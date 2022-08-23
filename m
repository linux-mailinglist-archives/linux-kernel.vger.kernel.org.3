Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709D459CE14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiHWBvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbiHWBvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:51:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE72D5A88C;
        Mon, 22 Aug 2022 18:51:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pm13so3778306pjb.5;
        Mon, 22 Aug 2022 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xRLqqAddV6ec5UBrYobxapckZ++aOG4IqWHgzXgYmDA=;
        b=ddFQIxJnCbPvSloECjr5AI1aW5WXxjrgGBEhWQpywPPSCAGAA7Q5+G1ANyNPJMBHsN
         UYKWT8tHhGbOXEpqBwCEH3pLwk/bihUWYxixJvNzyApkqbLec3z5OBc8SuIRul8rDwFy
         z8mPyBWX7Z2e1BfNkkxyCFifCUv4rDV4lUceT/z269YoSaQVXvA1OJ1K/qVFYFIDfw/M
         PRZ+zJ5PwfRJ6QKwH+9ZWFN7e+hS/aCqYETaGUkwZ7FoYnOG4UUA7gqwqY4WzSlk0iOq
         ku7CQKDw+1m6hfLw/lfc/8/4UTuJ1avUzYrqCwby3MV87/qBLdUFuanUVu72aGgrjLSU
         tiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xRLqqAddV6ec5UBrYobxapckZ++aOG4IqWHgzXgYmDA=;
        b=NEsSWiqlsqzfOzQ3XV3Sr58eogNc4RPGIZSNXkw6JsI+c51BcXz+uayIQXzVuNdord
         wI45hSdmFSxBROPpAoZrLlB/WtteK/i4L+WMJL0oERFiTwGs7bFjJCo4DcWvLmdbjtIR
         DI8wPj3CO39E+l3aaEQv5vGHvUEsZuFCDNFFu15Z9QduRpHGd0rdsIMH2nvYgnDHERJl
         rgxKNmNOVNpAhssFTGkkishitxyntEB0sULwajwgbwk/t6rM4/KoqU99Ky1XnwrnG51m
         9c+5I/+MfXBVuYB8TN34oXpseC0Au+Y/K9MIR+tn21722XDpcR8Kz8c1nmVoCftrSjbA
         c+2g==
X-Gm-Message-State: ACgBeo05od/NvblxQxgmzuBmhuEHJhjrPgr7YZtjZjlZBlUwsM7ZNDz0
        /i+BoIFtgU/27LXows7CAA==
X-Google-Smtp-Source: AA6agR5CNIokLQJhXl1jkrJxL5Kago8LD+Gheiv++i4KuBcludW/Ep920nkYaZmyX17iW8LUXLUsag==
X-Received: by 2002:a17:90b:4012:b0:1fa:df52:16ad with SMTP id ie18-20020a17090b401200b001fadf5216admr1067088pjb.198.1661219464428;
        Mon, 22 Aug 2022 18:51:04 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902d14200b0016dbe37cebdsm8979703plt.246.2022.08.22.18.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 18:51:03 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:50:56 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, boqun.feng@gmail.com
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
Message-ID: <YwQygLBtzqwxuMIJ@piliu.users.ipa.redhat.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
 <20220822021520.6996-7-kernelfans@gmail.com>
 <20220822024528.GC6159@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822024528.GC6159@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 07:45:28PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 22, 2022 at 10:15:16AM +0800, Pingfan Liu wrote:
> > In order to support parallel, rcu_state.n_online_cpus should be
> > atomic_dec()
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> 
> I have to ask...  What testing have you subjected this patch to?
> 

This patch subjects to [1]. The series aims to enable kexec-reboot in
parallel on all cpu. As a result, the involved RCU part is expected to
support parallel.

[1]: https://lore.kernel.org/linux-arm-kernel/20220822021520.6996-3-kernelfans@gmail.com/T/#mf62352138d7b040fdb583ba66f8cd0ed1e145feb

Thanks,

	Pingfan


> 							Thanx, Paul
> 
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Steven Price <steven.price@arm.com>
> > Cc: "Peter Zijlstra
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > To: linux-kernel@vger.kernel.org
> > To: rcu@vger.kernel.org
> > ---
> >  kernel/cpu.c      | 1 +
> >  kernel/rcu/tree.c | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 1261c3f3be51..90debbe28e85 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1872,6 +1872,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
> >  		.name			= "RCU/tree:prepare",
> >  		.startup.single		= rcutree_prepare_cpu,
> >  		.teardown.single	= rcutree_dead_cpu,
> > +		.support_kexec_parallel	= true,
> >  	},
> >  	/*
> >  	 * On the tear-down path, timers_dead_cpu() must be invoked
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 79aea7df4345..07d31e16c65e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2168,7 +2168,8 @@ int rcutree_dead_cpu(unsigned int cpu)
> >  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> >  		return 0;
> >  
> > -	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> > +	/* Hot remove path allows parallel, while Hot add races against remove on lock */
> > +	atomic_dec((atomic_t *)&rcu_state.n_online_cpus);
> >  	/* Adjust any no-longer-needed kthreads. */
> >  	rcu_boost_kthread_setaffinity(rnp, -1);
> >  	// Stop-machine done, so allow nohz_full to disable tick.
> > -- 
> > 2.31.1
> > 
