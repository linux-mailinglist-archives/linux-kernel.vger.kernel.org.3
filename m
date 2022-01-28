Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572C449F488
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347034AbiA1Hki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:40:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346935AbiA1HkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:40:22 -0500
Date:   Fri, 28 Jan 2022 07:40:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643355621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhcGxnKCmlfNzOrnw6CWtPC5obKr0sOrWxGxQpuO7ZU=;
        b=VbC0nuF3/gAU65zDmVRlI4QLnv2LnASX0uwGdVzU+L8lTIp7BpKGeCkM4VHHorqpaJqat3
        j+rDQFh4leJnFaNckyYKDTYgFAOUkUNnNr2gry+8LgA90sU5tjbWSMMJRmTAGN+p1YkGXA
        5UoPeLgi5b3G8u0P3elBwPedxGSz29SJEJXfNzy7w2nuhqE2wgjowzjm3Iokj2rMrk8bX2
        hjbak/92eFFaWjFw6dOn4GxkB8ZBFcG6a9b6rKt2Ix7A5dkmHYMJd1wkM4mNgpTBy5g/QI
        +BYmAge4b30kcZv0xAoRzRhMsToOKwY2zF9fsOgIjrSvdFp2OwwzSFo7u0J5fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643355621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhcGxnKCmlfNzOrnw6CWtPC5obKr0sOrWxGxQpuO7ZU=;
        b=CqAtjgsBQXcwyU3fhkqCqgbszNnaS80MzALQzIBBcuJXCvkuUP956x5Ryc4BzQ8doAYBA8
        ESGjZgVGvkdwZLCg==
From:   "tip-bot2 for Bharata B Rao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Remove mpol_get/put and
 task_lock/unlock from sched_show_numa
Cc:     Bharata B Rao <bharata@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220118050515.2973-1-bharata@amd.com>
References: <20220118050515.2973-1-bharata@amd.com>
MIME-Version: 1.0
Message-ID: <164335562004.16921.7101642205825756998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     28c988c3ec29db74a1dda631b18785958d57df4f
Gitweb:        https://git.kernel.org/tip/28c988c3ec29db74a1dda631b18785958d57df4f
Author:        Bharata B Rao <bharata@amd.com>
AuthorDate:    Tue, 18 Jan 2022 10:35:15 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Jan 2022 12:57:18 +01:00

sched/debug: Remove mpol_get/put and task_lock/unlock from sched_show_numa

The older format of /proc/pid/sched printed home node info which
required the mempolicy and task lock around mpol_get(). However
the format has changed since then and there is no need for
sched_show_numa() any more to have mempolicy argument,
asssociated mpol_get/put and task_lock/unlock. Remove them.

Fixes: 397f2378f1361 ("sched/numa: Fix numa balancing stats in /proc/pid/sched")
Signed-off-by: Bharata B Rao <bharata@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20220118050515.2973-1-bharata@amd.com
---
 kernel/sched/debug.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index aa29211..102d6f7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -931,25 +931,15 @@ void print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
 static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 {
 #ifdef CONFIG_NUMA_BALANCING
-	struct mempolicy *pol;
-
 	if (p->mm)
 		P(mm->numa_scan_seq);
 
-	task_lock(p);
-	pol = p->mempolicy;
-	if (pol && !(pol->flags & MPOL_F_MORON))
-		pol = NULL;
-	mpol_get(pol);
-	task_unlock(p);
-
 	P(numa_pages_migrated);
 	P(numa_preferred_nid);
 	P(total_numa_faults);
 	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
 			task_node(p), task_numa_group_id(p));
 	show_numa_stats(p, m);
-	mpol_put(pol);
 #endif
 }
 
