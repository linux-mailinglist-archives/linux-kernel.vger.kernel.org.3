Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9201527E56
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiEPHNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiEPHNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:13:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6BDE007;
        Mon, 16 May 2022 00:13:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1r7t66Hyz4xLR;
        Mon, 16 May 2022 17:13:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652685213;
        bh=2Jrm/4Qqn1icmxbBXlFbh7DhKve2cZZ/YB7E7YbK76M=;
        h=Date:From:To:Cc:Subject:From;
        b=KFTFUTUhx+WnA8TX//uBhNHXUgRtcyMalR3X3k3iucDUn/IoEcgiOgjCznxhWyBV0
         5xBksKh+UW43UhgV8lFT/Qu4ax9Kw2TJczVAPM3NwE6O835+f63E2CkV8/EjLM2ZvU
         LbC2VOPqDqSfcN8Z1oMB7+f7m3IUK4adDUx2HfYKTcOpVm2awjQqDH6UnhZ90/mkYR
         iNBSO9Nvf6fZHEyEYHybfuRp0qzAr7B5P9bMPE/wvybXSw9QvYlDvIo/EdzZo8LpBT
         Kkh88iyULvnbUnuM6sUD+PGno8vS/+iENzSQsnhmMiVM0zJCZbmPkJGxwNL300T92P
         ssuDGlj/zV4Pg==
Date:   Mon, 16 May 2022 17:13:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Gaynor <alex.gaynor@gmail.com>,
        Carlos Llamas <cmllamas@google.com>,
        Finn Behrens <me@kloenk.de>, Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wayne Campbell <wcampbell1995@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with the char-misc tree
Message-ID: <20220516171329.6b10e4e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I4QazcnF9oxDJnrrOIxuYeM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I4QazcnF9oxDJnrrOIxuYeM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  include/uapi/linux/android/binder.h

between commit:

  bd32889e841c ("binder: add BINDER_GET_EXTENDED_ERROR ioctl")

from the char-misc tree and commit:

  d637f9ec1954 ("[RFC] drivers: android: Binder IPC in Rust")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/uapi/linux/android/binder.h
index e6ee8cae303b,a982c30dbbf5..000000000000
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@@ -236,35 -236,21 +236,37 @@@ struct binder_frozen_status_info=20
  	__u32            async_recv;
  };
 =20
 +/* struct binder_extened_error - extended error information
 + * @id:		identifier for the failed operation
 + * @command:	command as defined by binder_driver_return_protocol
 + * @param:	parameter holding a negative errno value
 + *
 + * Used with BINDER_GET_EXTENDED_ERROR. This extends the error information
 + * returned by the driver upon a failed operation. Userspace can pull this
 + * data to properly handle specific error scenarios.
 + */
 +struct binder_extended_error {
 +	__u32	id;
 +	__u32	command;
 +	__s32	param;
 +};
 +
- #define BINDER_WRITE_READ		_IOWR('b', 1, struct binder_write_read)
- #define BINDER_SET_IDLE_TIMEOUT		_IOW('b', 3, __s64)
- #define BINDER_SET_MAX_THREADS		_IOW('b', 5, __u32)
- #define BINDER_SET_IDLE_PRIORITY	_IOW('b', 6, __s32)
- #define BINDER_SET_CONTEXT_MGR		_IOW('b', 7, __s32)
- #define BINDER_THREAD_EXIT		_IOW('b', 8, __s32)
- #define BINDER_VERSION			_IOWR('b', 9, struct binder_version)
- #define BINDER_GET_NODE_DEBUG_INFO	_IOWR('b', 11, struct binder_node_debu=
g_info)
- #define BINDER_GET_NODE_INFO_FOR_REF	_IOWR('b', 12, struct binder_node_in=
fo_for_ref)
- #define BINDER_SET_CONTEXT_MGR_EXT	_IOW('b', 13, struct flat_binder_objec=
t)
- #define BINDER_FREEZE			_IOW('b', 14, struct binder_freeze_info)
- #define BINDER_GET_FROZEN_INFO		_IOWR('b', 15, struct binder_frozen_statu=
s_info)
- #define BINDER_ENABLE_ONEWAY_SPAM_DETECTION	_IOW('b', 16, __u32)
- #define BINDER_GET_EXTENDED_ERROR	_IOWR('b', 17, struct binder_extended_e=
rror)
+ enum {
+ 	BINDER_WRITE_READ		=3D _IOWR('b', 1, struct binder_write_read),
+ 	BINDER_SET_IDLE_TIMEOUT		=3D _IOW('b', 3, __s64),
+ 	BINDER_SET_MAX_THREADS		=3D _IOW('b', 5, __u32),
+ 	BINDER_SET_IDLE_PRIORITY	=3D _IOW('b', 6, __s32),
+ 	BINDER_SET_CONTEXT_MGR		=3D _IOW('b', 7, __s32),
+ 	BINDER_THREAD_EXIT		=3D _IOW('b', 8, __s32),
+ 	BINDER_VERSION			=3D _IOWR('b', 9, struct binder_version),
+ 	BINDER_GET_NODE_DEBUG_INFO	=3D _IOWR('b', 11, struct binder_node_debug_i=
nfo),
+ 	BINDER_GET_NODE_INFO_FOR_REF	=3D _IOWR('b', 12, struct binder_node_info_=
for_ref),
+ 	BINDER_SET_CONTEXT_MGR_EXT	=3D _IOW('b', 13, struct flat_binder_object),
+ 	BINDER_FREEZE			=3D _IOW('b', 14, struct binder_freeze_info),
+ 	BINDER_GET_FROZEN_INFO		=3D _IOWR('b', 15, struct binder_frozen_status_i=
nfo),
+ 	BINDER_ENABLE_ONEWAY_SPAM_DETECTION	=3D _IOW('b', 16, __u32),
++	BINDER_GET_EXTENDED_ERROR	=3D _IOWR('b', 17, struct binder_extended_erro=
r),
+ };
 =20
  /*
   * NOTE: Two special error codes you should check for when calling

--Sig_/I4QazcnF9oxDJnrrOIxuYeM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKB+ZkACgkQAVBC80lX
0GyvNwf7Bpb1/PS1b2ljgqh5ntlJfN6cbfMjJMIPNajZFXAvIjLN4Ai720VCphE9
W+kM3VDBXXk8vMJbIDDHYvPjE7Io5Ye+bEw2nxj3CgBltiohgO425FGDzu9NtgY9
fMDSI95ZQLrdJ/tXrNDYULZFRcI0/RQs9uhqyfvdll1Qnyl5sZG0Rh2lie40oMux
lg8iXkOIc/eG/YnuJsUTvN1WjwHfKUsYfpsPACwhYzS1PyGbZbA2ltrE3ChjNccQ
Wyp5CNiYkybsIxNEso+fBnJT3B/c/xGeyl7PdrWus++0zGXSrFNa1Qm4lKA760k9
rPY6lXpZMao3RAp2IhuP64uQlVZLNA==
=8vzt
-----END PGP SIGNATURE-----

--Sig_/I4QazcnF9oxDJnrrOIxuYeM--
