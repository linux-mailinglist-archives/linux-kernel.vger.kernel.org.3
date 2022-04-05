Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8B4F308F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345710AbiDEKl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbiDEIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6A517072;
        Tue,  5 Apr 2022 01:29:13 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVssBcL6rymXgzZTC6veDngOKwXKTJKSIcpdjfi2604=;
        b=vDqsj8ydGq5mP5fsT7WPXhZCNpoUo5W7DjfVDWTFJaWPvg1nmQQ/GTIPuWx7h6VRsA/Wxi
        161VH2u9zyvpAwAI4vSFC54c3hBUunQh0KOahGJuJijedg07NvKHruUKNapwoPOFD82m5Z
        uNl69pdPt7IaJuaUBpoDAen8FUkgd3WhXPf/46waRx2hrd5n7S9FUe8hT/PPdiXB6oFcfF
        lp/obselpup1DhzzoE3DGNKZ2FWtpr1WX+b94pVrhBr43VCY1KhWQKIONQSTyVE7DZOu3u
        unCWvAsJcdtbgFW0iuQKe2VFLKvQ0qF/JP5e9hMYC0DXuaPQQnsyTGXW5GddxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVssBcL6rymXgzZTC6veDngOKwXKTJKSIcpdjfi2604=;
        b=SjfwP9bh2tMXm0dhIKtW5hnpkPz7A4pTqDXXCQjB0umXAw3rdo62jZvaeopDecODeLlgGs
        Jvp/kwsxfaiF2JAg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/cstate: Add Raptor Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1647366360-82824-2-git-send-email-kan.liang@linux.intel.com>
References: <1647366360-82824-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164914735134.389.8966372231911344728.tip-bot2@tip-bot2>
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

Commit-ID:     2da202aa1c38bfe8841611a3d339892eb5579e2b
Gitweb:        https://git.kernel.org/tip/2da202aa1c38bfe8841611a3d339892eb5579e2b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 15 Mar 2022 10:45:58 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:43 +02:00

perf/x86/cstate: Add Raptor Lake support

Raptor Lake is Intel's successor to Alder lake. From the perspective of
Intel cstate residency counters, there is nothing changed compared with
Alder lake.

Share adl_cstates with Alder lake.
Update the comments for Raptor Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/1647366360-82824-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index c6262b1..5d77622 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -40,7 +40,7 @@
  * Model specific counters:
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
- *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL
+ *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -51,49 +51,50 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL
+ *						TGL,TNT,RKL,ADL,RPL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL,ADL
+ *						ICL,TGL,RKL,ADL,RPL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL
+ *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
+ *						RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL
+ *						ADL,RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL
+ *						TGL,TNT,RKL,ADL,RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
- *						KBL,CML,ICL,TGL,RKL,ADL
+ *						KBL,CML,ICL,TGL,RKL,ADL,RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
  *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL
+ *						ADL,RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
  *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL
+ *						ADL,RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL
+ *						TNT,RKL,ADL,RPL
  *			       Scope: Package (physical package)
  *
  */
@@ -680,6 +681,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
