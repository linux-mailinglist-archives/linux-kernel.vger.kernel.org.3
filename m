Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73D47C06F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhLUNGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLUNGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:06:13 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE60FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:06:12 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id k37so29248705lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/8iJIUJFjccuRox5bfowtHEjXndE5J3VXorUJClalE=;
        b=N3Iffpk0gUhvvUN0nazVJ4xmStaDIjPEs9Y7OenQXI0EJI6DBIY7VuUzZ/IHCt4aeA
         F33dhkscnd5Zl2GcAhqZRJIRyRkk0P5lnGX3pbxS2E73nX0iKiXIpXVWrhti4x0FzocO
         T8sJVWy7G4ZEF/Mi+pAH2+a7TF8Zj8fvNP1KAJV3ZV8IzBg1uddc3hUvQVDqkBFii4eU
         FllvYVMaNOf9+HjwAkRT5m6qEsJJDgnQK2CKNqXdTr0iKdrDzjjg8p7X2tSAfmBVRINE
         rUGbC3+uLEBLUrDReSB5ToJ8Xp+8+Q4ovRPXl9aLqVtll4l3N7rwotalvwiI8tjlVAyk
         jozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/8iJIUJFjccuRox5bfowtHEjXndE5J3VXorUJClalE=;
        b=kZOoshj9EV53w/z/3mX/Kr2LJhtYd4B/HMh5TF4sG+HNgk19/7ATe007vMpwzymfXf
         hCaZws97N25JspcCQrl5qd+8liL8HUrXbgtHBoRab9zZiJpJ/6JeY32Ehv7+47I8Hcrh
         O6cm0KAZ9QQlaqpjo6Vz/56YUu31BhZzWvggD+cV5vCTh5/3nLyDHX7sxZvXc0wH1MWu
         /qzjsDFaKZWVs4Os1krQygH7zLTO4710nhjQcCrjZSzSguj1vo/rB2cFsyCShmwJN9Lc
         5/WVy/3STsVqr1/igpE/Ozgt9uydIfakuKbkphNf0xGC61Gd9Wv8t95oxCvIfERn9hjC
         SleA==
X-Gm-Message-State: AOAM532hK9Gj0JnAvxjlCuMI3TpA5aRvvMvrgrngtCv57Ee9Fg4rViig
        K8LsdSSuZMLFYIW+Vjjn93ZQIc7JJAuzU/7RIE/7Nw==
X-Google-Smtp-Source: ABdhPJyNPlvjtI2i3NqJuDIVtrd8SuEBhtoV49PJlodtGEfRFPp//tR+gsPk5UlWySj8JAgw0F/CuieCMpnxnnYimEI=
X-Received: by 2002:a05:6512:118b:: with SMTP id g11mr2832772lfr.46.1640091970932;
 Tue, 21 Dec 2021 05:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-2-mgorman@techsingularity.net> <CAKfTPtDPu6r3dsSmY-ZDB0k4muoSk1a2J3=NKqoBG1y8aEwNYQ@mail.gmail.com>
 <20211221113227.GT3366@techsingularity.net>
In-Reply-To: <20211221113227.GT3366@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Dec 2021 14:05:59 +0100
Message-ID: <CAKfTPtCFm98SV=JXV5zwFfB3CAjF5D8Fk0f4WX1gCm-tVhVe3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Use weight of SD_NUMA domain in find_busiest_group
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 at 12:32, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Dec 21, 2021 at 11:53:50AM +0100, Vincent Guittot wrote:
> > On Fri, 10 Dec 2021 at 10:33, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > find_busiest_group uses the child domain's group weight instead of
> > > the sched_domain's weight that has SD_NUMA set when calculating the
> > > allowed imbalance between NUMA nodes. This is wrong and inconsistent
> > > with find_idlest_group.
> >
> > I agree that find_busiest_group and find_idlest_group should be
> > consistent and use the same parameters but I wonder if sched_domain's
> > weight is the right one to use instead of the target group's weight.
> >
>
> Ok
>
> > IIRC, the goal of adjust_numa_imbalance is to keep some threads on the
> > same node as long as we consider that there is no performance impact
> > because of sharing  resources as they can even take advantage of
> > locality if they interact.
>
> Yes.
>
> > So we consider that tasks will not be
> > impacted by sharing resources if they use less than 25% of the CPUs of
> > a node. If we use the sd->span_weight instead, we consider that we can
> > pack threads in the same node as long as it uses less than 25% of the
> > CPUs in all nodes.
> >
>
> I assume you mean the target group weight instead of the node. The

I wanted to say that with this patch, we consider the imbalance
acceptable if the number of threads in a node is less than 25% of all
CPUs of all nodes (for this numa level) , but 25% of all CPUs of all
nodes can be more that the number of CPUs in the group.

So I would have changed find_idlest_group instead of changing find_busiest_group

> primary resource we are concerned with is memory bandwidth and it's a
> guess because we do not know for sure where memory channels are or how
> they are configured in this context and it may or may not be correlated
> with groups. I think using the group instead would deserve a series on
> its own after settling on an imbalance number when there are multiple
> LLCs per node.

I haven't look yet at the patch2 for multiple LLC per node

>
> --
> Mel Gorman
> SUSE Labs
