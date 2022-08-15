Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD0C592ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiHOH6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiHOH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:58:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68571DA73
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:58:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z12so8160480wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=4LHTOGZsFNehN7nMM3hFYDsNPkYY0DIUJCRTeMZ3RtQ=;
        b=qL3ecjHfsDCQmiIjDc5/oL+z+SJNdLWzHZNHyjSi/211iOUz10Fyt0nf2RgsXYAbF7
         40MLmWPqWN/2OtJrfMfucccnZIDsDAfLcAUlhi5Py76A/ukWhCJUfx8uMRHnXIRIaGPR
         OVvgkEOQErsJOP11nIL5ufk4XDxvyOqXRsDK2H4bt+k8toyqzRTMdovE3WWyYetP0+W7
         J1spod2ijPUeon/4aCBYqIMwebZyVOCjpIRcgRyNClksaDoc0qltD62JItV/1jJQb2YI
         7WpOpS+NsBWS5CnW6/tA579ICLmBz/VNSoFQ+uK7bsoceDDMKqdl05RC4T04RIcWqYf5
         kCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4LHTOGZsFNehN7nMM3hFYDsNPkYY0DIUJCRTeMZ3RtQ=;
        b=3XJsZMuz9ROIqMeL4GqglJAy+QHcug1ytBY4cTiXMw9pRWJvP7pt2Q9bIzWJWmcnkE
         +y/XxQttQd3M/N3aikmRCeqcZTv/sjhlLfHe73qLHTWZ512cScjp2M3dpd7xX1G11Kwd
         9Jcy9cMaX/Tt3sMROwg+InusAAEsFRZHBSHefjfHsstqoG1rBOx4Bqn5WxruR9x1j2DT
         iurqpPPo2H0WSbau8NnmUF8Q4FJevrKQm9X93rkyIxjGSxvVJsU2GQMhPgI1pBsijsk2
         i05luKbDThYpAIXxIYxNsNaOn33+mFnDTiPA8tr4LgutqNtUkTfqfJiR6V8/9v5YeHgg
         1wqw==
X-Gm-Message-State: ACgBeo0JeKlGrzAfBbyPYRe/R01sMYGhIsTdN/48ztyomqJR9n9h4BFF
        ZY2oaCNwiDaUZA27JdVp4n80/w==
X-Google-Smtp-Source: AA6agR4hZeAYzYRs+PLcDNRErousrS1A4XiKlllB0GiCkfj7oR+Cp1G2Ybl/w45MUb9AH3Bzs9kl+g==
X-Received: by 2002:a05:6000:114b:b0:220:5ff2:b9dc with SMTP id d11-20020a056000114b00b002205ff2b9dcmr8250922wrx.297.1660550293307;
        Mon, 15 Aug 2022 00:58:13 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a10-20020a05600c348a00b003a531c7aa66sm8820073wmq.1.2022.08.15.00.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 00:58:12 -0700 (PDT)
Date:   Mon, 15 Aug 2022 10:58:11 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH V2] clk: imx8mp: tune the order of enet_qos_root_clk
Message-ID: <Yvn8k0INnkF40Oky@linaro.org>
References: <20220815013428.476015-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815013428.476015-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-15 09:34:28, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The enet_qos_root_clk takes sim_enet_root_clk as parent. When
> registering enet_qos_root_clk, it will be put into clk orphan list,
> because sim_enet_root_clk is not ready.
> 
> When sim_enet_root_clk is ready, clk_core_reparent_orphans_nolock will
> set enet_qos_root_clk parent to sim_enet_root_clk.
> 
> Because CLK_OPS_PARENT_ENABLE is set, sim_enet_root_clk will be
> enabled and disabled during the enet_qos_root_clk reparent phase.
> 
> All the above are correct. But with M7 booted early and using
> enet, M7 enet feature will be broken, because clk driver probe phase
> disable the needed clks, in case M7 firmware not configure
> sim_enet_root_clk.
> 
> And tune the order would also save cpu cycles.
> 
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
> 
> V2:
>  Use Abel's new address
> 
> V1:
>  Patch got reviewed in NXP internal.
> 
>  drivers/clk/imx/clk-imx8mp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index e89db568f5a8..652ae58c2735 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -665,8 +665,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MP_CLK_CAN1_ROOT] = imx_clk_hw_gate2("can1_root_clk", "can1", ccm_base + 0x4350, 0);
>  	hws[IMX8MP_CLK_CAN2_ROOT] = imx_clk_hw_gate2("can2_root_clk", "can2", ccm_base + 0x4360, 0);
>  	hws[IMX8MP_CLK_SDMA1_ROOT] = imx_clk_hw_gate4("sdma1_root_clk", "ipg_root", ccm_base + 0x43a0, 0);
> -	hws[IMX8MP_CLK_ENET_QOS_ROOT] = imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base + 0x43b0, 0);
>  	hws[IMX8MP_CLK_SIM_ENET_ROOT] = imx_clk_hw_gate4("sim_enet_root_clk", "enet_axi", ccm_base + 0x4400, 0);
> +	hws[IMX8MP_CLK_ENET_QOS_ROOT] = imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base + 0x43b0, 0);
>  	hws[IMX8MP_CLK_GPU2D_ROOT] = imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_core", ccm_base + 0x4450, 0);
>  	hws[IMX8MP_CLK_GPU3D_ROOT] = imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core", ccm_base + 0x4460, 0);
>  	hws[IMX8MP_CLK_UART1_ROOT] = imx_clk_hw_gate4("uart1_root_clk", "uart1", ccm_base + 0x4490, 0);
> -- 
> 2.37.1
> 
