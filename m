Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A495882D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiHBTur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiHBTup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:50:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F7913F24;
        Tue,  2 Aug 2022 12:50:44 -0700 (PDT)
Date:   Tue, 02 Aug 2022 19:50:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659469841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WbydiD59EY0s4CYP7LwTpVU/3s7lkYvlJnK1ItKcre8=;
        b=Wrk7QsAiPv/du052Da2PsWto9098zQQEKRVx/AvwKr0/Ch71tnDh1WnPbO8NeSN6KAqnyo
        dZgqiBIkT66v4XGQ64+0+k6aYDLbfkDAP8Do21WTqqPVpFQb0WVf7MGYqZStTV76xrDUlx
        eCL8LHfUp1pYj0UIyW4iTWZwrSCAiccqLM0BnfuHJKqK9WKLS+LB6bwJbcXZl21n386JoA
        OlCEoKmggJNQDtzsYqPLkGYcV1Z0JGtquvN8qjFraKU7KZNQtcTfIj/nEQcLhrCqw8Glbi
        Iv7GqXVrS7/Scx4zU6Xevsms81R9pwbdxYta/IhIycywKjHVYhIfc60v67RbaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659469841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WbydiD59EY0s4CYP7LwTpVU/3s7lkYvlJnK1ItKcre8=;
        b=n+iPboLTBvwVW7LJI94NzgyzF4aEcMPJQeJv6rlqhM3aozDcyo2TJyUuUtRQtfqmRVU3Rt
        5KoPLCG09UfWHlCg==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Print each field value left-aligned in
 sched_show_task()
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220727060819.1085-1-thunder.leizhen@huawei.com>
References: <20220727060819.1085-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <165946983999.15455.573652282122630497.tip-bot2@tip-bot2>
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

Commit-ID:     0f03d6805bfc454279169a1460abb3f6b3db317f
Gitweb:        https://git.kernel.org/tip/0f03d6805bfc454279169a1460abb3f6b3db317f
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 27 Jul 2022 14:08:19 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Aug 2022 21:45:35 +02:00

sched/debug: Print each field value left-aligned in sched_show_task()

Currently, the values of some fields are printed right-aligned, causing
the field value to be next to the next field name rather than next to its
own field name. So print each field value left-aligned, to make it more
readable.

 Before:
	stack:    0 pid:  307 ppid:     2 flags:0x00000008
 After:
	stack:0     pid:308   ppid:2      flags:0x0000000a

This also makes them print in the same style as the other two fields:

	task:demo0           state:R  running task

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20220727060819.1085-1-thunder.leizhen@huawei.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5555e49..6785e3b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8825,7 +8825,7 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
+	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
 		free, task_pid_nr(p), ppid,
 		read_task_thread_flags(p));
 
