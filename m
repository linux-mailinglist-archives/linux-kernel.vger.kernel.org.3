Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E26B4FB02E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbiDJUhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbiDJUh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:37:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4656C31;
        Sun, 10 Apr 2022 13:35:15 -0700 (PDT)
Date:   Sun, 10 Apr 2022 20:35:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649622914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3t40NLdDYvw3Dpwjzjb8Ib6K1WAHAfILhDYJdXKOTOY=;
        b=Q0DDCid2QfRe4Bn0oejethBQQQ0SnYyqaWrBdHtvvjh/fTpdwHA/QmkRqB59Uig2yHhOrv
        vRTuSnviJOefYHh1MwO3M6VLnITm+aIDXMzrrb3xQV8pWXSgsZ0WYcwuxquM05t5J9IGMw
        Zar02WHO0BSUXhdOlPPq+nv9q5rs4msRNDixpNOFkLfvQL/BhI69A1fy4MgDGHGjup8ytp
        PrYN+cG4nyY8454fIvwXOtB0jDXRmoG5YkgJk2v9H4Jyf/xtjIV8Q0mo/U0zv79ks5T9DK
        2gtL6U/klYUHQ/UAqGaRZj5HOpTS7N+CEGRLDOfL6wEGPISnkckohVVNmdAVOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649622914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3t40NLdDYvw3Dpwjzjb8Ib6K1WAHAfILhDYJdXKOTOY=;
        b=CzS8qnSnHdl4KlcxLipbVHSe38+9NiwRW2Sbl9IWRufOp5P2Ast+Aw591vCUX6dZCOD5ij
        7dCxyDM6/89P4TDw==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Replace cpumask_weight() with cpumask_empty()
Cc:     Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220210224933.379149-24-yury.norov@gmail.com>
References: <20220210224933.379149-24-yury.norov@gmail.com>
MIME-Version: 1.0
Message-ID: <164962291319.4207.17949067919284421483.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8afbcaf8690dac19ebf570a4e4fef9c59c75bf8e
Gitweb:        https://git.kernel.org/tip/8afbcaf8690dac19ebf570a4e4fef9c59c75bf8e
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Thu, 10 Feb 2022 14:49:07 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 22:30:04 +02:00

clocksource: Replace cpumask_weight() with cpumask_empty()

clocksource_verify_percpu() calls cpumask_weight() to check if any bit of a
given cpumask is set.

This can be done more efficiently with cpumask_empty() because
cpumask_empty() stops traversing the cpumask as soon as it finds first set
bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220210224933.379149-24-yury.norov@gmail.com

---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 95d7ca3..cee5da1 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -343,7 +343,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	cpus_read_lock();
 	preempt_disable();
 	clocksource_verify_choose_cpus();
-	if (cpumask_weight(&cpus_chosen) == 0) {
+	if (cpumask_empty(&cpus_chosen)) {
 		preempt_enable();
 		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
