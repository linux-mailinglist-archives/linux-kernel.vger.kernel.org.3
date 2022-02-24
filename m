Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF494C2BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiBXMin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiBXMik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1219C19E0BE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645706289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YRjb58oU+mffN2OBfWfcPKcr9rxdbyZA6C2HyvymPc4=;
        b=S8om/3tAQn2K5Yycgf27OBmH64VPa25/5Z3QDOoz3NsWI1XA9d4ehKAVNaWhUUjqyCDMYF
        cZ1t6YpSm+s9EHWU+UZGGjb1U3DnnJaFU6O8muZ0npY0DX8GCcQbwLhrcbP10CO94DbY8G
        xRi/Cs4mMeBf4ur3EqwWE9cwc7r90U4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-ULOiTRekME2a6FWpc-98Vg-1; Thu, 24 Feb 2022 07:38:06 -0500
X-MC-Unique: ULOiTRekME2a6FWpc-98Vg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FC71835DE1;
        Thu, 24 Feb 2022 12:38:04 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5A5776BF9;
        Thu, 24 Feb 2022 12:38:03 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 5A44F416D862; Thu, 24 Feb 2022 09:37:44 -0300 (-03)
Date:   Thu, 24 Feb 2022 09:37:44 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <Yhd8GONfqYpIdl51@fuller.cnet>
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <20220217124729.GA743618@lothringen>
 <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
 <20220217163205.GA748087@lothringen>
 <20220218125454.utlgmuhijklzr3if@ava.usersys.com>
 <20220219154616.pwsvh445x3vn7ltf@ava.usersys.com>
 <Yhd5olg9CjXSAf2s@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhd5olg9CjXSAf2s@fuller.cnet>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:27:14AM -0300, Marcelo Tosatti wrote:
> On Sat, Feb 19, 2022 at 03:46:16PM +0000, Aaron Tomlin wrote:
> > On Fri 2022-02-18 12:54 +0000, Aaron Tomlin wrote:
> > > On Thu 2022-02-17 17:32 +0100, Frederic Weisbecker wrote:
> > > > > If I understand correctly, in the context of nohz_full, since such work is
> > > > > deferred, it will only be handled in a scenario when the periodic/or
> > > > > scheduling-clock tick is enabled i.e. the timer was reprogrammed on exit
> > > > > from idle.
> > > > 
> > > > Oh I see, it's a deferrable delayed work...
> > > > Then I can see two other issues:
> > > > 
> > > > 1) Can an interrupt in idle modify the vmstat and thus trigger the need to
> > > >    flush it? 
> 
> Yes. Page allocation and page freeing for example.
> 
>    6   3730  ../mm/page_alloc.c <<rmqueue>>
>              __mod_zone_freepage_state(zone, -(1 << order),
>    4   1096  ../mm/page_alloc.c <<__free_one_page>
>              __mod_zone_freepage_state(zone, -(1 << order),
> 
> > > >    I believe it's the case and then the problem goes beyond nohz_full
> > > >    because if the idle interrupt fired while the tick is stopped and didn't set
> > > >    TIF_RESCHED, we go back to sleep without calling quiet_vmstat().
> > > 
> > > Yes: e.g. a nohz_full CPU, in idle code, could indeed receive a reschedule
> > > IPI; re-enable local IRQs and generic idle code sees the TIF_NEED_RESCHED
> > > flag against the idle task. Additionally, the selected task could
> > > indirectly released a few pages [to satisfy a low-memory condition] and
> > > modify CPU-specific vmstat data i.e. vm_stat_diff[NR_FREE_PAGES].
> > > 
> > > 
> > > > 2) What if we are running task A in kernel mode while the tick is stopped
> > > >    (nohz_full). Task A modifies the vmstat and goes to userspace for a long
> > > >    while.
> > > > Your patch fixes case 1) but not case 2). The problem is that TIMER_DEFERRABLE
> > > > should really be about dynticks-idle only and not dynticks-full. I've always
> > > > been afraid about enforcing that rule though because that would break old
> > > > noise-free setups. But perhaps I should...
> > > 
> > > If I understand correctly, I agree. For the latter case, nothing can be
> > > done unfortunately since the scheduling-clock tick is stopped.
> > 
> > Hi Frederic,
> > 
> > As far vmstat_updateas I understand, in the context of nohz_full, options are indeed
> > limited; albeit, if we can ensure CPU-specific vmstat data is folded on
> > return to idle [when required] then this should be good enough.
> 
> I suppose the desired behaviour, with the deferred timer for vmstat_sync, is:
> 
> "Allow the per-CPU vmstats to be out of sync, but for a maximum of 
> sysctl_stat_interval".
> 
> But Aaron, vmstat_shepherd should be ensuring that per-CPU vmstat_update
> work are queued, if the per-CPU vmstat are out of sync.
> 
> And:
> 
> static void
> trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
> {
>         if (!is_timers_nohz_active())
>                 return;
> 
>         /*
>          * TODO: This wants some optimizing similar to the code below, but we
>          * will do that when we switch from push to pull for deferrable timers.
>          */
>         if (timer->flags & TIMER_DEFERRABLE) {
>                 if (tick_nohz_full_cpu(base->cpu))
>                         wake_up_nohz_cpu(base->cpu);
>                 return;
>         }
> 
>  * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
>  * system is busy, but will not cause a CPU to come out of idle just
>  * to service it; instead, the timer will be serviced when the CPU
>  * eventually wakes up with a subsequent non-deferrable timer.
> 
> You'd want that vmstat_update to execute regardless of whether there are 
> armed non-deferrable timers.
> 
> Should fix both 1 and 2 AFAICS.

Maybe just switching to a non-deferrable timer does not increase the
frequency of vmstat_update calls so much ? It should happen once per
second anyway.

Then the "vmstats out of sync but for a maximum of sysctl_stat_interval"
would be respected, rather than existance of non-deferrable timers.
 

