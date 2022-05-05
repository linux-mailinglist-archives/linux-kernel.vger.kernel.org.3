Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D847351B558
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiEEBqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiEEBqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:46:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CCF4C41E;
        Wed,  4 May 2022 18:43:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KtxKr1qPSz4xXS;
        Thu,  5 May 2022 11:43:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651714993;
        bh=TtMfVqytzBjCR0qUWr+CTwB6YM9CYPM1mDOpJiblGJc=;
        h=Date:From:To:Cc:Subject:From;
        b=QVpJlN7F1fjtI06Pzr5J23Bta3i1MLD/IVdXxywARhGWkNDvvqnThpIG+2ptNIbOS
         Rsv4iTmDHTZ773tlen8bvJu0rT+TZ36LG6Uo3kY6Ky6D7vfzIK0BffcPtabeF94db3
         1lCHBTjACCaE4whuBaP3ayLccOWLlohTTI/Rk3BWhLPYau87WcAcfIt6WNci1oxWqN
         UnVnyo/AcyZMpLL8xdHABA/7Qe81hklzeBU5hTadZ/DqXKnnxXQHgIrZ+z6jKuTaUl
         eP10cH5iaz4iItf8sNCB2SDYYkE270RWnbCck+gqCFDxG3FvxWYX3ffljoVun3YOtD
         HhQ4r0Fz49OFw==
Date:   Thu, 5 May 2022 11:43:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-msm tree
Message-ID: <20220505114311.18e7786f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/teBL01mlIaMgI0/1eR149Pp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/teBL01mlIaMgI0/1eR149Pp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-msm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/gpu/drm/msm/dp/dp_display.c:13:10: fatal error: drm/dp/drm_dp_aux_b=
us.h: No such file or directory
   13 | #include <drm/dp/drm_dp_aux_bus.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  c3bf8e21b38a ("drm/msm/dp: Add eDP support via aux_bus")

interacting with commit

  da68386d9edb ("drm: Rename dp/ to display/")

from the drm tree.

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 5 May 2022 11:41:09 +1000
Subject: [PATCH] fix up for "drm: Rename dp/ to display/"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/d=
p_display.c
index ed4e26ed20e4..c68d6007c2c6 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -10,7 +10,7 @@
 #include <linux/component.h>
 #include <linux/of_irq.h>
 #include <linux/delay.h>
-#include <drm/dp/drm_dp_aux_bus.h>
+#include <drm/display/drm_dp_aux_bus.h>
=20
 #include "msm_drv.h"
 #include "msm_kms.h"
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/teBL01mlIaMgI0/1eR149Pp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJzK68ACgkQAVBC80lX
0GxfmAf/bh2STLE2WuZawybH3tOZoRkCOAI1s9AYEDPZqTTDgVJwzhcaaTdoYVwX
r/hRBDe+UtOzg0oDcRpM4lwQl0GJaeW28XbZDqYomNvfpANMRqSlWievOEOEOm3h
Ct/m5UyyL1vWyAEOkq+xu/Syw2wIu5QP/PKwC0XomdROQ+gt5/s7LipVab5z7tKb
8FuMGJVj0pxZsLDHQM87sXsbmo67eovH+hKzqTO9qQQwPXPBfRyfbjPbbY/05KbY
RacuxoZgWZcv6bQsvSskLP6dS0u+fFjNCmbaHq+3VDEXGIE23ZGem9x8/5tOHGqo
AF3rckl2InIENa0CQPpfTVSjTISfDQ==
=zrUm
-----END PGP SIGNATURE-----

--Sig_/teBL01mlIaMgI0/1eR149Pp--
