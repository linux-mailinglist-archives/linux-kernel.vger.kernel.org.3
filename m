Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6624D0EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbiCHFUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiCHFUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:20:17 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E940C38BFF;
        Mon,  7 Mar 2022 21:19:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V6cdc5s_1646716755;
Received: from 30.240.113.144(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V6cdc5s_1646716755)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 13:19:17 +0800
Message-ID: <8c40a492-9461-2b43-6ec9-06bfc7a0e77f@linux.alibaba.com>
Date:   Tue, 8 Mar 2022 13:19:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [BUG] kernel side can NOT trigger memory error with einj
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        graeme.gregory@linaro.org, will.deacon@arm.com,
        myron.stowe@redhat.com, len.brown@intel.com, ying.huang@intel.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

If we inject an memory error at physical memory address, e.g. 0x92f033038,
used by a user space process:

	echo 0x92f033038 > /sys/kernel/debug/apei/einj/param1
	echo 0xfffffffffffff000 > /sys/kernel/debug/apei/einj/param2
	echo 0x1 > /sys/kernel/debug/apei/einj/flags
	echo 0x8 > /sys/kernel/debug/apei/einj/error_type
	echo 1 > /sys/kernel/debug/apei/einj/error_inject

Then the following error will be reported in dmesg:

    ACPI: [Firmware Bug]: requested region covers kernel memory @ 0x000000092f033038

After digging into einj trigger interface, I think it's a kernel bug.

On our platform, firmware relies on kernel to trigger an injected error.
Specifically, it populates trigger_tab with the injected physical memory
address, which is set in param1. It is expected to map the RAM address and
run read action. And the execution path is as follows:

    __einj_error_trigger
        => apei_resources_request
            => apei_exec_pre_map_gars
                => apei_exec_run

The root cause is because:

1. Commit fdea163d8c17 ("ACPI, APEI, EINJ, Fix resource conflict on some
machine") removes the injecting memory address range which conflits with
regular memory from trigger table resources. It make sense when calling
apei_resources_request(). **However, the actual mapping operation in
apei_exec_pre_map_gars() with trigger_ctx. And the conflit physical address
is still in trigger_ctx.**

2. Then apei_exec_pre_map_gars() will finally call acpi_os_ioremap().
The injected physical memory address is EFI_CONVENTIONAL_MEMORY and
memblock_is_map_memory is true (arch/arm64/kernel/acpi.c) so that we see
the printed message.

        case EFI_CONVENTIONAL_MEMORY:
        case EFI_PERSISTENT_MEMORY:
            if (memblock_is_map_memory(phys) ||
                !memblock_is_region_memory(phys, size)) {
                pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
                return NULL;
            }

3. On the other hand, commit ba242d5b1a84 ("ACPI, APEI: Add RAM mapping support to ACPI")
add RAM support with kmap. But after commit aafc65c731fe ("ACPI: add arm64 to the
platforms that use ioremap"), ioremap is used to map memory. However, the
ioremap implementation (arch/arm64/mm/ioremap.c) not allowed to map RAM at
all.

    /*
     * Don't allow RAM to be mapped.
     */
    if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
        return NULL;

**As a result, the error could not be triggered, which is not expected if we want
to inject an error to a physical page used by process.**

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

It works well for reserved memory, but not for common case in which we want
to inject normal memory.


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

Best Regards,
Shuai
