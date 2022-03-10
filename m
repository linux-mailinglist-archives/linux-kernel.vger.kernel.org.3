Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B044F4D4FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbiCJRBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbiCJRBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:01:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBF391052B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646931628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gB57+YJ6YRkHA5rn3XMB0b7INMSeUreN8Q0XW45JxlQ=;
        b=EsmjpLvXnqtn6g13HKQTDYmRaOiOA73STjoj3PEpIZGdtD/milM/TnUshmyQTawNy7GCLf
        SnOAf3DZ7lhqU4Zz4JpWA93u9ksd1VUJm1tGwGxQka0c5Dt4Do+Uz4CXaptgUcQbUk4Yg0
        IkX/rSKBYMCPpPTUNsmyaXDBfUyJHNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-jF7EAev0PwOP_S1xQduOpQ-1; Thu, 10 Mar 2022 12:00:25 -0500
X-MC-Unique: jF7EAev0PwOP_S1xQduOpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E1BC1091DA1;
        Thu, 10 Mar 2022 17:00:24 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEFA5106F968;
        Thu, 10 Mar 2022 16:59:20 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id D77CA416CE5D; Thu, 10 Mar 2022 13:30:14 -0300 (-03)
Date:   Thu, 10 Mar 2022 13:30:14 -0300
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
Subject: Re: [patch v11 07/13] task isolation: sync vmstats conditional on
 changes
Message-ID: <YionlrkrON9cp7SK@fuller.cnet>
References: <20220204173537.429902988@fedora.localdomain>
 <20220204173554.763888172@fedora.localdomain>
 <20220207151915.GA526112@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207151915.GA526112@lothringen>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:19:15PM +0100, Frederic Weisbecker wrote:
> On Fri, Feb 04, 2022 at 02:35:44PM -0300, Marcelo Tosatti wrote:
> > Rather than syncing VM-stats on every return to userspace
> > (or VM-entry), keep track of changes through a per-CPU bool.
> > 
> > This improves performance when enabling task isolated
> > for vcpu VMs.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> > v11:
> > - Add TIF_TASK_ISOL bit to thread info flags and use it
> >   to decide whether to perform task isolation work on
> >   return to userspace     
> > 
> >  include/linux/vmstat.h |   13 ++++++++++++-
> >  mm/vmstat.c            |   29 ++++++++++++++++++++++++++++-
> >  2 files changed, 40 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6/include/linux/vmstat.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/vmstat.h
> > +++ linux-2.6/include/linux/vmstat.h
> > @@ -22,7 +22,18 @@ int sysctl_vm_numa_stat_handler(struct c
> >  #endif
> >  
> >  #if defined(CONFIG_SMP) && defined(CONFIG_TASK_ISOLATION)
> > -void sync_vmstat(void);
> > +DECLARE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> > +
> > +extern struct static_key vmstat_sync_enabled;
> > +
> > +void __sync_vmstat(void);
> > +static inline void sync_vmstat(void)
> > +{
> > +	if (static_key_false(&vmstat_sync_enabled))
> > +		__sync_vmstat();
> > +}
> > +
> > +void init_sync_vmstat(void);
> >  #else
> >  static inline void sync_vmstat(void)
> >  {
> > Index: linux-2.6/mm/vmstat.c
> > ===================================================================
> > --- linux-2.6.orig/mm/vmstat.c
> > +++ linux-2.6/mm/vmstat.c
> > @@ -334,6 +334,31 @@ void set_pgdat_percpu_threshold(pg_data_
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_TASK_ISOLATION
> > +struct static_key vmstat_sync_enabled;
> > +DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> > +
> > +static inline void mark_vmstat_dirty(void)
> > +{
> > +	if (!static_key_false(&vmstat_sync_enabled))
> > +		return;
> > +
> > +	raw_cpu_write(vmstat_dirty, true);
> 
> Why not __this_cpu_write() ? Shouldn't we make sure we are not
> preemptible and not mark the wrong CPU?

#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
/*
 * If we have cmpxchg_local support then we do not need to incur the overhead
 * that comes with local_irq_save/restore if we use this_cpu_cmpxchg.
 *
 * mod_state() modifies the zone counter state through atomic per cpu
 * operations.
 *
 * Overstep mode specifies how overstep should handled:
 *     0       No overstepping
 *     1       Overstepping half of threshold
 *     -1      Overstepping minus half of threshold
*/
static inline void mod_zone_state(struct zone *zone,
       enum zone_stat_item item, long delta, int overstep_mode)
{
        struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
        s8 __percpu *p = pcp->vm_stat_diff + item;
        long o, n, t, z;

        do {
                z = 0;  /* overflow to zone counters */

Perhaps one can

                        n = -os;
                }
        } while (this_cpu_cmpxchg(*p, o, n) != o);
							<-- migrate
        if (z)
                zone_page_state_add(z, zone, item);
        mark_vmstat_dirty();


But we assume the task which is using task isolation is pinned to a single CPU,
so that should not happen.

