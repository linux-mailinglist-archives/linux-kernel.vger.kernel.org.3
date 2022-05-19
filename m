Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB8152D5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbiESORY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239614AbiESORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:17:12 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858B566AF5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:17:05 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2f83983782fso58232047b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYHx5q9vFxG1twHSrXgPuM3RtmqmqfeF+w08Xx1F+50=;
        b=F1A42Q6w8v/anLZoUpynyHZkvmowjKyElNX0N/ZdpsgitxYvM+W0pvclKCST5/ZewX
         A4E0VWr3zwJrT/PUFL7Vo5FYEDu8S4dQKE6ZfXppqvMlXhqkWRCfmYiVrT9G60VprHrh
         AMVUPEPcgPVp5ziQw8q9bLSuIA2q0lXZ/o82hB0eIngGzaFuDqALVh6glNsOGgUdnIVr
         fI5NGC6N/5vUBNebsQXBXHy1DbhV7mCA/TdmJhoGrpBkhIAGhvMSc5qbB1pCyB6TTn5j
         41ltJTUT+XXORnV1FQRcGQnD1pkLHwri/vw1GRI6lKoNiXAPwHr6BvXoCkNWPZtWpaSW
         bWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYHx5q9vFxG1twHSrXgPuM3RtmqmqfeF+w08Xx1F+50=;
        b=CYt0qZyUuw8wzNq8Tv0IVas5TOXjuqOgWaYsmrCTqgJlThtscJnRNS5HWVAPqdvZOn
         ez65Nh6UG3SQcj2oMjB9t5Y80KE5r0JCz1STF/6thr6PI3SdTwX636fsTLNeY3jRW9/a
         gSoB9xAmywUH057fx8qRn+Fgyfl9HQ4xlaxJpoiOh/HsUkVBfAoCmXdytNh6w04xP2hk
         ittX8DhjYPkeyBXlpMVMOJJvagQyTNSGdwsakP1f8MLBGdkYX6CgbucRd1ivjjOaUgiI
         RYtnTUwvvviM8oUpN+ac6XJv3rQouZUfSo0igIK7gPesqxvPfHJQmJSYsHGxIpJq2iRw
         p5Fg==
X-Gm-Message-State: AOAM531OUmrOhSrazo2CxKBvbATyVCGVVb3nt+QxgcAz54rUGnYDLsSO
        TlKEl6vhAOU1eJ+00WzThw+c28ikV12SnRhHMTg14Q==
X-Google-Smtp-Source: ABdhPJyN/nGkbfhkIlHqEYMrDUOhX+eTQfoaAsvZataBzL9VQWZ+jA+D+5+P9vFpxG0qupIHnCaIIj4MAvEF6tFie4A=
X-Received: by 2002:a81:6189:0:b0:2eb:deb5:9f63 with SMTP id
 v131-20020a816189000000b002ebdeb59f63mr4679410ywb.319.1652969824670; Thu, 19
 May 2022 07:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220512163534.2572-1-vincent.guittot@linaro.org> <f1f50c52673aa1873b4a4d3b6b15250d4bf390f9.camel@linux.intel.com>
In-Reply-To: <f1f50c52673aa1873b4a4d3b6b15250d4bf390f9.camel@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 19 May 2022 16:16:52 +0200
Message-ID: <CAKfTPtBEHyP202duKwJi+GVNTMza+L_PuK3hmUxcjKnODOuRjw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add latency_nice priority
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, joshdon@google.com,
        len.brown@intel.com
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

On Fri, 13 May 2022 at 23:44, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Thu, 2022-05-12 at 18:35 +0200, Vincent Guittot wrote:
> > This patchset restarts the work about adding a latency nice priority to
> > describe the latency tolerance of cfs tasks.
> >
> > The patches [1-4] have been done by Parth:
> > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> >
> > I have just rebased and moved the set of latency priority outside the
> > priority update. I have removed the reviewed tag because the patches
> > are 2 years old.
> >
>
> Vincent,
>
> Thanks for introducing the feature again, which is much needed.  I am trying
> to look at the problem again from usage point of view. And wonder if
> there are ways to make the latency_nice knob easier to use.
>
> The latency nice value here is relative.  A latency sensitive task
> may not tell if setting the latency_nice to -5, or to -10 is good enough.
> It depends on what other tasks are setting their latency_nice value to.
> What a task does know is what it it doing and its characteristics.
> For instance for client tasks, we may have categories such as
>
> Task Category                                   latency_nice_range
> -------------                                   ------------------
> urgent                                          -19 to -16
> media playback                                  -15 to -11
> interactive (e.g.pressing key)                  -10 to -6
> normal                                          -5  to  9
> background                                       10  to 15
> opportunistic soaker task (sched_idle class)     16 to  20
>
> And we could allow a task to set attribute of which task category applies
> to it and the OS can set a default latency nice value in its task category.
> So a task can just declare itself what kind of task it is, and not worry about
> actually setting a latency nice value which it may not know
> what is appopriate.
> If needed, a task could still adjust its latency nice value within the range to
> differentiate itself in a task category. And we will prevent
> a task from seeting inappropriate latency nice value out of the right range.

The description above make sense but I'm not sure this should be put
as part of the interface but more in the documentation to describe how
system can make use of nice_latency
>
> Knowing a task characteristics will also be helpful with other
> scheduling decisions, like placing a task on a more high performing
> core in hetero systems.

Ok so you would like a more general interface than an latency
interface but a way to set some attributes to a task so we can make
smarter decision

>
> I think the missing piece here is a way for a task to declare
> what kind of task it is.  I think that will make things easier.
>
> Tim
>
> > The patches [5-7] use latency nice priority to decide if a cfs task can
> > preempt the current running task. Patch 5 gives some tests results with
> > cyclictests and hackbench to highlight the benefit of latency nice
> > priority for short interactive task or long intensive tasks.
> >
> >
> > Change since v1:
> > - fix typo
> > - move some codes in the right patch to make bisect happy
> > - simplify and fixed how the weight is computed
> > - added support of sched core patch 7
> >
> > Parth Shah (4):
> >   sched: Introduce latency-nice as a per-task attribute
> >   sched/core: Propagate parent task's latency requirements to the child
> >     task
> >   sched: Allow sched_{get,set}attr to change latency_nice of the task
> >   sched/core: Add permission checks for setting the latency_nice value
> >
> > Vincent Guittot (3):
> >   sched/fair: Take into account latency nice at wakeup
> >   sched/fair: Add sched group latency support
> >   sched/core: support latency nice with sched core
> >
> >  include/linux/sched.h            |   3 +
> >  include/uapi/linux/sched.h       |   4 +-
> >  include/uapi/linux/sched/types.h |  19 ++++++
> >  init/init_task.c                 |   1 +
> >  kernel/sched/core.c              |  90 ++++++++++++++++++++++++++
> >  kernel/sched/debug.c             |   1 +
> >  kernel/sched/fair.c              | 105 ++++++++++++++++++++++++++++++-
> >  kernel/sched/sched.h             |  34 ++++++++++
> >  tools/include/uapi/linux/sched.h |   4 +-
> >  9 files changed, 257 insertions(+), 4 deletions(-)
> >
>
