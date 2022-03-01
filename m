Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1844C8A15
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiCAK4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiCAK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:56:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60F4D8BF14;
        Tue,  1 Mar 2022 02:56:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F7FBED1;
        Tue,  1 Mar 2022 02:56:13 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 701873F73D;
        Tue,  1 Mar 2022 02:56:10 -0800 (PST)
Message-ID: <4e4bb61a-377e-1ec9-5998-214055ef0a78@arm.com>
Date:   Tue, 1 Mar 2022 10:56:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 0/7] arm64: Default to 32-bit wide ZONE_DMA
Content-Language: en-GB
To:     Matt Flax <flatmax@gmail.com>, nsaenzjulienne@suse.de
Cc:     ardb@kernel.org, catalin.marinas@arm.com,
        devicetree@vger.kernel.org, guohanjun@huawei.com, hch@lst.de,
        iommu@lists.linux-foundation.org, jeremy.linton@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, will@kernel.org,
        Matt Flax <flatmax@flatmax.com>
References: <20201119175400.9995-1-nsaenzjulienne@suse.de>
 <20220301030031.4025282-1-flatmax@flatmax.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220301030031.4025282-1-flatmax@flatmax.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 2022-03-01 03:00, Matt Flax wrote:
> Hi All,
> 
> It seems that the ZONE_DMA changes have broken the operation of Rochip rk3399 chipsets from v5.10.22 onwards.
> 
> It isn't clear what needs to be changed to get any of these boards up and running again. Any pointers on how/what to change ?

Your firmware/bootloader setup is mismatched. If you're using the 
downstream Rockchip blob for BL31, you need to reserve or remove the 
memory range 0x8400000-0x9600000 to match the behaviour of the original 
Android BSP U-Boot. The downstream firmware firewalls this memory off 
for the Secure world such that any attempt to touch it from Linux 
results in a fatal SError fault as below. Any apparent correlation with 
the ZONE_DMA changes will simply be because they've affected the 
behaviour of the page allocator, such that it's more likely to reach 
into the affected range of memory.

Cheers,
Robin.

> An easy test for debugging is to run stress :
> 
> stress --cpu 4 --io 4 --vm 2 --vm-bytes 128M
> 
> stress: info: [255] dispatching hogs: 4 cpu, 4 io, 2 vm, 0 hdd
> [    8.070280] SError Interrupt on CPU4, code 0xbf000000 -- SError
> [    8.070286] CPU: 4 PID: 261 Comm: stress Not tainted 5.10.21 #1
> [    8.070289] Hardware name: FriendlyElec NanoPi M4 (DT)
> [    8.070293] pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
> [    8.070296] pc : clear_page+0x14/0x28
> [    8.070298] lr : clear_subpage+0x50/0x90
> [    8.070302] sp : ffff800012abbc40
> [    8.070305] x29: ffff800012abbc40 x28: ffff000000f68000
> [    8.070313] x27: 0000000000000000 x26: ffff000001f38e40
> [    8.070320] x25: ffff8000114fd000 x24: 0000000000000000
> [    8.070326] x23: 0000000000000000 x22: 0000000000001000
> [    8.070334] x21: 0000ffffa7e00000 x20: fffffe0000010000
> [    8.070341] x19: ffff000000f68000 x18: 0000000000000000
> [    8.070348] x17: 0000000000000000 x16: 0000000000000000
> [    8.070354] x15: 0000000000000002 x14: 0000000000000001
> [    8.070361] x13: 0000000000075879 x12: 00000000000000c0
> [    8.070368] x11: ffff80006c46a000 x10: 0000000000000200
> [    8.070374] x9 : 0000000000000000 x8 : 0000000000000010
> [    8.070381] x7 : ffff00007db800a0 x6 : ffff800011b899c0
> [    8.070387] x5 : 0000000000000000 x4 : ffff00007db800f7
> [    8.070394] x3 : 0000020000200000 x2 : 0000000000000004
> [    8.070401] x1 : 0000000000000040 x0 : ffff0000085ff4c0
> [    8.070409] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    8.070412] CPU: 4 PID: 261 Comm: stress Not tainted 5.10.21 #1
> [    8.070415] Hardware name: FriendlyElec NanoPi M4 (DT)
> [    8.070418] Call trace:
> [    8.070420]  dump_backtrace+0x0/0x1b0
> [    8.070423]  show_stack+0x18/0x70
> [    8.070425]  dump_stack+0xd0/0x12c
> [    8.070428]  panic+0x16c/0x334
> [    8.070430]  nmi_panic+0x8c/0x90
> [    8.070433]  arm64_serror_panic+0x78/0x84
> [    8.070435]  do_serror+0x64/0x70
> [    8.070437]  el1_error+0x88/0x108
> [    8.070440]  clear_page+0x14/0x28
> [    8.070443]  clear_huge_page+0x74/0x210
> [    8.070445]  do_huge_pmd_anonymous_page+0x1b0/0x7c0
> [    8.070448]  handle_mm_fault+0xdac/0x1290
> [    8.070451]  do_page_fault+0x130/0x3a0
> [    8.070453]  do_translation_fault+0xb0/0xc0
> [    8.070456]  do_mem_abort+0x44/0xb0
> [    8.070458]  el0_da+0x28/0x40
> [    8.070461]  el0_sync_handler+0x168/0x1b0
> [    8.070464]  el0_sync+0x174/0x180
> [    8.070508] SError Interrupt on CPU0, code 0xbf000000 -- SError
> [    8.070511] CPU: 0 PID: 258 Comm: stress Not tainted 5.10.21 #1
> [    8.070515] Hardware name: FriendlyElec NanoPi M4 (DT)
> [    8.070518] pstate: 80000000 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> [    8.070520] pc : 0000aaaacec22e98
> [    8.070523] lr : 0000aaaacec22d84
> [    8.070525] sp : 0000ffffe67a8620
> [    8.070528] x29: 0000ffffe67a8620 x28: 0000000000000003
> [    8.070534] x27: 0000aaaacec34000 x26: 0000ffffaeb42610
> [    8.070541] x25: 0000ffffa69af010 x24: 0000aaaacec23a98
> [    8.070547] x23: 0000aaaacec35010 x22: 0000aaaacec35000
> [    8.070554] x21: 0000000000001000 x20: ffffffffffffffff
> [    8.070560] x19: 0000000008000000 x18: 0000000000000000
> [    8.070567] x17: 0000000000000000 x16: 0000000000000000
> [    8.070573] x15: 0000000000000000 x14: 0000000000000000
> [    8.070580] x13: 0000000000008000 x12: 0000000000000000
> [    8.070587] x11: 0000000000000020 x10: 0000000000000030
> [    8.070593] x9 : 000000000000000a x8 : 00000000000000de
> [    8.070599] x7 : 0000000000200000 x6 : 000000000000021b
> [    8.070606] x5 : 0000000000000000 x4 : ffffffffffffffff
> [    8.070613] x3 : 0000000000000000 x2 : 0000ffffaeb47000
> [    8.070619] x1 : 000000000000005a x0 : 0000000000a58000
> [    8.070629] SMP: stopping secondary CPUs
> [    8.070632] Kernel Offset: disabled
> [    8.070634] CPU features: 0x0240022,6100600c
> [    8.070637] Memory Limit: none
> 
> 
