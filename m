Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C1B4E9728
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbiC1M6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbiC1M6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:58:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF958E68
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:56:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e16so24527645lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ty0gPYxWNpU2n0H7QIeSgFfwy//Cvhus3P3z45vF7Cw=;
        b=xxZbXLqpj4A3EaLThYUDImNKqDSXTbXq5AKOwTmfvE0cMAWI1vYcy6CbVDLD0OofM9
         jxxqTxfd7I9zVRxsg3x4pqzNsHHuNxOj2X7oeU/UR7ZTv8NEgUAxIqj14Jr/AumcLK7/
         BsXV6t9EWv0DrS8CucwH4JyyD75K0c6TetY9wyXViyDiuNK6hk1wIGpG8qWV9RemRuui
         RXpV2sSNcuwMnGgNzS0XbU2hPhIUJQKr4LxTsVc32FeCbZ5qyO6wHkxGD/ABN4x/MfLr
         wqG4b6zumhhOfUwZc5Kl+72LkCHkXJGapUziYEAeApR2niivQgGFc2DCC5j/L5auL4QQ
         yt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ty0gPYxWNpU2n0H7QIeSgFfwy//Cvhus3P3z45vF7Cw=;
        b=mW0xzCEnHLbpWvEhU4t8t1c0HzeHWhzDBdy0DXoSME1RGdNpGFJxG5h02LbFimNrHx
         2hedNMLXaL82QRyJUKPDaUQ6XztR3tISFqyNGThN+cBoTPc6SvevVYUrNDFwyzUJclDK
         ljRHvpFEwwpbYU1GxUTcVKpPHx1ynFln/JVAzRLuhwTRkkh9kCVdYJkpQvEBgf2Z92sp
         jRlkTSm8r6eDWZ6+mfCqpLievCJcLFTZdJg3dAIrYiQzEob0zEXF0kQCxsbs/+bYXLhN
         OTzWqBx2MXi+SRrwHCHbRuP8pq3dvk01AK8asac5M0HtHa7HdfwYdtizN16bARwiCqUX
         7NDw==
X-Gm-Message-State: AOAM533A0UnUjLOyZIZ0oh2ajZQ0Xl9ic93+RWON2/2fLnFEvMdnDSTz
        DdbBgrx0HKkpRVyGTzxgA3UMM8YhlwyRVFSelRAKbQ==
X-Google-Smtp-Source: ABdhPJzW5HcqjWowrAU+c28lyUH8vzs2XJoWDyolNRVK7sBbpDfYuwQapa9cqHOnAOHbDA/SJ6WUTmvOi6CASNXm2o8=
X-Received: by 2002:a05:6512:3e0a:b0:44a:37a6:51b3 with SMTP id
 i10-20020a0565123e0a00b0044a37a651b3mr20366536lfv.645.1648472177740; Mon, 28
 Mar 2022 05:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org> <7a7e1e21-df3d-4623-d9cd-51f5272919d5@arm.com>
In-Reply-To: <7a7e1e21-df3d-4623-d9cd-51f5272919d5@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 28 Mar 2022 14:56:06 +0200
Message-ID: <CAKfTPtC36OLqrQ57bnGDi93N+3Ozk5cX-+KHHTWHkwCGp=z4gA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add latency_nice priority
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, Valentin.Schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com
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

Hi Dietmar,


On Mon, 28 Mar 2022 at 11:24, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 11/03/2022 17:14, Vincent Guittot wrote:
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
> > The patches [5-6] use latency nice priority to decide if a cfs task can
> > preempt the current running task. Patch 5 gives some tests results with
> > cyclictests and hackbench to highlight the benefit of latency nice
> > priority for short interactive task or long intensive tasks.
>
> The Android specific `latency_nice` (in Android `latency_sensitive`
> [latency_nice < 0]) use case `Skip energy aware task placement` favors
> an idle CPU over the EAS search path for a `latency_sensitive` task.
>
> https://lkml.kernel.org/r/2aa4b838-c298-ec7d-08f3-caa50cc87dc2@arm.com
>
> This is Android proprietary code similar to what we have in
> find_idlest_group_cpu() in mainline.
> We talked to the Android folks last week and IMHO they are not convinced
> that they can switch this to the proposed `latency_nice->tweak
> preemption` use case.

Thanks for discussing this with Android folks. It's not always easy to
change the behavior of a product and I would be interested to discuss
this with them. Sometimes you need a PoC to get convinced
