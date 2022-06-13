Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AEB548232
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbiFMIoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbiFMInd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:43:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363EB7661;
        Mon, 13 Jun 2022 01:43:31 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:43:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+3xFbmd2Gh9/NIxhdlDtkJKD8GDZuK1gnj6+gOsw0U=;
        b=IJ9s4WyaLsWzOjvlSW43PZtmpR6On9iauKn4FG/mWx1AKcyz80ZiCxksYnLS+1F8G+K6jS
        7LFJX4JM6Uhbd4oY84d2+3uVsc9RuDex4TJWewvlCgi5pMaGgK6t3JOC+ArDGU2piMg5pz
        BRfAI7Q+8tNGEVxhaV0bUz762ouIWw6l/QMR62kTnl84UcNHmbc9rkx1dfRr7AQC7tcddB
        Dt8khVcNpdztpfb2NmjEE2pcetZb+MOtI8LgxBv8GsAxu+JZb57tGQYdz83NGvMvQDanXe
        SpF82yINhNN8pql8FCtt4QyZBFxiAai5WL+pNaoMUxyH9WXbNIsYYHwT1Mjqkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+3xFbmd2Gh9/NIxhdlDtkJKD8GDZuK1gnj6+gOsw0U=;
        b=IDCF1Dzh9CiCTQTo+rmhB7c9LHYimzBVvQysSS67ANSPoZrTlC3iwQbmdNs3p5c6bNihtj
        LYttiwevGxlvAXDg==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Adjust imb_numa_nr to a better
 approximation of memory channels
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220520103519.1863-5-mgorman@techsingularity.net>
References: <20220520103519.1863-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <165510980876.4207.9859802458122718132.tip-bot2@tip-bot2>
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

Commit-ID:     026b98a93bbdbefb37ab8008df84e38e2fedaf92
Gitweb:        https://git.kernel.org/tip/026b98a93bbdbefb37ab8008df84e38e2fedaf92
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Fri, 20 May 2022 11:35:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:30:00 +02:00

sched/numa: Adjust imb_numa_nr to a better approximation of memory channels

For a single LLC per node, a NUMA imbalance is allowed up until 25%
of CPUs sharing a node could be active. One intent of the cut-off is
to avoid an imbalance of memory channels but there is no topological
information based on active memory channels. Furthermore, there can
be differences between nodes depending on the number of populated
DIMMs.

A cut-off of 25% was arbitrary but generally worked. It does have a severe
corner cases though when an parallel workload is using 25% of all available
CPUs over-saturates memory channels. This can happen due to the initial
forking of tasks that get pulled more to one node after early wakeups
(e.g. a barrier synchronisation) that is not quickly corrected by the
load balancer. The LB may fail to act quickly as the parallel tasks are
considered to be poor migrate candidates due to locality or cache hotness.

On a range of modern Intel CPUs, 12.5% appears to be a better cut-off
assuming all memory channels are populated and is used as the new cut-off
point. A minimum of 1 is specified to allow a communicating pair to
remain local even for CPUs with low numbers of cores. For modern AMDs,
there are multiple LLCs and are not affected.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20220520103519.1863-5-mgorman@techsingularity.net
---
 kernel/sched/topology.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05b6c2a..8739c2a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2316,23 +2316,30 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 
 				/*
 				 * For a single LLC per node, allow an
-				 * imbalance up to 25% of the node. This is an
-				 * arbitrary cutoff based on SMT-2 to balance
-				 * between memory bandwidth and avoiding
-				 * premature sharing of HT resources and SMT-4
-				 * or SMT-8 *may* benefit from a different
-				 * cutoff.
+				 * imbalance up to 12.5% of the node. This is
+				 * arbitrary cutoff based two factors -- SMT and
+				 * memory channels. For SMT-2, the intent is to
+				 * avoid premature sharing of HT resources but
+				 * SMT-4 or SMT-8 *may* benefit from a different
+				 * cutoff. For memory channels, this is a very
+				 * rough estimate of how many channels may be
+				 * active and is based on recent CPUs with
+				 * many cores.
 				 *
 				 * For multiple LLCs, allow an imbalance
 				 * until multiple tasks would share an LLC
 				 * on one node while LLCs on another node
-				 * remain idle.
+				 * remain idle. This assumes that there are
+				 * enough logical CPUs per LLC to avoid SMT
+				 * factors and that there is a correlation
+				 * between LLCs and memory channels.
 				 */
 				nr_llcs = sd->span_weight / child->span_weight;
 				if (nr_llcs == 1)
-					imb = sd->span_weight >> 2;
+					imb = sd->span_weight >> 3;
 				else
 					imb = nr_llcs;
+				imb = max(1U, imb);
 				sd->imb_numa_nr = imb;
 
 				/* Set span based on the first NUMA domain. */
