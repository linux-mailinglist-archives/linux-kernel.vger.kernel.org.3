Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC48552179
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbiFTPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbiFTPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:45:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F681AD90;
        Mon, 20 Jun 2022 08:45:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z7so15664158edm.13;
        Mon, 20 Jun 2022 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rtXs7kbTYAIaKi3cLmcvhvj9LjGI2rwhz07by3dGrtw=;
        b=o7uHxiffDFsN/YBO0yimv8zrjf4lJWvAom/17OgGBiyzz9vkUlTwm/Yl+lT2ayjGLt
         fQuiblU8f0NtWxmZ7jTefJ8YUTJjE9zZCmgUQ+nmzGwMuZSXP3n0tcdgHSHss6EEY6HQ
         p7MJJvUcpuN+VxY0UbBg/MKvxLyLmq9h5EtPGHjQSy4G7w3K5Me1wxwbsYCz2HFEZbBt
         8fAEmVqwZ0hXFW65E9vqjcYo4fyPjKuQpyNGDaqnegWAvmsw+QYqKDQA7+R2qWCTksSD
         HZYQAPyfnyM+oyKQxv2cROwVDXJLocQv5j3Wf7J0V0JP4tiJklL76weWDDVBckK8E/+z
         QOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rtXs7kbTYAIaKi3cLmcvhvj9LjGI2rwhz07by3dGrtw=;
        b=VQr4t5gOS+AQyJvJIkC5Z7NXkgM+WXf/Adi8lTHGCGqN/uXRG5LIMKkTSooqPL5C11
         TT3e3ANHWSEzaXqo9+oN9/8Hp2p8x3gsoJpfEwCkDPNZ7ms37TRZVxA7P6hqIgMRxDgx
         6wisRCQwZkUhYMr76z/DsxOpLAf3BMCkUbSwXSNquVYekpMxosHY+i+hpuNcP8ACzc7R
         d2cuwmpYi8TrZVovVSQP1k1Gl9E37yb8+LDFJsjEbHJbpKpQTrf/HITG/Q/m3615kMNn
         9u8yd2I8PC1eCWRWe/D1xCRgARP4lS85B4AN52FG4jm2WL/KbBUAbncDhPUIZlE9m/Qq
         iWuA==
X-Gm-Message-State: AJIora+6l1gCcIjHAWxRNdiOMDfyv4id2UPJKsLPpS2I0VCMA5RaIMB7
        ynX6KDU7PRep6eo2b/8unNA=
X-Google-Smtp-Source: AGRyM1ujDQR9aZvv3au2jdETK0nvvmjLOG/uM1D6E/NFkZ1eQPLzbujTK+tJbCgfSYF28qMpSIQJmw==
X-Received: by 2002:a50:fb86:0:b0:435:7f5d:4cb5 with SMTP id e6-20020a50fb86000000b004357f5d4cb5mr8942887edq.163.1655739945357;
        Mon, 20 Jun 2022 08:45:45 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090631d400b0071c6dc728b2sm5895943ejf.86.2022.06.20.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:45:44 -0700 (PDT)
Date:   Mon, 20 Jun 2022 17:45:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Kartik <kkartik@nvidia.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathanh@nvidia.com, spujar@nvidia.com,
        akhilrajeev@nvidia.com, rgumasta@nvidia.com, pshete@nvidia.com,
        vidyas@nvidia.com, mperttunen@nvidia.com, mkumard@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/6] Add watchdog timer support for Tegra186/194/234 SoCs
Message-ID: <YrCWJpfobojqjhBw@orome>
References: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b82/QUJKb3XK5kW+"
Content-Disposition: inline
In-Reply-To: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b82/QUJKb3XK5kW+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 14, 2022 at 01:55:32PM +0530, Kartik wrote:
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
>  .../bindings/timer/nvidia,tegra186-timer.yaml | 116 ++++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   2 +-
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  16 +
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  22 +
>  drivers/clocksource/Kconfig                   |   8 +
>  drivers/clocksource/Makefile                  |   1 +
>  drivers/clocksource/timer-tegra186.c          | 514 ++++++++++++++++++
>  7 files changed, 678 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra1=
86-timer.yaml
>  create mode 100644 drivers/clocksource/timer-tegra186.c

Hi Daniel, Thomas,

any comments on this from the clocksource side of things? So far the
only comments have been on the bindings, so if there's nothing else on
the driver bits, Kartik could go ahead and send a v2 so that we can
hopefully get this into v5.20.

Thanks,
Thierry

--b82/QUJKb3XK5kW+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKwliMACgkQ3SOs138+
s6E+Ig//TlC+iFALnyPKXJqWBopRzUbPKeVZT+qb4Ucj/j9QjI95xY4uKiH5HPqU
IMgYuTVNezbsvh5H9bFGA1anEH2Wxq77e9C1CfC+Ym/mDl/ZuHPkTPPXmWUe0EoH
CvaaIpvLwlpaQ2Sl/E2h9hUdt2a4tkZKLQxwJGlNFJCAilof4w/dgy98QH/N2Kmr
wy+SEKRPEVP4DJrb+UB80NiOa0KuIGPAuXpPy0mtB07rhEI9mVPnD86gacPtQvzW
Pprae5BS0/YJi0zNUu5QdPrA7H3ga0Fp7HBSneKqJK/FSkvPGtHjw7wK1M7xL1uy
phC9b0aTHOAWzUKoYF9qua2DI5W5QPx+JwXbhENA4moa4lgXAVJM/SosVgsfdCMA
pBboodHeABtqOqcbOIlKyNn0b1d1aaJcp+KUgl5pmLDIJplSVZwSei+UtQ5lT2U7
+SPl6j02tkpw/ovjEebjypr1Fg02GHzf1LcMoSVvWcjvRzmWkPhNHrBs/7mgTLub
+eCEA04y5fuhsMDpAHhB7dRplbtOzp0KZVFnWYE+vV3+FGw2KHQeWkXf1UU2I74s
z0AlEU/6BbNCZqI1j5Ach3C7BvAYAoMOOfH9XJ/O500ukgCZpfsvDHjIZDaxSzdk
IlaGkYjkkmWHuUf0+wL4cLEV6JVN3RSPG62rBkL89eghfM61j+U=
=9Pgv
-----END PGP SIGNATURE-----

--b82/QUJKb3XK5kW+--
