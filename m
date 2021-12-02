Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCEF465B3C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354947AbhLBAs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:48:28 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58712 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344514AbhLBArF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D97A2CE2142;
        Thu,  2 Dec 2021 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0C8C58323;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=H6iGr+5NaCUtqsPo+PjOMSuWeKaEvUsxZhFUGuls/5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBV8RDuLQxcindlYciRWcbBUw7/ESd+fkN/kImdGdfYMS2y1QclRsutKPSvxbuEov
         vplKIeFY6yvl4OXKDThibtK7MCIQilB+GNgNGUbhR3VHfqo83LyBaa88x6RKH3jYmD
         SR6heaklnbi7mx3kuQOpPAOnK90BXdwkM+/61hQWQq1GldbCkkbDz2fK6pnH8ZCJpT
         XG2Ewr2oDahZ35G44FBwL0d/mnT5uc01PIxfyvmGI6/ouY7xFYOtbBb5Ogk6lfy/62
         gu+/8p7Fd8Vf6ORoDEMTP1nPE9v9wb+2yHa5abCaSzaEFYGZSXNc3S3JoslJBBoz3U
         /Bzts099EmdBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 593B95C12AF; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Li Zhijian <zhijianx.li@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/17] rcuscale: Always log error message
Date:   Wed,  1 Dec 2021 16:43:29 -0800
Message-Id: <20211202004337.3130175-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhijian <zhijianx.li@intel.com>

Unconditionally log messages corresponding to errors.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 228f143bf935d..5e4f1f83d38e7 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -50,8 +50,8 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 	pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s)
 #define VERBOSE_SCALEOUT_STRING(s) \
 	do { if (verbose) pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s); } while (0)
-#define VERBOSE_SCALEOUT_ERRSTRING(s) \
-	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s); } while (0)
+#define SCALEOUT_ERRSTRING(s) \
+	pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s)
 
 /*
  * The intended use cases for the nreaders and nwriters module parameters
@@ -514,11 +514,11 @@ rcu_scale_cleanup(void)
 	 * during the mid-boot phase, so have to wait till the end.
 	 */
 	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
-		VERBOSE_SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
+		SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
 	if (rcu_gp_is_normal() && gp_exp)
-		VERBOSE_SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
+		SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
 	if (gp_exp && gp_async)
-		VERBOSE_SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
+		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
 
 	if (torture_cleanup_begin())
 		return;
@@ -845,7 +845,7 @@ rcu_scale_init(void)
 	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (reader_tasks == NULL) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
@@ -865,7 +865,7 @@ rcu_scale_init(void)
 		kcalloc(nrealwriters, sizeof(*writer_n_durations),
 			GFP_KERNEL);
 	if (!writer_tasks || !writer_durations || !writer_n_durations) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
-- 
2.31.1.189.g2e36527f23

