Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C54ADE60
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383414AbiBHQcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiBHQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:32:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95896C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644337958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9wKL0mFcQI+dpfyUTo+H+hKAl43nfgO4cY94TcdTW8=;
        b=Bu/guvaS8zFQft8iBQFzkOt5CITC9WYDYIKLEyboPphirLJtDeSUuIM+1A7DcR5EnQ9rcO
        2tELa/WFcn7MzZwiSjUFZfseaEson4CyOChBLLaEPyqfYsdZqCUhHMMp7ya5/TKJzlLOcq
        qHwBFfiRHOdZ1Zq0pSbd/2Z4wa3QBTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-yScnzixDNL69_svQtZlp-w-1; Tue, 08 Feb 2022 11:32:37 -0500
X-MC-Unique: yScnzixDNL69_svQtZlp-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC72E8519E9;
        Tue,  8 Feb 2022 16:32:35 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA3641086486;
        Tue,  8 Feb 2022 16:32:34 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2A618416CE5D; Mon,  7 Feb 2022 12:16:34 -0300 (-03)
Date:   Mon, 7 Feb 2022 12:16:33 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v11 05/13] task isolation: sync vmstats on return to
 userspace
Message-ID: <YgE30X7z8htKWzbS@fuller.cnet>
References: <20220204173537.429902988@fedora.localdomain>
 <20220204173554.676117258@fedora.localdomain>
 <20220207145718.GA523931@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207145718.GA523931@lothringen>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 03:57:18PM +0100, Frederic Weisbecker wrote:
> On Fri, Feb 04, 2022 at 02:35:42PM -0300, Marcelo Tosatti wrote:
> > The logic to disable vmstat worker thread, when entering
> > nohz full, does not cover all scenarios. For example, it is possible
> > for the following to happen:
> > 
> > 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> > 2) app runs mlock, which increases counters for mlock'ed pages.
> > 3) start -RT loop
> > 
> > Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> > the mlock, vmstat shepherd can restart vmstat worker thread on
> > the CPU in question.
> > 
> > To fix this, use the task isolation prctl interface to quiesce 
> > deferred actions when returning to userspace.
> > 
> > This patch adds hooks to fork and exit code paths.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> > v11: fold patch to add task_isol_exit hooks (Frederic)
> >      Use _TIF_TASK_ISOL bit on thread flags (Frederic)
> >      
> > v6: modify exit_to_user_mode_loop to cover exceptions and interrupts
> > v5: no changes
> > v4: add oneshot mode support
> > 
> >  include/linux/task_isolation.h |   16 ++++++++++++++++
> >  include/linux/vmstat.h         |    8 ++++++++
> >  kernel/entry/common.c          |   15 +++++++++++----
> >  kernel/task_isolation.c        |   21 +++++++++++++++++++++
> >  mm/vmstat.c                    |   21 +++++++++++++++++++++
> >  5 files changed, 77 insertions(+), 4 deletions(-)
> > 
> > Index: linux-2.6/include/linux/task_isolation.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/task_isolation.h
> > +++ linux-2.6/include/linux/task_isolation.h
> > @@ -27,6 +27,13 @@ static inline void task_isol_free(struct
> >  		__task_isol_free(tsk);
> >  }
> >  
> > +void __task_isol_exit(struct task_struct *tsk);
> > +static inline void task_isol_exit(struct task_struct *tsk)
> > +{
> > +	if (tsk->task_isol_info)
> > +		__task_isol_exit(tsk);
> > +}
> > +
> >  int prctl_task_isol_feat_get(unsigned long arg2, unsigned long arg3,
> >  			     unsigned long arg4, unsigned long arg5);
> >  int prctl_task_isol_cfg_get(unsigned long arg2, unsigned long arg3,
> > @@ -40,12 +47,22 @@ int prctl_task_isol_activate_set(unsigne
> >  
> >  int __copy_task_isol(struct task_struct *tsk);
> >  
> > +void task_isol_exit_to_user_mode(void);
> > +
> >  #else
> >  
> > +static inline void task_isol_exit_to_user_mode(void)
> > +{
> > +}
> > +
> >  static inline void task_isol_free(struct task_struct *tsk)
> >  {
> >  }
> >  
> > +static inline void task_isol_exit(struct task_struct *tsk)
> > +{
> > +}
> > +
> >  static inline int prctl_task_isol_feat_get(unsigned long arg2,
> >  					   unsigned long arg3,
> >  					   unsigned long arg4,
> > Index: linux-2.6/include/linux/vmstat.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/vmstat.h
> > +++ linux-2.6/include/linux/vmstat.h
> > @@ -21,6 +21,14 @@ int sysctl_vm_numa_stat_handler(struct c
> >  		void *buffer, size_t *length, loff_t *ppos);
> >  #endif
> >  
> > +#if defined(CONFIG_SMP) && defined(CONFIG_TASK_ISOLATION)
> > +void sync_vmstat(void);
> > +#else
> > +static inline void sync_vmstat(void)
> > +{
> > +}
> > +#endif
> > +
> >  struct reclaim_stat {
> >  	unsigned nr_dirty;
> >  	unsigned nr_unqueued_dirty;
> > Index: linux-2.6/kernel/entry/common.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/entry/common.c
> > +++ linux-2.6/kernel/entry/common.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/livepatch.h>
> >  #include <linux/audit.h>
> >  #include <linux/tick.h>
> > +#include <linux/task_isolation.h>
> >  
> >  #include "common.h"
> >  
> > @@ -174,6 +175,9 @@ static unsigned long exit_to_user_mode_l
> >  		if (ti_work & _TIF_NOTIFY_RESUME)
> >  			tracehook_notify_resume(regs);
> >  
> > +		if (ti_work & _TIF_TASK_ISOL)
> > +			task_isol_exit_to_user_mode();
> > +
> >  		/* Architecture specific TIF work */
> >  		arch_exit_to_user_mode_work(regs, ti_work);
> >  
> > Index: linux-2.6/kernel/task_isolation.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/task_isolation.c
> > +++ linux-2.6/kernel/task_isolation.c
> > @@ -18,6 +18,12 @@
> >  #include <linux/sysfs.h>
> >  #include <linux/init.h>
> >  #include <linux/sched/task.h>
> > +#include <linux/mm.h>
> > +#include <linux/vmstat.h>
> > +
> > +void __task_isol_exit(struct task_struct *tsk)
> > +{
> > +}
> >  
> >  void __task_isol_free(struct task_struct *tsk)
> >  {
> > @@ -251,6 +257,9 @@ static int cfg_feat_quiesce_set(unsigned
> >  	task_isol_info->quiesce_mask = i_qctrl->quiesce_mask;
> >  	task_isol_info->oneshot_mask = i_qctrl->quiesce_oneshot_mask;
> >  	task_isol_info->conf_mask |= ISOL_F_QUIESCE;
> > +	if (task_isol_info->quiesce_mask & ISOL_F_QUIESCE_VMSTATS)
> > +		set_thread_flag(TIF_TASK_ISOL);
> 
> Should you check if (i->active_mask == ISOL_F_QUIESCE) before setting the
> flag?
> 
> > +
> >  	ret = 0;
> >  
> >  out_free:
> > @@ -303,6 +312,7 @@ int __copy_task_isol(struct task_struct
> >  		new_info->active_mask = info->active_mask;
> >  
> >  	tsk->task_isol_info = new_info;
> > +	set_ti_thread_flag(task_thread_info(tsk), TIF_TASK_ISOL);
> 
> Same here?

Yes, should fix that.

Will wait for more comments before resending -v12.


