Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2B4BA783
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbiBQRww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:52:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbiBQRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:52:49 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B17294135;
        Thu, 17 Feb 2022 09:52:34 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id bn33so593701ljb.6;
        Thu, 17 Feb 2022 09:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=odal8DH5pq4vSKy8tZSfPA+PF6EZNhV2ZjcnGJCW6aw=;
        b=FEQtUlzEqs4JH4nRW0z84i6cKotJD4Wy5qjTbbgz811YfzovswR7InsAo9d8fncgDi
         jZ1RzFmE9zZEjMf04CIVEqbnorx7HIyft8mMPmDeaXdpTYnCdYPYndtzBAkKfYgUtJNq
         oH6v6+lgvDOzE7H/zduVedPvtOUGJCO2UnIZX+PqNdLoPvy3xgd1w5vlu0XXwd+v+REX
         Ypj7lyd2mvp0CJ2K0ziAYKoPLrzBeqn7BrNGNp4SQjOe2mPSOmZ7UGOsRKvU8w47iugT
         e15/ye1m8INw9AzALYjDNHc1AQR/WQ1eZnlFzcQLtTsODkNrpSvaUDc/PzuMZRClE8Kk
         wSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=odal8DH5pq4vSKy8tZSfPA+PF6EZNhV2ZjcnGJCW6aw=;
        b=qcFUqz3FThutI7t4hXfvPY9ognRuvDAoF08XMSs3wnSqeWH7PTfE22IprQmBLxd6bc
         1MofmzPZWA0GwZ31sqlQ5KNTVs+mdrK1HvC292g0yJkyBNSwIXL2D3LZb4qE6JKA7IJw
         Cu4pSgyCUNyRKtv3bFrLePlLHL+8WNj0Q/P+RmdwWEY2NgPthDG+HQF5uZuYq1dUEBQo
         Rg1KPQF//3jjtKkKuH6qvWB1KlzfoSPT7sLISiZCqnxIGvfRqedp58k7v113FjsZxbxB
         NppYDDxc6cH/1WRF9SUrxlQjXtkgDgKO4+x0ByihYiw3kr/XPvko0LUkPN9MQAB3B26L
         OIcQ==
X-Gm-Message-State: AOAM530TMYLdJVX2GdqSCJSfG4U5Lr+LCOXoRMQkr4RrLmBkcS9hjKgD
        WfZQJDGVve9TkrH3kDjG3mQ=
X-Google-Smtp-Source: ABdhPJzIpumdgpKYKZdpvSS42smT5+JGOqe04EHV949NqkDTnxLaXe0V7OI4rDbw4/jBJ+K3L/Ud5Q==
X-Received: by 2002:a05:651c:202:b0:244:c45d:102 with SMTP id y2-20020a05651c020200b00244c45d0102mr2881890ljn.29.1645120352742;
        Thu, 17 Feb 2022 09:52:32 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c11sm26512lfm.32.2022.02.17.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:52:32 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 17 Feb 2022 18:52:30 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>
Subject: Re: [PATCH 1/1] rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
Message-ID: <Yg6LXv+XS85TXoEb@pc638.lan>
References: <20220216135209.3070-1-urezki@gmail.com>
 <20220216195508.GM4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216195508.GM4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 11:55:08AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 16, 2022 at 02:52:09PM +0100, Uladzislau Rezki (Sony) wrote:
> > From: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > 
> > Currently for both expedited and regular grace periods stall
> > warnings are emitted based on one timeout value that is defined
> > in seconds. The problem is that, a stall timeout in seconds for
> > expedited grace period is a way long.
> > 
> > The idea of expedited grace period is to force CPUs to report
> > their quiescent states as fast as possible. If in RCU read-side
> > critical section, it will request the next rcu_read_unlock() to
> > record the quiescent state. If not either it reports immediately
> > or set TIF_NEED_RESCHED to initiate the task switch.
> > 
> > Therefore introduce the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT kernel
> > configuration that is set to 20 msec. It also can be changed in
> > run-time via: /sys/.../parameters/rcu_exp_cpu_stall_timeout.
> > 
> > Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Nice, thank you!
> 
> I have queued this, with the usual wordsmithing.
> 
> I also changed the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT kconfig option's
> default to be 20 milliseconds only no CONFIG_ANDROID=y kernel builds.  For
> one, rcutorture gets expedited stall warnings even at 200 milliseconds,
> and for another, larger systems often have longer-running readers.
> It might be a very good thing to decrease the non-Android default
> expedited stall warning timeout, but 20 milliseconds is not likely the
> place to start that effort.  Though it would be one way to find out
> when in the process large-system users started testing.  ;-)
> 
> My guess is that this change will result in some breakage even on Android,
> and that adjustments will be needed.  Once that effort is complete,
> it would probably make sense to take another look at the non-Android
> default for CONFIG_RCU_EXP_CPU_STALL_TIMEOUT.
> 
Yep, totally agree. There will be needed an addition adjustment later on to
find some better floor value :) 

--
Vlad Rezki
