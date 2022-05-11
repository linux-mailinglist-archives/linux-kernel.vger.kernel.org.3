Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9EF522A27
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiEKDCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiEKDCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:02:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB4A3097;
        Tue, 10 May 2022 20:02:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4EFCB81F90;
        Wed, 11 May 2022 03:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75002C385DB;
        Wed, 11 May 2022 03:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652238117;
        bh=QPnzEV/hU3bF1sWDP+kAHLY6P+PDt+NhZYA5qv46hwU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NGv59s0SQZVZgNt9te1Cg0zQS4qZ9h6p9j6IVLCpcyOzCRuVo1s8etaaYUipI26EZ
         DI4EsKZPhi3aiBx1nPcaK8JGLxPkicaCnMsHs+nQwZFNS3/YXkOcuBHBZocQs++HLR
         hdotKHazGmoSZ+wKjspnSeeQ/HzrDvENA5U0wSfiSiFRzvkx6TGKEGL5CX1zUH/6Ef
         BszCzQSpYSqIxicCnCEC23tU/ArcWpuV3OSzS1jw4mMbY7RG4J5fkyo1eTeHqJW+nf
         pc8OQTzEX4LIOMWMDO70vrcqI5pLAuops+kp96VR93/1L3188OVLa1v25OcC8Cz7fp
         M2Xbb0GyYLsUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0B3D75C0602; Tue, 10 May 2022 20:01:57 -0700 (PDT)
Date:   Tue, 10 May 2022 20:01:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: remove useless INIT_LIST_HEAD()
Message-ID: <20220511030157.GB1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1652237224-11656-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652237224-11656-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:47:04AM +0800, Haowen Bai wrote:
> list rcu_torture_freelist has been inited staticly through LIST_HEAD,
> so there's no need to call another INIT_LIST_HEAD. Simply remove
> it.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

For kernels with built-in rcutorture that starts automatically at
boot, you are quite correct.

But wouldn't there be trouble in the case where someone does a series of
"modprobe rcutorture" "rmmod rcutorture" commands?

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index faf6b4c7a757..0005e259c4ce 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -3247,7 +3247,6 @@ rcu_torture_init(void)
>  
>  	/* Set up the freelist. */
>  
> -	INIT_LIST_HEAD(&rcu_torture_freelist);
>  	for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++) {
>  		rcu_tortures[i].rtort_mbtest = 0;
>  		list_add_tail(&rcu_tortures[i].rtort_free,
> -- 
> 2.7.4
> 
