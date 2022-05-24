Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1160F53299E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiEXLo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiEXLoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 179086D390
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653392604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IHHgKpKEE87xT5FBnMc3n1P6W5LoNANUXvj5TGZvIQM=;
        b=cFwTt+n6P1ZkljcBwBMYa/GzdCf3tcl3XqdL/sl7qg1/G4LDDwUUC53/cvAfez8h5TVff3
        DEekl0YkIXjvEv3OV8dl/4brLVedQbZT5x1jGPrwT/ZjyCANpobXvgH0fiuVyal8U/cvxr
        aSg2mkhMz3eB+ul+skRkIJnMHcR/3QQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-sIWWpxoEOGCkOZfNjlEHQg-1; Tue, 24 May 2022 07:43:16 -0400
X-MC-Unique: sIWWpxoEOGCkOZfNjlEHQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 693F9299E76E;
        Tue, 24 May 2022 11:43:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id 41A8E40869CB;
        Tue, 24 May 2022 11:42:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 24 May 2022 13:43:14 +0200 (CEST)
Date:   Tue, 24 May 2022 13:42:51 +0200
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
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 05/16] ptrace: Remove dead code from __ptrace_detach
Message-ID: <20220524114250.GB14347@redhat.com>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <20220518225355.784371-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518225355.784371-5-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for delay.

On 05/18, Eric W. Biederman wrote:
>
> Ever since commit 28d838cc4dfe ("Fix ptrace self-attach rule") it has
> been impossible to attach another thread in the same thread group.
>
> Remove the code from __ptrace_detach that was trying to support
> detaching from a thread in the same thread group.

may be I am totally confused, but I think you misunderstood this code
and thus this patch is very wrong.

The same_thread_group() check does NOT try to check if debugger and
tracee is in the same thread group, this is indeed impossible.

We need this check to know if the tracee was ptrace_reparented() before
__ptrace_unlink() or not.


> -static int ignoring_children(struct sighand_struct *sigh)
> -{
> -	int ret;
> -	spin_lock(&sigh->siglock);
> -	ret = (sigh->action[SIGCHLD-1].sa.sa_handler == SIG_IGN) ||
> -	      (sigh->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT);
> -	spin_unlock(&sigh->siglock);
> -	return ret;
> -}

...

> @@ -565,14 +552,9 @@ static bool __ptrace_detach(struct task_struct *tracer, struct task_struct *p)
>
>  	dead = !thread_group_leader(p);
>
> -	if (!dead && thread_group_empty(p)) {
> -		if (!same_thread_group(p->real_parent, tracer))
> -			dead = do_notify_parent(p, p->exit_signal);
> -		else if (ignoring_children(tracer->sighand)) {
> -			__wake_up_parent(p, tracer);
> -			dead = true;
> -		}
> -	}

So the code above does:

	- if !same_thread_group(p->real_parent, tracer), then the tracee was
	  ptrace_reparented(), and now we need to notify its natural parent
	  to let it know it has a zombie child.

	- otherwise, the tracee is our natural child, and it is actually dead.
	  however, since we are going to reap this task, we need to wake up our
	  sub-threads possibly sleeping on ->wait_chldexit wait_queue_head_t.

See?

> +	if (!dead && thread_group_empty(p))
> +		dead = do_notify_parent(p, p->exit_signal);

No, this looks wrong. Or I missed something?

Oleg.

