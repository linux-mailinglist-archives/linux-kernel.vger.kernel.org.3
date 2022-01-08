Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6995488041
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiAHA4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiAHA4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:56:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A1C061746;
        Fri,  7 Jan 2022 16:56:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B402B827C3;
        Sat,  8 Jan 2022 00:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05575C36AEB;
        Sat,  8 Jan 2022 00:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641603364;
        bh=st53BHQLvyLzo/b3A3D4UNXb37sg+UZodRPGTnSnFWY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Hpfsrk/In3BFFgMIQLxj0MO5/DK2K22Qwq6mtxs+4GXPHnLzAyeDZNyzTWQANwwym
         WJgyirFL+ZS3jclL4WCvoi9G2O8JTMW4zvfqMGg23mCZ7ZfCuzzYd6fkZiTyOF9tak
         FZE84sT8tK5nfJliA3OXnqI4cuuZ8z33DoeFwwHyQDSaI41mpFV46D1r2xTvPhseub
         sYyCn/YCvpAXZeSCLWi1ohQA7Dj08JwS67ynz9+JV6j3/nz4akxzGnXY26fGx8nuVI
         xuJlNNbRjMEwS3A7/P/3oeYLj1zoevo3iOUXKoxpPB2GyQapQWUBr0O4PskE0Cf1gf
         Ks8K5M/MXYENA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211209163720.106185-3-nikita@trvn.ru>
References: <20211209163720.106185-1-nikita@trvn.ru> <20211209163720.106185-3-nikita@trvn.ru>
Subject: Re: [PATCH 2/4] clk: qcom: clk-rcg2: Make sure to not write d=0 to the NMD register
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
To:     Nikita Travkin <nikita@trvn.ru>, linus.walleij@linaro.org,
        mturquette@baylibre.com
Date:   Fri, 07 Jan 2022 16:56:02 -0800
User-Agent: alot/0.9.1
Message-Id: <20220108005604.05575C36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Travkin (2021-12-09 08:37:18)
> Sometimes calculation of d value may result in 0 because of the
> rounding after integer division. This causes the following error:
>=20
> [  113.969689] camss_gp1_clk_src: rcg didn't update its configuration.
> [  113.969754] WARNING: CPU: 3 PID: 35 at drivers/clk/qcom/clk-rcg2.c:122=
 update_config+0xc8/0xdc
>=20
> Make sure that D value is never zero.
>=20
> Fixes: 7f891faf596e ("clk: qcom: clk-rcg2: Add support for duty-cycle for=
 RCG")
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  drivers/clk/qcom/clk-rcg2.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index 6964cf914b60..fdfd43e2a01b 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -424,6 +424,10 @@ static int clk_rcg2_set_duty_cycle(struct clk_hw *hw=
, struct clk_duty *duty)
>         if (d > mask)
>                 d =3D mask;
> =20
> +       /* Hardware can't handle d=3D0, make sure it's at least 1 */
> +       if (!d)
> +               d =3D 1;

Maybe clamp() would be better

	/*
 	 * Check bit widths of 2d. If D is too big reduce duty cycle and
	 * ensure it is non-zero.
	 */
	clamp(d, 1, mask);

> +
>         if ((d / 2) > (n - m))
>                 d =3D (n - m) * 2;
>         else if ((d / 2) < (m / 2))
