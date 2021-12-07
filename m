Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB8E46C36B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbhLGTSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbhLGTS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:18:29 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0511AC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 11:14:59 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id e27so38997vkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 11:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gfzNRfOsKy6o4CoW0KTsI8J/eMEJikfY3EgMdOHcArI=;
        b=C3x8m6XIt5zZcZApC7UVXRhmEt91ObiEbV5HiF21yWuQ8Z/F+R5Ikk1vFBylMG9YQP
         +D8LEcg+90Z0v6OUYHWQrcerwLFno4922M7JZobuKooB0HPx3DwCbqcpRZ8vYltJOKqt
         O+kud+dZtDXjnxh0jWSHwi/D8Pmmv2/C3EXePud4faXxyq3+2xW0IBRos78tEeA/IJi7
         uMcoykTpVhtjy0Hj92zQF2XRc9ArpKWlg+HOW3bnbuQxj61GL3CzM3IDAWIAP6bNohHF
         iAf1z9IBV8c4wun4DdtnR+WD6LlIunFHulbBVAvuFa9c9lAA3sw/0WHEVPxY6NyUoyQ+
         HSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gfzNRfOsKy6o4CoW0KTsI8J/eMEJikfY3EgMdOHcArI=;
        b=pEHfCbQZz8nZNgcekO/RWQ8r1DrcHvBvfP5hVntgnyFoFfkg22bVCuGDOaxCf3Bv1i
         Z8LF+hmeqh6jolGKmwQ3Qnw1UxdSMjFbiTyO+trOQ8AWwMgvY+VgbwK1a3HB8e2BR7CK
         vTSY/4tKYD4ZfI+kkObwPUcVwatRI5Veaqmgzs2B6UgC6k7USoaS1GwMqF3Qc7B7820Z
         4FZZmQAhdvnojHajhQpvjpeAVWXSgyhVQbbQ4Zy7rmYIu4yvyryQyefU2i9l/tLqyPrX
         WOwnECPXu9ojsQ6bvh9J96M+YQO/n6b2ClgG5oUBv3KCK5uv3ZoWdalRSmBoJDknJnAf
         w3rg==
X-Gm-Message-State: AOAM5317Pg/1MZEqkg8c+sX4TchZOdoareoU49p1K3XAP+tD5/O9aO2s
        ncCN2Vg6Hwd4a0e/TVF9R3VziOwCekZKa+KRYt5cmw==
X-Google-Smtp-Source: ABdhPJypvfHUwXRyCLvcg9o+Gk+YOEbi43sos3p42f+xtscBwKeEdSKeESXqCTfGN7/Avjk5D6XLH79UrM0X4YmCde8=
X-Received: by 2002:a05:6122:2158:: with SMTP id m24mr55096110vkd.1.1638904498002;
 Tue, 07 Dec 2021 11:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20211206153124.427102-1-virag.david003@gmail.com> <20211206153124.427102-7-virag.david003@gmail.com>
In-Reply-To: <20211206153124.427102-7-virag.david003@gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 7 Dec 2021 21:14:46 +0200
Message-ID: <CAPLW+4mxXMx2bBRiC2Y2_-PytK2PbvWgJ9OHkoE=dij5G4ac1Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] clk: samsung: Add initial Exynos7885 clock driver
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
> This is an initial implementation adding basic clocks, such as UART,
> USI, I2C, WDT, ect. and their parent clocks. It is heavily based on the
> Exynos850 clock driver at 'drivers/clk/samsung/clk-exynos850.c' which
> was made by Sam Protsenko, thus the copyright and author lines were
> kept.
>
> Bus clocks are enabled by default as well to avoid hangs while trying to
> access CMU registers.
>
> Only the parts of CMU_TOP needed for CMU_CORE and CMU_PERI, a bit of
> CMU_CORE, and most of CMU_PERI is implemented as of now.
>
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Use shared code between Exynos850 and 7885 clock drivers
>   - As the code that was from the Exynos850 clock driver was moved to
>     clk-exynos-arm64.c and what remains is mostly SoC specific data,
>     move the Linaro copyright and Sam Protsenko author lines there.
>
> Changes in v3:
>   - Nothing
>
> Changes in v4:
>   - Fixed missing headers
>
>  drivers/clk/samsung/Makefile         |   1 +
>  drivers/clk/samsung/clk-exynos7885.c | 597 +++++++++++++++++++++++++++
>  2 files changed, 598 insertions(+)
>  create mode 100644 drivers/clk/samsung/clk-exynos7885.c
>
> diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
> index 901e6333c5f0..0df74916a895 100644
> --- a/drivers/clk/samsung/Makefile
> +++ b/drivers/clk/samsung/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) +=3D clk-exynos-auds=
s.o
>  obj-$(CONFIG_EXYNOS_CLKOUT)    +=3D clk-exynos-clkout.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)  +=3D clk-exynos-arm64.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)  +=3D clk-exynos7.o
> +obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)  +=3D clk-exynos7885.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)  +=3D clk-exynos850.o
>  obj-$(CONFIG_S3C2410_COMMON_CLK)+=3D clk-s3c2410.o
>  obj-$(CONFIG_S3C2410_COMMON_DCLK)+=3D clk-s3c2410-dclk.o
> diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/c=
lk-exynos7885.c
> new file mode 100644
> index 000000000000..a7b106302706
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-exynos7885.c
> @@ -0,0 +1,597 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 D=C3=A1vid Vir=C3=A1g <virag.david003@gmail.com>
> + * Author: D=C3=A1vid Vir=C3=A1g <virag.david003@gmail.com>
> + *
> + * Common Clock Framework support for Exynos7885 SoC.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/clock/exynos7885.h>
> +
> +#include "clk.h"
> +#include "clk-exynos-arm64.h"
> +
> +/* ---- CMU_TOP --------------------------------------------------------=
----- */
> +
> +/* Register Offset definitions for CMU_TOP (0x12060000) */
> +#define PLL_LOCKTIME_PLL_SHARED0               0x0000
> +#define PLL_LOCKTIME_PLL_SHARED1               0x0004
> +#define PLL_CON0_PLL_SHARED0                   0x0100
> +#define PLL_CON0_PLL_SHARED1                   0x0120
> +#define CLK_CON_MUX_MUX_CLKCMU_CORE_BUS                0x1014
> +#define CLK_CON_MUX_MUX_CLKCMU_CORE_CCI                0x1018
> +#define CLK_CON_MUX_MUX_CLKCMU_CORE_G3D                0x101c
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_BUS                0x1058
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_SPI0       0x105c
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_SPI1       0x1060
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_UART0      0x1064
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_UART1      0x1068
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_UART2      0x106c
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_USI0       0x1070
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_USI1       0x1074
> +#define CLK_CON_MUX_MUX_CLKCMU_PERI_USI2       0x1078
> +#define CLK_CON_DIV_CLKCMU_CORE_BUS            0x181c
> +#define CLK_CON_DIV_CLKCMU_CORE_CCI            0x1820
> +#define CLK_CON_DIV_CLKCMU_CORE_G3D            0x1824
> +#define CLK_CON_DIV_CLKCMU_PERI_BUS            0x1874
> +#define CLK_CON_DIV_CLKCMU_PERI_SPI0           0x1878
> +#define CLK_CON_DIV_CLKCMU_PERI_SPI1           0x187c
> +#define CLK_CON_DIV_CLKCMU_PERI_UART0          0x1880
> +#define CLK_CON_DIV_CLKCMU_PERI_UART1          0x1884
> +#define CLK_CON_DIV_CLKCMU_PERI_UART2          0x1888
> +#define CLK_CON_DIV_CLKCMU_PERI_USI0           0x188c
> +#define CLK_CON_DIV_CLKCMU_PERI_USI1           0x1890
> +#define CLK_CON_DIV_CLKCMU_PERI_USI2           0x1894
> +#define CLK_CON_DIV_PLL_SHARED0_DIV2           0x189c
> +#define CLK_CON_DIV_PLL_SHARED0_DIV3           0x18a0
> +#define CLK_CON_DIV_PLL_SHARED0_DIV4           0x18a4
> +#define CLK_CON_DIV_PLL_SHARED0_DIV5           0x18a8
> +#define CLK_CON_DIV_PLL_SHARED1_DIV2           0x18ac
> +#define CLK_CON_DIV_PLL_SHARED1_DIV3           0x18b0
> +#define CLK_CON_DIV_PLL_SHARED1_DIV4           0x18b4
> +#define CLK_CON_GAT_GATE_CLKCMUC_PERI_UART1    0x2004
> +#define CLK_CON_GAT_GATE_CLKCMU_CORE_BUS       0x201c
> +#define CLK_CON_GAT_GATE_CLKCMU_CORE_CCI       0x2020
> +#define CLK_CON_GAT_GATE_CLKCMU_CORE_G3D       0x2024
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_BUS       0x207c
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_SPI0      0x2080
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_SPI1      0x2084
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_UART0     0x2088
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_UART2     0x208c
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_USI0      0x2090
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_USI1      0x2094
> +#define CLK_CON_GAT_GATE_CLKCMU_PERI_USI2      0x2098
> +
> +static const unsigned long top_clk_regs[] __initconst =3D {
> +       PLL_LOCKTIME_PLL_SHARED0,
> +       PLL_LOCKTIME_PLL_SHARED1,
> +       PLL_CON0_PLL_SHARED0,
> +       PLL_CON0_PLL_SHARED1,
> +       CLK_CON_MUX_MUX_CLKCMU_CORE_BUS,
> +       CLK_CON_MUX_MUX_CLKCMU_CORE_CCI,
> +       CLK_CON_MUX_MUX_CLKCMU_CORE_G3D,
> +       CLK_CON_MUX_MUX_CLKCMU_PERI_BUS,
> +       CLK_CON_MUX_MUX_CLKCMU_PERI_SPI0,
> +       CLK_CON_MUX_MUX_CLKCMU_PERI_SPI1,
> +       CLK_CON_MUX_MUX_CLKCMU_PERI_UART0,
> +       CLK_CON_MUX_MUX_CLKCMU_PERI_UART1,
> +       CLK_CON_MUX_MUX_CLKCMU_PERI_UART2,
> +       CLK_CON_MUX_MUX_CLKCMU_PERI_USI0,
> +       CLK_CON_MUX_MUX_CLKCMU_PERI_USI1,
> +       CLK_CON_MUX_MUX_CLKCMU_PERI_USI2,
> +       CLK_CON_DIV_CLKCMU_CORE_BUS,
> +       CLK_CON_DIV_CLKCMU_CORE_CCI,
> +       CLK_CON_DIV_CLKCMU_CORE_G3D,
> +       CLK_CON_DIV_CLKCMU_PERI_BUS,
> +       CLK_CON_DIV_CLKCMU_PERI_SPI0,
> +       CLK_CON_DIV_CLKCMU_PERI_SPI1,
> +       CLK_CON_DIV_CLKCMU_PERI_UART0,
> +       CLK_CON_DIV_CLKCMU_PERI_UART1,
> +       CLK_CON_DIV_CLKCMU_PERI_UART2,
> +       CLK_CON_DIV_CLKCMU_PERI_USI0,
> +       CLK_CON_DIV_CLKCMU_PERI_USI1,
> +       CLK_CON_DIV_CLKCMU_PERI_USI2,
> +       CLK_CON_DIV_PLL_SHARED0_DIV2,
> +       CLK_CON_DIV_PLL_SHARED0_DIV3,
> +       CLK_CON_DIV_PLL_SHARED0_DIV4,
> +       CLK_CON_DIV_PLL_SHARED0_DIV5,
> +       CLK_CON_DIV_PLL_SHARED1_DIV2,
> +       CLK_CON_DIV_PLL_SHARED1_DIV3,
> +       CLK_CON_DIV_PLL_SHARED1_DIV4,
> +       CLK_CON_GAT_GATE_CLKCMUC_PERI_UART1,
> +       CLK_CON_GAT_GATE_CLKCMU_CORE_BUS,
> +       CLK_CON_GAT_GATE_CLKCMU_CORE_CCI,
> +       CLK_CON_GAT_GATE_CLKCMU_CORE_G3D,
> +       CLK_CON_GAT_GATE_CLKCMU_PERI_BUS,
> +       CLK_CON_GAT_GATE_CLKCMU_PERI_SPI0,
> +       CLK_CON_GAT_GATE_CLKCMU_PERI_SPI1,
> +       CLK_CON_GAT_GATE_CLKCMU_PERI_UART0,
> +       CLK_CON_GAT_GATE_CLKCMU_PERI_UART2,
> +       CLK_CON_GAT_GATE_CLKCMU_PERI_USI0,
> +       CLK_CON_GAT_GATE_CLKCMU_PERI_USI1,
> +       CLK_CON_GAT_GATE_CLKCMU_PERI_USI2,
> +};
> +
> +static const struct samsung_pll_clock top_pll_clks[] __initconst =3D {
> +       PLL(pll_1417x, CLK_FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk"=
,
> +           PLL_LOCKTIME_PLL_SHARED0, PLL_CON0_PLL_SHARED0,
> +           NULL),
> +       PLL(pll_1417x, CLK_FOUT_SHARED1_PLL, "fout_shared1_pll", "oscclk"=
,
> +           PLL_LOCKTIME_PLL_SHARED1, PLL_CON0_PLL_SHARED1,
> +           NULL),
> +};
> +
> +/* List of parent clocks for Muxes in CMU_TOP: for CMU_CORE */
> +PNAME(mout_core_bus_p)         =3D { "dout_shared0_div2", "dout_shared1_=
div2",
> +                                   "dout_shared0_div3", "dout_shared0_di=
v3" };
> +PNAME(mout_core_cci_p)         =3D { "dout_shared0_div2", "dout_shared1_=
div2",
> +                                   "dout_shared0_div3", "dout_shared0_di=
v3" };
> +PNAME(mout_core_g3d_p)         =3D { "dout_shared0_div2", "dout_shared1_=
div2",
> +                                   "dout_shared0_div3", "dout_shared0_di=
v3" };
> +
> +/* List of parent clocks for Muxes in CMU_TOP: for CMU_PERI */
> +PNAME(mout_peri_bus_p)         =3D { "dout_shared0_div4", "dout_shared1_=
div4" };
> +PNAME(mout_peri_spi0_p)                =3D { "oscclk", "dout_shared0_div=
4" };
> +PNAME(mout_peri_spi1_p)                =3D { "oscclk", "dout_shared0_div=
4" };
> +PNAME(mout_peri_uart0_p)       =3D { "oscclk", "dout_shared0_div4" };
> +PNAME(mout_peri_uart1_p)       =3D { "oscclk", "dout_shared0_div4" };
> +PNAME(mout_peri_uart2_p)       =3D { "oscclk", "dout_shared0_div4" };
> +PNAME(mout_peri_usi0_p)                =3D { "oscclk", "dout_shared0_div=
4" };
> +PNAME(mout_peri_usi1_p)                =3D { "oscclk", "dout_shared0_div=
4" };
> +PNAME(mout_peri_usi2_p)                =3D { "oscclk", "dout_shared0_div=
4" };
> +
> +static const struct samsung_mux_clock top_mux_clks[] __initconst =3D {
> +       /* CORE */
> +       MUX(CLK_MOUT_CORE_BUS, "mout_core_bus", mout_core_bus_p,
> +           CLK_CON_MUX_MUX_CLKCMU_CORE_BUS, 0, 2),
> +       MUX(CLK_MOUT_CORE_CCI, "mout_core_cci", mout_core_cci_p,
> +           CLK_CON_MUX_MUX_CLKCMU_CORE_CCI, 0, 2),
> +       MUX(CLK_MOUT_CORE_G3D, "mout_core_g3d", mout_core_g3d_p,
> +           CLK_CON_MUX_MUX_CLKCMU_CORE_G3D, 0, 2),
> +
> +       /* PERI */
> +       MUX(CLK_MOUT_PERI_BUS, "mout_peri_bus", mout_peri_bus_p,
> +           CLK_CON_MUX_MUX_CLKCMU_PERI_BUS, 0, 1),
> +       MUX(CLK_MOUT_PERI_SPI0, "mout_peri_spi0", mout_peri_spi0_p,
> +           CLK_CON_MUX_MUX_CLKCMU_PERI_SPI0, 0, 1),
> +       MUX(CLK_MOUT_PERI_SPI1, "mout_peri_spi1", mout_peri_spi1_p,
> +           CLK_CON_MUX_MUX_CLKCMU_PERI_SPI1, 0, 1),
> +       MUX(CLK_MOUT_PERI_UART0, "mout_peri_uart0", mout_peri_uart0_p,
> +           CLK_CON_MUX_MUX_CLKCMU_PERI_UART0, 0, 1),
> +       MUX(CLK_MOUT_PERI_UART1, "mout_peri_uart1", mout_peri_uart1_p,
> +           CLK_CON_MUX_MUX_CLKCMU_PERI_UART1, 0, 1),
> +       MUX(CLK_MOUT_PERI_UART2, "mout_peri_uart2", mout_peri_uart2_p,
> +           CLK_CON_MUX_MUX_CLKCMU_PERI_UART2, 0, 1),
> +       MUX(CLK_MOUT_PERI_USI0, "mout_peri_usi0", mout_peri_usi0_p,
> +           CLK_CON_MUX_MUX_CLKCMU_PERI_USI0, 0, 1),
> +       MUX(CLK_MOUT_PERI_USI1, "mout_peri_usi1", mout_peri_usi1_p,
> +           CLK_CON_MUX_MUX_CLKCMU_PERI_USI1, 0, 1),
> +       MUX(CLK_MOUT_PERI_USI2, "mout_peri_usi2", mout_peri_usi2_p,
> +           CLK_CON_MUX_MUX_CLKCMU_PERI_USI2, 0, 1),
> +};
> +
> +static const struct samsung_div_clock top_div_clks[] __initconst =3D {
> +       /* TOP */
> +       DIV(CLK_DOUT_SHARED0_DIV2, "dout_shared0_div2", "fout_shared0_pll=
",
> +           CLK_CON_DIV_PLL_SHARED0_DIV2, 0, 1),
> +       DIV(CLK_DOUT_SHARED0_DIV3, "dout_shared0_div3", "fout_shared0_pll=
",
> +           CLK_CON_DIV_PLL_SHARED0_DIV3, 0, 2),
> +       DIV(CLK_DOUT_SHARED0_DIV4, "dout_shared0_div4", "fout_shared0_pll=
",
> +           CLK_CON_DIV_PLL_SHARED0_DIV4, 0, 1),
> +       DIV(CLK_DOUT_SHARED0_DIV5, "dout_shared0_div5", "fout_shared0_pll=
",
> +           CLK_CON_DIV_PLL_SHARED0_DIV5, 0, 3),
> +       DIV(CLK_DOUT_SHARED1_DIV2, "dout_shared1_div2", "fout_shared1_pll=
",
> +           CLK_CON_DIV_PLL_SHARED1_DIV2, 0, 1),
> +       DIV(CLK_DOUT_SHARED1_DIV3, "dout_shared1_div3", "fout_shared1_pll=
",
> +           CLK_CON_DIV_PLL_SHARED1_DIV3, 0, 2),
> +       DIV(CLK_DOUT_SHARED1_DIV4, "dout_shared1_div4", "fout_shared1_pll=
",
> +           CLK_CON_DIV_PLL_SHARED1_DIV4, 0, 1),
> +
> +       /* CORE */
> +       DIV(CLK_DOUT_CORE_BUS, "dout_core_bus", "gout_core_bus",
> +           CLK_CON_DIV_CLKCMU_CORE_BUS, 0, 3),
> +       DIV(CLK_DOUT_CORE_CCI, "dout_core_cci", "gout_core_cci",
> +           CLK_CON_DIV_CLKCMU_CORE_CCI, 0, 3),
> +       DIV(CLK_DOUT_CORE_G3D, "dout_core_g3d", "gout_core_g3d",
> +           CLK_CON_DIV_CLKCMU_CORE_G3D, 0, 3),
> +
> +       /* PERI */
> +       DIV(CLK_DOUT_PERI_BUS, "dout_peri_bus", "gout_peri_bus",
> +           CLK_CON_DIV_CLKCMU_PERI_BUS, 0, 4),
> +       DIV(CLK_DOUT_PERI_SPI0, "dout_peri_spi0", "gout_peri_spi0",
> +           CLK_CON_DIV_CLKCMU_PERI_SPI0, 0, 6),
> +       DIV(CLK_DOUT_PERI_SPI1, "dout_peri_spi1", "gout_peri_spi1",
> +           CLK_CON_DIV_CLKCMU_PERI_SPI1, 0, 6),
> +       DIV(CLK_DOUT_PERI_UART0, "dout_peri_uart0", "gout_peri_uart0",
> +           CLK_CON_DIV_CLKCMU_PERI_UART0, 0, 4),
> +       DIV(CLK_DOUT_PERI_UART1, "dout_peri_uart1", "gout_peri_uart1",
> +           CLK_CON_DIV_CLKCMU_PERI_UART1, 0, 4),
> +       DIV(CLK_DOUT_PERI_UART2, "dout_peri_uart2", "gout_peri_uart2",
> +           CLK_CON_DIV_CLKCMU_PERI_UART2, 0, 4),
> +       DIV(CLK_DOUT_PERI_USI0, "dout_peri_usi0", "gout_peri_usi0",
> +           CLK_CON_DIV_CLKCMU_PERI_USI0, 0, 4),
> +       DIV(CLK_DOUT_PERI_USI1, "dout_peri_usi1", "gout_peri_usi1",
> +           CLK_CON_DIV_CLKCMU_PERI_USI1, 0, 4),
> +       DIV(CLK_DOUT_PERI_USI2, "dout_peri_usi2", "gout_peri_usi2",
> +           CLK_CON_DIV_CLKCMU_PERI_USI2, 0, 4),
> +};
> +
> +static const struct samsung_gate_clock top_gate_clks[] __initconst =3D {
> +       /* CORE */
> +       GATE(CLK_GOUT_CORE_BUS, "gout_core_bus", "mout_core_bus",
> +            CLK_CON_GAT_GATE_CLKCMU_CORE_BUS, 21, 0, 0),
> +       GATE(CLK_GOUT_CORE_CCI, "gout_core_cci", "mout_core_cci",
> +            CLK_CON_GAT_GATE_CLKCMU_CORE_CCI, 21, 0, 0),
> +       GATE(CLK_GOUT_CORE_G3D, "gout_core_g3d", "mout_core_g3d",
> +            CLK_CON_GAT_GATE_CLKCMU_CORE_G3D, 21, 0, 0),
> +
> +       /* PERI */
> +       GATE(CLK_GOUT_PERI_BUS, "gout_peri_bus", "mout_peri_bus",
> +            CLK_CON_GAT_GATE_CLKCMU_PERI_BUS, 21, 0, 0),
> +       GATE(CLK_GOUT_PERI_SPI0, "gout_peri_spi0", "mout_peri_spi0",
> +            CLK_CON_GAT_GATE_CLKCMU_PERI_SPI0, 21, 0, 0),
> +       GATE(CLK_GOUT_PERI_SPI1, "gout_peri_spi1", "mout_peri_spi1",
> +            CLK_CON_GAT_GATE_CLKCMU_PERI_SPI1, 21, 0, 0),
> +       GATE(CLK_GOUT_PERI_UART0, "gout_peri_uart0", "mout_peri_uart0",
> +            CLK_CON_GAT_GATE_CLKCMU_PERI_UART0, 21, 0, 0),
> +       GATE(CLK_GOUT_PERI_UART1, "gout_peri_uart1", "mout_peri_uart1",
> +            CLK_CON_GAT_GATE_CLKCMUC_PERI_UART1, 21, 0, 0),
> +       GATE(CLK_GOUT_PERI_UART2, "gout_peri_uart2", "mout_peri_uart2",
> +            CLK_CON_GAT_GATE_CLKCMU_PERI_UART2, 21, 0, 0),
> +       GATE(CLK_GOUT_PERI_USI0, "gout_peri_usi0", "mout_peri_usi0",
> +            CLK_CON_GAT_GATE_CLKCMU_PERI_USI0, 21, 0, 0),
> +       GATE(CLK_GOUT_PERI_USI1, "gout_peri_usi1", "mout_peri_usi1",
> +            CLK_CON_GAT_GATE_CLKCMU_PERI_USI1, 21, 0, 0),
> +       GATE(CLK_GOUT_PERI_USI2, "gout_peri_usi2", "mout_peri_usi2",
> +            CLK_CON_GAT_GATE_CLKCMU_PERI_USI2, 21, 0, 0),
> +};
> +
> +static const struct samsung_cmu_info top_cmu_info __initconst =3D {
> +       .pll_clks               =3D top_pll_clks,
> +       .nr_pll_clks            =3D ARRAY_SIZE(top_pll_clks),
> +       .mux_clks               =3D top_mux_clks,
> +       .nr_mux_clks            =3D ARRAY_SIZE(top_mux_clks),
> +       .div_clks               =3D top_div_clks,
> +       .nr_div_clks            =3D ARRAY_SIZE(top_div_clks),
> +       .gate_clks              =3D top_gate_clks,
> +       .nr_gate_clks           =3D ARRAY_SIZE(top_gate_clks),
> +       .nr_clk_ids             =3D TOP_NR_CLK,
> +       .clk_regs               =3D top_clk_regs,
> +       .nr_clk_regs            =3D ARRAY_SIZE(top_clk_regs),
> +};
> +
> +static void __init exynos7885_cmu_top_init(struct device_node *np)
> +{
> +       exynos_arm64_register_cmu(NULL, np, &top_cmu_info);
> +}
> +
> +/* Register CMU_TOP early, as it's a dependency for other early domains =
*/
> +CLK_OF_DECLARE(exynos7885_cmu_top, "samsung,exynos7885-cmu-top",
> +              exynos7885_cmu_top_init);
> +
> +/* ---- CMU_PERI -------------------------------------------------------=
----- */
> +
> +/* Register Offset definitions for CMU_PERI (0x10010000) */
> +#define PLL_CON0_MUX_CLKCMU_PERI_BUS_USER      0x0100
> +#define PLL_CON0_MUX_CLKCMU_PERI_SPI0_USER     0x0120
> +#define PLL_CON0_MUX_CLKCMU_PERI_SPI1_USER     0x0140
> +#define PLL_CON0_MUX_CLKCMU_PERI_UART0_USER    0x0160
> +#define PLL_CON0_MUX_CLKCMU_PERI_UART1_USER    0x0180
> +#define PLL_CON0_MUX_CLKCMU_PERI_UART2_USER    0x01a0
> +#define PLL_CON0_MUX_CLKCMU_PERI_USI0_USER     0x01c0
> +#define PLL_CON0_MUX_CLKCMU_PERI_USI1_USER     0x01e0
> +#define PLL_CON0_MUX_CLKCMU_PERI_USI2_USER     0x0200
> +#define CLK_CON_GAT_GOUT_PERI_GPIO_TOP_PCLK    0x2024
> +#define CLK_CON_GAT_GOUT_PERI_HSI2C_0_PCLK     0x2028
> +#define CLK_CON_GAT_GOUT_PERI_HSI2C_1_PCLK     0x202c
> +#define CLK_CON_GAT_GOUT_PERI_HSI2C_2_PCLK     0x2030
> +#define CLK_CON_GAT_GOUT_PERI_HSI2C_3_PCLK     0x2034
> +#define CLK_CON_GAT_GOUT_PERI_I2C_0_PCLK       0x2038
> +#define CLK_CON_GAT_GOUT_PERI_I2C_1_PCLK       0x203c
> +#define CLK_CON_GAT_GOUT_PERI_I2C_2_PCLK       0x2040
> +#define CLK_CON_GAT_GOUT_PERI_I2C_3_PCLK       0x2044
> +#define CLK_CON_GAT_GOUT_PERI_I2C_4_PCLK       0x2048
> +#define CLK_CON_GAT_GOUT_PERI_I2C_5_PCLK       0x204c
> +#define CLK_CON_GAT_GOUT_PERI_I2C_6_PCLK       0x2050
> +#define CLK_CON_GAT_GOUT_PERI_I2C_7_PCLK       0x2054
> +#define CLK_CON_GAT_GOUT_PERI_PWM_MOTOR_PCLK   0x2058
> +#define CLK_CON_GAT_GOUT_PERI_SPI_0_PCLK       0x205c
> +#define CLK_CON_GAT_GOUT_PERI_SPI_0_EXT_CLK    0x2060
> +#define CLK_CON_GAT_GOUT_PERI_SPI_1_PCLK       0x2064
> +#define CLK_CON_GAT_GOUT_PERI_SPI_1_EXT_CLK    0x2068
> +#define CLK_CON_GAT_GOUT_PERI_UART_0_EXT_UCLK  0x206c
> +#define CLK_CON_GAT_GOUT_PERI_UART_0_PCLK      0x2070
> +#define CLK_CON_GAT_GOUT_PERI_UART_1_EXT_UCLK  0x2074
> +#define CLK_CON_GAT_GOUT_PERI_UART_1_PCLK      0x2078
> +#define CLK_CON_GAT_GOUT_PERI_UART_2_EXT_UCLK  0x207c
> +#define CLK_CON_GAT_GOUT_PERI_UART_2_PCLK      0x2080
> +#define CLK_CON_GAT_GOUT_PERI_USI0_PCLK                0x2084
> +#define CLK_CON_GAT_GOUT_PERI_USI0_SCLK                0x2088
> +#define CLK_CON_GAT_GOUT_PERI_USI1_PCLK                0x208c
> +#define CLK_CON_GAT_GOUT_PERI_USI1_SCLK                0x2090
> +#define CLK_CON_GAT_GOUT_PERI_USI2_PCLK                0x2094
> +#define CLK_CON_GAT_GOUT_PERI_USI2_SCLK                0x2098
> +#define CLK_CON_GAT_GOUT_PERI_MCT_PCLK         0x20a0
> +#define CLK_CON_GAT_GOUT_PERI_SYSREG_PERI_PCLK 0x20b0
> +#define CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER0_PCLK        0x20b4
> +#define CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER1_PCLK        0x20b8
> +
> +static const unsigned long peri_clk_regs[] __initconst =3D {
> +       PLL_CON0_MUX_CLKCMU_PERI_BUS_USER,
> +       PLL_CON0_MUX_CLKCMU_PERI_SPI0_USER,
> +       PLL_CON0_MUX_CLKCMU_PERI_SPI1_USER,
> +       PLL_CON0_MUX_CLKCMU_PERI_UART0_USER,
> +       PLL_CON0_MUX_CLKCMU_PERI_UART1_USER,
> +       PLL_CON0_MUX_CLKCMU_PERI_UART2_USER,
> +       PLL_CON0_MUX_CLKCMU_PERI_USI0_USER,
> +       PLL_CON0_MUX_CLKCMU_PERI_USI1_USER,
> +       PLL_CON0_MUX_CLKCMU_PERI_USI2_USER,
> +       CLK_CON_GAT_GOUT_PERI_GPIO_TOP_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_HSI2C_0_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_HSI2C_1_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_HSI2C_2_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_HSI2C_3_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_I2C_0_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_I2C_1_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_I2C_2_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_I2C_3_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_I2C_4_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_I2C_5_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_I2C_6_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_I2C_7_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_PWM_MOTOR_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_SPI_0_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_SPI_0_EXT_CLK,
> +       CLK_CON_GAT_GOUT_PERI_SPI_1_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_SPI_1_EXT_CLK,
> +       CLK_CON_GAT_GOUT_PERI_UART_0_EXT_UCLK,
> +       CLK_CON_GAT_GOUT_PERI_UART_0_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_UART_1_EXT_UCLK,
> +       CLK_CON_GAT_GOUT_PERI_UART_1_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_UART_2_EXT_UCLK,
> +       CLK_CON_GAT_GOUT_PERI_UART_2_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_USI0_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_USI0_SCLK,
> +       CLK_CON_GAT_GOUT_PERI_USI1_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_USI1_SCLK,
> +       CLK_CON_GAT_GOUT_PERI_USI2_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_USI2_SCLK,
> +       CLK_CON_GAT_GOUT_PERI_MCT_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_SYSREG_PERI_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER0_PCLK,
> +       CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER1_PCLK,
> +};
> +
> +/* List of parent clocks for Muxes in CMU_PERI */
> +PNAME(mout_peri_bus_user_p)    =3D { "oscclk", "dout_peri_bus" };
> +PNAME(mout_peri_spi0_user_p)   =3D { "oscclk", "dout_peri_spi0" };
> +PNAME(mout_peri_spi1_user_p)   =3D { "oscclk", "dout_peri_spi1" };
> +PNAME(mout_peri_uart0_user_p)  =3D { "oscclk", "dout_peri_uart0" };
> +PNAME(mout_peri_uart1_user_p)  =3D { "oscclk", "dout_peri_uart1" };
> +PNAME(mout_peri_uart2_user_p)  =3D { "oscclk", "dout_peri_uart2" };
> +PNAME(mout_peri_usi0_user_p)   =3D { "oscclk", "dout_peri_usi0" };
> +PNAME(mout_peri_usi1_user_p)   =3D { "oscclk", "dout_peri_usi1" };
> +PNAME(mout_peri_usi2_user_p)   =3D { "oscclk", "dout_peri_usi2" };
> +
> +static const struct samsung_mux_clock peri_mux_clks[] __initconst =3D {
> +       MUX(CLK_MOUT_PERI_BUS_USER, "mout_peri_bus_user", mout_peri_bus_u=
ser_p,
> +           PLL_CON0_MUX_CLKCMU_PERI_BUS_USER, 4, 1),
> +       MUX(CLK_MOUT_PERI_SPI0_USER, "mout_peri_spi0_user", mout_peri_spi=
0_user_p,

Nit-pick: here and below in this file, please try to keep max line
length at 80 characters. I know it's not mandatory anymore, but I'd
personally prefer it to be that away (otherwise it's not consistent
with most of lines that are 80 char long). It's easy to spot that with
"checkpatch.pl --strict".

> +           PLL_CON0_MUX_CLKCMU_PERI_SPI0_USER, 4, 1),
> +       MUX(CLK_MOUT_PERI_SPI1_USER, "mout_peri_spi1_user", mout_peri_spi=
1_user_p,
> +           PLL_CON0_MUX_CLKCMU_PERI_SPI1_USER, 4, 1),
> +       MUX(CLK_MOUT_PERI_UART0_USER, "mout_peri_uart0_user",
> +           mout_peri_uart0_user_p, PLL_CON0_MUX_CLKCMU_PERI_UART0_USER, =
4, 1),
> +       MUX(CLK_MOUT_PERI_UART1_USER, "mout_peri_uart1_user",
> +           mout_peri_uart1_user_p, PLL_CON0_MUX_CLKCMU_PERI_UART1_USER, =
4, 1),
> +       MUX(CLK_MOUT_PERI_UART2_USER, "mout_peri_uart2_user",
> +           mout_peri_uart2_user_p, PLL_CON0_MUX_CLKCMU_PERI_UART2_USER, =
4, 1),
> +       MUX(CLK_MOUT_PERI_USI0_USER, "mout_peri_usi0_user",
> +           mout_peri_usi0_user_p, PLL_CON0_MUX_CLKCMU_PERI_USI0_USER, 4,=
 1),
> +       MUX(CLK_MOUT_PERI_USI1_USER, "mout_peri_usi1_user",
> +           mout_peri_usi1_user_p, PLL_CON0_MUX_CLKCMU_PERI_USI1_USER, 4,=
 1),
> +       MUX(CLK_MOUT_PERI_USI2_USER, "mout_peri_usi2_user",
> +           mout_peri_usi2_user_p, PLL_CON0_MUX_CLKCMU_PERI_USI2_USER, 4,=
 1),
> +};
> +
> +static const struct samsung_gate_clock peri_gate_clks[] __initconst =3D =
{
> +       /* TODO: Should be enabled in GPIO driver (or made CLK_IS_CRITICA=
L) */
> +       GATE(CLK_GOUT_GPIO_TOP_PCLK, "gout_gpio_top_pclk",
> +            "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_GPIO_TOP_PCLK, 21, CLK_IGNORE_UNUSED, =
0),
> +       GATE(CLK_GOUT_HSI2C0_PCLK, "gout_hsi2c0_pclk", "mout_peri_bus_use=
r",
> +            CLK_CON_GAT_GOUT_PERI_HSI2C_0_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_HSI2C1_PCLK, "gout_hsi2c1_pclk", "mout_peri_bus_use=
r",
> +            CLK_CON_GAT_GOUT_PERI_HSI2C_1_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_HSI2C2_PCLK, "gout_hsi2c2_pclk", "mout_peri_bus_use=
r",
> +            CLK_CON_GAT_GOUT_PERI_HSI2C_2_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_HSI2C3_PCLK, "gout_hsi2c3_pclk", "mout_peri_bus_use=
r",
> +            CLK_CON_GAT_GOUT_PERI_HSI2C_3_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_I2C0_PCLK, "gout_i2c0_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_I2C_0_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_I2C1_PCLK, "gout_i2c1_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_I2C_1_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_I2C2_PCLK, "gout_i2c2_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_I2C_2_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_I2C3_PCLK, "gout_i2c3_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_I2C_3_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_I2C4_PCLK, "gout_i2c4_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_I2C_4_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_I2C5_PCLK, "gout_i2c5_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_I2C_5_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_I2C6_PCLK, "gout_i2c6_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_I2C_6_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_I2C7_PCLK, "gout_i2c7_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_I2C_7_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_PWM_MOTOR_PCLK, "gout_pwm_motor_pclk",
> +            "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_PWM_MOTOR_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_SPI0_PCLK, "gout_spi0_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_SPI_0_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_SPI0_EXT_CLK, "gout_spi0_ipclk", "mout_peri_spi0_us=
er",
> +            CLK_CON_GAT_GOUT_PERI_SPI_0_EXT_CLK, 21, 0, 0),
> +       GATE(CLK_GOUT_SPI1_PCLK, "gout_spi1_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_SPI_1_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_SPI1_EXT_CLK, "gout_spi1_ipclk", "mout_peri_spi1_us=
er",
> +            CLK_CON_GAT_GOUT_PERI_SPI_1_EXT_CLK, 21, 0, 0),
> +       GATE(CLK_GOUT_UART0_EXT_UCLK, "gout_uart0_ext_uclk", "mout_peri_u=
art0_user",
> +            CLK_CON_GAT_GOUT_PERI_UART_0_EXT_UCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_UART0_PCLK, "gout_uart0_pclk", "mout_peri_bus_user"=
,
> +            CLK_CON_GAT_GOUT_PERI_UART_0_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_UART1_EXT_UCLK, "gout_uart1_ext_uclk", "mout_peri_u=
art1_user",
> +            CLK_CON_GAT_GOUT_PERI_UART_1_EXT_UCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_UART1_PCLK, "gout_uart1_pclk", "mout_peri_bus_user"=
,
> +            CLK_CON_GAT_GOUT_PERI_UART_1_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_UART2_EXT_UCLK, "gout_uart2_ext_uclk", "mout_peri_u=
art2_user",
> +            CLK_CON_GAT_GOUT_PERI_UART_2_EXT_UCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_UART2_PCLK, "gout_uart2_pclk", "mout_peri_bus_user"=
,
> +            CLK_CON_GAT_GOUT_PERI_UART_2_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_USI0_PCLK, "gout_usi0_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_USI0_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_USI0_SCLK, "gout_usi0_sclk", "mout_peri_usi0_user",
> +            CLK_CON_GAT_GOUT_PERI_USI0_SCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_USI1_PCLK, "gout_usi1_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_USI1_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_USI1_SCLK, "gout_usi1_sclk", "mout_peri_usi1_user",
> +            CLK_CON_GAT_GOUT_PERI_USI1_SCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_USI2_PCLK, "gout_usi2_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_USI2_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_USI2_SCLK, "gout_usi2_sclk", "mout_peri_usi2_user",
> +            CLK_CON_GAT_GOUT_PERI_USI2_SCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_MCT_PCLK, "gout_mct_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_MCT_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_SYSREG_PERI_PCLK, "gout_sysreg_peri_pclk",
> +            "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_SYSREG_PERI_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_WDT0_PCLK, "gout_wdt0_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER0_PCLK, 21, 0, 0),
> +       GATE(CLK_GOUT_WDT1_PCLK, "gout_wdt1_pclk", "mout_peri_bus_user",
> +            CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER1_PCLK, 21, 0, 0),
> +};
> +
> +static const struct samsung_cmu_info peri_cmu_info __initconst =3D {
> +       .mux_clks               =3D peri_mux_clks,
> +       .nr_mux_clks            =3D ARRAY_SIZE(peri_mux_clks),
> +       .gate_clks              =3D peri_gate_clks,
> +       .nr_gate_clks           =3D ARRAY_SIZE(peri_gate_clks),
> +       .nr_clk_ids             =3D PERI_NR_CLK,
> +       .clk_regs               =3D peri_clk_regs,
> +       .nr_clk_regs            =3D ARRAY_SIZE(peri_clk_regs),
> +       .clk_name               =3D "dout_peri_bus",
> +};
> +
> +static void __init exynos7885_cmu_peri_init(struct device_node *np)
> +{
> +       exynos_arm64_register_cmu(NULL, np, &peri_cmu_info);
> +}
> +
> +/* Register CMU_PERI early, as it's needed for MCT timer */
> +CLK_OF_DECLARE(exynos7885_cmu_peri, "samsung,exynos7885-cmu-peri",
> +              exynos7885_cmu_peri_init);
> +
> +/* ---- CMU_CORE -------------------------------------------------------=
----- */
> +
> +/* Register Offset definitions for CMU_CORE (0x12000000) */
> +#define PLL_CON0_MUX_CLKCMU_CORE_BUS_USER      0x0100
> +#define PLL_CON0_MUX_CLKCMU_CORE_CCI_USER      0x0120
> +#define PLL_CON0_MUX_CLKCMU_CORE_G3D_USER      0x0140
> +#define CLK_CON_MUX_MUX_CLK_CORE_GIC           0x1000
> +#define CLK_CON_DIV_DIV_CLK_CORE_BUSP          0x1800
> +#define CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK     0x2054
> +#define CLK_CON_GAT_GOUT_CORE_GIC400_CLK       0x2058
> +
> +static const unsigned long core_clk_regs[] __initconst =3D {
> +       PLL_CON0_MUX_CLKCMU_CORE_BUS_USER,
> +       PLL_CON0_MUX_CLKCMU_CORE_CCI_USER,
> +       PLL_CON0_MUX_CLKCMU_CORE_G3D_USER,
> +       CLK_CON_MUX_MUX_CLK_CORE_GIC,
> +       CLK_CON_DIV_DIV_CLK_CORE_BUSP,
> +       CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK,
> +       CLK_CON_GAT_GOUT_CORE_GIC400_CLK,
> +};
> +
> +/* List of parent clocks for Muxes in CMU_CORE */
> +PNAME(mout_core_bus_user_p)            =3D { "oscclk", "dout_core_bus" }=
;
> +PNAME(mout_core_cci_user_p)            =3D { "oscclk", "dout_core_cci" }=
;
> +PNAME(mout_core_g3d_user_p)            =3D { "oscclk", "dout_core_g3d" }=
;
> +PNAME(mout_core_gic_p)                 =3D { "dout_core_busp", "oscclk" =
};
> +
> +static const struct samsung_mux_clock core_mux_clks[] __initconst =3D {
> +       MUX(CLK_MOUT_CORE_BUS_USER, "mout_core_bus_user", mout_core_bus_u=
ser_p,
> +           PLL_CON0_MUX_CLKCMU_CORE_BUS_USER, 4, 1),
> +       MUX(CLK_MOUT_CORE_CCI_USER, "mout_core_cci_user", mout_core_cci_u=
ser_p,
> +           PLL_CON0_MUX_CLKCMU_CORE_CCI_USER, 4, 1),
> +       MUX(CLK_MOUT_CORE_G3D_USER, "mout_core_g3d_user", mout_core_g3d_u=
ser_p,
> +           PLL_CON0_MUX_CLKCMU_CORE_G3D_USER, 4, 1),
> +       MUX(CLK_MOUT_CORE_GIC, "mout_core_gic", mout_core_gic_p,
> +           CLK_CON_MUX_MUX_CLK_CORE_GIC, 0, 1),
> +};
> +
> +static const struct samsung_div_clock core_div_clks[] __initconst =3D {
> +       DIV(CLK_DOUT_CORE_BUSP, "dout_core_busp", "mout_core_bus_user",
> +           CLK_CON_DIV_DIV_CLK_CORE_BUSP, 0, 2),
> +};
> +
> +static const struct samsung_gate_clock core_gate_clks[] __initconst =3D =
{
> +       /* CCI (interconnect) clock must be always running */
> +       GATE(CLK_GOUT_CCI_ACLK, "gout_cci_aclk", "mout_core_cci_user",
> +            CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK, 21, CLK_IS_CRITICAL, 0),
> +       /* GIC (interrupt controller) clock must be always running */
> +       GATE(CLK_GOUT_GIC400_CLK, "gout_gic400_clk", "mout_core_gic",
> +            CLK_CON_GAT_GOUT_CORE_GIC400_CLK, 21, CLK_IS_CRITICAL, 0),
> +};
> +
> +static const struct samsung_cmu_info core_cmu_info __initconst =3D {
> +       .mux_clks               =3D core_mux_clks,
> +       .nr_mux_clks            =3D ARRAY_SIZE(core_mux_clks),
> +       .div_clks               =3D core_div_clks,
> +       .nr_div_clks            =3D ARRAY_SIZE(core_div_clks),
> +       .gate_clks              =3D core_gate_clks,
> +       .nr_gate_clks           =3D ARRAY_SIZE(core_gate_clks),
> +       .nr_clk_ids             =3D CORE_NR_CLK,
> +       .clk_regs               =3D core_clk_regs,
> +       .nr_clk_regs            =3D ARRAY_SIZE(core_clk_regs),
> +       .clk_name               =3D "dout_core_bus",
> +};
> +
> +/* ---- platform_driver ------------------------------------------------=
----- */
> +
> +static int __init exynos7885_cmu_probe(struct platform_device *pdev)
> +{
> +       const struct samsung_cmu_info *info;
> +       struct device *dev =3D &pdev->dev;
> +
> +       info =3D of_device_get_match_data(dev);
> +       exynos_arm64_register_cmu(dev, dev->of_node, info);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id exynos7885_cmu_of_match[] =3D {
> +       {
> +               .compatible =3D "samsung,exynos7885-cmu-core",
> +               .data =3D &core_cmu_info,
> +       }, {
> +       },
> +};
> +
> +static struct platform_driver exynos7885_cmu_driver __refdata =3D {
> +       .driver =3D {
> +               .name =3D "exynos7885-cmu",
> +               .of_match_table =3D exynos7885_cmu_of_match,
> +               .suppress_bind_attrs =3D true,
> +       },
> +       .probe =3D exynos7885_cmu_probe,
> +};
> +
> +static int __init exynos7885_cmu_init(void)
> +{
> +       return platform_driver_register(&exynos7885_cmu_driver);
> +}
> +core_initcall(exynos7885_cmu_init);
> --
> 2.34.1
>
