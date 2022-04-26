Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1136C50F019
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbiDZFLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiDZFLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:11:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B19CF2A12;
        Mon, 25 Apr 2022 22:08:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnVK76flvz4ySS;
        Tue, 26 Apr 2022 15:08:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650949724;
        bh=oKQaG53Sdal0NHH0m+5zmNqGO0OxDy9xbE/+o2G++O8=;
        h=Date:From:To:Cc:Subject:From;
        b=A1O0gjmRixnoR20Ym/Xhn1SoVceIy+H92yHx9mKyQRkxnc+3wJ0DXER/wheGGLjxO
         8lvCUy3sQ6inRzCqsF0q1KNDh4LE2pXHqnB/yZ9PD9F3EcRQxtVMZpHsf42dwPVRUC
         fziDSDc0lWSvPsTeiyvoccuTsx/f3+04GwQRgOQiUw8QVT8uJJ6epKK9G/t6Ak7ZLe
         QveeG1bub8Njs9tKr2g/uHTXLtFSpnmqpk7BTiR2cH6JRT0uagwCnMezJrH7ZaT8Ob
         MJY85GMiYWaRIDFEzEYyDT+dlV3Tqud2MNKq4cQHwCNtbscEryNTkJS2EcB/gq/kAt
         hs99hjae6270g==
Date:   Tue, 26 Apr 2022 15:08:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sven Peter <sven@svenpeter.dev>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20220426150842.473be40e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P6wVelcR_C7SG6HInnwJLom";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P6wVelcR_C7SG6HInnwJLom
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/usb/dwc3/drd.c

between commit:

  ab7aa2866d29 ("usb: dwc3: Try usb-role-switch first in dwc3_drd_init")

from the usb.current tree and commit:

  0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is pre=
sent")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/usb/dwc3/drd.c
index 8cad9e7d3368,f277bebdaa09..000000000000
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@@ -585,14 -539,11 +539,10 @@@ int dwc3_drd_init(struct dwc3 *dwc
  	int ret, irq;
 =20
  	if (ROLE_SWITCH &&
 -	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
 -		ret =3D dwc3_setup_role_switch(dwc);
 -		if (ret < 0)
 -			return ret;
 -	} else if (dwc->edev) {
 +	    device_property_read_bool(dwc->dev, "usb-role-switch"))
 +		return dwc3_setup_role_switch(dwc);
 +
- 	dwc->edev =3D dwc3_get_extcon(dwc);
- 	if (IS_ERR(dwc->edev))
- 		return PTR_ERR(dwc->edev);
-=20
 +	if (dwc->edev) {
  		dwc->edev_nb.notifier_call =3D dwc3_drd_notifier;
  		ret =3D extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
  					       &dwc->edev_nb);

--Sig_/P6wVelcR_C7SG6HInnwJLom
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnfloACgkQAVBC80lX
0GwnLgf9GvFQWQ/9FsDm2eBSD5RMf0OAFKAX43onimNIzqaw2Gydv9nfT7Yp0n0d
cX1pE0ykxMIau4Df3rNGkTVeH0KuqCEBNBK75FfRrc/vgBRomZGDjW3R39sVla0U
5jS4vDZGNexWFW/oMzF4DY3KiqBI9dvuexGRJHy899WXW50OUexuYhDgVR+7V32d
FA1fmKeT9P2Hnw8qcGjIPlA+zphHWSvewnTzN3ikZGNkCdLFRV/vx8n4/+oshnjD
GlgU55G66E/Qpb8SQnE11B6IeePWnGm3/+iDzQMze1CRnumu+1PbjSCYI/H/q05O
X3xpc0MNHcSmWlMMYxb2wwy6zTIHBQ==
=qj6e
-----END PGP SIGNATURE-----

--Sig_/P6wVelcR_C7SG6HInnwJLom--
