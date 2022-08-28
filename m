Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3158E5A3ABB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 02:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiH1A4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 20:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiH1A4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 20:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58534D83E
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 17:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661648158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/aXd9q+Zc8DWwaDqektlrQ5X6iOwLmERxEPTmIKuNb8=;
        b=L07OwzE39bt1jitgKZO0m7PTg2m3By7JlYE3/HpOffG9zgjxsDSw4v7z0YJkgNr6qG4Urh
        34IxNaZTM1iNHIe9elfw0WyOXUFntMKlnH0o6y/wIR9ZKzJb4QQqWl+x/Cz0IZZl83Q4Ml
        Q5A6Mzacbs8RE/1IEZyZdxhT43Pwugc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-kYNRH9X8Pau8Ncm8C5akcw-1; Sat, 27 Aug 2022 20:55:55 -0400
X-MC-Unique: kYNRH9X8Pau8Ncm8C5akcw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C81A9800124;
        Sun, 28 Aug 2022 00:55:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBDCF492C3B;
        Sun, 28 Aug 2022 00:55:48 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        ardb@kernel.org, rppt@kernel.org, guanghuifeng@linux.alibaba.com,
        mark.rutland@arm.com, will@kernel.org, linux-mm@kvack.org,
        thunder.leizhen@huawei.com, wangkefeng.wang@huawei.com,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/2] arm64, kdump: enforce to take 4G as the crashkernel low memory end
Date:   Sun, 28 Aug 2022 08:55:43 +0800
Message-Id: <20220828005545.94389-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
=======
On arm64, block and section mapping is supported to build page tables.
However, currently it enforces to take base page mapping for the whole
linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
crashkernel kernel parameter is set. This will cause longer time of the
linear mapping process during bootup and severe performance degradation
during running time.

Root cause:
==========
On arm64, crashkernel reservation relies on knowing the upper limit of
low memory zone because it needs to reserve memory in the zone so that
devices' DMA addressing in kdump kernel can be satisfied. However, the
limit on arm64 is variant. And the upper limit can only be decided late
till bootmem_init() is called.

And we need to map the crashkernel region with base page granularity when
doing linear mapping, because kdump needs to protect the crashkernel region
via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
support well on splitting the built block or section mapping due to some
cpu reststriction [1]. And unfortunately, the linear mapping is done before
bootmem_init().

To resolve the above conflict on arm64, the compromise is enforcing to
take base page mapping for the entire linear mapping if crashkernel is
set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
performance is sacrificed.

Solution:
=========
To fix the problem, we should always take 4G as the crashkernel low
memory end in case CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled.
With this, we don't need to defer the crashkernel reservation till
bootmem_init() is called to set the arm64_dma_phys_limit. As long as
memblock init is done, we can conclude what is the upper limit of low
memory zone.

1) both CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled or memblock_start_of_DRAM() > 4G
  limit = PHYS_ADDR_MAX+1  (Corner cases)
2) CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are enabled:
   limit = 4G  (generic case)

Justification:
==============
In fact, kdump kernel doesn't need to cover all peripherals'
addressing bits. Only device taken as dump target need be taken care of
and its addressing bits need be satified. Currently, there are two kinds
of dumping, dumped to local storage disk or dumped through network card to
remove storage server. It means only storage disk or netowrk card taken
as dump target need be consider if their addressing bits are satisfied.
For saving memory, we usually generate kdump specific initramfs including
necessary kernel modules for dump target devices. All other unnecessary
kernel modules are excluded and their correspondent devices won't be
initialized during kdump kernel bootup.

So far, only Raspberry Pi 4 has some peripherals whcih can only address
30 bits memory range as reported in [2]. Devices on all other arm64 systems
can address 32bits memory range.

So by enforcing to take 4G as the crashkernel low memory end, the only
risk is if RPi4 owns storage disk or network card which can't address
32bits memory range because they could be set as dump target. Even if
RPi4 truly has storage devices or network card which can only address 30
bits memory range, it should be a corner case. We can document it since
crashkernel is more taken as a feature on server. Besides, RPi4 still can
use crashkernel=xM@yM to sepcify a location for 32bits addressing if it
really has that kind of storage device or network card and kdump is expected.

[1]
https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u

[2]
[PATCH v6 0/4] Raspberry Pi 4 DMA addressing support
https://lore.kernel.org/linux-arm-kernel/20190911182546.17094-1-nsaenzjulienne@suse.de/T/


======
Question to Nicolas:

Hi Nicolas,

In cover letter of [2] patchset, you told RPi4 has peripherals which
can only address 30bits range. In below sentence, do you mean "the PCIe,
V3D, GENET" can't address 32bit range, or they have wider view of
address space the same as 40-bit DMA channels? I am confused about that.

And the storage device or network card on RPi4 can address 32bit range
or 32bit range, do we have document or do you happen to know that?

"""
The new Raspberry Pi 4 has up to 4GB of memory but most peripherals can
only address the first GB: their DMA address range is
0xc0000000-0xfc000000 which is aliased to the first GB of physical
memory 0x00000000-0x3c000000. Note that only some peripherals have these
limitations: the PCIe, V3D, GENET, and 40-bit DMA channels have a wider
view of the address space by virtue of being hooked up trough a second
interconnect.
"""


Baoquan He (2):
  arm64, kdump: enforce to take 4G as the crashkernel low memory end
  arm64: remove unneed defer_reserve_crashkernel() and crash_mem_map

 arch/arm64/include/asm/memory.h |  5 ----
 arch/arm64/mm/init.c            | 24 ++++++++-------
 arch/arm64/mm/mmu.c             | 53 ++++++++++++++-------------------
 3 files changed, 36 insertions(+), 46 deletions(-)


base-commit: 10d4879f9ef01cc6190fafe4257d06f375bab92c
-- 
2.34.1

