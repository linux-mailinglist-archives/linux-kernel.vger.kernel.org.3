Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE3754821A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbiFMIoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239657AbiFMInf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:43:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CACC2650;
        Mon, 13 Jun 2022 01:43:34 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:43:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KE9yFAhJkFSxdjlp8+j+ThbDbFONBGfonA0pKJzp54=;
        b=EKaWSJzpuW5/HnFf4wHmt/MtGF1wjwB2ATMAnsTEXS4rMo3XCyOD8/zzneFUNDvVqTI6WT
        24d6ndeqSFrPQAU/eoV+aIpz94hxKG4dwOp/c0v6Vnl23fTIMHt7XmtLyBjE4fsafqkMVz
        5W/grFHvLy3ieZ78d+msvw2voGyRnmxLASpDRfmDzBE48OroxL/kJ7s35CqW3Ff56xJqbg
        e2AFeAo9vIW8Uj1dGjaTo0e7gN8KKQGixdcqK+B9zE51EZpXARoh5sL+uNEHO14ZJGrYGT
        LjxQxEC24Xcl2BJN5TJo8s5SfL0TPISELAuKAlZuXDP74fwtpAIXZiMTI+6akQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KE9yFAhJkFSxdjlp8+j+ThbDbFONBGfonA0pKJzp54=;
        b=w1rBCN8H75IKrLkUZ5bJF2Iz5Lby5LIPLvXCz2fUOCq84D/lAI+aEuSlh2SiXIpJzwgcQc
        EkiSZmXsy+laxRCA==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Initialise numa_migrate_retry
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220520103519.1863-2-mgorman@techsingularity.net>
References: <20220520103519.1863-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <165510981202.4207.14005671845758536625.tip-bot2@tip-bot2>
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

Commit-ID:     70ce3ea9aa4ed901c8a90de667df5ef307766e71
Gitweb:        https://git.kernel.org/tip/70ce3ea9aa4ed901c8a90de667df5ef307766e71
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Fri, 20 May 2022 11:35:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:29:59 +02:00

sched/numa: Initialise numa_migrate_retry

On clone, numa_migrate_retry is inherited from the parent which means
that the first NUMA placement of a task is non-deterministic. This
affects when load balancing recognises numa tasks and whether to
migrate "regular", "remote" or "all" tasks between NUMA scheduler
domains.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20220520103519.1863-2-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048..51836ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2885,6 +2885,7 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	p->node_stamp			= 0;
 	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
 	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
+	p->numa_migrate_retry		= 0;
 	/* Protect against double add, see task_tick_numa and task_numa_work */
 	p->numa_work.next		= &p->numa_work;
 	p->numa_faults			= NULL;
