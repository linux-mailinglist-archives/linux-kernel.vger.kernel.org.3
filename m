Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5F4F31BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354708AbiDEKPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbiDEIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A017070;
        Tue,  5 Apr 2022 01:29:12 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Od4ziOiKeQ/jjCBhqAj+AU5QzqCu91hE4cMK0pLFXYE=;
        b=qXnvbuPSVAqPxOmoS7huLahkBarnv4jzT+sUvi35nqqcfk63mJuG3Q676E53O/57TRih/h
        fwfay+zcB+Q6wTL1vCev4xy1VgDohOxgcoiIMHyfEE50MnRy7CHRW/T9AwBX4yOSyeSvb6
        INW6w/MvOVjNL8QSZmmvhvRXAE3Wh/cTspg9WdWSMOjH8+/PbThfMEhND88Uv6jE1/DYUA
        W2M7OzCgnHakQpA7qX60/SJTOOHo8ovQLKuhywcrrlo0XsjJEHmMTbyjT+3bOMhGUqQr5z
        MnGktkwHyLmh8CEDy5LYudFPT3pvLbTptzUUsij27O0WKuzkI692Tb+RCBtdmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Od4ziOiKeQ/jjCBhqAj+AU5QzqCu91hE4cMK0pLFXYE=;
        b=8q54xvi1gCg0up2AgK9eWomGt37o1/Gt9ECW5tgzqrfhaDVRNM0oH27dthpjOy/473mGBv
        VByWpBdL7zim9RCA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/msr: Add Raptor Lake CPU support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1647366360-82824-3-git-send-email-kan.liang@linux.intel.com>
References: <1647366360-82824-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164914735035.389.18407088404676331471.tip-bot2@tip-bot2>
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

Commit-ID:     82cd83047a9a80e52c0849e56885279166215310
Gitweb:        https://git.kernel.org/tip/82cd83047a9a80e52c0849e56885279166215310
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 15 Mar 2022 10:45:59 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:43 +02:00

perf/x86/msr: Add Raptor Lake CPU support

Raptor Lake is Intel's successor to Alder lake. PPERF and SMI_COUNT MSRs
are also supported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/1647366360-82824-3-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 96c775a..6d759f8 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -103,6 +103,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ROCKETLAKE:
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_RAPTORLAKE:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
