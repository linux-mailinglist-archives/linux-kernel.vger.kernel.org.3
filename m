Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22357465B38
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354832AbhLBAr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbhLBArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:47:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D59C06174A;
        Wed,  1 Dec 2021 16:43:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B608B82197;
        Thu,  2 Dec 2021 00:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87E1C5831B;
        Thu,  2 Dec 2021 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405818;
        bh=6xNAyz7Jtw09cJifsyQ60FXipRtHoNcO2JuOTeAmxEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGHjBU14hJPni1i9HMqF+TXIovFjhcMV1FnaNAXe0UvVdtYDrybW5lEMn0Cd+AIkt
         FSzrl1DTlONWNTjHcxkgsp4PmXmxUB+s4R6ze+KwzIoCcycIRoK/1HnW7gK7qH5M4U
         WvhB40AKWWhBwkIvZKEwpHnDhAt0AcU7NBmg+THFAwlMZD0zpTz0cZKZHpqHEspWOx
         Od92UKlj+uY9/Ar4H550CvSpTbokOpHttK8KALeUJun1IXgHnlObsn/u5/dmtSM4Ap
         g8NtJfynIrLfJKegKDE1cA4JgGNdNRwCzmCtttvFx4b+CyhzwGffarzpjbDUBLsSix
         M/RUg0qUrqgSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 55B3D5C1184; Wed,  1 Dec 2021 16:43:38 -0800 (PST)
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
Subject: [PATCH rcu 08/17] scftorture: Add missing '\n' to flush message
Date:   Wed,  1 Dec 2021 16:43:27 -0800
Message-Id: <20211202004337.3130175-8-paulmck@kernel.org>
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
 kernel/scftorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 5d42f44e3e1a1..9cff573b7eb4f 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -42,10 +42,10 @@
 	pr_alert(SCFTORT_FLAG s, ## x)
 
 #define VERBOSE_SCFTORTOUT(s, x...) \
-	do { if (verbose) pr_alert(SCFTORT_FLAG s, ## x); } while (0)
+	do { if (verbose) pr_alert(SCFTORT_FLAG s "\n", ## x); } while (0)
 
 #define VERBOSE_SCFTORTOUT_ERRSTRING(s, x...) \
-	do { if (verbose) pr_alert(SCFTORT_FLAG "!!! " s, ## x); } while (0)
+	do { if (verbose) pr_alert(SCFTORT_FLAG "!!! " s "\n", ## x); } while (0)
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
@@ -630,7 +630,7 @@ static int __init scf_torture_init(void)
 		goto unwind;
 	}
 
-	VERBOSE_SCFTORTOUT("Starting %d smp_call_function() threads\n", nthreads);
+	VERBOSE_SCFTORTOUT("Starting %d smp_call_function() threads", nthreads);
 
 	atomic_set(&n_started, nthreads);
 	for (i = 0; i < nthreads; i++) {
-- 
2.31.1.189.g2e36527f23

