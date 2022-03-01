Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CD44C89AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiCAKx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiCAKxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1721817061
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646131963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4B4atLkDITMoub+rHSsBV+3F1nWD6FbRljQkexCK2/s=;
        b=RSa+V1hvMpOXqwjrattZE6zCO8uU1bH6kopB+caofR0j5EVES9igjsKUGokd8pvkF/cX3I
        7qoqwWIvskGgq2URGsQ3LYXOHErN/e2ftFQNGE0SU1fTQf/whhnT/LszSbYh7hyuCVe0yZ
        EC/tdsOMI4E9Xs2ltcuBY+RGX30zHjo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-XKWNAxuZN5CakOyqXT0WkQ-1; Tue, 01 Mar 2022 05:52:42 -0500
X-MC-Unique: XKWNAxuZN5CakOyqXT0WkQ-1
Received: by mail-wm1-f72.google.com with SMTP id ay7-20020a05600c1e0700b003813d7a7d03so1035754wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4B4atLkDITMoub+rHSsBV+3F1nWD6FbRljQkexCK2/s=;
        b=hgrKqj4oNJgHIfsQq5IHxs6kqho5VRRR2h1sknalmrlaaVBY0BJdlNgmZDfLkOLa9k
         JBxECgJhwqUVg65GZvOM2cQsB/p6Rxc0WRTY5c0Q3NKudjFfbxOySeeYtIdM2eRHMhAO
         96ePPlgIs7lI1cFyFrSoDlZ/qG/OzYQp0j1Co1RkUZoGW8GBDuOUWKPSLCc/aYnKscwr
         UQU4puy/HJTNsfTW1to6GH0POLMFahHZfjDAU9woIOwSLVbZnX0W6OhXecreQ3+chkDa
         Ie8wN6pG4YbV9DE4e0O83dnyixkdfD/5k/fn2e4KsU7WfrBbO3VieRe15LT1sj/IfcrZ
         psFw==
X-Gm-Message-State: AOAM532RZWVGVfLUm3OEo4s0QTw9EoheJgQ5RPNxC6EbNQxG4MZ1m/2L
        TIiSlOubXOheDlNfKo1AgIDJ5/UcHTKZAZEOVvafEqdeE2ARPFuZilevIRL3uhCBzyo4TcvknWQ
        NbEOEayCptePIafUbkrzz1CWq
X-Received: by 2002:a05:600c:154b:b0:381:8148:64d with SMTP id f11-20020a05600c154b00b003818148064dmr3423712wmg.98.1646131960950;
        Tue, 01 Mar 2022 02:52:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKX4vaY/hTWQjHshhYhaGbJBz9CeZyOjB0CrVVscgUibX1V0+GjJh9k+/nu5TSLOeRT5X6WQ==
X-Received: by 2002:a05:600c:154b:b0:381:8148:64d with SMTP id f11-20020a05600c154b00b003818148064dmr3423698wmg.98.1646131960696;
        Tue, 01 Mar 2022 02:52:40 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8? ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm2067953wmh.31.2022.03.01.02.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:52:40 -0800 (PST)
Message-ID: <b604526d3186f6cd3da189abb70bd1ad9a6105c5.camel@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        rostedt@goodmis.org, paulmck@kernel.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, mtosatti@redhat.com
Date:   Tue, 01 Mar 2022 11:52:38 +0100
In-Reply-To: <137d3573-051f-5374-70d6-cc99b44d00da@kernel.org>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
         <137d3573-051f-5374-70d6-cc99b44d00da@kernel.org>
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

On Mon, 2022-02-28 at 21:00 +0100, Daniel Bristot de Oliveira wrote:
> On 2/28/22 15:14, Nicolas Saenz Julienne wrote:
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
> 
> Does this restrict to only isolcpus cpus?

nohz_full CPUs actually, IIUC HK_FLAG_MISC isn't set if isolcpus is used, which
is deprecated anyway.

> what if this CPU was isolated via other methods?

osnoise with an uncontested FIFO priority for example? I believe in that case
RCU will start throwing "rcu_preempt detected stalls" style warnings. As it
won't be able to preempt the osnoise CPU to force the grace period ending.

I see your point though, this would also help in that situation. We could maybe
relax the entry barrier to rcu_momentary_dyntick_idle(). I think it's safe to
call it regardless of nohz_full/tick state for most cases, I just wanted to
avoid the overhead. The only thing that worries me is PREEMPT_RT and its
rt_spinlocks, which can be preempted.

> > +		    tick_nohz_tick_stopped()) {
> > +			local_irq_save(flags);
> 
> This code is always with interrupts enabled, so local_irq_disable()/enable()
> should be enough (and faster).

Noted.

> > +			rcu_momentary_dyntick_idle();
> > +			local_irq_restore(flags);
> > +		}
> 
> Question, if we set this once, we could avoid setting it on every loop unless we
> have a preemption from another thread, right?

This tells RCU the CPU went through a quiescent state, which removes it from
the current grace period accounting. It's different from an extended quiescent
state, which fully disables the CPU from RCU's perspective.

We don't need to do it on every iteration, but as Paul explained in the mail
thread it has to happen at least every ~20-30ms.

Thanks!

-- 
Nicolás Sáenz

