Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A146C533F47
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244849AbiEYOdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244853AbiEYOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1ADEA88A1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653489207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9TKWXPVOyy27jggL+/cJXYJRt9uEdXRrwGp2as9PzGY=;
        b=PgOLgZk1zDCjho1yLJGQZDGxT/cT5s+ZWvASufOr6AbI7RKeMjPNUsbVeU+8qItK00WB9c
        rDUCJ2wZleC+grwv6zXCAWMexJyZvpf9I1D/vSpTSOKXcl38DXP3HJhgMCrV8RX8VliApu
        bUyb0wxYII1e/zvIjnV/Y2sXiUX9GbM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-1WAZ6LSpP8WakQXx6X-awA-1; Wed, 25 May 2022 10:33:24 -0400
X-MC-Unique: 1WAZ6LSpP8WakQXx6X-awA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A921E858EFE;
        Wed, 25 May 2022 14:33:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id BC570112131B;
        Wed, 25 May 2022 14:33:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 May 2022 16:33:22 +0200 (CEST)
Date:   Wed, 25 May 2022 16:33:03 +0200
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
Message-ID: <20220525143303.GB2687@redhat.com>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <20220518225355.784371-5-ebiederm@xmission.com>
 <20220524114250.GB14347@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524114250.GB14347@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24, Oleg Nesterov wrote:
>
> Sorry for delay.
>
> On 05/18, Eric W. Biederman wrote:
> >
> > Ever since commit 28d838cc4dfe ("Fix ptrace self-attach rule") it has
> > been impossible to attach another thread in the same thread group.
> >
> > Remove the code from __ptrace_detach that was trying to support
> > detaching from a thread in the same thread group.
>
> may be I am totally confused, but I think you misunderstood this code
> and thus this patch is very wrong.
>
> The same_thread_group() check does NOT try to check if debugger and
> tracee is in the same thread group, this is indeed impossible.
>
> We need this check to know if the tracee was ptrace_reparented() before
> __ptrace_unlink() or not.
>
>
> > -static int ignoring_children(struct sighand_struct *sigh)
> > -{
> > -	int ret;
> > -	spin_lock(&sigh->siglock);
> > -	ret = (sigh->action[SIGCHLD-1].sa.sa_handler == SIG_IGN) ||
> > -	      (sigh->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT);
> > -	spin_unlock(&sigh->siglock);
> > -	return ret;
> > -}
>
> ...
>
> > @@ -565,14 +552,9 @@ static bool __ptrace_detach(struct task_struct *tracer, struct task_struct *p)
> >
> >  	dead = !thread_group_leader(p);
> >
> > -	if (!dead && thread_group_empty(p)) {
> > -		if (!same_thread_group(p->real_parent, tracer))
> > -			dead = do_notify_parent(p, p->exit_signal);
> > -		else if (ignoring_children(tracer->sighand)) {
> > -			__wake_up_parent(p, tracer);
> > -			dead = true;
> > -		}
> > -	}
>
> So the code above does:
>
> 	- if !same_thread_group(p->real_parent, tracer), then the tracee was
> 	  ptrace_reparented(), and now we need to notify its natural parent
> 	  to let it know it has a zombie child.
>
> 	- otherwise, the tracee is our natural child, and it is actually dead.
> 	  however, since we are going to reap this task, we need to wake up our
> 	  sub-threads possibly sleeping on ->wait_chldexit wait_queue_head_t.
>
> See?
>
> > +	if (!dead && thread_group_empty(p))
> > +		dead = do_notify_parent(p, p->exit_signal);
>
> No, this looks wrong. Or I missed something?

Yes, but...

That said, it seems that we do not need __wake_up_parent() if it was our
natural child?

I'll recheck. Eric, I'll continue to read this series tomorrow, can't
concentrate on ptrace today.

Oleg.

