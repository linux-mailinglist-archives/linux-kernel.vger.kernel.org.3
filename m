Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C3351F1BD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 22:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiEHVDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiEHVDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 17:03:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A166BCB3;
        Sun,  8 May 2022 13:59:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l18so23352644ejc.7;
        Sun, 08 May 2022 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jAqj/OJEjy+6GJVxTT9oYNk8MhLxODI4SDyZ1kXl+8=;
        b=SiG6BXJa3Hmxnqnyf+EPE0jG29vNhWL1ZkWQFhbnPw5KBXPrAfeo6HACtZsiHj8AiK
         Exckinl6QKzyB1jdDgAGB/BCNg7PMlOQhBX5RxPwK+DoXM3y3ShWeUqhDWIEzoM6zugZ
         rS9C4JFiAxjQRWmaO4enV3DNFhTeu5YzspghGnD1xo9pmIsNXGOILoMmPvhs2P1MujrM
         TY2G3Lr7H2LdgpZv4P811O0ubTlj+jXXqCnJyVlmwkSQ+PVDslDv+mLMLQhOVkQ9TpsG
         syK3rKIFgn1E/cgHnZJryz/E34NLy2CcJg+2qfqO2zr1LXcKl9fy+supAzUZfEdjH2IJ
         NDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jAqj/OJEjy+6GJVxTT9oYNk8MhLxODI4SDyZ1kXl+8=;
        b=A7Qo7HSYWoLhVt5pUhVjK32auM0PejaQwgE8SMbRSB+qnoXzCcw2eeRdYJP+Ww+rp8
         cZpTYuPrGLljLi7O3fbso9Uo86+yX3EEAFC5d6WxSBnxK8KtOJ72t7+OsvcgMQa7vjiS
         Y/A7GsZtTCIQA62wgZepICeoWFTuv7/kAe8nD5ypeJtzNRN2vamuubamKX8E32QdBznN
         vQaE7XDnUzQN18pFI/pnxonhwwHp5vgQPumKvKErS+gWTUnF4Er0yeIpA2wZPFnlc5PQ
         lXu5zONbhbP1KzrmfgXonWiGYuVXy7gecn290o7JcuMgoo9BvHEq/g814Gy9hJw2qHTB
         jG5A==
X-Gm-Message-State: AOAM533Ld1yATLN6VgkdsT+KlybCnPJoj20wKkIyymgSe8nnDIIFLdC+
        GalBRSxy4fmnooYYe0U3CE4=
X-Google-Smtp-Source: ABdhPJxXZn1Sidq7bQhKq3jSUOV0AUtIgx/F+6rnYKFC08z1ZqPpV6ceuyjMR526F3qMEMaLxpJZLg==
X-Received: by 2002:a17:907:7e85:b0:6f4:78f1:75b5 with SMTP id qb5-20020a1709077e8500b006f478f175b5mr12088585ejc.54.1652043588983;
        Sun, 08 May 2022 13:59:48 -0700 (PDT)
Received: from kista.localnet (cpe1-3-76.cable.triera.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id h6-20020a1709062dc600b006f3ef214df5sm4398243eji.91.2022.05.08.13.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 13:59:48 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Dang Huynh <danct12@riseup.net>, Dang Huynh <danct12@riseup.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ARM: dts: sunxi: nanopi: Remove input-name property
Date:   Sun, 08 May 2022 22:59:47 +0200
Message-ID: <2111060.Icojqenx9y@kista>
In-Reply-To: <3427349.iIbC2pHGDl@kista>
References: <20220425064231.243482-1-danct12@riseup.net> <3427349.iIbC2pHGDl@kista>
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

Dne ponedeljek, 25. april 2022 ob 17:38:58 CEST je Jernej =C5=A0krabec napi=
sal(a):
> Dne ponedeljek, 25. april 2022 ob 08:42:32 CEST je Dang Huynh napisal(a):
> > This property doesn't seem to exist in the documentation nor
> > in source code, but for some reason it is defined in a bunch
> > of device trees.
> >=20
> > Signed-off-by: Dang Huynh <danct12@riseup.net>
>=20
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks!

Best regards,
Jernej

>=20
> Best regards,
> Jernej
>=20
> > ---
> > This patch is a split of this treewide patch [1] to ease the=20
> > maintainers.=20
> >=20
> > [1]: https://patchwork.kernel.org/patch/12633497/
> >=20
> >  arch/arm/boot/dts/sun8i-h3-nanopi.dtsi | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/
> sun8i-h3-nanopi.dtsi
> > index fc45d5aaa67f..a9f749f49beb 100644
> > --- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
> > @@ -75,7 +75,6 @@ led-1 {
> > =20
> >  	r_gpio_keys {
> >  		compatible =3D "gpio-keys";
> > -		input-name =3D "k1";
> > =20
> >  		k1 {
> >  			label =3D "k1";
> > --=20
> > 2.36.0
> >=20
> >=20
>=20
>=20
>=20


