Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C004FB4BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241319AbiDKH2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiDKH2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:28:34 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A53B540
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:26:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j2so25969716ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCizahI22iIFGiLOZD5DNvVNsX+gXun47dglVgPNMZ4=;
        b=VgaDcEqmMcEcE1ceZMEuOoXxj10rwMNqMWLACbgHKz9TPWLFTqZluaSEncQlaCu6p/
         fuqYskPKCtXP+tRelsRX02072M7dlhWcr7lpIEC3EsSR40w5QGxQC8HMsLs/cxIm6qnr
         KRUsNvTIe3zqy1bi6+bC6PdV2Z/pCxhaZHA/yPpwntee+Ep0X+Kj7vT925YEQTtMdBzS
         urdjO1yP5ElzjHL1aiimfIUvns6t5bY3qUQz4Bj9CE6cpT/URHSDRduvNLwMJPTjdmKX
         0G7R7YlriTgHEJp2EXFiPFioidLFyCHnEWeBrqHyby906gZPit3cyS2Bag+ctoX07Jho
         Sevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCizahI22iIFGiLOZD5DNvVNsX+gXun47dglVgPNMZ4=;
        b=sqoZGosyNl2Hbs9iAIxygxO7KuR8AmJCxxPRfHmqsl62+ZOxx/wreEwSEgLMVvLztI
         k7lhz0kBMuZM13ogxDvbeJEz4c8ZlORPXEC1USxFYE8Yk5oOv2ux8S5NbZZE+e4j6INK
         MjIOeJmTgWmPhrfTbB1K6v/34NrGrvdHLPF66M305cispGtyV2n1i0GHrTM8UZx2zGBD
         GA4DjLIlObEjpIFCYOkXvts6dxPk/OZklR+h0BcBwjNg7WeB6YFI1y2u5tlI/+IIEA2I
         l10c7UvXSn93TyH3zRGDdrY4ucvN/lFWXTB9/rZdP33EDypRFpuYRcReOrAzNEstAZ0Y
         +s/w==
X-Gm-Message-State: AOAM530FLujmEOoVc0akBMiCt9bQnGPF0hbvUKCBZI82Rlniy7QXmWD5
        ymEnToj+iJsx00VHzTOQ9LKUwfmicLinynF0yPSJvQ==
X-Google-Smtp-Source: ABdhPJwTp12ngXqBapiKy2XA1vB5rLb9SSwVJnU7SCCAB6lj0mQgvmUliXU1FzpjXJtBM7nIAs/fPKF7m5VYu6OxDHw=
X-Received: by 2002:a25:d80a:0:b0:641:38dd:2f4c with SMTP id
 p10-20020a25d80a000000b0064138dd2f4cmr4580482ybg.225.1649661980463; Mon, 11
 Apr 2022 00:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <7a7e1e21-df3d-4623-d9cd-51f5272919d5@arm.com> <CAKfTPtC36OLqrQ57bnGDi93N+3Ozk5cX-+KHHTWHkwCGp=z4gA@mail.gmail.com>
 <20220401121525.flngciwjtkn3mwlv@airbuntu> <CAKfTPtD7YntSV+fJkdwZxX0iO52hL0SxZ9G5hZTBSyZf6hMYRQ@mail.gmail.com>
 <20220409170841.upcimeak2ch3aj35@wubuntu> <20220409132829.16b03d69@rorschach.local.home>
 <20220409181036.v4mm3q2rotctbxb3@wubuntu>
In-Reply-To: <20220409181036.v4mm3q2rotctbxb3@wubuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 Apr 2022 09:26:08 +0200
Message-ID: <CAKfTPtB326TQ7YTjqkE9Tq7OqOj2fdz1FhYZ2iObSDckfQEfwQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add latency_nice priority
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        Valentin.Schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        Wei Wang <wvw@google.com>
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

On Sat, 9 Apr 2022 at 20:10, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 04/09/22 13:28, Steven Rostedt wrote:
> > On Sat, 9 Apr 2022 18:08:41 +0100
> > Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > > One other corner case to consider if you're working on next version is what
> > > should happen when there are multiple tasks of the same priority on the rq. RT
> > > scheduler will push/pull tasks to ensure the task will get to run ASAP if
> > > there's another cpu at lower priority is available. Seems a lot of complexity
> > > to add to CFS, but at the same time if 2 important tasks require low latency
> > > are on the same rq, one of them will suffer without introducing the ability to
> > > migrate one of them where it can get to run sooner.
> >
> > Instead of having the greedy algorithm of the RT push/pull logic, how
> > hard would it be to have the load balancer know of these tasks, and try
> > to keep them on different CPUs? When two are queued on the same CPU,
>
> Oh yeah I didn't think we need to replicate push/pull. Load balancer will need
> to know about it when it moves task so that it avoids placing two of these asks
> on the same cpu.
>
> > could it be possible to just trigger load balancing and let it do the
> > work?
>
> I think the other part will need to be at wake up when we decide the CPU.
>
> If we trigger the load balancing instead then it'd behave like a push/pull?
>
> All these paths are already complex though. So we need to carefully analyze the
> trade-offs. Maybe we don't need to deliver such level of service after all. It
> needs more thinking and experimenting.

I will consider this for v2 but we have to take care of not adding
more latency by trying to find a better CPU. As you said this
additional behavior will need more thinking and experimenting

Vincent

>
> Thanks
>
> --
> Qais Yousef
