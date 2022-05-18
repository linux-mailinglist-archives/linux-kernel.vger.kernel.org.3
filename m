Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D4A52B9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiERMDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbiERMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:03:45 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3AC38B4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:03:44 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2fee010f509so21405627b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cabH0/r/i9ENNrvrTh0ZegAxccHNhX3G5C8HN/c9ps=;
        b=RXddUxv7gYpQ0W/9gmSaN1PMcpStNKAJeJdvvfvkJW1SRkPy4cN35n8pgCCKNNEmyd
         qEUOxYRS8TndZz9r/a3/be45iuPIBqUasFFuCBCgWktl9VshxBcgLyTxcYQh8iCDzjwT
         hu3M40NoIkZT1MADW5Pu5rBaW8bahb7WUWv0VIdSOVMIi4RfvVZocF4dYfzd+NtRliNF
         ZkYhenrrBOqiG9yUMzoYB1kQ/9lc0yVLQuom/iKCHKK8j+gLHtt4grJZhgREiga4NCn5
         nWX/UgYhd/6C+RwiJ/pwT7KMZ2xBxHIMJDNf9Tl4JJYyFy08/Rlib/ZdA1IFY2rtptvM
         C7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cabH0/r/i9ENNrvrTh0ZegAxccHNhX3G5C8HN/c9ps=;
        b=zRay3zXSx2NoR7BCLSzmjcs0ldzs+ulX+NJGBVPJwwO5MAFnFg1XmDj3QNrSPfE+Vt
         wHHFVT4yhD966W3VUNjPic8nn8e2oW0scvqDwFkvDARgQCcJvmvXEHKbTr9x11L75dnI
         0MSZrU72viRtn/nccjZc9LA+32DTXiPjHUpElB0IGMLFAlfdzkwveG99gjKtgrG9kLPL
         8MTh6Vzr0sfx1ml5XLgwWR8lb4tQfFWIm/sAk6Gr0Eoj2BznEUabo/itV6SA25F/WWGl
         nq+HOPO0wYZj8CyTEz4B1mEuiTt/zkep/N2ABfYOqQYt5xtW8I6uFd41tEnl7rJ2Ohhl
         E3vg==
X-Gm-Message-State: AOAM530cYhmMze9JhXkWACuJB1Y7J3vlj77HApmOtcTU4++alJCU0Nat
        tgklQdtvb1zlBLNJFtPPHpUvDsJZkvVoSDE1hQDHyQ==
X-Google-Smtp-Source: ABdhPJzdQiuvAw0F/nEWCt+S3rq8DJXuFUV/Ce4RL3/fOs3DlIDQcYRU2jcwuhRfSH8pHKmgYDUni0Ab7TxgUDYhGTM=
X-Received: by 2002:a81:950:0:b0:2fe:d88e:5529 with SMTP id
 77-20020a810950000000b002fed88e5529mr20384569ywj.320.1652875423269; Wed, 18
 May 2022 05:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220518100841.1497391-1-fam.zheng@bytedance.com>
 <20220518102140.GF10117@worktop.programming.kicks-ass.net> <CAG+v+Kb5ON2-49t8ZZwH2jT31Jvi+F_HYW0gQ3ss040GKdp0Zw@mail.gmail.com>
In-Reply-To: <CAG+v+Kb5ON2-49t8ZZwH2jT31Jvi+F_HYW0gQ3ss040GKdp0Zw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 18 May 2022 14:03:31 +0200
Message-ID: <CAKfTPtBAkQpKtZMC5uV6hNeMqe9rJHd_GLHVFf2o3r=HvqH9fg@mail.gmail.com>
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
        songmuchun@bytedance.com, Juri Lelli <juri.lelli@redhat.com>
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

On Wed, 18 May 2022 at 12:38, Feiran Zheng . <fam.zheng@bytedance.com> wrote:
>
> On Wed, May 18, 2022 at 11:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, May 18, 2022 at 11:08:41AM +0100, Fam Zheng wrote:
> > > In the data center there sometimes comes a need to throttle down a
> > > server,
> >
> > Why?
>
> For economical reasons there can be over-provisioning in DC power
> supply (UPS capacity etc) because the utilization expectation of the
> racks is not maximum value. But the workload can be client driven,
> depending on how many users are online, and in the end the power
> supply may overload and trip itself. To avoid that, upon a threshold,
> some servers need to be brought down or throttled. The latter is
> obviously going to be much more smooth.

This looks like thermal or power budget management. We have other ways
to do so with powercap or idle injection. Did you consider those
solutions ?
