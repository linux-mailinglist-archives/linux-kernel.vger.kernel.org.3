Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1DB5A31E1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345217AbiHZWQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345083AbiHZWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:15:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B14D1E33;
        Fri, 26 Aug 2022 15:15:57 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:15:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VByEjTyR+7K3nixocDYcWs6DZi3rwzn+uvH/Ml+aSlY=;
        b=gx6/i3vNCdGmmyeqET5n4FrczruKc5F0TEJPZJLD6Qev5CvPzo02y8QVfI3yd1XL/I1TVt
        XqFPbeRHa7japQJjM9PUbjcjpxHgNcgi9mPlzNC6EoLM4ZADcNLDy78xXuVkENLuD1dlsU
        weCqM2+K7Bjzk85eyGA3nuLt29CkArcsCEKi9SMWBCDnVUwCdnxLjQqyImcmujAwusiRLl
        IfMcBJwwaOf+P21U5sh8OOGTetrmx/ouiXZ9hYNsAFxr9u/qWM/dtbDe55lcgF4AxlpRSb
        AyXe+TmZSWvuYIgrPW32QW4rgVZ+FMXv3d/FjeipjM3KB5bAhlHW6mck5DUclA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VByEjTyR+7K3nixocDYcWs6DZi3rwzn+uvH/Ml+aSlY=;
        b=+ylpFQN1oqzBS3HKNs3GYhzsNCJh+wlfTWB2sZ1xbidDHxJHQS7WeHDmrVvb55YDDt4KVh
        x8MxU3bTBgJYnGDg==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add speculation info to branch entries
Cc:     Stephane Eranian <eranian@google.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C834088c302faf21c7b665031dd111f424e509a64=2E16602?=
 =?utf-8?q?11399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C834088c302faf21c7b665031dd111f424e509a64=2E166021?=
 =?utf-8?q?1399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166155215416.401.7378423137712801227.tip-bot2@tip-bot2>
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

Commit-ID:     93315e46b000fc80fff5d53c3f444417fb3df6de
Gitweb:        https://git.kernel.org/tip/93315e46b000fc80fff5d53c3f444417fb3df6de
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 11 Aug 2022 18:00:00 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:45 +02:00

perf/core: Add speculation info to branch entries

Add a new "spec" bitfield to branch entries for providing speculation
information. This will be populated using hints provided by branch sampling
features on supported hardware. The following cases are covered:

  * No branch speculation information is available
  * Branch is speculative but taken on the wrong path
  * Branch is non-speculative but taken on the correct path
  * Branch is speculative and taken on the correct path

Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/834088c302faf21c7b665031dd111f424e509a64.1660211399.git.sandipan.das@amd.com
---
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ee8b9ec..ae30c61 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1078,6 +1078,7 @@ static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *b
 	br->abort = 0;
 	br->cycles = 0;
 	br->type = 0;
+	br->spec = PERF_BR_SPEC_NA;
 	br->reserved = 0;
 }
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 03b3700..30a4723 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -256,6 +256,17 @@ enum {
 	PERF_BR_MAX,
 };
 
+/*
+ * Common branch speculation outcome classification
+ */
+enum {
+	PERF_BR_SPEC_NA			= 0,	/* Not available */
+	PERF_BR_SPEC_WRONG_PATH		= 1,	/* Speculative but on wrong path */
+	PERF_BR_NON_SPEC_CORRECT_PATH	= 2,	/* Non-speculative but on correct path */
+	PERF_BR_SPEC_CORRECT_PATH	= 3,	/* Speculative and on correct path */
+	PERF_BR_SPEC_MAX,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -1363,6 +1374,7 @@ union perf_mem_data_src {
  *     abort: aborting a hardware transaction
  *    cycles: cycles from last branch (or 0 if not supported)
  *      type: branch type
+ *      spec: branch speculation info (or 0 if not supported)
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1373,7 +1385,8 @@ struct perf_branch_entry {
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
 		type:4,     /* branch type */
-		reserved:40;
+		spec:2,     /* branch speculation info */
+		reserved:38;
 };
 
 union perf_sample_weight {
