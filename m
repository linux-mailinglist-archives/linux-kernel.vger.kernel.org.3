Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6247F3E3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhLYQoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhLYQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:44:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A92C061401;
        Sat, 25 Dec 2021 08:44:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so44382349edd.8;
        Sat, 25 Dec 2021 08:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0jRj1jdzTuB6XYaS0/5SdS54hmWcBJmIKPZbi3JBY8=;
        b=YvCVonbrJnMuunfe3wQSyZbWvayF0yv9wX/Rijq2ZatfTXjRlivUauB25ASPF9OgR1
         Khf4pA/yfXUEVbTZADw4DAf6iTPswTIlyjDYdbVtl9e7FTD+QvrIJATDCJ/yJ/Ovk1No
         IslHmZTI2mk57WnGrv2KPMZWAvXVs9fLCYDzzZK0/ptqKD5SJzXx0pTJ1sLmvyCbgc0n
         aFVIsubyfVcQW+IEaQytbPrbnxdJBBMO4NVZ45P1++qbBznxqoyYkWxVeBd8H3+u3MHp
         OVDouXmfPmaAFV3lH/5/clc7sv0XUCKTYAhcCO+oHpqZ5Y3YeV8a0vnZ2bjJIo76z9vq
         xsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0jRj1jdzTuB6XYaS0/5SdS54hmWcBJmIKPZbi3JBY8=;
        b=7CNcFpLY0bXY5xOx0Nlxy8L6zFaPEvwnYSHye6EMQiuk0R7nugp63jrTJc5Y/w+1q+
         cQBZzNEGcmv1eXFgBtwLiyrIE4J0ucEwMqQPKXZJTMSi6vbC2nO0PQiv2hVvCreixjzR
         hNcr6jmxta4GM61nwdFUfpbSXS1Rrh1hQ9Y96/00Z+7kzxLuPjI9Lqncz9QBZGaHVLjd
         2toTW+6QBjJbIm66lErIPNO/XzYFbJISQN00zmD+7o3LeiwGvudvR2GTlv1w8rjm6nV1
         5Larq87LB2nJPoCg9aT5FTRNEt8dfNln7bjqkJyT4Gb4CDaNm6kwAI5/1n+kdLYRzCAX
         j62g==
X-Gm-Message-State: AOAM532iGbZhhJKEZBHZ+Z1pRxTCrNvRIs/DVTfNvja4gDQ+9M05p9dc
        PdUcZAxI6OQx25tmp2arV+c3SXknSH5U4l9NU9Y=
X-Google-Smtp-Source: ABdhPJwqcEGaPeapQCWpiQCPL+GhsE3uusCeaHYZBBWY263lPZfqrSNaV2pNoriOWCKD85SELwQ8NXCNaZDfVITiTzg=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr8380110ejj.636.1640450638917;
 Sat, 25 Dec 2021 08:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20211215130711.111186-1-gsomlo@gmail.com> <20211215130711.111186-4-gsomlo@gmail.com>
In-Reply-To: <20211215130711.111186-4-gsomlo@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 18:43:22 +0200
Message-ID: <CAHp75Vf7ktdoBoOHVE72LO19vxZiQ82eBg9_xP2ywB6c4yqXWQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 10:00 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> that targets FPGAs. LiteSDCard is a small footprint, configurable
> SDCard core commonly used in LiteX designs.
>
> The driver was first written in May 2020 and has been maintained
> cooperatively by the LiteX community. Thanks to all contributors!

...

> +       int ret;
> +
> +       host->irq = platform_get_irq_optional(host->dev, 0);
> +       if (host->irq <= 0) {
> +               dev_warn(dev, "Failed to get IRQ, using polling\n");
> +               goto use_polling;
> +       }

Same comment as per v3.

...

> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT

Why under ifdeffery?

> +       /* increase from default 32 on 64-bit-DMA capable architectures */
> +       ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +       if (ret)
> +               goto err;
> +#endif

-- 
With Best Regards,
Andy Shevchenko
