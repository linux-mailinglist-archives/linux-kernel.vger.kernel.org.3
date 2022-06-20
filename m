Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E6355273E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbiFTWzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344882AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6B11EAFB;
        Mon, 20 Jun 2022 15:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63D5B61480;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB44C53FCE;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=mIK+J5JIyXuTrHJlB2cC4OPP12UXoLuTsKc8W1n+1SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXKuEUnSNN9+aFsN0kWF85D0tPMZD3HjgYaheg/1WcIqabsdaMxg6vWBFI3GchKAw
         PgTbPlTT+yPSTpUKrCjVSLoKGGRZ4If6KiXF1KOgs7kCvCgDH/a+5wFq3rH2+8kOa7
         ElVwqROzRUaPV0GfWGTNTAZ6g5Zz/OkCbev8RBPhuDv5mhLlx8HE7uWm38+8xBgqfd
         pbaN99z8gWdlnUchzTzFZN9uyMZa+PGrGfOiARpbs0b/kdCLf7nRhTds4/p6d5q+p3
         cogNysO2hDVJ7HycED+nx+Go7UeP73egE6AiLiWhWIStjEwdKQBQQ6H91GpPDKGZk6
         AHLP72JEp6fbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 656245C2B25; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Waiman Long <longman@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 32/32] rcu-tasks: Use delayed_work to delay rcu_tasks_verify_self_tests()
Date:   Mon, 20 Jun 2022 15:54:11 -0700
Message-Id: <20220620225411.3842519-32-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

Commit 2585014188d5 ("rcu-tasks: Be more patient for RCU Tasks
boot-time testing") fixes false positive rcu_tasks verification check
failure by repeating the test once every second until timeout using
schedule_timeout_uninterruptible().

Since rcu_tasks_verify_selft_tests() is called from do_initcalls()
as a late_initcall, this has the undesirable side effect of delaying
other late_initcall's queued after it by a second or more.  Fix this by
instead using delayed_work to repeat the verification check.

Fixes: 2585014188d5 ("rcu-tasks: Be more patient for RCU Tasks boot-time testing")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fcbd0ec33c866..83c7e6620d403 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1832,6 +1832,11 @@ static void rcu_tasks_initiate_self_tests(void)
 #endif
 }
 
+/*
+ * Return:  0 - test passed
+ *	    1 - test failed, but have not timed out yet
+ *	   -1 - test failed and timed out
+ */
 static int rcu_tasks_verify_self_tests(void)
 {
 	int ret = 0;
@@ -1847,16 +1852,38 @@ static int rcu_tasks_verify_self_tests(void)
 				ret = -1;
 				break;
 			}
-			schedule_timeout_uninterruptible(1);
+			ret = 1;
+			break;
 		}
 	}
-
-	if (ret)
-		WARN_ON(1);
+	WARN_ON(ret < 0);
 
 	return ret;
 }
-late_initcall(rcu_tasks_verify_self_tests);
+
+/*
+ * Repeat the rcu_tasks_verify_self_tests() call once every second until the
+ * test passes or has timed out.
+ */
+static struct delayed_work rcu_tasks_verify_work;
+static void rcu_tasks_verify_work_fn(struct work_struct *work __maybe_unused)
+{
+	int ret = rcu_tasks_verify_self_tests();
+
+	if (ret <= 0)
+		return;
+
+	/* Test fails but not timed out yet, reschedule another check */
+	schedule_delayed_work(&rcu_tasks_verify_work, HZ);
+}
+
+static int rcu_tasks_verify_schedule_work(void)
+{
+	INIT_DELAYED_WORK(&rcu_tasks_verify_work, rcu_tasks_verify_work_fn);
+	rcu_tasks_verify_work_fn(NULL);
+	return 0;
+}
+late_initcall(rcu_tasks_verify_schedule_work);
 #else /* #ifdef CONFIG_PROVE_RCU */
 static void rcu_tasks_initiate_self_tests(void) { }
 #endif /* #else #ifdef CONFIG_PROVE_RCU */
-- 
2.31.1.189.g2e36527f23

