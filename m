Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E061150A808
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391274AbiDUS0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377142AbiDUS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 629534AE3A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650565416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LmSyD84kPlvCX1Yut1um26AMAoMt8zYT0gIGD5xoXR4=;
        b=O8++9tpz5Z7AA9Si8jhV3lKkPMiJuqss7jxXL7eFIjr/rM/QOlAqb8qKhVZ3rHE/Ws9y7O
        SMY0q6JdIfztV9UmaykSYeivvx0i4FqaCFbZwCjcAKoVKcD2mS7FZ6EfwuUzd36TmwDgbH
        HemOLWRC3LObHrIUxSYC1bS+1ydTv/0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-nabTa2K5O0mfhKwGKPzhKQ-1; Thu, 21 Apr 2022 14:23:31 -0400
X-MC-Unique: nabTa2K5O0mfhKwGKPzhKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50B9B185A7B2;
        Thu, 21 Apr 2022 18:23:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3AD19C2812A;
        Thu, 21 Apr 2022 18:23:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 21 Apr 2022 20:23:30 +0200 (CEST)
Date:   Thu, 21 Apr 2022 20:23:26 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
Message-ID: <20220421182325.GC20402@redhat.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421150654.817117821@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Peter Zijlstra wrote:
>
> Rework ptrace_check_attach() / ptrace_unfreeze_traced() to not rely on
> task->__state as much.

Looks good after the quick glance... but to me honest I got lost and
I need to apply these patches and read the code carefully.

However, I am not able to do this until Monday, sorry.

Just one nit for now,

>  static void ptrace_unfreeze_traced(struct task_struct *task)
>  {
> -	if (READ_ONCE(task->__state) != __TASK_TRACED)
> +	if (!task_is_traced(task))
>  		return;
>  
>  	WARN_ON(!task->ptrace || task->parent != current);
>  
> -	/*
> -	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
> -	 * Recheck state under the lock to close this race.
> -	 */
>  	spin_lock_irq(&task->sighand->siglock);
> -	if (READ_ONCE(task->__state) == __TASK_TRACED) {
> +	if (task_is_traced(task)) {

I think ptrace_unfreeze_traced() should not use task_is_traced() at all.
I think a single lockless

	if (task->jobctl & JOBCTL_DELAY_WAKEKILL)
		return;

at the start should be enough?

Nobody else can set this flag. It can be cleared by the tracee if it was
woken up, so perhaps we can check it again but afaics this is not strictly
needed.

> +//		WARN_ON_ONCE(!(task->jobctl & JOBCTL_DELAY_WAKEKILL));

Did you really want to add the commented WARN_ON_ONCE?

Oleg.

