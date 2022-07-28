Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34052583762
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbiG1DPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiG1DPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:15:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FDB1035;
        Wed, 27 Jul 2022 20:15:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LtbP36b0wz4x1F;
        Thu, 28 Jul 2022 13:15:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658978105;
        bh=7e66GShGF4d0fnCJXtFWm/XyPFNyJqkbIlauyHHtNrM=;
        h=Date:From:To:Cc:Subject:From;
        b=gTpqC4AoSEqRgfLQH8/TbQvGsIcho4jyacCzRLCh0MgDCzx6RzObziV1xu2ebtu+W
         1AImVGfysxwinJQuqw8Zuyp6f8e9tewdv6dYDpyOX0Wjx2o9IcTpHx6wxLL7dlR5Co
         MWnFnZ4vfjzJ9ucxeYt+91cqkFvUAAW2VkguRwO73r1/njfEowBFggbh60lSaYr4xk
         ZHZgI5NJ04k9gRRWsm2WquHgg/ZxUfCyCnc5/Tepe2YbSvS34DeeS/prY0FtyMD9ON
         4NxgnyF93M/dT7N4kDuHxbOYJ2ZVYpBI1o0n0wrXNBK4q0BPPGwCOK7dslyQmgbi3a
         nD82RujocNnFQ==
Date:   Thu, 28 Jul 2022 13:14:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: linux-next: manual merge of the device-mapper tree with the block
 tree
Message-ID: <20220728131459.7348fe5e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5kzJvbeoG5S8dV_9ABIRuFf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5kzJvbeoG5S8dV_9ABIRuFf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the device-mapper tree got a conflict in:

  drivers/md/dm.c

between commit:

  1be3479b8533 ("block: move ->bio_split to the gendisk")

from the block tree and commit:

  8b211aaccb91 ("dm: add two stage requeue mechanism")

from the device-mapper tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/md/dm.c
index b7458f2dd3e4,47bcc5081b2b..000000000000
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@@ -962,6 -1001,58 +1001,58 @@@ static void __dm_io_complete(struct dm_
  	}
  }
 =20
+ static void dm_wq_requeue_work(struct work_struct *work)
+ {
+ 	struct mapped_device *md =3D container_of(work, struct mapped_device,
+ 						requeue_work);
+ 	unsigned long flags;
+ 	struct dm_io *io;
+=20
+ 	/* reuse deferred lock to simplify dm_handle_requeue */
+ 	spin_lock_irqsave(&md->deferred_lock, flags);
+ 	io =3D md->requeue_list;
+ 	md->requeue_list =3D NULL;
+ 	spin_unlock_irqrestore(&md->deferred_lock, flags);
+=20
+ 	while (io) {
+ 		struct dm_io *next =3D io->next;
+=20
 -		dm_io_rewind(io, &md->queue->bio_split);
++		dm_io_rewind(io, &md->disk->bio_split);
+=20
+ 		io->next =3D NULL;
+ 		__dm_io_complete(io, false);
+ 		io =3D next;
+ 	}
+ }
+=20
+ /*
+  * Two staged requeue:
+  *
+  * 1) io->orig_bio points to the real original bio, and the part mapped to
+  *    this io must be requeued, instead of other parts of the original bi=
o.
+  *
+  * 2) io->orig_bio points to new cloned bio which matches the requeued dm=
_io.
+  */
+ static void dm_io_complete(struct dm_io *io)
+ {
+ 	bool first_requeue;
+=20
+ 	/*
+ 	 * Only dm_io that has been split needs two stage requeue, otherwise
+ 	 * we may run into long bio clone chain during suspend and OOM could
+ 	 * be triggered.
+ 	 *
+ 	 * Also flush data dm_io won't be marked as DM_IO_WAS_SPLIT, so they
+ 	 * also aren't handled via the first stage requeue.
+ 	 */
+ 	if (dm_io_flagged(io, DM_IO_WAS_SPLIT))
+ 		first_requeue =3D true;
+ 	else
+ 		first_requeue =3D false;
+=20
+ 	__dm_io_complete(io, first_requeue);
+ }
+=20
  /*
   * Decrements the number of outstanding ios that a bio has been
   * cloned into, completing the original io if necc.

--Sig_/5kzJvbeoG5S8dV_9ABIRuFf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLh/zQACgkQAVBC80lX
0GxEXAgAgqMbzpLpuHEQyMYzu0nfLaFuMp1Fm593wv/jeH2XLvqmprBS3pH1Pl/I
VuAsn2FtH6kOdSX4U0zlCQSswgfk3ALwKXAa/kG87DeJgDN2819gSH9xaUddyGyo
gGcl0cMRa1UqMQZFGSsKD+418UcECRvAIrbds3lxmqXig9kkYLAW9TCDH4koKrlB
Yt+4YXRSmyVLhIqrxfQL7YEvI4itWl5qW0MowZXpr/fT5wsHt3OQdjQuKuqGvs7H
QTpefeMayB3LF6LKzzNe6c7d/DhqvzkGY224bcNK+GIUPXphdwUoitkQEfAahYa8
qVpQy7qU+bVTPRYeE+ZOC6/y09JTvA==
=9q3b
-----END PGP SIGNATURE-----

--Sig_/5kzJvbeoG5S8dV_9ABIRuFf--
