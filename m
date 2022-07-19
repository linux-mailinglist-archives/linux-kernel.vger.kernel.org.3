Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B44057963F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbiGSJZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiGSJZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:25:12 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF1F26D2;
        Tue, 19 Jul 2022 02:25:11 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id y129so5240960vkg.5;
        Tue, 19 Jul 2022 02:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbzt5brwIFebOYyM4ZgDYkJkzvlzIdlBNH+my/RdY6o=;
        b=Kbgqukdw3Hr3yO/3tiu0dzncOSRmBVyWKbBxWUR7JOkvWgKYLgV6kd+K+JQAoa9vP+
         KZnNclDJNUJmW1YdgQgG4F/OPmr8EA7xTlPFmthzqJZpsz6hEYD5Mr3Xsx2LF2EsNAVI
         DOr61HM4Tj2ORfFGsaYI9ofta4FT5///eDb/tkqneI3O5Xq2bUImZnLAPyqOHHV06/WC
         WBlwzfhvBEyKx1WocJo+NsjIAys116N2ev7+o7hQkMgA6jQfg2Lo5vmr3hC5hthZV6Ti
         OY9wUiJpc76RplbhQQlGSWEwbdmw0OWSFQytK/MMzZTLmW3zVZNYnjHEzXaLUaA1eIYa
         Lbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbzt5brwIFebOYyM4ZgDYkJkzvlzIdlBNH+my/RdY6o=;
        b=UF/C+jl0tzO99t6+YmoGPon33YQQOuxMcRYKjrqpbJLMolDvPO2pusY0NijPRVqsT4
         FunyRf8qYgHOh3oUoElJEWxcQ3SRVPZKCqJzHs+rXWnDNks51qsgciX7v8u8xwHxWLCm
         WErmRd0kzCzznSHlKbis5/cemA4mBcq8rdUzLSSlaJ9BOagZm9m7oW6BpjkHAbisuPFd
         b3Y86q/aY4mStXcJ/SdgTKgJIEUeuHug1ooq6dZNJckTPm5BArZgdBSaGnQk1Xa17Pn7
         ClgjHvdjCS8qNXK/AVU+ozr2/SZI3qdFPGZjoC/8suJzdcjca8mgaActLfqL9poKsdTR
         Hb+g==
X-Gm-Message-State: AJIora+RplHUFXjUwQADWXygUmSFiq5mxlwChdDGhYF6V+QOtwEYfemj
        sHpB+WZTuFrENo8GUHa9hxT0oeyuoEWtVJ4TgzU=
X-Google-Smtp-Source: AGRyM1uJcYQerGd6gZzEV5+14xzWb79dJ15Erdb4eh4msNDwjzzAx7WtLmug0gVdEgCKtp7RB+N5jX+Qy3O/+L7Yx28=
X-Received: by 2002:a1f:2049:0:b0:374:866b:6dd8 with SMTP id
 g70-20020a1f2049000000b00374866b6dd8mr11149001vkg.15.1658222710222; Tue, 19
 Jul 2022 02:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220718122419.9409-1-di.shen@unisoc.com> <20220719041448.iyavinsv3jzs3au4@vireshk-i7>
In-Reply-To: <20220719041448.iyavinsv3jzs3au4@vireshk-i7>
From:   Di Shen <cindygm567@gmail.com>
Date:   Tue, 19 Jul 2022 17:24:59 +0800
Message-ID: <CAHYJL4r4A5k=ztd+PavibF1xcMCiLdaCqZK6B0PwayaHH2210Q@mail.gmail.com>
Subject: Re: [PATCH] thermal: cpufreq_cooling: Avoid all cluster using global cooling_ops
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Di Shen <di.shen@unisoc.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>, amit.kachhap@gmail.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xuewen.yan@unisoc.com, xuewen.yan94@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it fixes this problem! Thank you:)

BR
Di

On Tue, Jul 19, 2022 at 12:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-07-22, 20:24, Di Shen wrote:
> > Now, all the cooling device use the globle cpufreq_cooling_ops. When the
> > CONFIG_THERMAL_GOV_POWER_ALLOCATOR is enabled, once one cluster init the
> > cpufreq_cooling_ops, it would make all cooling device use the power allocator's
> > ops. If one's em is error because of the "em_is_sane", it would cause the
> > em NULL, but the cooling device's ops is exist, as a result, it would cause
> > panic because of the em.
> >
> > Add cpufreq_power_cooling_ops to avoid this case.
> >
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  drivers/thermal/cpufreq_cooling.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> > index b8151d95a806..af5cfb458370 100644
> > --- a/drivers/thermal/cpufreq_cooling.c
> > +++ b/drivers/thermal/cpufreq_cooling.c
> > @@ -493,6 +493,17 @@ static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
> >       .set_cur_state          = cpufreq_set_cur_state,
> >  };
> >
> > +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> > +static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
> > +     .get_max_state          = cpufreq_get_max_state,
> > +     .get_cur_state          = cpufreq_get_cur_state,
> > +     .set_cur_state          = cpufreq_set_cur_state,
> > +     .get_requested_power    = cpufreq_get_requested_power,
> > +     .state2power            = cpufreq_state2power,
> > +     .power2state            = cpufreq_power2state,
> > +};
> > +#endif
> > +
> >  /**
> >   * __cpufreq_cooling_register - helper function to create cpufreq cooling device
> >   * @np: a valid struct device_node to the cooling device device tree node
> > @@ -559,9 +570,7 @@ __cpufreq_cooling_register(struct device_node *np,
> >  #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> >       if (em_is_sane(cpufreq_cdev, em)) {
> >               cpufreq_cdev->em = em;
> > -             cooling_ops->get_requested_power = cpufreq_get_requested_power;
> > -             cooling_ops->state2power = cpufreq_state2power;
> > -             cooling_ops->power2state = cpufreq_power2state;
> > +             cooling_ops = &cpufreq_power_cooling_ops;
> >       } else
> >  #endif
> >       if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED) {
>
> Please have a look at this patch in linux-next.
>
> commit 6ee324afdf30 ("drivers/thermal/cpufreq_cooling: Use private callback ops for each cooling device")
>
> This already fixes the problem, right ?
>
> --
> viresh
