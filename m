Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1673554AF2A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354814AbiFNLTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiFNLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:19:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3956324084;
        Tue, 14 Jun 2022 04:19:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id s12so16524871ejx.3;
        Tue, 14 Jun 2022 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whlmV8UrxJzjBMd38gq+zS77XEXwKIxpWfDi63X16RI=;
        b=F1qCqa7i5aglLXWDzkorIGtEyjePLR6cCM7gbkmI2+uEezcDn1ZOYp4nihhGTesqd4
         Xl/ZSuyl3N9fWkP4au0KcoIJDmje5AqlkwNWBw2dqnx5rs98t9EiXOmryhgPTkAOH/Hz
         Z0Qb7Q1eO2FOkSl0NqgWnQz8mTJc4bwLeRcURCY21g4v91JncsXfrSOoqCCcdMwd03Oq
         50Mp8McJiZeEoj7bd69VoyG97750V4T+4+gdSmWslJ/S7rRzFX/SU91IuZb4yqRsgr5m
         nXp1Gd4BfhEVMM6sj8WCXe0/ffHegE3l8izreEzp4FVrqDYpHsngMGYmm9xrwwgQ2oLY
         sozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whlmV8UrxJzjBMd38gq+zS77XEXwKIxpWfDi63X16RI=;
        b=lB/KURUPKyU44eQbUyUKbMgVIEkd5lhXDRvPmSZpCY5v5KhF9/uv3DNbQ2i0Q+pnpJ
         eyFdC09RkLrM/2m+BkZm33kQjrZgUuHsVJULOYCLcck6uheqEFKENbDNhlDqN+K1rfZV
         nef/cXr82fYX/uwjLqUqWeLwdkg1139kgVPeTgqh8hyyzT+7m9EuJYLIz/mvj50FVMGd
         IBn1yNdbjf1xIuL76kQro2iChKcAmP6LuYupsvPpo8x6lmFqIb2bEp12m0iuw6JYGge2
         6Vw1lzuLvSNUHdv1/2Gg07e9Kty07qmd+rqwk9jfDeocEcP0LCkQx+9CAi5iqpcL7qo/
         yYrw==
X-Gm-Message-State: AOAM531BeJ/bMxQyRsEzuh6rFtyvP+3dFXjElB6bj525hykQ676p9X3D
        uA5Z0FKW4s/ajFBGVtC6cVLAI77F58xOrIc6OqE=
X-Google-Smtp-Source: AGRyM1v0nufiTvDZqbD1JqkDhi9ZtowOUuGXYkOfl3Gt3KfgIcCzvqZo7atHU6qMu0TPXakN/shNiAECtO+30c1F6r0=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr3792329ejc.579.1655205589593; Tue, 14
 Jun 2022 04:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-14-brad@pensando.io>
In-Reply-To: <20220613195658.5607-14-brad@pensando.io>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 13:19:13 +0200
Message-ID: <CAHp75Vck4xNF=OOseMssF2R7TV2t+y0AQozRDFN2E6zQ51xR0g@mail.gmail.com>
Subject: Re: [PATCH v5 13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, piotrs@cadence.com,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 9:57 PM Brad Larson <brad@pensando.io> wrote:
>
> From: Brad Larson <blarson@amd.com>
>
> Add support for AMD Pensando Elba SoC which explicitly controls
> byte-lane enables on writes.  Add priv_write_l() which is

enabling ?

> used on Elba platforms for byte-lane control.
>
> Select MMC_SDHCI_IO_ACCESSORS for MMC_SDHCI_CADENCE which
> allows Elba SoC sdhci_elba_ops to overwrite the SDHCI
> IO memory accessors.

...

> +       void (*priv_write_l)(struct sdhci_cdns_priv *priv, u32 val,

priv_writel

> +                            void __iomem *reg);

And perhaps leave it on one line.

I also would swap parameters, so address goes first followed by value.

...

> +static inline void sdhci_cdns_priv_writel(struct sdhci_cdns_priv *priv,
> +                                         u32 val, void __iomem *reg)
> +{

> +       if (unlikely(priv->priv_write_l))

First of all, why if (unlikely())-else instead of if (likely())-else?

> +               priv->priv_write_l(priv, val, reg);
> +       else
> +               writel(val, reg);
> +}

Instead of branching each time you do I/O, make sure that callback is
always set and call it unconditionally. In this case you don't need to
have this callback, but maybe just a wrapper on `writel()`. As a
result you may split this to two patches in the first of which you
simply introduce a callback and a writel() wrapper which is assigned
unconditionally to all current chips. In the next you add a new chip
support.

...

> +       u32 m = (reg & 0x3);
> +       u32 msk = (0x3 << (m));
> +
> +       spin_lock_irqsave(&priv->wrlock, flags);
> +       writel(msk << 3, priv->ctl_addr);
> +       writew(val, host->ioaddr + reg);
> +       spin_unlock_irqrestore(&priv->wrlock, flags);

Too many 3:s as magic. Is it GENMASK() or something else? Perhaps it
needs a definition.

...

> +       u32 m = (reg & 0x3);
> +       u32 msk = (0x1 << (m));
> +
> +       spin_lock_irqsave(&priv->wrlock, flags);
> +       writel(msk << 3, priv->ctl_addr);
> +       writeb(val, host->ioaddr + reg);
> +       spin_unlock_irqrestore(&priv->wrlock, flags);

Ditto.

...

> +       writel(0x78, priv->ctl_addr);

Magic.

...

> +static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
> +       .pltfm_data = {
> +               .ops = &sdhci_cdns_ops,
> +       },
> +};
> +
> +

One blank line is enough.

...

> +       {
> +               .compatible = "amd,pensando-elba-sd4hc",
> +               .data = &sdhci_elba_drv_data

Leave a comma here.

>         },

-- 
With Best Regards,
Andy Shevchenko
