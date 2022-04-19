Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3555D507A55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbiDSThr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353383AbiDSThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:37:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BE1D92;
        Tue, 19 Apr 2022 12:34:47 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:34:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650396885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRQQCuR5psNuEiEnoSIeznGIw1weg0S41N/l1rYRi6Y=;
        b=gdDI/V/cL+VUL8d+Y7IDSxEJ4tzTGXdZ0SSl1TgG4p39R7Jr+nzapBvdxhTYOMU2wEGZmq
        lxJBDtVlPsHqHpW9dEiGzNJi3tDmMe6m16i9BwgPdksBagFFooieaTasf3V/Ieul1CEefa
        9OMLgIyldo7GsTgXZ2dNSoDbgIHTSsNJAfUxNjsdnabwSVn2TE3lYi3sckjO3K1tiwGBik
        k21LepVYdoFkSxw34VrSN1fUrIpjr59QgmUIqxITuhDDmaSNaNxcEBHvFUnAwDXgDaKQYI
        NtghqVISvvQ71lwFfdLT2YY3IVZbYBUubTKDTPehU8Uax/jqKs21hVEcVYYnDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650396885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRQQCuR5psNuEiEnoSIeznGIw1weg0S41N/l1rYRi6Y=;
        b=0LRK1oFt4ul1dOERvtskPv9xPYSsxHx1kAkm5O1oBjKp8ya5QyCYuBLihzIQ4X8zMnQpqe
        sW0WGQk5vB3bhTDQ==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/cstate: Add SAPPHIRERAPIDS_X CPU support
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415104520.2737004-1-rui.zhang@intel.com>
References: <20220415104520.2737004-1-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <165039688387.4207.9627719799836247757.tip-bot2@tip-bot2>
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

Commit-ID:     528c9f1daf20da14d3e7348dc4b1d7c55743ee64
Gitweb:        https://git.kernel.org/tip/528c9f1daf20da14d3e7348dc4b1d7c55743ee64
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Fri, 15 Apr 2022 18:45:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:15:42 +02:00

perf/x86/cstate: Add SAPPHIRERAPIDS_X CPU support

>From the perspective of Intel cstate residency counters,
SAPPHIRERAPIDS_X is the same as ICELAKE_X.

Share the code with it. And update the comments for SAPPHIRERAPIDS_X.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20220415104520.2737004-1-rui.zhang@intel.com
---
 arch/x86/events/intel/cstate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 5d77622..48e5db2 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -51,7 +51,7 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL,RPL
+ *						TGL,TNT,RKL,ADL,RPL,SPR
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
@@ -62,7 +62,7 @@
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL
+ *						RPL,SPR
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -74,7 +74,7 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL,RPL
+ *						TGL,TNT,RKL,ADL,RPL,SPR
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -675,6 +675,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&icx_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&icx_cstates),
 
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
