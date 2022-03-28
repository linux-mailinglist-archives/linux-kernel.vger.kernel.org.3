Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DFD4E9185
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiC1JjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbiC1JjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:39:18 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6876541B1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=LE7raKislCZZkXpLroZs2BIDbLhu
        zFOoOiX4Xsm/vFc=; b=Oa/AVQQZxo59EXMkSKt745EdgGRQcy55ANXgYVA+K+7+
        gvKw+Yxir2ugT1vMk6zhw1DAy2MB8AvT7r7dg1hkMKtbCYHg49N97mzJ0v9YieQY
        +WDtacUu9gnA8SuNNa1fVgaiZ8LnHTgY4nhcLEJeRJYrMV5Lw4YhJ8OIFSEVoNI=
Received: (qmail 1305304 invoked from network); 28 Mar 2022 11:37:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Mar 2022 11:37:33 +0200
X-UD-Smtp-Session: l3s3148p1@pfDOD0TbpNUgAQnoAEkIAFmtuepKDVA5
Date:   Mon, 28 Mar 2022 11:37:32 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <YkGB3AgME/OZAdoG@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20220317085019.3987-1-wsa+renesas@sang-engineering.com>
 <20220317085019.3987-2-wsa+renesas@sang-engineering.com>
 <YjiC6Lg5k5gK/BfP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="inDyF/t2z9scnhMV"
Content-Disposition: inline
In-Reply-To: <YjiC6Lg5k5gK/BfP@smile.fi.intel.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--inDyF/t2z9scnhMV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

> > +	for (i =3D 0; i < priv->trig_len; i+=3D 2) {
>=20
> Missed space.

Yes.

> > +static int fops_buf_size_set(void *data, u64 val)
> > +{
> > +	struct gpio_la_poll_priv *priv =3D data;
>=20
> > +	int ret =3D 0;
>=20
> Instead of this assignment and other related things, can we do the follow=
ing?
>=20
> > +	void *p;
> > +
> > +	if (!val)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&priv->lock);
> > +
> > +	vfree(priv->blob.data);
>=20
> 	priv->blob.data =3D NULL;
> 	priv->blob.size =3D 0;
>=20
> > +	p =3D vzalloc(val);
> > +	if (!p) {
> > +		val =3D 0;
> > +		ret =3D -ENOMEM;
> > +	}
>=20
> 	p =3D vzalloc(val);
> 	if (!p)
> 		return -ENOMEM;
>=20
> > +	priv->blob.data =3D p;
> > +	priv->blob.size =3D val;

I don't like assigning 'priv' memebers twice, so I'd like to keep it as
is.

> > +static const struct file_operations fops_trigger =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.open =3D trigger_open,
> > +	.write =3D trigger_write,
> > +	.llseek =3D no_llseek,
> > +	.release =3D single_release,
> > +};
>=20
> Can it be wrapped by DEFINE_SHOW_ATTRIBUTE()?

I don't see a way. Do you?

> > +	dev_info(dev, "initialized");
>=20
> Not sure how this one would be helpful.

Then please check my comments on your previous reviews.

All the best,

   Wolfram


--inDyF/t2z9scnhMV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJBgdwACgkQFA3kzBSg
KbYyZBAAnxhHF2fEwbRxNWZSbs6cieerGxqMW3ujNQ61Y0c4z3zjENN2DGF7nz8C
iyHg20CYpZE+j/aPRV0v9CK4PjWSn6Au4UM+0SNKUtLwQRl+pQ/iJFQHc4opHlOD
Ri4Balpx5AwcpiSxiTPY2RlpNipoWseC4npofbNLrLOVQrVkuO21Fc0oHlgy1yXp
m34X0XRm2g37kyOgRsl2PxW5qVRNeuns4m8aXX3CFT/QApxH4GDXFOZ+MGJhCN5B
WxdvxdPDgITRjgUR1xUtKp1adZaD+nM2sPrqdZt9cQZi5GMPUJLInnx6KQbqMQZ/
wwPJu8YWiPhyK3M6wvSxFIBFwdrkWD5Igl4VpV3MnECzoFLQ4WZYsJeyMezvA9dp
4zZwbvuJqs7GImS9gr9PTuMU9niKPqKOIiN+GsawvQdceu/++cLue/Z8yDn6wvYa
WNuI2A3JQQib3ZlksuQ45boGaPrzpV2Oh9nwLhKuP+IOGPPU2e4rsC55WE0y5Eg5
ngP5hp7L+1/FPAn4XrSnTtxs9gh0hsvYAa4FM5ErrDhuiph3Kbzu2d5Jwjv1PTdS
nVPnboyMhb3HPd5sD2Sz5n6bFERktycMTcTuKD/+C/1gbbLw1iYP6GX7c8uJMAWM
4bllfRcoHft54irxD8KSuDJAOnIbeaJji+h8Knmtf5V2Ctrwc+c=
=wf1u
-----END PGP SIGNATURE-----

--inDyF/t2z9scnhMV--
