Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA71052D563
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbiESN65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiESN5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:57:14 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAA8640B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:57:13 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e78so9146664ybc.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpmZe7NIgncmC9N5Bspzg+Tuz94sgQYIdXmKL335178=;
        b=UbSfSf+cHrp/fqAvzlPIukmPsm2yZAiAzIvOVpTFC1ax3EpfwM1oh2wSpg5QJu7J+Y
         +US+5PV3p2w9Lt8IAyCkyB+vJ1f9TEabZ/o5Eu7XXSGc6bIhdMuC2rN41u2oiPxLz+Tu
         X5owoj7sKN/7wfWrDQBfAjjE91h7IGUOjXI696QUHeq71PBqcs16laABCuc8Dk8lapzI
         4+Xa85Pq9uTRnmi1acqFRRvz3RD0u7r4iTF6wXwyExMv12q+uBI1TVfFg6Ulbq9KVvFv
         e16jAR3SS+79E//ssCktVATQTCm34b3vG7KwTwc272AxyHogy3MNyKODAiaZOafDsOzP
         sI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpmZe7NIgncmC9N5Bspzg+Tuz94sgQYIdXmKL335178=;
        b=dRQz6J4cMC08P9tCUMa9/yNg81gwN/oP8vj9Dl1sPC34oBdqleYNDeOfWwVMggAwNN
         LDjruNVj+YM8nrz0tTS3RsoNu1aTmDUKuN6+dhkGy47AsXPXEFhm9cthl/lUJSMyrXmF
         F5jBZN+Nj8M6Lv3ziONfuPXJ+mPS6mt8D8e9rCzFwzoR839UcMtROlXKH3qoT8QcDznw
         jALg6nbG9dG4/xmZhJOjheavfrRIv6YJeK4bivGSKEkHW6MM6H6noQFpK+rnfh9lGh+x
         6nVR8WbJeycM1PTJn4k7nlHd9yRiUHuqH+f/wLe5lSuvqgZGjvps6wf2gT2eKymJWmVU
         wCsw==
X-Gm-Message-State: AOAM531Z2PjKW1lprMO9YohaoGQW81vecq7TUkUH6HMFmd6cA+m7W3YV
        3a/OJ1MmsX11pULa7XupmENFu2eWR6uId3SxJCB5gQ==
X-Google-Smtp-Source: ABdhPJxIFrlCfgs+Luh8bEXz8FYlGZLPfAs3RDs44HxhE/iUUxVbiBlJ3RODTc+Pp0h1jzP1dYq4xu31QkqWR3OCQhk=
X-Received: by 2002:a25:5909:0:b0:64d:f503:33c8 with SMTP id
 n9-20020a255909000000b0064df50333c8mr4443107ybb.241.1652968633018; Thu, 19
 May 2022 06:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
 <20220512163534.2572-6-vincent.guittot@linaro.org> <CABk29Ns-3L1S2xuRg15VxzcXJyNpA6nB2A4jdM9eyx0jiWjn+Q@mail.gmail.com>
In-Reply-To: <CABk29Ns-3L1S2xuRg15VxzcXJyNpA6nB2A4jdM9eyx0jiWjn+Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 19 May 2022 15:55:25 +0200
Message-ID: <CAKfTPtCx_fhud-VsxCi9jS==yGavn7zgRBQyUfzXgbTiX2+77g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] sched/fair: Take into account latency nice at wakeup
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, parth@linux.ibm.com,
        Qais Yousef <qais.yousef@arm.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        Paul Turner <pjt@google.com>, pavel@ucw.cz,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
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

On Tue, 17 May 2022 at 02:54, Josh Don <joshdon@google.com> wrote:
>
> Hi Vincent,
>
> On Thu, May 12, 2022 at 9:36 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Take into account the nice latency priority of a thread when deciding to
> > preempt the current running thread. We don't want to provide more CPU
> > bandwidth to a thread but reorder the scheduling to run latency sensitive
> > task first whenever possible.
> >
> > As long as a thread didn't use its bandwidth, it will be able to preempt
> > the current thread.
> >
> > At the opposite, a thread with a low latency priority will preempt current
> > thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
> > wait for the tick to get its sched slice.
>
> Following up from the discussion on the prior series, I'm still not
> sure why this approach is exclusive of extending the entity placement
> code; I think both changes together would be useful.
>
> By only changing the wakeup preemption decision, you're only
> guaranteeing that the latency-sensitive thing on cpu won't be
> preempted until the next sched tick, which can occur at any time
> offset from the wakeup, from 0ns to the length of one tick. If a

In fact, you are ensured to run a minimum time of 3ms at least on >=8
cores system before tick can preempt you. I considered updating this
part as well to increase the value for negative weight but didn't do
it for now. I can have a look

> latency-tolerant task wakes up with a lot of sleeper credit, it would
> pretty quickly preempt a latency-sensitive task on-cpu, even if it
> doesn't initially do so due to the above changes to wakeup preemption.
>
> Adjusting place_entity wouldn't impact cpu bandwidth in steady-state
> competition between threads of different latency prio, it would only
> impact slightly at wakeup, in a similar but more consistent manner to
> the changes above to wakeup_preempt_entity (ie. a task that is not
> latency sensitive might have to wait a few ticks to preempt a latency
> sensitive task, even if it was recently sleeping for a while).
