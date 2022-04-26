Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C5B50F030
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbiDZFbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiDZFax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:30:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05312AD6;
        Mon, 25 Apr 2022 22:27:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnVl03kKKz4xXW;
        Tue, 26 Apr 2022 15:27:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650950861;
        bh=VP83oNnfSmxK+GqykxZKWgk2eDZxQ/ru3oQHu9AxHbE=;
        h=Date:From:To:Cc:Subject:From;
        b=ItQJutjyqzlY8udohpP5+LFu27eZgJ4HSZcm0wL5R+edaLS598Bi+VVL2gi+vSnEa
         5UGi54OUKdLnVbQ+Z4qzwm/tMWEnbNr1d0jfDYFjuvUi4q/9T6YPEJTUsPo5k1UaMz
         gZjAzUApb49Ulh6NSInVAT5bich/00kMYOZWXp8S/FdzNYvxQJIhZtY6OtJRtZ+7CI
         QPaRpYcAMhUnfnyZuQgn1vzIyH/tJDvcDvtF50U/9ifIkG7L9gkBt7a2DLcdeIOswp
         ySIOl2tA/0t9DL3O0PhfqCvap3dbJwSfVd4LfpossKa31b1s8JkkVZUzFNE9CJY+pE
         NS85lyq0UO7Og==
Date:   Tue, 26 Apr 2022 15:27:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chanwoo Choi <cw00.choi@samsung.com>, Greg KH <greg@kroah.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the extcon tree with the usb tree
Message-ID: <20220426152739.62f6836e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FeCk1B0BdNXZDJMsTzOyuNv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FeCk1B0BdNXZDJMsTzOyuNv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the extcon tree got a conflict in:

  drivers/usb/dwc3/drd.c

between commit:

  0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is pre=
sent")

from the usb tree and commit:

  88490c7f43c4 ("extcon: Fix extcon_get_extcon_dev() error handling")

from the extcon tree.

I fixed it up (the former moved the code modified by the latter, so I
used the former version of this files and added the following merge fix
patch) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 26 Apr 2022 15:24:04 +1000
Subject: [PATCH] fixup for "usb: dwc3: Don't switch OTG -> peripheral if ex=
tcon is present"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/usb/dwc3/core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2345a54b848b..950e238c65bf 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1649,13 +1649,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc=
3 *dwc)
 	 * This device property is for kernel internal use only and
 	 * is expected to be set by the glue code.
 	 */
-	if (device_property_read_string(dev, "linux,extcon-name", &name) =3D=3D 0=
) {
-		edev =3D extcon_get_extcon_dev(name);
-		if (!edev)
-			return ERR_PTR(-EPROBE_DEFER);
-
-		return edev;
-	}
+	if (device_property_read_string(dev, "linux,extcon-name", &name) =3D=3D 0)
+		return extcon_get_extcon_dev(name);
=20
 	/*
 	 * Try to get an extcon device from the USB PHY controller's "port"
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/FeCk1B0BdNXZDJMsTzOyuNv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJngssACgkQAVBC80lX
0GwbRgf/c9hKe+5y1t7rehI0/4/CSFI9pvrcGvrZIYV1wAU7L10AgYaMNqAxEf5T
wXFyX3Qer9TGM0/8+HOgVXxzty0/Hbx816FjTsbiOZRSH4BOtfvn1GPiueP8MYrY
Ie1CkqJATAh6yQ7CJaSlwfGNCJu938JuY9X57TRlryF8yu01ls30FMuJZFJXMrg0
6BfmnhO6a7E8ci3CrzeYP0IlLXKxQ7vshG0KMQjhbJqJpsQ05MfMsE8BAm21kWWU
ZdzsCdExF4FM+FE4nlNrK5+8MnBdiGm8wKWEcU6DQQKw+xC51lVKU91SGt9cxTpb
h8NHM30ShaZTHbhneqUgmDGvdK98SQ==
=ruC8
-----END PGP SIGNATURE-----

--Sig_/FeCk1B0BdNXZDJMsTzOyuNv--
