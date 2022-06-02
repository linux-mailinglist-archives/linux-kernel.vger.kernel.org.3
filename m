Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA23B53B324
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiFBFtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiFBFtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:49:04 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87544262D42
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:48:59 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id wdhSn51g6QKuawdhSnS6n8; Thu, 02 Jun 2022 07:48:57 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 02 Jun 2022 07:48:57 +0200
X-ME-IP: 90.11.190.129
Message-ID: <60d33448-1cc9-c662-167b-10c1f9660545@wanadoo.fr>
Date:   Thu, 2 Jun 2022 07:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v10 14/21] drm/mediatek: dpi: Add dpintf support
Content-Language: fr
To:     granquet@baylibre.com
Cc:     airlied@linux.ie, chunfeng.yun@mediatek.com,
        chunkuang.hu@kernel.org, ck.hu@mediatek.com, daniel@ffwll.ch,
        deller@gmx.de, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jitao.shi@mediatek.com,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, maarten.lankhorst@linux.intel.com,
        matthias.bgg@gmail.com, mripard@kernel.org, msp@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, tzimmermann@suse.de,
        vkoul@kernel.org
References: <20220523104758.29531-1-granquet@baylibre.com>
 <20220523104758.29531-15-granquet@baylibre.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220523104758.29531-15-granquet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/05/2022 à 12:47, Guillaume Ranquet a écrit :
> dpintf is the displayport interface hardware unit. This unit is similar
> to dpi and can reuse most of the code.
> 
> This patch adds support for mt8195-dpintf to this dpi driver. Main
> differences are:
>   - Some features/functional components are not available for dpintf
>     which are now excluded from code execution once is_dpintf is set
>   - dpintf can and needs to choose between different clockdividers based
>     on the clockspeed. This is done by choosing a different clock parent.
>   - There are two additional clocks that need to be managed. These are
>     only set for dpintf and will be set to NULL if not supplied. The
>     clk_* calls handle these as normal clocks then.
>   - Some register contents differ slightly between the two components. To
>     work around this I added register bits/masks with a DPINTF_ prefix
>     and use them where different.
> 
> Based on a separate driver for dpintf created by
> Jason-JH.Lin <jason-jh.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Guillaume Ranquet <granquet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>   drivers/gpu/drm/mediatek/mtk_dpi.c          | 126 +++++++++++++++++---
>   drivers/gpu/drm/mediatek/mtk_dpi_regs.h     |  35 ++++++
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   8 ++
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   1 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   5 +-
>   include/linux/soc/mediatek/mtk-mmsys.h      |   4 +-
>   6 files changed, 159 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index eb969c5c5c2e..763bfb700135 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -71,6 +71,7 @@ struct mtk_dpi {
>   	void __iomem *regs;
>   	struct device *dev;
>   	struct clk *engine_clk;
> +	struct clk *dpi_ck_cg;
>   	struct clk *pixel_clk;
>   	struct clk *tvd_clk;
>   	int irq;
> @@ -126,6 +127,7 @@ struct mtk_dpi_conf {
>   	const u32 *output_fmts;
>   	u32 num_output_fmts;
>   	bool is_ck_de_pol;
> +	bool is_dpintf;
>   	bool swap_input_support;
>   	/* Mask used for HWIDTH, HPORCH, VSYNC_WIDTH and VSYNC_PORCH (no shift) */
>   	u32 dimension_mask;
> @@ -438,6 +440,8 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
>   	mtk_dpi_disable(dpi);
>   	clk_disable_unprepare(dpi->pixel_clk);
>   	clk_disable_unprepare(dpi->engine_clk);
> +	clk_disable_unprepare(dpi->dpi_ck_cg);
> +	clk_disable_unprepare(dpi->tvd_clk);
>   }
>   
>   static int mtk_dpi_power_on(struct mtk_dpi *dpi)
> @@ -447,12 +451,24 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>   	if (++dpi->refcount != 1)
>   		return 0;
>   

Hi,

belwo the error handling path looks odd. (both where we goto, and the 
order of the clk_disable_unprepare() in the error handling path.

just my 2c,

CJ

> +	ret = clk_prepare_enable(dpi->tvd_clk);
> +	if (ret) {
> +		dev_err(dpi->dev, "Failed to enable tvd pll: %d\n", ret);
> +		goto err_pixel;
> +	}
> +
>   	ret = clk_prepare_enable(dpi->engine_clk);
>   	if (ret) {
>   		dev_err(dpi->dev, "Failed to enable engine clock: %d\n", ret);
>   		goto err_refcount;
>   	}
>   
> +	ret = clk_prepare_enable(dpi->dpi_ck_cg);
> +	if (ret) {
> +		dev_err(dpi->dev, "Failed to enable dpi_ck_cg clock: %d\n", ret);
> +		goto err_ck_cg;
> +	}
> +
>   	ret = clk_prepare_enable(dpi->pixel_clk);
>   	if (ret) {
>   		dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", ret);
> @@ -466,6 +482,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>   	return 0;
>   
>   err_pixel:
> +	clk_disable_unprepare(dpi->dpi_ck_cg);
> +err_ck_cg:
>   	clk_disable_unprepare(dpi->engine_clk);
>   err_refcount:
>   	dpi->refcount--;

[...]
