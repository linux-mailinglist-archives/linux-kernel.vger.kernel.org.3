Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7884D2431
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350711AbiCHW0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiCHW0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:26:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F650583A3;
        Tue,  8 Mar 2022 14:25:22 -0800 (PST)
Date:   Tue, 08 Mar 2022 22:25:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646778320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDOCC6fJPsTkG+qvHEySw4J70C9xQqVLmfp1R+zQxdM=;
        b=QyNquRJCeKmWWi6OBjvcRijufrstVJIhWI0PIpqpwRoAChCYOkvRpykiZ8uYK0LfPsxmHC
        cQAsCZhk8I9zpsJ6IJQYeCG2AZ89PtqnTR9OK1ewvFpzu4yJCpdoQEZuf6vHlFRrrmd1vw
        0W3WVpalOIhWmm/ezx5Z52TiHa703LcZT6ujGMPpIGLvK5ZKo47XoiZjZshxf6QYjoyzty
        ntgHljM8niC1Gln6QscXGj4d7AROdNjSI/+CxFaygq8yJFEJsGWK9kgqhfItk5jVFZ6Mvu
        vQmJNuamEe56HfiPg+ZGOQze7KpltD+Ey0fRO1hat2478gHwZsmQYsnCRk6rzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646778320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDOCC6fJPsTkG+qvHEySw4J70C9xQqVLmfp1R+zQxdM=;
        b=V4TzrgnOZHpQjOT1bND1xkE7DrP1U1thMEtEKk2+YP29vmOBrS60rBb/S1aBiPVIx+B+wY
        W5+2BDMsg6F9YHBA==
From:   "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Remove redundant variable and fix
 incorrect type in build_sched_domains
Cc:     kernel test robot <lkp@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220218162743.1134-1-kprateek.nayak@amd.com>
References: <20220218162743.1134-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Message-ID: <164677831883.16921.2209475420454417488.tip-bot2@tip-bot2>
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

Commit-ID:     7f434dff76215af00c26ba6449eaa4738fe9e2ab
Gitweb:        https://git.kernel.org/tip/7f434dff76215af00c26ba6449eaa4738fe9e2ab
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Fri, 18 Feb 2022 21:57:43 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 16:08:40 +01:00

sched/topology: Remove redundant variable and fix incorrect type in build_sched_domains

While investigating the sparse warning reported by the LKP bot [1],
observed that we have a redundant variable "top" in the function
build_sched_domains that was introduced in the recent commit
e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance when
SD_NUMA spans multiple LLCs")

The existing variable "sd" suffices which allows us to remove the
redundant variable "top" while annotating the other variable "top_p"
with the "__rcu" annotation to silence the sparse warning.

[1] https://lore.kernel.org/lkml/202202170853.9vofgC3O-lkp@intel.com/

Fixes: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lore.kernel.org/r/20220218162743.1134-1-kprateek.nayak@amd.com
---
 kernel/sched/topology.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 32841c6..43f2899 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2291,7 +2291,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 
 			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
 			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
-				struct sched_domain *top, *top_p;
+				struct sched_domain __rcu *top_p;
 				unsigned int nr_llcs;
 
 				/*
@@ -2316,11 +2316,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 				sd->imb_numa_nr = imb;
 
 				/* Set span based on the first NUMA domain. */
-				top = sd;
-				top_p = top->parent;
+				top_p = sd->parent;
 				while (top_p && !(top_p->flags & SD_NUMA)) {
-					top = top->parent;
-					top_p = top->parent;
+					top_p = top_p->parent;
 				}
 				imb_span = top_p ? top_p->span_weight : sd->span_weight;
 			} else {
