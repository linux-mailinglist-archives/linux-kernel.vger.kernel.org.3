Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF98754D7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357690AbiFPCA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351492AbiFPCAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:00:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7C5931B;
        Wed, 15 Jun 2022 19:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0544FCE23ED;
        Thu, 16 Jun 2022 02:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389C2C3411A;
        Thu, 16 Jun 2022 02:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344821;
        bh=9PD8GVQU2JU+YsQ6LA98xQo4CJYHlIziBU/qLQY5GWM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RvNNnvTOwFz4RgfFhTrNbrXm6PR8txEubpwAoZVKLkpm4Jni1LMEsv+9Tci16UP5V
         Swfnzc7zf7RR/5dbdEGYe3pXf1K5K1OMnz8N7YjwoWI4/zO2ME9okGmrXzfPIBlTlo
         PxQg7bqiZVbdWrxKC7HrS/ehB8XCJFrdSRCURsvyudvAtkm2KZKQMjytxlBorr0ms2
         DQGgl/RHa1DqWGm4mv0LHHPiseUElV005HA0w7+UQU2Lxp7H63A5P9kEYKyLk+jDfA
         2VeAOXtkHBFk4R+bih2USx6eFRtB61HMpd04TThd8m1/GEU5e7GxRk1wPlP5OO+PYQ
         ksD3FnSA9NTcQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220527090355.7354-1-rex-bc.chen@mediatek.com>
References: <20220527090355.7354-1-rex-bc.chen@mediatek.com>
Subject: Re: [RFC PATCH] reset: mediatek: Move mediatek system clock reset to reset folder
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     runyang.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, matthias.bgg@gmail.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de
Date:   Wed, 15 Jun 2022 19:00:17 -0700
User-Agent: alot/0.10
Message-Id: <20220616020021.389C2C3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bo-Chen Chen (2022-05-27 02:03:55)
> diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek=
/clk-mt2701-eth.c
> index edf1e2ed2b59..84ea1591257e 100644
> --- a/drivers/clk/mediatek/clk-mt2701-eth.c
> +++ b/drivers/clk/mediatek/clk-mt2701-eth.c
> @@ -36,14 +36,6 @@ static const struct mtk_gate eth_clks[] =3D {
>         GATE_ETH(CLK_ETHSYS_CRYPTO, "crypto_clk", "ethif_sel", 29),
>  };
> =20
> -static u16 rst_ofs[] =3D { 0x34, };
> -
> -static const struct mtk_clk_rst_desc clk_rst_desc =3D {
> -       .version =3D MTK_RST_SIMPLE,
> -       .rst_bank_ofs =3D rst_ofs,
> -       .rst_bank_nr =3D ARRAY_SIZE(rst_ofs),
> -};
> -
>  static const struct of_device_id of_match_clk_mt2701_eth[] =3D {
>         { .compatible =3D "mediatek,mt2701-ethsys", },
>         {}
> @@ -66,7 +58,7 @@ static int clk_mt2701_eth_probe(struct platform_device =
*pdev)
>                         "could not register clock provider: %s: %d\n",
>                         pdev->name, r);
> =20
> -       mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
> +       mtk_rst_init(&pdev->dev, node, "mt2701-eth-rst");


Instead of making direct calls, please use the auxiliary bus and create
full fledged devices that are probed through the driver core. That way
we can see the relationship in sysfs between devices and they're "real"
device drivers for the reset component of the device.
