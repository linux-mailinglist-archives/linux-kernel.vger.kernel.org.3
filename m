Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6007B50AD2A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443036AbiDVBXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiDVBXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:23:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB268403D9;
        Thu, 21 Apr 2022 18:21:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A77BB829EB;
        Fri, 22 Apr 2022 01:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52267C385A5;
        Fri, 22 Apr 2022 01:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650590459;
        bh=ZGP6Dc5HcbyYx3f99nyxqazx+rsBw8MPomaGNK5aG6g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FImYl/5UrR4i0m6nCKBrz+z1VN3Zg730BK0ue7KWi4bLydZ/F70wJMb9JLwLTZL8n
         f1sahHwn759HtZb2fXH9ZQ4ltig1/8Xa6pZsuoGpbaofsbFNgyCtRCcIt199ELfRhk
         pLBm88zhb+xq12fw1k9DoavfM2G09U9+nuC+g/UB2vS+KqURyHuBryqI4kfX8CkDlq
         OhUkt6E8cAPFdg7t7Prdl7NVsUupxvDpDlMatUTbaQnXni8fgY+6ORw8m8BjQB3hDx
         VDkXpQqAQ/Fwq/9blwMnrpVlI/5Ev/GNZ7XPHdWFconE4rTxwSWdKIPmA4qiqYi9xb
         5GCb3j8kdj1Nw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220412065719.17735-1-linmq006@gmail.com>
References: <20220412065719.17735-1-linmq006@gmail.com>
Subject: Re: [PATCH] clk: imx: scu: Fix pm_runtime_get_sync() error checking
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linmq006@gmail.com
To:     Abel Vesa <abel.vesa@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Apr 2022 18:20:57 -0700
User-Agent: alot/0.10
Message-Id: <20220422012059.52267C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miaoqian Lin (2022-04-11 23:57:18)
> If the device is already in a runtime PM enabled state
> pm_runtime_get_sync() will return 1, so a test for negative
> value should be used to check for errors.

Maybe it should use pm_runtime_resume_and_get() instead?

>=20
> Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/clk/imx/clk-scu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index 083da31dc3ea..18c6190eeffd 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -529,7 +529,7 @@ static int imx_clk_scu_probe(struct platform_device *=
pdev)
>                 pm_runtime_enable(dev);
> =20
>                 ret =3D pm_runtime_get_sync(dev);
> -               if (ret) {
> +               if (ret < 0) {
>                         pm_genpd_remove_device(dev);
>                         pm_runtime_disable(dev);
>                         return ret;
> --=20
> 2.17.1
>
