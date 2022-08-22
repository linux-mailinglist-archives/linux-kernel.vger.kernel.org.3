Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A247B59BDEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiHVKyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiHVKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:54:02 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE410FC1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 03:54:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q18so9193149ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qUJzeAA0zGAS1ziTyPpIwPEe4uv+VPYIR9XMGD7ii3Q=;
        b=zS3GUMwVqjObBA9yF5EBFw5i8T4tvqI0WJm3QKWgwuNQskUJA1nQZRNYN7mXVH6eKp
         BXXJgVnO7b3OxwwmzlUoxkxxprQiYtoLk+sWv1BU/B50dwHNuZ2UkXWKcivTJWATWOuf
         tPcFq7G74B3Y4yLQOgu4O0FTV8b1WUkxEcIGfN5AXBz8owhYy8BM6cFA9RBJVhjVtm05
         BKNxqx0ASZVpEObqTtBm1GsfLmd83YyXYpGusTPRs1Ace2isVx1jfkzK4fVOGr3hdE1A
         w91cHt3yl/roRhk6IgHsrNwexe+NYBOOBqb6dZfsW2dUZeq0iFyaMLQ7OdYnEUfEQD8Z
         n5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qUJzeAA0zGAS1ziTyPpIwPEe4uv+VPYIR9XMGD7ii3Q=;
        b=7zYCS3A6rWJULhfSni8V3y/KrbElISYuX8YQxJ9GPyg9sJjDaUT15l9z/7bURy/Zfz
         FyOGx0wEjiT2dZ0+XWrmhmBCLUSpvM1UahQln8dJe8M05MbjzGIYzjyZY7ddgybc205Z
         O0yzEUozCkHh1gJbY5iam2pR2zNS/Ql7hw96GnwiqoBoOqTqM5OBn4RctQtOHTV7kQ2q
         Lta8sdRf/GrM2n3MqTM0DAWBnuCI/qq0HmWlQw2zHRqO10ImSApqNvA6cSMj1rFZnqR2
         jnLeNkYsu7Nsew3D09T19SIuYyMCFSzAtlIXpHJNWLpCoibMu/JVGRu3l3+ovqzeJ2yf
         V7FA==
X-Gm-Message-State: ACgBeo3iQE+hols0XwVxrGjOMqrtDiV5iWjdRkOT6IICzrL5nqZSUnB9
        PJ5nfpCf+1t9YDKymFfWoZdcxSO1hlNwptONv+Br7w==
X-Google-Smtp-Source: AA6agR5TbBnQzeewFLNJT2B20rIJ4J1PMANfqfPlA8kVn7/qRNYu/IMOKiDXsiM+z3emf7Y2A2IYdLt6WrjEEvVIqsQ=
X-Received: by 2002:a2e:b746:0:b0:261:cc50:35cf with SMTP id
 k6-20020a2eb746000000b00261cc5035cfmr1612272ljo.4.1661165639489; Mon, 22 Aug
 2022 03:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220820195750.70861-1-brad@pensando.io> <20220820195750.70861-18-brad@pensando.io>
In-Reply-To: <20220820195750.70861-18-brad@pensando.io>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Aug 2022 12:53:22 +0200
Message-ID: <CAPDyKFoYdQirftoEQAMBwXKXqSo-tu9EUvL6B6vHCj6cDd14ug@mail.gmail.com>
Subject: Re: [PATCH v6 17/17] mmc: sdhci-cadence: Support mmc hardware reset
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        will@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2022 at 21:58, Brad Larson <brad@pensando.io> wrote:
>
> From: Brad Larson <blarson@amd.com>
>
> Add support for mmc hardware reset with a reset-controller
> which would need to be enabled in the device tree with
> a supporting driver.  The default is disabled for all
> existing designs.
>
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index c662c63d49fa..35d37b9aba63 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -12,6 +12,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/reset.h>
>
>  #include "sdhci-pltfm.h"
>
> @@ -70,6 +71,7 @@ struct sdhci_cdns_priv {
>         spinlock_t wrlock;      /* write lock */
>         bool enhanced_strobe;
>         void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
> +       struct reset_control *rst_hw;
>         unsigned int nr_phy_params;
>         struct sdhci_cdns_phy_param phy_params[];
>  };
> @@ -458,6 +460,22 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>                                          SDHCI_CDNS_HRS06_MODE_MMC_HS400);
>  }
>
> +static void sdhci_mmc_hw_reset(struct mmc_host *mmc)

Nitpick: Probably better to be consistent with the prefixes for
function names. So, I suggest changing this to
"sdhci_cdns_mmc_hw_reset".

> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +
> +       dev_info(mmc_dev(host->mmc), "emmc hardware reset\n");

Maybe it's sufficient with dev_dbg?

> +
> +       reset_control_assert(priv->rst_hw);
> +       /* For eMMC, minimum is 1us but give it 9us for good measure */
> +       udelay(9);
> +
> +       reset_control_deassert(priv->rst_hw);
> +       /* For eMMC, minimum is 200us but give it 300us for good measure */
> +       usleep_range(300, 1000);
> +}
> +
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
> @@ -520,6 +538,17 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         if (ret)
>                 goto free;
>
> +       if (host->mmc->caps & MMC_CAP_HW_RESET) {
> +               priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, "hw");
> +               if (IS_ERR(priv->rst_hw)) {
> +                       ret = PTR_ERR(priv->rst_hw);
> +                       if (ret == -ENOENT)
> +                               priv->rst_hw = NULL;
> +               } else {
> +                       host->mmc_host_ops.card_hw_reset = sdhci_mmc_hw_reset;
> +               }
> +       }
> +
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto free;
> --

Other than the comments above, I wonder about what merging strategy we
should use for the series. I believe it looks fine for me to pick up
the mmc related patches, thus we can apply patches on a per subsystem
basis, right?

Kind regards
Uffe
