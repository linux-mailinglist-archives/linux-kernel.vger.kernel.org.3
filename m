Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7155B4AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 02:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiF0Ad5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 20:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiF0Ady (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 20:33:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720CD8F;
        Sun, 26 Jun 2022 17:33:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LWTHK54kWz4xDH;
        Mon, 27 Jun 2022 10:33:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656290030;
        bh=dxBX31GVCNAdZ1uAyn2cnF+nj9OyO//pM/osEPOjVrU=;
        h=Date:From:To:Cc:Subject:From;
        b=jnKcjtOAxBiJgJbGuYYxvWLn/IV243hNhpQatgFePZYyWonZIW9Bzia1/4Sr25Kok
         mehd/VpvIFTeeDdDv2rRMB3dqOzF86khs/dwy6Vs9KYXVetNEWhOwTRPofMWFRz3qI
         0oPkxGmlPgt1LLqXU0T990W6nc20k77zhTEQ35meAPrO10sU8v3Kxyo5m8vxApK7ZS
         YO9Rr7IIAnglGAIjqfKH3EJjU8U4poSgDPI2wDiIxTostX10gcebKnsx2MPxz/NeUB
         tAEN7A7JgRKkUTSQpqq0+fkzVn61Lz3NiC84bjbc1wcSpfGaBDxiuIPK12Axty4oRL
         Pus2K6R3UynkQ==
Date:   Mon, 27 Jun 2022 10:33:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>
Subject: linux-next: manual merge of the drm-msm-lumag tree with Linus' tree
Message-ID: <20220627103348.2e9fc4f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Be7PE3xcqyhgLsFb_d+3qxr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Be7PE3xcqyhgLsFb_d+3qxr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-msm-lumag tree got a conflict in:

  drivers/gpu/drm/msm/msm_fence.c

between commit:

  3c7a52217a8c ("drm/msm: Drop update_fences()")

from Linus' tree and commit:

  bda2eac959ae ("drm/msm: Fix fence rollover issue")

from the drm-msm-lumag tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/msm/msm_fence.c
index 38e3323bc232,a35a6746c7cd..000000000000
--- a/drivers/gpu/drm/msm/msm_fence.c
+++ b/drivers/gpu/drm/msm/msm_fence.c
@@@ -46,14 -54,13 +54,15 @@@ bool msm_fence_completed(struct msm_fen
  		(int32_t)(*fctx->fenceptr - fence) >=3D 0;
  }
 =20
- /* called from irq handler and workqueue (in recover path) */
+ /* called from irq handler */
  void msm_update_fence(struct msm_fence_context *fctx, uint32_t fence)
  {
 -	spin_lock(&fctx->spinlock);
 +	unsigned long flags;
 +
 +	spin_lock_irqsave(&fctx->spinlock, flags);
- 	fctx->completed_fence =3D max(fence, fctx->completed_fence);
+ 	if (fence_after(fence, fctx->completed_fence))
+ 		fctx->completed_fence =3D fence;
 -	spin_unlock(&fctx->spinlock);
 +	spin_unlock_irqrestore(&fctx->spinlock, flags);
  }
 =20
  struct msm_fence {

--Sig_/Be7PE3xcqyhgLsFb_d+3qxr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK4+uwACgkQAVBC80lX
0GyTDwgAhpm9xjOv+BvN8kbatE1ZBEj1+CJGqHISwE12ojGvAETF/IqOe3C3Hc9D
JxpmOukOKWKFuVFrPpH1pXkcp4KpMnLL9JQzODC2qjZZP0flz932ajwju4MHW2+y
XcMSj89JOIUK+F+uC/poyQ/MqqjxvmOcn5N6smm0vWv1BIy/hVreSHoAXEr0DFFh
6ArAN2kj1I48fkgVUFiOCfTGW0UJR7/luqhSTpg82j4N0AwCFsnLMj7ola24lsK+
fxf63+lC+oOWxLyHtRoi+W1i5/ou0nuoqN3SF5Imf6tWAn3JbvrPu945wWOmaLQu
YscNJVgdZH2Q0pW8g82bf81VhI68ng==
=zNKw
-----END PGP SIGNATURE-----

--Sig_/Be7PE3xcqyhgLsFb_d+3qxr--
