Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ABA548257
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbiFMI33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiFMI3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:29:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B181A05F;
        Mon, 13 Jun 2022 01:29:09 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:29:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655108948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4P50zMBvwsBGLU2NYGlOToCx0ejST5tjEPdEBGifrxs=;
        b=YqtckCc7NMaTmE6zxbn7zwWjkMY1JhLR84VCIrsL6n849U2xqcr7urAUAMyc7jqCWk/L5a
        H1f4WP/U6EpusipcGSEF/8ABJXsq6fsBfzqYJokA9nYBO/iV5vSHeO0dkutHLmZMZ5g0ZY
        QDoNTNF3ipN6SRf7nLZfk77eW5wakl1OTywWZH2X+Hi1uhPvtAb9ubUe3WUgqmY8wYIpIW
        MPoWgXgK6+PlhHi9XR2ZbKQgRMclnikzYpIuQKcp9anNmvNTnLM7XR87vqShZvuPeGVSqh
        obig5IrrVrhh0sR4QXBPEIMGI5kPdobibZ/4xIzsbZOfM2ThP+AIeQa2KPTxtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655108948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4P50zMBvwsBGLU2NYGlOToCx0ejST5tjEPdEBGifrxs=;
        b=cSU3UKenuX/BNad1rtcTLFhfVn0NPiFSeik5gHrtOsR7osSWmmBE5Fuxm3FKu04hx1gort
        8buuV/hmWOAoxRDw==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/events/intel/ds: Enable large PEBS for
 PERF_SAMPLE_WEIGHT_TYPE
Cc:     Yongchao Duan <yongduan@tencent.com>, Like Xu <likexu@tencent.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220519151913.80545-1-likexu@tencent.com>
References: <20220519151913.80545-1-likexu@tencent.com>
MIME-Version: 1.0
Message-ID: <165510894684.4207.9191600089709041341.tip-bot2@tip-bot2>
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

Commit-ID:     e60b7cb089f216a26d478f5ad8f811a1de65f382
Gitweb:        https://git.kernel.org/tip/e60b7cb089f216a26d478f5ad8f811a1de65f382
Author:        Like Xu <likexu@tencent.com>
AuthorDate:    Thu, 19 May 2022 23:19:13 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:15:13 +02:00

x86/events/intel/ds: Enable large PEBS for PERF_SAMPLE_WEIGHT_TYPE

All the information required by the PERF_SAMPLE_WEIGHT is
available in the pebs record. Thus large PEBS could be enabled
for PERF_SAMPLE_WEIGHT sample type to save PMIs overhead until
other non-compatible flags such as PERF_SAMPLE_DATA_PAGE_SIZE
(due to lack of munmap tracking) stop it.

To cover new weight extension, add PERF_SAMPLE_WEIGHT_TYPE
to the guardian LARGE_PEBS_FLAGS.

Tested it with:

$ perf mem record -c 1000 workload
Before: Captured and wrote 0.126 MB perf.data (958 samples) [958 PMIs]
After: Captured and wrote 0.313 MB perf.data (4859 samples) [3 PMIs]

Reported-by: Yongchao Duan <yongduan@tencent.com>
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220519151913.80545-1-likexu@tencent.com
---
 arch/x86/events/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 21a5482..1ca6200 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -136,7 +136,8 @@ struct amd_nb {
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
 	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
 	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
-	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE)
+	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE | \
+	PERF_SAMPLE_WEIGHT_TYPE)
 
 #define PEBS_GP_REGS			\
 	((1ULL << PERF_REG_X86_AX)    | \
