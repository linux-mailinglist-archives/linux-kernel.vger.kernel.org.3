Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD8508045
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 06:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359345AbiDTEtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 00:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347823AbiDTEts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:49:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107FA2716C;
        Tue, 19 Apr 2022 21:47:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kjp6r2Qqvz4xNm;
        Wed, 20 Apr 2022 14:47:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650430021;
        bh=JLEeU9OwjmVMFLMs8WsriEOViHzhWndg0ZSQF4hb0no=;
        h=Date:From:To:Cc:Subject:From;
        b=bUoydZnlb0isZe4mRNOyFYMRDrS5FcmGlcd8wsOIIfRofKqP+322hjwU91uTNmFmd
         FP+307qIIyjHkQJt7InlfoRjvs6WbLkG0N4+x1m5SCL9CVScR0OhyUrky71/L3s227
         /wm+cNKMxbJkrjR4so6iasCSgkbEfvbWU7OSPd9aifG8Ou65C6V2U9bwRNRy3zGSDA
         lRoVAqHeNn34AI56VFHCpvRXG/Rrxu5PheR3blIJ+0sKVh5wXx/SolsBHj4bodRRRK
         bxz9kvYimEjjvxT7GUCijjFXLNWc85oP8qk7rF+6WRUlmt/9Ctd4lwdKNpjsneBSx2
         Iu6QA2xOM2lWw==
Date:   Wed, 20 Apr 2022 14:46:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robherring2@gmail.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the pinctrl tree with the devicetree
 tree
Message-ID: <20220420144656.251e6261@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SOjFdFnKjhlEH4jnc2w4GVl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SOjFdFnKjhlEH4jnc2w4GVl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pinctrl tree got a conflict in:

  Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt

between commit:

  998282c6dad8 ("dt-bindings: qcom,pdc: Add SM6350 compatible")

from the devicetree tree and commit:

  6d289c378af4 ("dt-bindings: qcom,pdc: Add compatible for SM8150")

from the pinctrl tree.

I fixed it up (see below - I "corrected" the SM8150 in line with the former
commit) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.t=
xt
index 3b7b1134dea9,bd3539644d3f..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@@ -21,9 -21,9 +21,10 @@@ Properties
  		    - "qcom,sc7180-pdc": For SC7180
  		    - "qcom,sc7280-pdc": For SC7280
  		    - "qcom,sdm845-pdc": For SDM845
 -		    - "qcom,sdm8150-pdc": For SM8150
 -		    - "qcom,sdm8250-pdc": For SM8250
 -		    - "qcom,sdm8350-pdc": For SM8350
 +		    - "qcom,sm6350-pdc": For SM6350
++		    - "qcom,sm8150-pdc": For SM8150
 +		    - "qcom,sm8250-pdc": For SM8250
 +		    - "qcom,sm8350-pdc": For SM8350
 =20
  - reg:
  	Usage: required

--Sig_/SOjFdFnKjhlEH4jnc2w4GVl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJfkEAACgkQAVBC80lX
0GzEaQf9GSFO8+rtJuMZJNMGMGkEZ8rUPp5YVPwFMjJEBqe/NukCRE0SWNtGKsRJ
27UDhWrNAR+TdiKOYECLX2UnZUhPTkBe8zyp6sv+QsVrDbP0lhg06nxE4vlwVYOr
kd66cU0J6jbIrKWtczrSeAWoSRZLsn0pz37XELfX4S4E7DH+EsmJNkSmf3YxIS/N
Qcf1CG14Zaq8RUk6e/78wj94wp7luGxQwbPn5LrYnvX/RQyhA7ydqaHVeMphzWnr
MjPrBvFH+IQOYvCi2/Tx6HJPr5XStLSGi8NiaBx6LRANBbw0aLBVpqseDG00i9HV
Y+wkQRudzl+W7mtzBzKC8+I/TnNUUA==
=DvAS
-----END PGP SIGNATURE-----

--Sig_/SOjFdFnKjhlEH4jnc2w4GVl--
