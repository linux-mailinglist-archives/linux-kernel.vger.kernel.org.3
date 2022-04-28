Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4FB513BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiD1S4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiD1S4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24225B53F8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651172000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSgLveFDCQt97fdY0v/KXXdMC87h+iGQQ3KjG9Dmh38=;
        b=GsiFS9lxDa7nP2CQfk5FxrBp061Bu0lowO7Y4vXiqkNf7nIdKruCjo5XGhwngvXj1OvBM8
        QLSlsDgJOVbe2y/8y5eywfBd6sEcJs4dF93lmumxrEQGVZnrNjEbD0Ya1VWew9UvAcB+Ql
        i1FyIYmhnqT2iv/YqQ4y/UAHxUOYC40=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-_yFZ8gkLNFqQdtiQkAf15A-1; Thu, 28 Apr 2022 14:53:18 -0400
X-MC-Unique: _yFZ8gkLNFqQdtiQkAf15A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9D633C0CD50;
        Thu, 28 Apr 2022 18:53:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.151])
        by smtp.corp.redhat.com (Postfix) with SMTP id DAEE314A5060;
        Thu, 28 Apr 2022 18:53:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 Apr 2022 20:53:17 +0200 (CEST)
Date:   Thu, 28 Apr 2022 20:53:11 +0200
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
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
Message-ID: <20220428185311.GF15485@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-9-ebiederm@xmission.com>
 <87czh2160k.fsf@email.froward.int.ebiederm.org>
 <20220428151110.GB15485@redhat.com>
 <875ymtywxg.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ymtywxg.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> >> The bug appears when the TRACEE makes it to schedule().  Inside
> >> schedule there is a call to signal_pending_state() which notices
> >> a SIGKILL is pending and refuses to sleep.
> >
> > And I think this is fine. This doesn't really differ from the case
> > when the tracee was killed before it takes siglock.
>
> Hmm.  Maybe.

I hope ;)

> Previously we were actually guaranteed in ptrace_check_attach that after
> ptrace_freeze_traced would succeed as any pending fatal signal would
> cause ptrace_freeze_traced to fail.  Any incoming fatal signal would not
> stop schedule from sleeping.

Yes.

So let me repeat, 7/9 "ptrace: Simplify the wait_task_inactive call in
ptrace_check_attach" looks good to me (except it should use
wait_task_inactive(__TASK_TRACED)), but it should come before other
meaningfull changes and the changelog should be updated.

And then we will probably need to reconsider this wait_task_inactive()
and WARN_ON() around it, but depends on what will we finally do.

> I think in my tired mind yesterday

I got lost too ;)

> Still I would like to be able to
> let wait_task_inactive not care about the state of the process it is
> going to sleep for.

Not sure... but to be honest I didn't really pay attention to the
wait_task_inactive(match_state => 0) part...

Oleg.

