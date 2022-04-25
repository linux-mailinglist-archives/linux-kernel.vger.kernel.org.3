Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308D550E351
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiDYOi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242465AbiDYOix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 993C813EA1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650897348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=llh5N9erjou2WpvVGaytLaZbplT+rXm40NCMpXmjhzw=;
        b=Sjad16SK/xLlTSrW7Eu1gbcfNFxJc4c3h17sYb3nE/Wu0GE/6eGY9mD8PkL+OjfmDewBmW
        C0kmapgJhgVmYyi4ALP30bXU+8tMAn2mjjB+HFgErR7ohBpmizTHtDUEeIovH3rTqhLva3
        4/nPOVURwizqcwAXNU2wTWZr40yuRGU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-vFNx0tuZPzW0a37m-9SEtg-1; Mon, 25 Apr 2022 10:35:44 -0400
X-MC-Unique: vFNx0tuZPzW0a37m-9SEtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84665811E84;
        Mon, 25 Apr 2022 14:35:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.11])
        by smtp.corp.redhat.com (Postfix) with SMTP id 881D0400F8F6;
        Mon, 25 Apr 2022 14:35:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 25 Apr 2022 16:35:41 +0200 (CEST)
Date:   Mon, 25 Apr 2022 16:35:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
Message-ID: <20220425143537.GA12412@redhat.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421150654.817117821@infradead.org>
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

On 04/21, Peter Zijlstra wrote:
>
> +static void clear_traced_quiesce(void)
> +{
> +	spin_lock_irq(&current->sighand->siglock);
> +	WARN_ON_ONCE(!(current->jobctl & JOBCTL_TRACED_QUIESCE));

This WARN_ON_ONCE() doesn't look right, the task can be killed right
after ptrace_stop() sets JOBCTL_TRACED | JOBCTL_TRACED_QUIESCE and
drops siglock.

> @@ -2290,14 +2303,26 @@ static int ptrace_stop(int exit_code, in
>  		/*
>  		 * Don't want to allow preemption here, because
>  		 * sys_ptrace() needs this task to be inactive.
> -		 *
> -		 * XXX: implement read_unlock_no_resched().
>  		 */
>  		preempt_disable();
>  		read_unlock(&tasklist_lock);
> -		cgroup_enter_frozen();
> +		cgroup_enter_frozen(); // XXX broken on PREEMPT_RT !!!
> +
> +		/*
> +		 * JOBCTL_TRACE_QUIESCE bridges the gap between
> +		 * set_current_state(TASK_TRACED) above and schedule() below.
> +		 * There must not be any blocking (specifically anything that
> +		 * touched ->saved_state on PREEMPT_RT) between here and
> +		 * schedule().
> +		 *
> +		 * ptrace_check_attach() relies on this with its
> +		 * wait_task_inactive() usage.
> +		 */
> +		clear_traced_quiesce();

Well, I think it should be called earlier under tasklist_lock,
before preempt_disable() above.

We need tasklist_lock to protect ->parent, debugger can be killed
and go away right after read_unlock(&tasklist_lock).

Still trying to convince myself everything is right with
JOBCTL_STOPPED/TRACED ...

Oleg.

