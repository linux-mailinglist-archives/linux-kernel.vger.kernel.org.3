Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026FF465B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354765AbhLBAsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:48:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58706 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344518AbhLBArF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB0F8CE213A;
        Thu,  2 Dec 2021 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ED2C5674A;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=u/E7NBSUiC1vTrw3IPIfjunYAtKutzLweQSxWSzi/fs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8eusBADeXRGG3NCHM+RS08/OJFJSfTSksyrScsZVOkAngpIeg78vbTjXpJN/qD8C
         2J1f99G1UMGrz3kKaUDG33m1jRQ74QNUuK4Nz8bm2/p7AM2q0W/r/k6YH1heE0+Prj
         ls6JXj3H4CMr20qTXNdD3hNgrKY3KUDw9XSIrm/Z+GpFQ6+RwRmbJPTSO8gfz1BEtL
         muZOiu6s1JBToa9VCzHdQuOCFbQQj1w3weqKfdwjrkXNxPQDfDVFBeNxfrYsC0Y61E
         qV2MgMqOIAVQFkB2aMlTLO6UJ8BUa8oUN8WygE7R5RAiZqLFJX4wE6YJRGjFPpqSRJ
         vyvC8jXnBIlKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 521AC5C1180; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/17] refscale: Always log the error message
Date:   Wed,  1 Dec 2021 16:43:25 -0800
Message-Id: <20211202004337.3130175-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
References: <20211202004245.GA3129966@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhijian <lizhijian@cn.fujitsu.com>

An OOM is a serious error that should be logged even in non-verbose runs.
This commit therefore adds an unconditional SCALEOUT_ERRSTRING() macro
and uses it instead of VERBOSE_SCALEOUT_ERRSTRING() when reporting an OOM.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index d8ed1ca3adc04..e5b0c2160592b 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -58,8 +58,8 @@ do {											\
 	}										\
 } while (0)
 
-#define VERBOSE_SCALEOUT_ERRSTRING(s, x...) \
-	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
+#define SCALEOUT_ERRSTRING(s, x...) \
+	do { pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
@@ -651,7 +651,7 @@ static int main_func(void *arg)
 	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
 	buf = kzalloc(800 + 64, GFP_KERNEL);
 	if (!result_avg || !buf) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		goto oom_exit;
 	}
 	if (holdoff)
@@ -837,7 +837,7 @@ ref_scale_init(void)
 	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (!reader_tasks) {
-		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
-- 
2.31.1.189.g2e36527f23

