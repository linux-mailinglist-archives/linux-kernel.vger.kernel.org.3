Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449FA4C2CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiBXNQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiBXNP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CF65166E11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645708528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0lJYwvTZOZVdJ4O7bKhvvzTAAdIE1Ye5K2uSbURukI=;
        b=bK//y7ovI88mp2+dbJg9l4vs9ciBlyCa4LCtA8EJ3yOe5/DYSSiVx4uDYpv4PPbWqBFIQk
        k+R5EfHQrLy66cnTyoWsrdvxyVTu0JPnOtgvBZxkCv5+Py6ymX11Hj6dPvxgwn8epgO/cW
        ea566Q8Y+4LSZmpekhu87fmW+L6kPo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-E3FskdubMYSN1vTPcI5-nA-1; Thu, 24 Feb 2022 08:15:23 -0500
X-MC-Unique: E3FskdubMYSN1vTPcI5-nA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2F5B1854E21;
        Thu, 24 Feb 2022 13:15:21 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8936310631F7;
        Thu, 24 Feb 2022 13:15:19 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id D8300416D862; Thu, 24 Feb 2022 10:14:58 -0300 (-03)
Date:   Thu, 24 Feb 2022 10:14:58 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <YheE0joXm53Hxn4J@fuller.cnet>
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <20220217124729.GA743618@lothringen>
 <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
 <20220217163205.GA748087@lothringen>
 <20220218125454.utlgmuhijklzr3if@ava.usersys.com>
 <20220219154616.pwsvh445x3vn7ltf@ava.usersys.com>
 <Yhd5olg9CjXSAf2s@fuller.cnet>
 <20220224130014.rmhtx3xlepybuxn2@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224130014.rmhtx3xlepybuxn2@ava.usersys.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 01:00:14PM +0000, Aaron Tomlin wrote:
> On Thu 2022-02-24 09:27 -0300, Marcelo Tosatti wrote:
> > But Aaron, vmstat_shepherd should be ensuring that per-CPU vmstat_update
> > work are queued, if the per-CPU vmstat are out of sync.
> 
> Hi Marcelo,
> 
> Yes, I agree; albeit, as far as I understand, in the context of a nohz_full
> CPU that has its scheduling-clock tick stopped, we cannot rely on any
> deferred work.
> 
> The purpose of my patch was to prevent a nohz_full CPU from entering idle
> state when CPU-specific vmstat data is non-zero.
> 
> > And:
> > 
> > static void
> > trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
> > {
> >         if (!is_timers_nohz_active())
> >                 return;
> > 
> >         /*
> >          * TODO: This wants some optimizing similar to the code below, but we
> >          * will do that when we switch from push to pull for deferrable timers.
> >          */
> >         if (timer->flags & TIMER_DEFERRABLE) {
> >                 if (tick_nohz_full_cpu(base->cpu))
> >                         wake_up_nohz_cpu(base->cpu);
> >                 return;
> >         }
> > 
> >  * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
> >  * system is busy, but will not cause a CPU to come out of idle just
> >  * to service it; instead, the timer will be serviced when the CPU
> >  * eventually wakes up with a subsequent non-deferrable timer.
> > 
> > You'd want that vmstat_update to execute regardless of whether there are 
> > armed non-deferrable timers.
> > 
> > Should fix both 1 and 2 AFAICS.
> > 
> 
> If I understand correctly, you are suggesting to switch to a non-deferred
> timer for such work when the scheduling-clock tick is stopped? Indeed, it
> would address both scenarios yet I'm not sure we'd want that due to the
> performance impact which might be more than negligible.

Aaron,

If the per-CPU vmstat_update is limited to happen once per second, that
shouldnt be a significant performance impact?

