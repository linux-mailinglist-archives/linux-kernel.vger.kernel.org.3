Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925824D8BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbiCNSzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiCNSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E6A52BCB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647284079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=083jRPkrJnazoldsVs/TbU+MAEvPQEZLpxozIjfMarE=;
        b=MKSCRmivDljhrn+G32d8V4dLnnYX/DOhD9H1dLFGb1hZlArDtpcjok9+neqGZbyjNveXhP
        D18rmyYVxCLyqoArM5H+mA0cOZhwxeI9CsapSpOuzO5hB8aR0YxpGoExod9myqreMJIVqB
        VVw3PL2iFrlRr2CzdsxXNPTJmROjMwg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-AkQ1P6_VOLu2q2m4DjOOtg-1; Mon, 14 Mar 2022 14:54:36 -0400
X-MC-Unique: AkQ1P6_VOLu2q2m4DjOOtg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74D0318A6586;
        Mon, 14 Mar 2022 18:54:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.84])
        by smtp.corp.redhat.com (Postfix) with SMTP id B5B53492C14;
        Mon, 14 Mar 2022 18:54:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 14 Mar 2022 19:54:33 +0100 (CET)
Date:   Mon, 14 Mar 2022 19:54:30 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] ptrace: fix ptrace vs tasklist_lock race on PREEMPT_RT.
Message-ID: <20220314185429.GA30364@redhat.com>
References: <Yh/b19JikC+Vnm8i@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh/b19JikC+Vnm8i@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I never really understood ->saved_state logic. Will read this patch
tomorrow, but at first glance this patch doesn't solve all problems.

On 03/02, Sebastian Andrzej Siewior wrote:
>
> +static inline bool __task_state_match_eq(struct task_struct *tsk, long state)
> +{
> +	bool match = false;
> +
> +	if (READ_ONCE(tsk->__state) == state)
> +		match = true;
> +	else if (tsk->saved_state == state)
> +		match = true;
> +	return match;
> +}

...

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3239,7 +3239,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
>  		 * is actually now running somewhere else!
>  		 */
>  		while (task_running(rq, p)) {
> -			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> +			if (match_state &&
> +			    unlikely(!task_state_match_eq(p, match_state)))
>  				return 0;

So wait_task_inactive() can return 0 but the task can run after that, right?
This is not what we want...

Oleg.

