Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E9759BECE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiHVLsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiHVLsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:48:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123B320E;
        Mon, 22 Aug 2022 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YcH+L5yEug/0XCeHzWALjCRJa/mQAgz+/LGeuzUWwe4=; b=v9y7DX7/djXOtzPPySn/LRZ83a
        g1Wa0P4etH9Eg6J8m/I+dZdutFhV8+ozo6vzHim+GKFY1Vki5AzjL3nhRYcFwmfuYK2qTVRk3Lz7e
        qf/3IlriN18KOdMfHzjiuUukBk4/OkIk8N056XOT4HjgX9/+N4DrUYRqG+gC+AFxQcexRMdykQ+Nb
        sXWX/y5I0VRwmL7o4f40Cm8yJBVrInf8ZwhE/QGziT3gmgykqI51NkptyZGfcTpvgdZ7OUblCP55p
        dHNYo4iVwBMVhvLKxJPYTm8qFFtjHklz/HG8mHRpGrn+gaeacYPZAbq18W9eJEZtd0jE80B3XvTXM
        uEtBXQSw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ5uM-00EEes-0o; Mon, 22 Aug 2022 11:47:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD55E300859;
        Mon, 22 Aug 2022 13:47:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9268E20187A65; Mon, 22 Aug 2022 13:47:50 +0200 (CEST)
Message-ID: <20220822114648.856734578@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Aug 2022 13:18:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 3/6] sched: Change wait_task_inactive()s match_state
References: <20220822111816.760285417@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make wait_task_inactive()'s @match_state work like ttwu()'s @state.

That is, instead of an equal comparison, use it as a mask. This allows
matching multiple block conditions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3295,7 +3295,7 @@ unsigned long wait_task_inactive(struct
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
+			if (match_state && !(READ_ONCE(p->__state) & match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3310,7 +3310,7 @@ unsigned long wait_task_inactive(struct
 		running = task_running(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || READ_ONCE(p->__state) == match_state)
+		if (!match_state || (READ_ONCE(p->__state) & match_state))
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 


