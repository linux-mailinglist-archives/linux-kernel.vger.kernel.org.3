Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E6D5482C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiFMJCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiFMJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:02:28 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6511C3;
        Mon, 13 Jun 2022 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1655110940; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wzTq3X/06BFOnsk1/1jD9KPlkg3opvD7FWyWkz4J1rI=;
        b=eLbD7wDeL0e0UWjrlIAm+qxeUDjLUr4Yyk0i2d54W+5bAOCWSQRMYIi1m81Qr72nZqeEgF
        HnHc235l7jwMFS6tEjgir9ZSM+GK0ETMW/sTRnSfdAKWWG+73XAR2rdXGhp/vLId5m1VXb
        aklKa5aNN8ZZcUu/Obf/x/a9IfsHEi4=
Date:   Mon, 13 Jun 2022 10:02:11 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic-tcu: Properly enable registers before
 accessing timers
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <NRREDR.U6G6SM5BIXEC3@crapouillou.net>
In-Reply-To: <20220603134705.11156-1-aidanmacdonald.0x0@gmail.com>
References: <20220603134705.11156-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le ven., juin 3 2022 at 14:47:05 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Access to registers is guarded by ingenic_tcu_{enable,disable}_regs()
> so the stop bit can be cleared before accessing a timer channel, but
> those functions did not clear the stop bit on SoCs with a global TCU
> clock gate.
>=20
> Testing on the X1000 has revealed that the stop bits must be cleared
> _and_ the global TCU clock must be ungated to access timer registers.
> Programming manuals for the X1000, JZ4740, and JZ4725B specify this
> behavior. If the stop bit isn't cleared, then writes to registers do
> not take effect, which can leave clocks with no defined parent when
> registered and leave clock tree state out of sync with the hardware,
> triggering bugs in downstream drivers relying on TCU clocks.
>=20
> Fixing this is easy: have ingenic_tcu_{enable,disable}_regs() always
> clear the stop bit, regardless of the presence of a global TCU gate.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Tested on JZ4770, it still works fine.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Still needs a Fixes: tag (+ Cc: linux-stable) so I'm expecting a V2.

Cheers,
-Paul

> ---
>  drivers/clk/ingenic/tcu.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
> index 201bf6e6b6e0..d5544cbc5c48 100644
> --- a/drivers/clk/ingenic/tcu.c
> +++ b/drivers/clk/ingenic/tcu.c
> @@ -101,15 +101,11 @@ static bool ingenic_tcu_enable_regs(struct=20
> clk_hw *hw)
>  	bool enabled =3D false;
>=20
>  	/*
> -	 * If the SoC has no global TCU clock, we must ungate the channel's
> -	 * clock to be able to access its registers.
> -	 * If we have a TCU clock, it will be enabled automatically as it=20
> has
> -	 * been attached to the regmap.
> +	 * According to the programming manual, a timer channel's registers=20
> can
> +	 * only be accessed when the channel's stop bit is clear.
>  	 */
> -	if (!tcu->clk) {
> -		enabled =3D !!ingenic_tcu_is_enabled(hw);
> -		regmap_write(tcu->map, TCU_REG_TSCR, BIT(info->gate_bit));
> -	}
> +	enabled =3D !!ingenic_tcu_is_enabled(hw);
> +	regmap_write(tcu->map, TCU_REG_TSCR, BIT(info->gate_bit));
>=20
>  	return enabled;
>  }
> @@ -120,8 +116,7 @@ static void ingenic_tcu_disable_regs(struct=20
> clk_hw *hw)
>  	const struct ingenic_tcu_clk_info *info =3D tcu_clk->info;
>  	struct ingenic_tcu *tcu =3D tcu_clk->tcu;
>=20
> -	if (!tcu->clk)
> -		regmap_write(tcu->map, TCU_REG_TSSR, BIT(info->gate_bit));
> +	regmap_write(tcu->map, TCU_REG_TSSR, BIT(info->gate_bit));
>  }
>=20
>  static u8 ingenic_tcu_get_parent(struct clk_hw *hw)
> --
> 2.35.1
>=20


