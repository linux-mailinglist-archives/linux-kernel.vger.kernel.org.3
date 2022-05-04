Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C87519DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348612AbiEDLSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347697AbiEDLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:18:39 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B918B26110
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:15:03 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f7ca2ce255so11318617b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 04:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxW+lWlP847ASX34MIveb+faYqbZvqJ0ywo9daFnGUg=;
        b=N6hYuyVd6GmMOSyHM3e+QGy9jv0/Kpl/7RwJ9CeJ/qxf0N894oBPcz6Lmum/ywbNva
         FShWASKy6kYNqPgOIYtiAJ7mSctlw5D2n/t/gPgoerQJls3LxpzBrlt+FELeOnlYuCsG
         rkK58EUoAVqmWQ+hVw4XRe8/COXSflVGa0S/gdGv+o+VynKfUEGTLaRuwWrqiZxR07km
         wE2+Nlzx50qk1/A2RGDlAyw0zHi7GadDBLlhoJe/dnMuQsiKCM2gqfa0aiqcMaXVZwmY
         WLaf/CF4VgJfoKDeXsZ6Bdg23nKWMRuSans2JSyCEkJQyBOzVWB7vVvYcgqO5+wejpA0
         y7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxW+lWlP847ASX34MIveb+faYqbZvqJ0ywo9daFnGUg=;
        b=SKx1okFW0sVdc4VB/+0KcYZJsPyiVlH+ig1QGndn0qkQl2MTyMvK6INdPQZzn8ID49
         BvUbX9qS86qLiNldOP7memjQDBut/cA6mwFDkNxozDiT8TqBbxu3OIPIEHoI5LTlQVzw
         nx3eOYonAPGOHGN/KCX/nwu2LmkLdXf4Mbek0ve1TOJnsBhe7L/sN+JUjb/fZtC8MbeA
         pAi2rGEAb6VXOlTo89cDA5Odv4wYvmafrlUM5yQnt6/mLglD9KzuTtBcJ8Vk27ModIWE
         jqjHD3f0Bu+akALwHkBCLnKFzMtTm3bc2lMTYhsJNqtz5SE5fpYEfQdWbjBWy9NYkJ21
         K51Q==
X-Gm-Message-State: AOAM530h/khiQfg5ryjoZPMEdjUa+vHEfPH90XZdwAjPmggfSOF5385y
        IApkOr0s6iv5uuFXwOj81nl+Ez9DFlOIP62CxTU=
X-Google-Smtp-Source: ABdhPJzQ1ZhNtwkqK2gjO7TXydOIKzW82WAONCs2TfcWIDbfV3nqm99qFDxuDEDnrYJD89CmillSe5PFhKS3k2Slm+Y=
X-Received: by 2002:a81:c54a:0:b0:2d6:435a:5875 with SMTP id
 o10-20020a81c54a000000b002d6435a5875mr18016117ywj.181.1651662902996; Wed, 04
 May 2022 04:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org> <20220311161406.23497-6-vincent.guittot@linaro.org>
In-Reply-To: <20220311161406.23497-6-vincent.guittot@linaro.org>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Wed, 4 May 2022 19:14:52 +0800
Message-ID: <CADjb_WTYPqenF_BhuiDyLduxpaHWCigg-jxAE3FYKTNkWvVz=Q@mail.gmail.com>
Subject: Re: [RFC 5/6] sched/fair: Take into account latency nice at wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        parth@linux.ibm.com, qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        Paul Turner <pjt@google.com>, Pavel Machek <pavel@ucw.cz>,
        tj@kernel.org, dhaval.giani@oracle.com, qperret@google.com,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 7:11 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Take into account the nice latency priority of a thread when deciding to
> preempt the current running thread. We don't want to provide more CPU
> bandwidth to a thread but reorder the scheduling to run latency sensitive
> task first whenever possible.
>
---------->8-------------------
>  #endif /* CONFIG_SMP */
>
> +static long wakeup_latency_gran(int latency_weight)
> +{
> +       long thresh = sysctl_sched_latency;
If I understood correctly, this is to consider the latency weight and
'shrink/expand'
current task's time slice thus to facilitate preemption. And may I
know why don't we use
__sched_period() but to use sysctl_sched_latency directly? Is it
possible the rq has
more than 8(sched_nr_latency) tasks thus the period is longer than
sysctl_sched_latency?

Thanks,
Chenyu
> +
> +       if (!latency_weight)
> +               return 0;
> +
> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> +               thresh >>= 1;
> +
> +       /*
> +        * Clamp the delta to stay in the scheduler period range
> +        * [-sysctl_sched_latency:sysctl_sched_latency]
> +        */
> +       latency_weight = clamp_t(long, latency_weight,
> +                               -1 * NICE_LATENCY_WEIGHT_MAX,
> +                               NICE_LATENCY_WEIGHT_MAX);
> +
> +       return (thresh * latency_weight) >> NICE_LATENCY_SHIFT;
> +}
> +
