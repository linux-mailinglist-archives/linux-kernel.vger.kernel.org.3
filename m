Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2479C59B88B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 06:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiHVEqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 00:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiHVEqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 00:46:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB11E3C0;
        Sun, 21 Aug 2022 21:46:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MB0Dn1HLPz4wgn;
        Mon, 22 Aug 2022 14:46:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661143577;
        bh=PRPjNL9OqgsyzZoS7vFE/y8nJQbhGK73LvTpUznB0Ic=;
        h=Date:From:To:Cc:Subject:From;
        b=ODXXdh0O1XZJXeyHhIQqyWglRStXAltYiSwRNyd2Bai/J15jbTmGejgjdNM//goeA
         ssyvgHTns0b1+CBmr0tDW+T2aPu9epwUQqsAwmhg6mYGLjUkaMVS4lj9N0a2FjERjT
         K4xla1IzXdrENMsBKmM5fTvYj8234EQCrqS3SQMj29PO29Biou7e/NTEmmFZSmFFpk
         FM8+mA7binC6/Wn5ibEn/yiLK/xswuE0P2Sa6aPA2rpDgsYaz9hS6twGJS81TZSgKj
         GRoZploS5Pr8SR/zJgPVULmpdSeI7WhEmHWm4pEmpAWKG1xvsjBIJuyKK40rOcHQf4
         fDgTw/gjbCfJw==
Date:   Mon, 22 Aug 2022 14:46:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20220822144613.6e6ce950@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qRNm9vP81sVp7B8pV3z+oRm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qRNm9vP81sVp7B8pV3z+oRm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (sparc defconfig)
failed like this:

drivers/scsi/qlogicpti.c: In function 'qpti_map_queues':
drivers/scsi/qlogicpti.c:828:24: error: 'return' with a value, in function =
returning void [-Werror=3Dreturn-type]
  828 |                 return -1;
      |                        ^
drivers/scsi/qlogicpti.c:817:13: note: declared here
  817 | static void qpti_map_queues(struct qlogicpti *qpti)
      |             ^~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c:839:24: error: 'return' with a value, in function =
returning void [-Werror=3Dreturn-type]
  839 |                 return -1;
      |                        ^
drivers/scsi/qlogicpti.c:817:13: note: declared here
  817 | static void qpti_map_queues(struct qlogicpti *qpti)
      |             ^~~~~~~~~~~~~~~
drivers/scsi/qlogicpti.c: In function 'qpti_sbus_probe':
drivers/scsi/qlogicpti.c:1394:1: warning: label 'fail_free_irq' defined but=
 not used [-Wunused-label]
 1394 | fail_free_irq:
      | ^~~~~~~~~~~~~
cc1: some warnings being treated as errors

Caused by commit

  f19f2c966b2f ("block: Change the return type of blk_mq_map_queues() into =
void")

I have applied the following fix up patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 22 Aug 2022 14:40:02 +1000
Subject: [PATCH] fix up for "block: Change the return type of blk_mq_map_qu=
eues() into void"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/scsi/qlogicpti.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index a5aa716e9086..5bddfe0233b2 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -825,7 +825,7 @@ static void qpti_map_queues(struct qlogicpti *qpti)
 	if (qpti->res_cpu =3D=3D NULL ||
 	    qpti->res_dvma =3D=3D 0) {
 		printk("QPTI: Cannot map response queue.\n");
-		return -1;
+		return;
 	}
=20
 	qpti->req_cpu =3D dma_alloc_coherent(&op->dev,
@@ -836,7 +836,7 @@ static void qpti_map_queues(struct qlogicpti *qpti)
 		dma_free_coherent(&op->dev, QSIZE(RES_QUEUE_LEN),
 				  qpti->res_cpu, qpti->res_dvma);
 		printk("QPTI: Cannot map request queue.\n");
-		return -1;
+		return;
 	}
 	memset(qpti->res_cpu, 0, QSIZE(RES_QUEUE_LEN));
 	memset(qpti->req_cpu, 0, QSIZE(QLOGICPTI_REQ_QUEUE_LEN));
@@ -1391,7 +1391,6 @@ static int qpti_sbus_probe(struct platform_device *op)
 			  qpti->req_cpu, qpti->req_dvma);
 #undef QSIZE
=20
-fail_free_irq:
 	free_irq(qpti->irq, qpti);
=20
 fail_unmap_regs:
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/qRNm9vP81sVp7B8pV3z+oRm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMDChUACgkQAVBC80lX
0Gxxwgf/bZgcmGzBLWoulYmJvl6HdNI8D1gF6mze7dOxQBsCuIPY7wkb2WGCtnYO
9jqpD82TQ6we0Q0W7QtjNhmk0I+r6kNPKnkQNjgpKyw6gWSvNDK0hQtwxjA8Hy/C
sdOEhDuo04GzlnCs2eNr2UZwXMley7vG8fDbyXKZvL55jx9J9kUYGzgAOrE+vSZD
8kU26wmFpvP/8+T7RPdkaRsOTBfvufsUVudKDZwqjgLdeZCC37a4BPj9kjmCYj5u
gMQ83E2Ij91PeE5suEmo9bC6XB/Z5j3On9DlWD14JundbHB5sWwFAvOHd+VE1jAC
o11TXt83N++yZj2urezErYluDjDFlw==
=7my4
-----END PGP SIGNATURE-----

--Sig_/qRNm9vP81sVp7B8pV3z+oRm--
