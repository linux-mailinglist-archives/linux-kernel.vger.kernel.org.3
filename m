Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA11552EE02
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350217AbiETOVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiETOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:21:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD160045;
        Fri, 20 May 2022 07:21:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61B9C21A89;
        Fri, 20 May 2022 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653056503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3HjEeZ6v9eJRGMzuAUOJEIH0zziIHl1MeGRpDqDTDo=;
        b=gkkCIYhiHP+lvVa27jTaz4AaoSo3uu8QJdQMxnGo5oEC44Svb1DyQQFBfSC0+R707pzNVt
        W9EDJSV4fVdRnoO/6LC4oh6HcXCw1UvL96K/SS5VHs4EoB3aEg3cVy2tw6G3YRLkzOk35c
        R+PGdVeQJg5EOHOKYwoNL7w844KNGxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653056503;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3HjEeZ6v9eJRGMzuAUOJEIH0zziIHl1MeGRpDqDTDo=;
        b=+tLacv2PSOdpysuaM1/Fs4vqo/rnwr04rkPcSzSPmPeTesiLR5263MBBltToAinx9ngC7F
        5GkMGLOF2yhO0GCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEC1213AF4;
        Fri, 20 May 2022 14:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KOJXN/ajh2J5ewAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 20 May 2022 14:21:42 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 9575b903;
        Fri, 20 May 2022 14:22:20 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ceph: try to prevent exceeding the MDS maximum
 xattr size
References: <20220520115426.438-1-lhenriques@suse.de>
Date:   Fri, 20 May 2022 15:22:20 +0100
In-Reply-To: <20220520115426.438-1-lhenriques@suse.de> (=?utf-8?Q?=22Lu?=
 =?utf-8?Q?=C3=ADs?= Henriques"'s
        message of "Fri, 20 May 2022 12:54:26 +0100")
Message-ID: <87ee0o2sir.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lu=C3=ADs Henriques <lhenriques@suse.de> writes:

> The MDS tries to enforce a limit on the total key/values in extended
> attributes.  However, this limit is enforced only if doing a synchronous
> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
> doesn't have a chance to enforce these limits.
>
> This patch forces the usage of the synchronous operation if xattrs size h=
its
> the maximum size that is set on the MDS by default (64k).
>
> While there, fix a dout() that would trigger a printk warning:
>
> [   98.718078] ------------[ cut here ]------------
> [   98.719012] precision 65536 too large
> [   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprintf=
+0x5e3/0x600
> ...
>
> URL: https://tracker.ceph.com/issues/55725
> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/xattr.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index afec84088471..09751a5f028c 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -15,6 +15,12 @@
>  #define XATTR_CEPH_PREFIX "ceph."
>  #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
>=20=20
> +/*
> + * Maximum size of xattrs the MDS can handle per inode by default.  This
> + * includes the attribute name and 4+4 bytes for the key/value sizes.
> + */
> +#define MDS_MAX_XATTR_PAIRS_SIZE (1<<16) /* 64K */
> +
>  static int __remove_xattr(struct ceph_inode_info *ci,
>  			  struct ceph_inode_xattr *xattr);
>=20=20
> @@ -1078,7 +1084,7 @@ static int ceph_sync_setxattr(struct inode *inode, =
const char *name,
>  			flags |=3D CEPH_XATTR_REMOVE;
>  	}
>=20=20
> -	dout("setxattr value=3D%.*s\n", (int)size, value);
> +	dout("setxattr value size: ld\n", size);

Oops!  Looks like someone ate a '%' char.  Oh well, I won't bother sending
out a new version for now as this is an RFC and the MDS side is what
really needs fixing.  In fact, the client-side may be something very
different from this RFC.

Cheers,
--=20
Lu=C3=ADs

>=20=20
>  	/* do request */
>  	req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> @@ -1176,8 +1182,13 @@ int __ceph_setxattr(struct inode *inode, const cha=
r *name,
>  	spin_lock(&ci->i_ceph_lock);
>  retry:
>  	issued =3D __ceph_caps_issued(ci, NULL);
> -	if (ci->i_xattrs.version =3D=3D 0 || !(issued & CEPH_CAP_XATTR_EXCL))
> +	required_blob_size =3D __get_required_blob_size(ci, name_len, val_len);
> +	if ((ci->i_xattrs.version =3D=3D 0) || !(issued & CEPH_CAP_XATTR_EXCL) =
||
> +	    (required_blob_size >=3D MDS_MAX_XATTR_PAIRS_SIZE)) {
> +		dout("%s do sync setxattr: version: %llu blob size: %d\n",
> +		     __func__, ci->i_xattrs.version, required_blob_size);
>  		goto do_sync;
> +	}
>=20=20
>  	if (!lock_snap_rwsem && !ci->i_head_snapc) {
>  		lock_snap_rwsem =3D true;
> @@ -1193,8 +1204,6 @@ int __ceph_setxattr(struct inode *inode, const char=
 *name,
>  	     ceph_cap_string(issued));
>  	__build_xattrs(inode);
>=20=20
> -	required_blob_size =3D __get_required_blob_size(ci, name_len, val_len);
> -
>  	if (!ci->i_xattrs.prealloc_blob ||
>  	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
>  		struct ceph_buffer *blob;

