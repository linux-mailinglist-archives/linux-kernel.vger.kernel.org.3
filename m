Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0986488080
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiAHB0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiAHB0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:26:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA43CC061574;
        Fri,  7 Jan 2022 17:26:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A179FB827B9;
        Sat,  8 Jan 2022 01:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E050C36AEB;
        Sat,  8 Jan 2022 01:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641605209;
        bh=yxBttM5jej8eNEF7N0nxMv/+l9qCoNu2IKJT8kt1onQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Whn+48xnqgmNqwy6UGTJIrRM0ryA2+K6C73/dGSgXrB3JYDQvkdKmNfhCss8auvU4
         jtMTEJksm0DCYhgbhxK0FBOtC/CYN4f5hL4lxYGdPsOMiwGpkLiKlzdsELhrLw0gfo
         cUOXCpF/Wo+nOfMcX71YY1DwxpHx20eWPjnsgPhM224Fv4DcAEssQ9srYwgJYm/kRr
         Gvttba4aO0U8HP2rQbUoGEc38HdAEeulcqt3WO6h+xttBvi/0IGRdUkA5plYhZ9ET7
         3AB98ZpaR+fV3QdBdBqTUzcvx0bHxDZnzCswx3HdyO2qty3/EFuQBjWy3aDGWtArYg
         UDbvXUCeNFAag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211217155512.1877408-2-dario.binacchi@amarulasolutions.com>
References: <20211217155512.1877408-1-dario.binacchi@amarulasolutions.com> <20211217155512.1877408-2-dario.binacchi@amarulasolutions.com>
Subject: Re: [RFC PATCH 1/4] clk: mxs: imx28: Reparent gpmi clk to ref_gpmi
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Jan 2022 17:26:48 -0800
User-Agent: alot/0.9.1
Message-Id: <20220108012649.4E050C36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2021-12-17 07:55:09)
> From: Michael Trimarchi <michael@amarulasolutions.com>
>=20
> ref_gpmi is connected that is sourced from pll0. This allow
> to get nand clk frequency to handle edo mode 5,4,3
>=20
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>=20
>  drivers/clk/mxs/clk-imx28.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> index 62146ea4d5b8..9e0b9f8e5885 100644
> --- a/drivers/clk/mxs/clk-imx28.c
> +++ b/drivers/clk/mxs/clk-imx28.c
> @@ -243,6 +243,9 @@ static void __init mx28_clocks_init(struct device_nod=
e *np)
> =20
>         clk_register_clkdev(clks[enet_out], NULL, "enet_out");
> =20
> +       /* GPMI set parent to ref_gpmi instead of osc */
> +       clk_set_parent(clks[gpmi_sel], clks[ref_gpmi]);

Please check the return value and print a warning or something if it
fails. Also, can it be done through assigned-clock-parents instead?

> +
>         for (i =3D 0; i < ARRAY_SIZE(clks_init_on); i++)
>                 clk_prepare_enable(clks[clks_init_on[i]]);
>  }
