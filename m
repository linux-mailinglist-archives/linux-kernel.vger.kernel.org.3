Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928414869A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbiAFSUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbiAFSUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:20:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1C9C061245;
        Thu,  6 Jan 2022 10:20:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u25so12807308edf.1;
        Thu, 06 Jan 2022 10:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGef8Iic5mds3qfFclDmLiPy9AA+HpUFywGh5Pl0aL8=;
        b=qVing2t2LMVUpjVzUiTLgC3uw+yYdc3FWIsHTfG+tVEIAhRxnTXbR3troRhME2VO81
         H3udCejkhMQ9rlOSE82idRs+8MjETTSkuV/6gSl9FXLCILLO0s+/STuIm6FkqF1zuhWy
         Z+3w3ZoMwWKqxtSpWHjg9yV8jxUXbpWcCcjQlOwo6xDrSru6pUJA0vSssBpQ8QWBovKc
         Dx1KWJjI4F2QWxHO82wbiW5w5Puqf0XCSCYLgTMhso/i5kO24oZETgV+gkMVPriZW0ov
         tUY3A6exZziohWYAH8HyDway5zIOC2kt/5qrkIVslxqvWmGmGtL/uJdnIF4z0edsj4Hj
         fsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGef8Iic5mds3qfFclDmLiPy9AA+HpUFywGh5Pl0aL8=;
        b=STT+YIcK29lJhpeFN5z4Pkwzv/P7mwHl4a9Q4TAQcDqcvUsyPrCfWahfUKtjrrS92u
         Dgtnkek0FQop8UUmlTJ6KtDmn+MsQr8vPuqdJgWaTn2vt7OXHlpIZY63pTpvnpj+ZP9l
         ApzOhD1luWSxgDBuhjF36mwkvBujqbFz7rh1ZRGZppp6/Bo4WI1ET/OXvQSRZQe8uB7S
         rnmusJEMk4py5Rwvnq7OjSoyq4G6y6BJzg+LRHTwBvw/WkudItTErutS5RiBP+H6g2wo
         NFKBXWEvm+VyNeFLHku+w82+hPavFZvktFaxDFkGQpZnmrxEFt1MPvSMwohJzJOQAbt7
         NiRQ==
X-Gm-Message-State: AOAM531W/G2MJUbCKpGVwPRd55sjJqIuwa2Wu5CFeDsAwTZP/tW+ec1O
        gfrESIb+OIs4idLOizRIXBnsxvKOg+C2KGOGdeo=
X-Google-Smtp-Source: ABdhPJwvFPlF47cspLoKBSLFdSJQDE0uFLqstbjcjJUgwuNLFfM5hdQrBxBDWpSHhqc5ctiCOiN25kHA1AEWgJXHpfU=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr57412885edc.125.1641493215125;
 Thu, 06 Jan 2022 10:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20220106174803.1773876-1-gsomlo@gmail.com> <20220106174803.1773876-4-gsomlo@gmail.com>
In-Reply-To: <20220106174803.1773876-4-gsomlo@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 20:19:39 +0200
Message-ID: <CAHp75Ve_jWmo3+Es0G5SyMpcdC_=hWfxHoa866Difd+X3F0uxg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mmc: Add driver for LiteX's LiteSDCard interface
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

On Thu, Jan 6, 2022 at 7:48 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> that targets FPGAs. LiteSDCard is a small footprint, configurable
> SDCard core commonly used in LiteX designs.
>
> The driver was first written in May 2020 and has been maintained
> cooperatively by the LiteX community. Thanks to all contributors!

> +config MMC_LITEX
> +       tristate "LiteX MMC Host Controller support"
> +       depends on OF
> +       depends on PPC_MICROWATT || LITEX || COMPILE_TEST
> +       help
> +         This selects support for the MMC Host Controller found in LiteX SoCs.
> +
> +         If unsure, say N.

What would be the module name if built as a module?

...

> +/*
> + * LiteX LiteSDCard driver
> + *
> + * Copyright (C) 2019-2020 Antmicro <contact@antmicro.com>
> + * Copyright (C) 2019-2020 Kamil Rakoczy <krakoczy@antmicro.com>
> + * Copyright (C) 2019-2020 Maciej Dudek <mdudek@internships.antmicro.com>
> + * Copyright (C) 2020 Paul Mackerras <paulus@ozlabs.org>
> + * Copyright (C) 2020-2021 Gabriel Somlo <gsomlo@gmail.com>

> + *

Redundant blank line.

> + */

...

> +#include <linux/module.h>
> +#include <linux/litex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/host.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>

Perhaps keep it sorted?
It will easily show, for example, absence of bits.h.

...

> +       ret = readx_poll_timeout(litex_read8, reg, evt, (evt & SD_BIT_DONE),

Too many parentheses.

> +                                SD_SLEEP_US, SD_TIMEOUT_US);

> +       if (ret || (evt & SD_BIT_TIMEOUT))

Redundant second condition. If you want +1 iteration, increase timeout.

> +               return -ETIMEDOUT;

Why shadowed error code?

...

> +       pr_err("%s: unknown error evt=%x\n", __func__, evt);

Use dev_err().

...

> +       /* Wait for an interrupt if we have an interrupt and either there is
> +        * data to be transferred, or if the card can report busy via DAT0.
> +        */

This comment style is for the net subsystem, for others we use
/*
 * Starting here...
 */

Fix it everywhere in your code.

...

> +               reg = host->sdcore + LITEX_CORE_CMDRSP;
> +               for (i = 0; i < 4; i++) {
> +                       host->resp[i] = litex_read32(reg);
> +                       reg += sizeof(u32);
> +               }

Isn't it memcpy_fromio()?

...

> +       if (!host->app_cmd && cmd == SD_SEND_RELATIVE_ADDR)
> +               host->rca = (host->resp[3] >> 16) & 0xffff;

Are you expecting a 32-bit value to be bigger than 2^32-1?

...

> +       div = min(max(div, 2U), 256U);

clamp_t() / clamp_val() ?

...

> +       ret = platform_get_irq_optional(host->dev, 0);
> +       if (ret == -ENXIO || ret == 0) {
> +               dev_warn(dev, "Failed to get IRQ, using polling\n");
> +               goto use_polling;
> +       }
> +       if (ret < 0)
> +               return ret; /* e.g., deferred probe */
> +       host->irq = ret;

Can it be rather written as

       ret = platform_get_irq_optional(host->dev, 0);
       if (ret < 0 && ret != -ENXIO)
         return ret;
       if (ret > 0)
         host->irq = ret;
       else {
               dev_warn(dev, "Failed to get IRQ, using polling\n");
               goto use_polling;
       }

?

...

> +use_polling:
> +       host->mmc->caps |= MMC_CAP_NEEDS_POLL;

> +       host->irq = 0;

Isn't it 0 by default?

...

> +       mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), &pdev->dev);

> +       /* NOTE: defaults to max_[req,seg]_size=PAGE_SIZE, max_blk_size=512,
> +        * and max_blk_count accordingly set to 8;
> +        * If for some reason we need to modify max_blk_count, we must also
> +        * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;`
> +        */

Can you rather not split code by this comment. It makes sense to be above, no?

> +       if (!mmc)
> +               return -ENOMEM;

...

> +       /* set default sd_clk frequency range based on empirical observations
> +        * of LiteSDCard gateware behavior on typical SDCard media
> +        */

Start sentences from capital letters and keep proper style of
multi-line comments.

...

> +err:
> +       mmc_free_host(mmc);
> +       return ret;

This...

> +}
> +
> +static int litex_mmc_remove(struct platform_device *pdev)
> +{
> +       struct litex_mmc_host *host = dev_get_drvdata(&pdev->dev);
> +
> +       if (host->irq > 0)
> +               free_irq(host->irq, host->mmc);
> +       mmc_remove_host(host->mmc);
> +       mmc_free_host(host->mmc);

...and this have ordering issues. You mixed devm_*() with non-devm_*()
APIs in the wrong way.

Also, I haven't noticed the free_irq() call in the error path of
->probe(). Isn't it missed?

> +       return 0;
> +}

...

> +               .of_match_table = of_match_ptr(litex_match),

Wrong usage of of_match_ptr().

-- 
With Best Regards,
Andy Shevchenko
