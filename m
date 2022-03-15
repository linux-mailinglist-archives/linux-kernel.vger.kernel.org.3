Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD64D9B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348211AbiCOMYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348201AbiCOMYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:24:38 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D563D8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:23:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h11so26217417ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GoskkRaS3xKbqK2gaYIRk1KTtxNlFqgeuXFN+AZZnLY=;
        b=Q37V0853LSlk5ZhEq0VoQgmGV9DHPIeQ+ZEwwGw4B/yZytSozSz7Jj22JHt8/f5l/v
         80Ja0WVYDd3/ojuQXVwZu1FBWVl0DBDuzuyjIfzbrY8j3L5nIUrNvMAu59C3JdIkDSgC
         +7fyHRV+lyzsFAZrr2ZRRNaoxeTTc3N6kesSzMV8sr7c/WBjDIn+Gx/5jFhxjl+jb13C
         uL+qlcJIYklvdXK9XZOG4vhnLB+qLHaA0C7qwIzxBT9LnqAQ9EmTqd5ncgkURRP8ISGD
         2iQXeKrVyxy+lifc5n6aCv+UcvTmoOEXm8KM/imo2FptfV9ySDMdkrzAmlK2iRg0Xoep
         aVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GoskkRaS3xKbqK2gaYIRk1KTtxNlFqgeuXFN+AZZnLY=;
        b=ZzZeo91v+z73KE8aPXp2JqfLKj4pph0cGjxOjBhgVdPJEALNhdhiZrs2nVJdZL2Idn
         D3ey7pklgK4psVyKolfJaftuefaBp+ZffH2IG4DsGDmUeB3Lsvb4SItmRu+Y1XtIBZjn
         BPM2SsRP+8oBMXvtOILxZgZvagVbbHmU/NpQ9wjsYsNIRIuCIvksAxPfGwgLtSy2yW2l
         GBJ5myWs+5eSKw8N8wlWI/3RSGP9SAmv5pqV44DypYrb/beRFYsahcLkZEBz12Bb2cy2
         wksr0I57ym3ob0tUjnSOoDWHAxqDNGnppFCPPnmmyZk2d2bsUHS/EIjeKrgMpkNGXJwD
         clPA==
X-Gm-Message-State: AOAM5323xQyydQH4tzJ1lvpzlhlECRvE1JnaVb+yYprM9W0l2nAZuZtk
        c56R8080fcs+wiDw9aWSrr3mV6e8IcZJQ4CEXfrRqzjp+VI=
X-Google-Smtp-Source: ABdhPJyw6ZJVayVjzWxqOjk9MssbxAdG+fFQBGuSUslZ2HTumnLArfhj8jb0uGkUUduJOpNoBRtgFn7mGSzSpqfF5oE=
X-Received: by 2002:a2e:9cc5:0:b0:239:da6e:290d with SMTP id
 g5-20020a2e9cc5000000b00239da6e290dmr17257479ljj.4.1647347004620; Tue, 15 Mar
 2022 05:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220307090009.1386876-1-benchuanggli@gmail.com>
In-Reply-To: <20220307090009.1386876-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 13:22:48 +0100
Message-ID: <CAPDyKFpYSTsA5wtTA83QvAaK+Teyshz_PssddE2DJyuM-MLHMA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        hl.liu@genesyslogic.com.tw,
        Kevin Chang <kevin.chang@lcfuturecenter.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 at 10:00, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Add runtime PM for GL9763E and disable PLL in runtime suspend. So power
> gated of upstream port can be enabled. GL9763E has an auxiliary power
> so it keep states in runtime suspend. In runtime resume, PLL is enabled
> and waits for it to stabilize.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> * modify commit messages
> * Use read_poll_timeout() instead of while loop
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 47 ++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 97035d77c18c..c854c8db32e4 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -13,6 +13,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
> +#include <linux/iopoll.h>
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
>  #include "cqhci.h"
> @@ -873,6 +874,47 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>
> +#ifdef CONFIG_PM
> +static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       struct sdhci_host *host = slot->host;
> +       u16 clock;
> +
> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +}
> +
> +static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       struct sdhci_host *host = slot->host;
> +       u16 clock;
> +
> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +       clock |= SDHCI_CLOCK_PLL_EN;
> +       clock &= ~SDHCI_CLOCK_INT_STABLE;
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       /* Wait max 150 ms */
> +       if (read_poll_timeout(sdhci_readw, clock, (clock & SDHCI_CLOCK_INT_STABLE),
> +                             1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
> +               pr_err("%s: PLL clock never stabilised.\n",
> +                      mmc_hostname(host->mmc));
> +               sdhci_dumpregs(host);
> +       }
> +
> +       clock |= SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +}
> +#endif
> +
>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  {
>         struct pci_dev *pdev = slot->chip->pdev;
> @@ -982,6 +1024,11 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>  #ifdef CONFIG_PM_SLEEP
>         .resume         = sdhci_cqhci_gli_resume,
>         .suspend        = sdhci_cqhci_gli_suspend,
> +#endif
> +#ifdef CONFIG_PM
> +       .runtime_suspend = gl9763e_runtime_suspend,
> +       .runtime_resume  = gl9763e_runtime_resume,
> +       .allow_runtime_pm = true,
>  #endif
>         .add_host       = gl9763e_add_host,
>  };
> --
> 2.35.1
>
