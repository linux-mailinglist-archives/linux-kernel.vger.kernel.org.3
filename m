Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86C513E78
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352853AbiD1WXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiD1WXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:23:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CFABF33A;
        Thu, 28 Apr 2022 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qq72fPOyMsDMhllNPaD9/LDlbsltxPiZsmpBJxFx12M=; b=bgUEPOWf/Yyr5FFK4XBq2PNbDK
        ZnBnUnZTZnH4A0oi3zwtEYUXvg1bFxVDJ9djmpADklpVYxA0JUDGJYQ93B9Dej5Y19KcHfdIvzxye
        vt70+dpRdjYt0Au0M5wjcYQtU4SV8zlHEftwLoxd8buL6j/tBqzAlabZeeYpXDVkxyDme6aMo481f
        PaCW3/T+NIK7wiJbl5wI6Hu1qrxRviFOfLwIKotaGj9nwklwVNvKIqFgE7B1uIVKvNivA9P3l9f6o
        6nnvnAit53tlP6ZONb97iaa7gyJNlbnuQHONlrCwJ22CwYxC9TmeiufjLPDhuX0FYlos3+nl2oTJq
        PCd5j7Jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkCTl-009RWn-3g; Thu, 28 Apr 2022 22:19:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E78EB30040C;
        Fri, 29 Apr 2022 00:19:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A998B202961EB; Fri, 29 Apr 2022 00:19:14 +0200 (CEST)
Date:   Fri, 29 Apr 2022 00:19:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
Message-ID: <YmsS4pReIh6pVeWe@hirez.programming.kicks-ass.net>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-6-ebiederm@xmission.com>
 <20220427141018.GA17421@redhat.com>
 <874k2ea9q4.fsf@email.froward.int.ebiederm.org>
 <87zgk67fdd.fsf@email.froward.int.ebiederm.org>
 <YmrSijTc6HIv4sAG@hirez.programming.kicks-ass.net>
 <8735hxxddw.fsf@email.froward.int.ebiederm.org>
 <87ilqtvsqg.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilqtvsqg.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 03:49:11PM -0500, Eric W. Biederman wrote:

> static void lock_parents_siglocks(bool lock_tracer)
> 	__releases(&current->sighand->siglock)
> 	__acquires(&current->sighand->siglock)
> 	__acquires(&current->real_parent->sighand->siglock)
> 	__acquires(&current->parent->sighand->siglock)
> {
> 	struct task_struct *me = current;
> 	struct sighand_struct *m_sighand = me->sighand;
> 
> 	lockdep_assert_held(&m_sighand->siglock);
> 
> 	rcu_read_lock();
> 	for (;;) {
> 		struct task_struct *parent, *tracer;
> 		struct sighand_struct *p_sighand, *t_sighand, *s1, *s2, *s3;
> 
> 		parent = me->real_parent;
> 		tracer = lock_tracer? me->parent : parent;
> 
> 		p_sighand = rcu_dereference(parent->sighand);
> 		t_sighand = rcu_dereference(tracer->sighand);
> 
> 		/* Sort the sighands so that s1 >= s2 >= s3 */
> 		s1 = m_sighand;
> 		s2 = p_sighand;
> 		s3 = t_sighand;
> 		if (s1 > s2)
> 			swap(s1, s2);
> 		if (s1 > s3)
> 			swap(s1, s3);
> 		if (s2 > s3)
> 			swap(s2, s3);
> 
> 		if (s1 != m_sighand) {
> 			spin_unlock(&m_sighand->siglock);
> 			spin_lock(&s1->siglock);
> 		}
> 
> 		if (s1 != s2)
> 			spin_lock_nested(&s2->siglock, SIGLOCK_LOCK_SECOND);
> 		if (s2 != s3)
> 			spin_lock_nested(&s3->siglock, SIGLOCK_LOCK_THIRD);
> 

Might as well just use 1 and 2 for subclass at this point, or use
SIGLOCK_LOCK_FIRST below.

> 		if (likely((me->real_parent == parent) &&
> 			   (me->parent == tracer) &&
> 			   (parent->sighand == p_sighand) &&
> 			   (tracer->sighand == t_sighand))) {
> 			break;
> 		}
> 		spin_unlock(&p_sighand->siglock);
>                 if (t_sighand != p_sighand)
> 			spin_unlock(&t_sighand->siglock);

Indent fail above ^, also you likey need this:

		/*
		 * Since [pt]_sighand will likely change if we go
		 * around, and m_sighand is the only one held, make sure
		 * it is subclass-0, since the above 's1 != m_sighand'
		 * clause very much relies on that.
		 */
		lock_set_subclass(&m_sighand->siglock, 0, _RET_IP_);

> 		continue;
> 	}
> 	rcu_read_unlock();
> }
> 
> Eric
