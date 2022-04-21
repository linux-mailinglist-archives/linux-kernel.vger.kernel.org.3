Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F326D50AC01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442579AbiDUXgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442570AbiDUXgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:36:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F30B3BFA4;
        Thu, 21 Apr 2022 16:33:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kkv4N0mXwz4xL5;
        Fri, 22 Apr 2022 09:33:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650584021;
        bh=4h+c91ugqyhBJaJnLRrWCkiZzXbh5wCVoMk4zWdxUWk=;
        h=Date:From:To:Cc:Subject:From;
        b=f9UZAR7Z5tBZrkeSs7klRyExEh9iz4s07y846nMB/VCAa5sDrM8zEtfSMng7xnXFq
         FB+mwx3ZJOQpTJbGLJSy59T3QkftiHd+KmfT0QS4dTWgdxAD8PX6osZKulBeAcdcTm
         6RIhiTNMSJocC+Dcfw2HgDiNU7h7+lTXztoD44BTX2CImFgQXSvO8Fr+NuoUaIuERK
         GILRObJEtl+pXrxpvS0fcxg3TEI1MyLDFwaqXv+v/JN5yM5ZXPkuFFFM/OeOyTXxlF
         0ym3ROlG3MiDg5XyUHypUb1rh1JTO5VHRwwuOnbokCD07xM/vU1B+gaK7W99WaT97K
         Mmfp4Ey79xSTQ==
Date:   Fri, 22 Apr 2022 09:33:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pablo Ceballos <pceballos@google.com>,
        Stephen Boyd <swboyd@chromium.org>
Subject: linux-next: manual merge of the hid tree with Linus' tree
Message-ID: <20220422093339.1e0b8033@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tc1MfmY+dPwqvrJmDqEwtXa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tc1MfmY+dPwqvrJmDqEwtXa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the hid tree got conflicts in:

  drivers/hid/Kconfig
  drivers/hid/Makefile

between commit:

  33bbe04a15f2 ("HID: google: extract Vivaldi hid feature mapping for use i=
n hid-hammer")

from Linus' tree and commit:

  e9c8c7c43b51 ("HID: Driver for Google Hangouts Meet Speakermic")

from the hid tree.

I have to wonder why these new VIVALDI bits were not put next to the
old VIVALDI bits ...

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/hid/Kconfig
index a95a7cbc4a59,ef58b5c03780..000000000000
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@@ -405,17 -405,20 +405,29 @@@ config HOLTEK_F
  	  Say Y here if you have a Holtek On Line Grip based game controller
  	  and want to have force feedback support for it.
 =20
 +config HID_VIVALDI_COMMON
 +	tristate
 +	help
 +	  ChromeOS Vivaldi HID parsing support library. This is a hidden
 +	  option so that drivers can use common code to parse the HID
 +	  descriptors for vivaldi function row keymap.
 +
+ config HID_GOOGLE_ATRUS
+ 	tristate "Google Hangouts Meet Speakermic"
+ 	depends on USB_HID
+ 	help
+ 	This selects a driver for the Google Hangouts Meet Speakermic.
+=20
+ 	This driver works around a problem with the HID usage sent by this
+ 	device for the mute button. It prevents key events from being generated
+ 	for that HID usage since they would be incorrect.
+=20
+ 	Say Y here if you have a Google Hangouts Meet Speakermic.
+=20
  config HID_GOOGLE_HAMMER
  	tristate "Google Hammer Keyboard"
 +	select HID_VIVALDI_COMMON
 +	select INPUT_VIVALDIFMAP
  	depends on USB_HID && LEDS_CLASS && CROS_EC
  	help
  	Say Y here if you have a Google Hammer device.
diff --cc drivers/hid/Makefile
index 345ac5581bd8,495e67ec5d9e..000000000000
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@@ -50,7 -50,7 +50,8 @@@ obj-$(CONFIG_HID_FT260)		+=3D hid-ft260.
  obj-$(CONFIG_HID_GEMBIRD)	+=3D hid-gembird.o
  obj-$(CONFIG_HID_GFRM)		+=3D hid-gfrm.o
  obj-$(CONFIG_HID_GLORIOUS)  +=3D hid-glorious.o
 +obj-$(CONFIG_HID_VIVALDI_COMMON) +=3D hid-vivaldi-common.o
+ obj-$(CONFIG_HID_GOOGLE_ATRUS)  +=3D hid-google-atrus.o
  obj-$(CONFIG_HID_GOOGLE_HAMMER)	+=3D hid-google-hammer.o
  obj-$(CONFIG_HID_VIVALDI)	+=3D hid-vivaldi.o
  obj-$(CONFIG_HID_GT683R)	+=3D hid-gt683r.o

--Sig_/Tc1MfmY+dPwqvrJmDqEwtXa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJh6dMACgkQAVBC80lX
0GyQJQf/VENeTdlykfyMuOne2ITmCStmvPlbNfu2TivvBhboryKeFzkTAWa/MkNA
bz+gOIZKZQ3Op4VXnthvX1lwfS4zrH/W5FPNKuL4NlaWQLEzkzOMBEqlF4wVNDQI
vIxN2eiRuhItQh3gBPYLlHYVNRLzS2SftsLMrNLNAKLr31+cYN+GuyHFSGUYYGW2
87aIQs2DjoBVcnScyMjXkRacHZFuJd5EbpcCNwu7Q93sGQWTVsFy0hgu1UMwgY6P
IxfkEfFs5EaLZsu6cuXQ+0P7NW7bTYbybFAgB2HldaXV78tEVr5qrQW33g/EJRx2
c0bFwLciR1r/lODt2aHrHNfN1GK3ng==
=/e32
-----END PGP SIGNATURE-----

--Sig_/Tc1MfmY+dPwqvrJmDqEwtXa--
