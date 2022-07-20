Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D971257BA30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbiGTPev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiGTPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:34:48 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2238264E02
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:34:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 75so32695320ybf.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Crer058ze3PwaonKRdC4LpQYqjPuLYChBMwh4KbPnn8=;
        b=qJAz2qGSRiZTW57sRLjXpyb0A/PJhN5XFHLc6vqkEdXY8zZJN2Siw4/VqP9NrmnZel
         9Kir1SdxEFpQ5mbmPjWz358egrNaTNL2T42Sjc3A93ge2zZUfg/+F598miH+86OnXg0k
         R7duC/S4DQ5zY8Xql9J6967BgCJQtX449TGNUfvIYv7rnwkETO4wNWh2P5AikvUczpeA
         OfDMRpSpx+8dh/M/+0VE0vgTOA332OKI+GqjwUkyMTmQ/CHkUl/S+IW+Q4jrdBszVcEi
         mE2FYcbVRRELPZOtCPerzdbJ5nVP13JmpyevEqVUVoRMx7mVYeLNL6ZDuO48rIhDtVKt
         +ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Crer058ze3PwaonKRdC4LpQYqjPuLYChBMwh4KbPnn8=;
        b=Ns93Fx4d1YFiE67tBWe200I7gyEgD3t42nH9fdvoydoCSmI9Gf0tUdf/cTDlQc8PLo
         9IqvGdftJWVDK2LCVbOVTj7G1TNaWNM1hFB9jK7mLEG1tKnVYYzB28Wb38scfwJLF5TP
         3fzs1CvQatjmIx4EjpFjJ5pNIZDx1ov2kKhXRoq8QedtTRaUWc/MqUI82GvGRGZ4d4BW
         E7xjLJ3D0+RSKsy04z5km7P852wl68zCNo6qFP0zXVM8+SMQxiyccpHPrrehzjnNdHCD
         kMFxFD6xtE2qevwIYV6ATLTze8ElDfXSxYDhThHEWuBplA9DHeDs40KxKFmO07hO2wNh
         wjnQ==
X-Gm-Message-State: AJIora+MWskRcPkcF1UZsCUN+xaygB1nVsfXx4xvDENEP6rtVNxdXzGf
        UVcOQrv/hrymUQnGeH0yLdhfDup0ep0poxiGJmBP3Q==
X-Google-Smtp-Source: AGRyM1ui+FLHL3WbbwpvveQ67BPd/NChz2FAuRCVRYunaa0VQFnjWYgbtvNKZd383DmMKd97YU9fPPQocPFDkBsbioo=
X-Received: by 2002:a25:76cd:0:b0:66e:c634:1047 with SMTP id
 r196-20020a2576cd000000b0066ec6341047mr37706655ybc.241.1658331284479; Wed, 20
 Jul 2022 08:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-8-zhouchengming@bytedance.com> <e838ac28-f68e-2282-94d5-616ea3bdf8d0@arm.com>
 <88062fb6-e2fe-cf4e-10b5-7694c4d30941@bytedance.com> <CAKfTPtCsd2RkOZoa10SSwKhm0NRzmOphAVNW7_JykqzxqfkSXg@mail.gmail.com>
 <107763fc-7eab-a807-fa15-024178bdf57e@bytedance.com>
In-Reply-To: <107763fc-7eab-a807-fa15-024178bdf57e@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 Jul 2022 17:34:32 +0200
Message-ID: <CAKfTPtBo9GgkT1VeVA+1CBhiVZ8Vf+kp0XV3PWcBLGuZaz_hKQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 07/10] sched/fair: use update_load_avg()
 to attach/detach entity load_avg
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 at 15:41, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2022/7/19 18:29, Vincent Guittot wrote:
> > On Fri, 15 Jul 2022 at 18:21, Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>

...

> >>
> >>>
> >>> Looks to me that you want to replace this by your `freeze PELT when
> >>> outside fair` model.
> >>
> >> Yes, want to freeze PELT for two !fair cases:
> >>
> >> 1. !fair task hasn't been fair before: will still have its init load_avg
> >>    when switch to fair.
> >
> > But I'm not sure it makes sense to keep these init values. As an
> > example, the util_avg is set according to the cpu utilization at the
> > time of the task creation. I would tend to decay them as these init
> > values become less and less relevant.
> >
> > so we should return early in post_init_entity_util_avg() and don't set
> > util_avg if sched class is not cfs
>
> Yes, this indeed is a problem if we attach this init sched_avg of !fair task.
> I'm also not sure whether it make sense to keep them to 0 ? Will it cause
> unfairness problem between cfs_rqs?

Why should it cause an unfairness problem ? !fair tasks are not
accounted and their pelt values will be decayed down to 0 after 320ms
anyway (with the current implementation). So it's just like if you
started directly after those 320ms

>
> >
> >>
> >> 2. !fair task has been switched_from_fair(): will still keep its lastest
> >>    load_avg when switch to fair.
> >>
> >>>
> >>>> This patch make update_load_avg() the only location of attach/detach,
> >>>> and can handle these corner cases like change cgroup of NEW tasks,
> >>>> by checking last_update_time before attach/detach.
> >>>
> >>> [...]
> >>>
> >>>> @@ -11527,9 +11522,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
> >>>>      struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >>>>
> >>>>      /* Catch up with the cfs_rq and remove our load when we leave */
> >>>> -    update_load_avg(cfs_rq, se, 0);
> >>>> -    detach_entity_load_avg(cfs_rq, se);
> >>>> -    update_tg_load_avg(cfs_rq);
> >>>> +    update_load_avg(cfs_rq, se, UPDATE_TG | DO_DETACH);
> >>>
> >>> IMHO, the DO_[DE|AT]TACH comments in update_load_avg() would have to be
> >>> updated in this case.
> >>
> >> Correct, will do.
> >>
> >> Thanks.
> >>
> >>>
> >>> [...]
