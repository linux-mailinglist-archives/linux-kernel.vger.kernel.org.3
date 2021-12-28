Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEED480B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhL1QRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:17:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41298 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbhL1QRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:17:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DCAB6125A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7D8C36AEB;
        Tue, 28 Dec 2021 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640708269;
        bh=tUIoC2qnwliD2FmD5rtFXJ/M9laHCaNviF9N+iHFbXc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WgBlSe1kpOLVY/FEC60aSX56Dxd7UpVAI0CuAlPPpZs+wEJDuosEj4Gum3aBooUcJ
         aCY/ImEF3NEgC6x3+8HTubNQ1LdSm5Vx47uabrLFf8BDdQBSSetsbgx05FwicLOKCY
         IFv+gHkk7mVbC0T6LKhARX7H8SB7pZd5UuN5RnOu3fHuIgB510w8cYhonl/az5aNLJ
         BHlakFd8sukDV7LJ+0xE8IKs9lzUj6FeiOcgdIxcBhDwcV9G8xTgEQ1N1DqI+BCZvH
         AKlxJUdEzk+wzhidGSsuDoPEW/+bvnhDkt9ABxcnpeDKv7BPEuDzSyUp3XP+6exss9
         tPwayxlyZGSrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1FF6D5C100E; Tue, 28 Dec 2021 08:17:49 -0800 (PST)
Date:   Tue, 28 Dec 2021 08:17:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     elver@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu, kasan: Record work creation stack trace with
 interrupts enabled
Message-ID: <20211228161749.GW4109570@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211226005204.6909-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226005204.6909-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 08:52:04AM +0800, Zqiang wrote:
> Recording the work creation stack trace for KASAN reports in
> call_rcu() is expensive, due to unwinding the stack, but also
> due to acquiring depot_lock inside stackdepot (which may be contended).
> Because calling kasan_record_aux_stack_noalloc() does not require
> interrupts to already be disabled, this may unnecessarily extend
> the time with interrupts disabled.
> 
> Therefore, move calling kasan_record_aux_stack() before the section
> with interrupts disabled.
> 
> Acked-by: Marco Elver <elver@google.com>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Applied, thank you both!

							Thanx, Paul

> ---
>  v1->v2:
>  Make the submitted information clearer.
> 
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9b58bae0527a..36bd3f9e57b3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3068,8 +3068,8 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	}
>  	head->func = func;
>  	head->next = NULL;
> -	local_irq_save(flags);
>  	kasan_record_aux_stack_noalloc(head);
> +	local_irq_save(flags);
>  	rdp = this_cpu_ptr(&rcu_data);
>  
>  	/* Add the callback to our list. */
> -- 
> 2.25.1
> 
