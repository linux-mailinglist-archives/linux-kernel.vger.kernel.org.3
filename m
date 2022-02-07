Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA114ACD2A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245463AbiBHBEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiBGXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:11:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A01BC061355;
        Mon,  7 Feb 2022 15:11:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jt22r6cKxz4xcZ;
        Tue,  8 Feb 2022 10:11:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644275511;
        bh=OaI9CJxcyqPY8QQmjCIUrEv/kcnCpFMZFNJOpwi7Kvs=;
        h=Date:From:To:Cc:Subject:From;
        b=Ycji8VqRS1VLL7DZWR+65c+QgXQA7C/E6vP9K8nh8Ekxu/6w/kyvHlrepVxEqdZAV
         5s48e2gueoVdrY38dV8b4iyZCmIc54r6QV62BFxc+pRWaCsv39gBfZlBf32SH6Tjnm
         GZYzKIP51NrA+1rFqDZJyzdIuHtIglFddTUHBi9qFQBlMMZF/fGqb/l8EppbRxmWEL
         l2KkTu3Q6dm2giDid9kEkyiInq/vgo3UhJ/B2NZvAuoYL0epi2zJyHcIPpZ8WBbSq2
         6IeEEOsC/Qzqm2OGF8a33YNiD4ZzwKJcegNdMrQS32Wsbxf3fM8ZgrtxuVNjPUhcbg
         xtL3wm641ytTw==
Date:   Tue, 8 Feb 2022 10:11:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Akhil R <akhilrajeev@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the pm tree with the i2c tree
Message-ID: <20220208101148.7e7f7528@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I1cDFz+PyDv/wQYeAli2Uk6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I1cDFz+PyDv/wQYeAli2Uk6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pm tree got a conflict in:

  drivers/base/property.c

between commit:

  ca0acb511c21 ("device property: Add fwnode_irq_get_byname")

from the i2c tree and commit:

  ffa743d3f33b ("device property: Don't split fwnode_get_irq*() APIs in the=
 code")

from the pm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/base/property.c
index fc59e0f7f9cc,ad97d23ddbe6..000000000000
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@@ -919,51 -935,6 +935,35 @@@ int fwnode_irq_get(const struct fwnode_
  }
  EXPORT_SYMBOL(fwnode_irq_get);
 =20
- /**
-  * fwnode_iomap - Maps the memory mapped IO for a given fwnode
-  * @fwnode:	Pointer to the firmware node
-  * @index:	Index of the IO range
-  *
-  * Returns a pointer to the mapped memory.
-  */
- void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
- {
- 	if (IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode))
- 		return of_iomap(to_of_node(fwnode), index);
-=20
- 	return NULL;
- }
- EXPORT_SYMBOL(fwnode_iomap);
-=20
 +/**
 + * fwnode_irq_get_byname - Get IRQ from a fwnode using its name
 + * @fwnode:	Pointer to the firmware node
 + * @name:	IRQ name
 + *
 + * Description:
 + * Find a match to the string @name in the 'interrupt-names' string array
 + * in _DSD for ACPI, or of_node for Device Tree. Then get the Linux IRQ
 + * number of the IRQ resource corresponding to the index of the matched
 + * string.
 + *
 + * Return:
 + * Linux IRQ number on success, or negative errno otherwise.
 + */
 +int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char =
*name)
 +{
 +	int index;
 +
 +	if (!name)
 +		return -EINVAL;
 +
 +	index =3D fwnode_property_match_string(fwnode, "interrupt-names",  name);
 +	if (index < 0)
 +		return index;
 +
 +	return fwnode_irq_get(fwnode, index);
 +}
 +EXPORT_SYMBOL(fwnode_irq_get_byname);
 +
  /**
   * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
   * @fwnode: Pointer to the parent firmware node

--Sig_/I1cDFz+PyDv/wQYeAli2Uk6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIBpzQACgkQAVBC80lX
0GxO6gf/a16UTbqnkBeGJ3k1FAbCOEO7XnLNEn4hW8ILhY0M+ttQZqFF/MPNhCgx
SvHKWdsOemgH1B03YmHiSgd0s/+FZ4CMU2kBsTWpZdXxk7kKVML2sk17wm1QWZMK
PbMpncGmfbgUpa2QeCTWxu+mKXOgxQYNQXY7smqrdukFy0h1euzQslapmZhzzFpP
b+uJLwD6AFyLiA5b73v4AsM80Rl9uTnUgTFZAlxxLwciAQ1ajT8si2HJwchmA5U1
iY9uyMFTrzPkhJLOIL7Ekl7AGb16GtDSTE6BTZrNlnor0DHXkU4b6rF/uK/Rz2HE
2uvLG3IZHrjVG608DQWQfo+JElc5MA==
=ulUL
-----END PGP SIGNATURE-----

--Sig_/I1cDFz+PyDv/wQYeAli2Uk6--
