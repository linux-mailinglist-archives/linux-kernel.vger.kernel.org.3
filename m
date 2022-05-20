Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B652EA0C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348219AbiETKjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbiETKjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:39:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E51914D25
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:39:32 -0700 (PDT)
X-UUID: 0fc3d0681b8843af85197e923aaa4c03-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:eeff4b10-2339-4f06-9d8a-4050195bf023,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:20
X-CID-META: VersionHash:2a19b09,CLOUDID:795c027a-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 0fc3d0681b8843af85197e923aaa4c03-20220520
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 898076341; Fri, 20 May 2022 18:39:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 20 May 2022 18:39:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 20 May 2022 18:39:28 +0800
Message-ID: <95510f5fd4913f800d36052e573c56029b22b104.camel@mediatek.com>
Subject: Re: [PATCH] scs: Release kasan vmalloc poison in scs_free process
From:   Yee Lee <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
Date:   Fri, 20 May 2022 18:39:27 +0800
In-Reply-To: <20210923095316.13867-1-yee.lee@mediatek.com>
References: <20210923095316.13867-1-yee.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test
On Thu, 2021-09-23 at 17:53 +0800, yee.lee@mediatek.com wrote:
> From: Yee Lee <yee.lee@mediatek.com>
> 
> Since scs allocation has been moved to vmalloc region, the
> shadow stack is protected by kasan_posion_vmalloc.
> However, the vfree_atomic operation needs to access
> its context for scs_free process and causes kasan error
> as the dump info below.
> 
> This patch Adds kasan_unpoison_vmalloc() before vfree_atomic,
> which aligns to the prior flow as using kmem_cache.
> The vmalloc region will go back posioned in the following
> vumap() operations.
> 
>  ==================================================================
>  BUG: KASAN: vmalloc-out-of-bounds in llist_add_batch+0x60/0xd4
>  Write of size 8 at addr ffff8000100b9000 by task kthreadd/2
> 
>  CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.15.0-rc2-11681-(skip)
>  Hardware name: linux,dummy-virt (DT)
>  Call trace:
>   dump_backtrace+0x0/0x43c
>   show_stack+0x1c/0x2c
>   dump_stack_lvl+0x68/0x84
>   print_address_description+0x80/0x394
>   kasan_report+0x180/0x1dc
>   __asan_report_store8_noabort+0x48/0x58
>   llist_add_batch+0x60/0xd4
>   vfree_atomic+0x60/0xe0
>   scs_free+0x1dc/0x1fc
>   scs_release+0xa4/0xd4
>   free_task+0x30/0xe4
>   __put_task_struct+0x1ec/0x2e0
>   delayed_put_task_struct+0x5c/0xa0
>   rcu_do_batch+0x62c/0x8a0
>   rcu_core+0x60c/0xc14
>   rcu_core_si+0x14/0x24
>   __do_softirq+0x19c/0x68c
>   irq_exit+0x118/0x2dc
>   handle_domain_irq+0xcc/0x134
>   gic_handle_irq+0x7c/0x1bc
>   call_on_irq_stack+0x40/0x70
>   do_interrupt_handler+0x78/0x9c
>   el1_interrupt+0x34/0x60
>   el1h_64_irq_handler+0x1c/0x2c
>   el1h_64_irq+0x78/0x7c
>   _raw_spin_unlock_irqrestore+0x40/0xcc
>   sched_fork+0x4f0/0xb00
>   copy_process+0xacc/0x3648
>   kernel_clone+0x168/0x534
>   kernel_thread+0x13c/0x1b0
>   kthreadd+0x2bc/0x400
>   ret_from_fork+0x10/0x20
> 
>  Memory state around the buggy address:
>   ffff8000100b8f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>   ffff8000100b8f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  >ffff8000100b9000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>                     ^
>   ffff8000100b9080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>   ffff8000100b9100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  ==================================================================
> 
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> CC: Will Deacon <will@kernel.org>
> CC: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> ---
>  kernel/scs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/scs.c b/kernel/scs.c
> index e2a71fc82fa0..25c0d8e416e6 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -68,6 +68,7 @@ void scs_free(void *s)
>  
>  	__scs_account(s, -1);
>  
> +	kasan_unpoison_vmalloc(s, SCS_SIZE);
>  	/*
>  	 * We cannot sleep as this can be called in interrupt context,
>  	 * so use this_cpu_cmpxchg to update the cache, and
> vfree_atomic

