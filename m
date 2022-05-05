Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCEC51B8A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbiEEHYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343736AbiEEHX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:23:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB3D21F;
        Thu,  5 May 2022 00:20:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kv4pg3ljzz4xTX;
        Thu,  5 May 2022 17:20:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651735213;
        bh=0RQfHmyeqA9KUgkuozR1e0eVsVJQ0X/wUaMhxVJaBEg=;
        h=Date:From:To:Cc:Subject:From;
        b=peUeJiCGct+ZGMxOTZTJ/PkaS+rkvm4k9pOtOFmvrnsnEFkauhuT+Vefomoh577+C
         6JJww0/4XAwqDj1pNWZtzhKEZ/s5v083lLo9NjXHbjQNeGQFZvvVMfem+n0Ek+6FDL
         QVJWvyW7HPt586zM8itedFubZrISEwp++8FYkq0iksevGNma4BlswXWgqrc7pjsEnC
         GyMmU0k5hlnlcTGIFi+drF6JfDxWoSvlEd8+vTt4IE5VGXGrWw/jrlQXmsEx/rfJhn
         sUj971VHoEOzYdyya/js0C+/3g2FsfHlDRloKRF8J+Sx9aWRdqg93TqBThy+tqsRIU
         ER3eCmniChKkQ==
Date:   Thu, 5 May 2022 17:20:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: linux-next: manual merge of the kspp tree with the char-misc tree
Message-ID: <20220505172010.19545e84@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/su1yPshIWnwWUQV2/xQTAPF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/su1yPshIWnwWUQV2/xQTAPF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  drivers/misc/lkdtm/stackleak.c

between commit:

  73f62e60d80c ("lkdtm: Move crashtype definitions into each category")

from the char-misc tree and commit:

  c393c0b98d75 ("lkdtm/stackleak: prevent unexpected stack usage")

from the kspp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/misc/lkdtm/stackleak.c
index 210c84dfe1d2,52800583fd05..000000000000
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@@ -81,11 -115,11 +115,20 @@@ out
  	}
  }
 =20
 -void lkdtm_STACKLEAK_ERASING(void)
++static void lkdtm_STACKLEAK_ERASING(void)
+ {
+ 	unsigned long flags;
+=20
+ 	local_irq_save(flags);
+ 	check_stackleak_irqoff();
+ 	local_irq_restore(flags);
+ }
++
 +static struct crashtype crashtypes[] =3D {
 +	CRASHTYPE(STACKLEAK_ERASING),
 +};
 +
 +struct crashtype_category stackleak_crashtypes =3D {
 +	.crashtypes =3D crashtypes,
 +	.len	    =3D ARRAY_SIZE(crashtypes),
 +};

--Sig_/su1yPshIWnwWUQV2/xQTAPF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJzeqoACgkQAVBC80lX
0Gzyawf+IjL+0oQohkkUjMk3c6Uut80GjFdAKKTspcMLpx/cUMjtGNCklV5hL/yz
iAW38NEVXcDrjw1Y2MPTF7tcARPQuqPPK64CxOUkm4YapxTMpwE+MDYJK6yAoW+5
dF90TixdA7z8W02UgCNgQ+d8mjo2KmTAvOj/MsY5yf+lHCskZrf7c9PPrQcCQLEf
sEZR1RFtx9QtIXsuZeqwZdJkGmFyeAlAU5dnqqw1s1Tu83CuGe1H+8H0Pjog+f0u
G6OsNr1fcvnfjz7BFSMHXYdgUxk4PpxTm3nQDgIR5T3yfRXyQNBtEq+uisEwxpFz
KVscjVcvFdFAPO72Jf0alWsu7bV3hg==
=yG1J
-----END PGP SIGNATURE-----

--Sig_/su1yPshIWnwWUQV2/xQTAPF--
