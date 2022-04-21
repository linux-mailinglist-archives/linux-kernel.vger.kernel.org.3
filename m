Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5644450986C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiDUG5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385453AbiDUG5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:57:01 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C997E6156
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:53:24 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2edbd522c21so41818557b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxxyCE6218CsP33ncCT/QjJmGyzhJs4lIXEcCs7Cp7E=;
        b=NtyTmm73BO2ZpdykD4mRz6MZYwBQaD//bYiwl1WzFNjs/yuG3viWAA5tnQ3+Np0V7l
         9WJLbq1ASUtwB+n3y06WniFE8c5Q/NVHtWLHM/GRWczXMTFwtr1ZtGUPLoVIShUqOy4R
         wjEB14EJIEVodi7+Q2nUKIr/n1UDFi2JG+ekw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxxyCE6218CsP33ncCT/QjJmGyzhJs4lIXEcCs7Cp7E=;
        b=Ym83WWfGJyddZ/ci+0MGlZCObc/Yhap2FYOlzlUEFzvYuQmiPLdjPUknYG1vWdynwb
         zkd5MHquARlhNN8al2cL2My+31z2JO5+4QC7a3F7gKLMK5+BVGxNpMYBhcn6HOAr7ils
         +n00wrqbyKl8NS1hpcvg/MKuB2W5n0uMNoZ5+YCxNAApz+XFGSFrJz9mmZQNnfwAAi2u
         NWJMFwaO+/x3MGPbuLisVFrGBPPeQfYrVhxSQx6JVZFkG/6HQfPS5no+KlFdf+z2hajW
         nvomFRwZuSSxEWeadcjJQTVvI/k5lCmZrlbP6PcnrKNqmIYGFsmNDNsV4FLR8D1LuKD5
         38cQ==
X-Gm-Message-State: AOAM531lsaTqufj2K3d28jP5WMvO7jnygJRmuq9luf10AZfM9eiEfd81
        MEzgabr39JmXWqUqO+SLTOtucH64uY4YL078s3u08g==
X-Google-Smtp-Source: ABdhPJzVfB7TYnUrWb3CObQ/ODXX6LZUZjYXGH+wB1eh9ocMpbmW/G3DUs7pecxGAlW308Nn1wwuqQuNoV0zmu7lPZc=
X-Received: by 2002:a0d:eb46:0:b0:2ef:4946:544 with SMTP id
 u67-20020a0deb46000000b002ef49460544mr24654407ywe.286.1650524004092; Wed, 20
 Apr 2022 23:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com> <20220420130527.23200-12-rex-bc.chen@mediatek.com>
In-Reply-To: <20220420130527.23200-12-rex-bc.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 21 Apr 2022 14:53:13 +0800
Message-ID: <CAGXv+5HMe7LaXiMJofW4ZT0Ku70mNAt2A=98YzZbx-frF7kQGQ@mail.gmail.com>
Subject: Re: [PATCH V2 11/12] clk: mediatek: reset: Add infra_ao reset support
 for MT8192
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, allen-kh.cheng@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 9:05 PM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>
> The infra_ao reset is needed for MT8192. Therefore, we add this patch
> to support it.
>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt8192.c         | 11 +++++++++++
>  include/dt-bindings/reset/mt8192-resets.h | 11 +++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
> index ab27cd66b866..7926b83b9035 100644
> --- a/drivers/clk/mediatek/clk-mt8192.c
> +++ b/drivers/clk/mediatek/clk-mt8192.c
> @@ -1114,6 +1114,13 @@ static const struct mtk_gate top_clks[] = {
>         GATE_TOP(CLK_TOP_SSUSB_PHY_REF, "ssusb_phy_ref", "clk26m", 25),
>  };
>
> +static const struct mtk_clk_rst_desc clk_rst_desc = {
> +       .version = MTK_RST_SET_CLR,
> +       .reg_num = 4,
> +       .reg_ofs = 0x0,
> +       .reset_n_cells = 2,

If you want to do this, you need to update the bindings first.

> +};
> +
>  #define MT8192_PLL_FMAX                (3800UL * MHZ)
>  #define MT8192_PLL_FMIN                (1500UL * MHZ)
>  #define MT8192_INTEGER_BITS    8
> @@ -1239,6 +1246,10 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
>         if (r)
>                 goto free_clk_data;
>
> +       r = mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc);
> +       if (r)
> +               goto free_clk_data;
> +
>         r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>         if (r)
>                 goto free_clk_data;
> diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-bindings/reset/mt8192-resets.h
> index be9a7ca245b9..feac1ac85906 100644
> --- a/include/dt-bindings/reset/mt8192-resets.h
> +++ b/include/dt-bindings/reset/mt8192-resets.h
> @@ -7,6 +7,7 @@
>  #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8192
>  #define _DT_BINDINGS_RESET_CONTROLLER_MT8192
>
> +/* TOPRGU */
>  #define MT8192_TOPRGU_MM_SW_RST                                        1
>  #define MT8192_TOPRGU_MFG_SW_RST                               2
>  #define MT8192_TOPRGU_VENC_SW_RST                              3
> @@ -27,4 +28,14 @@
>
>  #define MT8192_TOPRGU_SW_RST_NUM                               23
>
> +/* INFRA RST0 */
> +#define MT8192_INFRA_RST0_LVTS_AP_RST                          0
> +/* INFRA RST2 */
> +#define MT8192_INFRA_RST2_PCIE_PHY_RST                         15
> +/* INFRA RST3 */
> +#define MT8192_INFRA_RST3_PTP_RST                              5
> +/* INFRA RST4 */
> +#define MT8192_INFRA_RST4_LVTS_MCU                             12
> +#define MT8192_INFRA_RST4_PCIE_TOP                             1
> +

This change should be part of the binding change.

For these, please also add a patch for the actual device tree changes.


ChenYu

>  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */
> --
> 2.18.0
>
