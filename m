Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CCD4C2CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiBXNUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiBXNT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:19:58 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5C415F0AE;
        Thu, 24 Feb 2022 05:19:28 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 29so2783300ljv.10;
        Thu, 24 Feb 2022 05:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tqghmzvBgkIucPk30i/1RBMKSaH511u/5cafjui8mTA=;
        b=iKFH/nCaBtENJTdm/3S9PPj+rKJPlWoG/Bdq+HV8ObixrJFQhS4z1MOzotSNJCI0nd
         ptVocWqzyJjOOYzWBHrx1rrGloth2JPJn7sKGfp69htceG3vkWOOI7ADBxyQFYlDgN2z
         NQsYce8GSPFvHIZR+DXTINmFU3dygBa1goHxH8XOUBFrPyJGVylrvRKUftxXzlFu2nmJ
         9KTSYsAcAKaN4YUQJ/qIh2d9uViSMimGushKydp4n/EadtjRn6tXME9va1S3DH1Qc89F
         q7FH1qy92/ox3nO1WFvK2bhM3H3EW+Yg6iSaY9gLDWfSa6AYQrGsS4Abm++y4xBxQ8gV
         m9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tqghmzvBgkIucPk30i/1RBMKSaH511u/5cafjui8mTA=;
        b=gwT6VelWK9OHv+ySdNIE5CDMGZMAAn4d1g74cyW5IET5t3xJbkGvjFqmP9cVDw1L/o
         r0cq3prYqjEJr9DAEEoFmP1zQGnFu7GosQFIGm2382VcRIr42CHF1Dq3580cxamLLa3u
         m78SzAf/xk8r+sZRkoICmd2uLdEXKmzpjNKtPq0Z930nXYU2kB3bPFmUq1yTiO+CgX67
         ppbCcVNsfC7TL9DAHzm8d1CpvBVPln62Mwn/zE4zkxbPofWmh/iY0XatDlDw+ZEAAgh5
         gIYcntdAoJA6Xdh58w7/7faLSnfZjNC6Vl4QyOGzTey7usIMgo5ZxBY/8nIZ7R0T1ZeF
         Z/Gg==
X-Gm-Message-State: AOAM5320KgeaaUwMshNmEeXpjCBAexYFPyG0pthMG/RqYs+FulxguELh
        uXrma7lfSbm0aGE4HluNctQ=
X-Google-Smtp-Source: ABdhPJxOmmfqAiXnv6BDPZ68mjeGMsSCHie4qvts2pK3mFGPljn7a3XGoQ/aUJEYXFFRyqmHmevKDQ==
X-Received: by 2002:a2e:99d6:0:b0:23a:925:6aa0 with SMTP id l22-20020a2e99d6000000b0023a09256aa0mr1896124ljj.110.1645708766930;
        Thu, 24 Feb 2022 05:19:26 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id n3sm205819lfq.285.2022.02.24.05.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:19:25 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:19:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     conor.dooley@microchip.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, geert@linux-m68k.org,
        krzysztof.kozlowski@canonical.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-riscv@lists.infradead.org, lewis.hanly@microchip.com,
        daire.mcnamara@microchip.com, ivan.griffin@microchip.com,
        atishp@rivosinc.com, Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v7 05/11] dt-bindings: pwm: add microchip corepwm binding
Message-ID: <YheF2xMOEtuDwG0U@orome>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-6-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0UAUmyEyisF1FZUK"
Content-Disposition: inline
In-Reply-To: <20220214135840.168236-6-conor.dooley@microchip.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0UAUmyEyisF1FZUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 01:58:35PM +0000, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> Add device tree bindings for the Microchip fpga fabric based "core" PWM
> controller.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  .../bindings/pwm/microchip,corepwm.yaml       | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/microchip,corep=
wm.yaml

Fine with me to go through the RISC-V tree:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--0UAUmyEyisF1FZUK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXhdgACgkQ3SOs138+
s6G99w//bjUK/d2MUDOjWCCN+SjvFVIkEqIcEl2BOJoazBkO95myY4zU0P1kEZ6J
mhjKjqxDg/pa5ynS7Ok+UO0q3L967NngdXeYQaexGkM9CGvcFkL7LMpvQjF8kSzW
tz2dB3xz/NFcy62y883siihherqZb92tL4F//7+yG31PlUiTlTsZD+eYPbELTDHf
7WAmcfr37ROA1PHsaa+qbFGCVtOnJEUkh3YRvntQiFhLM6jP2Ng9MFMxbr0VQ8Dc
GMyS+2SbZN18FBHq+/gyV8dEVD4GEI0KzwXnyCE8Gog6Rrm0ViE0DhIC0rvfNt92
itZH1MJxItGlqukOE0rASVZScSsmwL5cBemlNKNVv2nW0ZBuXrcVARhiMP7A9mH3
RDrh9ryJFcyZQV55ENCZbIoqlcF54agHJdwRjDq++VHi6+7CeQEdgqzHR52nJ28Q
+l45smPbNP6hejF0uJq+nnQ5CrmsfnjNb6CEVU48FTOFS+6SBWJiHx15a3+xQLKO
HGGtNO7fncc3AGgbP97M8wWvGM5+cgEpKOkxLRHNu1DV676Reqo1wcagIgmjwYuQ
e4IZPadbpRH61AVEXlo8fVnnGVGehoc8nDVs68WZa5Uq0hUqkjQhs6IBgMyxTUdo
J3tjDezQfMxD0aigHvWyo8xWrSi0Xi89QHb6IKg+6OZgbnpb0EU=
=wbm0
-----END PGP SIGNATURE-----

--0UAUmyEyisF1FZUK--
