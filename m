Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0B454826E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbiFMIoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbiFMIne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:43:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8808B1A05E;
        Mon, 13 Jun 2022 01:43:33 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:43:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKAOjO+RpZcq6LfarieRHwq4JpOcP8z4DONOzbHJQ3E=;
        b=qO9ioUPfUYcE6tce3t6d4a5bYbYFxbJ8v/mUeiYlbQIzpDYqDji7mnEcaIMpzYRaiRQXwo
        empbkqj58s3q7vMkJH3LamoU9GcHyqVQETZXq3PqOBoc7Kfc2sYDKq2HzSf7qCDssynmFi
        DWRoRhD/H2SAsDt4peIo1ZgmXK7PMKU/ASqTNOkGtYwDFv424MHCdXmhZDorj+DaY4p8kT
        hZ6wrL/lUgrHdCjVnz3CAVtaU+xRJUdEW8Y74RaYcw8gd9TWj/Vdxcg+9UEFOOWwTZu1f/
        QDWTeF5BbOu05FexNyE+i/eM6qP896Md9FG7xsWh2a5cIx+oX6pWXuHOAFOqUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKAOjO+RpZcq6LfarieRHwq4JpOcP8z4DONOzbHJQ3E=;
        b=bGkhLriKLv2TqyFB6pj75xJgRB3GvFsJUdUJ4RoyZAWB4yMhABI+0/8Yvjr8T2GAqxnh1N
        kwfJPW2utgspPtCw==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Do not swap tasks between nodes when
 spare capacity is available
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220520103519.1863-3-mgorman@techsingularity.net>
References: <20220520103519.1863-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <165510981090.4207.296202433440317954.tip-bot2@tip-bot2>
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

Commit-ID:     13ede33150877d44756171e33570076882b17b0b
Gitweb:        https://git.kernel.org/tip/13ede33150877d44756171e33570076882b17b0b
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Fri, 20 May 2022 11:35:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:29:59 +02:00

sched/numa: Do not swap tasks between nodes when spare capacity is available

If a destination node has spare capacity but there is an imbalance then
two tasks are selected for swapping. If the tasks have no numa group
or are within the same NUMA group, it's simply shuffling tasks around
without having any impact on the compute imbalance. Instead, it's just
punishing one task to help another.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20220520103519.1863-3-mgorman@techsingularity.net
---
 kernel/sched/fair.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 51836ef..23da36c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1790,6 +1790,15 @@ static bool task_numa_compare(struct task_numa_env *env,
 	 */
 	cur_ng = rcu_dereference(cur->numa_group);
 	if (cur_ng == p_ng) {
+		/*
+		 * Do not swap within a group or between tasks that have
+		 * no group if there is spare capacity. Swapping does
+		 * not address the load imbalance and helps one task at
+		 * the cost of punishing another.
+		 */
+		if (env->dst_stats.node_type == node_has_spare)
+			goto unlock;
+
 		imp = taskimp + task_weight(cur, env->src_nid, dist) -
 		      task_weight(cur, env->dst_nid, dist);
 		/*
