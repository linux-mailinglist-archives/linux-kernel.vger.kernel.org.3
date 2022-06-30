Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EE85615C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiF3JN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiF3JNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:13:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600C31F2E1;
        Thu, 30 Jun 2022 02:13:54 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o9so25644207edt.12;
        Thu, 30 Jun 2022 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D1MB0+cRdMUm4U5TtLDd9s96TysqWuUfBpSmSXVHdQQ=;
        b=I7fTo6bvGkKGF/wh/EcfPMXOL1d145t8v+08B2hUaGGMUR24uHZARy+LcLfl/39Ukq
         Fyv852+Oe/W+yWBUapnsOFNyFa+eVaG7/AivIV6qWy7qyP3/uH1nOoZFCTZpsclK0YYp
         HWSSMU9xajH3tUj4XwTqro4EizsLIxJScupAqpeweCXv+EHP33m6d+XK40o5M9U4ElWw
         y9M+MC3yJU/OiVijGF0d01Y1FoOwFHPrYyMospRLIAsgv28HKrtxyO/lJ9ft9He1C+m9
         RqZHdWzMZFYhTy4VvGHSEHe+WhPX4YSr5pr0SKIPplEc3QbUJEzR7iKL984nIHg7kj26
         KlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D1MB0+cRdMUm4U5TtLDd9s96TysqWuUfBpSmSXVHdQQ=;
        b=b8kEbI2+SGTuwlEMVkZAANJxHFppVOTCIyr9HtmJhhzrRMs92ccMakrScemdfvIfNV
         4SXBvuFZx/RYwHHYTuDWRrrsz8+gRQRv0YIc0hY0lpwufimkwl54lXyaMiqRtGhUXX6F
         HdSScNvwgK5EkIv7Vxn6dZRuokJVLJ7ZyB766hOdMnVqcwbr38iVRdawWyJZ8MEgdl0z
         vIa5NgzWLcdOUtakNNmhxpEoq8Szt8Qm7aRAGo1vyoA7ChzHfdA3cFGhsHBeJwB9cYDv
         RvL1PRk4qJ9ycISgdV1nCyqMKZgi6gvCPQzxHCz9+dY1gXzqxWrvHctFd3OS2kKYFssh
         W7wQ==
X-Gm-Message-State: AJIora9bw8Ih7pa87ixBGJisL7+p8JOT6KjUr4ZTGpH9v1Ch1CSoh0Db
        MXGa66DwxLRv5hZGm2/dr3Q=
X-Google-Smtp-Source: AGRyM1vU2xhGxeW+z2ilaqgHJ72WOXIedRMja5eEhcS1HdkaZGmxC0GHJ9re59ox2MyGTV8VyLFv0g==
X-Received: by 2002:aa7:d685:0:b0:435:7910:f110 with SMTP id d5-20020aa7d685000000b004357910f110mr9966549edr.247.1656580432766;
        Thu, 30 Jun 2022 02:13:52 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s3-20020a1709067b8300b0070efa110afcsm8768854ejo.83.2022.06.30.02.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:13:51 -0700 (PDT)
Date:   Thu, 30 Jun 2022 11:13:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Kartik <kkartik@nvidia.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, krzk+dt@kernel.org,
        jonathanh@nvidia.com, spujar@nvidia.com, akhilrajeev@nvidia.com,
        rgumasta@nvidia.com, pshete@nvidia.com, vidyas@nvidia.com,
        mperttunen@nvidia.com, mkumard@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: timer: Add Tegra186 & Tegra234 Timer
Message-ID: <Yr1pTlG+ncPb1gjO@orome>
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
 <1656527344-28861-2-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vd7lLC28doTmyfX4"
Content-Disposition: inline
In-Reply-To: <1656527344-28861-2-git-send-email-kkartik@nvidia.com>
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


--vd7lLC28doTmyfX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2022 at 11:58:59PM +0530, Kartik wrote:
> The Tegra186 timer provides ten 29-bit timer counters and one 32-bit
> timestamp counter. The Tegra234 timer provides sixteen 29-bit timer
> counters and one 32-bit timestamp counter. Each NV timer selects its
> timing reference signal from the 1 MHz reference generated by USEC,
> TSC or either clk_m or OSC. Each TMR can be programmed to generate
> one-shot, periodic, or watchdog interrupts.
>=20
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>  .../bindings/timer/nvidia,tegra186-timer.yaml | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra1=
86-timer.yaml

Rob, I've been wondering about patch application with these DT bindings.
In the past I've preferred to apply these along with the driver changes
that implement the bindings. I realize now that that's perhaps a bit
naive because we've had cases where the driver doesn't fully implement
everything in the binding as well as cases where the bindings are
upstreamed without the driver necessarily being upstreamed at the same
time.

So I'm thinking that it makes more sense to apply the DT bindings to the
same tree as the DT changes that add corresponding DT nodes. This would
also get rid of the (usually temporary) inconsistencies when running the
DT validation (and even just something like checkpatch) on a DT tree
that doesn't have corresponding DT bindings.

Do you have any strong preference on this?

Thierry

--vd7lLC28doTmyfX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmK9aU4ACgkQ3SOs138+
s6H5YA/+JP38fIDSYI7G6PH2+aHJjdG2V1dNqG/fVZBC13jryVWQ6IT8zFdHXxf4
0TR4H0NwXANXxNNOUIm1/nW+r32ekkyu+BZI5Z+8iyDHEVWBDWP2OL9KA6dTi7BL
IsxiQ+YrU57t7+C8cVA9hme2e3neVsYLbfB+OnYo+O7E6jh4cnTOSviJ7y6TwIbK
ESNxtqxgpX41KL+xUiGejk67w/HwTwQ+Muh1cQCqbIF5GmEdmMgo6GUAUmdiDCAs
YkoQwSq5IQqVIwl7Ap6neo3btmuZHTn3WfIBnlfSGNLLv1rnh23NkJ/ZxAO1P/uR
wAuy2oSO8GblE71Hc5ZBkfCnp+3KAqiU/XOT4xfmr/mIGKcc47HSVtQAqx51HwPF
N2Nzd4CvUsasVVx0XGk3QsjlbPdxsqV4HOTQ8s7LY/32u2iK1Azw1uHS4Sat9+m2
BM/+qwwR0up2Gr4i1kicy2n/OO2F31s4fzliykF2ApPJp8auLynaKM2IEQNUWg9L
g1nJ4AMELc6lgSkipk0qy8/uy0hOn7rHqI9hZFPbUGMIS2oz5k9kVRcBj4zL4wzq
Ct2KQs3QjMqx12/LISaRmQLUoCQrfe/vTmhZr+om5M+RJprxLvW9DaT2HhrCBKvJ
3hqkIw+CDHOyzVxw+LL6oJTUbmGNk3Ta1f5YCOqzbifM3ZnLEJo=
=m1P7
-----END PGP SIGNATURE-----

--vd7lLC28doTmyfX4--
