Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E599E513EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353049AbiD1Wxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353040AbiD1Wxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFEEBE0C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651186223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=21r3A+a97qIjMQ0EcHn0xJlRdWWTFjCaN7Ewqfu8RvI=;
        b=GXgboNJ6g4n8LkG4lW0b1aNWqgcVxcrB5n4N3mVxn4Ws9zwOsMe/Q+3VgLNjosrgqqhXCc
        mlxD9Ovv+Fag4/vHunZi/m3Q8FO/mWB51T0n2dtVNeufJY0uueMt8zTh8xCG8guwvjZV0R
        dLJMcleDNn4UooA+Ro9RIcpa/izCtXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-Yga_bl7UMtGVW5CD2aBAng-1; Thu, 28 Apr 2022 18:50:14 -0400
X-MC-Unique: Yga_bl7UMtGVW5CD2aBAng-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 902ED86B8A3;
        Thu, 28 Apr 2022 22:50:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id 783765E1A38;
        Thu, 28 Apr 2022 22:50:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 29 Apr 2022 00:50:13 +0200 (CEST)
Date:   Fri, 29 Apr 2022 00:50:09 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
Message-ID: <20220428225008.GH15485@redhat.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <20220425174719.GB12412@redhat.com>
 <8735hzcr18.fsf@email.froward.int.ebiederm.org>
 <Ymr5Ga3gcqG4ZAMt@hirez.programming.kicks-ass.net>
 <20220428205956.GG15485@redhat.com>
 <YmsTd4FiAXjsFegE@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmsTd4FiAXjsFegE@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, you know, it is very difficult to me to discuss the changes
in the 2 unfinished series and not loose the context ;) Plus I am
already sleeping. But I'll try to reply anyway.

On 04/29, Peter Zijlstra wrote:
>
> On Thu, Apr 28, 2022 at 10:59:57PM +0200, Oleg Nesterov wrote:
> > If it is on top of JOBCTL_TRACED/DELAY_WAKEKILL changes (yours or Eric's),
> > then it can't help - SIGKILL can come right after the tracee drops siglock
> > and calls schedule().
>
> But by that time it will already have set TRACED and signal_wake_up()
> wil clear it, no?

No. JOBCTL_DELAY_WAKEKILL is already set, this means that signal_wake_up()
will remove TASK_WAKEKILL from the "state" passed to signal_wake_up_state()
and this is fine and correct, this mean thats ttwu() won't change ->__state.

But this also mean that wake_up_state() will return false, and in this case

	signal_wake_up_state:

		if (wake_up_state(t, state | TASK_INTERRUPTIBLE))
			t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED | JOBCTL_TRACED_QUIESCE);

won't clear these flags. And this is nice too.

But. fatal_signal_pending() is true! And once we change freeze_traced()
to not abuse p->__state, schedule() won't block because it will check
signal_pending_state(TASK_TRACED == TASK_WAKEKILL | __TASK_TRACED) and
__fatal_signal_pending() == T.

In this case ptrace_stop() will leak JOBCTL_TRACED, so we simply need
to clear it before return along with LISTENING | DELAY_WAKEKILL.

> I'll go
> over it all again in the morning, perhaps I'll reach a different
> conclusion :-)

Same here ;)

Oleg.

