Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD65579057
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiGSCBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiGSCBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:01:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1293AE7C;
        Mon, 18 Jul 2022 19:01:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ln29q2srSz4xXj;
        Tue, 19 Jul 2022 12:01:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658196063;
        bh=Cd7a6kWCcHiJJ+yKIbT6zmzTP4Ew9jbPU/WunSGh7ms=;
        h=Date:From:To:Cc:Subject:From;
        b=PMupFgHOw5YwVR2SY8gnRxomARwD/zk55ChAXY90h34+bRKY1KklWQz+SAXCb61cQ
         zw6WHLLIMdIau97lZEDgWJcKHrptwY1AJqNIQVxQNwRpal+OyxjnqOH0d94cb/znnK
         qZybFkTrNllUuhLbYg4nUH7YB+0iGVOxuUKhgd7IS/xzRsjQMx2qnYPql5kmQUP/5z
         u+qclkTJhC3qt8JnmzCTYDQrNaavwDchzYPCKpMk7v/GBad8qboxqqiATUSzg4vmOj
         sZkcZxnq1MbbJgjWLu8soHWTr9c14lZkd6dtchMBCKpgYN9+RJQ1FXVjzHItRHgAT/
         9w6obcRROAVTA==
Date:   Tue, 19 Jul 2022 12:00:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the amdgpu tree with Linus' tree
Message-ID: <20220719120041.0cb1d16a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DH9UuOrJHjvpJdizQvM=3Kj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DH9UuOrJHjvpJdizQvM=3Kj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/display/Kconfig

between commit:

  d11219ad53dc ("amdgpu: disable powerpc support for the newer display engi=
ne")

from Linus' tree and commit:

  3876a8b5e241 ("drm/amd/display: Enable building new display engine with K=
COV enabled")

from the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

I have left the "|| PPC64" off the select line still.  Please let me
know if this has been properly tested on PowerPC and I will change
my resolution.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/display/Kconfig
index 0ba0598eba20,96cbc87f7b6b..000000000000
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@@ -6,7 -6,7 +6,7 @@@ config DRM_AMD_D
  	bool "AMD DC - Enable new display engine"
  	default y
  	select SND_HDA_COMPONENT if SND_HDA_CORE
- 	select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COM=
PARISONS)
 -	select DRM_AMD_DC_DCN if (X86 || PPC64)
++	select DRM_AMD_DC_DCN if X86
  	help
  	  Choose this option if you want to use the new display engine
  	  support for AMDGPU. This adds required support for Vega and

--Sig_/DH9UuOrJHjvpJdizQvM=3Kj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLWEEkACgkQAVBC80lX
0GwNggf8ChpEvdyKyeRlOViMZf/kq0yfGsLVDizppwFZwPC+XJ/57f9yGNzm3tSI
AzdY1YEUdk3IRu4DeYuXtn5HsYAcjzOnzrHMOO8kAZidGwRWyZSNCodcWVJvdrYS
7inKgX5D8gMOZXaIikr8ezra/BoYQmOGb2jA7naoAE45WxIRyot6zRBOZgh76x0c
qfVlzglsmoQDH6cWJPPyFs+FUCPQBzF5wVZHimII3BIzIR26LIjB0OyovGZRHV0U
3Cb5++kaJVtsa+PU1/yYOizl+YmziS9eWx1K9OjB/1sl8pXLDABtSWK3mjlNcfdJ
whoulG+RIuC4AnDMyHLbAbbferTxjQ==
=oAMh
-----END PGP SIGNATURE-----

--Sig_/DH9UuOrJHjvpJdizQvM=3Kj--
