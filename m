Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E614465B3E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344649AbhLBAsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354714AbhLBArF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E237C061574;
        Wed,  1 Dec 2021 16:43:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE565CE2144;
        Thu,  2 Dec 2021 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF652C5831C;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=eCkpJNKUZfbEDR24zCrJIaryfdNqV7jgxV8FdSPXU98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vzsw6XcsvDqmIq6jwJiPcJ/vGzBjHp9GEfDhEGJTTgDL0++NSlEmLQ5mK6nwWb1fD
         2Q7oNVVznESivHkHJFnWGi0dyqtUg41joPoKZcNxci/STDvsd3zDGOFkKjwDq5ix4e
         VYfLGfYAykdhSore2rdLJ4kTGI1YkrqsHBwUjL6YNtOpVUH3Wp4Rc5vFhbGBcK1lRX
         tUKRQ41KUKApDwonGqHMXveXKkWhyroRfFNvXCR0ywT08wFsApuM0hZpqa4OupiQaC
         Az0f8sP9VILf3sd1Xh+r4gUvAAVlZkCtjhmg8Vw+MO8vnq/eSKv/RFiwmeEomSpuOq
         E7CBehQoSmCww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5AFCB5C12B3; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
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
Subject: [PATCH rcu 11/17] scftorture: Always log error message
Date:   Wed,  1 Dec 2021 16:43:30 -0800
Message-Id: <20211202004337.3130175-11-paulmck@kernel.org>
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
 kernel/scftorture.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index a0df767897a1d..dcb0410950e45 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -41,8 +41,7 @@
 #define VERBOSE_SCFTORTOUT(s, x...) \
 	do { if (verbose) pr_alert(SCFTORT_FLAG s "\n", ## x); } while (0)
 
-#define VERBOSE_SCFTORTOUT_ERRSTRING(s, x...) \
-	do { if (verbose) pr_alert(SCFTORT_FLAG "!!! " s "\n", ## x); } while (0)
+#define SCFTORTOUT_ERRSTRING(s, x...) pr_alert(SCFTORT_FLAG "!!! " s "\n", ## x)
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
@@ -584,14 +583,14 @@ static int __init scf_torture_init(void)
 	if (weight_resched1 == 0 && weight_single1 == 0 && weight_single_rpc1 == 0 &&
 	    weight_single_wait1 == 0 && weight_many1 == 0 && weight_many_wait1 == 0 &&
 	    weight_all1 == 0 && weight_all_wait1 == 0) {
-		VERBOSE_SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
+		SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
 		firsterr = -EINVAL;
 		goto unwind;
 	}
 	if (IS_BUILTIN(CONFIG_SCF_TORTURE_TEST))
 		scf_sel_add(weight_resched1, SCF_PRIM_RESCHED, false);
 	else if (weight_resched1)
-		VERBOSE_SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
+		SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
 	scf_sel_add(weight_single1, SCF_PRIM_SINGLE, false);
 	scf_sel_add(weight_single_rpc1, SCF_PRIM_SINGLE_RPC, true);
 	scf_sel_add(weight_single_wait1, SCF_PRIM_SINGLE, true);
@@ -622,7 +621,7 @@ static int __init scf_torture_init(void)
 		nthreads = num_online_cpus();
 	scf_stats_p = kcalloc(nthreads, sizeof(scf_stats_p[0]), GFP_KERNEL);
 	if (!scf_stats_p) {
-		VERBOSE_SCFTORTOUT_ERRSTRING("out of memory");
+		SCFTORTOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
-- 
2.31.1.189.g2e36527f23

