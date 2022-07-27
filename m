Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E36582621
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiG0MJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiG0MJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:09:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E94B49D;
        Wed, 27 Jul 2022 05:09:39 -0700 (PDT)
Date:   Wed, 27 Jul 2022 12:09:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658923778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fp6pr5Xxzr1gnsIEg3CkXgkarNweuTECiEdDkXj13U=;
        b=OiX175RLZJQa+2i9+5hh63PUcj4tJh9tTQ4Bwh4SzrNKC54GsE2m+1KKrR16K+uKUupkAQ
        7L4YjoSqdqArUR472iXW3wbBhWB0C3tQ8sBI8aRQ6sbX4/LoP+kqjaViHc9xNx9mqA8F+l
        WGtuY66PY/zI2a87n0WgJeJ1q/Brr1f/xHQ41GzNPWiiff4n3RuIr2b6A1wx1mkualrTBF
        L/h3107lhLQlw7X1SwfFVPLebVCMSVLPhrIDoc4/Wnhm8ewP7aM1rI8JNqq66ZA05CdcLr
        HbTxWivNMyH+Tg6UK/WM/m/C5RZlVeDY9dVUmuparRMi/H7D2iHI6SsiRBlQFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658923778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fp6pr5Xxzr1gnsIEg3CkXgkarNweuTECiEdDkXj13U=;
        b=fn13zn6j1oVfJEfdoTsd/pWnL1larSYU6/SlUVvENsw6t8xMjsQ2SinWIDSw73SEkhSmG+
        qPcgjZ3UOEp00CCg==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/ibs: Add new IBS register bits into header
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Borislav Petkov <bp@suse.de>, Ian Rogers <irogers@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220604044519.594-7-ravi.bangoria@amd.com>
References: <20220604044519.594-7-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <165892377681.15455.233092789209615984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     326ecc15c61c349cd49d1700ff9e3e31c6fd1cd5
Gitweb:        https://git.kernel.org/tip/326ecc15c61c349cd49d1700ff9e3e31c6fd1cd5
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Sat, 04 Jun 2022 10:15:17 +05:30
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 Jul 2022 13:54:38 +02:00

perf/x86/ibs: Add new IBS register bits into header

IBS support has been enhanced with two new features in upcoming uarch:

  1. DataSrc extension and
  2. L3 miss filtering.

Additional set of bits has been introduced in IBS registers to use these
features. Define these new bits into arch/x86/ header.

  [ bp: Massage commit message. ]

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20220604044519.594-7-ravi.bangoria@amd.com
---
 arch/x86/include/asm/amd-ibs.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index aabdbb5..f3eb098 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -29,7 +29,10 @@ union ibs_fetch_ctl {
 			rand_en:1,	/* 57: random tagging enable */
 			fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
 					 *      (needs IbsFetchComp) */
-			reserved:5;	/* 59-63: reserved */
+			l3_miss_only:1,	/* 59: Collect L3 miss samples only */
+			fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
+			fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
+			reserved:2;	/* 62-63: reserved */
 	};
 };
 
@@ -38,14 +41,14 @@ union ibs_op_ctl {
 	__u64 val;
 	struct {
 		__u64	opmaxcnt:16,	/* 0-15: periodic op max. count */
-			reserved0:1,	/* 16: reserved */
+			l3_miss_only:1,	/* 16: Collect L3 miss samples only */
 			op_en:1,	/* 17: op sampling enable */
 			op_val:1,	/* 18: op sample valid */
 			cnt_ctl:1,	/* 19: periodic op counter control */
 			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
-			reserved1:5,	/* 27-31: reserved */
+			reserved0:5,	/* 27-31: reserved */
 			opcurcnt:27,	/* 32-58: periodic op counter current count */
-			reserved2:5;	/* 59-63: reserved */
+			reserved1:5;	/* 59-63: reserved */
 	};
 };
 
@@ -71,11 +74,12 @@ union ibs_op_data {
 union ibs_op_data2 {
 	__u64 val;
 	struct {
-		__u64	data_src:3,	/* 0-2: data source */
+		__u64	data_src_lo:3,	/* 0-2: data source low */
 			reserved0:1,	/* 3: reserved */
 			rmt_node:1,	/* 4: destination node */
 			cache_hit_st:1,	/* 5: cache hit state */
-			reserved1:57;	/* 5-63: reserved */
+			data_src_hi:2,	/* 6-7: data source high */
+			reserved1:56;	/* 8-63: reserved */
 	};
 };
 
