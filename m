Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066FE4CDFA1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiCDVOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiCDVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:14:02 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD8A1A3621;
        Fri,  4 Mar 2022 13:13:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 48C021F46C89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646428393;
        bh=RKKH9mCEijwrali0AP0nm5HmTvlFtQFbxvyv6PiOXDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgBbTlhw3YrcIGW0FzuAI8sC3nj/kk35SVDwfILKnNOts6biRPBHoNCp0uoIR7olH
         iAfDJ71MtELCLlS022JbLNnycPtyVGRub498VdQULf3ZDcRPIzTZtBpvhcMU4mqtRt
         qg0rJ218QriTWBUFlU8/AX5RDQhfwmJlrIfyInY5TFFznz1mfGp76Xl7E7rq80aaTz
         HNE77v/ANia2kjBBm7IZatNBe7p/rb9kqY7tHV63HnAYr3nsSO9kJsGmQpUBe1qqro
         Ahe13XYSWmSuLd+i36GBcy3ExGbbXkoqwToqG+SM0BK7O1aFRaJ3HATGCfheMmarDt
         hxL0vq5Jzh4ug==
Received: by mercury (Postfix, from userid 1000)
        id 2EB181060602; Fri,  4 Mar 2022 22:13:11 +0100 (CET)
Date:   Fri, 4 Mar 2022 22:13:11 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     support.opensource@diasemi.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] power: supply: da9150-fg: Remove unnecessary print
 function dev_err()
Message-ID: <20220304211311.ua2kf4nzkdozjb4x@mercury.elektranox.org>
References: <20220301081619.121904-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7wsqisaykrcj7ujp"
Content-Disposition: inline
In-Reply-To: <20220301081619.121904-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7wsqisaykrcj7ujp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 01, 2022 at 04:16:19PM +0800, Yang Li wrote:
> The print function dev_err() is redundant because
> platform_get_irq_byname() already prints an error.
>=20
> Eliminate the follow coccicheck warning:
> ./drivers/power/supply/da9150-fg.c:524:2-9: line 524 is redundant
> because platform_get_irq() already prints an error
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/da9150-fg.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da91=
50-fg.c
> index e63fa62d1943..8c5e2c49d6c1 100644
> --- a/drivers/power/supply/da9150-fg.c
> +++ b/drivers/power/supply/da9150-fg.c
> @@ -520,10 +520,8 @@ static int da9150_fg_probe(struct platform_device *p=
dev)
> =20
>  	/* Register IRQ */
>  	irq =3D platform_get_irq_byname(pdev, "FG");
> -	if (irq < 0) {
> -		dev_err(dev, "Failed to get IRQ FG: %d\n", irq);
> +	if (irq < 0)
>  		return irq;
> -	}
> =20
>  	ret =3D devm_request_threaded_irq(dev, irq, NULL, da9150_fg_irq,
>  					IRQF_ONESHOT, "FG", fg);
> --=20
> 2.20.1.7.g153144c
>=20

--7wsqisaykrcj7ujp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIigOYACgkQ2O7X88g7
+ppkYw//Y5PtNZtaW0ukp8PC65N/fBFGwlbHZI7AAHm+AuBLCxs5xKyRr/vXinYM
v3d/ofIiefy5jNfZFKwuuF/RJ4Rp+snPGX1PWfUHk25PlZE8364ksNTe5Q1KLy8V
rjjmNpkwPdi1X3YjMZaY3IgsqIEintwIbr90hAW+rE5YTKyJZ1RCaerhFox4C/kC
lrE+rDOTEelpTuhRne2x94Pz/gUB3hYXON76G21gFZ5NL998hHn6MWYWz1GXgE+E
VmK8uNQGxK6KFGzqaIre0gUAwfbOFVNzuSxU1EbKXVy8qmFqWGH4h8caXxdBFeMK
crJDZeJ5D+plWOlFu/wvvsvfkyUwJLd56nhXQkxGmNCjwQG7htmpCDXXW9z/AjEN
IQacdrO7aXmbj5YsQEhkGrLUHMhOfycNzjQ4GjXQm1pylkV4SV2645s/c9FtnZoj
B2MBonlhV5cDopfT1TEx7Ps7DBgU77ktvzyTqPxnsHJwr8t5YQJJuZSPX0KMwo9D
bTks2duWRC2BvU2b9QplrmAZSJyer+CBPVNGUIxWuha/vYH78yAOApzbx97c5rMF
+A6wYCrbVxha7yYSXQoZaBMgw4ib85R5UPAMnzHTp6Ew+4yr2JTdXgMiafvpS7sj
OoZYPOastUUbqt7bbrJqYjh6lIUfz99nFowkgmEXn6yfLrYBHTw=
=dQWT
-----END PGP SIGNATURE-----

--7wsqisaykrcj7ujp--
