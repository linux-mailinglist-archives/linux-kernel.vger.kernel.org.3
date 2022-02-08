Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D44AE684
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiBICjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiBHXE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:04:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41695C061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:04:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4F856177A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A5AC004E1;
        Tue,  8 Feb 2022 23:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644361498;
        bh=EWe+0R/ZVsm3W7XmSmNv2KN70VcPiLPtwrmHpmDlzu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTnv+2dK+6rYrMI0nFMsYl3iOw/V23R9x1TPnCSsewDe0UKYledTtwmnIFcsw6iTh
         AYc6XJ7tK2ZwKO6vz7aEvlhxkxWTzrW4q2BubAqrU3n8Jo/2+RwrlnUpWilhbU4r1B
         7FPmI1ya7W2VmtxkeBQO+c8qNdO4phap3WwX6MjJmsPUBtanuitQkAiLJf6jQtB+ly
         f8bxt2SWTZ/AnQaB/vYZ8yZms1ACQDGLE87P5qduIN3tVbITkNxNRbvjYHLetvF6XS
         uM2BJwR1WTbGH4ngZcVANvrij8Jg8HxS2G160oR9Z3U+7lD9CfleE6tJkILgvrPkpR
         DuJD86MOgXhfg==
Date:   Wed, 9 Feb 2022 00:04:55 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, paulmck@kernel.org, will@kernel.org,
        dave@stgolabs.net
Subject: Re: [PATCH] softirq: Remove raise_softirq from
 tasklet_action_common()
Message-ID: <20220208230455.GA539926@lothringen>
References: <1644066805-17212-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644066805-17212-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 06:43:25PM +0530, Mukesh Ojha wrote:
> Think about a scenario when all other cores are in suspend
> and one core is only running ksoftirqd and it is because
> some client has invoked tasklet_hi_schedule() only once
> during that phase.
> 
> tasklet_action_common() handles that softirq and marks the
> same softirq as pending again. And due to that core keeps
> running the softirq handler [1] forever and it is not able to
> go to suspend.
> 
> We can get rid of raising softirq from tasklet handler.
> 
> [1]
> <idle>-0    [003]   13058.769081:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13058.769085: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13058.769087:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13058.769091:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13058.769094: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13058.769097:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13058.769100:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13058.769103: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13058.769106:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13058.769109:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058923:  softirq_entry   vec=0  action=HI_SOFTIRQ
> ...
> ..
> ..
> ..
> 
> <idle>-0    [003]   13059.058951:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.058954: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.058957:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058960:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.058963: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.058966:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058969:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.058972: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.058975:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058978:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.058981: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.058984:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058987:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.058990: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.058993:  softirq_exit   vec=0  action=HI_SOFTIRQ
> <idle>-0    [003]   13059.058996:  softirq_entry   vec=0  action=HI_SOFTIRQ
> <idle>-0     [003]  13059.059000: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
> <idle>-0    [003]   13059.059002:  softirq_exit   vec=0  action=HI_SOFTIRQ
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  kernel/softirq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 41f4709..d3e6fb9 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -795,7 +795,6 @@ static void tasklet_action_common(struct softirq_action *a,
>  		t->next = NULL;
>  		*tl_head->tail = t;
>  		tl_head->tail = &t->next;
> -		__raise_softirq_irqoff(softirq_nr);
>  		local_irq_enable();

That requeue happens when the tasklet is already executing on some other CPU
or when it has been disabled through tasklet_disable().

So you can't just remove that line or you'll break everything.

It would be nice to identify which tasklet keeps being requeued. Is it because
something called tasklet_disable() to it and never called back tasklet_enable() ?

Thanks.
