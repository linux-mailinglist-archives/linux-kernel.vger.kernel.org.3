Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEEC5615EC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiF3JPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiF3JOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:14:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6832B25D;
        Thu, 30 Jun 2022 02:14:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v9so10707083wrp.7;
        Thu, 30 Jun 2022 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7JAcCx7O9WUA8J/ba2CcG+LAyXJgnH1EmqzxH+erpu0=;
        b=H/KLoQkK3aXUvCfb0E+7GO5SYDJOgYT0SdIyendvDiQfizylQajKEa1po19yIeeky3
         N+He4xha0qGy7V8wvu2WDAIO60Qw5RchPssk19dQnMrvK70K03/yl/BxSUmsBJxe8RrS
         ZgZ9rlhPt/F3WO5q2L7n599zip+xP4LP7oKpsP8MYtT4W/rRP6TZIDZj4QiJYGtvMtuk
         ib2eM13wI7bAcR1wtBAudinUhf/uKCcJBs4N71JKzx6WhzCrZvvcZA8ruv5X1t8MSp/K
         a/7eh2fM81ZELCNZ9e7WhwJSSAs1GchTkFsJaemrCuHrcqKDKitLO+dehYrNCGsyw4BM
         3kWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7JAcCx7O9WUA8J/ba2CcG+LAyXJgnH1EmqzxH+erpu0=;
        b=HzPAa8bLuIKqli2dwznDPXztpGhNu+Gchj1LEX3k0tMmRyEAGJBkihSZdvtHeNUiMM
         yJjk+6ybZDzlk/xseXOOhyCiOXhPvBr1IdLoLIM6vn24Zn2cIK/5AqaCc2UxkXR3rEcA
         kJwNZJGA5aMq/hWxccK97wNz8MW1P0VfV/d44x1bEDksfbJ2Ut7r8URtKtD7k6RYis+B
         PD2XOyvmqtWuxOlukJKNQgijhC8PlWuz6gCsAlieZc4741d5wehanrFpANemw5rLMast
         Trq0cnlo7/i5Dt1KCbO/BmmV0tRFHx3Ossc2R0KVmpR1d2Mh4sp+X3O24ETbh8Yn1AjF
         5F0Q==
X-Gm-Message-State: AJIora8nB4poV5JTVSQCUhTZvUIAFxbMyhj37H2F1KT+z17buTZoVBeY
        nFMEka6AixiPkpPTHcCNdPs=
X-Google-Smtp-Source: AGRyM1vDbKEg9OcaNLJk5Ngw5sO6akBRQyPmzcTzpvlzIUjFhFX2UUC4/7O5IrpaWjMnaPe6GlGQhA==
X-Received: by 2002:a5d:43cd:0:b0:21b:8e53:befe with SMTP id v13-20020a5d43cd000000b0021b8e53befemr7578627wrr.255.1656580477535;
        Thu, 30 Jun 2022 02:14:37 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d11-20020a5d4f8b000000b0020c7ec0fdf4sm22111504wru.117.2022.06.30.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:14:36 -0700 (PDT)
Date:   Thu, 30 Jun 2022 11:14:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathanh@nvidia.com, spujar@nvidia.com,
        akhilrajeev@nvidia.com, rgumasta@nvidia.com, pshete@nvidia.com,
        vidyas@nvidia.com, mperttunen@nvidia.com, mkumard@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/6] clocksource: Add Tegra186 timers support
Message-ID: <Yr1peqpxxnKRb0hq@orome>
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
 <1656527344-28861-3-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cBR8FTKly7EDP7kt"
Content-Disposition: inline
In-Reply-To: <1656527344-28861-3-git-send-email-kkartik@nvidia.com>
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


--cBR8FTKly7EDP7kt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2022 at 11:59:00PM +0530, Kartik wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Currently this only supports a single watchdog, which uses a timer in
> the background for countdown. Eventually the timers could be used for
> various time-keeping tasks, but by default the architected timer will
> already provide that functionality.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>  drivers/clocksource/Kconfig          |   8 +
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/timer-tegra186.c | 508 +++++++++++++++++++++++++++
>  3 files changed, 517 insertions(+)
>  create mode 100644 drivers/clocksource/timer-tegra186.c

Acked-by: Thierry Reding <treding@nvidia.com>

--cBR8FTKly7EDP7kt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmK9aXoACgkQ3SOs138+
s6FwsA/8DV6vLB6MXZtumwhezE3wsbKfHf83SlGKfBLk8X1grMAMjk+GAO/XPTGs
lArH01aDGyDdYmJZyhdUpg400lcqkKLGpf1m4qs59YjSRlrS2+3Cdq8NVPvI/6LT
M1egmja46jPT8FgxNR+p1mrJqUE8/1pXF959whU/uBI9o7E7rXEeUWFTZhTT38Q1
XGz68FZ05iMPFnstSXueTDpAaW/xTXa/VFKDQ9mnVnQaxdvAn6WXsRWbZLVmQxv8
M2F0tAONFlvi3wfDsP94oBBPgmpLiF4nr9eh3VuSAkUoRK46k/viRMtYqHUgoIb2
wYZmb/2SMxs8KeYOxDTztHA1wEEbG3v69r+w9PbxzgBkfnuPUt2KfVarcS+LV13M
fcBd2XDbqKB+fnMo8ssh/+tmUYrs/6FKYhcBSv4RRIBuyfJG3HEeft9QTsU0jbF7
U5qRGUtX+7iNx2E5FGS1Klztuc7SK9em+bqN9sZjTq8m7fZ/7QCXovdkJoaxBDbV
uqfy0Dk5cAOFJt4qZjM02RDtO/x7+Wu4Zt4+skMbkVB3E3vZhTkDlMeh3BnfMM7x
wc8/X/KiXUGuXbKkFVNB4SaiQAdRgwprb6flc2+Sc0yoc8HhceDx7vs0pGod2rjg
c2wxVZONssjZG4wJRS9ss2k/oalWCr2v4SPHTG9KaJVVCoQ9WJw=
=disK
-----END PGP SIGNATURE-----

--cBR8FTKly7EDP7kt--
