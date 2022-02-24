Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946A44C2D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiBXNl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiBXNl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:41:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDF24FC4E;
        Thu, 24 Feb 2022 05:40:56 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a8so4395844ejc.8;
        Thu, 24 Feb 2022 05:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OtIKf+7z6cN26PveqgHj5P2ZBhojQfOSSI42f03I2J8=;
        b=LXi8fuRxXuYDOyME6b+AaEEa+RCOA1Te38QwedNpMxVT6d/ZoARYTi0b1u45AtopfA
         6wrRCZaxMR+XR8hn8CEpiCFoZGKvNOlG/sVWbHpVc2hGbAR2MIHlA4l1aberSHnAdl8x
         aRdUAYBtNpokxJxvno6Sp9LsC5C20v7LWKGUUIiYpLzRnv8262/ZwiwUMOR0rjl73fvc
         w34u4JMIlY/nnXQ9veIQRhxumWvm3kzGKaCy1c6g880n6kiOc6Y55AAsJSqYSl0RRkWe
         DaldEiCK/66ueUxYYUPrzS2oawzO/T5Ozyt5n8PxL2wLZbB15k9PcgpESZ9bFV6WGcEx
         6Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtIKf+7z6cN26PveqgHj5P2ZBhojQfOSSI42f03I2J8=;
        b=xu+27sq6bdwaZdJpNzXYTwWz26WQ0I1dXdg9CO6d+i2UY8p9fSzT4sxxnNQPJzWi3o
         jr8+Ltv0EJe02A0hr58JwSKQ+XF24dPYc8RfS76kkaY6xJbhsiUgi8oMCcJqTiKyrHj6
         Smsn1ky3fM+Z4ziC3i1PGNryuWS/1uUPGTcMzc2UptBHHtpRZNZeC8t+vkEklOjpCo5k
         xrH+OSiYapcuVBzULOLICkMrolXG4tWwUGjtpEhfA1T7doE/yp3m71IDOf2fxHeM/lOk
         cN4Oets1GF106Vj08bUv0O30csxMP8KQOmrkJkJmRaFFtO5us1yv5AE8kk2uz1LiP/7r
         oB+Q==
X-Gm-Message-State: AOAM532MYZ7GgeoPs+L9V881h7NEYSZEHCMTi0zF1efBs66OtOgkq+6E
        Aagxsjc3qkC+dH9yluVst4Y=
X-Google-Smtp-Source: ABdhPJwfYT01HQ1tCbz57HCwFnhjgxB0BjhcKiUt+3R5TB/lUIQ34pVVAX1F+8ev9JDL6OaPklrXYQ==
X-Received: by 2002:a17:907:f81:b0:6ce:7247:557d with SMTP id kb1-20020a1709070f8100b006ce7247557dmr2386166ejc.308.1645710054819;
        Thu, 24 Feb 2022 05:40:54 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id x12sm1364228edv.57.2022.02.24.05.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:40:53 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:40:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: jz4740: Add support for X1000 SoC
Message-ID: <YheK4+t9w5IeHiDT@orome>
References: <20220209231141.20184-1-aidanmacdonald.0x0@gmail.com>
 <20220209231141.20184-2-aidanmacdonald.0x0@gmail.com>
 <2SMA7R.9OBQWV0ONR102@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KE21u3QmCih2Rfpn"
Content-Disposition: inline
In-Reply-To: <2SMA7R.9OBQWV0ONR102@crapouillou.net>
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


--KE21u3QmCih2Rfpn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 12:02:26PM +0000, Paul Cercueil wrote:
> Hi Aidan,
>=20
> Le mer., f=C3=A9vr. 9 2022 at 23:11:42 +0000, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
> > The X1000 has the same TCU / PWM hardware as other Ingenic SoCs,
> > but it has only 5 channels.
> >=20
> > Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> > ---
> >  arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
> >  drivers/pwm/pwm-jz4740.c              |  5 +++++
>=20
> Please put the driver and device tree changes into separate patches.

Seemed a shame not to take this, so I've manually removed the DTS
changes and applied this to the PWM tree.

Aidan, probably best to resend the DTS snippet as a separate patch,
unless Paul also wants to apply this manually.

Thierry

--KE21u3QmCih2Rfpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXiuMACgkQ3SOs138+
s6Fcng/+ITgV7uxb+GLIEexW0f1xhKS31CQmh33tzizsVYdmFFYnGTBBmqJIBez9
pDUQOygsU+Fj+gdrTYT4zK828x/YZpgVyJpa2bFlZjglwzU6lmp5nAeowO9XdYQZ
kwbFjMkYyepAy/ddkmh+C8TjUd+h7JqK1TR1JV+eIX1WDIhBO76mbV1JLkkgBvo3
II6WbehJZMm48/q+ThqkMkNUt/XlavqqitXENHKH5neB4BsXvNlqoizHeRYLXMdE
MXW9bM1xVq+IRQ75Ytr7aKIAePcTQQNWvy3h0mGPSg4j2UTyowr7AqZD9RiFGmUh
cQ4un3otzeWfMMZmsr8xvPZjsI2VP48KpplKgxargDb3jxbxFlVGsjHlceyqfATX
7RLXuxiPUlHQvVLo8mohzmK6HXUnvAdyGO1/qUNoG4yktr6PjW60LtnwhM2VkS13
9QjpSgxANKc9Wo4HREMrtQJ8mDOLxgdmCU0TH2E3x/wLGMPF14n84bIQ4MHsFRwF
wrHgNweoJu/MZFCNIq/1t5xs+6BlI5CrHLKyPjI5gsBqhO841NQTGpxbb2fhMXPz
QKfI3G4ASjSvInXXXya42jTsikWiaXqGBIEV7EkNszM+vLa/5Iu25Hf+iR3lSFnZ
LbYSLtLklHgZ1Tvja3yDfl1470Zv8AcRYeU88HhQMzrxw8FRP80=
=OxUN
-----END PGP SIGNATURE-----

--KE21u3QmCih2Rfpn--
