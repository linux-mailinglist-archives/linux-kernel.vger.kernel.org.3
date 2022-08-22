Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525DB59BC27
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiHVJBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiHVJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:00:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3583D2E6B3;
        Mon, 22 Aug 2022 02:00:54 -0700 (PDT)
Date:   Mon, 22 Aug 2022 09:00:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661158851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6SYAGK5MAJ3MgeJIA7evL1fzXBQDpRDV/9faic4irg=;
        b=0ZxZWjga3MNFns/pZm08bJKlxkakpdxK+guL5FNbZNdtV67x6wifAl/NLAqvdOFCjGRZlU
        y+FlsWFNSI8fH0mKVQdCaXOfHqgerJr3hdlpaJVQD+KYyNhiueKV7U3v4Ng18cKdQbg6IU
        LpOLwdtJ+kKStcycqs/CCLCxv60A10PAZUcu3LRFJOTzeqFXrfAXwaKHv0YjQb8t3c/TX5
        +9iQ8Yl/MNUOQB5LyPbk/ca+XTRgGYPuCJ34ziSOt/7MJ77qq1FTIjUta3pYnOzfqdb7Z5
        Dz9+AOABR70dGi5QCSDjAFjlh/wVafx7UBTF0JVFN1oGN75guKad9olZVIY/rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661158851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6SYAGK5MAJ3MgeJIA7evL1fzXBQDpRDV/9faic4irg=;
        b=VVQlxSDX5qHPS08GZH/slQ5UKWEZ/+oghi+/Nr/o/EiXuInR3rnbOT/Z4YkZ3IErMYqGLl
        X8opZBM805A8I6DA==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/ds: Fix precise store latency handling
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818054613.1548130-1-eranian@google.com>
References: <20220818054613.1548130-1-eranian@google.com>
MIME-Version: 1.0
Message-ID: <166115885066.401.15226681508594972592.tip-bot2@tip-bot2>
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

Commit-ID:     d4bdb0bebc5ba3299d74f123c782d99cd4e25c49
Gitweb:        https://git.kernel.org/tip/d4bdb0bebc5ba3299d74f123c782d99cd4e25c49
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 17 Aug 2022 22:46:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 Aug 2022 19:47:31 +02:00

perf/x86/intel/ds: Fix precise store latency handling

With the existing code in store_latency_data(), the memory operation (mem_op)
returned to the user is always OP_LOAD where in fact, it should be OP_STORE.
This comes from the fact that the function is simply grabbing the information
from a data source map which covers only load accesses. Intel 12th gen CPU
offers precise store sampling that captures both the data source and latency.
Therefore it can use the data source mapping table but must override the
memory operation to reflect stores instead of loads.

Fixes: 61b985e3e775 ("perf/x86/intel: Add perf core PMU support for Sapphire Rapids")
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220818054613.1548130-1-eranian@google.com
---
 arch/x86/events/intel/ds.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ac6dd4c..e5b5874 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -291,6 +291,7 @@ static u64 load_latency_data(struct perf_event *event, u64 status)
 static u64 store_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
+	union perf_mem_data_src src;
 	u64 val;
 
 	dse.val = status;
@@ -304,7 +305,14 @@ static u64 store_latency_data(struct perf_event *event, u64 status)
 
 	val |= P(BLK, NA);
 
-	return val;
+	/*
+	 * the pebs_data_source table is only for loads
+	 * so override the mem_op to say STORE instead
+	 */
+	src.val = val;
+	src.mem_op = P(OP,STORE);
+
+	return src.val;
 }
 
 struct pebs_record_core {
