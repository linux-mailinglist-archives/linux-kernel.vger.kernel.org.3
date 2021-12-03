Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8AE466EED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350068AbhLCBGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 20:06:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58890 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349868AbhLCBGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:06:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33694B825A0;
        Fri,  3 Dec 2021 01:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F37C00446;
        Fri,  3 Dec 2021 01:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638493388;
        bh=0vDgThgsCSpVdbfkrhNOTirLeaHU+i6DfoV0+C3plYo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QX4UlwM2kClLpPwBZt9QZvfxibm0tWQc7JsGlYAVCjMX4ZtDKTK50cJ3JsdEcymp7
         M+dl5siMSw39SB3psRIhtxd4EwWb5kzTKwgDIdg1ha8QqMiEn3F1OGbS8wNJbaQuoi
         xkqei9qtYQDlH02rr8pa/V8XRAYvAiRwlqbYizhnNyQJDseOBsWnfPL5ZTCXDe/7yN
         RD9MUgQGN+Vkn8wUII/kLay4zyzxvlF/s97s3/qVpsh9NmfYTlMw9lAMxuvnjqeEN6
         VAhD/dL0R/0HAAZMZ1TVAXLT0yC/xvwGMw2v5ZvTcDqPzvG5H0qVeJL0XbnxWD8U5q
         3GgUaMdhFTK2A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211130212015.25232-1-martin.botka@somainline.org>
References: <20211130212015.25232-1-martin.botka@somainline.org>
Subject: Re: [PATCH] clk: qcom: sm6125-gcc: Swap ops of ice and apps on sdcc1
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Date:   Thu, 02 Dec 2021 17:03:07 -0800
User-Agent: alot/0.9.1
Message-Id: <20211203010308.C7F37C00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Botka (2021-11-30 13:20:15)
> Without this change eMMC runs at overclocked freq.
> Swap the ops to not OC the eMMC.
>=20
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---

Any Fixes tag?

>  drivers/clk/qcom/gcc-sm6125.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/gcc-sm6125.c b/drivers/clk/qcom/gcc-sm6125.c
> index 543cfab7561f..431b55bb0d2f 100644
> --- a/drivers/clk/qcom/gcc-sm6125.c
> +++ b/drivers/clk/qcom/gcc-sm6125.c
> @@ -1121,7 +1121,7 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src =3D {
>                 .name =3D "gcc_sdcc1_apps_clk_src",
>                 .parent_data =3D gcc_parent_data_1,
>                 .num_parents =3D ARRAY_SIZE(gcc_parent_data_1),
> -               .ops =3D &clk_rcg2_ops,
> +               .ops =3D &clk_rcg2_floor_ops,
>         },
>  };
> =20
> @@ -1143,7 +1143,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src =
=3D {
>                 .name =3D "gcc_sdcc1_ice_core_clk_src",
>                 .parent_data =3D gcc_parent_data_0,
>                 .num_parents =3D ARRAY_SIZE(gcc_parent_data_0),
> -               .ops =3D &clk_rcg2_floor_ops,
> +               .ops =3D &clk_rcg2_ops,
>         },
>  };
> =20
> --=20
> 2.34.0
>
