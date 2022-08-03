Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8CD58910E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiHCRNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiHCRNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:13:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7FD2B606
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:13:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso1240580wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z5OCnAW+PZcXkMuuSs1kQUCSIWwKc63YJXF5AYyiWvs=;
        b=jNNajHux+HCM22nbhhvKyjG4WoGztDqTWXsUT0YtHR3batWmdxWXFnqaqiSopvjHc3
         /q1Evq/wAS3WzGgNLVZ2T3fi2OQwh6/pNum0yWBmfZaZSNKFGYM9U1AX+eVs0QqBLwq8
         3ZkDdWfO2MviryspuE8bnKOcv3z6eB0kLiKPOj1MxnvXwsjBsZwT7j51/5prDFdehf+F
         DD4pFJY8PjlIIOkWD7HkUDaiQfOaYId9DA16qO+j6sCbKo1GhZvus6ebdZ7Y4kG1XSJ1
         VX0Ihqkx9BwYz4pqX4Qsqd2IWKmwmzPtDBZbWBH9ooVIgPRjOdLLEbAEAU02d4AufWjM
         2Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=z5OCnAW+PZcXkMuuSs1kQUCSIWwKc63YJXF5AYyiWvs=;
        b=HKNpgSa1CY8bhprTF9LLnQ7lV2//dtcULWoPfkq4ktGk9n5nMlXjWqUF+zw6r79ZMX
         EaliMv1wyRx/W1xRyjK3hTP59hHQVemGKCbylAD2EvHtSAdAwrr/1hMKhf7eRcKtnKVW
         XhSX1HHhJePJuZhBjuuFek+Cx8dmCIp2MYV+U6whYIJTkK3qP+Jz+bIzziIlnqVPiucp
         Sx/RT6GwizduTSlTKkJb6Y2+3H1Y1pQtliFTuki/GegUMZn6BU5Nmj6TrF7vmEqBFFgG
         hkEcpM4CFLIyV1+eu1+KdAtKm/HPvk7wL+pOAM6pnIsW1vN6HMr5UnONMzenz8EdNJb4
         AMsg==
X-Gm-Message-State: ACgBeo3yPt6p2uuFOX2SOourEBGWx+ohdxlXOC+7F4p5Dgj28GV9H6rE
        rynty5bHMuHaB4hyVrBDr5AtgKjHRjI=
X-Google-Smtp-Source: AA6agR5McKuf/+273ZPdXBk02sh4g5+7ZlL1wsyoTiTCBCQNciKm76ckF2TutvNRUsFMMu/+Ol7vAQ==
X-Received: by 2002:a05:600c:3d06:b0:3a3:58f6:9d96 with SMTP id bh6-20020a05600c3d0600b003a358f69d96mr3504341wmb.195.1659546784116;
        Wed, 03 Aug 2022 10:13:04 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id t4-20020adfeb84000000b0021e45afa7b0sm18918509wrn.109.2022.08.03.10.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:13:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 19:13:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Liu Song <liusong@linux.alibaba.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] sched/debug: avoid executing show_state and causing rcu
 stall warning
Message-ID: <YuqsnX6LYxe34YN3@gmail.com>
References: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
 <20220803084235.5d56d1e4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803084235.5d56d1e4@gandalf.local.home>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> [ Adding Paul ]
> 
> On Wed,  3 Aug 2022 09:18:45 +0800
> Liu Song <liusong@linux.alibaba.com> wrote:
> 
> > From: Liu Song <liusong@linux.alibaba.com>
> > 
> > If the number of CPUs is large, "sysrq_sched_debug_show" will execute for
> > a long time. Every time I execute "echo t > /proc/sysrq-trigger" on my
> > 128-core machine, the rcu stall warning will be triggered. Moreover,
> > sysrq_sched_debug_show does not need to be protected by rcu_read_lock,
> > and no rcu stall warning will appear after adjustment.
> > 
> > Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> > ---
> >  kernel/sched/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 5555e49..82c117e 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8879,11 +8879,11 @@ void show_state_filter(unsigned int state_filter)
> >  			sched_show_task(p);
> >  	}
> >  
> > +	rcu_read_unlock();
> >  #ifdef CONFIG_SCHED_DEBUG
> >  	if (!state_filter)
> >  		sysrq_sched_debug_show();
> 
> If this is just because sysrq_sched_debug_show() is very slow, does RCU
> have a way to "touch" it? Like the watchdogs have? That is, to tell RCU
> "Yes I know I'm taking a long time, but I'm still making forward progress,
> don't complain about me". Then the sysrq_sched_debug_show() could have:
> 
> 	for_each_online_cpu(cpu) {
> 		/*
> 		 * Need to reset softlockup watchdogs on all CPUs, because
> 		 * another CPU might be blocked waiting for us to process
> 		 * an IPI or stop_machine.
> 		 */
> 		touch_nmi_watchdog();
> 		touch_all_softlockup_watchdogs();
> +		touch_rcu();
> 		print_cpu(NULL, cpu);
> 	}

I'd much rather we use the specific exclusion primitive suitable for that 
sequence - in that case it should be cpus_read_lock()/unlock() I suspect.

But the entire code sequence should be reviewed - do we anywhere walk task 
lists that need RCU protection?

My main complaint was that we cannot just randomly drop the RCU lock with 
no inspection of the underlying code.

	Ingo
