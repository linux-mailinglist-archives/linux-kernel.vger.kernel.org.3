Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489ED57DB0B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiGVHQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiGVHPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C43B99643;
        Fri, 22 Jul 2022 00:14:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E782662188;
        Fri, 22 Jul 2022 07:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFFAC341C7;
        Fri, 22 Jul 2022 07:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658474076;
        bh=69P75Uh9tSzboiEnDeDePBKG/ovLsyPxSOwg4CcKbQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dquxBBUXTymrJ56KloIC8oQr43PApoKh8fqGRem/LXrDlcPQV23c+nQ9jmKbPCgax
         NiFnFwcba6azEZo7HdBIoJp86AeKZCJe5KW1gc+AZ3bIoX61az7+9AWYsUdOxugpUv
         z7Fyn+MG66/aJ0UrGmR4JezoigO5obPFHbOH9g1bonzKsanwuIqtRnSt87KqGohUg5
         UFOjstoL5SvwY8otKrYWQp3CxnXgkOv2Lm02jARLn9JzzzhD4FOVNMtdNlV3mOtqOc
         k6bgVf27WOHflCU0Pn6SELNR9eQkTZI8DgpB+sJwf1ZVE2Y7IxDcDV66M5XSdrlshG
         6FHBmxHPwhv5w==
Date:   Fri, 22 Jul 2022 09:14:31 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     williamsukatube@163.com
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: Re: [PATCH] watchdog: armada_37xx_wdt: check the return value of
 devm_ioremap() in armada_37xx_wdt_probe()
Message-ID: <20220722091431.1572e92c@dellmb>
In-Reply-To: <20220722030938.2925156-1-williamsukatube@163.com>
References: <20220722030938.2925156-1-williamsukatube@163.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 11:09:38 +0800
williamsukatube@163.com wrote:

> From: William Dean <williamsukatube@gmail.com>
>=20
> The function devm_ioremap() in armada_37xx_wdt_probe() can fail, so
> its return value should be checked.
>=20
> Fixes: 54e3d9b518c8a ("watchdog: Add support for Armada 37xx CPU watchdog=
")
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: William Dean <williamsukatube@gmail.com>
> ---
>  drivers/watchdog/armada_37xx_wdt.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada=
_37xx_wdt.c
> index 1635f421ef2c..854b1cc723cb 100644
> --- a/drivers/watchdog/armada_37xx_wdt.c
> +++ b/drivers/watchdog/armada_37xx_wdt.c
> @@ -274,6 +274,8 @@ static int armada_37xx_wdt_probe(struct platform_devi=
ce *pdev)
>  	if (!res)
>  		return -ENODEV;
>  	dev->reg =3D devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!dev->reg)
> +		return -ENOMEM;
> =20
>  	/* init clock */
>  	dev->clk =3D devm_clk_get(&pdev->dev, NULL);

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
