Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82107521D48
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345288AbiEJPBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbiEJPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ACDB6B7C2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652192607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+S573656I/Ry3IV8BOR6MdvvHexB5xLndPCMThW4Hec=;
        b=DLB/SsUAQhxtPUmJkvigSLu8qBbDbSzIlV3/lDmm2aBbkvS5R4OSUxQWgj/Im5d6G34swJ
        qjt1FswvJiXBWXV/UWoDjuUkZ16H0bWCWK21tQZva1nzf3CmP2U5RZAJJ+FqlzIv6YfUTf
        /ElIi/FQsG8qRcTyJxcpHvmWItY69Sg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-e3vPlTW5NMShYGiJsluNNQ-1; Tue, 10 May 2022 10:23:24 -0400
X-MC-Unique: e3vPlTW5NMShYGiJsluNNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C58C3831C4C;
        Tue, 10 May 2022 14:23:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.98])
        by smtp.corp.redhat.com (Postfix) with SMTP id 10F38403D165;
        Tue, 10 May 2022 14:23:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 10 May 2022 16:23:22 +0200 (CEST)
Date:   Tue, 10 May 2022 16:23:18 +0200
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
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v4 10/12] ptrace: Don't change __state
Message-ID: <20220510142202.GB23277@redhat.com>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220505182645.497868-10-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505182645.497868-10-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05, Eric W. Biederman wrote:
>
>  static void ptrace_unfreeze_traced(struct task_struct *task)
>  {
> -	if (READ_ONCE(task->__state) != __TASK_TRACED)
> -		return;
> -
> -	WARN_ON(!task->ptrace || task->parent != current);
> +	unsigned long flags;
>  
>  	/*
> -	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
> -	 * Recheck state under the lock to close this race.
> +	 * The child may be awake and may have cleared
> +	 * JOBCTL_PTRACE_FROZEN (see ptrace_resume).  The child will
> +	 * not set JOBCTL_PTRACE_FROZEN or enter __TASK_TRACED anew.
>  	 */
> -	spin_lock_irq(&task->sighand->siglock);
> -	if (READ_ONCE(task->__state) == __TASK_TRACED) {
> +	if (lock_task_sighand(task, &flags)) {

But I still think that a lockless

	if (!(task->jobctl & JOBCTL_PTRACE_FROZEN))
		return;

check at the start of ptrace_unfreeze_traced() makes sense to avoid
lock_task_sighand() if possible.

And ptrace_resume() can probably clear JOBCTL_PTRACE_FROZEN along with
JOBCTL_TRACED to make this optimization work better. The same for
ptrace_signal_wake_up().

Oleg.

