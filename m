Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5817524E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354192AbiELNVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354183AbiELNVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:21:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3983506F7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:21:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v10so4559811pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4aQRSxerZIfxG75Us/8UUQ0iqFXnrxh04bqlSeNWSLY=;
        b=IW2hTvHv1ornPaWs/asOavYfPGh3aS+PUX88/ZdhRZDMLMqshfnOIRyKUvRCCDs1XM
         qXCMMVCR59IvJbT8ZjbP0dxO4VlwnEi8t77fh/0oMrbW/5UfGDDRTzvgvV1prWK1iuNE
         qbngcanQky/AMov43+2ze9brDGfUUgW1OXOZFvSvKMod4jPOzz3Mpa0jAIdA0sfZgLS8
         /NQ0YGyYLv1N5YR6qQoz9OvPNMZKrxjkn8mROXnQYa79P+e/c9m9AIyhHCK8jvojCcgR
         VWtEyQvZE673bHkSeTXWPv05X+f6IbP1V7CnhnSZM66AxXItpKgcoTkmZDbD9Rzo4xi7
         sRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4aQRSxerZIfxG75Us/8UUQ0iqFXnrxh04bqlSeNWSLY=;
        b=ttloDoSHbXlHQE8SKvJCrjQrLF+s3MdEtjPZWyzevgNIxYDPcgJaRCy/MDLJHgGQ8Q
         Eixsrwi9tlWrgg6zMTJEgyIKbMi0oL4K7VgJ8PJv52LtefMijhM+lngfkoSlPVDCCU/h
         KTzEGOsiqBgeNy3/0ErqfI4qMMnE64/2d4mpMGGtLt3EJsxD2jdCxHzwUjRkvdn9Awk9
         Z3sEEVrm24fldYyjtYCptOYGeJYP8uhGObHvS+eoKFOq4dl/Gu/DKt39IkTMuvEk+VH+
         HrYJ+f/fM3DLFoB34COAfXt9hYneyfQR0KJNflMscXvyBbaeIJ6EfBO5M7CkI6Pp2oOm
         /sEw==
X-Gm-Message-State: AOAM53272feJv6CScZ0kw1LkktVsgWnHck8EpJxwKBxQsmtnGKLJNuYE
        pjJbBq/cte9HbIGPFTWyeiTBZ6u2xau3aKYhzcyoFA==
X-Google-Smtp-Source: ABdhPJyZOET1EER9C9AZQaqJy8BQlI2AbD8N1VzLJbA77Z/dnnf5unDxOdy+QeXxPtAgZWu9NdemKM/OpYLVX4OA/B8=
X-Received: by 2002:aa7:9110:0:b0:4fa:e388:af57 with SMTP id
 16-20020aa79110000000b004fae388af57mr29932676pfh.1.1652361693176; Thu, 12 May
 2022 06:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220504122725.179262-1-robert.foss@linaro.org>
 <20220504122725.179262-5-robert.foss@linaro.org> <600d13cc-962a-bb6c-6e43-c56fd63b9591@somainline.org>
In-Reply-To: <600d13cc-962a-bb6c-6e43-c56fd63b9591@somainline.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 12 May 2022 15:21:22 +0200
Message-ID: <CAG3jFysb-ZVr+9jroGs3ibjs9ysOChEz6HqR5NqHj3LvEiFN9Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] clk: qcom: add support for SM8350 DISPCC
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

On Wed, 4 May 2022 at 18:23, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>
>
> On 04/05/2022 14:27, Robert Foss wrote:
> > From: Jonathan Marek <jonathan@marek.ca>
> >
> > Add support to the SM8350 display clock controller by extending the SM8250
> > display clock controller, which is almost identical but has some minor
> > differences.
> >
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >
> > Changes since v1
> >   - Remove comment - Dmitry
> >
> > Changes since v2
> >   - Add my SoB - Bjorn
> >   - Remove CLK_ASSUME_ENABLED_WHEN_UNUSED flag
> >
> >
> >   drivers/clk/qcom/Kconfig         |  4 +--
> >   drivers/clk/qcom/dispcc-sm8250.c | 60 +++++++++++++++++++++++++++++++-
> >   2 files changed, 61 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> > index 9b1f54e634b9..1752ca0ee405 100644
> > --- a/drivers/clk/qcom/Kconfig
> > +++ b/drivers/clk/qcom/Kconfig
> > @@ -609,11 +609,11 @@ config SM_DISPCC_6125
> >         splash screen
> >
> >   config SM_DISPCC_8250
> > -     tristate "SM8150 and SM8250 Display Clock Controller"
> > +     tristate "SM8150/SM8250/SM8350 Display Clock Controller"
> >       depends on SM_GCC_8150 || SM_GCC_8250
>
> || SM_GCC_8350?

Will fix in v4.

>
> sidenote: also || SC_GCC_8180X in a separate patch?

I haven't been involved in the 8180X work, and am a little bit
hesitant to include any changes related to it in this series.

>
> >       help
> >         Support for the display clock controller on Qualcomm Technologies, Inc
> > -       SM8150 and SM8250 devices.
> > +       SM8150/SM8250/SM8350 devices.
> >         Say Y if you want to support display devices and functionality such as
> >         splash screen.
> >
> > diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
> > index db9379634fb2..8e6cb990e387 100644
> > --- a/drivers/clk/qcom/dispcc-sm8250.c
> > +++ b/drivers/clk/qcom/dispcc-sm8250.c
> > @@ -43,6 +43,10 @@ static struct pll_vco vco_table[] = {
> >       { 249600000, 2000000000, 0 },
> >   };
> >
> > +static struct pll_vco lucid_5lpe_vco[] = {
> > +     { 249600000, 1750000000, 0 },
> > +};
> > +
> >   static struct alpha_pll_config disp_cc_pll0_config = {
> >       .l = 0x47,
> >       .alpha = 0xE000,
> > @@ -1228,6 +1232,7 @@ static const struct of_device_id disp_cc_sm8250_match_table[] = {
> >       { .compatible = "qcom,sc8180x-dispcc" },
> >       { .compatible = "qcom,sm8150-dispcc" },
> >       { .compatible = "qcom,sm8250-dispcc" },
> > +     { .compatible = "qcom,sm8350-dispcc" },
> >       { }
> >   };
> >   MODULE_DEVICE_TABLE(of, disp_cc_sm8250_match_table);
> > @@ -1258,7 +1263,7 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
> >               return PTR_ERR(regmap);
> >       }
> >
> > -     /* note: trion == lucid, except for the prepare() op */
> > +     /* Apply differences for SM8150 and SM8350 */
> >       BUILD_BUG_ON(CLK_ALPHA_PLL_TYPE_TRION != CLK_ALPHA_PLL_TYPE_LUCID);
> >       if (of_device_is_compatible(pdev->dev.of_node, "qcom,sc8180x-dispcc") ||
> >           of_device_is_compatible(pdev->dev.of_node, "qcom,sm8150-dispcc")) {
> > @@ -1270,6 +1275,59 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
> >               disp_cc_pll1_config.config_ctl_hi1_val = 0x00000024;
> >               disp_cc_pll1_config.user_ctl_hi1_val = 0x000000D0;
> >               disp_cc_pll1_init.ops = &clk_alpha_pll_trion_ops;
> > +     } else if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8350-dispcc")) {
> > +             static struct clk_rcg2 * const rcgs[] = {
> > +                     &disp_cc_mdss_byte0_clk_src,
> > +                     &disp_cc_mdss_byte1_clk_src,
> > +                     &disp_cc_mdss_dp_aux1_clk_src,
> > +                     &disp_cc_mdss_dp_aux_clk_src,
> > +                     &disp_cc_mdss_dp_link1_clk_src,
> > +                     &disp_cc_mdss_dp_link_clk_src,
> > +                     &disp_cc_mdss_dp_pixel1_clk_src,
> > +                     &disp_cc_mdss_dp_pixel2_clk_src,
> > +                     &disp_cc_mdss_dp_pixel_clk_src,
> > +                     &disp_cc_mdss_esc0_clk_src,
> > +                     &disp_cc_mdss_mdp_clk_src,
> > +                     &disp_cc_mdss_pclk0_clk_src,
> > +                     &disp_cc_mdss_pclk1_clk_src,
> > +                     &disp_cc_mdss_rot_clk_src,
> > +                     &disp_cc_mdss_vsync_clk_src,
> > +             };
> > +             static struct clk_regmap_div * const divs[] = {
> > +                     &disp_cc_mdss_byte0_div_clk_src,
> > +                     &disp_cc_mdss_byte1_div_clk_src,
> > +                     &disp_cc_mdss_dp_link1_div_clk_src,
> > +                     &disp_cc_mdss_dp_link_div_clk_src,
> > +             };
> > +             unsigned int i;
> > +             static bool offset_applied;
> > +
> > +             /* only apply the offsets once (in case of deferred probe) */
> > +             if (!offset_applied) {
> > +                     for (i = 0; i < ARRAY_SIZE(rcgs); i++)
> > +                             rcgs[i]->cmd_rcgr -= 4;
> > +
> > +                     for (i = 0; i < ARRAY_SIZE(divs); i++) {
> > +                             divs[i]->reg -= 4;
> > +                             divs[i]->width = 4;
> > +                     }
> > +
> > +                     disp_cc_mdss_ahb_clk.halt_reg -= 4;
> > +                     disp_cc_mdss_ahb_clk.clkr.enable_reg -= 4;
> > +
> > +                     offset_applied = true;
> > +             }
> > +
> > +             disp_cc_mdss_ahb_clk_src.cmd_rcgr = 0x22a0;
> > +
> > +             disp_cc_pll0_config.config_ctl_hi1_val = 0x2A9A699C;
>
> Lowercase hex, also below.

Ack.

>
>
> > +             disp_cc_pll0_config.test_ctl_hi1_val = 0x01800000;
> > +             disp_cc_pll0_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
> > +             disp_cc_pll0.vco_table = lucid_5lpe_vco;
> > +             disp_cc_pll1_config.config_ctl_hi1_val = 0x2A9A699C;
> > +             disp_cc_pll1_config.test_ctl_hi1_val = 0x01800000;
> > +             disp_cc_pll1_init.ops = &clk_alpha_pll_lucid_5lpe_ops;
> > +             disp_cc_pll1.vco_table = lucid_5lpe_vco;
> >       }
> >
> >       clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
> Konrad
> >
