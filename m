Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834AC487F45
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiAGXPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiAGXPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:15:44 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F4C061574;
        Fri,  7 Jan 2022 15:15:44 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id e25so7480516qkl.12;
        Fri, 07 Jan 2022 15:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5enD2fqmhH53EwmJgdKa8witlqi5OgPh1FBckXBxS+k=;
        b=p1oZxYFuJkbHig5dDL3LfdMi3rODDvGFJLaMXT6UR5MrGJW1VwZjKZfMk1K7zn6Xh+
         OucsrU3CR8S31xS2dXVY3VYATjRMK4yOMs5s7uhf/vxaSB8RIOUy57gkmOYppwCYHOv9
         gKHHi5V9MMtdIrUWFVy/IxrsyQYy6xkI3r5zrOaARjpLew7aIYiEJaK3ZJZuVK0e6mnf
         AJuDaBiyNogaKvWW9fecTOhwiSILyk/hlG0RfQRSIz73uSG/cdn74dyWUNB68sK/jgjf
         YvLPuCn8H/NYSKG1nEYWng5jbjHrl/W9z3oJSIVMD/97lqf3kC5ZgZDSlkrn9lwH7mIv
         0zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5enD2fqmhH53EwmJgdKa8witlqi5OgPh1FBckXBxS+k=;
        b=cRqFIiBNkLvs6uzPU/tFE1yW3pj49tIVnhg4HRA9JTAmfN5m1+6jGg6M3RI1VU3QiD
         ryRMdfunmDsKdZRtddTxnbgfPv6+FpLTlqv2dJhFiJit6q6uGljM1ZcQ9impzypa0GqQ
         jBzYvKT18tmZ8HqVZ6YQeAE0pBrYauRM3FKCjz/2ZaG7AI7qeBTbbbVlefsKjMb1vfg9
         +Cq9x/K53dYqXdV3Gr9qtuqJdKFuMfV3133L9pU28BvWyo48IcJhGyWg2iXZKRlKmXBy
         tBmiJmAT4ZcYnUjX92tF3ObJpiHolcNmOvVMeci0If4wOdOsZAdIJ3MWTmNQyvCCuugO
         2QmQ==
X-Gm-Message-State: AOAM533W8+MtrDIE6EdnXAIgSBA1zYZh7p6pAa2M7aVAgNvFx7GHgQ3K
        sRSLRbs4Z6p8qSX08N0PyYI=
X-Google-Smtp-Source: ABdhPJx8CyDb8YVKFRENAZUoUHe2ebUoEdhY+9r0iT2bB5P13b3r+/ZmP6ijgPyY2K2ElZ1j8OyBJA==
X-Received: by 2002:a05:620a:4551:: with SMTP id u17mr2307840qkp.298.1641597343480;
        Fri, 07 Jan 2022 15:15:43 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id d5sm3548008qte.26.2022.01.07.15.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:15:43 -0800 (PST)
Date:   Fri, 7 Jan 2022 18:15:40 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YdjJnJUDzd9HZq+s@errol.ini.cmu.edu>
References: <20220107170616.2041589-1-gsomlo@gmail.com>
 <20220107170616.2041589-4-gsomlo@gmail.com>
 <YdhzmE8eBsvkRCBn@errol.ini.cmu.edu>
 <CAHp75Ve5T-yNV-BJww_kN+6y8P9FyHodKfZ4nfi2POynp6BPVg@mail.gmail.com>
 <CAHp75VdnvdurRbL+aqTDhmQkHJU-mhNWFKRdVqPCh9mMV2h+6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdnvdurRbL+aqTDhmQkHJU-mhNWFKRdVqPCh9mMV2h+6g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:58:40PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 7, 2022 at 10:50 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Jan 7, 2022 at 7:08 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > > On Fri, Jan 07, 2022 at 12:06:16PM -0500, Gabriel Somlo wrote:
> 
> ...
> 
> > > Any more ordering or devm vs. non-devm mixing violations here? If so,
> > > can you please link me to an example or some docs where I ould figure
> > > out what it is I'm still doing wrong?
> >
> > Device managed resources are attached to the instance of the device
> > object and removed in the order they have been attached to, but with
> > the caveat that they have no clue about non-managed calls in between.
> > Now you may figure out what happens. Ex.:
> >
> > probe()
> >   A
> >   devm_B
> >   C
> >   devm_D
> >
> > remove()
> >   un_C
> >   un_A
> >
> > WRONG!
> 
> For the sake of comprehensivity of the examples the right one(s) depicted below:
> 
> ->probe()
> 
> 1)
>   devm_A
>   devm_B
>   C
>   D
> 
> 2)
>   A
>   B
>   C
>   D
> 
> 3)
>   devm_A
>   devm_B
>   devm_C
>   devm_D
> 
> Hint:
> `git log --no-merges --grep devm_add_action_or_reset`

Thanks again!

As far as I can tell, I *meant* (but failed to) use `devm_request_irq()`,
which would then have justified the absence of `free_irq()` on the
probe() function's error path!

Similarly, I would no longer have to call it during remove() either:

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index d96da0bcba55..38952f169a27 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -486,8 +486,8 @@ static int litex_mmc_irq_init(struct litex_mmc_host *host)
        if (IS_ERR(host->sdirq))
                return PTR_ERR(host->sdirq);
 
-       ret = request_irq(host->irq, litex_mmc_interrupt, 0,
-                         "litex-mmc", host->mmc);
+       ret = devm_request_irq(dev, host->irq, litex_mmc_interrupt, 0,
+                              "litex-mmc", host->mmc);
        if (ret < 0) {
                dev_warn(dev, "IRQ request error %d, using polling\n", ret);
                goto use_polling;
@@ -626,20 +626,16 @@ static int litex_mmc_probe(struct platform_device *pdev)
        return 0;
 
 err:
-       if (host->irq > 0)
-               free_irq(host->irq, mmc);
        mmc_free_host(mmc);
        return ret;
 }
 
 static int litex_mmc_remove(struct platform_device *pdev)
 {
-       struct litex_mmc_host *host = dev_get_drvdata(&pdev->dev);
+       struct litex_mmc_host *host = platform_get_drvdata(pdev);
        struct mmc_host *mmc = host->mmc;
 
        mmc_remove_host(mmc);
-       if (host->irq > 0)
-               free_irq(host->irq, mmc);
        mmc_free_host(mmc);
 
        return 0;


I'll send out v8 shortly, hopeuflly with all ordering and devm-ness
issues fixed.

Thanks,
--Gabriel
