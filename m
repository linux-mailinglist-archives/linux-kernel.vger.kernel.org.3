Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005A84BAD2F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiBQXVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:21:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBQXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:21:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE75AC91A;
        Thu, 17 Feb 2022 15:20:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03C0AB8252F;
        Thu, 17 Feb 2022 23:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0C8C340E8;
        Thu, 17 Feb 2022 23:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645139823;
        bh=wpCAjlLSjTEiziUFlRunKnTwOb7RZYEbkzvx1JFvluI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dfXLaiyU+P7B/B3h2TtSitoP0a4x3JIx8sMp7SqxTtvKcXj3wDvpnRK2ApUAyMQpI
         qqkpbkyoyufFbdjdhPjHXe1Evnw8HqMrHstHv8udplaOY5/vy7sE9QmMrhwf3M1NIs
         kyHz7TdR45zAMsRS95hW0diEeCDzxejB29iTeRH4ojykTGMYnYsMaPwvu37jL7h1ij
         hZZu2yjaeUKtOaUSi10XK6bkO8ZFRWk6JACUcrbUSGiKuMVnFwEkkj2MO0pNPZAvvx
         csVJ87RQoXFhwl45CB9FX05mo0uoAgMvFbnaz5Kx24u5Hk2ELBcRotfdTBqwJj5pOd
         pxSuT5A7FJ0iA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220202174213.21259-2-tdas@codeaurora.org>
References: <20220202174213.21259-1-tdas@codeaurora.org> <20220202174213.21259-2-tdas@codeaurora.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: clk-alpha-pll: Update to use determine rate ops for PLL
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 17 Feb 2022 15:17:01 -0800
User-Agent: alot/0.10
Message-Id: <20220217231703.8C0C8C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-02 09:42:13)
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alph=
a-pll.c
> index 4406cf609aae..4e2e93cd8c8b 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -812,12 +812,25 @@ static int alpha_pll_huayra_set_rate(struct clk_hw =
*hw, unsigned long rate,
>         return 0;
>  }
>=20
> -static long alpha_pll_huayra_round_rate(struct clk_hw *hw, unsigned long=
 rate,
> -                                       unsigned long *prate)
> +static int alpha_pll_huayra_determine_rate(struct clk_hw *hw,
> +                                       struct clk_rate_request *req)
>  {
> +       struct clk_hw *parent_hw;
> +       unsigned long rrate, prate;
>         u32 l, a;
>=20
> -       return alpha_huayra_pll_round_rate(rate, *prate, &l, &a);
> +       parent_hw =3D clk_hw_get_parent(hw);

The clk_rate_request should already have the parent_hw pointer set in
it. See clk_core_init_rate_req(). So there's no need to
clk_hw_get_parent() again here.

> +       if (!parent_hw)
> +               return -EINVAL;
> +
> +       prate =3D clk_hw_get_rate(parent_hw);

And low and behold the parent rate is also prepopulated in 'req'. Just
use that.

> +       rrate =3D alpha_huayra_pll_round_rate(req->rate, prate, &l, &a);
> +
> +       req->best_parent_hw =3D parent_hw;

Remove.

> +       req->best_parent_rate =3D prate;

Remove.

> +       req->rate =3D rrate;

Keep.

	req->rate =3D alpha_pll_huayra_round_rate(req->rate, prate, &l, &a);

> +
> +       return 0;
>  }
>=20
>  static int trion_pll_is_enabled(struct clk_alpha_pll *pll,
