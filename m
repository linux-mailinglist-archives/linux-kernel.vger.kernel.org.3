Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FA0587444
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiHAXKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiHAXKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E014E19029;
        Mon,  1 Aug 2022 16:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE00760DE0;
        Mon,  1 Aug 2022 23:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5A9C433C1;
        Mon,  1 Aug 2022 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659395430;
        bh=c68rvvKS7OQgl7DSiVXP6nOIRR0u1tOQMrT4+jA51fE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y+i7h8rHt7TGpHAWfVjqvgbK+2WMmD82Hc7mAxOb0aI49VvxXJ/OHEqKkz5251s9d
         Qks06Ig1tubt+kmUzInNt9UInoy9zGAM+fDDRZ5dFgn3lhFXQ90VsKf96o8MjuaFXr
         SuLWtOh1NoJRw+S9jZYLDGyBTnL5JYZC2q3CkC8j0psP63MYikDjgXumwt7XA7VXNN
         YF618/qertaCAdhOtxSVbba7X7TcEjG7xN2/Gpz1aZNoZRJ6aIh0GFvVnJ1+T26udB
         A+uxXIu7tba7WAPZd7gCzSxgq6vFUuENDVsv7GmBoXTfALO4/fwvAMuRvXEPUIz3+n
         qgUgIcPqLSwbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A403B5C0D2B; Mon,  1 Aug 2022 16:10:29 -0700 (PDT)
Date:   Mon, 1 Aug 2022 16:10:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Use the barrier operation corresponding to
 rcutorture.torture_type
Message-ID: <20220801231029.GB2860372@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220731105356.1741086-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731105356.1741086-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 06:53:56PM +0800, Zqiang wrote:
> when the rcutorture.torture_type value is 'rcu', this is correct for
> invoke rcu_barrier() to wait all in-flight call_rcu() callbacks
> (rcu_torture_fwd_cb_cr()) complete in rcutorture_oom_notify(). but when
> the rcutorture.torture_type value is 'tasks-tracing', invoke rcu_barrier()
> won't wait all in-flight call_rcu_tasks_trace() callbacks complete, the
> rcu_barrier_tasks_trace() should be invoked.
> 
> This commit fix it by using barrier operation corresponding to
> rcutorture.torture_type to wait all in-flight rcu_torture_fwd_cb_cr()
> complete.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch, thank you!

I have done my usual wordsmithing as shown below.  Could you please
double-check it?

							Thanx, Paul

------------------------------------------------------------------------

commit f8c9027f9c81be92344996a51babaa5a23bd88db
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
index 7f13f2e5ed62f..7e7d54841613c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2638,12 +2638,12 @@ static int rcutorture_oom_notify(struct notifier_block *self,
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
