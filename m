Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D1D51DF6A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389415AbiEFTBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiEFTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:01:40 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE8463533;
        Fri,  6 May 2022 11:57:56 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2f83983782fso91316007b3.6;
        Fri, 06 May 2022 11:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxlPrmLfCbB332ULeV+CNmlFte+BFEYMZyJdYeXRAX4=;
        b=LLA365oRD3tB46h/avyo/fnH4YTGU9rMIg2VBIG646C5BbJ43yIsebDPvrDB0NRcHa
         pGsmCDY5Ohizj2Ex1Tldh+xtd06+zX7nTH4YRsc1Dh9fj0nrh4eYYkZ/uIBO5sWQo1wy
         lREECU4muq3I4I6L+nhxqzs8avmux6THyDkHPtTjd3BPDhHbrXpGE1QQkAwSA5CD+jqL
         Awa99TPbg+TVanr14czj0NOseZB4mnZlHjWl7vOImfU3mUakbHpif7mb78+d1pI51/Fy
         Np/+Iru45+oHQhdZSRLwBgpEbsoM8N/r4pp/Iiadf8iLAPD3HIAeaXI5ZXdbCnot5F75
         tMGg==
X-Gm-Message-State: AOAM530u34qWGO7tmRkEY8FdjP/L0VSM7RVNCOiK6e4hQ7n5BiLUiu6/
        hlnxMryIy0Da+aTJ3rQeqAcGVr6q1XugNUwqPxc=
X-Google-Smtp-Source: ABdhPJwgiEChSGf9qvyjy1T6zYSy5XNdQbCamYh3pl5CMGsNXjJNpyDK30nh70IBONDR0lTHUw8ZW6bTd6FXqI7qopY=
X-Received: by 2002:a81:2f4e:0:b0:2fb:2c97:d66f with SMTP id
 v75-20020a812f4e000000b002fb2c97d66fmr4072572ywv.196.1651863475864; Fri, 06
 May 2022 11:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
 <0b9e332d-f479-ed3d-78ce-6386383d827b@gmail.com>
In-Reply-To: <0b9e332d-f479-ed3d-78ce-6386383d827b@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 May 2022 20:57:44 +0200
Message-ID: <CAJZ5v0itm1CmdVoO3kiwuLteuNqAvt7TqcMDOpYnBRM=yf4n9Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Avoid unnecessary frequency updates due to mismatch
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
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

On Thu, May 5, 2022 at 3:32 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 04/05/2022 10:21, Viresh Kumar wrote:
> > For some platforms, the frequency returned by hardware may be slightly
> > different from what is provided in the frequency table. For example,
> > hardware may return 499 MHz instead of 500 MHz. In such cases it is
> > better to avoid getting into unnecessary frequency updates, as we may
> > end up switching policy->cur between the two and sending unnecessary
> > pre/post update notifications, etc.
> >
> > This patch has chosen allows the hardware frequency and table frequency
> > to deviate by 1 MHz for now, we may want to increase it a bit later on
> > if someone still complains.
> >
> > Reported-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> > ---
> >   drivers/cpufreq/cpufreq.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0d58b0f8f3af..233e8af48848 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -28,6 +28,7 @@
> >   #include <linux/suspend.h>
> >   #include <linux/syscore_ops.h>
> >   #include <linux/tick.h>
> > +#include <linux/units.h>
> >   #include <trace/events/power.h>
> >
> >   static LIST_HEAD(cpufreq_policy_list);
> > @@ -1708,6 +1709,16 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
> >               return new_freq;
> >
> >       if (policy->cur != new_freq) {
> > +             /*
> > +              * For some platforms, the frequency returned by hardware may be
> > +              * slightly different from what is provided in the frequency
> > +              * table, for example hardware may return 499 MHz instead of 500
> > +              * MHz. In such cases it is better to avoid getting into
> > +              * unnecessary frequency updates.
> > +              */
> > +             if (abs(policy->cur - new_freq) < HZ_PER_MHZ)
> > +                     return policy->cur;
> > +
> >               cpufreq_out_of_sync(policy, new_freq);
> >               if (update)
> >                       schedule_work(&policy->update);

Applied as 5.19 material, thanks!
