Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84B24BAD23
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiBQXRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:17:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBQXRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:17:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEED2181;
        Thu, 17 Feb 2022 15:16:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 972B9B8251F;
        Thu, 17 Feb 2022 23:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038AFC340EB;
        Thu, 17 Feb 2022 23:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645139656;
        bh=yozxsWXDQqs16bj6JRVdbs2DwrSsE5yaw8OoKLCydFw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UiKzdhCSZMz9YH0P8ZAOk5AeINAwm6sL5aY4G04g6Yqom07RjNUAx4J/UJCLoctbJ
         F2e/Aam8pjeCahgo/qvTslD9Um3FsEMyESP5sfjlcxwTyGX3s7I3wIAtvw9jqnKaBk
         /MSQdiRgqrHJdWRR2T2JeUpAfk6f9DAYvwRKL+f7bbQu67Q3ATzG2yV9KZgEJX6UFG
         Wu/9wa29U28UEqH47/v8FCEJT2QEUznbPN8d9t/yx6f7HCfRH6WA+bx4skzxhBptFH
         k/e4EBl/5e8A7K/ulseqkSeyXhp6N4uYoAovYOWGvDz3Fvcq84bqWc8BiY+nZjSupV
         t79YWxvGOpI2Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220202174213.21259-1-tdas@codeaurora.org>
References: <20220202174213.21259-1-tdas@codeaurora.org>
Subject: Re: [PATCH v2 1/2] clk: qcom: clk-rcg2: Update the calc_rate logic to handle determine rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 17 Feb 2022 15:14:14 -0800
User-Agent: alot/0.10
Message-Id: <20220217231416.038AFC340EB@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-02 09:42:12)
> In the cases where the RCG parent implements the determine rate ops, the
> calc_rate needs to be updated the calculate the rate.

I don't follow. Do you mean in cases where 'rate' is close to 32-bits
and we're running on a CPU with sizeof(long) =3D=3D u32?

>=20
> Fixes: bcd61c0f535a0 ("clk: qcom: Add support for root clock generators (=
RCGs)")
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  * Split the patch for PLL and RCG.
>  * Update the Fixes tag.
>=20
>  drivers/clk/qcom/clk-rcg2.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e1b1b426fae4..2e120a6dd19a 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -147,19 +147,19 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u=
8 index)
>  static unsigned long
>  calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
>  {
> +       u64 tmp =3D rate;

Call it u64 calced_rate or u64 calculated?

> +
>         if (hid_div) {
> -               rate *=3D 2;
> -               rate /=3D hid_div + 1;
> +               tmp *=3D 2;
> +               do_div(tmp, hid_div + 1);

Can this use div_u64()?

>         }
>=20
>         if (mode) {
> -               u64 tmp =3D rate;
>                 tmp *=3D m;
>                 do_div(tmp, n);

This can probably use div_u64() as well. Do that first in a different
patch and then put this patch on top please.

> -               rate =3D tmp;
>         }
>=20
> -       return rate;
> +       return tmp;
>  }
