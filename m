Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84B4AA4A9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378463AbiBDXxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:53:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45768 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348892AbiBDXxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64386B83976;
        Fri,  4 Feb 2022 23:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBB6C340F8;
        Fri,  4 Feb 2022 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018809;
        bh=APu/3aCknEcXKDub4KhH82mNQhHQnTLKFoAZJqOduhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfkC9LUybIqs2n0dPhwuQnRc26yt6r/p/apaszeMcH0pg6us27JpbULe1XBcHApTE
         azvpSnaP0wnwkN1GoQnLAU2CBy3pW2/aA5PKC8lqGKtCHEttE/pzY3X4cByS5QH61s
         RmDHW78RErt2BxgZItCM28DyjkKcqocZQ5NvneYFsKwrRFq0nYKWa5q8IoUw/tLY7q
         X++KW2KY2B2ifNeC3i7CmEt4a31UN/USnz7DKRUkOqTz30AK9yI//zc1UZB6FtFnRq
         yxL/nYmEJwE6+7MJvvvudzfpDAHj2KptLMgx7PfCD9lLNuurpr6l52dZstgWkD/JUR
         LFE2v8cXAipwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7EADC5C0A0A; Fri,  4 Feb 2022 15:53:29 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 6/8] rcutorture: Fix rcu_fwd_mutex deadlock
Date:   Fri,  4 Feb 2022 15:53:25 -0800
Message-Id: <20220204235327.2948-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_torture_fwd_cb_hist() function acquires rcu_fwd_mutex, but is
invoked from rcutorture_oom_notify() function, which hold this same
mutex across this call.  This commit fixes the resulting deadlock.

Reported-by: kernel test robot <oliver.sang@intel.com>
Tested-by: Oliver Sang <oliver.sang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index e99658efd97f4..1c8f40b90f70b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2180,7 +2180,6 @@ static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
 	for (i = ARRAY_SIZE(rfp->n_launders_hist) - 1; i > 0; i--)
 		if (rfp->n_launders_hist[i].n_launders > 0)
 			break;
-	mutex_lock(&rcu_fwd_mutex); // Serialize histograms.
 	pr_alert("%s: Callback-invocation histogram %d (duration %lu jiffies):",
 		 __func__, rfp->rcu_fwd_id, jiffies - rfp->rcu_fwd_startat);
 	gps_old = rfp->rcu_launder_gp_seq_start;
@@ -2193,7 +2192,6 @@ static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
 		gps_old = gps;
 	}
 	pr_cont("\n");
-	mutex_unlock(&rcu_fwd_mutex);
 }
 
 /* Callback function for continuous-flood RCU callbacks. */
@@ -2431,7 +2429,9 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 			 n_launders, n_launders_sa,
 			 n_max_gps, n_max_cbs, cver, gps);
 		atomic_long_add(n_max_cbs, &rcu_fwd_max_cbs);
+		mutex_lock(&rcu_fwd_mutex); // Serialize histograms.
 		rcu_torture_fwd_cb_hist(rfp);
+		mutex_unlock(&rcu_fwd_mutex);
 	}
 	schedule_timeout_uninterruptible(HZ); /* Let CBs drain. */
 	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
-- 
2.31.1.189.g2e36527f23

