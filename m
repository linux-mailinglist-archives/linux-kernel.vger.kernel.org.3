Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A51488015
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiAHAwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiAHAwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:52:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43F0C061746;
        Fri,  7 Jan 2022 16:52:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B32FAB827C1;
        Sat,  8 Jan 2022 00:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5140EC36AEB;
        Sat,  8 Jan 2022 00:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641603129;
        bh=uZRAQjD0Cu/0AvHcRJoik8x/i5Cs4BQt2RicFubNe2Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=twiSvBeUnQLf648h4LtbyDAficRfIrrlKkylkdzGKySNf1AQ2aCU6ZCiagyt6t78G
         3OkJqjpR8RT1jyYDVdOVZen4X6iYiv6T8eFNEwYl6Rn3knK7oZdraYFFmKblNaJfDJ
         K3n95ddtss3WVDnriVvma9PluZ9jcLJT8HIdqyXyTsa5SFjq4Td4Vcitj5CO8m7BBn
         B5MWlZTwE/OSUCKNwPXioi82R8FdpRHK8Ay4aJwLHxFVUYnW78lxdqATcKheDO2vvQ
         rToSnFPIsmZekELuXJyVT+AQ5xBn/043+/L3PLvBhfZkzcDdM/KINJOHPHI4JezH6T
         tZNxoO+S5gHGQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211209163720.106185-2-nikita@trvn.ru>
References: <20211209163720.106185-1-nikita@trvn.ru> <20211209163720.106185-2-nikita@trvn.ru>
Subject: Re: [PATCH 1/4] clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if MND divider is not enabled.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
To:     Nikita Travkin <nikita@trvn.ru>, linus.walleij@linaro.org,
        mturquette@baylibre.com
Date:   Fri, 07 Jan 2022 16:52:08 -0800
User-Agent: alot/0.9.1
Message-Id: <20220108005209.5140EC36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Travkin (2021-12-09 08:37:17)
> In cases when MND is not enabled (e.g. when only Half Integer Divider is
> used), setting D registers makes no effect. Fail instead of making
> ineffective write.
>=20
> Fixes: 7f891faf596e ("clk: qcom: clk-rcg2: Add support for duty-cycle for=
 RCG")
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  drivers/clk/qcom/clk-rcg2.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e1b1b426fae4..6964cf914b60 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -396,7 +396,7 @@ static int clk_rcg2_get_duty_cycle(struct clk_hw *hw,=
 struct clk_duty *duty)
>  static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *d=
uty)
>  {
>         struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> -       u32 notn_m, n, m, d, not2d, mask, duty_per;
> +       u32 notn_m, n, m, d, not2d, mask, duty_per, cfg;
>         int ret;
> =20
>         /* Duty-cycle cannot be modified for non-MND RCGs */
> @@ -407,6 +407,11 @@ static int clk_rcg2_set_duty_cycle(struct clk_hw *hw=
, struct clk_duty *duty)
> =20
>         regmap_read(rcg->clkr.regmap, RCG_N_OFFSET(rcg), &notn_m);
>         regmap_read(rcg->clkr.regmap, RCG_M_OFFSET(rcg), &m);
> +       regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
> +
> +       /* Duty-cycle cannot be modified if MND divider is in bypass mode=
. */
> +       if (!(cfg & CFG_MODE_MASK))
> +               return -EINVAL;

Should we still allow 50% duty cycle to succeed?
