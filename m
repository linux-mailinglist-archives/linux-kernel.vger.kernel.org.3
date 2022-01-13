Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE19B48DF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiAMVXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:23:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39016 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiAMVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:23:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0558619D7;
        Thu, 13 Jan 2022 21:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D85C36AE3;
        Thu, 13 Jan 2022 21:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642108992;
        bh=cUCtebEbEkYh9sbWVWDJtzkSdylvZxNVVHxQYeHkfvU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EkbbGQ39JoG2q69FY3jPZnUyJ4PyM8pr3M4CFiY27lcgHKc6XXKt+dMubMWvLP60H
         ur32KHJ06fnu0K1qG0Yva18JvH11lyGBVA25luIhKbaOn6/OaBojSJpUhGKJ1Lb8c8
         1ZehMyK1e3BCP2DuJTKlmTFp1a/0FQ9zyQa83XByuDfMhwc/h9P4PWXSb/4VH5JQVc
         vOKZgKkD6/tCG1DcL9DfB8bgYzNaQw+ji9QTNfwzc05WSFBd3V4uyv+xzjk/93yvSj
         0QpnojQt8UFwLd3FfjrJyyBRq4lVP8U64Lv1W5b1uia/PK/j7q0qF8Z366ltJcMsh0
         PUL3VFzBB6PcA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211203141125.2447520-1-dev_public@wujek.eu>
References: <20211203141125.2447520-1-dev_public@wujek.eu>
Subject: Re: [PATCH] clk: si5341: fix reported clk_rate when output divider is 2
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Adam Wujek <dev_public@wujek.eu>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Adam Wujek <dev_public@wujek.eu>,
        Michael Turquette <mturquette@baylibre.com>,
        Robert Hancock <robert.hancock@calian.com>
Date:   Thu, 13 Jan 2022 13:23:10 -0800
User-Agent: alot/0.9.1
Message-Id: <20220113212312.19D85C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Robert

Please review

Quoting Adam Wujek (2021-12-03 06:12:07)
> SI5341_OUT_CFG_RDIV_FORCE2 shall be checked first to distinguish whether
> a divider for a given output is set to 2 (SI5341_OUT_CFG_RDIV_FORCE2
> is set) or the output is disabled (SI5341_OUT_CFG_RDIV_FORCE2 not set,
> SI5341_OUT_R_REG is set 0).
> Before the change, divider set to 2 (SI5341_OUT_R_REG set to 0) was
> interpreted as output is disabled.
>=20
> Signed-off-by: Adam Wujek <dev_public@wujek.eu>
> ---
>  drivers/clk/clk-si5341.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
> index b7641abe6747..15b1c90cafe5 100644
> --- a/drivers/clk/clk-si5341.c
> +++ b/drivers/clk/clk-si5341.c
> @@ -798,6 +798,15 @@ static unsigned long si5341_output_clk_recalc_rate(s=
truct clk_hw *hw,
>         u32 r_divider;
>         u8 r[3];
>=20
> +       err =3D regmap_read(output->data->regmap,
> +                       SI5341_OUT_CONFIG(output), &val);
> +       if (err < 0)
> +               return err;
> +
> +       /* If SI5341_OUT_CFG_RDIV_FORCE2 is set, r_divider is 2 */
> +       if (val & SI5341_OUT_CFG_RDIV_FORCE2)
> +               return parent_rate / 2;
> +
>         err =3D regmap_bulk_read(output->data->regmap,
>                         SI5341_OUT_R_REG(output), r, 3);
>         if (err < 0)
> @@ -814,13 +823,6 @@ static unsigned long si5341_output_clk_recalc_rate(s=
truct clk_hw *hw,
>         r_divider +=3D 1;
>         r_divider <<=3D 1;
>=20
> -       err =3D regmap_read(output->data->regmap,
> -                       SI5341_OUT_CONFIG(output), &val);
> -       if (err < 0)
> -               return err;
> -
> -       if (val & SI5341_OUT_CFG_RDIV_FORCE2)
> -               r_divider =3D 2;
>=20
>         return parent_rate / r_divider;
>  }
