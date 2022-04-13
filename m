Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAAF4FFC48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiDMRXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiDMRXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:23:53 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC2B62BE5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:21:31 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k25so2645985iok.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BaJWBZDuogrrbM9h8fK9n5eI07qEd/FZUeVGQjfGLZY=;
        b=RjH2Vr7/UjWidYKPEI2BDu8Y0nrFqfzyCMu9YY2n1BbC9HZmInKXfbfp69j8Zadjrl
         fPOwsMAzixgQf4WIh8kYc2rbaYfl/AlYiKDGtOMZXduyt9Xbx/RoZ/PiNtEcR5rTopHV
         8EkOY+yoTrsAkMYoBt0HDiHK3yrlPioNnHcOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BaJWBZDuogrrbM9h8fK9n5eI07qEd/FZUeVGQjfGLZY=;
        b=I+SrBX314zb8OX+QjYyFRMjR0gjBTyKQYLdd99f3IdRWhi6lawQDcnTV5+WeZa6W7d
         r2YEFoQ1yp3P8DbGm02o+HBZAniCOSWIRGREXlrj8RvqzdKKDmNsfCNpp/aQa36h3u0X
         VYahGqj6Lvu21z9B1nSA1rPxl2u3wpaDcfPrCHC1mT9/qc4Vzgi1NkXRJvCV6n0fcffJ
         fWpzqSn6zS7WZk3SKk5relFt1oIdAQW7fKtG+k5uanCa6A0RY1kjpNb0hmrkxrolnIMI
         dOYeXqIpbfuQ8yIT/EXqvLX3xUbNKa7UZTd+159BWPb8z82sozkT5xlpTRUpPzhDFTQE
         9qEw==
X-Gm-Message-State: AOAM5330I0fw4Ar6PF48aImEy6iakHWCHu7QEW3wfLiexhUsC7WXr3BS
        7jtfug6glOFgkafvHaBhPoNnI6Oj5loEjQJM835/Jg==
X-Google-Smtp-Source: ABdhPJztK+lyqX50IaiSOnE+cYTGAq/u25mmnmQqbL2DVHEGtOujz0jbIU5vSZzH+akI1wqQJdpcXM0gmeBDiW2Da2I=
X-Received: by 2002:a05:6638:240b:b0:326:bd5:8a6f with SMTP id
 z11-20020a056638240b00b003260bd58a6fmr10721949jat.52.1649870490957; Wed, 13
 Apr 2022 10:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045734.1158817-1-kaleshsingh@google.com>
 <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
 <20220408143444.GC4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
 <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YT-vJmXgWPQ_1J34iTb+ZhrAgN7c-HPz7kW17HmvKzJ3A@mail.gmail.com>
 <20220408173908.GJ4285@paulmck-ThinkPad-P17-Gen-1> <20220409071740.6024-1-hdanton@sina.com>
 <20220413113711.1263-1-hdanton@sina.com> <20220413140729.GL4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220413140729.GL4285@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 13 Apr 2022 13:21:20 -0400
Message-ID: <CAEXW_YTmZnk_kFw48HeyyFTXZzfj1cPdw+BaOra14JiWJh6kNg@mail.gmail.com>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Paul,


On Wed, Apr 13, 2022 at 8:07 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Apr 13, 2022 at 07:37:11PM +0800, Hillf Danton wrote:
> > On Sat, 9 Apr 2022 08:56:12 -0700 Paul E. McKenney wrote:
> > > On Sat, Apr 09, 2022 at 03:17:40PM +0800, Hillf Danton wrote:
> > > > On Fri, 8 Apr 2022 10:53:53 -0700 Kalesh Singh wrote
> > > > > Thanks for the discussion everyone.
> > > > >
> > > > > We didn't fully switch to kthread workers to avoid changing the
> > > > > behavior for users that dont need this low latency exp GPs. Another
> > > > > (and perhaps more important) reason is because kthread_worker offers
> > > > > reduced concurrency than workqueues which Pual reported can pose
> > > > > issues on systems with a large number of CPUs.
> > > >
> > > > A second ... what issues were reported wrt concurrency, given the output
> > > > of grep -nr workqueue block mm drivers.
> > > >
> > > > Feel free to post a URL link to the issues.
> > >
> > > The issues can be easily seen by inspecting kthread_queue_work() and
> > > the functions that it invokes.  In contrast, normal workqueues uses
> > > per-CPU mechanisms to avoid contention, as can equally easily be seen
> > > by inspecting queue_work_on() and the functions that it invokes.
> >
> > The worker from kthread_create_worker() roughly matches unbound workqueue
> > that can get every CPU overloaded, thus the difference in implementation
> > details between kthread worker and WQ worker (either bound or unbound) can
> > be safely ignored if the kthread method works, given that prioirty is barely
> > a cure to concurrency issues.
>
> Please look again, this time taking lock contention in to account,
> keeping in mind that systems with several hundred CPUs are reasonably
> common and that systems with more than a thousand CPUs are not unheard of.


You are talking about lock contention in the kthread_worker infra
which unbound WQ does not suffer from, right? I don't think the worker
lock contention will be an issue unless several
synchronize_rcu_expedited() calls are trying to queue work at the same
time. Did I miss something? Considering synchronize_rcu_expedited()
can block in the normal case (blocking is a pretty heavy operation
involving the scheduler and load balancers), I don't see how
contending on the worker infra locks can be an issue. If it was
call_rcu() , then I can relate to any contention since that executes
much more often.

I think the argument about too many things being RT is stronger though.

Thanks,

Joel


>
>
>                                                         Thanx, Paul
>
> > Hillf
> > >
> > > Please do feel free to take a look.
> > >
> > > If taking a look does not convince you, please construct some in-kernel
> > > benchmarks to test the scalability of these two mechanisms.  Please note
> > > that some care will be required to make sure that you are doing a valid
> > > apples-to-apples comparison.
> > >
> > >                                                     Thanx, Paul
> > >
