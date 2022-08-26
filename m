Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8C65A31D1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbiHZWP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbiHZWPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:15:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029EBD1E33;
        Fri, 26 Aug 2022 15:15:50 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:15:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFMHjwlJOaC7wxdjP6Lb0mQDebbdA5f893mbJKtci9I=;
        b=ovcvdx7bDQdEM8NgIoWKbAZ7/fSskJjGdtJI5X3NCas3EYZ8DbNn5W4Q2oQf4j+zvyO6t0
        21R+myTd3Zkf9uQzC5RJY0l8F2jJqeg2mqOKVSUv2bnxwUQ6x6rC1AYiAB33YoaSkggpjY
        T2kRA7SQd6UB3/tGCJOE7EG/DeXukjraWmS4AuHuuhy3yJypfODB8VToBDNYVVUWd/q/Dm
        JJklXb0hqMEDV2HU4eqx/ChyjmnwRJI7lyNeK8ibz6hnEEitNUHRyg6xdng987g1YWBhG/
        /oadvoWkiPrS8AFEEPnJ2RkZXR1YWAEQkoDpDLUqfNLghSQTXzPTPd3ysFQcvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552148;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFMHjwlJOaC7wxdjP6Lb0mQDebbdA5f893mbJKtci9I=;
        b=XyCdMpAvsiDkP86h0d1WEUhmbJ3IN5CeikgR+T5DIQFZWkBKLLZ8cdjBYE7Fd00/RypBDa
        oa9RoljYf+4P9dBA==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64
 platform
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        James Clark <james.clark@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824044822.70230-5-anshuman.khandual@arm.com>
References: <20220824044822.70230-5-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <166155214636.401.10960815116962223463.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3051ee34ccb5a821bc46ef06639ff275e9c810b7
Gitweb:        https://git.kernel.org/tip/3051ee34ccb5a821bc46ef06639ff275e9c810b7
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Wed, 24 Aug 2022 10:18:18 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:47 +02:00

perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform

BRBE captured branch types will overflow perf_branch_entry.type and generic
branch types in perf_branch_entry.new_type. So override each available arch
specific branch type in the following manner to comprehensively process all
reported branch types in BRBE.

PERF_BR_ARM64_FIQ            PERF_BR_NEW_ARCH_1
PERF_BR_ARM64_DEBUG_HALT     PERF_BR_NEW_ARCH_2
PERF_BR_ARM64_DEBUG_EXIT     PERF_BR_NEW_ARCH_3
PERF_BR_ARM64_DEBUG_INST     PERF_BR_NEW_ARCH_4
PERF_BR_ARM64_DEBUG_DATA     PERF_BR_NEW_ARCH_5

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: James Clark <james.clark@arm.com>
Link: https://lkml.kernel.org/r/20220824044822.70230-5-anshuman.khandual@arm.com
---
 include/uapi/linux/perf_event.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 1a258d4..dca1658 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -293,6 +293,12 @@ enum {
 	PERF_BR_PRIV_HV		= 3,
 };
 
+#define PERF_BR_ARM64_FIQ		PERF_BR_NEW_ARCH_1
+#define PERF_BR_ARM64_DEBUG_HALT	PERF_BR_NEW_ARCH_2
+#define PERF_BR_ARM64_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
+#define PERF_BR_ARM64_DEBUG_INST	PERF_BR_NEW_ARCH_4
+#define PERF_BR_ARM64_DEBUG_DATA	PERF_BR_NEW_ARCH_5
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
