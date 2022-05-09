Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6D551F89D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiEIJfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbiEII6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:58:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4630E185C82;
        Mon,  9 May 2022 01:54:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxZhp06rmz4xVP;
        Mon,  9 May 2022 18:53:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652086427;
        bh=w2m/tGdQTAx8CwiRbW9Lja4zBI/P+IiqXkEUWMZqfCc=;
        h=Date:From:To:Cc:Subject:From;
        b=e2GM/8uSu5SjESnNE0p9acMvp8bVUZNsXbkNiGSxqIyq06J4AC7AP7fUu3V/jH8Q3
         MKEtPFO+XonUfEZcJcuSZ8vawRAx1WropuIYSR+/9uCuOyCZbw9t6MBPctClHelYHC
         GaUuNn7qHbUe389wFFZ+oZPnPNnfQqzlbgvkUs5ff/rCSQOcEqq8czI+HDu0gLNJ2m
         BI7kQsEGLCamaYDL8FYgC7P+3lQGWsv5MMXqjsDlh7cfIN4W5xftM8PkmqkX9IaeUn
         6LPFUX9YbnE102GXGE9IrUsZ5YAl0rAduTaRQR6rKROfssljIrqjBBK7/i0SMfomzV
         8BOpacsFVs4Cg==
Date:   Mon, 9 May 2022 18:53:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: linux-next: manual merge of the kspp tree with the char-misc tree
Message-ID: <20220509185344.3fe1a354@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5Ha/EJ=CPT6QZVqs7X+t+uA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5Ha/EJ=CPT6QZVqs7X+t+uA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  drivers/misc/lkdtm/stackleak.c

between commit:

  73f62e60d80c ("lkdtm: Move crashtype definitions into each category")

from the char-misc tree and commits:

  c393c0b98d75 ("lkdtm/stackleak: prevent unexpected stack usage")
  932c12ae7963 ("lkdtm/stackleak: fix CONFIG_GCC_PLUGIN_STACKLEAK=3Dn")

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
index 210c84dfe1d2,82369c6f889e..000000000000
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@@ -81,11 -115,21 +115,29 @@@ out
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
+ #else /* defined(CONFIG_GCC_PLUGIN_STACKLEAK) */
 -void lkdtm_STACKLEAK_ERASING(void)
++static void lkdtm_STACKLEAK_ERASING(void)
+ {
+ 	if (IS_ENABLED(CONFIG_HAVE_ARCH_STACKLEAK)) {
+ 		pr_err("XFAIL: stackleak is not enabled (CONFIG_GCC_PLUGIN_STACKLEAK=3D=
n)\n");
+ 	} else {
+ 		pr_err("XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACK=
LEAK=3Dn)\n");
+ 	}
+ }
+ #endif /* defined(CONFIG_GCC_PLUGIN_STACKLEAK) */
 +static struct crashtype crashtypes[] =3D {
 +	CRASHTYPE(STACKLEAK_ERASING),
 +};
 +
 +struct crashtype_category stackleak_crashtypes =3D {
 +	.crashtypes =3D crashtypes,
 +	.len	    =3D ARRAY_SIZE(crashtypes),
 +};

--Sig_/5Ha/EJ=CPT6QZVqs7X+t+uA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ41pgACgkQAVBC80lX
0GzSJQgAo2yWwRCvJeEsi5G+3VFHcO7Td3MoNPir3QwJtaxbswj46G40PP1rAJm3
JWyB2bFnvhc1oVNGK+zkE1OM8r2CzBalcHKz9EtUyx4rjHN3Z6iWFBJu9sPm8uPz
7Y/K3SIqT+/yD+XAbsqUcBi7T3/zL1G5ijaY7APWg0altdcSbjY9toI+xndrzZ+R
pYIIneJ+n3DAVFeoRfk70aPzvb+sAZ0x6tauTXe/MOPujGy9JPe9srQiKVPQyPqa
YGiwK1+9we7QlJDLj0XpFwIffoOubaykEfLj/YixCzWTg9yarJFqP3fGRxRVhJBM
LXSNmB2V3yEqxXm6i90NrU0JuYuZHA==
=LMbm
-----END PGP SIGNATURE-----

--Sig_/5Ha/EJ=CPT6QZVqs7X+t+uA--
