Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBFE4E8A86
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiC0WeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiC0WeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:34:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3139449C99;
        Sun, 27 Mar 2022 15:32:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KRVvK1418z4xXS;
        Mon, 28 Mar 2022 09:32:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648420349;
        bh=eGnzFInsDLriIvOfS1qS5g3gq01yurBK57/e7LTZYXw=;
        h=Date:From:To:Cc:Subject:From;
        b=bBSPiO2YJ98hxnBqIblzmHY/pptEACqZhmewYK09YfOLH2z871QTJEGkoeuNvPkp/
         TgjMvgok7fFQ7j96hWfnTha5NxaXs1ZRgRbQz4edWrxFnsmEhixvkz9DRjWa/VFwOV
         YWIjabSGdVBpf92SCNO03fEbxpg219t+DAAYksk7W2k4+UvAObdW0wAnexlH0uTUeW
         sAdRfy41wLbUUl0+R82vI/JCzWcs04yiuGC3P7sQJ0N9RRICnlSYUVol9ZPH/LiN8v
         dR/kIS7YQl8tGjvr+9MCPi2sg0WDov+DJGJysVRpWaY3BJVNNx8tJhEFP1M5hTlx8x
         2DUlt3D0/Pjlg==
Date:   Mon, 28 Mar 2022 09:32:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the cifs tree with Linus' tree
Message-ID: <20220328093228.3c2a6019@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AtoCfsxgC+r=uegyvJMlbg2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AtoCfsxgC+r=uegyvJMlbg2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cifs tree got a conflict in:

  fs/ksmbd/smb2pdu.h

between commit:

  5224f7909617 ("treewide: Replace zero-length arrays with flexible-array m=
embers")

from Linus' tree and commit:

  be1350004392 ("smb3: move defines for query info and query fsinfo to smbf=
s_common")

from the cifs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ksmbd/smb2pdu.h
index d49468426576,4db2896b977b..000000000000
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@@ -818,13 -402,9 +402,9 @@@ struct smb2_file_stream_info=20
  	__le32  StreamNameLength;
  	__le64 StreamSize;
  	__le64 StreamAllocationSize;
 -	char   StreamName[0];
 +	char   StreamName[];
  } __packed;
 =20
- struct smb2_file_eof_info { /* encoding of request for level 10 */
- 	__le64 EndOfFile; /* new end of file value */
- } __packed; /* level 20 Set */
-=20
  struct smb2_file_ntwrk_info {
  	__le64 CreationTime;
  	__le64 LastAccessTime;

--Sig_/AtoCfsxgC+r=uegyvJMlbg2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJA5fwACgkQAVBC80lX
0Gzfywf/fVjZrbTPcdvC0okFkip2vEmy1KyZSZx9g638jNIBHmKfXmb8uu8oAICv
tf4slHDSX5MHLfBsxuaRZHlFcAHulohU7q4Oki1lnI9anKMUiXPClnZ0QKdXU5OM
zAqHsT1jxq6VoPz6TBIOBeeA48wmgXA7MtdcGE4HbrOM458Dvg6wVJUyWpin/9dU
psHwGlXdno92BbDKC2ChjzfSbdkL7uWYfaM2cYBMK1iv9ulMdeHpjbDvjHN9Nx4a
Sr5btmceoJX8P0go2aB7i4qk4bD549yA5JIRTB2iXY/KK+nmk+RQVSiS07kFILbi
jOyNEqrHSrrInO1a6jF4krdJgK2rqA==
=nyNJ
-----END PGP SIGNATURE-----

--Sig_/AtoCfsxgC+r=uegyvJMlbg2--
