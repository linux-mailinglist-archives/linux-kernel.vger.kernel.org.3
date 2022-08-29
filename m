Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177F5A442F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiH2Hua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiH2HuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:50:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A02B7C1;
        Mon, 29 Aug 2022 00:50:04 -0700 (PDT)
Date:   Mon, 29 Aug 2022 07:50:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661759402;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxYcNG93g26r3LfjfXOU0Wfjer1pZazRkJ3e0LkQmmA=;
        b=qWj5UrDdY4gknEg+KvbhpMGWBygdSLlMvID6LRCVgK5nLwN+tNl6gqYdOJNNpBKMshpxyF
        jH5dVF1jaCnhMHEX4F7CgDET+8Tg8kiS3+xpsCiV08owbVTKs29pAb+s97zXpC1bUj1VMb
        3N0JNK684TpXapvn8kj9UXqaA/Vgpf8SDTK1sNqoD9t3gAoB46eeGKjK9ASGyhDAhtKbiY
        CU4u3udMRovnZDI+52aYUacTfU79U9ueQ87KG1oKqIcITImz6i3saRputT1tAWNWruROtV
        YDJGuLEujdMsB3Ap0EyCONiKe6XyfT2dHdtfMlK96voXOSc3Nlk2AfUwAWCGCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661759402;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxYcNG93g26r3LfjfXOU0Wfjer1pZazRkJ3e0LkQmmA=;
        b=z+V1Sn8qW/EhZah9e4hv1WxFRo8FXr5XQxancijHqcYNEUOrYmLEKjgmXGaYYql8wxlYpX
        3hy5U5afuekIbtDg==
From:   "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Extend branch type classification
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        James Clark <james.clark@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824044822.70230-3-anshuman.khandual@arm.com>
References: <20220824044822.70230-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Message-ID: <166175940134.401.14721659707205439903.tip-bot2@tip-bot2>
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

Commit-ID:     b190bc4ac9e6d9763b61654c5a0c085ff77d7a09
Gitweb:        https://git.kernel.org/tip/b190bc4ac9e6d9763b61654c5a0c085ff77d7a09
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Wed, 24 Aug 2022 10:18:16 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Aug 2022 09:42:42 +02:00

perf: Extend branch type classification

branch_entry.type now has ran out of space to accommodate more branch types
classification. This will prevent perf branch stack implementation on arm64
(via BRBE) to capture all available branch types. Extending this bit field
i.e branch_entry.type [4 bits] is not an option as it will break user space
ABI both for little and big endian perf tools.

Extend branch classification with a new field branch_entry.new_type via a
new branch type PERF_BR_EXTEND_ABI in branch_entry.type. Perf tools which
could decode PERF_BR_EXTEND_ABI, will then parse branch_entry.new_type as
well.

branch_entry.new_type is a 4 bit field which can hold upto 16 branch types.
The first three branch types will hold various generic page faults followed
by five architecture specific branch types, which can be overridden by the
platform for specific use cases. These architecture specific branch types
gets overridden on arm64 platform for BRBE implementation.

New generic branch types

 - PERF_BR_NEW_FAULT_ALGN
 - PERF_BR_NEW_FAULT_DATA
 - PERF_BR_NEW_FAULT_INST

New arch specific branch types

 - PERF_BR_NEW_ARCH_1
 - PERF_BR_NEW_ARCH_2
 - PERF_BR_NEW_ARCH_3
 - PERF_BR_NEW_ARCH_4
 - PERF_BR_NEW_ARCH_5

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: James Clark <james.clark@arm.com>
Link: https://lkml.kernel.org/r/20220824044822.70230-3-anshuman.khandual@arm.com
---
 include/uapi/linux/perf_event.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index a79cc0e..fed60e6 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -255,6 +255,7 @@ enum {
 	PERF_BR_IRQ		= 12,	/* irq */
 	PERF_BR_SERROR		= 13,	/* system error */
 	PERF_BR_NO_TX		= 14,	/* not in transaction */
+	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
 	PERF_BR_MAX,
 };
 
@@ -269,6 +270,18 @@ enum {
 	PERF_BR_SPEC_MAX,
 };
 
+enum {
+	PERF_BR_NEW_FAULT_ALGN		= 0,    /* Alignment fault */
+	PERF_BR_NEW_FAULT_DATA		= 1,    /* Data fault */
+	PERF_BR_NEW_FAULT_INST		= 2,    /* Inst fault */
+	PERF_BR_NEW_ARCH_1		= 3,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_2		= 4,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_3		= 5,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_4		= 6,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_5		= 7,    /* Architecture specific */
+	PERF_BR_NEW_MAX,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -1388,7 +1401,8 @@ struct perf_branch_entry {
 		cycles:16,  /* cycle count to last branch */
 		type:4,     /* branch type */
 		spec:2,     /* branch speculation info */
-		reserved:38;
+		new_type:4, /* additional branch type */
+		reserved:34;
 };
 
 union perf_sample_weight {
