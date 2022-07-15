Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53A575A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbiGOEDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiGOEDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:03:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01205753A6;
        Thu, 14 Jul 2022 21:03:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lkd4N4YLxz4xdJ;
        Fri, 15 Jul 2022 14:03:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657857781;
        bh=6FhosIXeEv2iTJLL5/mJDR7ocd4WCVkI3wdrLqoSDvA=;
        h=Date:From:To:Cc:Subject:From;
        b=RCBxP/U7RRClN8Q47tF/erVKZajk4Pdhgx35GcKLWEKbWq6swi620UUmFcT0roK6m
         Lmw3A0Jyz3vK8FV1QBOYHgyNCRTvMHACpRWjYZrQIfi6Y5Is2/x5Mxxtpae8YegiHZ
         vwMT+vfnJ1smCpVvI1EVW8sbnMhlt65Ss6cgywxujoUfo6GqbPjx98svy0tfa39fDV
         ZuvxWNrdmjftc19LlE1Hct0n55dhOBEdHE95RMqXv/x7bln6gDuu0Xg/Pyjj1UWBUN
         V8NTiobL9QItYDPAQvzjyy3Dqs9Tj+7D7QP0vok/ci8GCpSuUQR6xypL5zG3FsOT90
         V4ZYzrYNyM66Q==
Date:   Fri, 15 Jul 2022 14:02:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ming Lei <ming.lei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20220715140259.205ef267@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+OQ6gAo3wG1LmmGCWmeXDZe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+OQ6gAo3wG1LmmGCWmeXDZe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/block/ublk_drv.c:951:19: error: 'no_llseek' undeclared here (not in=
 a function); did you mean 'noop_llseek'?
  951 |         .llseek =3D no_llseek,
      |                   ^~~~~~~~~
      |                   noop_llseek

Caused by commit

  71f28f3136af ("ublk_drv: add io_uring based userspace block driver")

interacting with commit

  8804bffa93a1 ("fs: remove no_llseek")

from the vfs tree.

I have applied the following merge resolution patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 15 Jul 2022 13:59:09 +1000
Subject: [PATCH] fix up for "fs: remove no_llseek"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/block/ublk_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f10c4319dc1f..52fd0af8a4f2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -948,7 +948,6 @@ static const struct file_operations ublk_ch_fops =3D {
 	.owner =3D THIS_MODULE,
 	.open =3D ublk_ch_open,
 	.release =3D ublk_ch_release,
-	.llseek =3D no_llseek,
 	.uring_cmd =3D ublk_ch_uring_cmd,
 	.mmap =3D ublk_ch_mmap,
 };
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/+OQ6gAo3wG1LmmGCWmeXDZe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLQ5vMACgkQAVBC80lX
0GzEPAf/d/Lk1QwzVOaTpNM4HE/Mtaaakk+BZgrvdSVRrnElSdkSNYElg2CMJy+e
rd53OQRaRLX8opjb02OMgFgXn6lTYZ2lvd/xJCrSCOEPTURWNN7FLTIfijzAAfjQ
9MqfTCTkz7rUmbuHvGOXeVIgpv1p7f3D0DtFMQg5w3NrG59gLsoShOH0TDLQMPVm
tJJW233atlQu35ZFgfEa63iAbWmPrF+mwTdt5yR+dt/Y+Dh4uyRM5QPC8WAzqZrQ
yTNdQCE2eQA4C025WIxw7NZwE/cHGwqRVvO6QVFyNe+MOYbQzuiox1lAyjhLtU8M
AKcZ2oEgHeO5DZryWNKU3QZgUccdEQ==
=KLS7
-----END PGP SIGNATURE-----

--Sig_/+OQ6gAo3wG1LmmGCWmeXDZe--
