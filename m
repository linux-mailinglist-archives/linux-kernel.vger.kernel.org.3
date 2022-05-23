Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA1E531D93
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiEWVTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiEWVTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:19:48 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F958E1BF
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:19:48 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ff155c239bso162876547b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLDY4cmr222gssu19D12pJ5dYihqNZnukAxsU+Y1ejU=;
        b=TpnIFJb7O/pdBIh8GUMlw6sWMXiJFEVNwuRhxPHn/pS6eG4jN6V0v2RzhCj/pd35EC
         8lq2QhNInOnvmqq/zm4SEz7YYfPZ5EQYXPjVarG0ekP3j3lvV8K8HIbeyz9ASKnTk4QS
         LP+4y+UfTGkKM4PdkuW0IVuwO5VawqXUTE5pnWjLtqVgS6nWJtSXnw7D5Hn8VBOA1T5S
         7G/KKhAAwpio8PNKPqvbIJBJyp4ZV4MJZllDzlxdv5reJbK6keUzJ4cAY6yRl1qIXoUQ
         CbrS65lral4Fx6CrW683Kz+ekjveuKIrfouYulpG/Z6Fsue+KcdNmeGw6+02Lawm4lhM
         YS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLDY4cmr222gssu19D12pJ5dYihqNZnukAxsU+Y1ejU=;
        b=HZoBZMBP40Mvmqq9W1WvQgPThKeKp88tpb8ZdvyjaNYrois07ZtAWKkn+W6keEKBIZ
         9Ve+8oHmyMdvaMCVg8gSn68j/3DHsy0y+k/PDof0anMRs8ec1ZxPTZjmM0PDAQfY5ayF
         wnYhWw8v+S/K+YcpNlNdmE0nGyTGzP01vmm/XeagFaqYy2v6DXCEj1nqSZL7tvVIsTQw
         Lb0snbduxdP+c00x2M2tWCvcyKrfEoHFREp1GoU9XiVfsAO14eyXg+AkzWtuT0piV8Ze
         +DhWHjAIWW9JlZfg6rIBf9J4aqiMYVLDzYMX1ImVwQ3Q17b1ggvzsr3w0ZP9PzibaIl2
         BQQA==
X-Gm-Message-State: AOAM533rTrPrZFL4qvFDT1bXmv5WKVg491GBzClJ51aokCXW5CNZoGwp
        vMxruiVBNZiku7DNgzKtvAm4W34iUjskoeQU+SQ+RQ==
X-Google-Smtp-Source: ABdhPJxt8kx6z5PYnwwImB38ZeXt2ruBXVuGVWJUKy4FdUXc1K+c+OD39mj78O+sHHvTXJPM1vetIs7qpZw7Y3/ZVsM=
X-Received: by 2002:a81:2388:0:b0:2ff:a07a:517a with SMTP id
 j130-20020a812388000000b002ffa07a517amr16294486ywj.201.1653340787230; Mon, 23
 May 2022 14:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220520235138.3140590-1-joshdon@google.com> <20220521100037.GA2578@worktop.programming.kicks-ass.net>
In-Reply-To: <20220521100037.GA2578@worktop.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 23 May 2022 14:19:36 -0700
Message-ID: <CABk29NuaNSCs-sXsDjkEbnFChRsqUYPWG9VrwS=O88Q1aMzuNA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/core: add forced idle accounting for cgroups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 3:00 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 20, 2022 at 04:51:38PM -0700, Josh Don wrote:
>
> > diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> > index 38a2cec21014..ddef2b8ddf68 100644
> > --- a/kernel/sched/core_sched.c
> > +++ b/kernel/sched/core_sched.c
> > @@ -277,7 +277,11 @@ void __sched_core_account_forceidle(struct rq *rq)
> >               if (p == rq_i->idle)
> >                       continue;
> >
> > -             __schedstat_add(p->stats.core_forceidle_sum, delta);
> > +             /*
> > +              * Note: this will account forceidle to the current cpu, even
> > +              * if it comes from our SMT sibling.
> > +              */
> > +             account_forceidle_time(p, delta);
> >       }
>
> AFAICT this is the only caller of that function.
>
> >  }
> >
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index 78a233d43757..598d1026d629 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -226,6 +226,17 @@ void account_idle_time(u64 cputime)
> >               cpustat[CPUTIME_IDLE] += cputime;
> >  }
> >
> > +
> > +#ifdef CONFIG_SCHED_CORE
> > +/* Account for forceidle time due to core scheduling. */
> > +void account_forceidle_time(struct task_struct *p, u64 delta)
> > +{
> > +     schedstat_add(p->stats.core_forceidle_sum, delta);
>
> But then you loose the __, why?

Yea, this is probably better off as __ and a comment on the function
stating that it requires schedstat is enabled. My original thinking
was that it would be nice to avoid capturing this requirement here for
future potential use cases, especially given that the
schedstat_enabled() check is basically free anyway.

> > +
> > +     task_group_account_field(p, CPUTIME_FORCEIDLE, delta);
> > +}
> > +#endif
