Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5978F564296
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiGBTsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGBTsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:48:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5ECD121;
        Sat,  2 Jul 2022 12:48:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id k20so6747128edj.13;
        Sat, 02 Jul 2022 12:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gz1+XuaI1WtJ5POZxlN5cbO7DH/6Zc9pmNew6XfWARs=;
        b=AulFQUq2u5EfzjQRsFUa7j+gQFNtQKmksPeuT2CkNiUZjcrH63cCL5HeBtAvvu0lu4
         XN27idgvN75nrHaQc7ao/8y/g+U3gcwg12w01U1n8f0AMwP4Xd8Pu8NwbruUPwYgQ/OH
         +FT801Xu1fn8cHuLIr66TPHAJj9P7woLeIVfdicNXKsQ3zd1OM5waJc5TQ0alS/eN/Qg
         Qbq9Xe+o7mXsOpWY/N+OJx2BfaLVVChF7tHxCl/C1ZCSpEpMgF8SQJP49PqBD00oLlvA
         1eLr3xa+Z4hS4yzus1j4fLzU+OJ1fA2JqZC7NGXSfVI/T5rK956W786zJsy+E0AuXRPa
         H23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gz1+XuaI1WtJ5POZxlN5cbO7DH/6Zc9pmNew6XfWARs=;
        b=Mxqt8oHSQ8MwRolAtXGBsyxPevlEgQJ8VlzbNa4p/9i3KDfk72nK7yPycsYa2BxDuS
         bQf8Bd+aukcYRYvaNFh1Q4mj4bkeeWuIK+a9d8zogJdgGHYXWCW+g2oLxk+GP9aTUlWy
         3IpcbZv1Uyd+1R6ZQP8OsI4ulE/2ZDzHigE2Gj+XZmm7Oap3MNXwSQTquXEPiy7u0T7v
         rVcum9o5HlDchZ3d1eE82h481DclFtGZ0H15WQRUBYpZRQutlbG0HaAF8LsV2gNMwN8z
         eyLS5t/xizZMR/7gKNR9NnWnBLujDLQfG91xBmSGEbS72CEp553iZ+kwfsvB6Mrr3dIW
         fZxw==
X-Gm-Message-State: AJIora95GYVVdaWg5vNNDLjcd71yVcU9veMKdgCo0NSpk4wQbNtxmoPS
        Z2nXvlitGnzMBbx1lqNOPdA=
X-Google-Smtp-Source: AGRyM1uQ5rANlaWGjtm/q+DOfz42euY/DfAfA1txdC0Nwzfp54NmoU9FEg3nDfopf1YcFabKINXNLw==
X-Received: by 2002:a05:6402:3490:b0:435:9802:96ac with SMTP id v16-20020a056402349000b00435980296acmr27159873edc.40.1656791289634;
        Sat, 02 Jul 2022 12:48:09 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id f20-20020a50fe14000000b00435720b7a1csm997479edt.20.2022.07.02.12.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 12:48:09 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/6] pinctrl: sunxi: Support the 2.5V I/O bias mode
Date:   Sat, 02 Jul 2022 21:48:07 +0200
Message-ID: <1793842.atdPhlSkOF@jernej-laptop>
In-Reply-To: <b1aaa895-59dd-bbb1-3dc1-9dfaa96dfdb0@sholland.org>
References: <20220626021148.56740-1-samuel@sholland.org> <1818958.tdWV9SEqCh@jernej-laptop> <b1aaa895-59dd-bbb1-3dc1-9dfaa96dfdb0@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 28. junij 2022 ob 05:29:51 CEST je Samuel Holland napisal(a):
> On 6/27/22 3:43 PM, Jernej =C5=A0krabec wrote:
> > Dne nedelja, 26. junij 2022 ob 04:11:44 CEST je Samuel Holland napisal(=
a):
> >> H616 and newer SoCs feature a 2.5V I/O bias mode in addition to the
> >> 1.8V and 3.3V modes. This mode is entered by selecting the 3.3V level
> >> and disabling the "withstand function".
> >>=20
> >> H616 supports this capability on its main PIO only. A100 supports this
> >> capability on both its PIO and R-PIO.
> >>=20
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>=20
> >>  drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c |  1 +
> >>  drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c   |  2 +-
> >>  drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c   |  2 +-
> >>  drivers/pinctrl/sunxi/pinctrl-sunxi.c         | 10 ++++++++++
> >>  drivers/pinctrl/sunxi/pinctrl-sunxi.h         |  7 +++++++
> >>  5 files changed, 20 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
> >> b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c index
> >> 21054fcacd34..afc1f5df7545 100644
> >> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
> >> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
> >> @@ -82,6 +82,7 @@ static const struct sunxi_pinctrl_desc
> >> a100_r_pinctrl_data =3D { .npins =3D ARRAY_SIZE(a100_r_pins),
> >>=20
> >>  	.pin_base =3D PL_BASE,
> >>  	.irq_banks =3D 1,
> >>=20
> >> +	.io_bias_cfg_variant =3D BIAS_VOLTAGE_PIO_POW_MODE_CTL,
> >>=20
> >>  };
> >> =20
> >>  static int a100_r_pinctrl_probe(struct platform_device *pdev)
> >>=20
> >> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
> >> b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c index
> >> e69f6da40dc0..f682e0e4244d 100644
> >> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
> >> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
> >> @@ -684,7 +684,7 @@ static const struct sunxi_pinctrl_desc
> >> a100_pinctrl_data =3D { .npins =3D ARRAY_SIZE(a100_pins),
> >>=20
> >>  	.irq_banks =3D 7,
> >>  	.irq_bank_map =3D a100_irq_bank_map,
> >>=20
> >> -	.io_bias_cfg_variant =3D BIAS_VOLTAGE_PIO_POW_MODE_SEL,
> >> +	.io_bias_cfg_variant =3D BIAS_VOLTAGE_PIO_POW_MODE_CTL,
> >>=20
> >>  };
> >> =20
> >>  static int a100_pinctrl_probe(struct platform_device *pdev)
> >>=20
> >> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> >> b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c index
> >> 152b71226a80..d6ca720ee8d8 100644
> >> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> >> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
> >> @@ -525,7 +525,7 @@ static const struct sunxi_pinctrl_desc
> >> h616_pinctrl_data =3D { .irq_banks =3D ARRAY_SIZE(h616_irq_bank_map),
> >>=20
> >>  	.irq_bank_map =3D h616_irq_bank_map,
> >>  	.irq_read_needs_mux =3D true,
> >>=20
> >> -	.io_bias_cfg_variant =3D BIAS_VOLTAGE_PIO_POW_MODE_SEL,
> >> +	.io_bias_cfg_variant =3D BIAS_VOLTAGE_PIO_POW_MODE_CTL,
> >>=20
> >>  };
> >> =20
> >>  static int h616_pinctrl_probe(struct platform_device *pdev)
> >>=20
> >> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c index 3c5e71359ca8..eb3d595f81=
6a
> >> 100644
> >> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> @@ -662,6 +662,16 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct
> >> sunxi_pinctrl *pctl, reg &=3D ~IO_BIAS_MASK;
> >>=20
> >>  		writel(reg | val, pctl->membase +
> >=20
> > sunxi_grp_config_reg(pin));
> >=20
> >>  		return 0;
> >>=20
> >> +	case BIAS_VOLTAGE_PIO_POW_MODE_CTL:
> >> +		val =3D uV > 1800000 && uV <=3D 2500000 ? BIT(bank) : 0;
> >> +
> >> +		raw_spin_lock_irqsave(&pctl->lock, flags);
> >> +		reg =3D readl(pctl->membase + PIO_POW_MOD_CTL_REG);
> >> +		reg &=3D ~BIT(bank);
> >> +		writel(reg | val, pctl->membase + PIO_POW_MOD_CTL_REG);
> >> +		raw_spin_unlock_irqrestore(&pctl->lock, flags);
> >> +
> >> +		fallthrough;
> >=20
> > Would this set bit 12 as needed? According to documentation, it's a bit
> > special case, since it covers VCC-IO, port F and port H, at least
> > according to documentation. I guess BIAS_VOLTAGE_PIO_POW_MODE_SEL has
> > same issue.
> Right, it seems we would need some mask to tell us which ports are affect=
ed
> by bit 12, and which have their own setting. The current code is unlikely
> to cause any issue, though, because in practice VCC-IO is always 3.3 V.

ok, it's good for now.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



