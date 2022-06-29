Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B4855F88D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiF2HNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiF2HNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:13:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758F7326E9;
        Wed, 29 Jun 2022 00:13:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LXt3q40F8z4xNm;
        Wed, 29 Jun 2022 17:13:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656486823;
        bh=b3IocXqxeZMPv/2DWEOClO6ETBKjJomsFK+gSpWHbRs=;
        h=Date:From:To:Cc:Subject:From;
        b=Uj/nK39+yHiyf93iRWaRjSaswQuylka73WYpkUYU1EMDj8rDZpND8Mwx7KVUGmEWX
         kbFQlX6C9u56N+pxKDPm09I065KJZDOUo5RvFqb53I3CP1UwEx2Wa9DSv5DFbkQg8w
         kTkTDC4sq9p3t6P8WJMjFJuS2MZm/PlOgN6Qmgmpt5lkhYu93F10cap3OGW22vb+t/
         rC8qocdQL/MPmEtbWyvCfCj6YT2sSnm0JUXQ37Yij5PkoEdicPMLh43cGs1FzajkAV
         kio07lk+t6WLO2AlsH+BDL2814LwW1L3R7c88yBZDiUpknvgdqFFObLBhYHFxMbJIe
         BlKKdX7V3qR+w==
Date:   Wed, 29 Jun 2022 17:13:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pinctrl tree
Message-ID: <20220629171341.5b9b5269@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SvXwb=6Qai0oe304PJJsOWe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SvXwb=6Qai0oe304PJJsOWe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pinctrl tree, today's linux-next build (arm64 defconig)
failed like this:

drivers/pinctrl/qcom/pinctrl-lpass-lpi.c: In function 'lpi_pinctrl_probe':
drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:391:31: error: assignment of membe=
r 'is_clk_optional' in read-only object
  391 |         data->is_clk_optional =3D of_property_read_bool(dev->of_nod=
e,
      |                               ^

Caused by commit

  36fe26843d6d ("pinctrl: qcom: sc7280: Add clock optional check for ADSP b=
ypass targets")

I am beginning to wonder if this commit has ever even been compile
tested :-(

I have reverted that commit (and its follow up fix) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/SvXwb=6Qai0oe304PJJsOWe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK7+6UACgkQAVBC80lX
0GxPVQf9Hcicv7JJcH6aPQrx8ZrBYOMtsFV+9GLnDMHmLJUWwKaaEx7dOLqPzbvH
mW0+/rpoY06CZuNBPiW2u/bUEQ5vmzcv4OE+SsFaHRYZAQyBQdN5soHYoeks+gub
hkwGIsgWV5c7otHQRvS530X9ZgCj794oLZOi3XlNwUbWM8kCId7JFzgU/E0uM2mg
Mp2xHRd4LST9Tqkj8O5wre7ZYw2ull41ZH9FJUMhWqmD+x0bVC4pSiSz4o61oAs7
7f5fmIZy7fdE5I/LxZzZ3q1hcRo3qtFO/5O3qAam0WOfntpcCUkA1ojA+tERTGdN
2kMiltoZp+qxL+6IIUY8Z6B3q9zrlQ==
=XYDC
-----END PGP SIGNATURE-----

--Sig_/SvXwb=6Qai0oe304PJJsOWe--
