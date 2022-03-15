Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD984D9643
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbiCOIcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345935AbiCOIcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4814C419;
        Tue, 15 Mar 2022 01:30:57 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:30:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Fft8ZwL2Lx87/uADdwjRj9ovPOhmQ+kmRIPIPrZAc2M=;
        b=eq27owgx6o9bNjETE8c0bHYA53n/fNoyJsefWAa4akMYcyBAXam2CwxFtX6LdaSetrH1hv
        idJjZWqQezJaB/UhoDQBBr//Focljh8u7BxzI3dgcmIfu6K+T2HoFZwwwgxz3/qYsnrtgu
        xgFqdahpA2bkgQ/SEB2YLmWN84uIW6XS0nAqcGIkKBRYRbZKtJkvTUwN5XtEppEVBWoD8m
        vQLNy7IfC/pG2CEiAX9WE26EkiOoznfFQyMaQpMgCOGZD9t/fN/IGzp27vngUaffUayXKT
        uupt56b3MytMaxnaGBhg2Y8unsYpuBE2/cGF6eOQJwp2M7dU2PrV/Z2WHjwLYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Fft8ZwL2Lx87/uADdwjRj9ovPOhmQ+kmRIPIPrZAc2M=;
        b=sl5/owG7n9YCMs0s940luyzygxD0qVc0hVFRBm8wHaZ5Rk7WEcLgAMaEFN7csuSfHEDSzJ
        27ZJm0jc9E2/qTDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Reorganize, clean up and optimize
 kernel/sched/build_policy.c dependencies
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733305467.16921.16597177726639531734.tip-bot2@tip-bot2>
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

Commit-ID:     0dda4eeb484962ad574fcea77a78a4fbd7bc06ba
Gitweb:        https://git.kernel.org/tip/0dda4eeb484962ad574fcea77a78a4fbd7bc06ba
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 21 Jun 2021 10:33:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 10:58:33 +01:00

sched/headers: Reorganize, clean up and optimize kernel/sched/build_policy.c dependencies

Use all generic headers from kernel/sched/sched.h that are required
for it to build.

Sort the sections alphabetically.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/build_policy.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 9a169b2..a2e4023 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -12,12 +12,36 @@
  * core.c and fair.c are built separately.
  */
 
+/* Headers: */
+#include <linux/sched/clock.h>
+#include <linux/sched/cputime.h>
+#include <linux/sched/posix-timers.h>
+#include <linux/sched/rt.h>
+
+#include <linux/cpuidle.h>
+#include <linux/jiffies.h>
+#include <linux/livepatch.h>
+#include <linux/psi.h>
+#include <linux/seqlock_api.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include <linux/tsacct_kern.h>
+#include <linux/vtime.h>
+
+#ifdef CONFIG_PARAVIRT
+# include <asm/paravirt.h>
+#endif
+
+#include <uapi/linux/sched/types.h>
+
 #include "sched.h"
 
 #include "autogroup.h"
 #include "stats.h"
 #include "pelt.h"
 
+/* Source code modules: */
+
 #include "idle.c"
 
 #include "rt.c"
