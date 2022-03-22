Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46984E3749
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiCVDMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiCVDMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:12:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BFA1E3E7;
        Mon, 21 Mar 2022 20:10:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KMxLt5HsQz4xNq;
        Tue, 22 Mar 2022 14:10:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647918631;
        bh=JgcPupeKnnHBzGSo+u871QI4p41qJ1PO7267xASx8Ng=;
        h=Date:From:To:Cc:Subject:From;
        b=POAk4w9hPKys2YmVxgz2G9QMazVxgx94pNu9pr37NjqvAkCKXwaXa9Of9ZccJi1LL
         oREVGQVcs1yLsm/t83E8CqNgq5RKSg8mn5lB4GYb2RpfKGS349dWxnNk2trxDh03Wq
         2PNkEfvpBAq11qbq1TjtNvUNMDsxAUPOfIRmxrbiVRQNL8p1OkE4kD0J4POAujOGym
         v+l5XBS9xM1kBzSpWiADy8ed3Kb467HfNJMj9H1J8KtuKzL1HJNv9SdH0/BLTkEGx4
         esTOeKEf41V6AG2bfGmSrrsMX/Q5PbsoOmzPAHPNHEE7ssN6m7HkPdv9ojSlkvc52c
         e3I+4QIcNySNw==
Date:   Tue, 22 Mar 2022 14:10:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the devicetree tree with the mfd tree
Message-ID: <20220322141029.1885af98@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=8eRZByPhcW_bYIMAev82Rw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=8eRZByPhcW_bYIMAev82Rw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/mfd/syscon.yaml

between commit:

  844dd8fe02f2 ("dt-bindings: Add compatibles for undocumented trivial sysc=
ons")

from the mfd tree and commit:

  c1ff0c0f24d6 ("dt-bindings: mfd: syscon: add microchip,lan966x-cpu-syscon=
 compatible")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/mfd/syscon.yaml
index 29d4a97f7108,5aa0daa55533..000000000000
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@@ -44,10 -44,7 +44,11 @@@ properties
                - hisilicon,hi6220-sramctrl
                - hisilicon,pcie-sas-subctrl
                - hisilicon,peri-subctrl
 +              - intel,lgm-syscon
 +              - marvell,armada-3700-usb2-host-misc
 +              - mediatek,mt8135-pctl-a-syscfg
 +              - mediatek,mt8135-pctl-b-syscfg
+               - microchip,lan966x-cpu-syscon
                - microchip,sparx5-cpu-syscon
                - mstar,msc313-pmsleep
                - rockchip,px30-qos

--Sig_/=8eRZByPhcW_bYIMAev82Rw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI5PiUACgkQAVBC80lX
0GzCTgf/fn4tKxmXvhKbgmHzqKLWSRIoQAnY7wD2eiJYRx2v3pbUfwsOt8xXs6dA
YQKVMSfGrnnOs5zo3TkL3lUruQfKbHQVKHLYQGse1FUL+FNZLUtwZJ3DKjvsv3fM
4jH9A3XdnIIq+6NOlyuWCj6whd0j4Uwlh/m5BctUQUW86ZyYeCoT8RbcS2kC3Esl
oLpmgq7eID/uyQ/F6o+0tPXa9NC/EFvaMMZhaALv92yuRvqY0yb+W99n32mUoMLT
ios6vIZL0v9DCU3e8TJ03UusMBTXdwFUnAxLWTZHsaPS3OHvzTx0iryhjhH6NQ2w
/rT3DbsI0jLeKUuqyVerpg2DhyM+bw==
=/g50
-----END PGP SIGNATURE-----

--Sig_/=8eRZByPhcW_bYIMAev82Rw--
