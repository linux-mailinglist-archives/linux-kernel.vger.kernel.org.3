Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAEC49E7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244109AbiA0Qri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:47:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238557AbiA0Qrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643302054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H1koGe2qHGNLjEfeVCswORaZQP6sDw+SXgvHfEnRrS0=;
        b=Q+dSBCOZJtti8BG9Ai3cLqhx31RMYeD/miV7YkqqTe8VSoqBc+e2CYFwaPUwymtPixeODa
        vid4smupWB7gsZ0pXd7wyN2xIDWNzY9++HbeF+aN/tUACt4hn6MtnPl1ZpR+ElNd3u7Itm
        uraNvo4k9m5KVx+ZvVgPbrrX5/CYmgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-VX8XNsMZPHu8b5XpicsYEA-1; Thu, 27 Jan 2022 11:47:31 -0500
X-MC-Unique: VX8XNsMZPHu8b5XpicsYEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02DBA18460E5;
        Thu, 27 Jan 2022 16:47:29 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64AE084D1A;
        Thu, 27 Jan 2022 16:47:28 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id EA725416CD79; Thu, 27 Jan 2022 13:47:07 -0300 (-03)
Date:   Thu, 27 Jan 2022 13:47:07 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v8 03/10] task isolation: sync vmstats on return to
 userspace
Message-ID: <YfLMi4SOvPl5rY5J@fuller.cnet>
References: <20211208161000.714824954@fuller.cnet>
 <20220121120610.GA231488@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121120610.GA231488@lothringen>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:06:10PM +0100, Frederic Weisbecker wrote:
> On Wed, Dec 08, 2021 at 01:09:09PM -0300, Marcelo Tosatti wrote:
> > Index: linux-2.6/include/linux/task_isolation.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/task_isolation.h
> > +++ linux-2.6/include/linux/task_isolation.h
> > @@ -40,8 +40,19 @@ int prctl_task_isolation_activate_set(un
> >  
> >  int __copy_task_isolation(struct task_struct *tsk);
> >  
> > +void isolation_exit_to_user_mode(void);
> > +
> > +static inline int task_isol_has_work(void)
> > +{
> > +	return 0;
> > +}
> > +
> >  #else
> >  
> > +static void isolation_exit_to_user_mode(void)
> > +{
> > +}
> > +
> >  static inline void tsk_isol_free(struct task_struct *tsk)
> >  {
> >  }
> > @@ -86,6 +97,11 @@ static inline int prctl_task_isolation_a
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +static inline int task_isol_has_work(void)
> > +{
> > +	return 0;
> > +}
> > +
> 
> It would be nice to have a coherent greppable task_isol_*() namespace instead
> of random scattered tsk_*(), isolation_*() stuff...
> 
> task_isol_exit_to_user_mode()
> task_isol_free()
> task_isol_copy_process()
> task_isol_had_work()
> ...
> 
> > @@ -149,13 +150,14 @@ static void handle_signal_work(struct pt
> >  }
> >  
> >  static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> > -					    unsigned long ti_work)
> > +					    unsigned long ti_work,
> > +					    unsigned long tsk_isol_work)
> >  {
> >  	/*
> >  	 * Before returning to user space ensure that all pending work
> >  	 * items have been completed.
> >  	 */
> > -	while (ti_work & EXIT_TO_USER_MODE_WORK) {
> > +	while ((ti_work & EXIT_TO_USER_MODE_WORK) || tsk_isol_work) {
> 
> So there is a dependency on CONFIG_GENERIC_ENTRY. Then you need to split that
> from CONFIG_CPU_ISOLATION:
> 
> config TASK_ISOLATION
>        bool "Task isolation prctl()"
>        depends on GENERIC_ENTRY
>        help "...."
> 
> >  
> >  		local_irq_enable_exit_to_user(ti_work);
> >  
> > @@ -177,6 +179,9 @@ static unsigned long exit_to_user_mode_l
> >  		/* Architecture specific TIF work */
> >  		arch_exit_to_user_mode_work(regs, ti_work);
> >  
> > +		if (tsk_isol_work)
> > +			isolation_exit_to_user_mode();
> > +
> >  		/*
> >  		 * Disable interrupts and reevaluate the work flags as they
> >  		 * might have changed while interrupts and preemption was
> > @@ -188,6 +193,7 @@ static unsigned long exit_to_user_mode_l
> >  		tick_nohz_user_enter_prepare();
> >  
> >  		ti_work = READ_ONCE(current_thread_info()->flags);
> > +		tsk_isol_work = task_isol_has_work();
> 
> Shouldn't it be a TIF_FLAG part of EXIT_TO_USER_MODE_WORK instead?
> 
> Thanks.

static inline int task_isol_has_work(void)
{
       int cpu, ret;
       struct isol_info *i;

       if (likely(current->task_isol_info == NULL))
               return 0;

       i = current->task_isol_info;
       if (i->active_mask != ISOL_F_QUIESCE)
               return 0;

       if (!(i->quiesce_mask & ISOL_F_QUIESCE_VMSTATS))
               return 0;

       cpu = get_cpu();
       ret = per_cpu(vmstat_dirty, cpu);
       put_cpu();

       return ret;
}

Well, whether its necessary to call task_isol_exit_to_user_mode depends
on the state of the enabled/disabled masks _and_ vmstat dirty bit
information.

It seems awkward, to me, to condense all that information in a single bit.

Addressed all other comments, thanks.

