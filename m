Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498D2488515
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiAHRn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiAHRn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:43:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8387EC06173F;
        Sat,  8 Jan 2022 09:43:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o6so35413316edc.4;
        Sat, 08 Jan 2022 09:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZcQfWwMsghwScclCB7tIK4EIlld/CkiQ2JNewUzLag8=;
        b=gOtyYhkaoeyXc9CsYntBmNljOHCUv3yTbUIUH4wiKPN/IdBT3QQQnTZjP7PUw7yKpx
         dyCOtotGEt6oFMpFZK//zYND0lXQEgTkxiaNoVXXfhbZ/WsNkVVs1622VsQOkpw855Xf
         4RuTfpsGXzzBsKshOT1WhYGWGwOvdzbQh+Ej4qsFxczbZ2MKKGRwDV+beCIv2K3f5guH
         mRCcv0eTJA+CjZhJ7npUyBRDzipOsZ5whZsrtYOMUapb+Bmgnftn63CWNwYwarUXP3p+
         ZIimfSgge/LVoNEFLz3TBtvwPMCQxnmAZjBuHxoamdf1jOArVXT1VIKmmS2gRurtY9WJ
         EVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcQfWwMsghwScclCB7tIK4EIlld/CkiQ2JNewUzLag8=;
        b=fAduNIOVSBi4QcB9pQ25Y89o8Ne/iA86NP9HU07/MgTYjcMoExX/g4fXETUTjmVxD0
         jwhT1iaF05N3CwlcisA+QXhtQ3cmA8lDRi4dKrAIX3pxvYbrbwwjmC69QVGOuRyus9JQ
         W0iKQqdXCGhn6ZK8fl6VMqYfngt+PZF2UfvKSImB6Akmhr3dTZw99KBDXiRQQEW5HyqP
         RuTCue4/3B8UheYPOGxoWuuyywt453FYOoUcmT8YQgSNnnhOmhYSDjakYSeaVsCSKlYQ
         zPMp3djdGuvW6SvM3T/4HqIIHKPaCOE1MdWpQbFHfW5c0p0t/2en6Rn74UppHhUfVGQT
         cvKw==
X-Gm-Message-State: AOAM5321ZAH1ufXeSakPjyALnFdB8N/22/vSqt78CmxtQ6/O+QXhJvX9
        QqXJ+b5U7HxxCM83PgEIBJ1V0htVjCQrqwqc+xMWZ6bWrOMtPMq7
X-Google-Smtp-Source: ABdhPJx5rPtY1jXDZ0YljyluPabYaOm0Bv7it0vmPSxlQWPLBS/JUQzpNEfzaQWMFyuIDNiJmPCNCAIK/G6Cs+SYwfk=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr65442760edx.218.1641663836100;
 Sat, 08 Jan 2022 09:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20220108161134.2419279-1-gsomlo@gmail.com> <20220108161134.2419279-4-gsomlo@gmail.com>
In-Reply-To: <20220108161134.2419279-4-gsomlo@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Jan 2022 19:43:19 +0200
Message-ID: <CAHp75VeEvT-_47gKFAYdz-BR9y=KLEw2uMbRxYKo1rLQSQEfyg@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 6:11 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> that targets FPGAs. LiteSDCard is a small footprint, configurable
> SDCard core commonly used in LiteX designs.
>
> The driver was first written in May 2020 and has been maintained
> cooperatively by the LiteX community. Thanks to all contributors!

Thanks for an update, my comments below.

...

> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/litex.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>

> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>

I would move this group of headers...

> +#include <linux/platform_device.h>
> +

...somewhere here to show that this driver belongs to the MMC subsystem.

...

> +#define LITEX_MMC_OCR (MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 | \
> +                      MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 | \
> +                      MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36)

Seems to me this is identical to
https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/au1xmmc.c#L72

And may be reused in
https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/vub300.c#L2168.

Perhaps it makes sense to have

#define MMC_VDD_27_36 ...

in mmc.h?

In any case, it can be postponed, just a side note for the future improvements.

...

> +       /* Ensure bus width will be set (again) upon card (re)insertion */
> +       if (ret == 0)
> +               host->is_bus_width_set = false;
> +
> +       return ret;

Please, switch to standard pattern, i.e.

  if (ret)
    return ret;
  ...
  return 0;

...

> +       u32 div;
> +
> +       div = freq ? host->ref_clk / freq : 256U;

> +       div = roundup_pow_of_two(div);
> +       div = clamp(div, 2U, 256U);

Not sure why it becomes two lines again.

...

> +       ret = devm_add_action_or_reset(dev,
> +                                      (void(*)(void *))mmc_free_host, mmc);

One line?
An actually preferable way is to define a separate wrapper function
and use it here without any casting.

> +       if (ret) {

> +               dev_err(dev, "Failed to register mmc_free_host action\n");
> +               return ret;

return dev_err_probe(...);

> +       }

...

> +       clk = devm_clk_get(dev, NULL);
> +       if (IS_ERR(clk)) {

> +               ret = dev_err_probe(dev, PTR_ERR(clk), "can't get clock\n");
> +               return ret;

    return dev_err_probe(...);

> +       }

...

> +       ret = mmc_add_host(mmc);
> +
> +       return ret;

It's now

    return mmc_add_host(...);

> +}

-- 
With Best Regards,
Andy Shevchenko
