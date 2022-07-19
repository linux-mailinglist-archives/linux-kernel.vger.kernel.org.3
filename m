Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124AB5792FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbiGSGJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGSGJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:09:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE722B8;
        Mon, 18 Jul 2022 23:09:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ln7gq6n5Dz4xRC;
        Tue, 19 Jul 2022 16:08:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658210936;
        bh=U9LWxIpSsbLDUfTG1gQS2qEa9bbpA/+7+e54gl4F0Hk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q0mgnk4njJq6DPzA096X5G4GZqNF9HXvH8OuI/FVOf3iBfuS93EFFlGE+Gif6eHkE
         NCVdAm+LR5ITClp1SBkDgCqDXl3F2TV5oFCad+d7K3ogOrISgXSiJgAD4GdSsdGfKu
         JwVtZ1R1r4wryYPWjsugHH7xZT0gBCEA8GXIlu+0+KIPi26wGruid71AtApI3CU0k1
         kEFuwLuTEIh/YJGYfcH84YKw4jk2JZozERWJcxYJ3RR555vgDzHA1LDuXK7noTgsRt
         np5Y3Zyj4OCXqrvkd9lYT5SlMzToclkI8ildtsJ1PQpNul85UeUYxRHvaWxm4tKvUM
         oaT2Q4FY/ZuCA==
Date:   Tue, 19 Jul 2022 16:08:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Prashant Malani <pmalani@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <20220719160821.5e68e30b@oak.ozlabs.ibm.com>
In-Reply-To: <YtXF8TUZHNRUUyJh@kroah.com>
References: <20220718163158.42176b4e@canb.auug.org.au>
        <YtXF8TUZHNRUUyJh@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/exaMxt4Wim5.9/J8QGNrfmb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/exaMxt4Wim5.9/J8QGNrfmb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, 18 Jul 2022 22:43:29 +0200 Greg KH <greg@kroah.com> wrote:
>
> > Caused by commit
> >=20
> >   e54369058f3d ("platform/chrome: cros_typec_switch: Add switch driver")
> >=20
> > and commits
> >=20
> >   34f375f0fdf6 ("platform/chrome: cros_typec_switch: Set EC retimer")
> >   bb53ad958012 ("platform/chrome: cros_typec_switch: Add event check")
> >=20
> > interacting with commit
> >=20
> >   b1d288d9c3c5 ("platform/chrome: cros_ec_proto: Rename cros_ec_command=
 function")
> >=20
> > from the chrome-platform tree.
> >=20
> > I have used the usb tree from next-20220715 for today.
> >=20
> > I will fix up the cros_ec_command() rename with a merge fix patch after
> > the apci usage problem is solved. =20
>=20
> The ACPI issue should now be solved in my tree.

OK, so I have applied the following merge fix patch from today.  So
Linus will need to know about this when the usb and chrome-platform
trees are merged.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 19 Jul 2022 15:57:13 +1000
Subject: [PATCH] fix up for "platform/chrome: cros_ec_proto: Rename cros_ec=
_command function"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/platform/chrome/cros_typec_switch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform=
/chrome/cros_typec_switch.c
index 024a2bb146b2..38ac20d52c88 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -49,7 +49,7 @@ static int cros_typec_cmd_mux_set(struct cros_typec_switc=
h_data *sdata, int port
 		.mux_params =3D params,
 	};
=20
-	return cros_ec_command(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
+	return cros_ec_cmd(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
 			       sizeof(req), NULL, 0);
 }
=20
@@ -76,7 +76,7 @@ static int cros_typec_send_clear_event(struct cros_typec_=
switch_data *sdata, int
 		.clear_events_mask =3D events_mask,
 	};
=20
-	return cros_ec_command(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
+	return cros_ec_cmd(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
 			       sizeof(req), NULL, 0);
 }
=20
@@ -88,7 +88,7 @@ static bool cros_typec_check_event(struct cros_typec_swit=
ch_data *sdata, int por
 	};
 	int ret;
=20
-	ret =3D cros_ec_command(sdata->ec, 0, EC_CMD_TYPEC_STATUS, &req, sizeof(r=
eq),
+	ret =3D cros_ec_cmd(sdata->ec, 0, EC_CMD_TYPEC_STATUS, &req, sizeof(req),
 			      &resp, sizeof(resp));
 	if (ret < 0) {
 		dev_warn(sdata->dev, "EC_CMD_TYPEC_STATUS failed for port: %d\n", port_n=
um);
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/exaMxt4Wim5.9/J8QGNrfmb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLWSnUACgkQAVBC80lX
0GwAJAgAmN75xRoz4gV6KU1Be1ht2ebwiit/RRbeqfbWoniP24i7fxSDd66kuZ1Y
Q78jcwq084pi6FD283w4S/uuixLs7kiZyJXUcYsZl2ft22o59DoJ5J4yIWssQET0
oRYHXaxIr/cb8pJy5bthSAH+jL+cHmBQ50U1S8LY6h4nnIw52g5o7kY6SupfOBeN
fgs8TzkpjFWZXvRxyO2zlnuDnuH6Hol7cdOj1FWtYyg0W5Jf4TC6CKHW07FgbTU9
P350HiOXPLDn/6xN9B2TpXv9Rh90n53hKMVlxPIk+lAUxUkjr0ELoJUMCCzStTiE
6cFTCRfk0qxL+iuf/4jSrjyMycA4IQ==
=nOE3
-----END PGP SIGNATURE-----

--Sig_/exaMxt4Wim5.9/J8QGNrfmb--
