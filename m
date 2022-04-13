Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B394FF9E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiDMPW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbiDMPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:22:46 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7A6E0D2;
        Wed, 13 Apr 2022 08:20:23 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id t67so4391091ybi.2;
        Wed, 13 Apr 2022 08:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2Lgy0xxZ/kq35mN9jTEDe99/KAY+dTqIri9HO0ska8=;
        b=fIsxeVdjGUPOzAQXIwLuR+jgjLcl2Nrnnj8+9Z914QnpKIvCpeQJXeVhkHxZQvUgt2
         egyVB6fU9ORmBo1UtIrq42qHIua3FRY8UUcjwRiZeXqioUPvEL+ILQ1BDj+6LeixDo0+
         yPanUDtk0YFqPQ7CHpTlcMgJO5ffYl2rh+3C/J4pXOtOvWymChyD6O0d/THAvUzjEAoU
         nvwasDRCliYTcobmT19eA8yr4Q3BPxsX/4ooSIFF3U2y0KW3tKcE2CqnqnFRROoPHlZl
         Fzafsto+xPGtymXLqLbxCjxk1KLvCqkqXvwfCzBJfnafwJY+wZG0YYH+gR3yL0CHpUVG
         +2OA==
X-Gm-Message-State: AOAM533NsEvun26aZwsFmt6MzsF4aBVtF9IZx1guPFwdk5QbnGgZ7N5h
        wvyzyUEOmclYrLlvc+BnQPOTuepdNGPSmXY6KFXDSvWw
X-Google-Smtp-Source: ABdhPJwOIpKOGRh6wLe+b2eqyMIagCZXSSwKkMG4Q0iaM3xYCmKqKl32u8IbpWSAjNHIgVdbn8Ltt5Bh6VA0YsVmI+o=
X-Received: by 2002:a25:3cc3:0:b0:63e:6ee9:4840 with SMTP id
 j186-20020a253cc3000000b0063e6ee94840mr22598626yba.153.1649863222281; Wed, 13
 Apr 2022 08:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <4cb0c4573cce165657ad1f7275c4b3852cbcd115.1648833416.git.christophe.leroy@csgroup.eu>
 <20220404062710.m6bzpg5gsx4x7tm5@vireshk-i7>
In-Reply-To: <20220404062710.m6bzpg5gsx4x7tm5@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 17:20:11 +0200
Message-ID: <CAJZ5v0itEsDDWPYPYJkY5xbs1t97uMx3P3pL1Qg_jrA63aXw_Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Prepare cleanup of powerpc's asm/prom.h
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Mon, Apr 4, 2022 at 8:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 01-04-22, 19:24, Christophe Leroy wrote:
> > powerpc's asm/prom.h brings some headers that it doesn't
> > need itself.
> >
> > In order to clean it up, first add missing headers in
> > users of asm/prom.h
> >
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> >  drivers/cpufreq/pasemi-cpufreq.c      | 1 -
> >  drivers/cpufreq/pmac32-cpufreq.c      | 2 +-
> >  drivers/cpufreq/pmac64-cpufreq.c      | 2 +-
> >  drivers/cpufreq/ppc_cbe_cpufreq.c     | 1 -
> >  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 2 +-
> >  5 files changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> > index 815645170c4d..039a66bbe1be 100644
> > --- a/drivers/cpufreq/pasemi-cpufreq.c
> > +++ b/drivers/cpufreq/pasemi-cpufreq.c
> > @@ -18,7 +18,6 @@
> >
> >  #include <asm/hw_irq.h>
> >  #include <asm/io.h>
> > -#include <asm/prom.h>
> >  #include <asm/time.h>
> >  #include <asm/smp.h>
> >
> > diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
> > index 4f20c6a9108d..20f64a8b0a35 100644
> > --- a/drivers/cpufreq/pmac32-cpufreq.c
> > +++ b/drivers/cpufreq/pmac32-cpufreq.c
> > @@ -24,7 +24,7 @@
> >  #include <linux/device.h>
> >  #include <linux/hardirq.h>
> >  #include <linux/of_device.h>
> > -#include <asm/prom.h>
> > +
> >  #include <asm/machdep.h>
> >  #include <asm/irq.h>
> >  #include <asm/pmac_feature.h>
> > diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> > index d7542a106e6b..ba9c31d98bd6 100644
> > --- a/drivers/cpufreq/pmac64-cpufreq.c
> > +++ b/drivers/cpufreq/pmac64-cpufreq.c
> > @@ -22,7 +22,7 @@
> >  #include <linux/completion.h>
> >  #include <linux/mutex.h>
> >  #include <linux/of_device.h>
> > -#include <asm/prom.h>
> > +
> >  #include <asm/machdep.h>
> >  #include <asm/irq.h>
> >  #include <asm/sections.h>
> > diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
> > index c58abb4cca3a..e3313ce63b38 100644
> > --- a/drivers/cpufreq/ppc_cbe_cpufreq.c
> > +++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
> > @@ -12,7 +12,6 @@
> >  #include <linux/of_platform.h>
> >
> >  #include <asm/machdep.h>
> > -#include <asm/prom.h>
> >  #include <asm/cell-regs.h>
> >
> >  #include "ppc_cbe_cpufreq.h"
> > diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> > index 037fe23bc6ed..4fba3637b115 100644
> > --- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> > +++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> > @@ -13,9 +13,9 @@
> >  #include <linux/init.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/pm_qos.h>
> > +#include <linux/slab.h>
> >
> >  #include <asm/processor.h>
> > -#include <asm/prom.h>
> >  #include <asm/pmi.h>
> >  #include <asm/cell-regs.h>
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.19 material.

If the powerpc folks decide to take it, I can drop it, so please let me know.
