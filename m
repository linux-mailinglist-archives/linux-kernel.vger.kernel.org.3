Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731BD523DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347204AbiEKTru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347154AbiEKTrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:47:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B374A3DA4D;
        Wed, 11 May 2022 12:47:06 -0700 (PDT)
Date:   Wed, 11 May 2022 19:47:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OmBT3NQxlDU3hXUnOgNbDOrxI4MkGpzAessibHPN5e8=;
        b=VebexW9R3RtlgzwofsFDmyaecW57dPo7vAcA0HBauSUKjOI6As0W2QMZ+MLOFhVH7kcYtC
        8ikb9muZ5LfjFfHbeW3ahqcfNxVUUJyLacZNkQLlLDKE9RjSf1nUypDtEBIPr4eGJRIf+g
        iNx/gHlC+b7D9d9HB4JK9PhaSd7Diwg8Cwe3eUZPqP7eppwlVw8EIECluilIAB5FaXkvlf
        jeEHyM8QOOK0k87a+lztzcV5jthKtj4U2F0aWxWlmJdwP+gP52FbNlJEtAHhQEhLQBORBP
        uWF6/GBvBHl5n5Ye5zhq3EZayimtUII1fTjQAOYJkSGRe1eom4lnCqS/fUKz/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OmBT3NQxlDU3hXUnOgNbDOrxI4MkGpzAessibHPN5e8=;
        b=P7skKloGwna5QwNim2v/xqQGo701GmGTiNVkPmYgoTH8qnuqGyZse6KUD/aC3D5hLnIw7d
        ReeapJnBKeN7qqBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/cstate: Add new Alder Lake and Raptor Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220504194413.1003071-3-kan.liang@linux.intel.com>
References: <20220504194413.1003071-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <165229842389.4207.7701841937070636375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cd971104ac7e41ff66082b9b584d319bb0688a1a
Gitweb:        https://git.kernel.org/tip/cd971104ac7e41ff66082b9b584d319bb0688a1a
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 04 May 2022 12:44:11 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:08 +02:00

perf/x86/cstate: Add new Alder Lake and Raptor Lake support

>From the perspective of Intel cstate residency counters, there is nothing
changed for the new Alder Lake N and Raptor Lake P.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220504194413.1003071-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 48e5db2..8ec23f4 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -682,7 +682,9 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
