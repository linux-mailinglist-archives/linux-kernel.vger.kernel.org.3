Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559CD5699ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiGGFfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGGFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:35:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61A33138E;
        Wed,  6 Jul 2022 22:35:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LdlVD4v1Kz4xXD;
        Thu,  7 Jul 2022 15:35:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657172101;
        bh=Er96BYX0qV8YNs6ECQ777qibN0NojAhA5cN7YVJsaWw=;
        h=Date:From:To:Cc:Subject:From;
        b=U22eI7OHVcB5/ykIOyZaYdFiYaWDdY+iktdHr4AbKE/0D8RCMOhSa2L4Cw60O+UFD
         e6muaas5Z3hbqhwrS9XGlJtekQ08IztaQNtyQ6z7ohMz8rGFVJ+LCejZwK5NUwu5IH
         Xqwmlo2t1gneqxqqm7DnANyJsauYWHgMRuK8AxcS+HN5OMdHw7i1APDbfCKHEWswGr
         VxomGud5rV/CbE5HGuQISrQOwOFB1GOCWE4pcKXcLfs+uXsgusqlKn0KZ2lrNlnNcO
         u2jHZzChaFjkcDhdG8Tq7SF5fS5u+gkiOPaRyUA0WQH8v6oo2vQrcWuW5q/A+cjH21
         0aSMrQtNOqaSw==
Date:   Thu, 7 Jul 2022 15:21:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the phy-next tree with the drm-msm tree
Message-ID: <20220707152142.060c5b6f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TeUkG8KjfcZ_x6OL7Km577L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TeUkG8KjfcZ_x6OL7Km577L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the phy-next tree got a conflict in:

  drivers/gpu/drm/msm/dp/dp_parser.h

between commit:

  50b1131e0674 ("drm/msm/dp: rewrite dss_module_power to use bulk clock fun=
ctions")

from the drm-msm tree and commit:

  fa384dd8b9b8 ("drm/msm/dp: delete vdda regulator related functions from e=
DP/DP controller")

from the phy-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/msm/dp/dp_parser.h
index 9abddc6d50c0,47430e3a97bf..000000000000
--- a/drivers/gpu/drm/msm/dp/dp_parser.h
+++ b/drivers/gpu/drm/msm/dp/dp_parser.h
@@@ -100,16 -99,6 +98,11 @@@ struct dp_reg_entry=20
  	int disable_load;
  };
 =20
- struct dp_regulator_cfg {
- 	int num;
- 	struct dp_reg_entry regs[DP_DEV_REGULATOR_MAX];
- };
-=20
 +struct dss_module_power {
 +	unsigned int num_clk;
 +	struct clk_bulk_data *clocks;
 +};
 +
  /**
   * struct dp_parser - DP parser's data exposed to clients
   *

--Sig_/TeUkG8KjfcZ_x6OL7Km577L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLGbWYACgkQAVBC80lX
0GyCvAgAicMjd/akoL0/+CQJJXCFHdV7CbTbiySm2H2lVdBwL0D8OmJDHx7J/lvG
SUwSf0b50XCY2/0lKwt0LcAshGrZtrV/YXRX4jKrWoudBq3S0axeSFQx81YrgcTF
sO2hx0K89bDDX/Tg2B0LCdJc300BWitSSnUbLkSQhfyR4BmaS+td8uGeNGx7adv8
NjZZkAgBh5yPcy3V0fhO85tNBJXpBrovqMFQ6BeghukCZyiskF5bmBt58byBXTwp
w3zRHb+F6i+Xa1YfKsU852QPL9+a0UUkNWhuTNLpb1AfEIiza9oc/gM/q3MyyBHx
ZG3tmzAkm+zieJE52jNLx2PUv4TY+A==
=3qvA
-----END PGP SIGNATURE-----

--Sig_/TeUkG8KjfcZ_x6OL7Km577L--
