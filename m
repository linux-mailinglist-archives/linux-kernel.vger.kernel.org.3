Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1054F5DA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiDFMSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiDFMSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:18:15 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C550E459
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=BAvepl+m4lr4VUIlMDK9326Co7aN
        ArbKAWcyhN4afso=; b=nL7rIFi0g1Gsg5GL+LUrgVEpQYDnJCkVlcHQNOeVYX+y
        T+TW2ZWIodS/ULoqjVQRsNm/3BrKi+qAOE5zFOlaJltd7WQNruNAcKQE6HLWE/hw
        ZqoZgWuHY9DtGPmMENxWFhxUqkFsXlps1Uol3wIL0uIR9V5MWWcwwtDcy52oYX4=
Received: (qmail 2628494 invoked from network); 6 Apr 2022 10:02:12 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Apr 2022 10:02:12 +0200
X-UD-Smtp-Session: l3s3148p1@PEhhx/fbSpQgAQnoAH8rAO83AtqmbDBd
Date:   Wed, 6 Apr 2022 10:02:11 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/10] mmc: core: improve API to make clear hw_reset
 from bus_ops is for cards
Message-ID: <Yk1JA4TWO9bTt0kb@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
 <20220321115059.21803-9-wsa+renesas@sang-engineering.com>
 <CAPDyKFqwgxhRPBabxfUTC+8UVegWrTg3F0nRn3PoToiO2DWtvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WmgP1hItt5WDz7hZ"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqwgxhRPBabxfUTC+8UVegWrTg3F0nRn3PoToiO2DWtvQ@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WmgP1hItt5WDz7hZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > To make it unambiguous that bus_ops->hw_reset() is for cards and not for
> > controllers, we a) add 'card' to the function name and b) make the
> > function argument mmc_card instead of mmc_host. All users are converted,
> > too.
>=20
> Again b) is sufficient in my opinion. All bus_ops are for cards, while
> host_ops are for hosts.

Okay, this argument I buy right away.

> Also, there may be some corner cases where b) can't be done, like the
> ->remove() bus_ops for example. In that case, we either have to make
> more re-structuring of the code of simply live with that there may be
> some special cases.

With the above argument, I could even imaging to simply drop this patch?
That keeps 'host' consistently as the default argument? All given that
'bus_ops' are for cards anyway.


--WmgP1hItt5WDz7hZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJNSQMACgkQFA3kzBSg
KbZerRAApvClAIJvXDjBVi5cIAt85vX1GGEV2WMs29A02GLYHBpBp+U3Et/rsA6o
DWg+xLV8zJTZw+D2RJOAvM8lq6nMmTiGn67byy79huhwUr6DtYlvKKIIizR7Ae4M
niV0TXz1vv97qd4RdfJ8SjRyNoFAJOsJIt7zGkuuXviaBIc+5GwJyWYdM48Klgqc
9B8JUutPyHmxbwIeH+lUZfaY87WTTypBWQehJJIZN5+vcFyVz/l93OL8wf727VDX
LujbAf2WlvFTLjrHs6QPSuq2IUlbILazWBcILMOKlYMFLy8+ETvX99x1rj5pV4Bv
l6p5Q+KOW428FyjMBoYOMYzlI+BNL2Ym9f1oM6vAuOfoZbtMENq6RDy67w5oovgm
DH8QMzyszLrASjzu4y/drWm3/d9Pge8FkhTF1RRi7jL0NnAMFtu51AzIiSN1OKlv
O87LZVSQTRcNo4/KhazHyMv6TxM1Ev7zRKvMkm/+/5OcoVZynBTDv46A/CNGA1oU
q2kggc5f69xTaQKAxOGwFJrdYvucqf3s11XiIdLdYU3jjcQmbKMLBruahi4x/WUr
zMh25xweGmwm2lvAGzs1fm3sZmw2lHwa0G0EeawGW6ctCK8l6iUD6xwGrXV09LcQ
9u7aJsJGkzYoMu+DSR/YJj+peBAIjA0fdwfYet37fjXcBr+vcFY=
=Fe4Y
-----END PGP SIGNATURE-----

--WmgP1hItt5WDz7hZ--
