Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA5E49AB25
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351902AbiAYEir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:38:47 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:43541 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582875AbiAYDYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:24:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JjXJt6sSLz4y5t;
        Tue, 25 Jan 2022 14:24:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643081072;
        bh=TZLUgeha3UgBWPULciAx47PKJ6+EbX+2P4quvRb1h0A=;
        h=Date:From:To:Cc:Subject:From;
        b=JycxqdgrDBIoyBIIuF3vGU7CKvzcMMt9NxDdTyBWSQTc76vX0dw3tkedjBNxSyf9V
         vOO2UJ3Z5I2TXaaXGZYDiyJrjjHdpdbpx4goHkm0pHw7jppQfht8YsJjTenNPr59+p
         C1mrAz2mTIOiSYPALLMlHIXAejz0hlwm+/BWjAahTQb93AAaKFskiNKT1BP5M+1Dhn
         EdFRh6T0qIjYevipxAcgNhnIcLSSgo6xC9TdqlVvdbOdq/8iCFyuXxE+6Su6N5pJgN
         FREp5uvhkM2A1/5graxMbIU8XuTxd/+Ewjv/cLnCKy4dItO1nyL0Ey1seVXDziv7n7
         8Au4nV94Xx4Xw==
Date:   Tue, 25 Jan 2022 14:24:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Steven Royer <seroyer@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125142430.75c3160e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a1p_bkazwN8LurQiv3XEc_x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a1p_bkazwN8LurQiv3XEc_x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (powerpc
allyesconfig) failed like this:


drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_send_messa=
ges':
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1934:44: error: array subscript 's=
truct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long =
long unsigned int[1]'} [-Werror=3Darray-bounds]
 1934 |                                         crq->valid =3D VALID_CMD_RE=
SP_EL;
      |                                            ^~
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing '=
msg_hi'
 1875 |         u64 msg_hi =3D 0;
      |             ^~~~~~
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1935:44: error: array subscript 's=
truct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long =
long unsigned int[1]'} [-Werror=3Darray-bounds]
 1935 |                                         crq->format =3D cmd->rsp.fo=
rmat;
      |                                            ^~
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing '=
msg_hi'
 1875 |         u64 msg_hi =3D 0;
      |             ^~~~~~
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1938:52: error: array subscript 's=
truct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long =
long unsigned int[1]'} [-Werror=3Darray-bounds]
 1938 |                                                 crq->status =3D VIO=
SRP_ADAPTER_FAIL;
      |                                                    ^~
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing '=
msg_hi'
 1875 |         u64 msg_hi =3D 0;
      |             ^~~~~~
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1940:44: error: array subscript 's=
truct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long =
long unsigned int[1]'} [-Werror=3Darray-bounds]
 1940 |                                         crq->IU_length =3D cpu_to_b=
e16(cmd->rsp.len);
      |                                            ^~
drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing '=
msg_hi'
 1875 |         u64 msg_hi =3D 0;
      |             ^~~~~~

Exposed by commit

  4ba545781e20 ("Makefile: Enable -Warray-bounds")

Probably introduced by commit

  88a678bbc34c ("ibmvscsis: Initial commit of IBM VSCSI Tgt Driver")

I applied the following hack for now:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 25 Jan 2022 14:18:36 +1100
Subject: [PATCH] scsi: hack for building with -Warray-bounds

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvsc=
si_tgt/ibmvscsi_tgt.c
index 61f06f6885a5..89fcf98c61c3 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -1872,11 +1872,11 @@ static void srp_snd_msg_failed(struct scsi_info *vs=
csi, long rc)
  */
 static void ibmvscsis_send_messages(struct scsi_info *vscsi)
 {
-	u64 msg_hi =3D 0;
+	u64 msg_hi[2] =3D { };
 	/* note do not attempt to access the IU_data_ptr with this pointer
 	 * it is not valid
 	 */
-	struct viosrp_crq *crq =3D (struct viosrp_crq *)&msg_hi;
+	struct viosrp_crq *crq =3D (struct viosrp_crq *)msg_hi;
 	struct ibmvscsis_cmd *cmd, *nxt;
 	long rc =3D ADAPT_SUCCESS;
 	bool retry =3D false;
@@ -1940,7 +1940,7 @@ static void ibmvscsis_send_messages(struct scsi_info =
*vscsi)
 					crq->IU_length =3D cpu_to_be16(cmd->rsp.len);
=20
 					rc =3D h_send_crq(vscsi->dma_dev->unit_address,
-							be64_to_cpu(msg_hi),
+							be64_to_cpu(msg_hi[0]),
 							be64_to_cpu(cmd->rsp.tag));
=20
 					dev_dbg(&vscsi->dev, "send_messages: cmd %p, tag 0x%llx, rc %ld\n",
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/a1p_bkazwN8LurQiv3XEc_x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHvbW4ACgkQAVBC80lX
0GzvMQf/QRhiXVaYaZG2uTo539upkz90dUyYzgIla+hvXu2Ncl+aKbJzDbudgtu0
YyA1qYpwLN+F3L6W0klBFB9b+b7Na6YG+RBiYuI48qK4BXRXmdGbHbRptwL+QJup
Z13twPX7Ip3ppDXjhY6s+8BDwmaPZ8BQ8lW2EkFeQCp0I+fmCNpKPH32vqdVUgMu
cK4jOYk0VurL5miS83sDphMUS9etbCgOIla8k81VYR7Grr+Vk6aiJBz0gRNv2pZj
3B3456eZyd0t7dRnBfuIFhS0jd7AiRRRT24dyQ6OQKeU/5dXx8usPxUK3WwykQJH
oiqF8T/tDlLggKd81lALspKc4Uk7ig==
=AWTT
-----END PGP SIGNATURE-----

--Sig_/a1p_bkazwN8LurQiv3XEc_x--
