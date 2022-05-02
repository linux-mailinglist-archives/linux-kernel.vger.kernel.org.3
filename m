Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64134517300
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385927AbiEBPn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385918AbiEBPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D77913DED
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651505987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gLdcGhcmAyanfeuj2//xQhxqED3kPZibx0ll8qOzya8=;
        b=U2tfIKxJJ+I6TwkiqPHAcX/Hh39odtG5JJ+E4YjG7E5iwlONA+EXr+wJcGutp5+zmgYlWN
        lN5SJtd+rNLEORXR6l4LuRmW6gUITgFxk+d86EYO8H1afJM0//rHlIZMPIYsAsZFWACsMt
        5eSYJD5rYeeXgML+j8TUIgDxQn8ZTdc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-G0ULXuoRPiGOwDLnPT3Xkg-1; Mon, 02 May 2022 11:39:43 -0400
X-MC-Unique: G0ULXuoRPiGOwDLnPT3Xkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB58B185A7A4;
        Mon,  2 May 2022 15:39:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id B1D342166B41;
        Mon,  2 May 2022 15:39:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  2 May 2022 17:39:41 +0200 (CEST)
Date:   Mon, 2 May 2022 17:39:35 +0200
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
Subject: Re: [PATCH v2 07/12] ptrace: Don't change __state
Message-ID: <20220502153934.GD17276@redhat.com>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <20220429214837.386518-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429214837.386518-7-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29, Eric W. Biederman wrote:
>
> Stop playing with tsk->__state to remove TASK_WAKEKILL while a ptrace
> command is executing.

Eric, I'll read this patch and the rest of this series tomorrow.
Somehow I failed to force myself to read yet another version after
weekend ;)

plus I don't really understand this one...

>  #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
>  #define TASK_STOPPED			(TASK_WAKEKILL | __TASK_STOPPED)
> -#define TASK_TRACED			(TASK_WAKEKILL | __TASK_TRACED)
> +#define TASK_TRACED			__TASK_TRACED
...
>  static inline void signal_wake_up(struct task_struct *t, bool resume)
>  {
> -	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
> +	unsigned int state = 0;
> +	if (resume) {
> +		state = TASK_WAKEKILL;
> +		if (!(t->jobctl & JOBCTL_PTRACE_FROZEN))
> +			state |= __TASK_TRACED;
> +	}
> +	signal_wake_up_state(t, state);

Can't understand why is this better than the previous version which removed
TASK_WAKEKILL if resume... Looks a bit strange to me. But again, I didn't
look at the next patches yet.

> @@ -2209,11 +2209,8 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>  		spin_lock_irq(&current->sighand->siglock);
>  	}
>
> -	/*
> -	 * schedule() will not sleep if there is a pending signal that
> -	 * can awaken the task.
> -	 */
> -	set_special_state(TASK_TRACED);
> +	if (!__fatal_signal_pending(current))
> +		set_special_state(TASK_TRACED);

This is where I stuck. This probably makes sense, but what does it buy
for this particular patch?

And if we check __fatal_signal_pending(), why can't ptrace_stop() simply
return ?

Oleg.

