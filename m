Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C824CF095
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 05:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiCGEP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 23:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiCGEP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 23:15:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD1D12AD5;
        Sun,  6 Mar 2022 20:15:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBlV63wQyz4xYy;
        Mon,  7 Mar 2022 15:14:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646626495;
        bh=41nGrEATh6zLH4eIHRLQ+Ym34K+NcfFps2hKPE69jX8=;
        h=Date:From:To:Cc:Subject:From;
        b=hy5JQedIIsbQVcG50cI7G+2WnVyia0EYSoHefEHQ4SJWMTzjObV82qWV3SRjDATKt
         NSmD1T/g0nSGfKM+toB2OPdu0kTx/6B76x6EL7fVw52AzlOF2Jrlf//qnEzpmzPqhr
         du6AdSlu6cutKIrp7Rcd369iS0ozQ9Hn0Bb5zIaWr8E8gotsNyJb2SBbbkAtTJL/sB
         iihllhn+bijiT+bKRI1roaKMZ+1rvd6UGdbPeMGC2RWvghtzippf6MSGuJwu3pvPsQ
         q7SQIHi28KIn1S/LZ7vy7cT8Q4WSJKL7NC2/Ein43J9V/SvwE8jhcvZxkvHibTA4EL
         VClFeWSuiRljw==
Date:   Mon, 7 Mar 2022 15:14:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: manual merge of the scsi tree with the block tree
Message-ID: <20220307151453.21e0ceab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NQfAqqu0.k.ne2d_jmVv=b1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NQfAqqu0.k.ne2d_jmVv=b1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi tree got a conflict in:

  block/blk-merge.c

between commit:

  6928b8f7eafa ("block: remove the per-bio/request write hint")

from the block tree and commit:

  73bd66d9c834 ("scsi: block: Remove REQ_OP_WRITE_SAME support")

from the scsi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc block/blk-merge.c
index 0e871d4e7cb8,87cee7e82ae1..000000000000
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@@ -778,10 -749,13 +747,6 @@@ static struct request *attempt_merge(st
  	if (rq_data_dir(req) !=3D rq_data_dir(next))
  		return NULL;
 =20
- 	if (req_op(req) =3D=3D REQ_OP_WRITE_SAME &&
- 	    !blk_write_same_mergeable(req->bio, next->bio))
 -	/*
 -	 * Don't allow merge of different write hints, or for a hint with
 -	 * non-hint IO.
 -	 */
 -	if (req->write_hint !=3D next->write_hint)
--		return NULL;
--
  	if (req->ioprio !=3D next->ioprio)
  		return NULL;
 =20
@@@ -903,11 -877,13 +868,6 @@@ bool blk_rq_merge_ok(struct request *rq
  	if (!bio_crypt_rq_ctx_compatible(rq, bio))
  		return false;
 =20
- 	/* must be using the same buffer */
- 	if (req_op(rq) =3D=3D REQ_OP_WRITE_SAME &&
- 	    !blk_write_same_mergeable(rq->bio, bio))
 -	/*
 -	 * Don't allow merge of different write hints, or for a hint with
 -	 * non-hint IO.
 -	 */
 -	if (rq->write_hint !=3D bio->bi_write_hint)
--		return false;
--
  	if (rq->ioprio !=3D bio_prio(bio))
  		return false;
 =20

--Sig_/NQfAqqu0.k.ne2d_jmVv=b1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIlhr0ACgkQAVBC80lX
0Gx77Qf8D1j35lZqafHP31jkNZtbtQOBMESdUYogUDn+fH1gebtS+7slyMGGKT5q
wJSWa7RFsoacdsNpGSlPwWAAY2It7YYMSplQsCaZTJ45mwN5/kI8VUrKlPRIykiX
JXqnvTMM2XfkGrlawQQgR9qjq0JbXbDYm17kxwTI2LZvYmKNvRhKTVmeYUt+nAGH
L/RFW+GcGLxBzyx/1r0rs7xAy2n/p9aYOOuAcAGymVJOFTeYYdy4GOMMklp2QZYd
JDjMSAbJpZ0tl/pMXakLAkSYPIS7nnl5Gxiti/qK0JDCHKT1FJlkZYcNqS38Apyy
q+iF5HqZc0uubv/s09DkS2I4bS8E0w==
=xd8r
-----END PGP SIGNATURE-----

--Sig_/NQfAqqu0.k.ne2d_jmVv=b1--
