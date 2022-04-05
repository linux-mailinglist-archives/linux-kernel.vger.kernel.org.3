Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4081D4F2DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346205AbiDEKnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbiDEIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CCD17079;
        Tue,  5 Apr 2022 01:29:14 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E+FXe1f5zmjyKSWYJfD7CbEkVYcWfT20iHGjiGdqNXg=;
        b=H+hhm3swfUasbQ76dTILXhrORpE72us0YDpYy7ERKA+xTmVO6Eb4WC9hOgfbDbdKD9y+4M
        h8PZITFwW5z4aObV8HJfsPxjDnxJxCJSK1ElK+cNI23XFgplEQAIDyVUx/M8l2fSvcQkGq
        O2WwG6bOryVc9WElSSk2D1pIdr6EDuHKK3z93roveCn/hckHrGelbYMxjxpesRqsQke2C6
        544SCsLI/wWc7tTQ9JNDaTrOcf7fPYMLBW1UDu1w08SthfsnoTQk8C73xHWgemOzPoKJks
        0qT23xsmSs2O8mslwMtBf0IXEA9tznK7s0zhm5r6RQul3WfsZ/wkcDsznxnrbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E+FXe1f5zmjyKSWYJfD7CbEkVYcWfT20iHGjiGdqNXg=;
        b=InNndmzVcr4FtQN8848pcBnuPmGlThffrlr/JJioEVab9I+uIIST2zz9xPUdmD2+ejlZJt
        dDQnSHJ0hhNk/ZBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Add Intel Raptor Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
References: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164914735235.389.727657081152348358.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c61759e581576d3330bd1d9490b4d7552e24da6b
Gitweb:        https://git.kernel.org/tip/c61759e581576d3330bd1d9490b4d7552e24da6b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 15 Mar 2022 10:45:57 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:43 +02:00

perf/x86: Add Intel Raptor Lake support

>From PMU's perspective, Raptor Lake is the same as the Alder Lake. The
only difference is the event list, which will be supported in the perf
tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/1647366360-82824-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e88791b..28f075e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6212,6 +6212,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_RAPTORLAKE:
 		/*
 		 * Alder Lake has 2 types of CPU, core and atom.
 		 *
