Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AB14AC10C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391320AbiBGOTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388526AbiBGNv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:51:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F0EC0401C0;
        Mon,  7 Feb 2022 05:51:56 -0800 (PST)
Date:   Mon, 07 Feb 2022 13:51:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644241912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9xA7eYVT5M2/VrmaYV4cA9B4eqyznJsTf6TVyU7AcS8=;
        b=eHe/pDa41pwmIPGYH51kk1NHelMzaqhOPr58LFvzbaA3W+wWVP1SSUvs10YJFgnTcdDTeE
        4AKmD6HBEn6HN1g9SJcXRhqfPWpfLoLjypL+tAM2fU8chj9uSE+VNmzMCqzjcdj9dpbjX0
        D/1SVCoh7Y0UvIsXRRnklvtMGnqEYfxeZqZCQ1Am/9wYnGtdlZciq0dKXTP8k4uJZkYUB6
        4Q8hK0gpX3oKlcSxwSEH73IDMBsKXM/IvaNEAg9AASe3eKuQBuKRx79pyIEpNo4fDHeZ9X
        SDRNdlCG/QAZ8kjNiywv9IBVTpDkf9tC8kfCKwl4kfY/o+Q+ZlQIP/eJe191ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644241912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9xA7eYVT5M2/VrmaYV4cA9B4eqyznJsTf6TVyU7AcS8=;
        b=asLlUO5ldIeUUn2Esj//SUK2wuF1dNGufi9ZvYo71KvmKyj026bfUSxr0tmEBJV+z3wi/w
        YsgymR6bRh91nFDw==
From:   "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix list corruption in perf_cgroup_switch()
Cc:     Song Liu <song@kernel.org>, Rik van Riel <riel@surriel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220204004057.2961252-1-song@kernel.org>
References: <20220204004057.2961252-1-song@kernel.org>
MIME-Version: 1.0
Message-ID: <164424191171.16921.7739193739267946142.tip-bot2@tip-bot2>
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

Commit-ID:     5f4e5ce638e6a490b976ade4a40017b40abb2da0
Gitweb:        https://git.kernel.org/tip/5f4e5ce638e6a490b976ade4a40017b40abb2da0
Author:        Song Liu <song@kernel.org>
AuthorDate:    Thu, 03 Feb 2022 16:40:57 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 06 Feb 2022 22:37:27 +01:00

perf: Fix list corruption in perf_cgroup_switch()

There's list corruption on cgrp_cpuctx_list. This happens on the
following path:

  perf_cgroup_switch: list_for_each_entry(cgrp_cpuctx_list)
      cpu_ctx_sched_in
         ctx_sched_in
            ctx_pinned_sched_in
              merge_sched_in
                  perf_cgroup_event_disable: remove the event from the list

Use list_for_each_entry_safe() to allow removing an entry during
iteration.

Fixes: 058fe1c0440e ("perf/core: Make cgroup switch visit only cpuctxs with cgroup events")
Signed-off-by: Song Liu <song@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220204004057.2961252-1-song@kernel.org
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57c7197..6859229 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -839,7 +839,7 @@ static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
  */
 static void perf_cgroup_switch(struct task_struct *task, int mode)
 {
-	struct perf_cpu_context *cpuctx;
+	struct perf_cpu_context *cpuctx, *tmp;
 	struct list_head *list;
 	unsigned long flags;
 
@@ -850,7 +850,7 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 	local_irq_save(flags);
 
 	list = this_cpu_ptr(&cgrp_cpuctx_list);
-	list_for_each_entry(cpuctx, list, cgrp_cpuctx_entry) {
+	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
 		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
 
 		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
