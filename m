Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3572651396E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349797AbiD1QNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiD1QNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:13:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0317B11C03;
        Thu, 28 Apr 2022 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lg8SqQYCcNFGIKioQXjUK2uICLPTc1JMobWkPo+n0W8=; b=QQjuN2cWLD2QjLNCxlFpCNSYOl
        YgRRXme+rrRbihUv5AuBfn2TfzHJpmudJquvxC9wp5DQY5QDZQHKbkPIfonWw0z87lTFSmXRdWC8G
        bkZT9F5/eR7ZPuf1TEFCOkDAXUIItjikmTOyUkrUPPMzP9A5Lf7e2jR6pMb4G6LoIGv1+cSvGBQRJ
        dzsIyjuSiQH6/mwgYkbuuNHfDTTbkiPgHkXbMZ/HoHrPHumFj7hx1S9jlN/Cybv9c5cguOGbxGzWs
        8Ewx4M5gL3u7LRkeMltPCf2/4nLnDNUrqA7h18kF/NAW/6AWB9h5pPsT3wRbV2+Na0gfBJ2XRxDjc
        C+RNX82Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk6iK-009Muv-UM; Thu, 28 Apr 2022 16:09:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0AB7D30031D;
        Thu, 28 Apr 2022 18:09:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF3592029F886; Thu, 28 Apr 2022 18:09:53 +0200 (CEST)
Date:   Thu, 28 Apr 2022 18:09:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 7/9] ptrace: Simplify the wait_task_inactive call in
 ptrace_check_attach
Message-ID: <Ymq8UafDbJEjSoB0@hirez.programming.kicks-ass.net>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-7-ebiederm@xmission.com>
 <20220427151455.GE17421@redhat.com>
 <Ympvf1Pam1ckX+EA@hirez.programming.kicks-ass.net>
 <20220428111911.GA3804@redhat.com>
 <YmqckaB+xB6azP1d@hirez.programming.kicks-ass.net>
 <20220428145750.GA15485@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428145750.GA15485@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 04:57:50PM +0200, Oleg Nesterov wrote:

> > Shouldn't we then switch wait_task_inactive() so have & matching instead
> > of the current ==.
> 
> Sorry, I don't understand the context...

This.. I've always found it strange to have wti use a different matching
scheme from ttwu.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f259621f4c93..c039aef4c8fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3304,7 +3304,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
+			if (match_state && unlikely(!(READ_ONCE(p->__state) & match_state)))
 				return 0;
 			cpu_relax();
 		}
@@ -3319,7 +3319,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		running = task_running(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || READ_ONCE(p->__state) == match_state)
+		if (!match_state || (READ_ONCE(p->__state) & match_state))
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
