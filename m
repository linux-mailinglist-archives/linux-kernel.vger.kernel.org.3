Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF494A996F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245143AbiBDMgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243157AbiBDMgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:36:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BADC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 04:36:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C226B836A1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF2AC004E1;
        Fri,  4 Feb 2022 12:36:26 +0000 (UTC)
Date:   Fri, 4 Feb 2022 12:36:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     h00486469 <hewenliang4@huawei.com>
Cc:     will@kernel.org, Punit Agrawal <punitagrawal@gmail.com>,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        hejingxian@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: fix slab-out-of-bounds in emulation_proc_handler
 when accessing concurrently
Message-ID: <Yf0dxon1d07rzxZH@arm.com>
References: <20220128090324.2727688-1-hewenliang4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128090324.2727688-1-hewenliang4@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I corrected Punit's email address. Also please cc
linux-arm-kernel@lists.infradead.org in the future (you can use
scripts/get_maintainer.pl to give you a hint on who to cc).

On Fri, Jan 28, 2022 at 05:03:24PM +0800, h00486469 wrote:
> From: hewenliang <hewenliang4@huawei.com>
> 
> SAN reports an issue of slab-out-of-bounds in emulation_proc_handler
> when we try to read/write the interfaces in /proc/sys/abi concurrently.
> So we need to add emulation_proc_lock to protect table->data and insn
> from data corruption in emulation_proc_handler.
> 
> The stack is follows:
> Call trace:
>  dump_backtrace+0x0/0x310
>  show_stack+0x28/0x38
>  dump_stack+0xec/0x15c
>  print_address_description+0x68/0x2d0
>  kasan_report+0x130/0x2f0
>  __asan_load4+0x88/0xb0
>  emulation_proc_handler+0x58/0x158
>  proc_sys_call_handler+0x1dc/0x228
>  proc_sys_read+0x44/0x58
>  __vfs_read+0xe0/0x320
>  vfs_read+0xbc/0x1c0
>  __arm64_sys_read+0x50/0x60
>  el0_svc_common+0xc8/0x2b8
>  el0_svc_handler+0xf8/0x160
>  el0_svc+0x10/0x218
> 
> Allocated by task 1:
>  kasan_kmalloc+0xe0/0x190
>  kmem_cache_alloc_trace+0x18c/0x418
>  register_insn_emulation+0x4c/0x2b0
>  armv8_deprecated_init+0x40/0x108
>  do_one_initcall+0xb4/0x508
>  kernel_init_freeable+0x7d0/0x8e0
>  kernel_init+0x20/0x1a8
>  ret_from_fork+0x10/0x18
> 
> Mmeory state around the buggy address:
> >ffff8026dacf0b00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> 
> Fixes: 587064b610c7 ("arm64: Add framework for legacy instruction emulation")
> Signed-off-by: hewenliang <hewenliang4@huawei.com>
> Signed-off-by: hejingxian <hejingxian@huawei.com>
> Signed-off-by: fulin <fulin@huawei.com>
> ---
>  arch/arm64/kernel/armv8_deprecated.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index 6875a16b09d2..d2ac483b0dd8 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -59,6 +59,7 @@ struct insn_emulation {
>  static LIST_HEAD(insn_emulation);
>  static int nr_insn_emulated __initdata;
>  static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
> +static DEFINE_MUTEX(emulation_proc_lock);
>  
>  static void register_emulation_hooks(struct insn_emulation_ops *ops)
>  {
> @@ -207,9 +208,12 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
>  				  loff_t *ppos)
>  {
>  	int ret = 0;
> -	struct insn_emulation *insn = (struct insn_emulation *) table->data;
> -	enum insn_emulation_mode prev_mode = insn->current_mode;
> +	struct insn_emulation *insn;
> +	enum insn_emulation_mode prev_mode;
>  
> +	mutex_lock(&emulation_proc_lock);
> +	insn = (struct insn_emulation *) table->data;
> +	prev_mode = insn->current_mode;
>  	table->data = &insn->current_mode;
>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);

It looks like we update table->data to something that's not the original
insn pointer just to be able to call proc_dointvec_minmax(). On a
concurrent call, we'd get the wrong pointer hence the ASAN warning. I'd
rather keep the table->data as &insn->current_mode and use
container_of() to retrieve the insn pointer. We probably still need a
mutex to protect against the current_mode update and the registration of
the emulation hooks but not for retrieving insn as table->data is no
longer changing.

>  
> @@ -224,6 +228,7 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
>  	}
>  ret:
>  	table->data = insn;
> +	mutex_unlock(&emulation_proc_lock);
>  	return ret;
>  }
>  
> -- 
> 2.27.0

-- 
Catalin
