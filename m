Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0A5264B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382004AbiEMOgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381354AbiEMOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:34:38 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252CC1C9AC1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:30:08 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o130so65408ybc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NP6EhM0X5mD3UzK4e4exb5R0VTq4XniyN4C07WX/Go=;
        b=cZi6hWJvOF2VZMnh6yPQoLDh4Dnlxa0Jbaglle0oh+f3CygyxrXYwW2adM1URgVwUb
         Dz6klL6PoSomeo+wpCmo1A87bU+2JBKQY4jsd98vpSB9JBBHsya+W+NOd/N6kw7b7eT8
         j+kqQihDkvuu4dCw2TaNoVgRJDNaBnB4pPD0Koih2C7atkA3wpdGBi9HKOHLueXVSc7l
         d6LNFaMBCDoT3jUJALI9YOee20+5FnI48jXivTcRUEW3H4JE38/vW2o0Mo91LS32pNJV
         nOFLGaAWgXJJIzWpMPK4Nsdz+pHgWTR9L2trFmb8zBDQTMds2jsmX9bl7kj2/6bd2fO9
         Dg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NP6EhM0X5mD3UzK4e4exb5R0VTq4XniyN4C07WX/Go=;
        b=ydN4AQF/I82IDufhImUXc/iWSI2ANU4Ol7MkQ2J3G6W73d7Hup5TwHZhNBKpgcbsiy
         1zn1P/GIrj6EJ73uqRVk84VZD7bV4SuaHVSxi25y+wL8xQ5L8CNIixR0DYn/Rftx5zmE
         ln0Em5vn9zVuy0oUFhxEuY2pzaBDGlIz5QqWNuD34sjqfNNYGNPOyLDRbpAqQDrVWNf0
         e6nX8YT2c7d1K/7gWkAShVUveLaqPkxc91Ef5ULblftk5/0rOwRtWhhJa1cYZOKD+WIH
         hfYhjkQp7AHoXknapTMP78+j+BKPEl8IEWa1Nt+3NqWXIdoFhMde91+WK0gg5ydqV2E2
         ANEw==
X-Gm-Message-State: AOAM532XvXVwJz1Jd3iFS+iwZe3GbgySpDXjhVAWouHKB+T8QZeWiGvd
        mn6cclub9Wj0GcUE6oYMYLgajMgnBN7u/6hRdxk5aw==
X-Google-Smtp-Source: ABdhPJyTJudNGJtkAW4NctmhORicAlKAnvJLdlDZ50xVK9tE6EjXyHMGuV9guzIlFTcKi31JInQBAtKqDQCEK0XVIHA=
X-Received: by 2002:a25:d3cd:0:b0:648:6a92:80f9 with SMTP id
 e196-20020a25d3cd000000b006486a9280f9mr5051460ybf.300.1652452207184; Fri, 13
 May 2022 07:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220512163534.2572-1-vincent.guittot@linaro.org> <86066641739c4897b0001153e598a261@AcuMS.aculab.com>
In-Reply-To: <86066641739c4897b0001153e598a261@AcuMS.aculab.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 May 2022 16:29:55 +0200
Message-ID: <CAKfTPtDUCodxyyBmTsJ_jHPCxvBgGTALaMO8r3UvrBA6ZWks6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add latency_nice priority
To:     David Laight <David.Laight@aculab.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parth@linux.ibm.com" <parth@linux.ibm.com>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "joshdon@google.com" <joshdon@google.com>
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

On Fri, 13 May 2022 at 09:13, David Laight <David.Laight@aculab.com> wrote:
>
> From: Vincent Guittot
> > Sent: 12 May 2022 17:35
> >
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
> > The patches [5-7] use latency nice priority to decide if a cfs task can
> > preempt the current running task. Patch 5 gives some tests results with
> > cyclictests and hackbench to highlight the benefit of latency nice
> > priority for short interactive task or long intensive tasks.
>
> I'd have thought the best way to reduce latency would be to look
> harder for an idle cpu before trying to preempt the current task.

Although it's a good policy, this is not always true:
- The wakeup latency of an idle CPU can be significant for deep idle
state (several ms)
- The cost of looking for an idle CPU can be higher than preempting
current thread

>
> By far the worst case latency for a cfs task is waking it from an
> rt task.
> AFAICT the cpu selection algorithm is something like:
> 1) if the cpu it last ran on is idle, schedule it there.
> 2) if one of a small subset of cpu is idle run it there.

yes the LLC

> 3) schedule on the current cpu after the rt thread exits.

when prev and current cpu are differents, we start to select which one
will be the starting point for looking for an idle cpu

>
> Then there is the additional behaviour:
> An rt thread (almost) always starts on the cpu it ran on last,
> any running cfs thread is put on the q for that cpu.

and might even have to wait for other cfs threads to run 1st which is
where this patch want to improve in priority

>
> This makes it very difficult to start a background cfs thread
> from an active rt thread.
> Quite often it won't migrate to an idle cpu until the timer
> tick scheduler rebalance happens.

so you are speaking about idle cpu out of the LLC
But then, this cfs task should try to wakeup 1st on the new cpu and
not on the RT one

>
> I think the search for an idle cpu is also limited when woken
> by a cfs thread.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
