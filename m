Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA484932DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350916AbiASCWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:22:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38574 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiASCWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:22:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5DE861523;
        Wed, 19 Jan 2022 02:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF83C340E0;
        Wed, 19 Jan 2022 02:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642558941;
        bh=TUaPuu1VvMddn53j9AqDwXehQaQWuB7rudQxVqafxIs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gQBiIfrSi8SbwNyqk7TR3sDQFgUvzBwxm3ZoeDaZR5VtOKRqN8TS/8qo+1lH1yeHX
         p+orgMaJd33+92x7qXCFDIam92CgcOvBXrmCMRVVmr9E/JcIojjNXaqLbU4djY5lxP
         0Sqj6okrbhJoDOYGgqdzKltj3n+0bl6WNCHYx5liZP0qw9BZknOw15II9dwLWHkWFV
         11BsWVmQqE2jdrGu30C+fycF2JZDlowOpe2sbKT6NMBtEzHj9THC4bSHxpJuZLz+Ma
         Yo8rEzWLIism0INmF+JM4e2OQTfvIkMkwgKGvaOCV0lKw6ZbQKHKi36hzHpEbK/xFg
         Kg3oXwQZrB4EQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fe77fd6b-788f-1694-f260-f95e54cf4ef3@amlogic.com>
References: <20220113115745.45826-1-liang.yang@amlogic.com> <20220113115745.45826-5-liang.yang@amlogic.com> <20220113213513.9819AC36AEA@smtp.kernel.org> <09ff9044-9abc-d1ad-26c1-5e6ece56d30c@amlogic.com> <20220114230130.35EAAC36AE7@smtp.kernel.org> <fe77fd6b-788f-1694-f260-f95e54cf4ef3@amlogic.com>
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
Date:   Tue, 18 Jan 2022 18:22:19 -0800
User-Agent: alot/0.10
Message-Id: <20220119022221.3AF83C340E0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liang Yang (2022-01-16 22:24:28)
>=20
>=20
> On 2022/1/15 7:01, Stephen Boyd wrote:
> > [ EXTERNAL EMAIL ]
> >=20
> > Quoting Liang Yang (2022-01-13 21:14:46)
> >> On 2022/1/14 5:35, Stephen Boyd wrote:
> >>> Quoting Liang Yang (2022-01-13 03:57:45)
> >>>> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-cl=
kc.c
> >>>> new file mode 100644
> >>>> index 000000000000..f53977f61390
> >>>> --- /dev/null
> >>>> +++ b/drivers/clk/meson/mmc-clkc.c
> >>>> @@ -0,0 +1,300 @@
> > [..]
> >>>> +
> >>>> +static int mmc_clkc_probe(struct platform_device *pdev)
> >>>> +{
> >>>> +       struct clk_hw_onecell_data *onecell_data;
> >>>> +       struct device *dev =3D &pdev->dev;
> >>>> +       struct mmc_clkc_data *data;
> >>>> +       struct regmap *map;
> >>>> +       struct clk_regmap *clk, *core;
> >>>> +       struct meson_sclk_div_data *div_data;
> >>>> +
> >>>> +       /*cast to drop the const in match->data*/
> >>>
> >>> Space after *, also why do we need to cast away const? The user of th=
is
> >>> pointer passes it all the way down to mmc_clkc_register_clk() which
> >>> could take the data as const void pointer and decide to cast away con=
st
> >>> there.
> >>
> >> if use 'const' here, it  will report a warning:
> >> drivers/clk/meson/mmc-clkc.c:224:7: error: assignment discards =E2=80=
=98const=E2=80=99
> >> qualifier from pointer targe
> >> t type [-Werror=3Ddiscarded-qualifiers]
> >>
> >>     data =3D (const struct mmc_clkc_data *)of_device_get_match_data(de=
v);
> >=20
> > Of course. The type declaration up above needs const added to it.The pa=
rm of mmc_clkc_register_clk_with_parent(...., void *data) does not=20
> have 'const', so make the type declaration cause a further 'const' cast=20
> warning. Could i copy these infos just like below:

Why can't you push const down to the function that really cares to
remove const?
