Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF951398F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349889AbiD1QWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349883AbiD1QWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA11F5D18C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651162764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TK2deUlPmpF496ha3AlCXcsfEwKXNp+OVKjxx1+ZfjM=;
        b=bBXJLH41sGfKFnHwp/CniNIRhsaaA/snHyr88v4z7KFeWX+ZoQ7aCz4rWqt2sA8P0PKJ8T
        pHFpA77a45ZqMB/zty2gCBOAkq50mP6RlEzwgnKo+z3tZ5h551sn4y+fWeXo5ZdXgi7u19
        EGINBZI3IGJInXdH6T0VuvB99jqKk5w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-AYxnPGG8MouLzDRXcZQYXQ-1; Thu, 28 Apr 2022 12:19:20 -0400
X-MC-Unique: AYxnPGG8MouLzDRXcZQYXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A068929ABA25;
        Thu, 28 Apr 2022 16:19:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.151])
        by smtp.corp.redhat.com (Postfix) with SMTP id B184615230A0;
        Thu, 28 Apr 2022 16:19:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 Apr 2022 18:19:19 +0200 (CEST)
Date:   Thu, 28 Apr 2022 18:19:13 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 7/9] ptrace: Simplify the wait_task_inactive call in
 ptrace_check_attach
Message-ID: <20220428161912.GD15485@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-7-ebiederm@xmission.com>
 <20220427151455.GE17421@redhat.com>
 <Ympvf1Pam1ckX+EA@hirez.programming.kicks-ass.net>
 <20220428111911.GA3804@redhat.com>
 <YmqckaB+xB6azP1d@hirez.programming.kicks-ass.net>
 <20220428145750.GA15485@redhat.com>
 <Ymq8UafDbJEjSoB0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymq8UafDbJEjSoB0@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28, Peter Zijlstra wrote:
>
> On Thu, Apr 28, 2022 at 04:57:50PM +0200, Oleg Nesterov wrote:
>
> > > Shouldn't we then switch wait_task_inactive() so have & matching instead
> > > of the current ==.
> >
> > Sorry, I don't understand the context...
>
> This.. I've always found it strange to have wti use a different matching
> scheme from ttwu.

Ah. This is what I understood (and I too thought about this), just I meant that
this patch from Eric (assuming wait_task_inactive() still uses __TASK_TRACED) is
fine without your change below.

Oleg.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f259621f4c93..c039aef4c8fe 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3304,7 +3304,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
>  		 * is actually now running somewhere else!
>  		 */
>  		while (task_running(rq, p)) {
> -			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> +			if (match_state && unlikely(!(READ_ONCE(p->__state) & match_state)))
>  				return 0;
>  			cpu_relax();
>  		}
> @@ -3319,7 +3319,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
>  		running = task_running(rq, p);
>  		queued = task_on_rq_queued(p);
>  		ncsw = 0;
> -		if (!match_state || READ_ONCE(p->__state) == match_state)
> +		if (!match_state || (READ_ONCE(p->__state) & match_state))
>  			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
>  		task_rq_unlock(rq, p, &rf);

