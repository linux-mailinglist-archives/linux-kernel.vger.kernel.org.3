Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5536853FB12
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbiFGKTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbiFGKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:19:30 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA39EBE92
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:19:27 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-30c2f288f13so170041327b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FL/UAS4bQAWgbLIprGtoSAT6rD1oU9uh25nWrLBVWyU=;
        b=FS5YDsuS2FHiC5HezMtUXuVfIkymf1wecm4Gbym5lxt8lglm/3xmLFBaHtV6+HI5wB
         e6e2DMmxKgKXGz1P0moSs0V/HADxcdP4Qe3YDHa6Fa32jQUrsWyN7i99lArY56MpYzxN
         1S0SGq8dpUOIRJrlLXoKTRbMnLSkiQbp4aGRgCpQmO9atYkCtscbCZceo/a5uV5hVA0I
         b2SBKSK6+sy56nj8Qn2FubBLEvBjanIDOAGr17lrOtgol440nkRAALCRqmm25HS4p2Vz
         hYk+1vxm/b+xo/rvs/VQZ9ntDCdiITpFp+sCk0HFXn6n09QOHCQ6QrUUuHyU/YkQQRxr
         v70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FL/UAS4bQAWgbLIprGtoSAT6rD1oU9uh25nWrLBVWyU=;
        b=dbt4NaL8TGJvqYQaB039+3IkskuT3xIon+IxaFULWMHgnrb2+lR3WrmLpzMsI78ZAo
         FXSRHiwUs+LFJtFLrdpXspKJoQixrav78anF597AEyhWGdpKO3uTsocs3WNcQaDegfeO
         wGIGlxzT6ZmKgLURefniefwRthuXguXvMxyp8ykQ8oPfEgWLS+bGQ8/Dn5z5EdIitZdT
         vLkvDwWTxcZyr+2hu7VQIrNuFFAGWKXHum+D3hLVo3wwDe7+PwTS5DxJbKSfWWGnXUQ6
         wKqEwmH9OY6h0osrB2BWX+O4h1TqAnrdEtdjQULoP/ApMlydVLOkCeqaOjuPBpKvDxBr
         X+aQ==
X-Gm-Message-State: AOAM533U7Zz8/TnKwWzZ37AH4H0GjC2TuSazm3ZmK6Bxb7usJl/1X67h
        A80e/7G+q3RV+zbfVUdoFrVOkY/E0pdaxwUybk7R958rz75WWQ==
X-Google-Smtp-Source: ABdhPJwTlfX4/yt38cyd8nB1rH50UsF611jeTqSE+Vd2N9PXULgwLicRFox22IGpZU1L9ojt9wHni/ekr8MGO/x0fZI=
X-Received: by 2002:a81:6357:0:b0:30f:dbe5:b8ff with SMTP id
 x84-20020a816357000000b0030fdbe5b8ffmr28720416ywb.67.1654597166370; Tue, 07
 Jun 2022 03:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220523155140.2878563-1-vdonnefort@google.com>
 <20220523155140.2878563-3-vdonnefort@google.com> <72bd6945-c167-65ba-6f81-fad2768972dc@arm.com>
 <Yp3JZIokwFxT+X6M@google.com> <CAKfTPtD6TpaJoz37Xv2_1Cc8ij_XGFjDTwA+TvN3ddiASkYc4g@mail.gmail.com>
 <Yp8ico+B8USmi7fY@google.com>
In-Reply-To: <Yp8ico+B8USmi7fY@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Jun 2022 12:19:14 +0200
Message-ID: <CAKfTPtC1OQVLpHm3Qmj0bD0fZKp76DQf9tNruNMG57u4yv42sQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] sched/fair: Decay task PELT values during wakeup migration
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com
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

On Tue, 7 Jun 2022 at 12:03, Vincent Donnefort <vdonnefort@google.com> wrote:
>
> [...]
>
> > > >
> > > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > > index bf4a0ec98678..97bc26e5c8af 100644
> > > > > --- a/kernel/sched/sched.h
> > > > > +++ b/kernel/sched/sched.h
> > > > > @@ -648,6 +648,10 @@ struct cfs_rq {
> > > > >     int                     runtime_enabled;
> > > > >     s64                     runtime_remaining;
> > > > >
> > > > > +   u64                     throttled_pelt_idle;
> > > > > +#ifndef CONFIG_64BIT
> > > > > +   u64                     throttled_pelt_idle_copy;
> > > > > +#endif
> > > > >     u64                     throttled_clock;
> > > > >     u64                     throttled_clock_pelt;
> > > > >     u64                     throttled_clock_pelt_time;
> > > > > @@ -1020,6 +1024,12 @@ struct rq {
> > > > >     u64                     clock_task ____cacheline_aligned;
> > > > >     u64                     clock_pelt;
> > > > >     unsigned long           lost_idle_time;
> > > > > +   u64                     clock_pelt_idle;
> > > > > +   u64                     enter_idle;
> > > > > +#ifndef CONFIG_64BIT
> > > > > +   u64                     clock_pelt_idle_copy;
> > > > > +   u64                     enter_idle_copy;
> > > > > +#endif
> > > > >
> > > > >     atomic_t                nr_iowait;
> > > >
> > > > `throttled_pelt_idle`, `clock_pelt_idle` and `enter_idle` are clock
> > > > snapshots when cfs_rq resp. rq go idle. But the naming does not really
> > > > show this relation. And this makes reading those equations rather difficult.
> > > >
> > > > What about something like `throttled_clock_pelt_time_enter_idle`,
> > > > `clock_pelt_enter_idle`, `clock_enter_idle`? Especially the first one is
> > > > too long but something which shows that those are clock snapshots when
> > > > enter idle would IMHO augment readability in migrate_se_pelt_lag().
> > >
> > > What if I drop the "enter"?
> > >
> > >  clock_idle;
> > >  clock_pelt_idle;
> > >  throttled_clock_pelt_time_idle;
> >
> > and you can even remove the _time for throttled_clock_pelt_idle
> >
>
> Hum, "throttled_clock_pelt" already exists, while what we really snapshot is
> "throttled_clock_pelt_time".

What is snapshot is throttled_clock_pelt when entering idle so my
proposal of "throttled_clock_pelt_idle"
throttled_clock_pelt_idle doesn't exist and reflect  that it's
throttled_clock_pelt when cfs_rq enter idle just like clock_pelt_idle
reflect clock_pelt when entering idle
