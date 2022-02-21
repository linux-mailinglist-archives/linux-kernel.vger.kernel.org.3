Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074F84BEB0A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiBUSwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:52:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiBUSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:51:40 -0500
Received: from mail1.wrs.com (unknown-3-146.windriver.com [147.11.3.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81451D7C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:51:16 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 21LIKXlI027173
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Feb 2022 10:20:34 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 21 Feb 2022 10:20:33 -0800
Received: from yow-pgortmak-d4.wrs.com (128.224.56.60) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Mon, 21 Feb 2022 10:20:31 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/2] sched/nohz: disallow non-existent cores from nohz-full
Date:   Mon, 21 Feb 2022 13:20:07 -0500
Message-ID: <20220221182009.1283-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rebase and retest of two fixes I'd sent earlier[1].

The rebase is required due to conflicts in my patch #1 and where Frederic updated
the unwind code in housekeeping_setup in his series[2] and that series is now
in sched/core of tip[3].

So this update is against a baseline of ed3b362d54f0 found in sched/core as
"sched/isolation: Split housekeeping cpumask per isolation features" in tip.

Changes amount to "return 0" ---> "goto out_free" and adding a nod to PaulM's
observation that nohz_full w/o a cpuset is coming someday into the commit log.

[1] https://lore.kernel.org/all/20211206145950.10927-1-paul.gortmaker@windriver.com/
[2] https://lore.kernel.org/all/20220207155910.527133-1-frederic@kernel.org/
[3] git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

 ----- Original v1 text follows ----- 

A couple months back I sent a fix to reconcile rcu_nocbs= input
restrictions with nohz_full= input restrictions; with the latter being
more restrictive than the former.

However, in relaxing the nohz_full restrictions, I made it possible to
boot with a nohz_full= parameter that contains nothing but nonexistent
and not-possible cores - which will trigger a WARN.

This fixes the original reconcile commit by explicitly coding our
allowed values just like RCU does, and changes the WARN_ON to a
WARN_ON_ONCE, since it needlessly rendered the machine unusable.

---

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

Paul Gortmaker (2):
  sched/isolation: really align nohz_full with rcu_nocbs
  tick/nohz: WARN_ON --> WARN_ON_ONCE to prevent console saturation

 kernel/sched/isolation.c | 11 +++++++++++
 kernel/time/tick-sched.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.17.1

