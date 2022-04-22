Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A62450B50F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446618AbiDVKbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446559AbiDVKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:30:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D092A54BF8;
        Fri, 22 Apr 2022 03:27:48 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:27:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sVW4Ydvq15SqBx7hBnnP2C2IYNopzPTpKw8mHoiN8o=;
        b=FR3EJRYxI4HUPuVEc13RMYd9uZdGn1u5OEywLHag6cz8wljs7cP482fKC9Ix20u2RbVFES
        ixamZhqJir5VqUfgVmhsC8CjEcOaHU0i6vulMxw65Ukm+ziApTyjHwKpNLvjF+NWSwyRhU
        S2fWSWsEgXqIqGZwBP028e0u7he/kwsR980tlwZTrniUoC91UGYRPqJVeEO+RkpIO8Gp5u
        udFIk6CGEwLi7/StUCAOiOKlPJV5NGDXcXBb2BUytwqGVOEt+SAVwJWutiXA0KyZEkYzD6
        8Fl1QWRmUkXBYOtjKvI1nBPZ0zk1Y7n2248DHp+aJSPXU+z6tV/WgIKjLBHIEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sVW4Ydvq15SqBx7hBnnP2C2IYNopzPTpKw8mHoiN8o=;
        b=2sdu2xsLu08GImbhNaQLg/Womt3RjHZkxaJZfMnDCpgEFyMVdDAquKs/XP45Kfq4jHZCpV
        u01oksQ6C0/TcgDg==
From:   "tip-bot2 for Hailong Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Fix trigger being fired unexpectedly at initial
Cc:     Hailong Liu <liuhailong@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1648789811-3788971-1-git-send-email-liuhailong@linux.alibaba.com>
References: <1648789811-3788971-1-git-send-email-liuhailong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <165062326638.4207.9400750130018944129.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     915a087e4c47334a2f7ba2a4092c4bade0873769
Gitweb:        https://git.kernel.org/tip/915a087e4c47334a2f7ba2a4092c4bade0873769
Author:        Hailong Liu <liuhailong@linux.alibaba.com>
AuthorDate:    Fri, 01 Apr 2022 13:10:11 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:14:06 +02:00

psi: Fix trigger being fired unexpectedly at initial

When a trigger being created, its win.start_value and win.start_time are
reset to zero. If group->total[PSI_POLL][t->state] has accumulated before,
this trigger will be fired unexpectedly in the next period, even if its
growth time does not reach its threshold.

So set the window of the new trigger to the current state value.

Signed-off-by: Hailong Liu <liuhailong@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Link: https://lore.kernel.org/r/1648789811-3788971-1-git-send-email-liuhailong@linux.alibaba.com
---
 kernel/sched/psi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a4fa3aa..5a49a8c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1117,7 +1117,8 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->state = state;
 	t->threshold = threshold_us * NSEC_PER_USEC;
 	t->win.size = window_us * NSEC_PER_USEC;
-	window_reset(&t->win, 0, 0, 0);
+	window_reset(&t->win, sched_clock(),
+			group->total[PSI_POLL][t->state], 0);
 
 	t->event = 0;
 	t->last_event_time = 0;
