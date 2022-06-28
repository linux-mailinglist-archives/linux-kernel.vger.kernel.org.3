Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165E355E21C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbiF1HRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbiF1HQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:16:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C912C67C;
        Tue, 28 Jun 2022 00:16:47 -0700 (PDT)
Date:   Tue, 28 Jun 2022 07:16:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656400606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be2rZMSxSuOrkwNw2B547tmWDoxek/pBMVyxl1SaJCY=;
        b=Y4HumeEKjriC9cEA7OkP025d8OsbOB/zQIshmejqiyZXYV9DyNJY/sP90I1U5rJbz/hPIU
        tybEvisU/XCnzeUBCa0NXrRiF4CduG92vffCmlOpT/k+5WTezwdOEWhC/i1SF056KdACrj
        s+JrTU9OJbdO4paBwRmGipJp3j/NnhOee7J3r4k7O28p5YS9QKrfa1wCHRGCjRDIhJL6dX
        XbVIDVCvk4PCWiwKuGB6WK5VI6TFfNG4WD/WwfcVwuRvzzWdIJ642mCQC86+fELsM4CbFq
        yoZl6nd/w56YiLk2GFSLb13gVWoXLHDNKC5VJdn9JJ5trOvb3+ApcC1V8OO5eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656400606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be2rZMSxSuOrkwNw2B547tmWDoxek/pBMVyxl1SaJCY=;
        b=JxHOtk3t1PF6obiDevRdWajPkcPJ1vLVLVAWK2O9mbOgNRZinX2uVo9VwzrOIstc7FyiQA
        xwm05Cek+b+D6YBw==
From:   "tip-bot2 for Michael Jeanson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: check if libc rseq support is registered
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220614154830.1367382-4-mjeanson@efficios.com>
References: <20220614154830.1367382-4-mjeanson@efficios.com>
MIME-Version: 1.0
Message-ID: <165640060512.4207.5481017420790615805.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d1a997ba4c1bf65497d956aea90de42a6398f73a
Gitweb:        https://git.kernel.org/tip/d1a997ba4c1bf65497d956aea90de42a6398f73a
Author:        Michael Jeanson <mjeanson@efficios.com>
AuthorDate:    Tue, 14 Jun 2022 11:48:30 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:08:28 +02:00

selftests/rseq: check if libc rseq support is registered

When checking for libc rseq support in the library constructor, don't
only depend on the symbols presence, check that the registration was
completed.

This targets a scenario where the libc has rseq support but it is not
wired for the current architecture in 'bits/rseq.h', we want to fallback
to our internal registration mechanism.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/r/20220614154830.1367382-4-mjeanson@efficios.com
---
 tools/testing/selftests/rseq/rseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 986b945..4177f95 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -111,7 +111,8 @@ void rseq_init(void)
 	libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
 	libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
 	libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
-	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p) {
+	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p &&
+			*libc_rseq_size_p != 0) {
 		/* rseq registration owned by glibc */
 		rseq_offset = *libc_rseq_offset_p;
 		rseq_size = *libc_rseq_size_p;
