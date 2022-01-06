Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92972486D64
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbiAFWu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245167AbiAFWu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:50:28 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC0AC061245;
        Thu,  6 Jan 2022 14:50:28 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id p12so3799847qvj.6;
        Thu, 06 Jan 2022 14:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5HD5jrCjT+x7XnYXC71lELec8Zqrw2up8ZrlifTIXOs=;
        b=KGhi7VVpCzgeAxzdJwi4oxGgs0x8bCiwOYXy40NR0VHyGjKnw0lmrW1xMhpb5w8q/C
         SGDvGqNLOdW9Z4+JJvOKYB7dvkhSJoohqEYw2Izxjyz+2Lee3AEn5JRMCftDAwzcQhA1
         r9EpHQvjcMyHS778+27YI7K4IbxelM0/4YLo2FTehxx/n1ZDc6yi3o+Rpvn/X5Gmoxum
         616LUMYqthfp7ifPIjratj/g2Ip23UTS4b5irvVemorDMGQ0KHy8/0+9wVZfKZeCowH1
         adhJUFOWiSsciaYtBWoOL0RCc9jVCrEOiG7w7rfY9BEJlg+TkPoGVhTg6KxciPOu8xOA
         287w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5HD5jrCjT+x7XnYXC71lELec8Zqrw2up8ZrlifTIXOs=;
        b=MLNcAuALhonLF+h6bvkxJjRlDSJ0C9GLjq0CSUPGSFgRekcy3jnVbrwXjpdS4XbjmW
         I9IIUVlCgdZE2hfRLZsxK9DzIL+FY+UHMbr+IZYGpFrG0qqR20VY0Jzn5AIPSktADg0X
         ZkatlrnOFOj/NmEbw5QINFp5vamH4Ubb/7eI4ikHSOZQf/LgWg2VXxvFWRrvJEraB5dB
         D9f1rIn+nd9glN340TUTWa+7PPgr3eGWFr9gjCiPrS4i0UsfAkcyoa/qfizH50WUxFzX
         Uf3ACuoP0tV7P9agYkePPs+2dgujRW/DmoXJoY1c/kWOxWXqwtL8/Dmm0FijbeitjkYk
         bBsg==
X-Gm-Message-State: AOAM530huo3GDp6noknjg0fIFKzgCZVoS/SnS6XI62t0ymKAymef7UCC
        oumvw/zgeUl3G2WM2b7MuGE=
X-Google-Smtp-Source: ABdhPJwY6nrI4FW495UD+zuKJMZ8cuqnTzBUUc8N1dl8Pb7OXHltDH7QzaYxTjHSR8EV3pqvJZW9UQ==
X-Received: by 2002:a05:6214:258f:: with SMTP id fq15mr55413470qvb.100.1641509427125;
        Thu, 06 Jan 2022 14:50:27 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id e2sm2433705qty.14.2022.01.06.14.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:50:26 -0800 (PST)
Date:   Thu, 6 Jan 2022 17:50:24 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v6 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YddyMI7hJE7u0jQ/@errol.ini.cmu.edu>
References: <20220106174803.1773876-1-gsomlo@gmail.com>
 <20220106174803.1773876-4-gsomlo@gmail.com>
 <CAHp75Ve_jWmo3+Es0G5SyMpcdC_=hWfxHoa866Difd+X3F0uxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve_jWmo3+Es0G5SyMpcdC_=hWfxHoa866Difd+X3F0uxg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks again, replies and follow-up questions inline below:

On Thu, Jan 06, 2022 at 08:19:39PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 6, 2022 at 7:48 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> >
> > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > SDCard core commonly used in LiteX designs.
> >
> > The driver was first written in May 2020 and has been maintained
> > cooperatively by the LiteX community. Thanks to all contributors!
> 
> > +config MMC_LITEX
> > +       tristate "LiteX MMC Host Controller support"
> > +       depends on OF
> > +       depends on PPC_MICROWATT || LITEX || COMPILE_TEST
> > +       help
> > +         This selects support for the MMC Host Controller found in LiteX SoCs.
> > +
> > +         If unsure, say N.
> 
> What would be the module name if built as a module?

litex_mmc.ko -- why are you asking? I.e., should I mention that anywhere
in the Kconfig blurb (I don't see other blurbs doing that, fwiw)?
 
> ...
> 
> > +/*
> > + * LiteX LiteSDCard driver
> > + *
> > + * Copyright (C) 2019-2020 Antmicro <contact@antmicro.com>
> > + * Copyright (C) 2019-2020 Kamil Rakoczy <krakoczy@antmicro.com>
> > + * Copyright (C) 2019-2020 Maciej Dudek <mdudek@internships.antmicro.com>
> > + * Copyright (C) 2020 Paul Mackerras <paulus@ozlabs.org>
> > + * Copyright (C) 2020-2021 Gabriel Somlo <gsomlo@gmail.com>
> 
> > + *
> 
> Redundant blank line.

OK, removed.

> 
> > + */
> 
> ...
> 
> > +#include <linux/module.h>
> > +#include <linux/litex.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/clk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/mmc/sd.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/host.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> 
> Perhaps keep it sorted?

OK, sorted. Now looks like this:

#include <linux/clk.h>
#include <linux/delay.h>
#include <linux/dma-mapping.h>
#include <linux/interrupt.h>
#include <linux/iopoll.h>
#include <linux/litex.h>
#include <linux/module.h>
#include <linux/mmc/host.h>
#include <linux/mmc/mmc.h>
#include <linux/mmc/sd.h>
#include <linux/mmc/slot-gpio.h>
#include <linux/of.h>
#include <linux/platform_device.h>

> It will easily show, for example, absence of bits.h.
 
I'm not getting any errors or warnings re. missing bits.h -- why are
you mentioning it explicitly? (for the record, I try not to explicitly
include anything unless I absolutely have to, so I try to avoid
including headers included via other headers I already *have* to
include explicitly!)

I'm expecting you're going to tell me that's wrong, but then I'm much
less confident of a clean canonical way of determining exactly what
headers must be mentioned explicitly in a driver -- please advise! :)

> 
> > +       ret = readx_poll_timeout(litex_read8, reg, evt, (evt & SD_BIT_DONE),
> 
> Too many parentheses.

OK, removed (from both occurrences of `readx_poll_timeout()`).

> 
> > +                                SD_SLEEP_US, SD_TIMEOUT_US);
> 
> > +       if (ret || (evt & SD_BIT_TIMEOUT))
> 
> Redundant second condition. If you want +1 iteration, increase timeout.

Well, readx_poll_timeout() returns -ETIMEDOUT or 0, depending on whether
or not it read the SD_BIT_DONE bit from the provided register reg.
But even if it did return 0, the hardware might have returned its own
timeout flag (SD_BIT_TIMEOUT) before readx_poll_timeout() decided to
give up on polling the register. So we can time out in one of two
different ways, and we need to check for both.
 
> > +               return -ETIMEDOUT;
> 
> Why shadowed error code?

See above -- if readx_poll_timeout returned 0, we should still return
-ETIMEDOUT in case the hardware set the SD_BIT_TIMEOUT flag. I figured
I'd deal with all timeout scenarios in one place, but we can definitely
split that out to avoid confusion, something like this:

	...
        ret = readx_poll_timeout(litex_read8, reg, evt, evt & SD_BIT_DONE,
                                 SD_SLEEP_US, SD_TIMEOUT_US);
	if (ret)
                return ret;
        if (evt == SD_BIT_DONE)
                return 0;
        if (evt & SD_BIT_WR_ERR)
                return -EIO;
        if (evt & SD_BIT_TIMEOUT)	// <<< HERE
                return -ETIMEDOUT;
        if (evt & SD_BIT_CRC_ERR)
                return -EILSEQ;
	...

> ...
> 
> > +       pr_err("%s: unknown error evt=%x\n", __func__, evt);
> 
> Use dev_err().

OK, done.

> ...
> 
> > +       /* Wait for an interrupt if we have an interrupt and either there is
> > +        * data to be transferred, or if the card can report busy via DAT0.
> > +        */
> 
> This comment style is for the net subsystem, for others we use
> /*
>  * Starting here...
>  */
> 
> Fix it everywhere in your code.

OK, multi-line comment style updated across the entire file.

> ...
> 
> > +               reg = host->sdcore + LITEX_CORE_CMDRSP;
> > +               for (i = 0; i < 4; i++) {
> > +                       host->resp[i] = litex_read32(reg);
> > +                       reg += sizeof(u32);
> > +               }
> 
> Isn't it memcpy_fromio()?

Yes, that appears to be the case. Looking at `litex_read32()`
(in include/linux/litex.h), it's defined as

	le32_to_cpu((__le32 __force)readl(addr))

which counts as a "__raw_readl()", i.e., without the byteswap occurring
on BE architectures. It looks like memcpy_fromio() doesn't play byteswap
games on BE either, so they should be equivalent. With the caveat that
I only have the ability to test on LE!

For now, based on the above observations, I think it's safe to use
memcpy_fromio() here.

> ...
> 
> > +       if (!host->app_cmd && cmd == SD_SEND_RELATIVE_ADDR)
> > +               host->rca = (host->resp[3] >> 16) & 0xffff;
> 
> Are you expecting a 32-bit value to be bigger than 2^32-1?

Fair enough :)

> ...
> 
> > +       div = min(max(div, 2U), 256U);
> 
> clamp_t() / clamp_val() ?

OK, changed to `div = clamp_val(div, 2U, 256U);`

> ...
> 
> > +       ret = platform_get_irq_optional(host->dev, 0);
> > +       if (ret == -ENXIO || ret == 0) {
> > +               dev_warn(dev, "Failed to get IRQ, using polling\n");
> > +               goto use_polling;
> > +       }
> > +       if (ret < 0)
> > +               return ret; /* e.g., deferred probe */
> > +       host->irq = ret;
> 
> Can it be rather written as
> 
>        ret = platform_get_irq_optional(host->dev, 0);
>        if (ret < 0 && ret != -ENXIO)
>          return ret;
>        if (ret > 0)
>          host->irq = ret;
>        else {
>                dev_warn(dev, "Failed to get IRQ, using polling\n");
>                goto use_polling;
>        }
> 
> ?

OK, done.

> ...
> 
> > +use_polling:
> > +       host->mmc->caps |= MMC_CAP_NEEDS_POLL;
> 
> > +       host->irq = 0;
> 
> Isn't it 0 by default?

Yes, because of kzalloc() by way of mmc_alloc_host(). So I don't have to
set it to 0 explicitly -- Done.

> ...
> 
> > +       mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), &pdev->dev);
> 
> > +       /* NOTE: defaults to max_[req,seg]_size=PAGE_SIZE, max_blk_size=512,
> > +        * and max_blk_count accordingly set to 8;
> > +        * If for some reason we need to modify max_blk_count, we must also
> > +        * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;`
> > +        */
> 
> Can you rather not split code by this comment. It makes sense to be above, no?

OK -- Done.

> > +       if (!mmc)
> > +               return -ENOMEM;
> 
> ...
> 
> > +       /* set default sd_clk frequency range based on empirical observations
> > +        * of LiteSDCard gateware behavior on typical SDCard media
> > +        */
> 
> Start sentences from capital letters and keep proper style of
> multi-line comments.

Multi-line comment style fixed per your earlier observation.

I also went and capitalized the first letter of each comment throughout
the source.

> ...
> 
> > +err:
> > +       mmc_free_host(mmc);
> > +       return ret;
> 
> This...
> 
> > +}
> > +
> > +static int litex_mmc_remove(struct platform_device *pdev)
> > +{
> > +       struct litex_mmc_host *host = dev_get_drvdata(&pdev->dev);
> > +
> > +       if (host->irq > 0)
> > +               free_irq(host->irq, host->mmc);
> > +       mmc_remove_host(host->mmc);
> > +       mmc_free_host(host->mmc);
> 
> ...and this have ordering issues. You mixed devm_*() with non-devm_*()
> APIs in the wrong way.
> 
> Also, I haven't noticed the free_irq() call in the error path of
> ->probe(). Isn't it missed?

OK, I've reordered everything (and added the missing free_irq() call
like so:

	static int litex_mmc_probe(struct platform_device *pdev)
	{
		...
		...
		return 0;

	err:
	        if (host->irq > 0)
	                free_irq(host->irq, host->mmc);
	        mmc_free_host(mmc);
	        return ret;
	}

	static int litex_mmc_remove(struct platform_device *pdev)
	{
	        struct litex_mmc_host *host = dev_get_drvdata(&pdev->dev);

	        mmc_remove_host(host->mmc);
	        if (host->irq > 0)
	                free_irq(host->irq, host->mmc);
	        mmc_free_host(host->mmc);

	        return 0;
	}

Looking at other examples in drivers/mmc/host/* I'm not sure if/what
other ordering issues or devm/non-devm mixing violations I'm
perpetrating: if there are any left, could you please point them out
in a bit more detail?
 
> > +       return 0;
> > +}
> 
> ...
> 
> > +               .of_match_table = of_match_ptr(litex_match),
> 
> Wrong usage of of_match_ptr().

Huh? It's consistent with how a whole bunch of other files in
drivers/mmc/host/*.c are using it, can you please elaborate?

Thanks much for taking the time to review the driver, much appreciated!
I'll send out a v7 as soon as I get some clarity on the portions above
that I'm still confused about... :)

Thanks again,
--Gabriel
