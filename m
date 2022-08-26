Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DAD5A31D3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345113AbiHZWQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242698AbiHZWPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:15:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7116DAEB;
        Fri, 26 Aug 2022 15:15:51 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:15:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L7FCVs0ouqldvQWRn61yXW9yw/lp7jB6WgFLvwRhDPc=;
        b=IhdRw8jWiUUYLi/6t+dADYftUM5A369+GLZYOLasjmF/+YxPYjoErhwCdA3GzdocnZZbjr
        bELkXVSJ/B1vp1n1SNTl8rwCHPIK1ZeJc3rYXRpOE5aR9GgtNQ+JWPrROq8VWhSDmhokLU
        ogyT6+tStyDGZLRX1PU4m8hsijXIJWjh+fPrPv80p3IBSawdF8OmuCYVvjUfUCYKPttYUx
        DDB/Y5gm9gWUY+UD3AEpoXg4DkbxdrowpfDtAN5bV6teb553gtSrpAtFWMlty4B0lCzD13
        MA5C8/A5VvCjY4huzabhrI9YK7xkChGFDaS+JKJb3q6EzdWSREZHmnRRviZk+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L7FCVs0ouqldvQWRn61yXW9yw/lp7jB6WgFLvwRhDPc=;
        b=XVkAJGn3syzGTxehqwviGZ2/s5UxcgLNIzPToe62P6yuifYp3x0KHJd7+4UlZlioi5/aOb
        3de6OeQ95x9LLuDQ==
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
Message-ID: <166155214801.401.16152978599761815008.tip-bot2@tip-bot2>
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

Commit-ID:     7203d4a5c19fc13c5229c4c1a08a5f9222207230
Gitweb:        https://git.kernel.org/tip/7203d4a5c19fc13c5229c4c1a08a5f9222207230
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Wed, 24 Aug 2022 10:18:17 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:47 +02:00

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
