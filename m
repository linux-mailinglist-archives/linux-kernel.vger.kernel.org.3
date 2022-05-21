Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2264C52F8AE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiEUE1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiEUE1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:27:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255F117EC38;
        Fri, 20 May 2022 21:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1119B80011;
        Sat, 21 May 2022 04:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B92C385A5;
        Sat, 21 May 2022 04:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653107248;
        bh=VR2e2nGywKJO8BXGBw7bDB50ksSQe7j9hsFNTsbScHo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rQtOWkLe4RREd5CSnrIlDauiRGtpW4gIDDk8Hu4bg6ROvhBQKh1NWU50VKus7fduU
         TZa3rxoZikGUUAsMh4tXjyAxlCkK9/aC0TOt6pknNei9PQ2F2WPXMs01zGk5ydQW4l
         pdv5mrATPOVaa+dzTGql53SDZMnJ/cBIPm49xF1jK5hv1+ffzaXfKTNfCtiO6yP0Vf
         WBH5sl+go4s6b7Rl0tnwa0NuvDN8kY4kN7tEGmNi4+/ly1sxrz6l8CvZK+Y+alQfjV
         JBGV66UaC83Nw6z7JwfyuxGn+/x21RPviW9hl5OhG5LbcVn8TwKan8tt5B33nrD3KZ
         p1iYsCqUBkJ7g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220520094323.754971-5-wenst@chromium.org>
References: <20220520094323.754971-1-wenst@chromium.org> <20220520094323.754971-5-wenst@chromium.org>
Subject: Re: [PATCH 4/4] clk: mediatek: mt8183: Add clk mux notifier for MFG mux
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Fri, 20 May 2022 21:27:26 -0700
User-Agent: alot/0.10
Message-Id: <20220521042728.80B92C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-05-20 02:43:23)
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk=
-mt8183.c
> index 8a755fadebb5..afef3738396e 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -1217,6 +1219,25 @@ static int clk_mt8183_top_probe(struct platform_de=
vice *pdev)
>         mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
>                 top_clk_data);
> =20
> +       /* Register mux notifier for MFG mux */

This comment sort of indicates it should be another function for this
block called "register mfg mux notifier".

> +       mfg_mux_nb =3D devm_kzalloc(&pdev->dev, sizeof(*mfg_mux_nb), GFP_=
KERNEL);
> +       if (!mfg_mux_nb)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(top_muxes); i++)
> +               if (top_muxes[i].id =3D=3D CLK_TOP_MUX_MFG)
> +                       break;
> +       if (i =3D=3D ARRAY_SIZE(top_muxes))
> +               return -EINVAL;
> +
> +       mfg_mux_nb->mux =3D &top_muxes[i];
> +       mfg_mux_nb->bypass_index =3D 0; // Bypass to 26M crystal

Use /* these types of comments */

> +       ret =3D devm_mtk_clk_mux_notifier_register(&pdev->dev,
> +                                                top_clk_data->hws[CLK_TO=
P_MUX_MFG]->clk,
> +                                                mfg_mux_nb);
> +       if (ret)
> +               return ret;
> +
>         return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
