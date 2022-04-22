Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF150AD5C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443158AbiDVBrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244815AbiDVBrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D98F49FBC;
        Thu, 21 Apr 2022 18:44:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1FD161A30;
        Fri, 22 Apr 2022 01:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F96BC385A7;
        Fri, 22 Apr 2022 01:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650591851;
        bh=3dKzo/CNM7o0fMsSPqSjBhW3RlZrFwl/PpvNPNQgmg0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uF1TrlOKfD1+u/AzyPo4V5FvFcuIOBJAPq346IdP4HmyagaWLOZb83UW0ADV0fA2Y
         UXyESVCyLrYtTnM+gQ8Cr0SFThinGPF/g6wpagdwT3cxsmiGKWdXt8g+xdcHAHLOx5
         QUg6K7soeNDKVKepsoUvQd6nYBUXTmhF1l+jRVXFnGfYyr/+vJGwfMbXQmgjQM46Li
         hwpdkI4f9QYMJdi96FDvs4bbGD9ml6YPmaz1bSnm7Ztjd+D50Ja3O8KeP3IJR+Uc+C
         GVL/jN4Uv2qWhArfnjaBzB8H9rHbrZ5wGbehrOfWhqyN1ZoMZBvRmnvZqCdv0dsMFD
         bxuGpLYtBx+/A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220422013317.30362-1-linmq006@gmail.com>
References: <20220422012059.52267C385A5@smtp.kernel.org> <20220422013317.30362-1-linmq006@gmail.com>
Subject: Re: [PATCH v2] clk: imx: scu: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage
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
Date:   Thu, 21 Apr 2022 18:44:09 -0700
User-Agent: alot/0.10
Message-Id: <20220422014411.4F96BC385A7@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miaoqian Lin (2022-04-21 18:33:16)
> If the device is already in a runtime PM enabled state
> pm_runtime_get_sync() will return 1.
>=20
> Also, we need to call pm_runtime_put_noidle() when pm_runtime_get_sync()
> fails, so use pm_runtime_resume_and_get() instead. this function
> will handle this.
>=20
> Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Please don't send patches as replies to previous versions of the patch.

>  drivers/clk/imx/clk-scu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
> index 083da31dc3ea..2044e62980e3 100644
> --- a/drivers/clk/imx/clk-scu.c
> +++ b/drivers/clk/imx/clk-scu.c
> @@ -528,7 +528,7 @@ static int imx_clk_scu_probe(struct platform_device *=
pdev)
>                 pm_runtime_use_autosuspend(&pdev->dev);
>                 pm_runtime_enable(dev);
> =20
> -               ret =3D pm_runtime_get_sync(dev);
> +               ret =3D pm_runtime_resume_and_get(dev);
>                 if (ret) {
>                         pm_genpd_remove_device(dev);
>                         pm_runtime_disable(dev);
> --=20
> 2.17.1
>
