Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2BD52DFA3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245366AbiESV5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiESV5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:57:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466F535250;
        Thu, 19 May 2022 14:57:09 -0700 (PDT)
Date:   Thu, 19 May 2022 21:57:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652997427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+T+amg6kgleAz3R7s9/Nr4n6n7tL5/g0yy6j/puf0o=;
        b=hZQp0zPGx+qJ6aWkHidFl8ZhaxYAwqxr7Cny74jlN9ZhB7gSBdOtzx0YqsB++7NPlQj+iz
        zgBT3BjgD8LkPeT7R+n/kgRY1Gt6f4n4qn0BG3B3zw8cxmF7pGC1f0DhNWRZnOUQNNA7fJ
        Z0fm/HIj3NS9kSF1Bhbs/WH/pNrPtkJoqC1tcSz63OyAcoxR2ERcnfkfYR2jh1WC1ngQY3
        BlzEXycqprGNt39/hT4fKvjRlrNkqrzfjOj/NAC6ZBsJsJplm9LnyIdU1HWvJsg5SMz8Be
        WIPv/+Mob33Fo3UZNuTwLldd4MVrFdgJlwtNdDdT0eeYZYXwQBCeONBQVOFkqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652997427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+T+amg6kgleAz3R7s9/Nr4n6n7tL5/g0yy6j/puf0o=;
        b=bnOnkfD38M0wv4ASFfug+ky140obQcPfkVb2hAxvDdLu/d+rfx9WPsIzZw/1g7ZpYQ32pA
        vgT05ewAnYNal8Bw==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] topology: Remove unused cpu_cluster_mask()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Barry Song <baohua@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220513093433.425163-1-dietmar.eggemann@arm.com>
References: <20220513093433.425163-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <165299742675.4207.9389624037232636288.tip-bot2@tip-bot2>
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

Commit-ID:     991d8d8142cad94f9c5c05db25e67fa83d6f772a
Gitweb:        https://git.kernel.org/tip/991d8d8142cad94f9c5c05db25e67fa83d6f772a
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Fri, 13 May 2022 11:34:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 May 2022 23:46:13 +02:00

topology: Remove unused cpu_cluster_mask()

default_topology[] uses cpu_clustergroup_mask() for the CLS level
(guarded by CONFIG_SCHED_CLUSTER) which is currently provided by x86
(arch/x86/kernel/smpboot.c) and arm64 (drivers/base/arch_topology.c).

Fixes: 778c558f49a2c ("sched: Add cluster scheduler level in core and
related Kconfig for ARM64")

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Barry Song <baohua@kernel.org>
Link: https://lore.kernel.org/r/20220513093433.425163-1-dietmar.eggemann@arm.com
---
 include/linux/topology.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index f19bc36..4564faa 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -240,13 +240,6 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
 }
 #endif
 
-#if defined(CONFIG_SCHED_CLUSTER) && !defined(cpu_cluster_mask)
-static inline const struct cpumask *cpu_cluster_mask(int cpu)
-{
-	return topology_cluster_cpumask(cpu);
-}
-#endif
-
 static inline const struct cpumask *cpu_cpu_mask(int cpu)
 {
 	return cpumask_of_node(cpu_to_node(cpu));
