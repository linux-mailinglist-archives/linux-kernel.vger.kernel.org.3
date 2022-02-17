Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716404BA90C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244802AbiBQS5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:57:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244731AbiBQS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:57:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171EF5DE56;
        Thu, 17 Feb 2022 10:56:57 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pj+t/szV/wvVKUAhST9b8qaxSk39ql6cDwFmn94Bxdo=;
        b=aLFaq4AOOMYNpmUdANedEvX9heT1LWyevLoLkQZLrGIsvw22fwPMhBdeErs83280Opk2KG
        ykNLgc7lF1Oz8ShX7mRFzSL50ErhyfAMNxmEi8nq/joKLRT+/XWQgLCEsxcVGkS/pVwc7R
        qV568eQ7oyU3asScheJ6i6QoBmQgLU6n5LpFxbKPgRwFFhmau6K0rZVOcNlIvm1OUgQCVB
        rqFN50jt1z6rPksZH728eWkGC9BPiAVYUA2D3QGPuDsYGXNssm9VDwE2QAgFZagYxbBDEH
        PphhQWIHArSx+p0TUMyqlvMx4UNwPWKGAB6sr5+kGBYx1Jcnb2pWY/M+oWwooA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pj+t/szV/wvVKUAhST9b8qaxSk39ql6cDwFmn94Bxdo=;
        b=P04Rv/nS2aCDA1a6uwDg2QyODdRL/+UsmgLPNvhtHz0X26JCkrhGSFgMh7GqpcmYslo80j
        x5py/bNg11pCcvBQ==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: replace cpumask_weight with cpumask_empty
 where appropriate
Cc:     Yury Norov <yury.norov@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220210224933.379149-23-yury.norov@gmail.com>
References: <20220210224933.379149-23-yury.norov@gmail.com>
MIME-Version: 1.0
Message-ID: <164512421465.16921.1322444581830816438.tip-bot2@tip-bot2>
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

Commit-ID:     1087ad4e3f88c474b8134a482720782922bf3fdf
Gitweb:        https://git.kernel.org/tip/1087ad4e3f88c474b8134a482720782922bf3fdf
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Thu, 10 Feb 2022 14:49:06 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:53 +01:00

sched: replace cpumask_weight with cpumask_empty where appropriate

In some places, kernel/sched code calls cpumask_weight() to check if
any bit of a given cpumask is set. We can do it more efficiently with
cpumask_empty() because cpumask_empty() stops traversing the cpumask as
soon as it finds first set bit, while cpumask_weight() counts all bits
unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220210224933.379149-23-yury.norov@gmail.com
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1d863d7..c620aab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8708,7 +8708,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 {
 	int ret = 1;
 
-	if (!cpumask_weight(cur))
+	if (cpumask_empty(cur))
 		return ret;
 
 	ret = dl_cpuset_cpumask_can_shrink(cur, trial);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e6cd559..1c84b48 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -74,7 +74,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 			break;
 		}
 
-		if (!cpumask_weight(sched_group_span(group))) {
+		if (cpumask_empty(sched_group_span(group))) {
 			printk(KERN_CONT "\n");
 			printk(KERN_ERR "ERROR: empty group\n");
 			break;
