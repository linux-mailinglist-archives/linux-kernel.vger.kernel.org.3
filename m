Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974EB56BC58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiGHOnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbiGHOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:43:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0385C95C;
        Fri,  8 Jul 2022 07:43:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v14so30865071wra.5;
        Fri, 08 Jul 2022 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BRYUOnIWi5M57RJtVoXP/TsIE0FkF4fEBmfkJBAxfsc=;
        b=qnARdgQx4gnZeTzzAcEsjt9rOrq1mWFye/4tl4RW4Wn8qOWZyv5OhS7PloUC+ivWM3
         CiBDCjHcI6KwU7bWI33NF5BPulIVkHpFs5HiefkEVdKoNnDPXS2SgteAeXI0NaNRD0CH
         RrXpELj4GBCc9XSh70o/PS+W4hSComhsF7wRa1rvPBChc/1kDyGwbnbMA6AFNINkiGZg
         nVMDllGp6p37ysJuRRRV60ZTGKKhKfQJEVsrTtoH/qHbWVPrhwRfCVlnHbp6QlfZZlPh
         wsjORN14E75zElDlIZv2024snu/mNNigr80kM5gG4OITPYnqPWmIVOUnVpClvp7n0VTl
         ALuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BRYUOnIWi5M57RJtVoXP/TsIE0FkF4fEBmfkJBAxfsc=;
        b=PyoZGJoJwRUlUUr5qngR25Z2cI7GQ9bzZm9romb1/n82WKvIZB5Wrp3DqWcMClG0oG
         xcKhNH7qnm/bPsToxBwFy+U0GQyZngFv5uoV85V/Yy1RTVBEvhzyVkMVnA/61Koau4GB
         0ncn57DqPCkO7I8TnKS+RPKh1udFJHLpbn8xsHiMkhMXwmbh3loH93Ym69S/0ygx8P/Z
         8bVBZx2EdWTqutsirWBRpbVH6O9HSTjqM5pEgn4mZ1qmSK9DxcK2TSRxaxJ45T1iM8y1
         8UEawCZPD4Pgu705UbBGcfgu3nyJZ1PM1iCn2Dq5+j1fSJgRBf7jVsq7zfUNcwPrNMWe
         Io+A==
X-Gm-Message-State: AJIora+7lJMEWrSAxdBh3KG/I/coXPODTc+asOzV2CJSHGTg0Om2h+Lj
        jgeMnNu1sd9Cetswpu7VSnU=
X-Google-Smtp-Source: AGRyM1ubc04lQi1tUvDV3Y63BKlWZaD4Uv3ELSfpCzAWVUTgZxUTcZmmKl1JCv2tt5NLcapYwxTWog==
X-Received: by 2002:adf:ed41:0:b0:210:20a5:26c2 with SMTP id u1-20020adfed41000000b0021020a526c2mr3511818wro.603.1657291382091;
        Fri, 08 Jul 2022 07:43:02 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q17-20020adfdfd1000000b0021d4d6355efsm8018387wrn.109.2022.07.08.07.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:43:01 -0700 (PDT)
Date:   Fri, 8 Jul 2022 16:42:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jonathanh@nvidia.com,
        spujar@nvidia.com, mperttunen@nvidia.com, rgumasta@nvidia.com,
        amhetre@nvidia.com, akhilrajeev@nvidia.com, pshete@nvidia.com,
        vidyas@nvidia.com, sumitg@nvidia.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Add watchdog timer support for Tegra186/194/234
 SoCs
Message-ID: <YshCcySmxbP3zW+l@orome>
References: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="To66DtgvRzKF9iGi"
Content-Disposition: inline
In-Reply-To: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--To66DtgvRzKF9iGi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 04, 2022 at 01:43:36PM +0530, Kartik wrote:
> The native timers IP block found on Tegra SoCs implements a watchdog
> timer that can be used to recover from system hangs. This series of
> patches adds support for watchdog timers available on Tegra186,
> Tegra194 and Tegra234 SOC's.
>=20
> To keep the history intact, I added Tegra234 driver change as separate.
> The original patchset is an old one authored by Thierry.
>=20
> Kartik (4):
>   dt-bindings: timer: Add Tegra186 & Tegra234 Timer
>   clocksource/drivers/timer-tegra186: Add support for Tegra234 SoC
>   arm64: tegra: Enable native timers on Tegra186
>   arm64: tegra: Enable native timers on Tegra234
>=20
> Thierry Reding (2):
>   clocksource: Add Tegra186 timers support
>   arm64: tegra: Enable native timers on Tegra194
>=20
>  .../bindings/timer/nvidia,tegra186-timer.yaml | 109 ++++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   2 +-
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  16 +
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  22 +
>  drivers/clocksource/Kconfig                   |   8 +
>  drivers/clocksource/Makefile                  |   1 +
>  drivers/clocksource/timer-tegra186.c          | 514 ++++++++++++++++++
>  7 files changed, 671 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra1=
86-timer.yaml
>  create mode 100644 drivers/clocksource/timer-tegra186.c

Applied patches 1 and 4-6 to the Tegra tree, thanks.

Thierry

--To66DtgvRzKF9iGi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLIQnMACgkQ3SOs138+
s6F+3g/+JJ0EuV8vTrhiMebpmsXQPNQdTGJW2YkCiXhgTeBVn8WdDVX83JKANAFu
ylNX2oZZkLZBuhATumBu8+Cyq6Hoq9zOrECnyoJFR9hVh/Bi3GBnghofXmKw9t8J
9xKjfEtN1V/gPBo2K3El7fMcsZsfvGskZj+iMIKHCjWN5DUqdxS8tJ+TDkI8OGnX
zJLgNZs8snRQVuwDbLnEIOeDzJzX7CfUp1Y15OK5gMfczcJ1xWE2FH1XadDHwKpw
4wF2xx71py2sfKdHdK48FEkeXnZbfgtE8O2IJlF31by0qqDHLxVwqslATjn91Joa
LDg4Hrh+WnVFP7kfc9B2mLGWQAlwr53YKxHd+3Cc4MpYOyNwbEAvrQ7xy/y3tQFe
ZWj3MOiVEnDTS2fB5+ju/ZljLlDnsu9u3UHrv7H1Ztp0KdsFiAvvIpGkheocUAzL
vDYVwru/2+O6e7ZzCtWgl/Zol7hVwSuyXrlRRPcy2rxMl/K4/ZM1Nd3kiGU7QyTg
DmkUg9mJt6LcaVen9b9/HnAwGefPaAi+kgYfVl1cAaajNtyP8mkKiWaIw4ccY1o7
15dd2U2nJugYxh1il/IOklvsA97ECJqfhaiLKVej5qy+W7yrKO0+sT9mE3Ep2dSc
Qwq5wst6omfQyILHmHAiQM8k8g1MBQS2/TQo08gnWDrsXKyumtg=
=sRV5
-----END PGP SIGNATURE-----

--To66DtgvRzKF9iGi--
