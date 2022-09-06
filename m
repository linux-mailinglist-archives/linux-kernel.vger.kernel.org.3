Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A85A5ADF07
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiIFFts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiIFFtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:49:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57C1A066
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 22:49:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k10so1141581lfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 22:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jyeR3VMLBLtc3JY3rsRXZWBfOqiefWk1RcdRM/P+dzo=;
        b=ptDDs3mOst0GuaAe/XGHuwS8HnhMGkeuTX9ZJU55HPCkejoHg1J8Q080X1BkpfZUb9
         4mtmkQkrY/rFA1GWrS4LBm+IgVNTXo+9Tc/Nd0mKPObr3TgxXAPT5WWpiJ8Yc5uDjqnr
         PYBpovo1UVpfqU7Yxf+cuaAh1O8IEUSZb1Ea2eDKzi8ssS7g/KjPzNPJRAWEYuT89x8q
         9vwjzyx7Q/78e2cLLolCG6HMgurqOK3q4xBGz/7KpKPCB8bfWwyFASH5JUFgqa7DICOY
         oisRtWZf/YUTh6ylAsTrh0CpLi4FFJlP0sv8LkQgVuXmTNrgZ1nAwvkDoVaTN1lJucns
         xHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jyeR3VMLBLtc3JY3rsRXZWBfOqiefWk1RcdRM/P+dzo=;
        b=ZMxMl5zKko4uLxHzk2QMAbDeJVupwqOoERq+YGshPTgTxq7LS3cxdrMbeGp6HnaH19
         iHOZl/ZOW+6oNfe48tQUk/qVsIeO3MCs9qKasuykPbJFOby1ydkWcig7LfFZcWe1HQqY
         2/r6cA0crMEsba2TVAzncYx52qF53Ze1SLhO1X8zE3kqtAghb0MdHj90sXrj/JNVUp+E
         hqwBTW9DIUY6hyStTCBrBWBtPWTutXa16XNEjS4ZydWMqj67cs4luRGLGJaZ3cZgG/q9
         llrMTGmUp0uTxV/f/IGNGvD3zua/Rc617WzkRgZYTzQRAzyAm6gOpeoxhT9lR6DvmGeW
         WaRA==
X-Gm-Message-State: ACgBeo0QOcYOSyKxS+7crDXr2Uyx4PSfwUh1J7m046FjrWNbA981mlxa
        DbJAlXmKxCDZ5IOMlQnIqXAlSQwFXEqDygNzDr94z//vANQ7giDi
X-Google-Smtp-Source: AA6agR5nax/2cSDCCpKl4yYqDnoPhspr+eAHrxcWtsG572aEk91bt9mZDkQczrDl1Do2dIZ45Qcolcj9Igmlnuobko8=
X-Received: by 2002:a05:6512:c1c:b0:494:6c98:a298 with SMTP id
 z28-20020a0565120c1c00b004946c98a298mr11690305lfu.18.1662443379658; Mon, 05
 Sep 2022 22:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <20220829055450.1703092-2-dietmar.eggemann@arm.com> <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
 <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net> <CAKfTPtAnC4escfufhjJkqsYyhDPzpmQH4xYT4nj=EjCP7gzifg@mail.gmail.com>
 <12b3443a-6456-4a57-95b3-dd6be5b10873@arm.com>
In-Reply-To: <12b3443a-6456-4a57-95b3-dd6be5b10873@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Sep 2022 07:49:28 +0200
Message-ID: <CAKfTPtCN6fmTZ8mvDWP80_KF2CVdv8AkyB=VKvSvD_HH19ZwVg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
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

On Fri, 2 Sept 2022 at 09:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 29/08/2022 12:13, Vincent Guittot wrote:
> > On Mon, 29 Aug 2022 at 12:03, Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Mon, Aug 29, 2022 at 10:08:13AM +0200, Peter Zijlstra wrote:
> >>> On Mon, Aug 29, 2022 at 07:54:50AM +0200, Dietmar Eggemann wrote:
> >>>> From: Vincent Donnefort <vincent.donnefort@arm.com>
>
> [...]
>
> >>> Hurmph... I'd almost go write you something like
> >>> static_call()/static_branch() but for immediates.
> >>>
> >>> That said; given there's only like 3 options, perhaps a few
> >>> static_branch() instances work just fine ?
> >>
> >> Also, I'm not at all sure about exposing that as an official sysctl.
> >
> > Me too, I would even make it a boot time parameter so we can remove
>
> Isn't a sched feature even less official than a boot parameter?
> But AFAIK at least some of the Android folks want to change this during
> runtime and they don't have debugfs mounted.
>
> > the new clock_task_mult clock and left shift clock_taslk or the delta
> > before passing it to clock_pelt
>
> We still need rq_clock_task_mult(rq), i.e. `rq->clock_task_mult` in
> _update_idle_rq_clock_pelt() though.

Why ? If the mult is defined at boot we just have to use
"rq_clock_task(rq) << mult" instead of rq_clock_task(rq) when updating
clock_pelt
