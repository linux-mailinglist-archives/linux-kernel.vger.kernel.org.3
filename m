Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93ED5AC08B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiICSJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiICSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:09:25 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3D62C6;
        Sat,  3 Sep 2022 11:09:22 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3376851fe13so41219717b3.6;
        Sat, 03 Sep 2022 11:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5TvOzDgsOBFBbklyss9/Ftz1OqCB2n8dPRcJ8qkoIdo=;
        b=CVEc5V5ZZjTR0Cwrp0rZTtpmBH+nddLl3DSue+PqLbNyvpbqpcve2+0UmFpe6mDM//
         k92YB4q8rbWYYM7pTnSI9E++0nfaC/yLjBE9ZrUp7M00KtHD97aMRF1iMNXlvR/1ijGe
         4uyVKjnGGZ+62MdpT4zprk6nqWgWw6nLWoFXl2ySj0b6Gks8+scPIsKFXZKg4fsIJgRs
         QZXVXIkfqwOZuMg45oiSc6C55g/nVE339JhuGsctsCpdxSEMI2K3wrXgmTT3/qf7V7eu
         X2r6P3kMmzAy0B+0Zo14lGs4xMzUv5g8KXzE3KiMv6KdMN+hIjqXY6k/wBnA8UYniHhj
         VQaw==
X-Gm-Message-State: ACgBeo134I8Kc78h3JtLHD4HS/oaGMdoT1+bItC6QzdxllVGVKwM7/QT
        Ze1SwZRRDG9hKr8rIWBQ1eXbgm0s0JfXbFR0Igg=
X-Google-Smtp-Source: AA6agR70ERCaU+wGxH3tC+tdf2v4CCkjEOH0SXQw0lYGliAJvpTjIwuIbS/uEBJCecIb40tkW1kniJeaGH2ATGcxqmg=
X-Received: by 2002:a0d:c841:0:b0:33d:bf96:f823 with SMTP id
 k62-20020a0dc841000000b0033dbf96f823mr31231457ywd.326.1662228559975; Sat, 03
 Sep 2022 11:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220825114018.1715-1-xuewen.yan@unisoc.com> <20220830053417.eebsc6joyvlpti3s@vireshk-i7>
In-Reply-To: <20220830053417.eebsc6joyvlpti3s@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:09:08 +0200
Message-ID: <CAJZ5v0j=s-RS2oVjPtR0=pAiXHNwvtDih6Jt6dffC4eKh1bBcg@mail.gmail.com>
Subject: Re: [PATCH] thermal: Check the policy first in cpufreq_cooling_register
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xuewen.yan94@gmail.com, Di Shen <di.shen@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 7:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 25-08-22, 19:40, Xuewen Yan wrote:
> > Since the policy needs to be accessed first when obtaining cpu devices,
> > first check whether the policy is legal before this.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>
> Fixes: 5130802ddbb1 ("thermal: cpu_cooling: Switch to QoS requests for freq limits")
>
> > ---
> >  drivers/thermal/cpufreq_cooling.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> > index b76293cc989c..7838b6e2dba5 100644
> > --- a/drivers/thermal/cpufreq_cooling.c
> > +++ b/drivers/thermal/cpufreq_cooling.c
> > @@ -501,17 +501,17 @@ __cpufreq_cooling_register(struct device_node *np,
> >       struct thermal_cooling_device_ops *cooling_ops;
> >       char *name;
> >
> > +     if (IS_ERR_OR_NULL(policy)) {
> > +             pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> >       dev = get_cpu_device(policy->cpu);
> >       if (unlikely(!dev)) {
> >               pr_warn("No cpu device for cpu %d\n", policy->cpu);
> >               return ERR_PTR(-ENODEV);
> >       }
> >
> > -     if (IS_ERR_OR_NULL(policy)) {
> > -             pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
> > -             return ERR_PTR(-EINVAL);
> > -     }
> > -
> >       i = cpufreq_table_count_valid_entries(policy);
> >       if (!i) {
> >               pr_debug("%s: CPUFreq table not found or has no valid entries\n",
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.1 material, thanks!
