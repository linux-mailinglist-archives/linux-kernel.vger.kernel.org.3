Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D12512073
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbiD0RYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244037AbiD0RYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BF7145AE4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651080083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MGbpkBAM5ckrE2XkacROVUw8iTojO8omojTbuiRlzq4=;
        b=ZjrALiIza1OEmkMI5mq57l/G5Enl4ervyIfK1ucuW60P2LpeBY8Vu9ZFMrgp1/l+ZuJAhW
        EoYyQcvQ/CbZug0FXRwcZkFHHh12CKvpy28+20FZoY06ysKrxXZ3Ek7kvW17YPOKZKKl8a
        XaeypmY1YZC9uwDC1NzJh/pqyoG07z8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-OGwoKz8ROxW-U8jIWnjSjw-1; Wed, 27 Apr 2022 13:21:17 -0400
X-MC-Unique: OGwoKz8ROxW-U8jIWnjSjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89F1E88B7BC;
        Wed, 27 Apr 2022 17:21:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9A5582024CB6;
        Wed, 27 Apr 2022 17:21:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Apr 2022 19:21:16 +0200 (CEST)
Date:   Wed, 27 Apr 2022 19:21:10 +0200
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
Message-ID: <20220427172109.GK17421@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-9-ebiederm@xmission.com>
 <20220427160901.GI17421@redhat.com>
 <87o80m7afv.fsf@email.froward.int.ebiederm.org>
 <20220427171829.GJ17421@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427171829.GJ17421@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27, Oleg Nesterov wrote:
>
> On 04/27, Eric W. Biederman wrote:
> >
> > Oleg Nesterov <oleg@redhat.com> writes:
> >
> > > On 04/26, Eric W. Biederman wrote:
> > >>
> > >> @@ -253,7 +252,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
> > >>  	 */
> > >>  	if (lock_task_sighand(child, &flags)) {
> > >>  		if (child->ptrace && child->parent == current) {
> > >> -			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
> > >> +			WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);
> > >
> > > This WARN_ON() doesn't look right.
> > >
> > > It is possible that this child was traced by another task and PTRACE_DETACH'ed,
> > > but it didn't clear DELAY_WAKEKILL.
> >
> > That would be a bug.  That would mean that PTRACE_DETACHED process can
> > not be SIGKILL'd.
>
> Why? The tracee will take siglock, clear JOBCTL_DELAY_WAKEKILL and notice
> SIGKILL after that.

Not to mention that the tracee is TASK_RUNNING after PTRACE_DETACH wakes it
up, so the pending JOBCTL_DELAY_WAKEKILL simply has no effect.

Oleg.

> > > If the new debugger attaches and calls ptrace() before the child takes siglock
> > > ptrace_freeze_traced() will fail, but we can hit this WARN_ON().
> > 
> > Eric
> > 

