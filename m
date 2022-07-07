Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B9A5699F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiGGFlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiGGFlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:41:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84105313BF;
        Wed,  6 Jul 2022 22:41:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LdldT27SRz4xXD;
        Thu,  7 Jul 2022 15:41:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657172478;
        bh=oj6dBw9Nm3G2bzkHq2OFfgBtAf6fr7vRnbnVheyfJkU=;
        h=Date:From:To:Cc:Subject:From;
        b=LfMlAW3Z1VIR/fnORqeeNPAYRDuzu1R10PDCB7YbG6EYdvM8GCZSj/xTJ/veu6DE8
         1Yi14wdPq0tzaF029IfE48YNG091bC3xYm6rcNxmGlYr401MiIFLKzv0v6NpR2kZUb
         7PngINVse+clPQZ+dhm/Mp2FNSWNMuoTHApmcDAI6U0yjolpI8bFb6FKFkbCkG7BVY
         8Nf1/e8ZtPI8Jm0SrTONSakugXqN/v0Vz6zeGVVLOubuyg1V9tTK8ZFkEEtfUvKlD9
         yohQwLSf2ApoHaEDS5kFuQeKb+jUtqJ+QVIP/VuHcCORekhiJzwCta/IeLn5kdl2PT
         LjubKeOsNRs3w==
Date:   Thu, 7 Jul 2022 15:28:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: linux-next: manual merge of the soundwire tree with the sound-asoc
 tree
Message-ID: <20220707152831.57f1e92d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u8xEwjcQIuXrB4pbi78Xe/X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u8xEwjcQIuXrB4pbi78Xe/X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the soundwire tree got a conflict in:

  drivers/soundwire/intel.c

between commit:

  ca68202098a4 ("soundwire: intel: Migrate to new style legacy DAI naming f=
lag")

from the sound-asoc tree and commit:

  3e9c9f90573f ("soundwire: intel: use pm_runtime_resume() on component pro=
be")

from the soundwire tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/soundwire/intel.c
index 0268fa527c0c,95ce292994cc..000000000000
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@@ -1097,9 -1114,9 +1114,10 @@@ static const struct snd_soc_dai_ops int
  };
 =20
  static const struct snd_soc_component_driver dai_component =3D {
 -	.name           =3D "soundwire",
 -	.probe		=3D intel_component_probe,
 -	.suspend	=3D intel_component_dais_suspend
 +	.name			=3D "soundwire",
++	.probe			=3D intel_component_probe,
 +	.suspend		=3D intel_component_dais_suspend,
 +	.legacy_dai_naming	=3D 1,
  };
 =20
  static int intel_create_dai(struct sdw_cdns *cdns,

--Sig_/u8xEwjcQIuXrB4pbi78Xe/X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLGbv8ACgkQAVBC80lX
0Gx+uggAn1PSacDabrsol1tUCJl6nVH3Ta6gtZWkhpj1eSkwg7YAZ7jnufkD7zdY
D62nM3D+pEr70snw8luril0KGPOZqhFu5wwQkZTjUvpN7BHte2sUs6L6vP2fZp0C
CE9xkYS7TmcGLt4MZAwrJEWwNpouEglr8yvAukpqu6zH+kgcXa2679nIqHjH/cPO
Zc0M3QPMDj7MINia069iVg+c/ZUOMVdM8nhM9WT3fyR7Bu+Xu1JqIJDXe2+Zvk6Z
W55KBZn/w9GxPbHzUCZBu8eWDNQmK66fCfat4PXDBQVI4dKQjhuhxaWXTIWFRKGF
cN8aJkFMqHiqkq3SmdzzyhI2CNUeUw==
=OZ1O
-----END PGP SIGNATURE-----

--Sig_/u8xEwjcQIuXrB4pbi78Xe/X--
