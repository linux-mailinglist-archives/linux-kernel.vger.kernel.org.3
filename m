Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF24C529914
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 07:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiEQFet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 01:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiEQFep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 01:34:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E787640916;
        Mon, 16 May 2022 22:34:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L2PvM043Fz4xXj;
        Tue, 17 May 2022 15:34:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652765679;
        bh=+teQEkoVE0NcOfaTzwnoVR40DyApB6GlzBhfcfYjvAI=;
        h=Date:From:To:Cc:Subject:From;
        b=BKn917nPlFZ7u5ZO206YY2ITn06347RaRzfU122QJ1+kJg/txlgIaVHbESFoNqwTw
         J//seSlwAvnuUmCLlPR/z7eFYXAv9z79x+xQF6qQS5K+bIfEs9Z3/e0SZxBuW99tFr
         FYw7puHBYmg3JBT0ij/tZEzSbOb5PKwYX8dVNhhMasrRDdPt1EduOEIyMks/zxy9he
         hrM7LC3CpJyv6/ek+Wo176vMup1WuNdQ2VwmuUrvJEuSYWrGskWgg1arW7rbkfVsJp
         Q5I5fcF38jTgcMZ5M1ngfl5JyOg2nu85xxCkOEYYzKmiFtB/Ql/yonnHkbWoFzVoaQ
         9WQSOz60JpeVA==
Date:   Tue, 17 May 2022 15:34:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the dmaengine tree with Linus' tree
Message-ID: <20220517153435.645a9313@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c4t0jNTZlCZXPEXCew1.RyN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c4t0jNTZlCZXPEXCew1.RyN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dmaengine tree got a conflict in:

  drivers/dma/idxd/device.c

between commit:

  1cd8e751d96c ("dmaengine: idxd: skip clearing device context when device =
is read-only")

from Linus' tree and commit:

  cf4ac3fef338 ("dmaengine: idxd: fix lockdep warning on device driver remo=
val")

from the dmaengine tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/dma/idxd/device.c
index f652da6ab47d,1143886f4a80..000000000000
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@@ -699,21 -716,23 +716,26 @@@ static void idxd_device_wqs_clear_state
  		struct idxd_wq *wq =3D idxd->wqs[i];
 =20
  		if (wq->state =3D=3D IDXD_WQ_ENABLED) {
+ 			mutex_lock(&wq->wq_lock);
  			idxd_wq_disable_cleanup(wq);
 -			idxd_wq_device_reset_cleanup(wq);
  			wq->state =3D IDXD_WQ_DISABLED;
+ 			mutex_unlock(&wq->wq_lock);
  		}
 +		idxd_wq_device_reset_cleanup(wq);
  	}
  }
 =20
  void idxd_device_clear_state(struct idxd_device *idxd)
  {
 +	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 +		return;
 +
+ 	idxd_device_wqs_clear_state(idxd);
+ 	spin_lock(&idxd->dev_lock);
  	idxd_groups_clear_state(idxd);
  	idxd_engines_clear_state(idxd);
- 	idxd_device_wqs_clear_state(idxd);
+ 	idxd->state =3D IDXD_DEV_DISABLED;
+ 	spin_unlock(&idxd->dev_lock);
  }
 =20
  static void idxd_group_config_write(struct idxd_group *group)

--Sig_/c4t0jNTZlCZXPEXCew1.RyN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKDM+sACgkQAVBC80lX
0GyXKAf9Err06CkA4FC2G72Ulc/oN1x/Yz1ru53R2bhw2yT/J3RuERy8jeA2Jqas
Ok5tnzwjWEo+anqC8c5w4MJsU03VMdiUGdrQ5CKM3fCo+H9xQYIjozaIr91am7vo
H2fwPDEfa5zF7AY3SD5Pf8bd+bfa+g5MgYuq8VFTBMR/2HJGqUHUK+bh7xhA6DLb
QPupcy/kSgQOgURW1cSpx5y+cAswMClm5GVccJF9Xj/9+py5tITM+B6xwpNeXYMA
WrrBdt6GRvIbFzZpn7wuZ17DM4l+OdyYXYhHAkE526onNQNWzkQKLdyyQQyi8wUL
EthiRvDxZ/1KkOHlT22bppuju7hWcA==
=JxJP
-----END PGP SIGNATURE-----

--Sig_/c4t0jNTZlCZXPEXCew1.RyN--
