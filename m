Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1E5A7BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiHaK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiHaK5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:57:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DB7CAC8D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A39CB81FF5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA0AC433D6;
        Wed, 31 Aug 2022 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661943428;
        bh=AcZZZkQyVF2bDFbGmh47igrqNgqi57iGKTnF8zvHbU4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MxAnuY+pgMoeF8dV0+CH41J0Es90hVxbDQVvFZjaE2OSQr/LM+z/2zWzGr8uZGPZl
         1OgF7A8k1XXjkPKhsnCnzrQexnBBkJeZKsoFWHmExhfZK6XqkNH6s645UmqtAkUafk
         MpdJA3jgfJw29/E3MWmm22+e/siSvOoDANpZiw8xxJznlEsRQ3XK4I/6l3E+2LIhVD
         r7ZHSQ2KY4kjT6xKJf/q95nLtlZreeoE4qTJcRgborFCbt+0M84cjKPBcAVyOeujeU
         WpGqqnYZPHZKKaExSZGl8IR3NKXNNbOGKeD4mJGFGqmiAex2zzDUb675aS6xm6rOkO
         zgLb8IkWpfX3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DF6B05C05A0; Wed, 31 Aug 2022 03:57:07 -0700 (PDT)
Date:   Wed, 31 Aug 2022 03:57:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, qiang1.zhang@intel.com
Subject: Re: [rcutorture]  613b00fbe6:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog_cr[rcutorture]
Message-ID: <20220831105707.GJ6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YuqOqJnNzmEDKRIB@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuqOqJnNzmEDKRIB@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 11:05:12PM +0800, kernel test robot wrote:
> 
> (please be noted we reported this since clean on parent, ~10% on this commit,
> and found similar issue on latest maineline, e.g. v5.19)
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 613b00fbe64461f1c73e035e07c22cf3de65740b ("rcutorture: Add ability to limit callback-flood intensity")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: default
> 	torture_type: tasks-tracing
> 
> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

I believe that this commit in -rcu fixes this problem.  Could you please
check it?

							Thanx, Paul

------------------------------------------------------------------------

commit dba268ff32101559cd3e3800b24993ae5c59844c
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Sun Jul 31 18:53:56 2022 +0800

    rcutorture: Use the barrier operation specified by cur_ops
    
    The rcutorture_oom_notify() function unconditionally invokes
    rcu_barrier(), which is OK when the rcutorture.torture_type value is
    "rcu", but unhelpful otherwise.  The purpose of these barrier calls is to
    wait for all outstanding callback-flooding callbacks to be invoked before
    cleaning up their data.  Using the wrong barrier function therefore
    risks arbitrary memory corruption.  Thus, this commit changes these
    rcu_barrier() calls into cur_ops->cb_barrier() to make things work when
    torturing non-vanilla flavors of RCU.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7168dc8d61e98..bdd630f7a970c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2603,12 +2603,12 @@ static int rcutorture_oom_notify(struct notifier_block *self,
 	for (i = 0; i < fwd_progress; i++)
 		ncbs += rcu_torture_fwd_prog_cbfree(&rfp[i]);
 	pr_info("%s: Freed %lu RCU callbacks.\n", __func__, ncbs);
-	rcu_barrier();
+	cur_ops->cb_barrier();
 	ncbs = 0;
 	for (i = 0; i < fwd_progress; i++)
 		ncbs += rcu_torture_fwd_prog_cbfree(&rfp[i]);
 	pr_info("%s: Freed %lu RCU callbacks.\n", __func__, ncbs);
-	rcu_barrier();
+	cur_ops->cb_barrier();
 	ncbs = 0;
 	for (i = 0; i < fwd_progress; i++)
 		ncbs += rcu_torture_fwd_prog_cbfree(&rfp[i]);
