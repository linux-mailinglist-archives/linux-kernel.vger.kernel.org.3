Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CDD466157
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356913AbhLBKWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:22:31 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:48967 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240883AbhLBKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:22:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UzAdIBL_1638440313;
Received: from 30.240.95.24(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0UzAdIBL_1638440313)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Dec 2021 18:18:50 +0800
Message-ID: <18bf9b21-9926-d7c6-5827-4cf69732131c@linux.alibaba.com>
Date:   Thu, 2 Dec 2021 18:18:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Question: How to trigger RAM address when injecting memory error
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        graeme.gregory@linaro.org, will.deacon@arm.com,
        myron.stowe@redhat.com, len.brown@intel.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On our platform, firmware relies on kernel to trigger an injected error.
Specifically, it populates trigger_tab with the injected physical memory
address, which is set in param1. It is expected to map the RAM address and
run read action. And the execution path is as follows:

    __einj_error_trigger
        => apei_resources_request
            => apei_exec_pre_map_gars
                => apei_exec_run

If injecting at physical memory address, e.g. 0x92f033038, used by a
user space process, the following error will be reported in dmesg:

    ACPI: [Firmware Bug]: requested region covers kernel memory @ 0x000000092f033038

This is because the injected physical memory address is
EFI_CONVENTIONAL_MEMORY and memblock_is_map_memory is true
(arch/arm64/kernel/acpi.c).

        case EFI_CONVENTIONAL_MEMORY:
        case EFI_PERSISTENT_MEMORY:
            if (memblock_is_map_memory(phys) ||
                !memblock_is_region_memory(phys, size)) {
                pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
                return NULL;
            }

As a result, the error could not be triggered.

A normal workflow maps Generic Address Register (GAR) by acpi_os_ioremap
and add its virtual address into acpi_ioremaps. The execution path is as
follows:

    apei_exec_pre_map_gars
        => pre_map_gar_callback
            => apei_map_generic_address
                => acpi_os_map_generic_address
                    => acpi_os_map_iomem    /* add mapped VA into acpi_ioremaps */
                        =>    acpi_map
                            => acpi_os_ioremap /**/

Then, a read or write action is taken. It will check if the physical
address is mapped from acpi_ioremap. If yes, the value is read directly.
Otherwise, acpi_os_ioremap the physical address first. The execution path
is as follows:

    __apei_exec_run
        => apei_exec_read_register
            => apei_read
                => acpi_os_read_memory
                    => acpi_map_vaddr_lookup    /* lookup VA of PA from acpi_ioremap */
                    => acpi_os_ioremap

It works well for reserved memory, but not for our case.

Commit fdea163d8c17 ("ACPI, APEI, EINJ, Fix resource conflict on some
machine") removes the injecting memory address range which conflits with
regular memory from trigger table resources. It make sense when calling
apei_resources_request(). However, the actual mapping operation in
apei_exec_pre_map_gars() with trigger_ctx. And the conflit physical address
is still in trigger_ctx.

Commit ba242d5b1a84 ("ACPI, APEI: Add RAM mapping support to ACPI")add RAM
support with kmap. But after commit aafc65c731fe ("ACPI: add arm64 to the
platforms that use ioremap"), ioremap is used to map memory. However, the
ioremap implementation (arch/arm64/mm/ioremap.c) not allowed to map RAM at
all.

    /*
     * Don't allow RAM to be mapped.
     */
    if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
        return NULL;

A hacking way to address this issue is that map RAM memory with kmap
instead of apei_exec_pre_map_gars, and read it directly instead of
apei_exec_run.
-       rc = apei_exec_pre_map_gars(&trigger_ctx);
-       if (rc)
-               goto out_release;
+       volatile long *ptr;
+       long tmp;
+       unsigned long pfn;
+       pfn = param1 >> PAGE_SHIFT;

-       rc = apei_exec_run(&trigger_ctx, ACPI_EINJ_TRIGGER_ERROR);
+       ptr = kmap(pfn_to_page(pfn));
+       tmp = *(ptr + (param1 & ~ PAGE_MASK));

-       apei_exec_post_unmap_gars(&trigger_ctx);

I am wondering that should we use kmap to map RAM in acpi_map or add a
another path to address this issue? Any comment is welcomed.


