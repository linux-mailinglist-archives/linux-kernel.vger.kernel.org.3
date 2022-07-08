Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38FD56BC7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbiGHOsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiGHOsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:48:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E9E7C18C;
        Fri,  8 Jul 2022 07:47:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r6so15715285edd.7;
        Fri, 08 Jul 2022 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T97Q4f+HcuNzzhbVtaPDkxyfQet0VOfUrtsgltNAGrE=;
        b=EQ0o/sI3JwH206TZ88dzrPwpXGxoM5o62ZdebnMA/zuDiwSpgEGdj/npAzY6YKNd7U
         vhREfRlgcDik2uT2DhASWZ1gh9KajYHiHGkE31JCdOCPRfSczlC30ixvaUckQJUCHA3T
         0SiH9a1bx+h+/dc9ot/5b/8+we5VZo+lgWjV1bP64PGFnggaYRWho1tT7XUHVDOHq4zk
         Lmv61+3F+j2OseQZYXQVKJvkzIugoq8gBAkk0sQGNKEqbrvZ5RvFhyIQBB3kYIT2eGLc
         GIfPoAI8/OWdTKQbuwRKHmfcgRTT+Xxb5aNG1oeSKJYm2N0b1+tag1T46NVJzO2qhoS8
         3dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T97Q4f+HcuNzzhbVtaPDkxyfQet0VOfUrtsgltNAGrE=;
        b=HzXHz7Aeiog+Ne9C3h3Ra1jqef/xL5tv0DGb4l9HFEwHGaNMUZbtPN1mxoOnwJ79CP
         sO8r+6Er2rx6nYJYNh6zopQe9A/Aks8VhHkUbAAI3AiviguWpVO/bD4JsT9/R9ZDGK29
         BuG/B5ATAW7iiBbRZwdTLAhKMiwGgG9iqBDiAloCXzoc13qzt7UdsjSoFq7uZQHn3kj9
         AbU3aPdxmfxdRYuHj1jQW4ghn2sQNpUd91dpG5A7FkaKiB5FLRsS4yTEMlJyI2Gj2dQU
         LgzyPHN/lhZbgQhxCDm7Zh/4NKOkv3Ss5FofqIHunNYXVbFMgo+3G+5vj8he74pFyja9
         cOaw==
X-Gm-Message-State: AJIora+Fm4kvz2WBwu6KJTRU49BzQEC9rgypB5tcjN1Kjcd/xO2BxaXO
        gueDtkprJSt9uXBTyP7wLR8=
X-Google-Smtp-Source: AGRyM1u3KQ2wbreR/BRqD8g5B4WWaioG+u9CNY+V+MDiDQoGkb0HoR1AUtG86POB8SEm56iHCb8juQ==
X-Received: by 2002:aa7:c9cf:0:b0:435:de3b:c499 with SMTP id i15-20020aa7c9cf000000b00435de3bc499mr5190761edt.321.1657291654294;
        Fri, 08 Jul 2022 07:47:34 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s18-20020a056402015200b0043a7de4e526sm7525369edu.44.2022.07.08.07.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:47:33 -0700 (PDT)
Date:   Fri, 8 Jul 2022 16:47:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Kartik <kkartik@nvidia.com>, tglx@linutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, spujar@nvidia.com, mperttunen@nvidia.com,
        rgumasta@nvidia.com, amhetre@nvidia.com, akhilrajeev@nvidia.com,
        pshete@nvidia.com, vidyas@nvidia.com, sumitg@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/6] clocksource: Add Tegra186 timers support
Message-ID: <YshDgwTIUKanczPJ@orome>
References: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
 <1656922422-25823-3-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u8Wyb4q+Kx8f/4q8"
Content-Disposition: inline
In-Reply-To: <1656922422-25823-3-git-send-email-kkartik@nvidia.com>
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


--u8Wyb4q+Kx8f/4q8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 04, 2022 at 01:43:38PM +0530, Kartik wrote:
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

Daniel, any more work needed on this? Looks good to me, so:

Acked-by: Thierry Reding <treding@nvidia.com>

I've picked up patches 1 and 4-6 into the Tegra tree, so you only need
to take patches 2 and 3.

Thanks,
Thierry

--u8Wyb4q+Kx8f/4q8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLIQ4MACgkQ3SOs138+
s6FdcRAAtm1z7oXg251GEXPbR81PR6J6/O0trrhI0jmaTi4i1VkAxadP68t0uZDu
LIyYKge4A2Ps7PApqyO17aFjBXPS0xXE00IqIgQiDEMdhJ+wiWZKEsksuhcKrSMc
1HEAOAS25bRLfQYnQZLQKV9bGEAPZZdqQQW0SE3s1jp3I/5gldnLS7F7Qnv4Vow8
rVY+7oDeWmCd/JheUxuOUoV2eIe2pdCsD8eOFbDSgsCKMz0Xukg8uZaPI8TyENjB
Sze2BC4yS+JO0pnxN312v0X2bJpj1k/cpIA/yeh8TX0wu5vWZW2PfJ792iVM8hfg
81L9Gy9PEHmKWx15FMne8rLI2DZ8vGqn6FRkZePAQl9PUwr3qbrzc6W+la9G3ky1
a5o5a2P3yhL6a1GKDTrA5v7uP2EulBoL8NGLnToaQjmDx3f96qcD5Y5WWrtZlsHH
B6CbWdD5Vmk+afIDm/OLSz0+B3ER0YXftT307atJpISgL7JIgjm7EfwkqGxksEcX
gT8oodGIPLDG/0yeVi5f5wiOTt1aC0Qaq9b62S/EOg1TeORTE6OzU7LXDiB3mLiu
ebPxrAYFMNL7D2FtPDi6HGWREH+X603Q204xZivLocfQJMQBTVrcsTLXv3Trqztm
wW70t2Lx+bTh2RjM404xRPhlClIrUaRA9lUmG5P9gh6dNo/UMgc=
=4vyp
-----END PGP SIGNATURE-----

--u8Wyb4q+Kx8f/4q8--
