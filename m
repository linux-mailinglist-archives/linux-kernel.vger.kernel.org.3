Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F45137DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348888AbiD1POk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348757AbiD1POh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CB5965D22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651158682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oLKNKGr8DCgjevzFl33k7TMRU8EM/aNPYmQT5R2S5w8=;
        b=UbgFSNqncYGJUmuLeDpMMUN1CLTAWQc69dv44n8yh3a+FVTiNOsldZisWi4ZySUYmBdJxS
        g1STj1/ZMyX/UK/Ld/fkzO6XwtKnDCpMZio4zmHYEVCf61u5BrHDUTJfM+HJqxFR60KoRM
        xBrTHgGro0+0bMEAsIH6A+usAN4GwcU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-N8lcjA7HMeetaX_6BRAbgw-1; Thu, 28 Apr 2022 11:11:18 -0400
X-MC-Unique: N8lcjA7HMeetaX_6BRAbgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB1D81014A67;
        Thu, 28 Apr 2022 15:11:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.151])
        by smtp.corp.redhat.com (Postfix) with SMTP id CBFF2414A7E7;
        Thu, 28 Apr 2022 15:11:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 Apr 2022 17:11:17 +0200 (CEST)
Date:   Thu, 28 Apr 2022 17:11:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
Message-ID: <20220428151110.GB15485@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-9-ebiederm@xmission.com>
 <87czh2160k.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czh2160k.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27, Eric W. Biederman wrote:
>
> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
> > diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> > index 3c8b34876744..1947c85aa9d9 100644
> > --- a/include/linux/sched/signal.h
> > +++ b/include/linux/sched/signal.h
> > @@ -437,7 +437,8 @@ extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
> >
> >  static inline void signal_wake_up(struct task_struct *t, bool resume)
> >  {
> > -	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
> > +	bool wakekill = resume && !(t->jobctl & JOBCTL_DELAY_WAKEKILL);
> > +	signal_wake_up_state(t, wakekill ? TASK_WAKEKILL : 0);
> >  }
> >  static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
> >  {
>
> Grrr.  While looking through everything today I have realized that there
> is a bug.
>
> Suppose we have 3 processes: TRACER, TRACEE, KILLER.
>
> Meanwhile TRACEE is in the middle of ptrace_stop, just after siglock has
> been dropped.
>
> The TRACER process has performed ptrace_attach on TRACEE and is in the
> middle of a ptrace operation and has just set JOBCTL_DELAY_WAKEKILL.
>
> Then comes in the KILLER process and sends the TRACEE a SIGKILL.
> The TRACEE __state remains TASK_TRACED, as designed.
>
> The bug appears when the TRACEE makes it to schedule().  Inside
> schedule there is a call to signal_pending_state() which notices
> a SIGKILL is pending and refuses to sleep.

And I think this is fine. This doesn't really differ from the case
when the tracee was killed before it takes siglock.

The only problem (afaics) is that, once we introduce JOBCTL_TRACED,
ptrace_stop() can leak this flag. That is why I suggested to clear
it along with LISTENING/DELAY_WAKEKILL before return, exactly because
schedule() won't block if fatal_signal_pending() is true.

But may be I misunderstood you concern?

Oleg.

