Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AC756C2A3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbiGHUeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbiGHUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:33:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EE0F9CE17
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:33:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF3601063;
        Fri,  8 Jul 2022 13:33:09 -0700 (PDT)
Received: from [10.57.86.102] (unknown [10.57.86.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CF9F3F70D;
        Fri,  8 Jul 2022 13:33:08 -0700 (PDT)
Message-ID: <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
Date:   Fri, 8 Jul 2022 21:32:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Content-Language: en-GB
To:     Ben Dooks <ben.dooks@sifive.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, iommu@lists.linux-foundation.org
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220708170811.270589-1-ben.dooks@sifive.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220708170811.270589-1-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-08 18:08, Ben Dooks wrote:
> If the io_tlb_default_mem is used by a device that then gets used
> by the swiotlb code, the spinlock warning is triggered causing a
> lot of stack-trace.

Hang on, how have we got as far as trying to allocate out of an 
uninitialised SWIOTLB at all? That seems like either something's gone 
more fundamentally wrong or we're missing a proper check somewhere. I 
don't think papering over it like this is right.

Thanks,
Robin.

> Fix this by making the structure's lock initialised at build time.
> 
> Avoids the following BUG trigger:
> 
> [    3.046401] BUG: spinlock bad magic on CPU#3, kworker/u8:0/7
> [    3.046689]  lock: io_tlb_default_mem+0x30/0x60, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    3.047217] CPU: 3 PID: 7 Comm: kworker/u8:0 Not tainted 5.17.0-00056-g1e9bac738084-dirty #310
> [    3.048363] Workqueue: events_unbound deferred_probe_work_func
> [    3.048892] Call Trace:
> [    3.049224] [<ffffffff800048aa>] dump_backtrace+0x1c/0x24
> [    3.049576] [<ffffffff805c5f74>] show_stack+0x2c/0x38
> [    3.049898] [<ffffffff805cade2>] dump_stack_lvl+0x40/0x58
> [    3.050216] [<ffffffff805cae0e>] dump_stack+0x14/0x1c
> [    3.050460] [<ffffffff805c69f6>] spin_dump+0x62/0x6e
> [    3.050681] [<ffffffff8004e000>] do_raw_spin_lock+0xb0/0xd0
> [    3.050934] [<ffffffff805d5b58>] _raw_spin_lock_irqsave+0x20/0x2c
> [    3.051157] [<ffffffff80067e38>] swiotlb_tbl_map_single+0xce/0x3da
> [    3.051372] [<ffffffff80068320>] swiotlb_map+0x3a/0x15c
> [    3.051668] [<ffffffff80065a56>] dma_map_page_attrs+0x76/0x162
> [    3.051975] [<ffffffff8031d542>] dw_pcie_host_init+0x326/0x3f2
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>   kernel/dma/swiotlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index cb50f8d38360..a707a944c39a 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -65,7 +65,7 @@
>   static bool swiotlb_force_bounce;
>   static bool swiotlb_force_disable;
>   
> -struct io_tlb_mem io_tlb_default_mem;
> +struct io_tlb_mem io_tlb_default_mem = { .lock = __SPIN_LOCK_UNLOCKED(io_tlb_default_mem.lock) } ;
>   
>   phys_addr_t swiotlb_unencrypted_base;
>   
