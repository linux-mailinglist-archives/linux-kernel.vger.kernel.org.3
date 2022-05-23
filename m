Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF7E531A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiEWUaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiEWUaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:30:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74327F2F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:30:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 31so14612412pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n7fUAxt+82CsizWnMlCZf98dHnI7u5OUTGdwgpxnSjo=;
        b=mZerlrpDGB5mhhRV34plfqZfV9LodLPAP8SjLREHFpWzCQuEprqcEum3X+qhfLfGLv
         V1lZ+pgKoaQxaI0UCDqOMicdGUKwj067xQ4twxZK1rJSNsjQu1dZ9HRGZccgwsIyYoyR
         ndACwpQnu1dDenXYwD8SuKGL/d3bFILpB0Zgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n7fUAxt+82CsizWnMlCZf98dHnI7u5OUTGdwgpxnSjo=;
        b=F5G6s/iPwz7ybHUCJbCTvoBzIRoM53uZ0ZGvpMvrQDxst6dhk83YDXMrPitTP9LAKM
         9GwrfqQZMg4WJ3keNzxI4Jrcac01K1nFdf4ITBY9ikWLV7h2v16FGf289PPYaVYBP7SG
         956r4Q8lc/OMY0rU3roQ34h9JJ3MGz0CBKQT7Kz3u8MBSUzqPmE/D7EzJPCMVx+Gksjy
         aNq17Oezkb9pNU3HkMdL43CTfXySKbUBaim1YghpRxP9gA2C3fJVU+fMA3qm2pnCmNZ2
         P8LN4MwhnTZAiVUiYPD/oTwZ8tpcqx4UouNMJ3UcRbYAbKoFcDyIq0I1dazylvOSXmiT
         S3Mg==
X-Gm-Message-State: AOAM530Q64bnxbt7oi2pbdtTYC/ifQeCnBIKsUGDrKysgMSufVLa00wJ
        ztyNR6p/Ik/vmZrIT2vvTTLQVA==
X-Google-Smtp-Source: ABdhPJx63phKcpO0uZPYB27l4UtMxX68hXxpZO2pMLP4x0d6kJfgCdKhMS16dWLmGoPAyCVkRynQ8w==
X-Received: by 2002:a05:6a00:198f:b0:50e:7e6:6d5c with SMTP id d15-20020a056a00198f00b0050e07e66d5cmr24908263pfl.20.1653337816886;
        Mon, 23 May 2022 13:30:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u8-20020a170903124800b0016196bd15f4sm5650102plh.15.2022.05.23.13.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:30:16 -0700 (PDT)
Date:   Mon, 23 May 2022 13:30:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sched/psi: Bounds-check state iterator against
 NR_PSI_STATES
Message-ID: <202205231305.E93AAFAA07@keescook>
References: <20220520165826.2140252-1-keescook@chromium.org>
 <YouX6g1T7w3FDeM8@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YouX6g1T7w3FDeM8@cmpxchg.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 10:19:22AM -0400, Johannes Weiner wrote:
> On Fri, May 20, 2022 at 09:58:26AM -0700, Kees Cook wrote:
> > GCC 12 cannot tell that "t" will be bounded by NR_PSI_STATES, which could
> > lead to walking off the end of the tasks array, which is NR_PSI_STATES in
> > size. Explicitly bounds-check "t" as part of the loop.
> > 
> > In file included from ../kernel/sched/build_utility.c:97:
> > ../kernel/sched/psi.c: In function 'psi_group_change':
> > ../kernel/sched/psi.c:730:38: warning: array subscript 32 is above array bounds of 'unsigned int[5]' [-Warray-bounds]
> >   730 |                         groupc->tasks[t]++;
> >       |                         ~~~~~~~~~~~~~^~~
> > In file included from ../include/linux/psi.h:6,
> >                  from ../kernel/sched/build_utility.c:36:
> > ../include/linux/psi_types.h:84:22: note: while referencing 'tasks'
> >    84 |         unsigned int tasks[NR_PSI_TASK_COUNTS];
> >       |                      ^~~~~
> > ../kernel/sched/psi.c:730:38: warning: array subscript 32 is above array bounds of 'unsigned int[5]' [-Warray-bounds]
> >   730 |                         groupc->tasks[t]++;
> >       |                         ~~~~~~~~~~~~~^~~
> > ../include/linux/psi_types.h:84:22: note: while referencing 'tasks'
> >    84 |         unsigned int tasks[NR_PSI_TASK_COUNTS];
> >       |                      ^~~~~
> > 
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  kernel/sched/psi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index a337f3e35997..827f16a79936 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -725,7 +725,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
> >  		}
> >  	}
> >  
> > -	for (t = 0; set; set &= ~(1 << t), t++)
> > +	for (t = 0; set && t < ARRAY_SIZE(groupc->tasks); set &= ~(1 << t), t++)
> >  		if (set & (1 << t))
> >  			groupc->tasks[t]++;
> 
> This is a very hot path, it runs for every nested cgroup on every task
> switch, wakeup and sleep. We should avoid unnecessary instructions and
> branches if we can help it at all.
> 
> Does the below patch address the warning for you? I can't test it
> myself, because I'm not getting it with gcc version 12.1.0. It's also
> odd that it didn't warn you about the loop over `clear' a few lines
> up, which ostensibly has the same "problem".

It seems this is a GCC 12 bug. Array indexes that have been used with a
shift end up miscalculated when building also with -fsanitize=shift
(i.e. allmodconfig):

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105679


> 
> ---
> 
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index c7fe7c089718..113861343733 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -41,6 +41,7 @@ enum psi_task_count {
>  #define TSK_RUNNING	(1 << NR_RUNNING)
>  #define TSK_ONCPU	(1 << NR_ONCPU)
>  #define TSK_MEMSTALL_RUNNING	(1 << NR_MEMSTALL_RUNNING)
> +#define TSK_MASK	((1U << NR_PSI_TASK_COUNTS) - 1)
>  
>  /* Resources that workloads could be stalled on */
>  enum psi_res {
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index a4fa3aadfcba..fb7fd40af337 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -804,6 +804,8 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>  	void *iter = NULL;
>  	u64 now;
>  
> +	WARN_ON_ONCE((clear|set) & ~TSK_MASK);
> +
>  	if (!task->pid)
>  		return;

I'll give this a spin.

Thanks!

-Kees

-- 
Kees Cook
