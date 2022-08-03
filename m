Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2F6588968
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiHCJ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiHCJ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:28:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974595926C;
        Wed,  3 Aug 2022 02:28:37 -0700 (PDT)
Date:   Wed, 03 Aug 2022 09:28:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659518916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSSoAZX8HzRzKwMf0Giml1gMUyfKkPwjKeLro+vtYhk=;
        b=Zm6bXtenW5uMHxtFCW6r4LIMbd2Nxwp/sqTYQdYjcC4MifItf2zBdQ1KrwCC+4czGWunrl
        pAMpmLrksaNa5h8+OtgvmlnbYNhPx3lg8TXCi1K2sPpk09UsLtq8jl06qCF2Np0IW670rp
        sEefT+FVsft9xt1UYLzRgM/cU6J7XHNHK5MjoexeJK27n6ZOTc/IwyqlW1tb0K5qOzfGl5
        gCvSBHmzNdQ9rEMeMuYplSW5fhqP8ZTBOOHfD8hSSwRSX+MWhugciGalJKhWXsLF9MImIJ
        ZjggdBlsxkoDQ0K4a34/eajGQvYN205zbHyIgN/Y/ck493BbLCJEThx1BqqpnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659518916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSSoAZX8HzRzKwMf0Giml1gMUyfKkPwjKeLro+vtYhk=;
        b=d55MXswOMNPouJ0pUSzmCr4Sx+Ro3fQUxN222SbTB0r7GnqrxrbFpMF2dsKFt2WE7bDY+u
        h/rTKy5NcJ+iEtAw==
From:   "tip-bot2 for Ben Dooks" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt: Fix Sparse warnings due to undefined
 rt.c declarations
Cc:     Ben Dooks <ben-linux@fluff.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220721145155.358366-1-ben-linux@fluff.org>
References: <20220721145155.358366-1-ben-linux@fluff.org>
MIME-Version: 1.0
Message-ID: <165951891492.15455.12248825885512286794.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     87514b2c24f294c32e9e743b095541dcf43928f7
Gitweb:        https://git.kernel.org/tip/87514b2c24f294c32e9e743b095541dcf43928f7
Author:        Ben Dooks <ben-linux@fluff.org>
AuthorDate:    Thu, 21 Jul 2022 15:51:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Aug 2022 11:22:37 +02:00

sched/rt: Fix Sparse warnings due to undefined rt.c declarations

There are several symbols defined in kernel/sched/sched.h but get wrapped
in CONFIG_CGROUP_SCHED, even though dummy versions get built in rt.c and
therefore trigger Sparse warnings:

  kernel/sched/rt.c:309:6: warning: symbol 'unregister_rt_sched_group' was not declared. Should it be static?
  kernel/sched/rt.c:311:6: warning: symbol 'free_rt_sched_group' was not declared. Should it be static?
  kernel/sched/rt.c:313:5: warning: symbol 'alloc_rt_sched_group' was not declared. Should it be static?

Fix this by moving them outside the CONFIG_CGROUP_SCHED block.

[ mingo: Refreshed to the latest scheduler tree, tweaked changelog. ]

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220721145155.358366-1-ben-linux@fluff.org
---
 kernel/sched/sched.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aad7f5e..1429315 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -480,9 +480,6 @@ extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 
-extern void unregister_rt_sched_group(struct task_group *tg);
-extern void free_rt_sched_group(struct task_group *tg);
-extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent);
 extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 		struct sched_rt_entity *rt_se, int cpu,
 		struct sched_rt_entity *parent);
@@ -520,6 +517,10 @@ struct cfs_bandwidth { };
 
 #endif	/* CONFIG_CGROUP_SCHED */
 
+extern void unregister_rt_sched_group(struct task_group *tg);
+extern void free_rt_sched_group(struct task_group *tg);
+extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent);
+
 /*
  * u64_u32_load/u64_u32_store
  *
