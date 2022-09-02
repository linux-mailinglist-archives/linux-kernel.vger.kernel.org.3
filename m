Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417C15AB817
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiIBSTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIBSTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:19:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E053108517
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:19:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j26so1710167wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aaSpVNO0sb1iwk/pqz8Vu7wOTAOR3tCl1BOThAiS1Oo=;
        b=gmOWlgsuehgaHUeiVMWvSUDAmVwSVUMl2Wo/SA8JUyZfzK22utTstvQik33qcmmMia
         s8u6JOaRQcxu4Sjt6VWca/HxUaLkep58idanRGxa0IaPGsrmwYUMP/uj7y15dvM5JLvA
         o4fPltKMkuEjg7mZU8fxgvL7AeFK3v13a+jdUWsiUhtvsJFXgcsiU3ieiFtEuxlT8STT
         kd2SDeL5Z5R6YRIWI1w35JlR3FBAcNpSx0yj8son1gFWNASiwXNbC38igGR0JWkdPvRQ
         WolpgHziIzHzj+AdjmU7Fv+5cQTruraeFChPfCcLmQUIAb1E2A5kQwzWnhDcGGIFMASp
         wtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aaSpVNO0sb1iwk/pqz8Vu7wOTAOR3tCl1BOThAiS1Oo=;
        b=wvDYFoqzYIwSxRPosS9WB1zQFgKqTM1ODJrvhZKl4Kb9GYeF/cqMXvWXPPMLRPQmuF
         d39qk3mbU111kFXev1uyi+qdyiP76ATp5XCl5T9H39ktv/QOrzX2Q84AzEtTojBW4tWG
         vutNVYU7Sr1zeXhk3pfECvATkNVrRiOEFrAJxBwsjjLXNRYiNSEJAv2NIQMGreVtiWnz
         tjNK2PlKuayWqHopTmuG2ckTV9vYebmc3T5T5uir/ySY6rk7a21M749ZQ/vrKroyxZMU
         /tz77/qXzKXL/tw7shwEy1iJuqq1V66qYueEEoXDAnYcvNLPl2qBo/XHGOPKFIuh+Mp9
         uwbg==
X-Gm-Message-State: ACgBeo2b8DF7slr9QfX4nDXp2t7qa9qWQoHRUmMRk7oV5lU9b7biPLJR
        z1Yc3PmaYuewYjMiKC9ZRz8Uxg==
X-Google-Smtp-Source: AA6agR7BTQH15DGgHn0VC/Jbq3c61VoGnruaykOR+Eypyn/HzAJ0W8p6bOMepKPQ8SuoIUyRS7kMvA==
X-Received: by 2002:a7b:ca42:0:b0:3a6:9d:a444 with SMTP id m2-20020a7bca42000000b003a6009da444mr3796030wml.51.1662142743579;
        Fri, 02 Sep 2022 11:19:03 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x16-20020adff0d0000000b0021d221daccfsm2070481wro.78.2022.09.02.11.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:19:02 -0700 (PDT)
Date:   Fri, 2 Sep 2022 21:18:59 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH V2] clk: imx8mp: tune the order of enet_qos_root_clk
Message-ID: <YxJJE3omFIoHQuao@linaro.org>
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

Applied, thanks.

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
