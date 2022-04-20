Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DF05089B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379184AbiDTNur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379167AbiDTNuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:50:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7738427F8;
        Wed, 20 Apr 2022 06:47:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y32so3090950lfa.6;
        Wed, 20 Apr 2022 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EUDkuHiiE3jOGgT4dcOAN2NtXeesxDjziWFKWNdMwMc=;
        b=BKC/1S9Ee+T0NGL/P7YfvoKT+dmJL4wsNBQAfXHnjRNWR4dwf21aZ1dvxTCL8+/rcK
         wx/7Kdgs3LG3kiYeC7s42fviwXf3HkU73FmyIFTVGdfAIL086e4Lr6rt9FUpes8npNuo
         YqgxyBj+SQQbyGF5V/0aCcIS9T+WgmDGmbshBePWkv7J0HxB+hhY8vMGHV8D6sP4ueZS
         izBzCYnT8lfxOagMVj1412yYX1K4GQu510euYsM1uLWS1SW5IYazfIjJC9454mfBB1Kc
         DPHpXL1UznW8q/9oMBAAhXrIejAT7LgRQfykFkrKJe73x8IeMmjqEsfLs5X3c38b7vpK
         0JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EUDkuHiiE3jOGgT4dcOAN2NtXeesxDjziWFKWNdMwMc=;
        b=QpioY95bY3SYCHkPc4KDr2aiocKhvsvG9NLvI71N7dEwMFWGZBRQnwwsbsfISk33bU
         Yrx4d6oNjE9L8QMYLfTEGylolItqhpUzNN0H6FoAK8L7TGmkmWlrwvPR9rZGXX4N2Q9E
         /ouhzezW3YjabVHnbQBys/1WhNJu1vphV4g4kzyiJ1SV+APNp8TjAV4OHPkSfmnG/XPA
         jdz7WDXXR8UNZfN/o7llXRfG2RJy6W/p/YM2nYPymFMxEExqSQ8Wg3ssCgy+nCaTXOaJ
         cqrvWFK7vppVtZNtUa1dQgltgaEYQR4lwrmhqJe+TNsJA7RozwIzo5HqKvchrAuuPnGi
         /+YA==
X-Gm-Message-State: AOAM530nQ+iF00PwP3DnlCNyjaURy0Xmxo+kEI+wTL7HcHG35hPJcMsi
        fHxRRj5XJ3z6TYAJNGnJlHA=
X-Google-Smtp-Source: ABdhPJzZGRiSwSAqvgCP5AOIeyD7C70dmObSjXexKMSthWVgviMeZ0vUc/6O4elYeHnoz70VHTMwag==
X-Received: by 2002:a05:6512:2613:b0:448:5164:689d with SMTP id bt19-20020a056512261300b004485164689dmr14645349lfb.526.1650462471947;
        Wed, 20 Apr 2022 06:47:51 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f20-20020a056512229400b0044a6ac1af69sm1826081lfu.181.2022.04.20.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:47:50 -0700 (PDT)
Date:   Wed, 20 Apr 2022 15:47:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dipen Patel <dipenp@nvidia.com>, jonathanh@nvidia.com,
        smangipudi@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        bgolaszewski@baylibre.com, warthog618@gmail.com,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v5 00/11] Intro to Hardware timestamping engine
Message-ID: <YmAPBG6IknkLotJp@orome>
References: <20220329054521.14420-1-dipenp@nvidia.com>
 <CACRpkdbGyrRU9DDTmNDpU52rECAKY3wfi2y3jo9FMypDG=pmJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aQT/Tnz8hJhvHE9O"
Content-Disposition: inline
In-Reply-To: <CACRpkdbGyrRU9DDTmNDpU52rECAKY3wfi2y3jo9FMypDG=pmJQ@mail.gmail.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aQT/Tnz8hJhvHE9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2022 at 12:46:43AM +0200, Linus Walleij wrote:
> On Tue, Mar 29, 2022 at 7:45 AM Dipen Patel <dipenp@nvidia.com> wrote:
>=20
> > This patch series introduces new subsystem called hardware timestamping
> > engine (HTE). It offers functionality such as timestamping through hard=
ware
> > means in realtime. The HTE subsystem centralizes HTE provider and consu=
mers
> > where providers can register themselves and the consumers can request
> > interested entity which could be lines, GPIO, signals or buses. The
> > HTE subsystem provides timestamp in nano seconds, having said that the =
provider
> > need to convert the timestamp if its not in that unit. There was upstre=
am
> > discussion about the HTE at
> > https://lore.kernel.org/lkml/4c46726d-fa35-1a95-4295-bca37c8b6fe3@nvidi=
a.com/
>=20
> I like this.
>=20
> Can you put it in a public git and make it eligible for Stephen Rothwell =
to
> pull into linux-next and ask him to do so, as we intend to merge this for
> v5.19?

Do you intend to maintain this as part of the pinctrl or GPIO trees with
Dipen as a sub-maintainer? Or would you prefer for this to be a separate
tree?

Thierry

--aQT/Tnz8hJhvHE9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJgDwQACgkQ3SOs138+
s6GBVBAAoIufX261GXCPhjjv2Vpcv/Fcq66w2zBD79G3dM6msz72AoX/qFRt0ppr
G/6umVXxICTcvt+pCbtorBpAWfb8B38Z5Qr8isBHzhFL8lNRBBvF2PB2Tx1IAMrZ
CXL3pRfxv99bDxy9ScdHenFDzbASlLVPcRIRGJ2AWZipxx6+jg1BFqKti5RQl12H
bFYJo2G/FG2jSCCz9LEAgjzW/rWEMNDnoacyq7dvf9vUp9tjc2on9YY+MH6vPzmD
aM8LX5fZYyvarFJ0bZJoPXSlnzIZJkzj8QF/w/mUyipFPVubOWtFxcp+D9NdIkuh
4ZlXS4W2lLLvmQMWP/zn6fpKWl+I0buHPLF8rT89YgAGwA1fQqPNQmGUSs9Rjctd
Sw76IxkuTY7xwazAps29WUYc1hzDkA9ovt78DbyMRmoxT1naiLzzHwIinPr4X0Pm
0MwXUYQwrQ8jwm0WkgFND74GmaPQ3UZ8aBD+cGp3zQn6YLcttR0xzfdBBUmYE2ZV
Ygh+Mv5tUmz6theIk66+37qtKONoLjZZXoLcvBCzo4a/Tv95N6xRWeN/i6qIV8vc
myDSa2bkJ/NisM8kxYdUkW+kdZTfY22SXchL7dKDbdf1dkxvl8m1Apu2sLyzY6by
+hFVfp0+aNaP8/KP+KEAQFAGVae6of0GLiDOSppaSDqB/6Vry1U=
=EMoF
-----END PGP SIGNATURE-----

--aQT/Tnz8hJhvHE9O--
