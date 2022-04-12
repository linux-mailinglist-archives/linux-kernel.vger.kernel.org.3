Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070054FDC55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379187AbiDLKTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378009AbiDLJ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:59:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B268205D4;
        Tue, 12 Apr 2022 02:05:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b15so21563186edn.4;
        Tue, 12 Apr 2022 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JvUzj4eJQSW6VlbLUjMSITUiq97FPtxDr7ncwYmoRZw=;
        b=PQN4pGhpOlIZoayWPrUBzGowazBqMXrd4jRr1snIyitef4NjsLhheTAe0qQ4xxS53b
         3Bt6MF+gTSAJvT6Dr3An/eqtqMwA/5zAkSdx9c7loYNVNFh9WM+LFbECAWMLVRdG5mYk
         EHaD8+YmvSfCswWysoOwVBSMt1FW0TYI80ssVuaKlsX40TIA1HRDORT8I2xQLJg1MiMs
         Yx/pt7YehaJjEiMKaTBxBkXZNXuWm38BnB890ruRydAj6g6KeFCaBmrdhEULfmwVXtvW
         JuXDdKRrxlc7wpyYmrYqigcamJk84SaFG6J8AQDlYbDZrY894fzLN+jF/gyZI2J22cJA
         G+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JvUzj4eJQSW6VlbLUjMSITUiq97FPtxDr7ncwYmoRZw=;
        b=apipqC5iq8qGmSdZFgX7WK8tmdHuIHRk8IzpIu6qFqkTKLsHzlVxoo5Fq7f6oq7upL
         qqlFFiABi33laX9LmL4Bg5AwNT/OKMyyJ8G2HUjNFhEX2+AiObGv7z5UutbIB/ap0GOD
         4daMLZMq8VIjWXUs+gYvFEIGwX7ABy/ezDHDJzXKbHidlhe7w3aZwezfVZrAsl7eUN3S
         F86jKysoOT5+E41CWIMzQpBFCSp4mXOZjEpPIPn33mkuoYwciyuhtUVMYgHL1e+iYSMB
         f3TZ8efmMxMR8lOdgHhiAIVgsXfneL3Dlbm1zXidw9zbJ6FMEM1n2uURWBbY7KI1yVe3
         corg==
X-Gm-Message-State: AOAM531lq5w84URxPGf8nDBU4uHxBAwcEVwri+wNPlh3JMus3uQjVExT
        27BURn0Kk0AB8oAu0rs5pFs=
X-Google-Smtp-Source: ABdhPJy7UIlkAw90AvWa8CNYC9UtMZpU5M8mz2CPjgf62C2T/CEb2v4+GAYAJGpj0vByS1chiMtK+A==
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id c17-20020a05640227d100b004191b024a04mr37474442ede.218.1649754319553;
        Tue, 12 Apr 2022 02:05:19 -0700 (PDT)
Received: from orome (pd9e518f7.dip0.t-ipconnect.de. [217.229.24.247])
        by smtp.gmail.com with ESMTPSA id d26-20020a1709064c5a00b006e89debe3f4sm1595260ejw.9.2022.04.12.02.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 02:05:18 -0700 (PDT)
Date:   Tue, 12 Apr 2022 11:05:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] arm64: dts: tegra: Fix boolean properties with
 values
Message-ID: <YlVAy95eF/9b1nmu@orome>
References: <Yk3nShkFzNJaI3/Z@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NBsBIpgqCfiMExLJ"
Content-Disposition: inline
In-Reply-To: <Yk3nShkFzNJaI3/Z@robh.at.kernel.org>
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


--NBsBIpgqCfiMExLJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 06, 2022 at 02:17:30PM -0500, Rob Herring wrote:
> Boolean properties in DT are present or not present and don't take a valu=
e.
> A property such as 'foo =3D <0>;' evaluated to true. IOW, the value doesn=
't
> matter.
>=20
> It may have been intended that 0 values are false, but there is no change
> in behavior with this patch.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Can someone apply this for 5.18.
>=20
>  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi            | 8 ++++----
>  .../boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts    | 8 ++++----
>  arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi            | 6 +++---
>  arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi            | 6 +++---
>  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi            | 6 +++---
>  arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi            | 8 ++++----
>  arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts        | 8 ++++----
>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts             | 4 ++--
>  8 files changed, 27 insertions(+), 27 deletions(-)

This causes multiple regressions on Tegra boards. The reason for this is
that these properties are not in fact boolean, despite what the DT
bindings say. If you look at the code that handles these, you'll notice
that they are single-cell properties, typically with <0> and <1> values.
What may have led to the conclusion that these are boolean is that there
is also a special case where these can be left out, but the meaning of
that is not the "false" (<0>) value. Instead, leaving these out means
that the values should be left at whatever is currently in the register.

See pinconf_generic_parse_dt_config() and parse_dt_cfg() specifically in
drivers/pinctrl/pinconf-generic.c.

Arnd, can you please revert this so that these boards can be unbroken?

It's a bit unfortunate because there seem to be other platforms that
also employ these in the boolean form that Rob mentioned, but I think it
is those that probably need fixing instead. Not sure what the intentions
were for those.

Adding Bjorn for MSM, the Nuvoton and STM32 folks.

Thierry

--NBsBIpgqCfiMExLJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJVQMgACgkQ3SOs138+
s6FAcQ//f9+PoHjpquYwfy+qc69MSz549E+MT1SBelK6GGDpNc7CWrtmujpeiTP/
bgA1e0TzCagra2528fAUyOtyAaVKPHS8BVt6OxptgyEgvwP2fygn83+2BIQsVar1
Ls092mvWt1GeHYri19DRt3L43JH1RlcYxaPsUbgWU2tucetEtEDndOVUki87oclX
se/tsVqGRA5B1FMFHPiVgJyTaFzJtiwkCZnH31BN3DRXSsOnkJr33fV5bQM4Ylg5
vxWmwURr1T7+vTgUSCxi2RNzYGAuveI/IGFs1QD/jddo8MEHqF/EHmGmPWHF5fta
iP3T6u7bSb0y433imp3GDtLFch/cJ4BZ9sIWfLqPXP06sVVMfbLq2joo0p26XEZ1
q7hxFhNrpWBpmEna+RtNQWLCbcW7BBI+v0f4VYml+xNVpYehqUfHwrOqLdURucPO
WbriU9+nODw81tLTJbSr2EGGvYi4uiGBZw302ZuApk2pOhF+Az9WnlxUHiM3Q64D
WFubEG7Ezq1lEFO4hD4zZs9bMhSycTi6LMIJRTz7HHH/qPubJ8DWRi/Npn7WjN5S
uzQyjmD9ei7E/jLb28Sa0TCk4zAKiZiSVWZF/ONXhJ4aGzkgLhebFgMlGOihj4Gj
4J3cLi4fOm2o4qU7axaSMb8yd6hAD93kKRIylehK0Lfdmt9pM4I=
=kKPk
-----END PGP SIGNATURE-----

--NBsBIpgqCfiMExLJ--
