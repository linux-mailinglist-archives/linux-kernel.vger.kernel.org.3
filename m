Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183EC4E5AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbiCWVcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiCWVcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:32:03 -0400
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 14:30:32 PDT
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF93D3E0EE;
        Wed, 23 Mar 2022 14:30:32 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4KP1Xz15lyzDs6Q;
        Wed, 23 Mar 2022 14:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1648070579; bh=K5DayJKzywfJ8rV0t5+qTTJdDuq8sxKxz9R1nJWR6v0=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
        b=efwQCJNGWb3akNgwGKrZEqvn2jHIW0+yj/ELXOU/nsFhcwWR2dGCaJIYR2c86tXDo
         L4QzMDn4IL56xtKoZogZUOXVI6a3XCMjccamKMzwWsW6d1dlVjCv3Mn5Zmx41qpBgH
         VzWxTajgfNSZWd7XiaFzPsh7na5X2Vb7TdaXYBsQ=
X-Riseup-User-ID: 3E5567DDA8FA81198A5EBD1492A1B1F43CA8B82C4894982B0AA93A2620D2FCED
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4KP1Xx5LxLz1y9M;
        Wed, 23 Mar 2022 14:22:57 -0700 (PDT)
Message-ID: <275245e8048fa124055d9ff3d10ce6562294483a.camel@riseup.net>
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>
To:     Manuel =?ISO-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Yifr4etBFPu1a2Ct@hermes>
References: <Yifr4etBFPu1a2Ct@hermes>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7NA5b+BMyLiRNR4ZGUnP"
Date:   Wed, 23 Mar 2022 21:22:49 +0000
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7NA5b+BMyLiRNR4ZGUnP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-03-08 at 16:50 -0700, Manuel Sch=C3=B6nlaub wrote:
> The HID++ protocol allows to set multicolor (RGB) to a static color.
> Multiple of such LED zones per device are supported.
> This patch exports said LEDs so that they can be set from userspace.
>=20
> Signed-off-by: Manuel Sch=C3=B6nlaub <manuel.schoenlaub@gmail.com>
> ---
> =C2=A0drivers/hid/hid-logitech-hidpp.c | 188 ++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 188 insertions(+)

*snip*

Hi Manuel,

Thanks for putting this forward, although I am not sure if this is the best=
 way
to handle this.

Before anything, could you elaborate a bit on what lead to you wanting this=
?

There are a couple of reasons why merging this in the kernel might be
problematic.

1) I don't think we will ever support the full capabilities of the devices,=
 so
configuration via userspace apps will always be required, and here we are
introducing a weird line between the two.

2) There is already an ecosystem of userspace configuration apps, with whic=
h
this would conflict. They might not be in the best maintenance state due to=
 lack
of time from the maintainers, but moving this functionality to the kernel, =
which
is harder change, and harder to ship to users, will only make that worse.

Cheers,
Filipe La=C3=ADns

--=-7NA5b+BMyLiRNR4ZGUnP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAmI7j6kACgkQ+JPGdIFq
qV3jwQ/8DPkEGDhXfUMS/tEHfeP3AMV3pKrpIP0ccAWDQUCJdmowjGrdrbM/AVbs
3RIxMULEuIk94kY0oQbmumQhbd3xyGC8AgQ1F0jgVc94w3RQg4R4YqdMk7HLeqrc
GfrO/u2RUR6T5B5+oas0LZ/9HmS/wbPdVg8B1Ucvs7Zk9090gyx0HxXDVg/VJ6kj
HRG2BH1c9wDDHv4mRcZ0n8gsmhzHEFkpeCDeUEmgyJZ+LC11DdVjMGIl3vB2HXPC
WcHNjz5OIrWZKSqdoiyN6yUZqc6GuoPhB8FW+kRNfUnQA5kZFAQrTZDfQ709HOj2
cJ9QylEyJy98pGLRRwoev+yX9hKFwmRDnS8H2TqiKCWcuS+GMedFtO8mJRFSSaei
7yfN+Udw8fWm26ctitqO7RmUuEs9V0WCIi0DkjFYhf9oqYWZUlxC1xuJYSR3Nt9A
7eytHD6TWmL3x9GCMs3YbSVd6xxPgwDOwnx6PwaopZppyLYsQjIzRCwyznea17Tv
DNcfZUdijLORD4G2uiq5FhlRT5Pjly38TfYTen9PsNwMScYccp4mDX2xToRTo/0A
YTZk+Gpy4hDDEw7nXhCq8FuDniK1pFrRUVO8BUfZmc3drUDk/lAQmzjbPQoWEE0J
c6t9Zl26T1xQY+htIwhWMUfyTpWopdUmFilQLCi/yatiw19V5ak=
=LrbX
-----END PGP SIGNATURE-----

--=-7NA5b+BMyLiRNR4ZGUnP--
