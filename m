Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B614C88AD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiCAKA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiCAKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:00:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC0BE57155
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646128814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0a4V8jcz4WdUPFnoBy8n2iqsSKeTwdBk1wFP5Zn0FME=;
        b=Dw8YlcWrPAMNqLSSzhSCmOyyt3HjOgNO0EznjCj1TccL2lmdtCwPEf6Xrn+8EoLN/F5H33
        WNrGPXf6hLxlP2HtlZ76dou0C+hhAv27yGn4Gf0gJugtICbwxyQkrjUjp4YucG8B1yt2Q1
        QWLfZTsun0HeVu5rLmu2JYJmfTzrzok=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-D3PvyDsKOsaVhgtuVzSniw-1; Tue, 01 Mar 2022 05:00:11 -0500
X-MC-Unique: D3PvyDsKOsaVhgtuVzSniw-1
Received: by mail-wr1-f70.google.com with SMTP id w2-20020adfbac2000000b001ea99ca4c50so3075754wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0a4V8jcz4WdUPFnoBy8n2iqsSKeTwdBk1wFP5Zn0FME=;
        b=3GFXGX1g1UI/wu2jN0S02N5A7b384/Vsi14RCPIMNvauCmwBuOmJd34l6WRTw9WKD4
         jYTTQUvyOjIl7d0QB64FcobDAbItMXAQBbYhmK5+YrF/2ifiwnglojOXWblve2ChVk8A
         W49jNDSPeqD2NX38KTS4U4yAwoo92DTfOmbiFfLJfPHXgfGnPnV3pvLdhgTFYXRlmzGe
         MAqb4Fd/Z0xsLHHaeyQvoxlAFarh5+9MaP7A8rAvTrw0OcreYoVOD/RE9XcHVFIlWlEP
         ujJ8hcPg27mlV7ON3qIQ8IRCD20bYtENq5+qU9fDw0AOs513eG0W72yX1ftNIIfW0NF0
         TCKw==
X-Gm-Message-State: AOAM531O6+JPOZgiAlyfsZVnhJZVJIkmrkcB4a0trzw9e82KNVU59wHQ
        1+YsD7k7O1N4OgugKMXOyD/9w2bq46voCpoMhuT9mBx/mdip+p/5vLfi9bpXmUG2MfoasqvfTYd
        8yDBWRmqOEQr+u1te8vPpJEsl
X-Received: by 2002:a05:600c:4f8e:b0:381:6de4:fccc with SMTP id n14-20020a05600c4f8e00b003816de4fcccmr5886520wmq.82.1646128810543;
        Tue, 01 Mar 2022 02:00:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSq5xLxZz6UTmqeKf4ZTIP6iVSTgRTeBibDgXtAwHRPsE1hpCYnsjegBPlNIf2Bpm/YqjF6A==
X-Received: by 2002:a05:600c:4f8e:b0:381:6de4:fccc with SMTP id n14-20020a05600c4f8e00b003816de4fcccmr5886493wmq.82.1646128810226;
        Tue, 01 Mar 2022 02:00:10 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8? ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b003816bac83f6sm2233206wmg.27.2022.03.01.02.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:00:09 -0800 (PST)
Message-ID: <1b388cdc409fdfae75ef2280674d8211e5b6194e.camel@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     paulmck@kernel.org
Cc:     rostedt@goodmis.org, bristot@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com
Date:   Tue, 01 Mar 2022 11:00:08 +0100
In-Reply-To: <20220228221154.GN4285@paulmck-ThinkPad-P17-Gen-1>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
         <20220228221154.GN4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-28 at 14:11 -0800, Paul E. McKenney wrote:
> On Mon, Feb 28, 2022 at 03:14:23PM +0100, Nicolas Saenz Julienne wrote:
> > At the moment running osnoise on an isolated CPU and a PREEMPT_RCU
> > kernel might have the side effect of extending grace periods too much.
> > This will eventually entice RCU to schedule a task on the isolated CPU
> > to end the overly extended grace period, adding unwarranted noise to the
> > CPU being traced in the process.
> > 
> > So, check if we're the only ones running on this isolated CPU and that
> > we're on a PREEMPT_RCU setup. If so, let's force quiescent states in
> > between measurements.
> > 
> > Non-PREEMPT_RCU setups don't need to worry about this as osnoise main
> > loop's cond_resched() will go though a quiescent state for them.
> > 
> > Note that this same exact problem is what extended quiescent states were
> > created for. But adapting them to this specific use-case isn't trivial
> > as it'll imply reworking entry/exit and dynticks/context tracking code.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > ---
> >  kernel/trace/trace_osnoise.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> > index 870a08da5b48..4928358f6e88 100644
> > --- a/kernel/trace/trace_osnoise.c
> > +++ b/kernel/trace/trace_osnoise.c
> > @@ -21,7 +21,9 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/delay.h>
> > +#include <linux/tick.h>
> >  #include <linux/sched/clock.h>
> > +#include <linux/sched/isolation.h>
> >  #include <uapi/linux/sched/types.h>
> >  #include <linux/sched.h>
> >  #include "trace.h"
> > @@ -1295,6 +1297,7 @@ static int run_osnoise(void)
> >  	struct osnoise_sample s;
> >  	unsigned int threshold;
> >  	u64 runtime, stop_in;
> > +	unsigned long flags;
> >  	u64 sum_noise = 0;
> >  	int hw_count = 0;
> >  	int ret = -1;
> > @@ -1386,6 +1389,22 @@ static int run_osnoise(void)
> >  					osnoise_stop_tracing();
> >  		}
> >  
> > +		/*
> > +		 * Check if we're the only ones running on this nohz_full CPU
> > +		 * and that we're on a PREEMPT_RCU setup. If so, let's fake a
> > +		 * QS since there is no way for RCU to know we're not making
> > +		 * use of it.
> > +		 *
> > +		 * Otherwise it'll be done through cond_resched().
> > +		 */
> > +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) &&
> > +		    !housekeeping_cpu(raw_smp_processor_id(), HK_FLAG_MISC) &&
> > +		    tick_nohz_tick_stopped()) {
> > +			local_irq_save(flags);
> > +			rcu_momentary_dyntick_idle();
> > +			local_irq_restore(flags);
> 
> What is supposed to happen in this case is that RCU figures out that
> there is a nohz_full CPU running for an extended period of time in the
> kernel and takes matters into its own hands.  This goes as follows on
> a HZ=1000 kernel with default RCU settings:
> 
> o	At about 20 milliseconds into the grace period, RCU makes
> 	cond_resched() report quiescent states, among other things.
> 	As you say, this does not help for CONFIG_PREEMPT=n kernels.
> 
> o	At about 30 milliseconds into the grace period, RCU forces an
> 	explicit context switch on the wayward CPU.  This should get
> 	the CPU's attention even in CONFIG_PREEMPT=y kernels.
> 
> So what is happening for you instead?

Well, that's exactly what I'm seeing, but it doesn't play well with osnoise.

Here's a simplified view of what the tracer does:

	time1 = get_time();
	while(1) {
		time2 = get_time();
		if (time2 - time1 > threshold)
			trace_noise();
		cond_resched();
		time1 = time2;
	}

This is pinned to a specific CPU, and in the most extreme cases is expected to
take 100% of CPU time. Eventually, some SMI, NMI/interrupt, or process
execution will trigger the threshold, and osnoise will provide some nice traces
explaining what happened.

RCU forcing a context switch on the wayward CPU is introducing unwarranted
noise as it's triggered by the fact we're measuring and wouldn't happen
otherwise.

If this were user-space, we'd be in an EQS, which would make this problem go
away. An option would be mimicking this behaviour (assuming irq entry/exit code
did the right thing):

	rcu_eqs_enter(); <--
	time1 = get_time();
	while(1) {
		time2 = get_time();
		if (time2 - time1 > threshold)
			trace_noise();
		rcu_eqs_exit(); <--
		cond_resched();
		rcu_eqs_enter(); <--
		time1 = time2;
	}

But given the tight loop this isn't much different than what I'm proposing at
the moment, isn't it? rcu_momentary_dyntick_idle() just emulates a really fast
EQS entry/exit.

Thanks!

-- 
Nicolás Sáenz

