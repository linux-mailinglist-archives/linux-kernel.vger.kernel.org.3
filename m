Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36E535379
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiEZSl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348634AbiEZSj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DF369705;
        Thu, 26 May 2022 11:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6250361844;
        Thu, 26 May 2022 18:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CCFC385A9;
        Thu, 26 May 2022 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653590397;
        bh=AgFmrtegK+cAzXrHn+2PNwciuMSnJKAsgacqmVbnJM4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E8Lk7nQv7P+pHtvS2ozvf5IDIcZAJYkWieZFFfSD5GMnwBFfZzjBNjgJ7G/O6HWit
         w3m9AeXJxJHsQSp3lGHCB0ZHr3Hrrz3EWv50wK+8gIDa6CwKywgs2G9hu7HwV1wWJ7
         h2lP/9Iq+r2d17/6g5ws9L8/IhyFV2Q0Gt+lmZbBHj2irD458FuTE15Qr31px/2DJn
         k9Oht2Utgl7vd7jeDvhnQmEerKtM/W8zq73Q8gK/fwVcRrkwiIrcRFPoraN3DX9PmH
         j0EqrMfxqOD53GLiSUSmf9+z65AZAkSU+vl4fiUFph0L0uwl1hqaqFhDx72J+7BAcH
         q/GLN3llS5AQg==
Message-ID: <fb3d817d8b6235472e517a9fc9ad0956fb4e8cf2.camel@kernel.org>
Subject: Re: [RFC PATCH v2] ceph: prevent a client from exceeding the MDS
 maximum xattr size
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 26 May 2022 14:39:55 -0400
In-Reply-To: <20220525172427.3692-1-lhenriques@suse.de>
References: <20220525172427.3692-1-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-25 at 18:24 +0100, Lu=EDs Henriques wrote:
> The MDS tries to enforce a limit on the total key/values in extended
> attributes.  However, this limit is enforced only if doing a synchronous
> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
> doesn't have a chance to enforce these limits.
>=20
> This patch adds support for an extra feature bit that will allow the
> client to get the MDS max_xattr_pairs_size setting in the session message=
.
> Then, when setting an xattr, the kernel will revert to do a synchronous
> operation if that maximum size is exceeded.
>=20
> While there, fix a dout() that would trigger a printk warning:
>=20
> [   98.718078] ------------[ cut here ]------------
> [   98.719012] precision 65536 too large
> [   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprintf=
+0x5e3/0x600
> ...
>=20
> URL: https://tracker.ceph.com/issues/55725
> Signed-off-by: Lu=EDs Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/mds_client.c | 12 ++++++++++++
>  fs/ceph/mds_client.h | 15 ++++++++++++++-
>  fs/ceph/xattr.c      | 12 ++++++++----
>  3 files changed, 34 insertions(+), 5 deletions(-)
>=20
> * Changes since v1
>=20
> Added support for new feature bit to get the MDS max_xattr_pairs_size
> setting.
>=20
> Also note that this patch relies on a patch that hasn't been merged yet
> ("ceph: use correct index when encoding client supported features"),
> otherwise the new feature bit won't be correctly encoded.
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 35597fafb48c..87a25b7cf496 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3500,6 +3500,7 @@ static void handle_session(struct ceph_mds_session =
*session,
>  	struct ceph_mds_session_head *h;
>  	u32 op;
>  	u64 seq, features =3D 0;
> +	u64 max_xattr_pairs_size =3D 0;
>  	int wake =3D 0;
>  	bool blocklisted =3D false;
> =20
> @@ -3545,6 +3546,9 @@ static void handle_session(struct ceph_mds_session =
*session,
>  		}
>  	}
> =20
> +	if (msg_version >=3D 6)
> +		ceph_decode_64_safe(&p, end, max_xattr_pairs_size, bad);
> +
>  	mutex_lock(&mdsc->mutex);
>  	if (op =3D=3D CEPH_SESSION_CLOSE) {
>  		ceph_get_mds_session(session);
> @@ -3552,6 +3556,12 @@ static void handle_session(struct ceph_mds_session=
 *session,
>  	}
>  	/* FIXME: this ttl calculation is generous */
>  	session->s_ttl =3D jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
> +
> +	if (max_xattr_pairs_size && (op =3D=3D CEPH_SESSION_OPEN)) {
> +		dout("Changing MDS max xattrs pairs size: %llu =3D> %llu\n",
> +		     mdsc->max_xattr_pairs_size, max_xattr_pairs_size);
> +		mdsc->max_xattr_pairs_size =3D max_xattr_pairs_size;
> +	}
>  	mutex_unlock(&mdsc->mutex);
> =20
>  	mutex_lock(&session->s_mutex);
> @@ -4761,6 +4771,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>  	strscpy(mdsc->nodename, utsname()->nodename,
>  		sizeof(mdsc->nodename));
> =20
> +	mdsc->max_xattr_pairs_size =3D MDS_MAX_XATTR_PAIRS_SIZE;
> +
>  	fsc->mdsc =3D mdsc;
>  	return 0;
> =20
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index ca32f26f5eed..3db777df6d88 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -29,8 +29,11 @@ enum ceph_feature_type {
>  	CEPHFS_FEATURE_MULTI_RECONNECT,
>  	CEPHFS_FEATURE_DELEG_INO,
>  	CEPHFS_FEATURE_METRIC_COLLECT,
> +	CEPHFS_FEATURE_ALTERNATE_NAME,
> +	CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
> +	CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,

Having to make this feature-bit-dependent kind of sucks. I wonder if it
could be avoided...

A question:

How do the MDS's discover this setting? Do they get it from the mons? If
so, I wonder if there is a way for the clients to query the mon for this
instead of having to extend the MDS protocol?

> =20
> -	CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_METRIC_COLLECT,
> +	CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,
>  };
> =20
>  /*
> @@ -45,9 +48,16 @@ enum ceph_feature_type {
>  	CEPHFS_FEATURE_MULTI_RECONNECT,		\
>  	CEPHFS_FEATURE_DELEG_INO,		\
>  	CEPHFS_FEATURE_METRIC_COLLECT,		\
> +	CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,	\
>  }
>  #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
> =20
> +/*
> + * Maximum size of xattrs the MDS can handle per inode by default.  This
> + * includes the attribute name and 4+4 bytes for the key/value sizes.
> + */
> +#define MDS_MAX_XATTR_PAIRS_SIZE (1<<16) /* 64K */
> +
>  /*
>   * Some lock dependencies:
>   *
> @@ -404,6 +414,9 @@ struct ceph_mds_client {
>  	struct rb_root		quotarealms_inodes;
>  	struct mutex		quotarealms_inodes_mutex;
> =20
> +	/* maximum aggregate size of extended attributes on a file */
> +	u64			max_xattr_pairs_size;
> +
>  	/*
>  	 * snap_rwsem will cover cap linkage into snaprealms, and
>  	 * realm snap contexts.  (later, we can do per-realm snap
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 8c2dc2c762a4..175a8c1449aa 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1086,7 +1086,7 @@ static int ceph_sync_setxattr(struct inode *inode, =
const char *name,
>  			flags |=3D CEPH_XATTR_REMOVE;
>  	}
> =20
> -	dout("setxattr value=3D%.*s\n", (int)size, value);
> +	dout("setxattr value size: %ld\n", size);
> =20
>  	/* do request */
>  	req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> @@ -1184,8 +1184,14 @@ int __ceph_setxattr(struct inode *inode, const cha=
r *name,
>  	spin_lock(&ci->i_ceph_lock);
>  retry:
>  	issued =3D __ceph_caps_issued(ci, NULL);
> -	if (ci->i_xattrs.version =3D=3D 0 || !(issued & CEPH_CAP_XATTR_EXCL))
> +	required_blob_size =3D __get_required_blob_size(ci, name_len, val_len);
> +	if ((ci->i_xattrs.version =3D=3D 0) || !(issued & CEPH_CAP_XATTR_EXCL) =
||
> +	    (required_blob_size >=3D mdsc->max_xattr_pairs_size)) {
> +		dout("%s do sync setxattr: version: %llu size: %d max: %llu\n",
> +		     __func__, ci->i_xattrs.version, required_blob_size,
> +		     mdsc->max_xattr_pairs_size);
>  		goto do_sync;
> +	}
> =20
>  	if (!lock_snap_rwsem && !ci->i_head_snapc) {
>  		lock_snap_rwsem =3D true;
> @@ -1201,8 +1207,6 @@ int __ceph_setxattr(struct inode *inode, const char=
 *name,
>  	     ceph_cap_string(issued));
>  	__build_xattrs(inode);
> =20
> -	required_blob_size =3D __get_required_blob_size(ci, name_len, val_len);
> -
>  	if (!ci->i_xattrs.prealloc_blob ||
>  	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
>  		struct ceph_buffer *blob;

--=20
Jeff Layton <jlayton@kernel.org>
