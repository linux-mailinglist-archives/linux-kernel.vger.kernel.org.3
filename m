Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C61152C2A4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbiERSuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiERSu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:50:29 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74892177076;
        Wed, 18 May 2022 11:50:27 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2ec42eae76bso34188157b3.10;
        Wed, 18 May 2022 11:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeOeCVH7gCGznzqm2nGSE0funGSjnIdlMb+nr+xRP/A=;
        b=3+ugiIGKRuORnUBE3aWmDYPmfo2uoKReK9QoB9jYqINY0xOKGYRLD4kaHXsqZbsFBQ
         xikCFVQ81XLmVFHXafYVezePnJ+jFtjhf6pZmoO+aiu8kfVYcZ8Df+B31IoA+upCDVMA
         IUEeaxuBg3/G+VOhZfVb0k0j1aP+w7oSqR63bOjM8ISxVx+ogFxiuuYJrFt3ol6pJWOd
         7p80i5ixfyK0/5EwMPce3rb3lpsboEllF82sfE0Mq0ztsd7ljZd1gTA5LZW338M5enp3
         Y0gV6dhtrsIrigpFM/cbyCMeKD9Dg75kBwYHrUHkWOmcqfpXlqL3AoIupPN2ziz0lpgr
         66OA==
X-Gm-Message-State: AOAM531s/TwKcTwNgkHuJeNSTgKx6vkmKKEeJuMoNNXo5Mpy55xTGz5S
        s7fFmXpfZ20PAXU6l8gIqAOTMb9qhOyuM+5K+YQ=
X-Google-Smtp-Source: ABdhPJxcL5gAMOBXXOO+YGL6Y0P2PkXH2MCCVm1GVtiV2ayBXlf+abelWHS3qgKA5DVkPjc2lFFUvR3mDUeY/B0dZQA=
X-Received: by 2002:a0d:c8c3:0:b0:2fe:e9eb:664 with SMTP id
 k186-20020a0dc8c3000000b002fee9eb0664mr844761ywd.301.1652899826747; Wed, 18
 May 2022 11:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220514152032.758738-1-ulf.hansson@linaro.org> <CAAhSdy3m3FzbkL-On5kPtrZgyO4x=6onr6mXi_=te5B=m_n8GQ@mail.gmail.com>
In-Reply-To: <CAAhSdy3m3FzbkL-On5kPtrZgyO4x=6onr6mXi_=te5B=m_n8GQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 May 2022 20:50:15 +0200
Message-ID: <CAJZ5v0i+RR2nK8gew9tbnO_VVU3YUx2JgdRTBW07EPrB3UK87g@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: psci: Fix regression leading to no genpd governor
To:     Anup Patel <anup@brainfault.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 6:49 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Sat, May 14, 2022 at 8:50 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > While factoring out the PM domain related code from PSCI domain driver into
> > a set of library functions, a regression when initializing the genpds got
> > introduced. More precisely, we fail to assign a genpd governor, so let's
> > fix this.
> >
> > Fixes: 9d976d6721df ("cpuidle: Factor-out power domain related code from PSCI domain driver")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>

Ulf, do you want me to take this lot or is it going to be handled elsewhere?

> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index 755bbdfc5b82..3db4fca1172b 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -52,7 +52,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
> >         struct generic_pm_domain *pd;
> >         struct psci_pd_provider *pd_provider;
> >         struct dev_power_governor *pd_gov;
> > -       int ret = -ENOMEM, state_count = 0;
> > +       int ret = -ENOMEM;
> >
> >         pd = dt_idle_pd_alloc(np, psci_dt_parse_state_node);
> >         if (!pd)
> > @@ -71,7 +71,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
> >                 pd->flags |= GENPD_FLAG_ALWAYS_ON;
> >
> >         /* Use governor for CPU PM domains if it has some states to manage. */
> > -       pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
> > +       pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
> >
> >         ret = pm_genpd_init(pd, pd_gov, false);
> >         if (ret)
> > --
> > 2.25.1
> >
