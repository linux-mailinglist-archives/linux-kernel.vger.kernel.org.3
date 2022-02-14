Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102954B5914
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357242AbiBNRsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:48:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357218AbiBNRsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:48:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A213D24;
        Mon, 14 Feb 2022 09:48:07 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:48:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644860886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+bAjrM0dBctcVGZsZ6adrwCFL8Ov+Uon3r1Ix+A/dM=;
        b=JOFwp3lMy8xLfIc6f37xPD+gXFwivERVKDZDezgFwQuDMS96e19m8YCUF1KZAluN/Crwce
        LpCvxkqq0Ox3OKMsBZvUDb1JRYn1PgJ26HIDrjyN+RAzwPpo24+N0FReKUkVeiRYfhdY//
        wjD2HwPKwkTedMP0yRGuUcLzKei9NhcdSec6D+Fzm/JagRjficCPZFdMw6LBFtlmuQgjWO
        lo+1sZGvLUI/684v7xqX018wWzI52oDBJLsnLYpeqq6s0knM3SpGLP70Qyxnu4pBDDoYst
        xUVfVNQ7UINFIYK6XL1Z/zX6MV4i3z6+yqqY0fxtayLDhcU2/uOJOsMjum+XfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644860886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+bAjrM0dBctcVGZsZ6adrwCFL8Ov+Uon3r1Ix+A/dM=;
        b=/3n6f22YovnYoOgJhTXmVQRpGQsuhTNjP1W/eOw4SmwwGvM5yA4xKYkuljLREhPSzgOcsA
        x7mtHgVAQs8u5LAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 7/8] kernel/fork: Only cache the VMAP stack in
 finish_task_switch().
Message-ID: <YgqV1BLbCx5V+6tq@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
 <20220125152652.1963111-8-bigeasy@linutronix.de>
 <00f9c7a6-2d1d-f871-e9bc-00e2217f40f9@kernel.org>
 <YgpGnFlTS+2Ugfw4@linutronix.de>
 <YgpJ41q35k+KCsk4@linutronix.de>
 <YgqJV0LREU9IDJxl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgqJV0LREU9IDJxl@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-14 17:54:48 [+0100], To Andy Lutomirski wrote:
> index fcf0c180617c2..defe31036930a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4895,8 +4895,11 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  		if (prev->sched_class->task_dead)
>  			prev->sched_class->task_dead(prev);
>  
> -		/* Task is done with its stack. */
> -		put_task_stack(prev);
> +		/*
> +		 * Task is done with its stack. Try to cache VMAP stack and
> +		 * delay free it otherwise.
> +		 */
> +		put_task_stack_sched(prev);

Now that I write the commit message, there is probably nothing wrong
with unconditionally delaying it via RCU if caching failed. Then I don't
have to explain that there is one function is for the atomic context and
the other for non-atomic.

>  		put_task_struct_rcu_user(prev);
>  	}
> -- 
Sebastian
