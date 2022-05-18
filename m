Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD29552BCED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiERM4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbiERM4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:56:19 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7265D167FC
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:56:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h8so2412406ljb.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dM4bl7eU/dULWWBp2eDh/PeRjPphqkSU0WhoA+v9GXg=;
        b=KUyMcRSOwDu6jx3pdPfF4rBn1VDHBiK4nQudYAkgaxNLKolk/LxQnZ8rCaNzA96DVy
         nyGOhCEtRt9cKP5qLIIAXqhqDuitw/7tK5iwTCbBD1sWxmkWhxcr03w9cKVvB2uRjAB6
         H1KfMYClxSt54NLmBb7cidPlUzasjfOSB/qyJpAA+Td07l54yyAEniUSEvfyqooVrLu4
         +Ok+u3LA71bM8EUThDJYof3NS0D0xvvz2jkPTfqJMYe5GTD+SYJp0RYQqlYyatiCBinW
         +nzzOGWCqt88Qv24FKXJRQQJKmsNTVKNUya3OzGPrkgloGoD2tunU15OJtoe3R1HRN45
         9oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dM4bl7eU/dULWWBp2eDh/PeRjPphqkSU0WhoA+v9GXg=;
        b=020xkVLRg/t5/gy2K18GNYvTC+i2zOv5gc+LP8gqU5UJGZThHRiTUMbk+uwIX2zM7s
         +LGY7AMrAfVrR2SgM17ORVWmzXBT/NQwYHVsbFZU50yGOOHk+2vmQBWwBIrJLEwrHJc4
         dZFihMEaGTV1PdJoecnn5ZNq1Clfg8F20VuN4par7ImwtBHty+uE2GuODckm0ot/APly
         obI6/HJdeiiLK8lN5CgBECYPLJQJEhpYXyJbbMYVYPiiDJGKPLurEEl1NT++2QqaF5Of
         iWCavYTmz4lu7JpwA1KiBdBE+3XsL239C2/1MowtmwjqFRyNoupHUCo06lX7eQB/TQY/
         BNLQ==
X-Gm-Message-State: AOAM533dt7A4lvHNB7CU7SLKB/XQirYmzTmpQN3Ynn4PK4Pj5BwXc5GG
        2t1ibhBMjwFOmgKiLiMNxngXN+066+3Wn0BHE/WyJg==
X-Google-Smtp-Source: ABdhPJzaQT74FoU0dYj57Nfz76whG87HcFWFaT3sLsPuhgi4O4TBuld1Lvj/DaCm8cfTnIrR9q4iRTi8O7ekdn2D+LQ=
X-Received: by 2002:a2e:a495:0:b0:253:c86e:328c with SMTP id
 h21-20020a2ea495000000b00253c86e328cmr2170676lji.175.1652878562764; Wed, 18
 May 2022 05:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220518100841.1497391-1-fam.zheng@bytedance.com>
 <20220518102140.GF10117@worktop.programming.kicks-ass.net>
 <CAG+v+Kb5ON2-49t8ZZwH2jT31Jvi+F_HYW0gQ3ss040GKdp0Zw@mail.gmail.com> <CAKfTPtBAkQpKtZMC5uV6hNeMqe9rJHd_GLHVFf2o3r=HvqH9fg@mail.gmail.com>
In-Reply-To: <CAKfTPtBAkQpKtZMC5uV6hNeMqe9rJHd_GLHVFf2o3r=HvqH9fg@mail.gmail.com>
From:   "Feiran Zheng ." <fam.zheng@bytedance.com>
Date:   Wed, 18 May 2022 13:55:51 +0100
Message-ID: <CAG+v+Kbfy-TuAWR9sfuWGyKb5Y+xjHDzB9hcoHuAN1kjYv5gWw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] sched: Enable root level cgroup
 bandwidth control
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        zhouchengming@bytedance.com, fam@euphon.net,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        songmuchun@bytedance.com, Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 1:03 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 18 May 2022 at 12:38, Feiran Zheng . <fam.zheng@bytedance.com> wrote:
> >
> > On Wed, May 18, 2022 at 11:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, May 18, 2022 at 11:08:41AM +0100, Fam Zheng wrote:
> > > > In the data center there sometimes comes a need to throttle down a
> > > > server,
> > >
> > > Why?
> >
> > For economical reasons there can be over-provisioning in DC power
> > supply (UPS capacity etc) because the utilization expectation of the
> > racks is not maximum value. But the workload can be client driven,
> > depending on how many users are online, and in the end the power
> > supply may overload and trip itself. To avoid that, upon a threshold,
> > some servers need to be brought down or throttled. The latter is
> > obviously going to be much more smooth.
>
> This looks like thermal or power budget management. We have other ways
> to do so with powercap or idle injection. Did you consider those
> solutions ?

Hi Vincent,

I looked at powercap, and it seems Intel only? Any idea about AMD/ARM?
There seems nothing for them under drivers/powercap/.

I don't know the idle injection interface, can you please give more hints?

I also plan to test uclamp, still need to learn more about that.

Fam
