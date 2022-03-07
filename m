Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7434D065E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244804AbiCGSX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244884AbiCGSXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:23:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7035C82D20;
        Mon,  7 Mar 2022 10:22:19 -0800 (PST)
Date:   Mon, 07 Mar 2022 18:22:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646677338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=brdFGG5Xij91XQ8U/NotYr8CHSDrJMrma8OMykMr1cI=;
        b=2U+40qWS2SkN4gmthV4VprEcxB5unBFL0LCRz/+A5tWXsvn5D5ZeIU6Rhga4qzebHJLlJW
        Nbvpj9iOcCBuGQYbYlqGdPdbbIZIXxe5ztia0G7grw79yrlVpYLkaLvYg4OZJJ9+qQ7CMR
        Gy0qRpybKjPGwCeZ8WiOxkNNpj9wIGkugQNb0NXKhrJkR+D/57QtEyvcEoqN0WcUNhoISi
        KhS1P0TMJ/8/x354Mgijp2IeKywsjKgs+sa6DJfn1s7mnHefqIpucgUUT0ullRSE8kk8lh
        LGe5qeuGCj1zTzAYhgN3puyBfMs5NMR+1+Kw7e5HHBMyrmGDt90GjURM05Agbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646677338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=brdFGG5Xij91XQ8U/NotYr8CHSDrJMrma8OMykMr1cI=;
        b=TlFHxC+1vRDDtm2v/h5SgUcBdKNs/J7XnR4uMQ3F1ZZnpdKUIUpjpLTlTwtuIaUN9p5xlE
        imxe2ZaRkfnvOSAA==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW
Cc:     Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164667733672.16921.6998583323424686515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fc153c1c58cb8c3bb3b443b4d7dc3211ff5f65fc
Gitweb:        https://git.kernel.org/tip/fc153c1c58cb8c3bb3b443b4d7dc3211ff5=
f65fc
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Sun, 05 Dec 2021 22:38:15 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 01 Feb 2022 17:35:43 -08:00

clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW

A watchdog maximum skew of 100us may still be too small for
some systems or archs. It may also be too small when some kernel
debug config options are enabled.  So add a new Kconfig option
CLOCKSOURCE_WATCHDOG_MAX_SKEW_US to allow kernel builders to have more
control on the threshold for marking clocksource as unstable.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/Kconfig       |  9 +++++++++
 kernel/time/clocksource.c |  8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 04bfd62..27b7868 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -181,5 +181,14 @@ config HIGH_RES_TIMERS
 	  hardware is not capable then this option only increases
 	  the size of the kernel image.
=20
+config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+	int "Clocksource watchdog maximum allowable skew (in =CE=BCs)"
+	depends on CLOCKSOURCE_WATCHDOG
+	range 50 1000
+	default 100
+	help
+	  Specify the maximum amount of allowable watchdog skew in
+	  microseconds before reporting the clocksource to be unstable.
+
 endmenu
 endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 1cf7380..95d7ca3 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -107,7 +107,13 @@ static u64 suspend_start;
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
  * a lower bound for cs->uncertainty_margin values when registering clocks.
  */
-#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
+#ifdef CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+#define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+#else
+#define MAX_SKEW_USEC	100
+#endif
+
+#define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
=20
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
