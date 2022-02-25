Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E764C3B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiBYB6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbiBYB6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:58:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B22A28F459;
        Thu, 24 Feb 2022 17:58:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19CF661470;
        Fri, 25 Feb 2022 01:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C81CC340E9;
        Fri, 25 Feb 2022 01:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645754284;
        bh=Am4FBRKLYugZvkSv0Lo8VPgRbfXsAVl3IMh275eLbjU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uutRSKlgKaj6D3K+WTu9yKqS/waQc7a0hSfs0n67//r61NwyJFItq9y9mcv/QrXHX
         D6uuCml+sUrDtDcdP+Z5dYIQW16wBdVtWmPFbVS5e+B/3TmGJQ9g8tCxwKfIq6Q4zf
         n6uFBx+8umZzGt9l73Vqr0zo/SkJBgXd9aHWehnwCAGLaRz+Ooeuglqiib2HY2twTW
         CBOmf3Tr3I2LtT5S+H0wSUtpqgZKKjMutMjMgX4DZPh91cF2+Lsv31ObhweEQw1soD
         W8XtnpLBv6mCi7ff5bSl3pOLMiV7HJiwRai5Ncn2GVd2LAH98/u0zs/80t6HrNXi7p
         hifJF71nDmRZA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220225014234.1766305-6-peng.fan@oss.nxp.com>
References: <20220225014234.1766305-1-peng.fan@oss.nxp.com> <20220225014234.1766305-6-peng.fan@oss.nxp.com>
Subject: Re: [PATCH V5 5/5] clk: imx: add i.MX93 clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, abel.vesa@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Thu, 24 Feb 2022 17:58:02 -0800
User-Agent: alot/0.10
Message-Id: <20220225015804.6C81CC340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2022-02-24 17:42:34)
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> new file mode 100644
> index 000000000000..7cd5e7fb0c8b
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -0,0 +1,338 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP.
> + */
> +
> +#include <dt-bindings/clock/imx93-clock.h>

Include after linux headers please.

> +#include <linux/clk.h>

Is this include used?

> +#include <linux/clk-provider.h>
> +#include <linux/debugfs.h>

Is this used?

> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "clk.h"
> +
> +enum clk_sel {
> +       LOW_SPEED_IO_SEL,
> +       NON_IO_SEL,
> +       FAST_SEL,
> +       AUDIO_SEL,
> +       VIDEO_SEL,
> +       TPM_SEL,
> +       CKO1_SEL,
> +       CKO2_SEL,
> +       MISC_SEL,
> +       MAX_SEL
> +};
> +
> +static const char *parent_names[MAX_SEL][4] =3D {
> +       {"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "video_pll"=
},
> +       {"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "sys_pll_pf=
d2_div2"},
> +       {"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "sys_pll_pfd2"},
> +       {"osc_24m", "audio_pll", "video_pll", "clk_ext1"},
> +       {"osc_24m", "audio_pll", "video_pll", "sys_pll_pfd0"},
> +       {"osc_24m", "sys_pll_pfd0", "audio_pll", "clk_ext1"},
> +       {"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "audio_pll"},
> +       {"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "video_pll"},
> +       {"osc_24m", "audio_pll", "video_pll", "sys_pll_pfd2"},
> +};
> +
> +struct imx93_clk_root {
> +       u32 clk;
> +       char *name;
> +       u32 off;
> +       enum clk_sel sel;
> +       unsigned long flags;
> +} root_array[] =3D {

Can this be const and static?

> +       { IMX93_CLK_A55_PERIPH,         "a55_periph_root",      0x0000, F=
AST_SEL, CLK_IS_CRITICAL },
> +       { IMX93_CLK_A55_MTR_BUS,        "a55_mtr_bus_root",     0x0080, L=
OW_SPEED_IO_SEL, CLK_IS_CRITICAL },
> +       { IMX93_CLK_A55,                "a55_root",             0x0100, F=
AST_SEL, CLK_IS_CRITICAL },
> +       { IMX93_CLK_M33,                "m33_root",             0x0180, L=
OW_SPEED_IO_SEL, CLK_IS_CRITICAL },
> +       { IMX93_CLK_BUS_WAKEUP,         "bus_wakeup_root",      0x0280, L=
OW_SPEED_IO_SEL, CLK_IS_CRITICAL },
> +       { IMX93_CLK_BUS_AON,            "bus_aon_root",         0x0300, L=
OW_SPEED_IO_SEL, CLK_IS_CRITICAL },
> +       { IMX93_CLK_WAKEUP_AXI,         "wakeup_axi_root",      0x0380, F=
AST_SEL, CLK_IS_CRITICAL },
> +       { IMX93_CLK_SWO_TRACE,          "swo_trace_root",       0x0400, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_M33_SYSTICK,        "m33_systick_root",     0x0480, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_FLEXIO1,            "flexio1_root",         0x0500, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_FLEXIO2,            "flexio2_root",         0x0580, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPIT1,              "lpit1_root",           0x0600, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPIT2,              "lpit2_root",           0x0680, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPTMR1,             "lptmr1_root",          0x0700, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPTMR2,             "lptmr2_root",          0x0780, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_TPM1,               "tpm1_root",            0x0800, T=
PM_SEL, },
> +       { IMX93_CLK_TPM2,               "tpm2_root",            0x0880, T=
PM_SEL, },
> +       { IMX93_CLK_TPM3,               "tpm3_root",            0x0900, T=
PM_SEL, },
> +       { IMX93_CLK_TPM4,               "tpm4_root",            0x0980, T=
PM_SEL, },
> +       { IMX93_CLK_TPM5,               "tpm5_root",            0x0a00, T=
PM_SEL, },
> +       { IMX93_CLK_TPM6,               "tpm6_root",            0x0a80, T=
PM_SEL, },
> +       { IMX93_CLK_FLEXSPI1,           "flexspi1_root",        0x0b00, F=
AST_SEL, },
> +       { IMX93_CLK_CAN1,               "can1_root",            0x0b80, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_CAN2,               "can2_root",            0x0c00, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPUART1,            "lpuart1_root",         0x0c80, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPUART2,            "lpuart2_root",         0x0d00, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPUART3,            "lpuart3_root",         0x0d80, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPUART4,            "lpuart4_root",         0x0e00, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPUART5,            "lpuart5_root",         0x0e80, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPUART6,            "lpuart6_root",         0x0f00, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPUART7,            "lpuart7_root",         0x0f80, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPUART8,            "lpuart8_root",         0x1000, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPI2C1,             "lpi2c1_root",          0x1080, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPI2C2,             "lpi2c2_root",          0x1100, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPI2C3,             "lpi2c3_root",          0x1180, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPI2C4,             "lpi2c4_root",          0x1200, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPI2C5,             "lpi2c5_root",          0x1280, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPI2C6,             "lpi2c6_root",          0x1300, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPI2C7,             "lpi2c7_root",          0x1380, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPI2C8,             "lpi2c8_root",          0x1400, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPSPI1,             "lpspi1_root",          0x1480, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPSPI2,             "lpspi2_root",          0x1500, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPSPI3,             "lpspi3_root",          0x1580, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPSPI4,             "lpspi4_root",          0x1600, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPSPI5,             "lpspi5_root",          0x1680, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPSPI6,             "lpspi6_root",          0x1700, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPSPI7,             "lpspi7_root",          0x1780, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_LPSPI8,             "lpspi8_root",          0x1800, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_I3C1,               "i3c1_root",            0x1880, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_I3C2,               "i3c2_root",            0x1900, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_USDHC1,             "usdhc1_root",          0x1980, F=
AST_SEL, },
> +       { IMX93_CLK_USDHC2,             "usdhc2_root",          0x1a00, F=
AST_SEL, },
> +       { IMX93_CLK_USDHC3,             "usdhc3_root",          0x1a80, F=
AST_SEL, },
> +       { IMX93_CLK_SAI1,               "sai1_root",            0x1b00, A=
UDIO_SEL, },
> +       { IMX93_CLK_SAI2,               "sai2_root",            0x1b80, A=
UDIO_SEL, },
> +       { IMX93_CLK_SAI3,               "sai3_root",            0x1c00, A=
UDIO_SEL, },
> +       { IMX93_CLK_CCM_CKO1,           "ccm_cko1_root",        0x1c80, C=
KO1_SEL, },
> +       { IMX93_CLK_CCM_CKO2,           "ccm_cko2_root",        0x1d00, C=
KO2_SEL, },
> +       { IMX93_CLK_CCM_CKO3,           "ccm_cko3_root",        0x1d80, C=
KO1_SEL, },
> +       { IMX93_CLK_CCM_CKO4,           "ccm_cko4_root",        0x1e00, C=
KO2_SEL, },
> +       { IMX93_CLK_HSIO,               "hsio_root",            0x1e80, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_HSIO_USB_TEST_60M,  "hsio_usb_test_60m_root", 0x1f00,=
 LOW_SPEED_IO_SEL, },
> +       { IMX93_CLK_HSIO_ACSCAN_80M,    "hsio_acscan_80m_root", 0x1f80, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_HSIO_ACSCAN_480M,   "hsio_acscan_480m_root", 0x2000, =
MISC_SEL, },
> +       { IMX93_CLK_ML_APB,             "ml_apb_root",          0x2180, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_ML,                 "ml_root",              0x2200, F=
AST_SEL, },
> +       { IMX93_CLK_MEDIA_AXI,          "media_axi_root",       0x2280, F=
AST_SEL, },
> +       { IMX93_CLK_MEDIA_APB,          "media_apb_root",       0x2300, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_MEDIA_LDB,          "media_ldb_root",       0x2380, V=
IDEO_SEL, },
> +       { IMX93_CLK_MEDIA_DISP_PIX,     "media_disp_pix_root",  0x2400, V=
IDEO_SEL, },
> +       { IMX93_CLK_CAM_PIX,            "cam_pix_root",         0x2480, V=
IDEO_SEL, },
> +       { IMX93_CLK_MIPI_TEST_BYTE,     "mipi_test_byte_root",  0x2500, V=
IDEO_SEL, },
> +       { IMX93_CLK_MIPI_PHY_CFG,       "mipi_phy_cfg_root",    0x2580, V=
IDEO_SEL, },
> +       { IMX93_CLK_ADC,                "adc_root",             0x2700, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_PDM,                "pdm_root",             0x2780, A=
UDIO_SEL, },
> +       { IMX93_CLK_TSTMR1,             "tstmr1_root",          0x2800, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_TSTMR2,             "tstmr2_root",          0x2880, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_MQS1,               "mqs1_root",            0x2900, A=
UDIO_SEL, },
> +       { IMX93_CLK_MQS2,               "mqs2_root",            0x2980, A=
UDIO_SEL, },
> +       { IMX93_CLK_AUDIO_XCVR,         "audio_xcvr_root",      0x2a00, N=
ON_IO_SEL, },
> +       { IMX93_CLK_SPDIF,              "spdif_root",           0x2a80, A=
UDIO_SEL, },
> +       { IMX93_CLK_ENET,               "enet_root",            0x2b00, N=
ON_IO_SEL, },
> +       { IMX93_CLK_ENET_TIMER1,        "enet_timer1_root",     0x2b80, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_ENET_TIMER2,        "enet_timer2_root",     0x2c00, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_ENET_REF,           "enet_ref_root",        0x2c80, N=
ON_IO_SEL, },
> +       { IMX93_CLK_ENET_REF_PHY,       "enet_ref_phy_root",    0x2d00, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_I3C1_SLOW,          "i3c1_slow_root",       0x2d80, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_I3C2_SLOW,          "i3c2_slow_root",       0x2e00, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_USB_PHY_BURUNIN,    "usb_phy_root",         0x2e80, L=
OW_SPEED_IO_SEL, },
> +       { IMX93_CLK_PAL_CAME_SCAN,      "pal_came_scan_root",   0x2f00, M=
ISC_SEL, }
> +};
> +
> +struct imx93_clk_ccgr {
> +       u32 clk;
> +       char *name;
> +       char *parent_name;
> +       u32 off;
> +       unsigned long flags;
> +} ccgr_array[] =3D {

static const?

> +       { IMX93_CLK_A55_GATE,           "a55",          "a55_root",      =
       0x8000, CLK_IS_CRITICAL },

Please add comments on why clks are critical.

> +       { IMX93_CLK_CM33_GATE,          "cm33",         "m33_root",      =
       0x8040, CLK_IS_CRITICAL },
> +       { IMX93_CLK_ADC1_GATE,          "adc1",         "osc_24m",       =
       0x82c0, },
> +       { IMX93_CLK_WDOG1_GATE,         "wdog1",        "osc_24m",       =
       0x8300, },
> +       { IMX93_CLK_WDOG2_GATE,         "wdog2",        "osc_24m",       =
       0x8340, },
> +       { IMX93_CLK_WDOG3_GATE,         "wdog3",        "osc_24m",       =
       0x8380, },
> +       { IMX93_CLK_WDOG4_GATE,         "wdog4",        "osc_24m",       =
       0x83c0, },
> +       { IMX93_CLK_WDOG5_GATE,         "wdog5",        "osc_24m",       =
       0x8400, },
> +       { IMX93_CLK_SEMA1_GATE,         "sema1",        "bus_aon_root",  =
       0x8440, },
> +       { IMX93_CLK_SEMA2_GATE,         "sema2",        "bus_wakeup_root"=
,      0x8480, },
> +       { IMX93_CLK_MU_A_GATE,          "mu_a",         "bus_aon_root",  =
       0x84c0, },
> +       { IMX93_CLK_MU_B_GATE,          "mu_b",         "bus_aon_root",  =
       0x8500, },
> +       { IMX93_CLK_EDMA1_GATE,         "edma1",        "wakeup_axi_root"=
,      0x8540, },
> +       { IMX93_CLK_EDMA2_GATE,         "edma2",        "wakeup_axi_root"=
,      0x8580, },
> +       { IMX93_CLK_FLEXSPI1_GATE,      "flexspi",      "flexspi_root",  =
       0x8640, },
> +       { IMX93_CLK_GPIO1_GATE,         "gpio1",        "m33_root",      =
       0x8880, },
> +       { IMX93_CLK_GPIO2_GATE,         "gpio2",        "bus_wakeup_root"=
,      0x88c0, },
> +       { IMX93_CLK_GPIO3_GATE,         "gpio3",        "bus_wakeup_root"=
,      0x8900, },
> +       { IMX93_CLK_GPIO4_GATE,         "gpio4",        "bus_wakeup_root"=
,      0x8940, },
> +       { IMX93_CLK_FLEXIO1_GATE,       "flexio1",      "flexio1_root",  =
       0x8980, },
> +       { IMX93_CLK_FLEXIO2_GATE,       "flexio2",      "flexio2_root",  =
       0x89c0, },
> +       { IMX93_CLK_LPIT1_GATE,         "lpit1",        "lpit1_root",    =
       0x8a00, },
> +       { IMX93_CLK_LPIT2_GATE,         "lpit2",        "lpit2_root",    =
       0x8a40, },
> +       { IMX93_CLK_LPTMR1_GATE,        "lptmr1",       "lptmr1_root",   =
       0x8a80, },
> +       { IMX93_CLK_LPTMR2_GATE,        "lptmr2",       "lptmr2_root",   =
       0x8ac0, },
> +       { IMX93_CLK_TPM1_GATE,          "tpm1",         "tpm1_root",     =
       0x8b00, },
> +       { IMX93_CLK_TPM2_GATE,          "tpm2",         "tpm2_root",     =
       0x8b40, },
> +       { IMX93_CLK_TPM3_GATE,          "tpm3",         "tpm3_root",     =
       0x8b80, },
> +       { IMX93_CLK_TPM4_GATE,          "tpm4",         "tpm4_root",     =
       0x8bc0, },
> +       { IMX93_CLK_TPM5_GATE,          "tpm5",         "tpm5_root",     =
       0x8c00, },
> +       { IMX93_CLK_TPM6_GATE,          "tpm6",         "tpm6_root",     =
       0x8c40, },
> +       { IMX93_CLK_CAN1_GATE,          "can1",         "can1_root",     =
       0x8c80, },
> +       { IMX93_CLK_CAN2_GATE,          "can2",         "can2_root",     =
       0x8cc0, },
> +       { IMX93_CLK_LPUART1_GATE,       "lpuart1",      "lpuart1_root",  =
       0x8d00, },
> +       { IMX93_CLK_LPUART2_GATE,       "lpuart2",      "lpuart2_root",  =
       0x8d40, },
> +       { IMX93_CLK_LPUART3_GATE,       "lpuart3",      "lpuart3_root",  =
       0x8d80, },
> +       { IMX93_CLK_LPUART4_GATE,       "lpuart4",      "lpuart4_root",  =
       0x8dc0, },
> +       { IMX93_CLK_LPUART5_GATE,       "lpuart5",      "lpuart5_root",  =
       0x8e00, },
> +       { IMX93_CLK_LPUART6_GATE,       "lpuart6",      "lpuart6_root",  =
       0x8e40, },
> +       { IMX93_CLK_LPUART7_GATE,       "lpuart7",      "lpuart7_root",  =
       0x8e80, },
> +       { IMX93_CLK_LPUART8_GATE,       "lpuart8",      "lpuart8_root",  =
       0x8ec0, },
> +       { IMX93_CLK_LPI2C1_GATE,        "lpi2c1",       "lpi2c1_root",   =
       0x8f00, },
> +       { IMX93_CLK_LPI2C2_GATE,        "lpi2c2",       "lpi2c2_root",   =
       0x8f40, },
> +       { IMX93_CLK_LPI2C3_GATE,        "lpi2c3",       "lpi2c3_root",   =
       0x8f80, },
> +       { IMX93_CLK_LPI2C4_GATE,        "lpi2c4",       "lpi2c4_root",   =
       0x8fc0, },
> +       { IMX93_CLK_LPI2C5_GATE,        "lpi2c5",       "lpi2c5_root",   =
       0x9000, },
> +       { IMX93_CLK_LPI2C6_GATE,        "lpi2c6",       "lpi2c6_root",   =
       0x9040, },
> +       { IMX93_CLK_LPI2C7_GATE,        "lpi2c7",       "lpi2c7_root",   =
       0x9080, },
> +       { IMX93_CLK_LPI2C8_GATE,        "lpi2c8",       "lpi2c8_root",   =
       0x90c0, },
> +       { IMX93_CLK_LPSPI1_GATE,        "lpspi1",       "lpspi1_root",   =
       0x9100, },
> +       { IMX93_CLK_LPSPI2_GATE,        "lpspi2",       "lpspi2_root",   =
       0x9140, },
> +       { IMX93_CLK_LPSPI3_GATE,        "lpspi3",       "lpspi3_root",   =
       0x9180, },
> +       { IMX93_CLK_LPSPI4_GATE,        "lpspi4",       "lpspi4_root",   =
       0x91c0, },
> +       { IMX93_CLK_LPSPI5_GATE,        "lpspi5",       "lpspi5_root",   =
       0x9200, },
> +       { IMX93_CLK_LPSPI6_GATE,        "lpspi6",       "lpspi6_root",   =
       0x9240, },
> +       { IMX93_CLK_LPSPI7_GATE,        "lpspi7",       "lpspi7_root",   =
       0x9280, },
> +       { IMX93_CLK_LPSPI8_GATE,        "lpspi8",       "lpspi8_root",   =
       0x92c0, },
> +       { IMX93_CLK_I3C1_GATE,          "i3c1",         "i3c1_root",     =
       0x9300, },
> +       { IMX93_CLK_I3C2_GATE,          "i3c2",         "i3c2_root",     =
       0x9340, },
> +       { IMX93_CLK_USDHC1_GATE,        "usdhc1",       "usdhc1_root",   =
       0x9380, },
> +       { IMX93_CLK_USDHC2_GATE,        "usdhc2",       "usdhc2_root",   =
       0x93c0, },
> +       { IMX93_CLK_USDHC3_GATE,        "usdhc3",       "usdhc3_root",   =
       0x9400, },
> +       { IMX93_CLK_SAI1_GATE,          "sai1",         "sai1_root",     =
       0x9440, },
> +       { IMX93_CLK_SAI2_GATE,          "sai2",         "sai2_root",     =
       0x9480, },
> +       { IMX93_CLK_SAI3_GATE,          "sai3",         "sai3_root",     =
       0x94c0, },
> +       { IMX93_CLK_MIPI_CSI_GATE,      "mipi_csi",     "media_apb_root",=
       0x9580, },
> +       { IMX93_CLK_MIPI_DSI_GATE,      "mipi_dsi",     "media_apb_root",=
       0x95c0, },
> +       { IMX93_CLK_LVDS_GATE,          "lvds",         "media_ldb_root",=
       0x9600, },
> +       { IMX93_CLK_LCDIF_GATE,         "lcdif",        "media_apb_root",=
       0x9640, },
> +       { IMX93_CLK_PXP_GATE,           "pxp",          "media_apb_root",=
       0x9680, },
> +       { IMX93_CLK_ISI_GATE,           "isi",          "media_apb_root",=
       0x96c0, },
> +       { IMX93_CLK_NIC_MEDIA_GATE,     "nic_media",    "media_apb_root",=
       0x9700, },
> +       { IMX93_CLK_USB_CONTROLLER_GATE, "usb_controller", "hsio_root",  =
       0x9a00, },
> +       { IMX93_CLK_USB_TEST_60M_GATE,  "usb_test_60m", "hsio_usb_test_60=
m_root", 0x9a40, },
> +       { IMX93_CLK_HSIO_TROUT_24M_GATE, "hsio_trout_24m", "osc_24m",    =
       0x9a80, },
> +       { IMX93_CLK_PDM_GATE,           "pdm",          "pdm_root",      =
       0x9ac0, },
> +       { IMX93_CLK_MQS1_GATE,          "mqs1",         "sai1_root",     =
       0x9b00, },
> +       { IMX93_CLK_MQS2_GATE,          "mqs2",         "sai3_root",     =
       0x9b40, },
> +       { IMX93_CLK_AUD_XCVR_GATE,      "aud_xcvr",     "audio_xcvr_root"=
,      0x9b80, },
> +       { IMX93_CLK_SPDIF_GATE,         "spdif",        "spdif_root",    =
       0x9c00, },
> +       { IMX93_CLK_HSIO_32K_GATE,      "hsio_32k",     "osc_32k",       =
       0x9dc0, },
> +       { IMX93_CLK_ENET1_GATE,         "enet1",        "enet_root",     =
       0x9e00, },
> +       { IMX93_CLK_ENET_QOS_GATE,      "enet_qos",     "wakeup_axi_root"=
,      0x9e40, },
> +       { IMX93_CLK_SYS_CNT_GATE,       "sys_cnt",      "osc_24m",       =
       0x9e80, },
> +       { IMX93_CLK_TSTMR1_GATE,        "tstmr1",       "bus_aon_root",  =
       0x9ec0, },
> +       { IMX93_CLK_TSTMR2_GATE,        "tstmr2",       "bus_wakeup_root"=
,      0x9f00, },
> +       { IMX93_CLK_TMC_GATE,           "tmc",          "osc_24m",       =
       0x9f40, },
> +       { IMX93_CLK_PMRO_GATE,          "pmro",         "osc_24m",       =
       0x9f80, }
> +};
> +
> +static struct clk_hw_onecell_data *clk_hw_data;
> +static struct clk_hw **clks;
> +
> +static int imx93_clocks_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *np =3D dev->of_node;
> +       struct imx93_clk_root *root;
> +       struct imx93_clk_ccgr *ccgr;
> +       void __iomem *base =3D NULL;
> +       int i, ret;
> +
> +       clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws,
> +                                         IMX93_CLK_END), GFP_KERNEL);
> +       if (WARN_ON(!clk_hw_data))

Drop WARN_ON() as allocation already prints a stacktrace on failure.

> +               return -ENOMEM;
> +
> +       clk_hw_data->num =3D IMX93_CLK_END;
> +       clks =3D clk_hw_data->hws;
> +
> +       clks[IMX93_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
> +       clks[IMX93_CLK_24M] =3D imx_obtain_fixed_clk_hw(np, "osc_24m");
> +       clks[IMX93_CLK_32K] =3D imx_obtain_fixed_clk_hw(np, "osc_32k");
> +       clks[IMX93_CLK_EXT1] =3D imx_obtain_fixed_clk_hw(np, "clk_ext1");
> +
> +       clks[IMX93_CLK_SYS_PLL_PFD0] =3D imx_clk_hw_fixed("sys_pll_pfd0",=
 1000000000);
> +       clks[IMX93_CLK_SYS_PLL_PFD0_DIV2] =3D imx_clk_hw_fixed_factor("sy=
s_pll_pfd0_div2",
> +                                                                   "sys_=
pll_pfd0", 1, 2);
> +       clks[IMX93_CLK_SYS_PLL_PFD1] =3D imx_clk_hw_fixed("sys_pll_pfd1",=
 800000000);
> +       clks[IMX93_CLK_SYS_PLL_PFD1_DIV2] =3D imx_clk_hw_fixed_factor("sy=
s_pll_pfd1_div2",
