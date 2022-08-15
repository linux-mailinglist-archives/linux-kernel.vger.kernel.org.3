Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5D592D03
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiHOIXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiHOIW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:22:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A661F2EF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:22:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k17so3547249wmr.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=d2sik8LPZ5fxVGdSA1l9x3G3rxafD4vN6Fm4gVfARLA=;
        b=EWWStsBgT0CUUkk+fRVpvgIYoMTYAqsmgZOoIVZ/B8o9QlrgHr2GtvUZwRBQlqiA3o
         GSeoFqXvdI/ed1mxpdD2mwX8pI4b/W+oiCU2jUvJJJnsB2BqKrMozt0AUT4vfYOAFFBQ
         kGIKnaGLC8teaVdlh2bgpDToToDy8MoZgyyaGsZTz8BNV0qgRf+rvVSzC1HjgHTHO6qj
         GGlAbpXMymkWhlPvdJ09jpcvwSwpFSK0G5LBNk6Q1XFjIsy2cZrU5hKFoct0V40f73Rz
         /LIJUl7YWoUIP1H6NWhMADHgvO5skrq6d6scFxXE7JMMPitARW9/UwkOufwmiTb60Yxk
         MKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=d2sik8LPZ5fxVGdSA1l9x3G3rxafD4vN6Fm4gVfARLA=;
        b=7reJrWwCN+KDN4vlUbQ4HZt6q/qn5uumdhorEVWYlnLrWyq56XONS3vUzp43MN3uBE
         0hpP0hEbLo7tnZEM/FWrYTom0rSJHbXCLoVJOGh8z/Q8oiRzHyfbBX0iOHQGMXjs/U1H
         an38wkMd4ppfGRpL/yx5wH186NsMzP/zy6GfHwogToLNoy6F95xZ9hEYsVn02nm9ixBz
         +sjb1g/Y20yHOzcD7RX+/SCT4TwwEGLpIg3aYUqTdOLplO62WfLO+At9Dmpn5qmZxsa+
         s8VQ0fZIEtHPFEup/oqJ3TLde15q6LFQbUSi6BOjvR3sJcNbkYQvAanE6fF1ETRIqHB0
         YyYw==
X-Gm-Message-State: ACgBeo0OFD/LKNLgl++Vx7Z8zMsoBkR7TFN75vv6FwT5qZdAXz+rMsT5
        UZ/QVKK3LlniHYP6Tlv8o6iTlw==
X-Google-Smtp-Source: AA6agR409Xzc8ugmfhdQoBBq94xoC2ngs6ImhPo9HVq3NWTVAE5UDrnGLJnqYSGxkn3kPX2CDejNrg==
X-Received: by 2002:a7b:cc0d:0:b0:3a5:1eae:3948 with SMTP id f13-20020a7bcc0d000000b003a51eae3948mr9634659wmh.32.1660551776186;
        Mon, 15 Aug 2022 01:22:56 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b003a5dde32e4bsm8400912wms.37.2022.08.15.01.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 01:22:55 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:22:54 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH V2] clk: imx8mp: tune the order of enet_qos_root_clk
Message-ID: <YvoCXkdSb8Nq3aLT@linaro.org>
References: <20220815013428.476015-1-peng.fan@oss.nxp.com>
 <Yvn8k0INnkF40Oky@linaro.org>
 <DU0PR04MB9417BD20354981A3B690D02B88689@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417BD20354981A3B690D02B88689@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-15 07:59:06, Peng Fan wrote:
> Abel,
> 
> > Subject: Re: [PATCH V2] clk: imx8mp: tune the order of enet_qos_root_clk
> > 
> > On 22-08-15 09:34:28, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The enet_qos_root_clk takes sim_enet_root_clk as parent. When
> > > registering enet_qos_root_clk, it will be put into clk orphan list,
> > > because sim_enet_root_clk is not ready.
> > >
> > > When sim_enet_root_clk is ready, clk_core_reparent_orphans_nolock will
> > > set enet_qos_root_clk parent to sim_enet_root_clk.
> > >
> > > Because CLK_OPS_PARENT_ENABLE is set, sim_enet_root_clk will be
> > > enabled and disabled during the enet_qos_root_clk reparent phase.
> > >
> > > All the above are correct. But with M7 booted early and using enet, M7
> > > enet feature will be broken, because clk driver probe phase disable
> > > the needed clks, in case M7 firmware not configure sim_enet_root_clk.
> > >
> > > And tune the order would also save cpu cycles.
> > >
> > > Reviewed-by: Ye Li <ye.li@nxp.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > 
> > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Wrong address?

vim macro issue. Sorry about that.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> 
> Thanks,
> Peng.
> > 
> > > ---
> > >
> > > V2:
> > >  Use Abel's new address
> > >
> > > V1:
> > >  Patch got reviewed in NXP internal.
> > >
> > >  drivers/clk/imx/clk-imx8mp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/imx/clk-imx8mp.c
> > > b/drivers/clk/imx/clk-imx8mp.c index e89db568f5a8..652ae58c2735
> > 100644
> > > --- a/drivers/clk/imx/clk-imx8mp.c
> > > +++ b/drivers/clk/imx/clk-imx8mp.c
> > > @@ -665,8 +665,8 @@ static int imx8mp_clocks_probe(struct
> > platform_device *pdev)
> > >  	hws[IMX8MP_CLK_CAN1_ROOT] =
> > imx_clk_hw_gate2("can1_root_clk", "can1", ccm_base + 0x4350, 0);
> > >  	hws[IMX8MP_CLK_CAN2_ROOT] =
> > imx_clk_hw_gate2("can2_root_clk", "can2", ccm_base + 0x4360, 0);
> > >  	hws[IMX8MP_CLK_SDMA1_ROOT] =
> > imx_clk_hw_gate4("sdma1_root_clk", "ipg_root", ccm_base + 0x43a0, 0);
> > > -	hws[IMX8MP_CLK_ENET_QOS_ROOT] =
> > imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base +
> > 0x43b0, 0);
> > >  	hws[IMX8MP_CLK_SIM_ENET_ROOT] =
> > > imx_clk_hw_gate4("sim_enet_root_clk", "enet_axi", ccm_base + 0x4400,
> > > 0);
> > > +	hws[IMX8MP_CLK_ENET_QOS_ROOT] =
> > > +imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base
> > +
> > > +0x43b0, 0);
> > >  	hws[IMX8MP_CLK_GPU2D_ROOT] =
> > imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_core", ccm_base + 0x4450, 0);
> > >  	hws[IMX8MP_CLK_GPU3D_ROOT] =
> > imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core", ccm_base + 0x4460, 0);
> > >  	hws[IMX8MP_CLK_UART1_ROOT] =
> > imx_clk_hw_gate4("uart1_root_clk",
> > > "uart1", ccm_base + 0x4490, 0);
> > > --
> > > 2.37.1
> > >
