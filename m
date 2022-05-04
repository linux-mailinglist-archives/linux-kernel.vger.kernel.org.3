Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92908519572
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343806AbiEDCZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiEDCZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:25:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B3122BDD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 19:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34333619DD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56B7C385A4;
        Wed,  4 May 2022 02:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651630903;
        bh=fcTqXzojK4WmUgceBGkv/oGAZ7gI7I5rRw7o4nQVbGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ojzA6aF0kfY1cUuum9CUbSCbM9+l4RhJ8rV5UXJnu7Mr2OEVH7qbx6sX5ml6CTL9a
         AoaQVg4nFBa4gCSepjH8uClbLuHAdgykwVF54AY/hL3TASIvtecRA+7EaX/kTM/hHv
         5qt7BXRZFSLaute/jXivH+Gno1McJ05QZnTgCdzfCuLooRHW0f1oSgYxaMzsb2a6gv
         gdf0mwycPUxH6ZIpHuPEG65PrJxk5Y4The64wvEcYRV9TutNwwvW0/1SftGf/0jVN5
         Yro7K5EUUwtl6Kl6Qb/dKFZJBI6eY9BlV4Sc5FN0wo/2m/zrilgV7nlVMse8yWG/MX
         thvcHtXZV1TSQ==
Date:   Wed, 4 May 2022 11:21:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] kprobes: fix build with CONFIG_KRETPROBES=n
Message-Id: <20220504112139.a4b9e0bbeb697fb0980864c6@kernel.org>
In-Reply-To: <20220502184050.1792743-1-jcmvbkbc@gmail.com>
References: <20220502184050.1792743-1-jcmvbkbc@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Max,

Thank you for reporting this issue and making a patch.
However, it looks those functions (free_rp_inst_rcu(), recycle_rp_inst(), 
kprobe_flush_task() and free_rp_inst()) should be moved into the
CONFIG_KRETPROBES=y area simply because all of those are needed for
kretprobes.
Let me fix that.

Thank you,

On Mon,  2 May 2022 11:40:50 -0700
Max Filippov <jcmvbkbc@gmail.com> wrote:

> When building kernel with CONFIG_KRETPROBES=n kernel/kprobes.c
> compilation fails with the following messages:
> 
>   kernel/kprobes.c: In function ‘recycle_rp_inst’:
>   kernel/kprobes.c:1273:32: error: implicit declaration of function
>                                    ‘get_kretprobe’
> 
>   kernel/kprobes.c: In function ‘kprobe_flush_task’:
>   kernel/kprobes.c:1299:35: error: ‘struct task_struct’ has no member
>                                    named ‘kretprobe_instances’
> 
> Make references to kretprobe-specific structures and functions
> conditional.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  kernel/kprobes.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index dd58c0be9ce2..95ce4d16e63e 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1258,6 +1258,7 @@ void kprobe_busy_end(void)
>  }
>  
>  #if !defined(CONFIG_KRETPROBE_ON_RETHOOK)
> +#ifdef CONFIG_KRETPROBES
>  static void free_rp_inst_rcu(struct rcu_head *head)
>  {
>  	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
> @@ -1279,21 +1280,11 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
>  }
>  NOKPROBE_SYMBOL(recycle_rp_inst);
>  
> -/*
> - * This function is called from delayed_put_task_struct() when a task is
> - * dead and cleaned up to recycle any kretprobe instances associated with
> - * this task. These left over instances represent probed functions that
> - * have been called but will never return.
> - */
> -void kprobe_flush_task(struct task_struct *tk)
> +static void kretprobe_flush_task(struct task_struct *tk)
>  {
>  	struct kretprobe_instance *ri;
>  	struct llist_node *node;
>  
> -	/* Early boot, not yet initialized. */
> -	if (unlikely(!kprobes_initialized))
> -		return;
> -
>  	kprobe_busy_begin();
>  
>  	node = __llist_del_all(&tk->kretprobe_instances);
> @@ -1306,6 +1297,25 @@ void kprobe_flush_task(struct task_struct *tk)
>  
>  	kprobe_busy_end();
>  }
> +NOKPROBE_SYMBOL(kretprobe_flush_task);
> +#endif
> +
> +/*
> + * This function is called from delayed_put_task_struct() when a task is
> + * dead and cleaned up to recycle any kretprobe instances associated with
> + * this task. These left over instances represent probed functions that
> + * have been called but will never return.
> + */
> +void kprobe_flush_task(struct task_struct *tk)
> +{
> +	/* Early boot, not yet initialized. */
> +	if (unlikely(!kprobes_initialized))
> +		return;
> +
> +#ifdef CONFIG_KRETPROBES
> +	kretprobe_flush_task(tk);
> +#endif
> +}
>  NOKPROBE_SYMBOL(kprobe_flush_task);
>  
>  static inline void free_rp_inst(struct kretprobe *rp)
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
