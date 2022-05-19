Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EFB52D510
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbiESNuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbiESNrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:47:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B5B46B28
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=spFvWqpntAjyDIyQTuuju53IdKRla2N41ylF/wTFrBs=; b=Uwd124YOn/1UWMQ9pfsIjaHRgD
        r1J47bokiQmjgRiNdg22ytRK3cQ04t+q/vkAH7Tl8wtzrgIQWOTX3d2z1SmbF7ijt0VjtAneCXHuu
        K4ujhEmQEsiCj6NfpHCJ4TFAZ35un83XQS32gdqz/bp+YufNtfKJUt5UgVBv2biL73oaFyLzEbCd6
        mYR06XJaIqM7PcsVPKWnQIZ7As06GLkjElqUXM+hRN39wnYyk5BZ2ruKoXVzhMIsejYkNjlvygQxq
        Y+eKUATAOBCM4wyWwNm3IxgONvZP7MG9WkTzPCJ9PqsUZDDQA9sFBuLSAwGmLkzCv0CY85ZK1RUyF
        150H2/KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrgUe-0022LG-Jc; Thu, 19 May 2022 13:47:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2411D980E0B; Thu, 19 May 2022 15:47:06 +0200 (CEST)
Date:   Thu, 19 May 2022 15:47:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jing-Ting Wu <jing-ting.wu@mediatek.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, tglx@linutronix.de,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jonathan.JMChen@mediatek.com,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [Bug] Race condition between CPU hotplug off flow and
 __sched_setscheduler()
Message-ID: <20220519134706.GH2578@worktop.programming.kicks-ass.net>
References: <4a0aa13c99ffd6aea6426f83314aa2a91bc8933f.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a0aa13c99ffd6aea6426f83314aa2a91bc8933f.camel@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 08:53:15PM +0800, Jing-Ting Wu wrote:
> Hi all
> 
> 
> There is a race condition between CPU hotplug off flow and
> __sched_setscheduler(), which will cause hang-up in CPU hotplug off
> flow.

How easy can you reproduce; does the below hack make it better?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95bac3b094b3..f18ee22b29bc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4763,20 +4763,30 @@ struct callback_head balance_push_callback = {
 	.func = (void (*)(struct callback_head *))balance_push,
 };
 
-static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+static inline struct callback_head *
+__splice_balance_callbacks(struct rq *rq, bool foo)
 {
 	struct callback_head *head = rq->balance_callback;
 
 	lockdep_assert_rq_held(rq);
-	if (head)
-		rq->balance_callback = NULL;
+	if (head) {
+		if (foo && head == &balance_push_callback)
+			head = NULL;
+		else
+			rq->balance_callback = NULL;
+	}
 
 	return head;
 }
 
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	return __splice_balance_callbacks(rq, true);
+}
+
 static void __balance_callbacks(struct rq *rq)
 {
-	do_balance_callbacks(rq, splice_balance_callbacks(rq));
+	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
 
 static inline void balance_callbacks(struct rq *rq, struct callback_head *head)

