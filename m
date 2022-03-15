Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E354D958A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345603AbiCOHqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244096AbiCOHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:46:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB7B4B856;
        Tue, 15 Mar 2022 00:45:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHlnS6LXKz4xvg;
        Tue, 15 Mar 2022 18:45:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647330333;
        bh=fnz5vs4G769t7TVUotfrDBsK3ETdb0YePG6kc1s1NjQ=;
        h=Date:From:To:Cc:Subject:From;
        b=pCGCs/rrIxZzQc5AhFTKyuqRwy7TaFLEQiRGmvMPwDq7mPJVovKgnzMzy7YNwgc4V
         1GlpHdUuKM9ciosmrvnDFqFBsV/YCp9izevr12QWVrZ1azKu2neMA3ILuQS2pZjeC5
         FNygKJdxFa2ssX8xq6O2wigyjtrRezApANetmS/7WZvo5HOnlW023ZTVX9lKG09YN3
         FLSZEEALScvirozRpu5LXHxfnIUxx5z/BqpLV1aMWGwBHWYJsiI0mqo9GT2Y3ITdMY
         XhRBJAkwal4K8mKF4sAyBFErjmMN+io8Tnsr9zHGnWXIsYu71cuXGeZiBvkL0G4+PD
         wkIKtn1nvTZTw==
Date:   Tue, 15 Mar 2022 18:45:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: linux-next: manual merge of the userns tree with the block tree
Message-ID: <20220315184530.644fae9f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G+K2_xRivRPitXmd_hV8GAQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G+K2_xRivRPitXmd_hV8GAQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the userns tree got a conflict in:

  block/blk-cgroup.c

between commit:

  672fdcf0e7de ("block: partition include/linux/blk-cgroup.h")

from the block tree and commit:

  03248addadf1 ("resume_user_mode: Move to resume_user_mode.h")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc block/blk-cgroup.c
index fa063c6c0338,4d8be1634bc6..000000000000
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@@ -26,7 -26,9 +26,7 @@@
  #include <linux/delay.h>
  #include <linux/atomic.h>
  #include <linux/ctype.h>
- #include <linux/tracehook.h>
 -#include <linux/blk-cgroup.h>
+ #include <linux/resume_user_mode.h>
  #include <linux/psi.h>
  #include <linux/part_stat.h>
  #include "blk.h"

--Sig_/G+K2_xRivRPitXmd_hV8GAQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwRBoACgkQAVBC80lX
0Gwy1gf8CPvcS/VI//mlByO7LpVZd7SfVHWBpHyX3QHS1Mhh4js9Q5llbY+5yovT
oQB6sjDwka22wjQBPRSI0ik2jpD9n98nnPrbQQuJTOHIChzSwkUnNN1wfkkcYXb9
GqjVSoRKuHldwl/NMXMW6o/mVbDoSeN1TCYO7Dr1HJULQU4bCOY+FkabV/aJFJuB
IFPirnRdfY21vdQa7bgqW0k+B6effGiITQ7Q0W3VsPG8q2/641lmJMS9SAGiTg3x
mrjdt1ALFKIcxKfFAkJu1e8/HMg4ljJM3y3FOBFYPwkkCwnHulxh6d7CZ2NbydSu
fj/g56bypkBe/56giCrxSd+/P45vJQ==
=5dwX
-----END PGP SIGNATURE-----

--Sig_/G+K2_xRivRPitXmd_hV8GAQ--
