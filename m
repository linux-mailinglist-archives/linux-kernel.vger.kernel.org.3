Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F87152BE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbiERObx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiERObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:31:52 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8B7131F0D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:31:50 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p139so3950971ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7nmEi6ZoG9r127aWoO2La/t7onhMEzl5Gbs0ISxTId4=;
        b=QHkp2SHQ0ilczfAavRdE+bGwRoRlPSAVvvBQ/UKIKFlyIbmL071SoLuKxg2nQ4mA+S
         Bl1WVEyfZ5uoc4hHnDGf/USDpoHoVvIYv92hR2CnXGjbCDRT6QdxTYIvB2FOkGlxpRrQ
         fx8PX0tyYhijJpmU7oA+PmVGz59bta+zGUOz/Vy1uOLlBJ0Boi4TyEY1qN4AW4LWzZ10
         I6URRpRzLgwtufvkwnBlWr1sC/oGRWtxEUaSxqgmvd8X1DlsETJBV81fx9iSiJ0nc/Fu
         p4rE7aOVOT24cJLnW1/9GN48oTV0uRlwKeik5fpwsCXv3NJi9woK15JY6MY1CRiQY/nB
         lUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nmEi6ZoG9r127aWoO2La/t7onhMEzl5Gbs0ISxTId4=;
        b=h+gGADsKM5OglcIgFkQJYDpdWS1BI74AJ513WtYgbG0N8FKY9uCzt56rE6gy9gr3up
         U8Kan+hLYQtlXI50/unOQhfVXn0N79VYeQ3OtTYgwQxjqzoOqrWcxQuwJjxc66RIPuKA
         L/p+4PVrn6f6MZ2K43u6Sxaj0Qrw6UPw2Xfn10glqKHOWutfPUB5zazsJQEpPMhYGcMo
         ImdgA/0pCaozdG9reOZbODr3fFQ8K5ui/iryj86Bs2JQpZAknJtNNnwkz6d8Fh5hSayh
         G4B9srr/VYZYsQBHDoHl06HmH3Yhh/mlcuZWYHCXZbx37ufDKXCERaF/w+ZAhP8sO4FC
         PKkw==
X-Gm-Message-State: AOAM533TKF1/lCU4ERbQC3xOSPrlth45LHgwcz9RihG8bAQcHMBSZXSA
        RSwmq9rHmsWCJjA8tjcfZNhPlA3sNLhnBHGBQ1Znog==
X-Google-Smtp-Source: ABdhPJz0ouudIkCpPRRDk/fmvhMRPYd6OJH2pyj1Rp+/2Y/lT2tLO6oxXSEmNkETJ6Y4AlsWwaA3UoEXv6zT6oaH7UA=
X-Received: by 2002:a25:5e45:0:b0:64d:7707:e8c2 with SMTP id
 s66-20020a255e45000000b0064d7707e8c2mr18758338ybb.403.1652884309753; Wed, 18
 May 2022 07:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220518100841.1497391-1-fam.zheng@bytedance.com>
 <20220518102140.GF10117@worktop.programming.kicks-ass.net>
 <CAG+v+Kb5ON2-49t8ZZwH2jT31Jvi+F_HYW0gQ3ss040GKdp0Zw@mail.gmail.com>
 <CAKfTPtBAkQpKtZMC5uV6hNeMqe9rJHd_GLHVFf2o3r=HvqH9fg@mail.gmail.com> <CAG+v+Kbfy-TuAWR9sfuWGyKb5Y+xjHDzB9hcoHuAN1kjYv5gWw@mail.gmail.com>
In-Reply-To: <CAG+v+Kbfy-TuAWR9sfuWGyKb5Y+xjHDzB9hcoHuAN1kjYv5gWw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 18 May 2022 16:31:38 +0200
Message-ID: <CAKfTPtA4qRUpMK4gw0STFg3kQqhpxCJpOMy9HgbSKaeVwfSjEQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] sched: Enable root level cgroup
 bandwidth control
To:     "Feiran Zheng ." <fam.zheng@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        zhouchengming@bytedance.com, fam@euphon.net,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        songmuchun@bytedance.com, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>
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

Adding daniel and cristian who works on some powercap implementation

On Wed, 18 May 2022 at 14:56, Feiran Zheng . <fam.zheng@bytedance.com> wrote:
>
> On Wed, May 18, 2022 at 1:03 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Wed, 18 May 2022 at 12:38, Feiran Zheng . <fam.zheng@bytedance.com> wrote:
> > >
> > > On Wed, May 18, 2022 at 11:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, May 18, 2022 at 11:08:41AM +0100, Fam Zheng wrote:
> > > > > In the data center there sometimes comes a need to throttle down a
> > > > > server,
> > > >
> > > > Why?
> > >
> > > For economical reasons there can be over-provisioning in DC power
> > > supply (UPS capacity etc) because the utilization expectation of the
> > > racks is not maximum value. But the workload can be client driven,
> > > depending on how many users are online, and in the end the power
> > > supply may overload and trip itself. To avoid that, upon a threshold,
> > > some servers need to be brought down or throttled. The latter is
> > > obviously going to be much more smooth.
> >
> > This looks like thermal or power budget management. We have other ways
> > to do so with powercap or idle injection. Did you consider those
> > solutions ?
>
> Hi Vincent,
>
> I looked at powercap, and it seems Intel only? Any idea about AMD/ARM?
> There seems nothing for them under drivers/powercap/.

there is a DTPM powercap provider in the latest kernel and a scmi
power capp provider is under review
>
> I don't know the idle injection interface, can you please give more hints?

idle injection can be used with cpuidle cooling device and there were
some discussion to make a dtpm idle injection device but I think this
has  never been sent on mailing list


>
> I also plan to test uclamp, still need to learn more about that.
>
> Fam
