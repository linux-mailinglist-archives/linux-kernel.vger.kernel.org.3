Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1684E3A09
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiCVIES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiCVIEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:04:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD545A5AC;
        Tue, 22 Mar 2022 01:02:48 -0700 (PDT)
Date:   Tue, 22 Mar 2022 08:02:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647936166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zC0KMgmR8oZmeDTsp0o5snXk5OZvrD4+E+WJEQEL2lM=;
        b=weYR9844Ovn/YQAU5MiheVXb0GiSNSd+6KUcT2O7TYOASMk+2GvcJEt97j37VWJ4ZNsRaR
        ltyv6zKJbGy9pqrSWVVDGl60hADE1zTnO1epER4s/m3x0Ay86jvMPdvlf+5YqardqgUH6c
        iQks5vmL3MfSB5dNBWYW23p+RfYhtzTFnjicnyg831R/Moiq89wQsxA0nwyNVgSruu97Kl
        cgwf/lyqFVgX3CywEkevPTPHIZ+UAiiFbDHC5zBh70DwLRATyOeG3oMbuEEgokRxQS55br
        hL1XxWKKgxmDT5LlgcLJAGIfX7NOrZ5wHcdMk+Etdd7wd8wK8UzuQlBL78D28A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647936166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zC0KMgmR8oZmeDTsp0o5snXk5OZvrD4+E+WJEQEL2lM=;
        b=oDvFMDpfyEmjxyLcabzaLyqCghHjL/XiqEUE2GP29BmBsSK1OReYVaCKD6cfUduQM8XAMA
        0QIFt6XAiQuGPnCA==
From:   "tip-bot2 for Huang, Ying" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Fix boot crash on arm64 systems
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164793616519.389.1981081124860525020.tip-bot2@tip-bot2>
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

Commit-ID:     ab31c7fd2d37bc3580d9d712d5f2dfb69901fca9
Gitweb:        https://git.kernel.org/tip/ab31c7fd2d37bc3580d9d712d5f2dfb69901fca9
Author:        Huang, Ying <ying.huang@intel.com>
AuthorDate:    Tue, 22 Mar 2022 08:39:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Mar 2022 08:49:22 +01:00

sched/numa: Fix boot crash on arm64 systems

Qian Cai reported a boot crash on arm64 systems, caused by:

  0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")

The bug is that node_state() must be supplied a valid node_states[] array index,
but in task_numa_placement() the max_nid search can fail with NUMA_NO_NODE,
which is not a valid index.

Fix it by checking that max_nid is a valid index.

[ mingo: Added changelog. ]

Fixes: 0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Tested-by: Qian Cai <quic_qiancai@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 89d21fd..ee0664c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2437,7 +2437,7 @@ static void task_numa_placement(struct task_struct *p)
 	}
 
 	/* Cannot migrate task to CPU-less node */
-	if (!node_state(max_nid, N_CPU)) {
+	if (max_nid != NUMA_NO_NODE && !node_state(max_nid, N_CPU)) {
 		int near_nid = max_nid;
 		int distance, near_distance = INT_MAX;
 
