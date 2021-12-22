Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF1E47CDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbhLVIPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhLVIO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:14:57 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A0BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:14:57 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id p8so2511495ljo.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PuJvsA2cOJ+aWNScjJ4VRV1oM6NY08nJ5cVbE6tDGY=;
        b=tTJJ0f95EQ3LuByNRVe0F5RbwbOvgrh6cko9fwWkZ7eyiHscxzH3Q0lNjv3+e2rFov
         GCip1muDIStOQua/aqY6SxZBMMv4kSgu/c6RTGiZwuCTG60XJIdzP2GHF1jyiAS5FTuq
         nzfUFdxN3l6KAUgTCV2vo18os9v5TI9/RcwF8vdhxAVv7u8N2KCwFGm+me/eQ/jX/9o1
         +J7iTODGo2quAf34w6S+11Q4IMLp1J8R/x71Ktp/tu6s3pGcZERkz8ox4BIc8cPFUS75
         VBdjcDn1/vQ+9kXzPvOESQazqR0iNLNULBap2R3+iZYAGfBQvu6cSdjnZzSTMaxbd/u7
         UgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PuJvsA2cOJ+aWNScjJ4VRV1oM6NY08nJ5cVbE6tDGY=;
        b=rMiK83WpBBwJitScrqjvBrGdsJhOHk/MUTsqgN6wKrq1GO5EcRc32NmL2HpOkI6qAH
         xE8rfOYXRxewnZ01zJECbM0CBNPkiTdLneJPMPWD37dStFa5kC8UT29fPj6V4QQu+AXl
         7MHZQLCrpRNq8Ywi/LdR45SQdUz9beHGuBH/Ufzg6a+BA91GVhMWTmTi2f2gxqFWPQUv
         LBvq7QgL9EUiDiya/QT0R1IDSRkuYD2jxk/8un0MANyhLVxcRjpujo6bIddTzEkgFFCf
         9LwBxjqSL86MOlrm39osgQQMJ0OK36DzGt0IMrojyz38b6TrzB5CkkT8dFYQFt0rrurY
         oVZw==
X-Gm-Message-State: AOAM530ewycAdGjdXeZHODUj5iyrukc+U6KOioCTGKTvFG5WQeqjzBGx
        VhTZ/fQJ5TJ9/utbA+5YohrmtInHHRVgc7enmQ0bEQ==
X-Google-Smtp-Source: ABdhPJziRRsZLPJUgUo7B9x4Io1Jum67pS0blnPfQlVCM0d/uYZKaFLf6gUFAng/pO8rdTJKx1d6N7rYaC3H3p1YmGU=
X-Received: by 2002:a2e:b88e:: with SMTP id r14mr1391411ljp.365.1640160895143;
 Wed, 22 Dec 2021 00:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20211220114323.22811-1-vincent.donnefort@arm.com> <20211220114323.22811-3-vincent.donnefort@arm.com>
In-Reply-To: <20211220114323.22811-3-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Dec 2021 09:14:44 +0100
Message-ID: <CAKfTPtCJPHfoiuspYMGPARHdOuLJ6g0oUx2EQjdEPz729NrDPA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: Fix newidle_balance() for overutilized systems
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
> On Energy-Aware Scheduling systems, load balancing is disabled in favor of
> energy based placement, until one of the CPU is identified as being
> overutilized. Once the overutilization is resolved, two paths can lead to
> marking the system as non overutilized again:
>
>   * load_balance() triggered from newidle_balance().
>   * load_balance() triggered from the scheduler tick.
>
> However, small caveat for each of those paths. newidle_balance() needs
> rd->overload set to run load_balance(), while the load_balance() triggered
> by the scheduler tick needs to run from the first idle CPU of the root
> domain (see should_we_balance()).
>
> Overutilized can be triggered without setting overload (this can happen
> for a CPU which had a misfit task but didn't had its util_avg updated
> yet). Then, only the scheduler tick could help to reset overutilized...
> but if most of the CPUs are idle, it is very unlikely load_balance() would
> run on the only CPU which can reset the flag. This means the root domain

AFAICT, this will happen as you don't have to run on the only CPU but
for the only CPU and this is what ilb is doing. So your problem is not
to run on the only CPU that can clear overutilized

> can spuriously maintain overutilized for a long period of time.
>
> We then need newidle_balance() to proceed with balancing if the system is
> overutilized.

Always triggering a costly newidle_balance when you are already
overutilized for the sole purpose of clearing overutilized seems to be
a bit overkill.

Furthermore, nothing prevents us to abort newidle_balance before
reaching the root domain

So this doesn't seem like the good way to proceed

>
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e2f6fa14e5e7..51f6f55abb37 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10849,7 +10849,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>         rcu_read_lock();
>         sd = rcu_dereference_check_sched_domain(this_rq->sd);
>
> -       if (!READ_ONCE(this_rq->rd->overload) ||
> +       if ((!READ_ONCE(this_rq->rd->overload) &&
> +           !READ_ONCE(this_rq->rd->overutilized)) ||
>             (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>
>                 if (sd)
> --
> 2.25.1
>
