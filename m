Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CD2532B41
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiEXN03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbiEXN0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B98FF50E0B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653398777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=acmhyrCTF0XS2BK7y8uo6vpek2Tjc12pUbIZAJf3+G4=;
        b=A11QgoEV5TVCopQJaaR4wiynfBt2qGkcqDES3ko6plRADd6xfZhJ7H4l/SjGxZT6EAC+fI
        A2YzyyG6h1dv9rSQVWzxri4qSB8Bp9wHWXatGb55vfiNPd5611HMJLm6avRgBd+nnBUFoB
        NPlCe5S6nDRjjMiyzhm/Z79BN+1xPU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-k95FiaAWOuuZHyhIgKfnnw-1; Tue, 24 May 2022 09:26:16 -0400
X-MC-Unique: k95FiaAWOuuZHyhIgKfnnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2D89803D5B;
        Tue, 24 May 2022 13:26:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id B31637AD8;
        Tue, 24 May 2022 13:25:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 24 May 2022 15:26:14 +0200 (CEST)
Date:   Tue, 24 May 2022 15:25:54 +0200
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
Subject: Re: [PATCH 07/16] signal: Wake up the designated parent
Message-ID: <20220524132553.GD14347@redhat.com>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <20220518225355.784371-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518225355.784371-7-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fail to understand this patch...

On 05/18, Eric W. Biederman wrote:
>
> Today if a process is ptraced only the ptracer will ever be woken up in
> wait

and why is this wrong?

> Fixes: 75b95953a569 ("job control: Add @for_ptrace to do_notify_parent_cldstop()")

how does this change fix 75b95953a569?

>  static int child_wait_callback(wait_queue_entry_t *wait, unsigned mode,
>  				int sync, void *key)
>  {
>  	struct wait_opts *wo = container_of(wait, struct wait_opts,
>  						child_wait);
> -	struct task_struct *p = key;
> +	struct child_wait_info *info = key;
>
> -	if (!eligible_pid(wo, p))
> +	if (!eligible_pid(wo, info->p))
>  		return 0;
>
> -	if ((wo->wo_flags & __WNOTHREAD) && wait->private != p->parent)
> -		return 0;
> +	if ((wo->wo_flags & __WNOTHREAD) && (wait->private != info->parent))
> +			return 0;

So. wait->private is the task T which sleeping on wait_chldexit.

Before the patch the logic is clear. T called do_wait(__WNOTHREAD) and
we do not need to wake it up if it is not the "actual" parent of p.

After the patch we check it T is actual to the "parent" arg passed to
__wake_up_parent(). Why??? This arg is only used to find the
->signal->wait_chldexit wait_queue_head, and this is fine.

As I said, I don't understand this patch. But at least this change is
wrong in case when __wake_up_parent() is calles by __ptrace_detach().
(you removed it in 5/16 but this looks wrong too). Sure, we can change
ptrace_detach() to use __wake_up_parent(p, p->parent), but for what?

I must have missed something.

Oleg.

