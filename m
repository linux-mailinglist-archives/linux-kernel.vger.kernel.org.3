Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6384F5D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiDFMTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiDFMTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:19:04 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13B410A956
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=KaJn7Gi/gqVuEmNrjPS40alhwYrU
        tCotnu4qjAqSYL0=; b=L33fG8W7PM+IzXsntCFBZZSbQ86rEscCp16Vqa6gMSHB
        ZDI/f9dGPAuIneLHQqoDhOX5NpcDnzM6+/jf4Gl6jfMG9e0lEQR+W9S476LKu7ba
        2PomVEJh929eu//4Hs+wtZZP8OLSV6gUeHZAA9c0ztXc8+ix4K8hccLc6LCTWLQ=
Received: (qmail 2627153 invoked from network); 6 Apr 2022 09:58:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Apr 2022 09:58:49 +0200
X-UD-Smtp-Session: l3s3148p1@qlYeu/fbSJQgAQnoAH8rAO83AtqmbDBd
Date:   Wed, 6 Apr 2022 09:58:46 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/10] mmc: core: improve API to make clear
 mmc_hw_reset is for cards
Message-ID: <Yk1INkxW/i5p8yxf@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
 <20220321115059.21803-2-wsa+renesas@sang-engineering.com>
 <CAPDyKFqt8UUfGVHvpSX5ciP7qJReTYed=sffCGWPP9psS3vC_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cQf4rzNHPH4cfRh2"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqt8UUfGVHvpSX5ciP7qJReTYed=sffCGWPP9psS3vC_w@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cQf4rzNHPH4cfRh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

> > To make it unambiguous that mmc_hw_reset() is for cards and not for
> > controllers, we a) add 'card' to the function name and b) make the
> > function argument mmc_card instead of mmc_host. A fallback is provided
> > until all users are converted.
>=20
> In my opinion, I think b) is sufficient and would be a nice improvement.

If you say so... but I do wonder why we can't be super clear with the
function name alone without the function argument as an additional
source of information? Kernel hacking is complicated enough.

> In this regard, I suggest we make one big cross-subsystem patch (the
> smallest change as possible) then I can pick it up and send it for the
> v5.18-rc2.

Ok, I can prepare this.

> > -static void mmc_hw_reset_for_init(struct mmc_host *host)
> > +/* we can't use mmc_card as a parameter, it is not populated yet */
>=20
> Please drop this. The function is internal/static and at least to me,
> rather self-explanatory.

All other ?w_reset() functions have a card as a parameter. For people
trying to get into the MMC core, this comment might be helpful to
understand the anomaly? I know that you as the maintainer do know this
by heart, this comment is meant for people learning the stuff.

All the best,

   Wolfram

--cQf4rzNHPH4cfRh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJNSDIACgkQFA3kzBSg
KbZeZxAApOuKoRg/pcDM9Aqk/r5xQr0MifjkJ89D9Km+0feVU7H+g9UOwQnenXZ1
Ki6NIoiXNQQAUhRJP5gKjLZ1uA/mNNzYQqjLBmeRP/5r8y2CeNbR8wm83EdbmoRO
O8CR/2wwfWAhPtXz35yLq9+RKmKdiK3/UI/BYp9bupmM5nClDlVnMJa28qkp1TSg
dyiIQ40Smc1mbr9YTVIaZ8cxtookuczxhrUd+UyQ9MtBwq3LQ1DKR05BqRsv6AQF
J86gbBtjOr6ZyO4+3AS5+BLwQ2b1ZoZjQfPOcgor5+DYETIK66prurPL/ZEKLML9
YVoS77jnlyODq3LdMtYhLrJUZultkfO7f3r/3y66JBMuw8bNfLG8nbozT/7q81Mp
nHxARkZbV7syIRILUFcTE3MnhysgN55REfE4EuA2CnJ2dvmxCOI+HoscNIFE8X1e
wBTMz3LLnNmSHuCXh5mBT+dKMiKy0PsD0zs8ki7BhNPogOYC8evBobruUtxVo5ro
Z3cGAkRqF4GB7oCGFqEddbjeex2IOWBi1d/b8aA1RO40bxtyY2GfFewnCP2S4K5n
2kJY9B4zUMoA/jrZdWZzQJXgwsrOpJ2Lt57lkUOu6J4Tv3gaYYzG/TqFvH+IJZ4R
VfwSURSReiLjxIJCEzMYwYssXQkFr55vvexiTeeE47kjoHdkgC0=
=CuG5
-----END PGP SIGNATURE-----

--cQf4rzNHPH4cfRh2--
