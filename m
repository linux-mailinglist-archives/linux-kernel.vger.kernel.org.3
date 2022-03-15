Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2084D9CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348829AbiCON4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiCON4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:56:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62BF53E0A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:55:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w27so33172991lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wbMw4cdXweFkAK6j6U5W3V1cAn1OdMOoliVOt8SyHS0=;
        b=JV5Ehtv1rh9HFbOVWcAFnBeIPRNwqANJ+lB/BoC0ugx9NEWIR4C7uMn2MR547JYTuV
         IufzHYUIRj1drdLHyDPPa4RCno6aPt8/R2PK2WsW5v8DiUz1hFXJrKwZ2BGfF8hE6VOK
         MnOL+/sCmSQSjWQQlZdqMwMphyh0d3731ERhONIpFuEcUxXRxS1RKlB1uEZGSrdjSKb9
         1c6Ji3VJJcJnNaxXA1raUTKG5v0VnFylwGG7TC8OmZe/naqUr4Gn/hvlPL3giYt6swo2
         BsmC6dUDWQr08KkyaN/IqdYKbh5ZiPSo6J7N7WOB6aKleSuCKOKVh6shvYp7odcC7idA
         WwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbMw4cdXweFkAK6j6U5W3V1cAn1OdMOoliVOt8SyHS0=;
        b=pfXFr6OHIr1URDjQv0Fed8KFkw9dC3yiE6QSZ5LKLEbywtRtbM++weSd7/FgfN5SxM
         zxdA4VW0gZLL+Pc9oxWqhplLeC23EEi1eYw0S++Uv+Q077HtS5GtCwIkOFhZZ0BnZjRO
         clW9cd9yOqrjFWfJEqfsEip2xt+WhM/9OetHqG/yRDYJdoq9Sa78vPxXejKGqCmMX70m
         8mLbh7oPjo5PI+BGn5928831Tbx6x7ozZGS9GI1hShUM53UKBfqeKK99iVlob5xFRoQG
         b1/xZmM0ix2rgCV7T7xGVIJDmtY0gJ2ILTIlTLRFBtcl+qh5BXbP3knyr6bXnqbu5RpS
         rKNw==
X-Gm-Message-State: AOAM533Ko83MFa7ftnkwHm0ndhBpw7dgEqtDGiBF5ytFk2OMJT8rrTi4
        MCQ8mnPS5fuRGc4sQiGe9AIV3y/BUffcoAIWR5UKrA==
X-Google-Smtp-Source: ABdhPJxkQD6dRSrEehRpxRdDZXZY8AoZTvSe2x1vQIuaH/oGsQuXBOvnBU298Ua03OwyzD0dEgBQFeYGYk+aGFfPvng=
X-Received: by 2002:ac2:554a:0:b0:448:2a09:66eb with SMTP id
 l10-20020ac2554a000000b004482a0966ebmr17025105lfk.645.1647352502958; Tue, 15
 Mar 2022 06:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-6-vincent.guittot@linaro.org> <CABk29Numf595wF6PiLd673TmFt6AV9qTEsWP7tSf2xPOKcGgLQ@mail.gmail.com>
In-Reply-To: <CABk29Numf595wF6PiLd673TmFt6AV9qTEsWP7tSf2xPOKcGgLQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Mar 2022 14:54:51 +0100
Message-ID: <CAKfTPtD0kFuyh+Q3po0UHR3GQz1uKGxRrFWDfsHcCuQr4ZWbNQ@mail.gmail.com>
Subject: Re: [RFC 5/6] sched/fair: Take into account latency nice at wakeup
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, parth@linux.ibm.com,
        Qais Yousef <qais.yousef@arm.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        Paul Turner <pjt@google.com>, pavel@ucw.cz,
        Tejun Heo <tj@kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>, qperret@google.com,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 at 01:53, Josh Don <joshdon@google.com> wrote:
>
> Hi Vincent,
>
> On Fri, Mar 11, 2022 at 8:21 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> [snip]
> > +
> > +static void check_preempt_from_idle(struct cfs_rq *cfs, struct sched_entity *se)
> > +{
> > +       struct sched_entity *next;
> > +
> > +       if (se->latency_weight <= 0)
> > +               return;
> > +
> > +       if (cfs->nr_running <= 1)
> > +               return;
>
> I don't quite understand this nr_running check.

just to return early if there is no other task running on the cfs

>
> > +       /*
> > +        * When waking from idle, we don't need to check to preempt at wakeup
> > +        * the idle thread and don't set next buddy as a candidate for being
> > +        * picked in priority.
> > +        * In case of simultaneous wakeup from idle, the latency sensitive tasks
> > +        * lost opportunity to preempt non sensitive tasks which woke up
> > +        * simultaneously.
> > +        */
> > +
> > +       if (cfs->next)
> > +               next = cfs->next;
> > +       else
> > +               next = __pick_first_entity(cfs);
> > +
> > +       if (next && wakeup_preempt_entity(next, se) == 1)
> > +               set_next_buddy(se);
> > +}
> > +
>
> What's the motivation to do this with the next buddy vs using wakeup
> entity placement to achieve a similar result? The latter would also

I don't want to modify vruntime because of latency prio because it
would mean impacting the cpu bandwidth of the task which is managed
with nice priority. latency nice is only  about preempting current
running task

> more generically work when we aren't transitioning from idle. It also
> doesn't suffer from some slight weirdness here in the interaction with
> core scheduling, where rq->curr can be idle despite the presence of
> runnable tasks if the cpu is forced idle.

TBH, I haven't looked in details the core scheduling part which adds
another level of complexity when selecting which task should run on
the core
