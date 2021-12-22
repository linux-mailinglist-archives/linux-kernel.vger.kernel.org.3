Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB22447CDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbhLVIUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239583AbhLVIUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:20:31 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9512DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:20:30 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id bn20so2520782ljb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Smub1PVQp+Gnfb9kOw4YZKWYUmEaFc+hKcFDOl5Qwjo=;
        b=cBLvQ56WDwYomuYdUBxvaalEPoeJYcW6MKmxEaOm8mW/r0bN6Xl5ofsnbl7KJ573t1
         edwIHxqqYZdZGTtZqXYVnNhRI4EwrYpPiMVIRjJbAVcFHxswtyOXbggWCBM8/hxVXR7Q
         /me75RQYwnXXutBixXfPpQE98vJnVRv+z5DhMQq3i1qmr3aStFCXKPCuy8WkuC6A4nXI
         z0wcnIfFt2psFXLTCwWAykxnR9xt13BJgPRXf3N3MDoXg87J7kDLZxJO064IhesFJsMT
         wK8VPoRX1WyyrDyo1w/HjnkbCe01iYzf1IywaP2YFg8/nGEnJ06JzU+BA8qccB9olJ0z
         0TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Smub1PVQp+Gnfb9kOw4YZKWYUmEaFc+hKcFDOl5Qwjo=;
        b=3RfBoF/v6OdrLHVGtQ3jyI4Y9WNsL9KPnp75aqHlhRRBpjJFuDhUzcT916VHksWLdC
         1DfqGLkegK+/uXAIEc/wtzQkpyEzj7/9NrlFiL23fjEDlpQpCtiiHZ6JqWJQvvMM52x4
         bCW8TpBWCz/WB1z/dTLjdFWPgW3UfQYVKwiWx6dUKE1Gvo0NGMaT4NCQ3un+IxbhWjaS
         RkIQO/D2CrAJenwEMX/qMicGs2T9q0FYF+73IWxherU4dxTawmkFFGmkAKaKgzWdODRE
         YgHlcQsVWxydlE5+nZhlza/PcBGuHzmg9nAd65BP6Xqwf20HNCChKpDq5bIhbGFCc3At
         a5iA==
X-Gm-Message-State: AOAM533yirBmQMgdK4cukjuyCPHP+bKOJMxOC0Cc8oqYM7s4PowYfuye
        lEh0mood4yQQ5TxGvlRgHTYmG0QZ1J5SkTLC78RMROLBXGc=
X-Google-Smtp-Source: ABdhPJxsj9CtccX1xFPe20ZRQAVdi41gnLwDYjGiZc6b/U/adsq2a7+D3YJxl8Bt/qBkzynKiMjHTYGyG37fU/bxxTw=
X-Received: by 2002:a2e:b0c5:: with SMTP id g5mr1402036ljl.381.1640161228814;
 Wed, 22 Dec 2021 00:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20211220114323.22811-1-vincent.donnefort@arm.com> <20211220114323.22811-4-vincent.donnefort@arm.com>
In-Reply-To: <20211220114323.22811-4-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Dec 2021 09:20:17 +0100
Message-ID: <CAKfTPtDjVdPimPbOes5Oix=3NYi3ZWY1dvQjZY3hoMfYbxXuDw@mail.gmail.com>
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

On Mon, 20 Dec 2021 at 12:43, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> During a migration, the lock for the previous runqueue is not taken and
> hence, the task contribution isn't directly removed from that runqueue
> utilization but instead temporarily saved, until the next PELT signals
> update where it would be accounted. There is then a window in which a
> CPU can ben idle be nonetheless overutilized.
>
> The load balancer wouldn't be able to do anything to help a sleeping CPU,
> it brings then no gain to raise overutilized there, only the risk of
> spuriously doing it.

But how do you make the difference between a very short idle time of
an overutilized CPU and a idle cpu with outdated utilization

Being idle is not a good reason for not being overutilized (ie ~80% of
average utilisation)

>
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 51f6f55abb37..37f737c5f0b8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8641,26 +8641,28 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>
>                 nr_running = rq->nr_running;
>                 sgs->sum_nr_running += nr_running;
> -
> -               if (nr_running > 1)
> -                       *sg_status |= SG_OVERLOAD;
> -
> -               if (cpu_overutilized(i))
> -                       *sg_status |= SG_OVERUTILIZED;
> -
>  #ifdef CONFIG_NUMA_BALANCING
>                 sgs->nr_numa_running += rq->nr_numa_running;
>                 sgs->nr_preferred_running += rq->nr_preferred_running;
>  #endif
> +               if (nr_running > 1)
> +                       *sg_status |= SG_OVERLOAD;

Why do you move this code related to overload ?

> +
>                 /*
>                  * No need to call idle_cpu() if nr_running is not 0
>                  */
>                 if (!nr_running && idle_cpu(i)) {
>                         sgs->idle_cpus++;
> -                       /* Idle cpu can't have misfit task */
> +                       /*
> +                        * Idle cpu can neither be overutilized nor have a
> +                        * misfit task.
> +                        */
>                         continue;
>                 }
>
> +               if (cpu_overutilized(i))
> +                       *sg_status |= SG_OVERUTILIZED;
> +
>                 if (local_group)
>                         continue;
>
> --
> 2.25.1
>
