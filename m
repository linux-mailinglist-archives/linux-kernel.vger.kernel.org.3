Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B464D353E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiCIRTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiCIRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:18:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC52B16D7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:17:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DFBC60BAF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04E6C340E8;
        Wed,  9 Mar 2022 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646846229;
        bh=9UoUCC1ls/L9HENnvFoU5WNKJ/fU0gxSo20kTRh/kRg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FmF5HKGDibvFxUWXY4N37EIGfNe8mbKNpXcqZPhgeApuR2/ua64JyIFltkVdzu+H6
         DIKHFheeOvvRiYDHlbf/+POIDIN5HWsHi2HM/i5KAC2iPKjzbCoPqsLbkCRLycKy3D
         7HgWKLj77eak/Ysb19QnW3YNfNxivUz24rJQoGEQL5rt/0mkf7E4/q0uTOABsV0T9s
         tsByc/5BPFcNQ+GCcXnn/Weq8xrT0Lkq5I9jcCx834bjsUfyGDvuvLpJtmA4tfwQoM
         n2fh+jMxjiTxKkUNA+FzjvxepoiC0qnJ336qFpeGbXOi+TIehFk5Bzs/lTVQr96aaP
         tddo2bKxTU7SQ==
Message-ID: <23cbcd6a467c211f792ff54d50635cd6536c9dcc.camel@kernel.org>
Subject: Re: [PATCH 16/19] context_tracking: Convert state to atomic_t
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 09 Mar 2022 18:17:02 +0100
In-Reply-To: <20220302154810.42308-17-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
         <20220302154810.42308-17-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-02 at 16:48 +0100, Frederic Weisbecker wrote:
> Context tracking's state and dynticks counter are going to be merged
> in a single field so that both updates can happen atomically and at the
> same time. Prepare for that with converting the state into an atomic_t.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Cc: Yu Liao<liaoyu15@huawei.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
> Cc: Alex Belits <abelits@marvell.com>
> ---
>  static __always_inline bool context_tracking_in_user(void)
>  {
> -	return __this_cpu_read(context_tracking.state) == CONTEXT_USER;
> +	return __ct_state() == CONTEXT_USER;
>  }

I was wondering whether it'd make more sense to use ct_state() for extra safety
vs preemption, but it turns out the function isn't being used at all.

I figure it'd be better to remove it altogether and leave ct_state() as the
goto function for this sort of checks.

>  #else
>  static inline bool context_tracking_in_user(void) { return false; }
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index de247e758767..69db43548768 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -337,6 +337,7 @@ static __always_inline void context_tracking_recursion_exit(void)
>   */
>  void noinstr __ct_user_enter(enum ctx_state state)
>  {
> +	struct context_tracking *ct = this_cpu_ptr(&context_tracking);

I wonder if there is any value to having __ct_state() take 'struct
context_tracking *ct' as an argument to avoid a redundant this_cpu_ptr()...

>  	lockdep_assert_irqs_disabled();
>  
>  	/* Kernel threads aren't supposed to go to userspace */
> @@ -345,8 +346,8 @@ void noinstr __ct_user_enter(enum ctx_state state)
>  	if (!context_tracking_recursion_enter())
>  		return;
>  
> -	if ( __this_cpu_read(context_tracking.state) != state) {
> -		if (__this_cpu_read(context_tracking.active)) {
> +	if (__ct_state() != state) {

...here (and in __ct_user_exit()).

Regards,
Nicolas
