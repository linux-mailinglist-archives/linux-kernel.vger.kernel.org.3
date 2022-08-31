Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65695A857A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiHaS0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiHaSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5215FF2D6B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3DFD61CD5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F8FC433C1;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=G6VCAaAlg/8tBYkx3RPV5CkGGSZS3E5wZVxJmH+lP90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVBHJbpNQdgbnc4qXYLa+ovth+GIPc7SCLhCOA6jS5UqRAf/NBnMuaRtX2GsKQV7m
         hpi2tqu1Sd+z1oP7yFNBuQSEKCFrIIlQa2R8hZmAGWK7q6uo8HhxxapcLBYR78jC7q
         Pei9AcypNaKfMPjIMe8csMI+ZQGbIUHCBSyvFiMNbu8EB+K3bA+QOy8fRX06rNqLZn
         BhM/pRcBsQ7QuoerunDb6speRipO+PJP4aofMvvifHF59W3gDsrvyX532HFUYeGT3N
         op0KYOvA6VDi8UBetIc2CnfTA+hq1JuXgYOXaiXGozu5+61Zuc7z+KRym/2P9koOaj
         jWyQxvf2sK78A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D16295C0143; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        "Paul E. McKenney" <paulmck@kernel.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH rcu 1/2] torture: Optionally flush printk() buffers before powering off
Date:   Wed, 31 Aug 2022 11:21:30 -0700
Message-Id: <20220831182148.2698489-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
References: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcutorture test suite produces quite a bit of console output at
the end of a test.  This means that the new-in-2022 printk() kthreads
are likely to be in the process of flushing output at the time of the
torture_shutdown() function's call to kernel_power_off().  Normally,
rcutorture relies on printk() to flush any pending output upon shutdown,
the better to detect bugs in this area, for example, the one introduced
by 8e274732115f ("printk: extend console_lock for per-console locking").
However, once such a bug is detected and reported, it is necessary to
test the rest of the system, without noise from the already-reported bug.

This commit therefore adds a torture.printk_shutdown_bug_workaround
kernel parameter, which causes torture_shutdown() to invoke pr_flush(),
and print an informative message on the console, immediately before
invoking kernel_power_off().  When this kernel parameter is not specified,
it is up to printk() to flush its own buffers.

Suggested-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 kernel/torture.c                                | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d7f30902fda02..ba1b8776aab83 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6143,6 +6143,12 @@
 			are running concurrently, especially on systems
 			with rotating-rust storage.
 
+	torture.printk_shutdown_bug_workaround= [KNL]
+			Execute pr_flush(1000, true) just before invoking
+			kernel_power_off() to work around any bugs that
+			might prevent printk() from flushing its buffers
+			at shutdown time.
+
 	torture.verbose_sleep_frequency= [KNL]
 			Specifies how many verbose printk()s should be
 			emitted between each sleep.  The default of zero
diff --git a/kernel/torture.c b/kernel/torture.c
index 789aeb0e1159c..7cd2016b02076 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -48,6 +48,9 @@ module_param(disable_onoff_at_boot, bool, 0444);
 static bool ftrace_dump_at_shutdown;
 module_param(ftrace_dump_at_shutdown, bool, 0444);
 
+static bool printk_shutdown_bug_workaround;
+module_param(printk_shutdown_bug_workaround, bool, 0444);
+
 static int verbose_sleep_frequency;
 module_param(verbose_sleep_frequency, int, 0444);
 
@@ -651,6 +654,10 @@ static int torture_shutdown(void *arg)
 		VERBOSE_TOROUT_STRING("No torture_shutdown_hook(), skipping.");
 	if (ftrace_dump_at_shutdown)
 		rcu_ftrace_dump(DUMP_ALL);
+	if (printk_shutdown_bug_workaround) {
+		pr_info("%s: Flushing printk() buffers at power-down time.\n", __func__);
+		pr_flush(1000, true);
+	}
 	kernel_power_off();	/* Shut down the system. */
 	return 0;
 }
-- 
2.31.1.189.g2e36527f23

