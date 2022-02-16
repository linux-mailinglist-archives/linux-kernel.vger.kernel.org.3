Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374E74B9331
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 22:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiBPVa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 16:30:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiBPVav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 16:30:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAAB269A95
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 13:30:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9AEEB81FC5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FCCC004E1;
        Wed, 16 Feb 2022 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645047035;
        bh=OpEGQnFFecbZspQRi+quq6myphBMlI9nD/dHwvJIyME=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uCJeFcEQYmxDuTrwAN9qnVUzRjNp4p3ndQIKVJXrzGpAHHSdy5KF9tFNjEe4IKGLs
         qG8RDxcU0UVQsXtcMf/NL3cGSzuVv27bMI/oIe+AZp6bWTgAQBF0EfpFqsLALQq9rv
         lmFJCXLMoep5cKDOx9aogxmtCvMWZGx1JCz/srm8/dsgloibTjmBJU5aaUg64SrW66
         JvygsgvdojZ28ua0OXVyWMSaPdjFBAHWJTyFlOZ0/yYwgmPY3XJiTawV7JCQ2lTmCS
         JDWl6eQmv7NQGfdC2EWGV/yfSY904AAvOiZps2ugt1QRq3UF6zAhQXfBTm1vHUUoZk
         Zt/gP+dClYtWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 495A15C064D; Wed, 16 Feb 2022 13:30:35 -0800 (PST)
Date:   Wed, 16 Feb 2022 13:30:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/5] rcu/nocb: Move rcu_nocb_is_setup to rcu_state
Message-ID: <20220216213035.GA2442742@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220216154208.696069-1-frederic@kernel.org>
 <20220216154208.696069-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216154208.696069-3-frederic@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 04:42:05PM +0100, Frederic Weisbecker wrote:
> In order to avoid scattering the global RCU states, move the RCU nocb
> initialization witness within rcu_state.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Build testing for CONFIG_NO_HZ_FULL=n kernels suggested the following
patch be merged into this one.  Or does this variable need to be used
somewhere?  Either way, please let me know!

							Thanx, Paul

------------------------------------------------------------------------

commit 1a4f308b3b3841ef10043fe6c3dd12fc872b0400
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Feb 16 13:27:42 2022 -0800

    squash! rcu/nocb: Move rcu_nocb_is_setup to rcu_state
    
    [ paulmck: Remove unused need_rcu_nocb_mask local variable. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 9d6d4786bc703..9d97aa1f4d6ce 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1154,14 +1154,8 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-	bool need_rcu_nocb_mask = false;
 	struct rcu_data *rdp;
 
-#if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
-		need_rcu_nocb_mask = true;
-#endif /* #if defined(CONFIG_NO_HZ_FULL) */
-
 	if (rcu_state.nocb_is_setup) {
 		if (!cpumask_available(rcu_nocb_mask)) {
 			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
