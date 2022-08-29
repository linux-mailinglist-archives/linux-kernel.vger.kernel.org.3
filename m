Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057BA5A4429
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiH2HuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2HuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:50:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B76B7CB;
        Mon, 29 Aug 2022 00:50:04 -0700 (PDT)
Date:   Mon, 29 Aug 2022 07:50:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661759401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fO3ZTj6meGiDyhJqc5NyEivNjZrZ1xDwGlcPWQwXCF8=;
        b=jKlN3wT6MsxVoqu6RlSeVQMeQZ45pTNSGEHFdubXT5lNe+0byBiUbk0t19QDJehToxKfzF
        7VtaH2d9Y3qiIL4f8PSHIx9PUZy2O0lY+1yw3nNbllu4zKwP4y+JpPsfksV54012yuBAuW
        vbZ9n4m6x7zbBc+P6Wo2p3DbGVSo2n7mph3dHVys7g3jK/qfhZ8/eETPLidF+vY+dTTSlv
        DaH0/+z7seXlQI5AI8/MTQ7U1wPnH6H98udoj/GAqPNXov7BEg826nBoqMZJ9FJgm27UWH
        kacw+3jid0Q15FOxzWs8gzcygiqL/vmg/mlkz7Yf9w6GJggG5T7cvUpUcblUpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661759401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fO3ZTj6meGiDyhJqc5NyEivNjZrZ1xDwGlcPWQwXCF8=;
        b=9Vr6cZOymKnYSrGBjc5jV5Lmi7MEaSOmSWS0axyIsUYXSBm4pLaQ283OA9MZxWDay8q8vs
        dVMY0jRbvJSZzpAQ==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Capture branch privilege information
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        James Clark <james.clark@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824044822.70230-4-anshuman.khandual@arm.com>
References: <20220824044822.70230-4-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <166175940031.401.8517902436805331352.tip-bot2@tip-bot2>
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

Commit-ID:     5402d25aa5710d240040f73fb13d7d5c303ef071
Gitweb:        https://git.kernel.org/tip/5402d25aa5710d240040f73fb13d7d5c303ef071
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Wed, 24 Aug 2022 10:18:17 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Aug 2022 09:42:42 +02:00

perf: Capture branch privilege information

Platforms like arm64 could capture privilege level information for all the
branch records. Hence this adds a new element in the struct branch_entry to
record the privilege level information, which could be requested through a
new event.attr.branch_sample_type based flag PERF_SAMPLE_BRANCH_PRIV_SAVE.
This flag helps user choose whether privilege information is captured.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: James Clark <james.clark@arm.com>
Link: https://lkml.kernel.org/r/20220824044822.70230-4-anshuman.khandual@arm.com
---
 include/uapi/linux/perf_event.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index fed60e6..1a258d4 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT	= 17, /* save low level index of raw branch records */
 
+	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privilege mode */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -233,6 +235,8 @@ enum perf_branch_sample_type {
 
 	PERF_SAMPLE_BRANCH_HW_INDEX	= 1U << PERF_SAMPLE_BRANCH_HW_INDEX_SHIFT,
 
+	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -282,6 +286,13 @@ enum {
 	PERF_BR_NEW_MAX,
 };
 
+enum {
+	PERF_BR_PRIV_UNKNOWN	= 0,
+	PERF_BR_PRIV_USER	= 1,
+	PERF_BR_PRIV_KERNEL	= 2,
+	PERF_BR_PRIV_HV		= 3,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -1402,7 +1413,8 @@ struct perf_branch_entry {
 		type:4,     /* branch type */
 		spec:2,     /* branch speculation info */
 		new_type:4, /* additional branch type */
-		reserved:34;
+		priv:3,     /* privilege level */
+		reserved:31;
 };
 
 union perf_sample_weight {
