Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA80448F2B6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiANXBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiANXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:01:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40330C061574;
        Fri, 14 Jan 2022 15:01:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D38A261FBB;
        Fri, 14 Jan 2022 23:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EAAC36AE7;
        Fri, 14 Jan 2022 23:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642201290;
        bh=vZ5Dm1SDTdxFpSbc9Jis9bD4bSLl4wKV7rgTTztozS4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=o1EaSxJ54n4kQY6cWvJ8ClkAtAQsziVxlaDFJ3z3ww+SnsVukyi8EHq1b4xoonNKc
         6PnWilX1ldxVpi5Gv1XReD0l/h4Kvq165/oK4ycyvHrHzpHjbBZnr77VhCSE5lXb7m
         EF+giwMMeUVkOErxDPWfvtXSuIxQC6Dd8NNXK5uEzVI7abj/fxW2f2T8QZwcYLEzoc
         35ixf1LhqQ4g+2wNR2Eo3E1ziyh5xi98wrzOPH6tZTpTm4bOeqOPL/SnTXVOxAteh2
         FEcspTwrFFQOWvQZHKtVZqf7LdBSudR6lSZjSYL/dc6reLmXd8l0vAPnzcjRJ1zxEL
         +cto8oXOYYqHA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <09ff9044-9abc-d1ad-26c1-5e6ece56d30c@amlogic.com>
References: <20220113115745.45826-1-liang.yang@amlogic.com> <20220113115745.45826-5-liang.yang@amlogic.com> <20220113213513.9819AC36AEA@smtp.kernel.org> <09ff9044-9abc-d1ad-26c1-5e6ece56d30c@amlogic.com>
Subject: Re: [PATCH v9 4/4] clk: meson: add sub MMC clock controller driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org
Date:   Fri, 14 Jan 2022 15:01:28 -0800
User-Agent: alot/0.10
Message-Id: <20220114230130.35EAAC36AE7@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liang Yang (2022-01-13 21:14:46)
> On 2022/1/14 5:35, Stephen Boyd wrote:
> > Quoting Liang Yang (2022-01-13 03:57:45)
> >> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc=
.c
> >> new file mode 100644
> >> index 000000000000..f53977f61390
> >> --- /dev/null
> >> +++ b/drivers/clk/meson/mmc-clkc.c
> >> @@ -0,0 +1,300 @@
[..]
> >> +
> >> +static int mmc_clkc_probe(struct platform_device *pdev)
> >> +{
> >> +       struct clk_hw_onecell_data *onecell_data;
> >> +       struct device *dev =3D &pdev->dev;
> >> +       struct mmc_clkc_data *data;
> >> +       struct regmap *map;
> >> +       struct clk_regmap *clk, *core;
> >> +       struct meson_sclk_div_data *div_data;
> >> +
> >> +       /*cast to drop the const in match->data*/
> >=20
> > Space after *, also why do we need to cast away const? The user of this
> > pointer passes it all the way down to mmc_clkc_register_clk() which
> > could take the data as const void pointer and decide to cast away const
> > there.
>=20
> if use 'const' here, it will report a warning:
> drivers/clk/meson/mmc-clkc.c:224:7: error: assignment discards =E2=80=98c=
onst=E2=80=99=20
> qualifier from pointer targe
> t type [-Werror=3Ddiscarded-qualifiers]=20
>=20
>    data =3D (const struct mmc_clkc_data *)of_device_get_match_data(dev);

Of course. The type declaration up above needs const added to it.
