Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1C465B39
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354940AbhLBAsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbhLBArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86029C061756;
        Wed,  1 Dec 2021 16:43:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DA5DB821A1;
        Thu,  2 Dec 2021 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A44C58322;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=1583yWcgPcSd7iLBHTApnMwXtF4QzzcZxd9zWwGmZrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMvd8ZTBr05cpX+hB3PVyspQxoRYRZE1roeM8HlLuNZPxzVkhyliLRbi/PWwuYv6u
         WMKXCv/5MW+jNueFFZ6+x7uxW6/eirx8OZ7J6Mgkdzxq7i8xvPW2NkHbGP+pI2XH4N
         P4nVnkTznvaNFhtq1YDxI3o4YFdXAWHYL8yDHK+YkD8pqdEr3r6knfFrNcJYq7HvrQ
         dh8U2adVSQrmarSc34mtQhM70Y7BXT9RTupQIAaLWk5k9lcE+ZKJAf4KbavhCe4RGY
         QZCHVUKaiiOI7auft2kcaO1Y/Y2j3faK/Nz7rvx2N+3i0Rv+u2v4/M0/JEECJ4r0Ck
         0jZApj+Kvraag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 53E265C1183; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
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
Subject: [PATCH rcu 07/17] refscale: Add missing '\n' to flush message
Date:   Wed,  1 Dec 2021 16:43:26 -0800
Message-Id: <20211202004337.3130175-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhijian <zhijianx.li@intel.com>

Add '\n' to macros to flush message for each call.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index e5b0c2160592b..bbf2e915f835c 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -44,7 +44,10 @@
 	pr_alert("%s" SCALE_FLAG s, scale_type, ## x)
 
 #define VERBOSE_SCALEOUT(s, x...) \
-	do { if (verbose) pr_alert("%s" SCALE_FLAG s, scale_type, ## x); } while (0)
+	do { \
+		if (verbose) \
+			pr_alert("%s" SCALE_FLAG s "\n", scale_type, ## x); \
+	} while (0)
 
 static atomic_t verbose_batch_ctr;
 
@@ -54,12 +57,12 @@ do {											\
 	    (verbose_batched <= 0 ||							\
 	     !(atomic_inc_return(&verbose_batch_ctr) % verbose_batched))) {		\
 		schedule_timeout_uninterruptible(1);					\
-		pr_alert("%s" SCALE_FLAG s, scale_type, ## x);				\
+		pr_alert("%s" SCALE_FLAG s "\n", scale_type, ## x);			\
 	}										\
 } while (0)
 
 #define SCALEOUT_ERRSTRING(s, x...) \
-	do { pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
+	do { pr_alert("%s" SCALE_FLAG "!!! " s "\n", scale_type, ## x); } while (0)
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
@@ -842,7 +845,7 @@ ref_scale_init(void)
 		goto unwind;
 	}
 
-	VERBOSE_SCALEOUT("Starting %d reader threads\n", nreaders);
+	VERBOSE_SCALEOUT("Starting %d reader threads", nreaders);
 
 	for (i = 0; i < nreaders; i++) {
 		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
-- 
2.31.1.189.g2e36527f23

