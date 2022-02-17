Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8A4BA8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbiBQS5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:57:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244659AbiBQS5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:57:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718D95C865;
        Thu, 17 Feb 2022 10:56:47 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124206;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMMohCtuIVghFj1NeGI6kbOcYuXSwEI5r0/f4ErZjfM=;
        b=UHhWAGT3PCAgQOjn/pb+7dTDd1iRBYs0YqOqCSzxspgRoDwHmwS7G6DwAmAV7vide6JvQx
        qUC1BjZN/CgUaTjgGNjJij4cZCznwVKnlEf7X8535nz0hkVnRTRaUfUxn5L3bgofA32Cck
        ChW8jrvsxsRLfB7DchiOlWXaasatnJn1dFFjwtN88T8bPKu1I/JLCLgbGgprpTh02gKT7+
        7aElL3pdKTmCizLK1trCtbH5HzMxE+FnjyNh8TyIva5rpITnXCFi4NOTfF3FCRqpMl4yxt
        cIGNfZoLfXDkmIR1ftJ2u37s+uoPITcc1lDqFB4mwUyagTdadQqQtnI4mDN4wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124206;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMMohCtuIVghFj1NeGI6kbOcYuXSwEI5r0/f4ErZjfM=;
        b=EUkfwxk/8Zm7la/qkbv2g+kNCrsmcIImT5OXiODEUHSVAHjSOd8bN9iDeg0gVsBEAfTINN
        /Vl7RZXGhxPYtuCw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/isolation: Fix housekeeping_mask memory leak
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Phil Auld <pauld@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207155910.527133-8-frederic@kernel.org>
References: <20220207155910.527133-8-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <164512420496.16921.9807957184721003129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     65e53f869e9f92a23593c66214b88e54fb190a13
Gitweb:        https://git.kernel.org/tip/65e53f869e9f92a23593c66214b88e54fb190a13
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 07 Feb 2022 16:59:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:56 +01:00

sched/isolation: Fix housekeeping_mask memory leak

If "nohz_full=" or "isolcpus=nohz" are called with CONFIG_NO_HZ_FULL=n,
housekeeping_mask doesn't get freed despite it being unused if
housekeeping_setup() is called for the first time.

Check this scenario first to fix this, so that no useless allocation
is performed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lore.kernel.org/r/20220207155910.527133-8-frederic@kernel.org
---
 kernel/sched/isolation.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 828dace..883eee9 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -94,6 +94,14 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
 	int err = 0;
 
+	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
+		if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+			pr_warn("Housekeeping: nohz unsupported."
+				" Build with CONFIG_NO_HZ_FULL\n");
+			return 0;
+		}
+	}
+
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
 	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
 		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
@@ -123,15 +131,8 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 		}
 	}
 
-	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
-		if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
-			tick_nohz_full_setup(non_housekeeping_mask);
-		} else {
-			pr_warn("Housekeeping: nohz unsupported."
-				" Build with CONFIG_NO_HZ_FULL\n");
-			goto free_housekeeping_staging;
-		}
-	}
+	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK))
+		tick_nohz_full_setup(non_housekeeping_mask);
 
 	housekeeping_flags |= flags;
 	err = 1;
