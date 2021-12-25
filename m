Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4759E47F338
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 13:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhLYMRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 07:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhLYMRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 07:17:43 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C8C061401;
        Sat, 25 Dec 2021 04:17:43 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id y130so5570559ybe.8;
        Sat, 25 Dec 2021 04:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THzJ/r5xUdHVrqzWqmn8Q/Eb3Hnh+qCbeidzUFLU18g=;
        b=TQXmHokzCISzJsguxMWkrt/fsOhRzo5X2T6Q9B7lsGMzLKMUzr6cQlCTzTlUrAMjOu
         aUWz7nVPT6uhE6+n55E1XVVPOIKj3hGudR0wWl8s70ggP5QvI0k/Sk3zM4ddO+EL2d3M
         Dd3jo6gak37AggX+lOB4/C/VqJCoiqYriI83KfIgI6CT/FAQvsolzmWUqA2wPoeu9Tu6
         zdMNE5/cCZHMYYu7KZgAfSPwy6UmhCqgxHreG5BIl/vEerOhrbDYi8PEOW6g3vsdU9kT
         VmFSuQaTkuC8l/WJOQhb/E6GX28F9iRgoCh1hUhWs18OKSJwP+mG1fC3dw/jW3I84Ap5
         gbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THzJ/r5xUdHVrqzWqmn8Q/Eb3Hnh+qCbeidzUFLU18g=;
        b=XH2HVO7s21BLfJH6RnDSzk0RmuSxxoYCzp9CyFOmYPpwPliE72VIE1fPXbbRmzbCoJ
         uVPKIg/bKx8QaJd2CWICzpbyPZdJ7RstMkRwY4dENanJa8SnMc8ZglrK8DF5qEmqZmBX
         yWmLUzhYWthHPSj3NoNzEfN3smEz/v6nMNfZiXP4gQVcgK9j2Id2RSnMCFkqIG67xTA4
         1B9kQOUa54y4XunG8e0qVL0MGkWEMzp5dr5Urt7smTGNru6zJRD77otakucBNPMTS184
         SiRmi7oqWLEO3kKPJ8tOodAsWk+JmER2SLJsK/2gp1S6KoDz0Kl2bmPojfK/qgJU8SVC
         6SUA==
X-Gm-Message-State: AOAM530CYLLcq6h/AEJBCbzkecqSRBPfPn7wAX5MoAHwL3RaLPX6L1E0
        7UMoFAgaXAoQUTYi3lE/ECcg/pMWgMt9H+UQTHyYUAFqZRRiyQ==
X-Google-Smtp-Source: ABdhPJyCmLEoKYcIP5HB/Td6LKfr0d3201dtjNX8ACCAk8U1FFXkmFwQR5/77w1is08YSUiOacK9LX9/zkO6YRcBbhI=
X-Received: by 2002:a25:98c4:: with SMTP id m4mr12904095ybo.613.1640434662143;
 Sat, 25 Dec 2021 04:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20211224194649.22328-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75Vd+84qyTzPc=Tkhz2cxkVv9Y+ME64XO6btXq=RmtWUxZw@mail.gmail.com>
In-Reply-To: <CAHp75Vd+84qyTzPc=Tkhz2cxkVv9Y+ME64XO6btXq=RmtWUxZw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Dec 2021 12:17:16 +0000
Message-ID: <CA+V-a8vC9=sXr+HqMCt808yuNcjobQPJw45JimdQg8qc0G1uPA@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: rcar_thermal: Use platform_get_irq_optional()
 to get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for the review.

On Sat, Dec 25, 2021 at 11:41 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Friday, December 24, 2021, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>>
>> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
>> allocation of IRQ resources in DT core code, this causes an issue
>> when using hierarchical interrupt domains using "interrupts" property
>> in the node as this bypasses the hierarchical setup and messes up the
>> irq chaining.
>>
>> In preparation for removal of static setup of IRQ resource from DT core
>> code use platform_get_irq_optional().
>>
>> This patch break's the for loop if there are no more interrupts instead
>> of continuing as done in previous code.
>>
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> ---
>> v1->v2
>> * Simplified checking error code
>> * Break loop earlier if no interrupts are seen
>> ---
>>  drivers/thermal/rcar_thermal.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
>> index b49f04daaf47..ff9c55999ddf 100644
>> --- a/drivers/thermal/rcar_thermal.c
>> +++ b/drivers/thermal/rcar_thermal.c
>> @@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>>         struct rcar_thermal_common *common;
>>         struct rcar_thermal_priv *priv;
>>         struct device *dev = &pdev->dev;
>> -       struct resource *res, *irq;
>> +       struct resource *res;
>>         const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
>>         int mres = 0;
>>         int i;
>> @@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>>         pm_runtime_get_sync(dev);
>>
>>         for (i = 0; i < chip->nirqs; i++) {
>> -               irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
>> -               if (!irq)
>> -                       continue;
>> +               int irq;
>> +
>> +               irq = platform_get_irq_optional(pdev, i);
>> +               if (irq == -ENXIO)
>> +                       break;
>> +               if (irq < 0) {
>> +                       ret = irq;
>> +                       goto error_unregister;
>> +               }
>
>
> In all your patches which introduce optional IRQ please change the logic to the opposite:
>
>   if (irq > 0)
>     ...we got one...
>   if (irq == -EPROBE_DEFER)
>     ...return it, if it is ever possible...
>
> With this you adding me a work.
>
The maintainer has requested me to do so [0].

[0] https://patchwork.kernel.org/project/linux-pm/patch/20211218144136.6663-1-prabhakar.mahadev-lad.rj@bp.renesas.com/#24669399

Cheers,
Prabhakar
>
>>
>> +
>>                 if (!common->base) {
>>                         /*
>>                          * platform has IRQ support.
>> @@ -487,7 +494,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>>                         idle = 0; /* polling delay is not needed */
>>                 }
>>
>> -               ret = devm_request_irq(dev, irq->start, rcar_thermal_irq,
>> +               ret = devm_request_irq(dev, irq, rcar_thermal_irq,
>>                                        IRQF_SHARED, dev_name(dev), common);
>>                 if (ret) {
>>                         dev_err(dev, "irq request failed\n ");
>> --
>> 2.17.1
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
