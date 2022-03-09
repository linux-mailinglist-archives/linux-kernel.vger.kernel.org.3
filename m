Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3F74D3953
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbiCIS6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiCIS6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:58:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5371FCEE;
        Wed,  9 Mar 2022 10:57:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9671DB82357;
        Wed,  9 Mar 2022 18:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2192EC340EC;
        Wed,  9 Mar 2022 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646852258;
        bh=823gQkzc3z2Ax/PB0AF2EV05ZOJdbyNdg1TPhRMlf2Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FuJ4NbNq6ZUsKFhmbJ2zFX5viVTa8gA45bLJJZRHiFOzTeSCo3hBGt/tPAM32fL0z
         ooTODTKvoDEPUwxniaQSdeA8mFp02c4vFjMPMLJ4hvz5j+lRhUJds/ZlgHbDqyPr3A
         fD0ZaKpYDQGnxagXfQJ0s4CXXOIeP93L1/3+m/yPbauUZD6dLxFOQ5UrWPIZ/BPnHB
         tkD+2moevzlwOtOY5NVtvxqIFKqQ4cn3FzcfbjYzqUQd2iBEOmE8HZYvbgCuCx+xKL
         gS7if2l5nKWHcrAOCK73sr+mm47SCj3LqlTASTm868D8aSod/TWX98LeI4xfcbMqCz
         VDUrsMZZo2MCA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220304011703.2061466-1-chi.minghao@zte.com.cn>
References: <20220304011703.2061466-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] clk/rockchip: Use of_device_get_match_data()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     heiko@sntech.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
To:     cgel.zte@gmail.com, mturquette@baylibre.com
Date:   Wed, 09 Mar 2022 10:57:36 -0800
User-Agent: alot/0.10
Message-Id: <20220309185738.2192EC340EC@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting cgel.zte@gmail.com (2022-03-03 17:17:03)
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
>=20
> Use of_device_get_match_data() to simplify the code.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
>  drivers/clk/rockchip/clk-rk3399.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk=
-rk3399.c
> index 306910a3a0d3..b1b67bfb63b8 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -1634,14 +1634,8 @@ static const struct of_device_id clk_rk3399_match_=
table[] =3D {
>  static int __init clk_rk3399_probe(struct platform_device *pdev)
>  {
>         struct device_node *np =3D pdev->dev.of_node;
> -       const struct of_device_id *match;
>         const struct clk_rk3399_inits *init_data;
> -
> -       match =3D of_match_device(clk_rk3399_match_table, &pdev->dev);
> -       if (!match || !match->data)
> -               return -EINVAL;
> -
> -       init_data =3D match->data;
> +       init_data =3D of_device_get_match_data(&pdev->dev);

The translation doesn't look equivalent. Before we would bail out of
probe if match data isn't there with an error. That isn't possible of
course with further investigation but please make a note of this in the
commit text to aid review. Also, please don't send new versions of
patches in reply to previous versions of patches. It breaks my patch
workflow. Thanks in advance.

>         if (init_data->inits)
>                 init_data->inits(np);
>
