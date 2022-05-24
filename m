Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2545A532F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbiEXQjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiEXQjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83698E023
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653410377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fBeQ/9otl7euJ3gJ516ZBteQsGcd+PSie7gaIlgj0ZI=;
        b=IXo6ADJHu4DSaH+FXmCLrDTSMbiAYrtjsIsTx3Emx02jaTvLwpc5ZZzomQyDyc9XzyKWuF
        7TZKakg74aylgvCKLtUsi9xn8yoJ16DaFRcnE9LgRoL/vb+y0JUZgm0pgh0bezPMN+kgle
        UEgVST26d6Pd90UO8OtuKJpp9qML6Uo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-iQYTbkV1PEye8_HbwoHjvw-1; Tue, 24 May 2022 12:39:35 -0400
X-MC-Unique: iQYTbkV1PEye8_HbwoHjvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C543858EFE;
        Tue, 24 May 2022 16:39:35 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0DBC1410DD5;
        Tue, 24 May 2022 16:39:34 +0000 (UTC)
Date:   Tue, 24 May 2022 12:39:33 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuhp: make target_store() a nop when target == state
Message-ID: <Yo0KRVpfhUb8Ta4N@lorien.usersys.redhat.com>
References: <20220523144728.32414-1-pauld@redhat.com>
 <xhsmh35gzj77s.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh35gzj77s.mognet@vschneid.remote.csb>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 04:11:51PM +0100 Valentin Schneider wrote:
> On 23/05/22 10:47, Phil Auld wrote:
> > writing the current state back into hotplug/target calls cpu_down()
> > which will set cpu dying even when it isn't and then nothing will
> > ever clear it. A stress test that reads values and writes them back
> > for all cpu device files in sysfs will trigger the BUG() in
> > select_fallback_rq once all cpus are marked as dying.
> >
> > kernel/cpu.c::target_store()
> > 	...
> >         if (st->state < target)
> >                 ret = cpu_up(dev->id, target);
> >         else
> >                 ret = cpu_down(dev->id, target);
> >
> > cpu_down() -> cpu_set_state()
> > 	 bool bringup = st->state < target;
> > 	 ...
> > 	 if (cpu_dying(cpu) != !bringup)
> > 		set_cpu_dying(cpu, !bringup);
> >
> > Make this safe by catching the case where target == state
> > and bailing early.
> >
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > ---
> >
> > Yeah, I know... don't do that. But it's still messy.
> >
> > !< != > 
> >
> >  kernel/cpu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index d0a9aa0b42e8..8a71b1149c60 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -2302,6 +2302,9 @@ static ssize_t target_store(struct device *dev, struct device_attribute *attr,
> >  		return -EINVAL;
> >  #endif
> >  
> > +	if (target == st->state)
> > +		return count;
> > +
> 
> The current checks are against static boundaries, this has to compare
> against st->state - AFAICT this could race with another hotplug operation
> to the same CPU, e.g.
> 
>   CPU42.cpuhp_state
>     ->state  == CPUHP_AP_SCHED_STARTING
>     ->target == CPUHP_ONLINE
> 
>   <write CPUHP_ONLINE via sysfs, OK because current state != CPUHP_ONLINE>
> 
>   CPU42.cpuhp_state == CPUHP_ONLINE
>
>   <issues ensue>
>

What I'm trying to fix is not a race.  It's just bogus logic. 
There is an assumption here that !< means > which is just not
true. 

This potential race seems orthogonal and not even effected
one way or the other by this code change, right?

I could not convince myself that the check I added needed to
be under the locks because returning success when the state
is already reporting what you asked for seems harmless.


> 
> _cpu_up() has:
> 
> 	/*
> 	 * The caller of cpu_up() might have raced with another
> 	 * caller. Nothing to do.
> 	 */
> 	if (st->state >= target)
> 		goto out;
>
> Looks like we want an equivalent in _cpu_down(), what do you think?

Maybe. I still think that

> >         if (st->state < target)
> >                 ret = cpu_up(dev->id, target);
> >         else
> >                 ret = cpu_down(dev->id, target);

is not correct. If we catch the == case earlier then this makes
sense as is.

I suppose "if (st->state <= target)" would work too since __cpu_up()
already checks. Catching this sooner seems better to me though.

> 
> >  	ret = lock_device_hotplug_sysfs();
> >  	if (ret)
> >  		return ret;
> > -- 
> > 2.18.0
> 


Cheers,
Phil

-- 

