Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B03E4F377E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353053AbiDELNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbiDEIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:30:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB36C245B7;
        Tue,  5 Apr 2022 01:22:03 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:22:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649146922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+xUYv6gdZsjBlMimQWLTKtSrNhHai4I0pW5bOZsXo4=;
        b=o7a0WX1+82rPz7+R5wyQMyN3+HOr4Wz8RKw9ysNFrG2V4/gXB5JnAYrkH/Zt1Pi9F0zmwc
        GUlQ6ROOqYycGL2PUCJCoaBad7NzII8NZJsO+gErN3hVlneu8J67pwwp64tW0EqAre8WDD
        7hTu647GjwUr1glcwuI8VKPU3pgO8WEVc5rPuk4Xb//uDWZIk7+rRqoCUw+2evSOKlKhKK
        I2GcWs+mgTqGvXnWMD0XOl5+ZR0cVjegjTp4kN8NU0PBMsqztoqQ6ISB9PnKXUDd8oPs2X
        itBr3axY2d64RGTudrqgHFTx07wnJLMoiYCX2u921By3yCPthIENtkdWKe3BgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649146922;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+xUYv6gdZsjBlMimQWLTKtSrNhHai4I0pW5bOZsXo4=;
        b=SuCYPPCkjJFGlSdOxpigCfqddH5Qmj0Tzj8uylBk29udUPKWXbi41L7A3cCHdFWfEdupsy
        suz3BgVXaufUsxDw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Teach the forced-newidle balancer about
 CPU affinity limitation.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YjNK9El+3fzGmswf@linutronix.de>
References: <YjNK9El+3fzGmswf@linutronix.de>
MIME-Version: 1.0
Message-ID: <164914692120.389.11878203217805894208.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     386ef214c3c6ab111d05e1790e79475363abaa05
Gitweb:        https://git.kernel.org/tip/386ef214c3c6ab111d05e1790e79475363abaa05
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 17 Mar 2022 15:51:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:36 +02:00

sched: Teach the forced-newidle balancer about CPU affinity limitation.

try_steal_cookie() looks at task_struct::cpus_mask to decide if the
task could be moved to `this' CPU. It ignores that the task might be in
a migration disabled section while not on the CPU. In this case the task
must not be moved otherwise per-CPU assumption are broken.

Use is_cpu_allowed(), as suggested by Peter Zijlstra, to decide if the a
task can be moved.

Fixes: d2dfa17bc7de6 ("sched: Trivial forced-newidle balancer")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YjNK9El+3fzGmswf@linutronix.de
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 017ee78..51efaab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6006,7 +6006,7 @@ static bool try_steal_cookie(int this, int that)
 		if (p == src->core_pick || p == src->curr)
 			goto next;
 
-		if (!cpumask_test_cpu(this, &p->cpus_mask))
+		if (!is_cpu_allowed(p, this))
 			goto next;
 
 		if (p->core_occupation > dst->idle->core_occupation)
