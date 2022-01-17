Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5417B49062F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiAQKpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiAQKpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:45:46 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E84C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 02:45:46 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x11so30205813lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 02:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFnI2n344fEXDTpdsSUOjcKjWGnGBz/iToNlRmLPe7U=;
        b=fuodsfLNn9z0V31KFyLWJdWRmLOJmd8d6qjy3nFUlF1g58zoZkoP7rywmgO4+FHbeE
         nxQTvJT3gjWFrRHKJztDzSoaxZZg+Kg6YMpWzw0GiwiGBR3z0PjE8cN/cutnAVjqoasr
         ajPDB6M4OXYfYKRTqgIwOCzUDufAInwT2EYKQkXO95uT0DIXiV+o/dNyt2VXdyAHMFaH
         elxH92Hr3LhUhgYhf8PUNVBd/ojbWU0xENhlBtiDFRFZhShkd8ayelU7D9kkCJ2nboPx
         mwVbCe+VXYpU2aI1nfzxNUGbMl1WNRCKYoX/D9wIZZgoOm1dv5q6dKawN+lwtrSzByOG
         N2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFnI2n344fEXDTpdsSUOjcKjWGnGBz/iToNlRmLPe7U=;
        b=0bWZaBPJbrjep6EYZ2MCo9HlsKXoHyTOjjk0/zD3zcEuy6BipGBkG0y31HkDTFTDqb
         ehnKV29+XEgKa+hfulEsaql4PBRU99vg1L2BzvHLYM2ZfRSXAJyTpRufL2s3cQCW9U/J
         biho7kLRhKsIqVqAqWnMPix0kKSntTTIJejsTO6jKsx+AQ2kJuFBIEH0pOh4Xh1M5K7k
         jw7/PzJ/CIRzsRfZT4SitVJRdJHTc0R0Jeg2CThfubCp3rE9Egd7zcisrOgxtmeUhsKh
         fOGMd7KZRE7CwCZwveAbcnkG+IPy5yNNS/xfPWIQY1ZeWgoi0BRCAeedy52T8JaYmqtK
         ivCg==
X-Gm-Message-State: AOAM532Kc1ucaXt90dkgb/wF/VlRYep/tGtT0olMXeWNyzhd4xEC7hUB
        M/ey+DkrKALOuN2gO1x+kZh3ZzLScQMkvYixzfpB24q7XE1U3g==
X-Google-Smtp-Source: ABdhPJx5K/lbq6A3g1jegxd5QCeeVa5zxQ9orXlH1mtKgkViXTNSc3JWjZe2RmXcaM0qs4zw+si+k1SAF1Z83zLeIaE=
X-Received: by 2002:a2e:908e:: with SMTP id l14mr5020043ljg.266.1642416344654;
 Mon, 17 Jan 2022 02:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20211220114323.22811-1-vincent.donnefort@arm.com>
 <20211220114323.22811-4-vincent.donnefort@arm.com> <CAKfTPtDjVdPimPbOes5Oix=3NYi3ZWY1dvQjZY3hoMfYbxXuDw@mail.gmail.com>
 <Ydxhe7wkHsq5U6Gk@FVFF7649Q05P>
In-Reply-To: <Ydxhe7wkHsq5U6Gk@FVFF7649Q05P>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 17 Jan 2022 11:45:33 +0100
Message-ID: <CAKfTPtBDh71zZ41M+p+8r2HQiNyaBNckTD2n8_1No-1pghZJaQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/fair: Do not raise overutilized for idle CPUs
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com, Morten.Rasmussen@arm.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 at 17:40, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> On Wed, Dec 22, 2021 at 09:20:17AM +0100, Vincent Guittot wrote:
> > On Mon, 20 Dec 2021 at 12:43, Vincent Donnefort
> > <vincent.donnefort@arm.com> wrote:
> > >
> > > During a migration, the lock for the previous runqueue is not taken and
> > > hence, the task contribution isn't directly removed from that runqueue
> > > utilization but instead temporarily saved, until the next PELT signals
> > > update where it would be accounted. There is then a window in which a
> > > CPU can ben idle be nonetheless overutilized.
> > >
> > > The load balancer wouldn't be able to do anything to help a sleeping CPU,
> > > it brings then no gain to raise overutilized there, only the risk of
> > > spuriously doing it.
> >
> > But how do you make the difference between a very short idle time of
> > an overutilized CPU and a idle cpu with outdated utilization
>
> No distinction here, but if the CPU is idle there's nothing to pull, so the load
> balance wouldn't do anything with this information.

The load balance has never done anything with this information. This
information is only used to disable LB for EAS and as mentioned below,
being idle is not a good reason for not being overutilized.

Also this patch seems to be there just to fix a problem created by the
previous one which triggers the costly new idle load balance without
good reason

>
> >
> > Being idle is not a good reason for not being overutilized (ie ~80% of
> > average utilisation)
> >
> > >
> > > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 51f6f55abb37..37f737c5f0b8 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8641,26 +8641,28 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> > >
> > >                 nr_running = rq->nr_running;
> > >                 sgs->sum_nr_running += nr_running;
> > > -
> > > -               if (nr_running > 1)
> > > -                       *sg_status |= SG_OVERLOAD;
> > > -
> > > -               if (cpu_overutilized(i))
> > > -                       *sg_status |= SG_OVERUTILIZED;
> > > -
> > >  #ifdef CONFIG_NUMA_BALANCING
> > >                 sgs->nr_numa_running += rq->nr_numa_running;
> > >                 sgs->nr_preferred_running += rq->nr_preferred_running;
> > >  #endif
> > > +               if (nr_running > 1)
> > > +                       *sg_status |= SG_OVERLOAD;
> >
> > Why do you move this code related to overload ?
>
> This was a cosmetic change to put the NUMA related stats next to the other ones.

Please don't add unrelated cosmetic changes in a patch

>
> [...]
