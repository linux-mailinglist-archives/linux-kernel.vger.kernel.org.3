Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7AE4B2F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348044AbiBKVkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:40:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiBKVkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:40:36 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6777C65;
        Fri, 11 Feb 2022 13:40:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0B53F1F47299
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644615632;
        bh=x/eg+6w2Tr2joTOYtZyNlDgHawkmOfVfZKO5c0bZI88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJ48klO6UXAOJ763KOdmdua13QAzL7OYHlD+bxgtnQuoL7D3hgltRJ/oIs+Mnn4WY
         2PIJyqYDBIUJYEWXiQe0d61dE5hevANlWLgtO5oVMFea0Uu5hpBh4tgBFLGWzI5tfs
         b2trkrsThdubZoCiJ5rfhKq+SjdRU6ke9tzeuYWHvgqu2Kzq6R20dMgMOqYeMCWdl7
         sOGHSW9p+RxQHD60ddYr9sJjM/2BOMeiW+YZ2ai9QgT98Fvt0SoW4W2PH8KGbL1Ysm
         DOd8CsHsfNd0Lq0/j3b4auNnZk4YNzFT/bJZV9JNLZEyRV7aXVl/e7gH0KNLFT64yI
         sw1loLoHBLVTg==
Received: by mercury (Postfix, from userid 1000)
        id 3BD2E1060908; Fri, 11 Feb 2022 22:40:29 +0100 (CET)
Date:   Fri, 11 Feb 2022 22:40:29 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Qing Wang <wangqing@vivo.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: da9150: use div64_u64() instead of
 do_div()
Message-ID: <20220211214029.syw76upbqthasgwb@mercury.elektranox.org>
References: <1644395986-4349-1-git-send-email-wangqing@vivo.com>
 <20220211205026.6jhtt66wco5ht6i6@mercury.elektranox.org>
 <9b563415-f58a-15f1-b375-64ef4e98ca05@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="md3jjtjbp2ssjuiz"
Content-Disposition: inline
In-Reply-To: <9b563415-f58a-15f1-b375-64ef4e98ca05@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--md3jjtjbp2ssjuiz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 11, 2022 at 09:53:08PM +0100, Christophe JAILLET wrote:
> Le 11/02/2022 =E0 21:50, Sebastian Reichel a =E9crit=A0:
> > Hi,
> >=20
> > On Wed, Feb 09, 2022 at 12:39:46AM -0800, Qing Wang wrote:
> > > From: Wang Qing <wangqing@vivo.com>
> > >=20
> > > do_div() does a 64-by-32 division.
> > > When the divisor is u64, do_div() truncates it to 32 bits, this means=
 it
> > > can test non-zero and be truncated to zero for division.
> > >=20
> > > fix do_div.cocci warning:
> > > do_div() does a 64-by-32 division, please consider using div64_u64 in=
stead.
> > >=20
> > > Signed-off-by: Wang Qing <wangqing@vivo.com>
> > > ---
> >=20
> > Thanks, queued.
>=20
> All these patches are broken and should be NACKed, fixed or reverted if
> applied.
>=20
> See [1].
>=20
> CJ
>=20
> [1]: https://lore.kernel.org/linux-kernel/19b96972-cee7-937f-21ce-c78982e=
d2048@linaro.org/

Oops, thanks for the hint. Patch dropped. I actually missed the
do_div(div, 1000000) during my review (probably should go sleeping),
so div should be within safe range in the second do_div() anyways.

-- Sebastian

>=20
> >=20
> > -- Sebastian
> >=20
> > >   drivers/power/supply/da9150-fg.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/=
da9150-fg.c
> > > index 6e36782..896491a
> > > --- a/drivers/power/supply/da9150-fg.c
> > > +++ b/drivers/power/supply/da9150-fg.c
> > > @@ -250,7 +250,7 @@ static int da9150_fg_current_avg(struct da9150_fg=
 *fg,
> > >   	div =3D (u64) (sd_gain * shunt_val * 65536ULL);
> > >   	do_div(div, 1000000);
> > >   	res =3D (u64) (iavg * 1000000ULL);
> > > -	do_div(res, div);
> > > +	div64_u64(res, div);
> > >   	val->intval =3D (int) res;
> > > --=20
> > > 2.7.4
> > >=20
>=20

--md3jjtjbp2ssjuiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIG18EACgkQ2O7X88g7
+priAQ//bkVDODa2EvDnVHbSTMEiUYEmsB+fd1kCnq+4JxGyLR0Spa70VOO75FYz
AI5N2/Q2wfWYhmUOyZTWr7GVx8fdT87vbusDtZWks5Ulk32WuNFTVWsEodxMIgTL
dVR9FWrK8BMn1B1TB+GvGaY7SjX/9iwCeZLbUYLZ5d+fM+7JZIc2/wsZ/0PqN6tf
kLUBmlaPYBrZr9pFKPBpd1TPLrQ5UfgA5ATzwIUHfDhK+41qE4OkkoAtbgQzt3SK
2WgOAEkz4cIsPRQOQbp6YxuAkbuf/ojJwER71yViq23h+DsLLeJcLewg7OqJUckR
Qfz1QW0ueDJ0cwPB1yfax0S85IdDCD7io12LHt+PwsZy7BzF4a4oTOaG1j9rrcWZ
z6gVRXieckjMQrrlovDUyIC7B5/zY4P8i4Tt1hNYx34EfT/P25XAzcC6Ch1VJroR
AsGU/B9TO/lU+aXWeZpFIGOrGcsLxTebO0dwOXEWj3LcbtRbilFjyfB6kTq0lw8v
vypncxy8dZKnIiMcxsrU4VgSKuKs8mB2rE6tZO31AwD9RDWgp7lTG2DGBz4A+9Sy
2BDb2ZFeJ67jdBMCZ36ldK+zdWbWdCHC4xQliSW9QccGu3ajRtWcVcHoAYQ4VRTH
TQd5+R5cfbETdt0DhIFzeVictb1/YY/b7PgNP1yfKoMRanQI+sM=
=Gyea
-----END PGP SIGNATURE-----

--md3jjtjbp2ssjuiz--
