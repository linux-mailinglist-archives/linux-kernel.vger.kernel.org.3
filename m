Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D658946C330
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbhLGS5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbhLGS5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:57:30 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF54FC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 10:53:59 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id i6so260748uae.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 10:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IgJEQWAIZy11LVGEGdPek9pRf1DjP8rskBl5TjrZwEs=;
        b=AUpkaYG4/MTv2iN75c8FIC4dCq/csivQOnd1uJjuDvW1w7zB9AY/W6cNIl+AFr+h18
         QhT2gbuEq6tQlTzhZ6swWRtQzJ+/xJByKRY+aREeY+SKpzzRJV8y0gCI+6MiA0j+O7hN
         wzD/CQMvqiYRFRMx3M0jeOC1QcwADGTao0rhhwKzxgSgUKPfIadHxYd+vOHMTMZLh38a
         d8O7eNC3xh2JLj8Di3VqJg7CkEVPexGfEs1Ji6pu7wT6hvOTfW501yTYA+ZQknUVkx/q
         kom9ou1w7xcBqWVEeSWSK3GgjEDS+oG8e2hJ/bcr8rOJQl/JUS05XXT4V1U089DGOkiF
         6+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IgJEQWAIZy11LVGEGdPek9pRf1DjP8rskBl5TjrZwEs=;
        b=yztryvogmzX0VixyWdL2RNGco4G3SbS5yHp6GVKMiUAeZgSq/vWhuwTdHDcu5NIAUI
         qsaoQDh2MyZ6OfEqOHEOpGB/rA82H29Xf3csf4a1jfx3vtzmNvLWoKgQWWgBFcyfcdot
         a7Z2BBpFXcxf1n511K1Sy//cv0krrYUl+ieXllkxsuynm6tJ+qU1/C8JsiuPbyZTQmWD
         qmcuV6VF0ImZU5wr9+XuE00Y/iRMJvEdY6Ti3XwvWLCAglHlItPjRX5hmbAyXXBBaDIr
         Vqyf7R027QWdfV2jqy3e/iAL2seXJv3Rb20Ispn3yJ5gXt8R5CRrD7UmgDHnPhwYfSLS
         DIoQ==
X-Gm-Message-State: AOAM531WwkuZR2W1JKHrjsJSFHdCPUPXqh8Iuf/JPlh9MlICWUTRoEU2
        MUZmXJoBBCY74FCukP7V4fXk/kHdvpYxpdXtMZ8mlg==
X-Google-Smtp-Source: ABdhPJxe/hEEJ+Zjw5CuU9SoEdWiEkXc5nbuj9rWKPJ0T+16zckbpdj2xWp8namjdZAtHzJhSY9INfbAojqSTzLz1fs=
X-Received: by 2002:a67:3382:: with SMTP id z124mr46887694vsz.57.1638903238896;
 Tue, 07 Dec 2021 10:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20211206153124.427102-1-virag.david003@gmail.com> <20211206153124.427102-5-virag.david003@gmail.com>
In-Reply-To: <20211206153124.427102-5-virag.david003@gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 7 Dec 2021 20:53:47 +0200
Message-ID: <CAPLW+4m6aMx3T7Rsh39zuNqrd1r_US1WWeU+5KRR5GGjOvyDcA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] clk: samsung: Make exynos850_register_cmu shared
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 17:32, David Virag <virag.david003@gmail.com> wrote:
>
> Rename exynos850_register_cmu to exynos_arm64_register_cmu and move it
> to a new file called "clk-exynos-arm64.c".
>
> This should have no functional changes, but it will allow this code to
> be shared between other arm64 Exynos SoCs, like the Exynos7885 and
> possibly ExynosAuto V9.
>
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - New patch
>
> Changes in v3:
>   - Fix SPDX comment style in clk-exynos-arm64.h
>
> Changes in v4:
>   - Fix missing headers but still remove of_address.h
>   - "__SAMSUNG_CLK_ARM64_H" -> "__CLK_EXYNOS_ARM64_H" in
>     clk-exynos-arm64.h everywhere (only the comment at the end had the
>     latter by accident)
>
>  drivers/clk/samsung/Makefile           |  1 +
>  drivers/clk/samsung/clk-exynos-arm64.c | 94 ++++++++++++++++++++++++++
>  drivers/clk/samsung/clk-exynos-arm64.h | 20 ++++++
>  drivers/clk/samsung/clk-exynos850.c    | 88 ++----------------------
>  4 files changed, 119 insertions(+), 84 deletions(-)
>  create mode 100644 drivers/clk/samsung/clk-exynos-arm64.c
>  create mode 100644 drivers/clk/samsung/clk-exynos-arm64.h
>
> diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
> index c46cf11e4d0b..901e6333c5f0 100644
> --- a/drivers/clk/samsung/Makefile
> +++ b/drivers/clk/samsung/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_EXYNOS_5420_COMMON_CLK)  +=3D clk-exynos5-=
subcmu.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)  +=3D clk-exynos5433.o
>  obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) +=3D clk-exynos-audss.o
>  obj-$(CONFIG_EXYNOS_CLKOUT)    +=3D clk-exynos-clkout.o
> +obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)  +=3D clk-exynos-arm64.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)  +=3D clk-exynos7.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)  +=3D clk-exynos850.o
>  obj-$(CONFIG_S3C2410_COMMON_CLK)+=3D clk-s3c2410.o
> diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung=
/clk-exynos-arm64.c
> new file mode 100644
> index 000000000000..b921b9a1134a
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-exynos-arm64.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 Linaro Ltd.
> + * Copyright (C) 2021 D=C3=A1vid Vir=C3=A1g <virag.david003@gmail.com>
> + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> + * Author: D=C3=A1vid Vir=C3=A1g <virag.david003@gmail.com>
> + *
> + * This file contains shared functions used by some arm64 Exynos SoCs,
> + * such as Exynos7885 or Exynos850 to register and init CMUs.
> + */

Please add empty line here (if you're going to send another version).
Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> +#include <linux/clk.h>
> +#include <linux/of_address.h>
> +
> +#include "clk-exynos-arm64.h"
> +
> +/* Gate register bits */
> +#define GATE_MANUAL            BIT(20)
> +#define GATE_ENABLE_HWACG      BIT(28)
> +
> +/* Gate register offsets range */
> +#define GATE_OFF_START         0x2000
> +#define GATE_OFF_END           0x2fff
> +
> +/**
> + * exynos_arm64_init_clocks - Set clocks initial configuration
> + * @np:                        CMU device tree node with "reg" property =
(CMU addr)
> + * @reg_offs:          Register offsets array for clocks to init
> + * @reg_offs_len:      Number of register offsets in reg_offs array
> + *
> + * Set manual control mode for all gate clocks.
> + */
> +static void __init exynos_arm64_init_clocks(struct device_node *np,
> +               const unsigned long *reg_offs, size_t reg_offs_len)
> +{
> +       void __iomem *reg_base;
> +       size_t i;
> +
> +       reg_base =3D of_iomap(np, 0);
> +       if (!reg_base)
> +               panic("%s: failed to map registers\n", __func__);
> +
> +       for (i =3D 0; i < reg_offs_len; ++i) {
> +               void __iomem *reg =3D reg_base + reg_offs[i];
> +               u32 val;
> +
> +               /* Modify only gate clock registers */
> +               if (reg_offs[i] < GATE_OFF_START || reg_offs[i] > GATE_OF=
F_END)
> +                       continue;
> +
> +               val =3D readl(reg);
> +               val |=3D GATE_MANUAL;
> +               val &=3D ~GATE_ENABLE_HWACG;
> +               writel(val, reg);
> +       }
> +
> +       iounmap(reg_base);
> +}
> +
> +/**
> + * exynos_arm64_register_cmu - Register specified Exynos CMU domain
> + * @dev:       Device object; may be NULL if this function is not being
> + *             called from platform driver probe function
> + * @np:                CMU device tree node
> + * @cmu:       CMU data
> + *
> + * Register specified CMU domain, which includes next steps:
> + *
> + * 1. Enable parent clock of @cmu CMU
> + * 2. Set initial registers configuration for @cmu CMU clocks
> + * 3. Register @cmu CMU clocks using Samsung clock framework API
> + */
> +void __init exynos_arm64_register_cmu(struct device *dev,
> +               struct device_node *np, const struct samsung_cmu_info *cm=
u)
> +{
> +       /* Keep CMU parent clock running (needed for CMU registers access=
) */
> +       if (cmu->clk_name) {
> +               struct clk *parent_clk;
> +
> +               if (dev)
> +                       parent_clk =3D clk_get(dev, cmu->clk_name);
> +               else
> +                       parent_clk =3D of_clk_get_by_name(np, cmu->clk_na=
me);
> +
> +               if (IS_ERR(parent_clk)) {
> +                       pr_err("%s: could not find bus clock %s; err =3D =
%ld\n",
> +                              __func__, cmu->clk_name, PTR_ERR(parent_cl=
k));
> +               } else {
> +                       clk_prepare_enable(parent_clk);
> +               }
> +       }
> +
> +       exynos_arm64_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
> +       samsung_cmu_register_one(np, cmu);
> +}
> diff --git a/drivers/clk/samsung/clk-exynos-arm64.h b/drivers/clk/samsung=
/clk-exynos-arm64.h
> new file mode 100644
> index 000000000000..0dd174693935
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-exynos-arm64.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Linaro Ltd.
> + * Copyright (C) 2021 D=C3=A1vid Vir=C3=A1g <virag.david003@gmail.com>
> + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> + * Author: D=C3=A1vid Vir=C3=A1g <virag.david003@gmail.com>
> + *
> + * This file contains shared functions used by some arm64 Exynos SoCs,
> + * such as Exynos7885 or Exynos850 to register and init CMUs.
> + */
> +
> +#ifndef __CLK_EXYNOS_ARM64_H
> +#define __CLK_EXYNOS_ARM64_H
> +
> +#include "clk.h"
> +
> +void exynos_arm64_register_cmu(struct device *dev,
> +               struct device_node *np, const struct samsung_cmu_info *cm=
u);
> +
> +#endif /* __CLK_EXYNOS_ARM64_H */
> diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/cl=
k-exynos850.c
> index 568ac97c8120..17413135196d 100644
> --- a/drivers/clk/samsung/clk-exynos850.c
> +++ b/drivers/clk/samsung/clk-exynos850.c
> @@ -9,93 +9,13 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>
>  #include <dt-bindings/clock/exynos850.h>
>
>  #include "clk.h"
> -
> -/* Gate register bits */
> -#define GATE_MANUAL            BIT(20)
> -#define GATE_ENABLE_HWACG      BIT(28)
> -
> -/* Gate register offsets range */
> -#define GATE_OFF_START         0x2000
> -#define GATE_OFF_END           0x2fff
> -
> -/**
> - * exynos850_init_clocks - Set clocks initial configuration
> - * @np:                        CMU device tree node with "reg" property =
(CMU addr)
> - * @reg_offs:          Register offsets array for clocks to init
> - * @reg_offs_len:      Number of register offsets in reg_offs array
> - *
> - * Set manual control mode for all gate clocks.
> - */
> -static void __init exynos850_init_clocks(struct device_node *np,
> -               const unsigned long *reg_offs, size_t reg_offs_len)
> -{
> -       void __iomem *reg_base;
> -       size_t i;
> -
> -       reg_base =3D of_iomap(np, 0);
> -       if (!reg_base)
> -               panic("%s: failed to map registers\n", __func__);
> -
> -       for (i =3D 0; i < reg_offs_len; ++i) {
> -               void __iomem *reg =3D reg_base + reg_offs[i];
> -               u32 val;
> -
> -               /* Modify only gate clock registers */
> -               if (reg_offs[i] < GATE_OFF_START || reg_offs[i] > GATE_OF=
F_END)
> -                       continue;
> -
> -               val =3D readl(reg);
> -               val |=3D GATE_MANUAL;
> -               val &=3D ~GATE_ENABLE_HWACG;
> -               writel(val, reg);
> -       }
> -
> -       iounmap(reg_base);
> -}
> -
> -/**
> - * exynos850_register_cmu - Register specified Exynos850 CMU domain
> - * @dev:       Device object; may be NULL if this function is not being
> - *             called from platform driver probe function
> - * @np:                CMU device tree node
> - * @cmu:       CMU data
> - *
> - * Register specified CMU domain, which includes next steps:
> - *
> - * 1. Enable parent clock of @cmu CMU
> - * 2. Set initial registers configuration for @cmu CMU clocks
> - * 3. Register @cmu CMU clocks using Samsung clock framework API
> - */
> -static void __init exynos850_register_cmu(struct device *dev,
> -               struct device_node *np, const struct samsung_cmu_info *cm=
u)
> -{
> -       /* Keep CMU parent clock running (needed for CMU registers access=
) */
> -       if (cmu->clk_name) {
> -               struct clk *parent_clk;
> -
> -               if (dev)
> -                       parent_clk =3D clk_get(dev, cmu->clk_name);
> -               else
> -                       parent_clk =3D of_clk_get_by_name(np, cmu->clk_na=
me);
> -
> -               if (IS_ERR(parent_clk)) {
> -                       pr_err("%s: could not find bus clock %s; err =3D =
%ld\n",
> -                              __func__, cmu->clk_name, PTR_ERR(parent_cl=
k));
> -               } else {
> -                       clk_prepare_enable(parent_clk);
> -               }
> -       }
> -
> -       exynos850_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
> -       samsung_cmu_register_one(np, cmu);
> -}
> +#include "clk-exynos-arm64.h"
>
>  /* ---- CMU_TOP --------------------------------------------------------=
----- */
>
> @@ -404,7 +324,7 @@ static const struct samsung_cmu_info top_cmu_info __i=
nitconst =3D {
>
>  static void __init exynos850_cmu_top_init(struct device_node *np)
>  {
> -       exynos850_register_cmu(NULL, np, &top_cmu_info);
> +       exynos_arm64_register_cmu(NULL, np, &top_cmu_info);
>  }
>
>  /* Register CMU_TOP early, as it's a dependency for other early domains =
*/
> @@ -892,7 +812,7 @@ static const struct samsung_cmu_info peri_cmu_info __=
initconst =3D {
>
>  static void __init exynos850_cmu_peri_init(struct device_node *np)
>  {
> -       exynos850_register_cmu(NULL, np, &peri_cmu_info);
> +       exynos_arm64_register_cmu(NULL, np, &peri_cmu_info);
>  }
>
>  /* Register CMU_PERI early, as it's needed for MCT timer */
> @@ -1069,7 +989,7 @@ static int __init exynos850_cmu_probe(struct platfor=
m_device *pdev)
>         struct device *dev =3D &pdev->dev;
>
>         info =3D of_device_get_match_data(dev);
> -       exynos850_register_cmu(dev, dev->of_node, info);
> +       exynos_arm64_register_cmu(dev, dev->of_node, info);
>
>         return 0;
>  }
> --
> 2.34.1
>
