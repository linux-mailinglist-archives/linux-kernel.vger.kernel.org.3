Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34F747F420
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhLYRkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:40:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F06C061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 09:40:33 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so44731737edd.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 09:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9bXsUsdOmkN2j/Yll9QiHcS6DeDyMc7r7Kj1H7frv4=;
        b=eBRUIlw985mdXBb0ZXlBrZ0J4cX4OzbtuGg5y0cSr5H2t5BD+2YqdgdrLQh1exaZ53
         itQ3LNxK3GWncjbanlkeS/ej4tOY3qtJlHNZiakHUTu0R5h642Qjw4h/182gpa6DREWa
         rwcBwyEGMCvTi2b3+UGpkCp0Q12vvJGzY6OH1Lz7MeWPmPhA3Cy+aQNNY2+pahRGYlPt
         EZ2c5oesEPgjsjlahUTEhLeZ/y0CgAF99Opc+q1bZlNAZYHRhgtMkj1awQ1Nm39Y08QD
         uicCpzixx+di0tD6pm0s4gQyay1w8yag1S+KRYOPai4pjVLr0dqr2htymw7ib2KDM6+l
         iVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9bXsUsdOmkN2j/Yll9QiHcS6DeDyMc7r7Kj1H7frv4=;
        b=WqXWMI64F0N+6hM9/3LyL3pmmRcShQgeMHTxrvyW6nzmd2/k/xQhHAXX45MfSfRQuo
         G6grliohZyPPhw7H3UZAc/Z6a1txWVeMrqHvaSW0+X2AZ508aykCttBS4qyR4hijFfbi
         OvxwasepLtZ6NOTZZXPasPziGwwEkq2zkSLRL864hzgTWvegnzK0Se4Di/GgF3LUpmVd
         kucQOxd/RhF8SsuyFgN6pNsInq5HoMkdjlx4Ljjat+0LTKYZB+WTVirM3+MrVjjhjbP/
         l7KJu0ZJryuLEaP6UF88vRSjHOVB5TaErVGTX0/dPjdzP+6ayf7DjdttkKyri/2crjy6
         yE7w==
X-Gm-Message-State: AOAM530ocK+jDC/OyY47yQVFRSW3zNW4TssYHlp3p9z7LfvSEq099hF0
        SeVVosSklw1eidFemr1WSh2caOxskhCLEH9teVs=
X-Google-Smtp-Source: ABdhPJymVyN3Hgu2lVSfDDJad687aQzBGLB3dzg+dliiAowerTMzBQJGn0SViqV2WSkHt4NVJimv/LQOUuAG0iD2O5g=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr9927399edx.218.1640454032520;
 Sat, 25 Dec 2021 09:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com> <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
In-Reply-To: <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 19:39:56 +0200
Message-ID: <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to
 get the interrupt
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 7:28 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Sat, Dec 25, 2021 at 4:46 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Dec 16, 2021 at 9:52 AM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> > ret = platform_get_irq_optional(...);
> > if (ret < 0 && ret != -ENXIO)
> >   return ret;
> > if (ret > 0)
> >   ...we got it...
> >
> > It will allow the future API fix of platform_get_irq_optional() to be
> > really optional.
> >
> Later patch [0] (merged into -next) does check for -ENXIO first.
>
> [0] https://lore.kernel.org/lkml/20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com/t/

The problem is that it doesn't consider 0 as no IRQ.

-- 
With Best Regards,
Andy Shevchenko
