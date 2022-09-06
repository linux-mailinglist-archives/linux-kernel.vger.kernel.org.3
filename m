Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7935AE632
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiIFLJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiIFLJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:09:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A03A786F2;
        Tue,  6 Sep 2022 04:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yu++D7bkwQQG7Ub1mrE07B0EAGlCE5py7JaXbH+mhJw=; b=sR6D0hXfShKppvkpMLrnuompUC
        RgRPtpmq3G4lbied5m37KPvfxBqAdA23fu6T7xh6T31qXLK9aff5Vsv46swV1wuT0zZHsissyxXEZ
        kolaxgCtQotofCyiAoqy+RluTQ8ul8XCWF/ib0E5mT/jo5vsJ6/gxUjOo4J5IAJFAQZJHB9pAb+00
        Mi7x69NCb4tZ040mRSed/zS8YVwGRloeskz4XTTjJomJi76bmIL3ELiUG09/S96C+k8jGqKE8lvy6
        Ifn4InpU31Gqe5s0SZECKy5qNwzln+B1AyE66QyEDrl2VJYCs0QEDWSGsEAutFCTied/TscWZHWwL
        YELDWlow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVWRt-00AL2i-QQ; Tue, 06 Sep 2022 11:08:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CC58300348;
        Tue,  6 Sep 2022 13:08:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69A8F2B662EE3; Tue,  6 Sep 2022 13:08:55 +0200 (CEST)
Date:   Tue, 6 Sep 2022 13:08:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] sched/wait: Add wait_event_state()
Message-ID: <YxcqR/hSTwLnk3RK@hirez.programming.kicks-ass.net>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.989212021@infradead.org>
 <YxR18Qs8vqTpPFV5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxR18Qs8vqTpPFV5@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 11:54:57AM +0200, Ingo Molnar wrote:
> > +/**
> > + * wait_event_state - sleep until a condition gets true
> > + * @wq_head: the waitqueue to wait on
> > + * @condition: a C expression for the event to wait for
> > + * @state: state to sleep in
> > + *
> > + * The process is put to sleep (@state) until the @condition evaluates to true
> > + * or a signal is received.  The @condition is checked each time the waitqueue
> > + * @wq_head is woken up.
> 
> Documentation inconsistency nit: if TASK_INTERRUPTIBLE isn't in @state then 
> we won't wake up when a signal is received. This probably got copy-pasted 
> from a signal variant.
> 
> > + *
> > + * wake_up() has to be called after changing any variable that could
> > + * change the result of the wait condition.
> > + *
> > + * The function will return -ERESTARTSYS if it was interrupted by a
> > + * signal and 0 if @condition evaluated to true.
> 
> That's not unconditionally true either if !TASK_INTERRUPTIBLE.


--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -942,14 +942,14 @@ extern int do_wait_intr_irq(wait_queue_h
  * @state: state to sleep in
  *
  * The process is put to sleep (@state) until the @condition evaluates to true
- * or a signal is received.  The @condition is checked each time the waitqueue
- * @wq_head is woken up.
+ * or a signal is received (when allowed by @state).  The @condition is checked
+ * each time the waitqueue @wq_head is woken up.
  *
  * wake_up() has to be called after changing any variable that could
  * change the result of the wait condition.
  *
- * The function will return -ERESTARTSYS if it was interrupted by a
- * signal and 0 if @condition evaluated to true.
+ * The function will return -ERESTARTSYS if it was interrupted by a signal
+ * (when allowed by @state) and 0 if @condition evaluated to true.
  */
 #define wait_event_state(wq_head, condition, state)				\
 ({										\


> > +#define wait_event_state(wq_head, condition, state)				\
> > +({										\
> > +	int __ret = 0;								\
> > +	might_sleep();								\
> 
> Very small style consistency nit, the above should have a newline after 
> local variables:
> 
> > +#define wait_event_state(wq_head, condition, state)				\
> > +({										\
> > +	int __ret = 0;								\
> > +                                                                             \
> > +	might_sleep();								\
> 
> Like most (but not all ... :-/ ) of the existing primitives have.

Yeah, I'm going to leave it as is.
