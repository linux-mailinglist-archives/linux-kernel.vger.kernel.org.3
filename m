Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C221535733
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiE0AoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiE0AoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:44:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0B3E64C0;
        Thu, 26 May 2022 17:44:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02A8CB82178;
        Fri, 27 May 2022 00:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C545C385B8;
        Fri, 27 May 2022 00:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653612249;
        bh=YMVu9EkRya7bepAagUUeL4DJvi1g8W6zwzX+5oCDky0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W5pIMFqfJTCpFzXnh639oDwcdHWEVG7id+hDbNelmVoXxU8dUSYHvIVAMu94q1TcM
         gLCuAJeYfr//mHeWNvAsnrBa79QWefLCCmm641CrAANg6+bcjBTH+a955l8Z/xZC7e
         gbp+jQduWYNgBFqlq8g3nMhP8OwqAe60Iity+Ibtcxs9mLIqiHfvf2v9Jc9UHR8pIR
         wKvkwpQakW9QEaOlnwEZBp74RxLLulqh3Uwn0eP8G8Iew70bpc7kuNcSJp7v6usA3l
         SNgqYHvyHz7Vn204AJe1fVyN42nhW0Oa458mwEntX3jA4ygRM+iuafLfPb/suA32WL
         GqK9GYDQ8aZVQ==
Message-ID: <ca4928507bdf329bbe5b32a7b71f4a4295e5bba1.camel@kernel.org>
Subject: Re: [RFC PATCH v2] ceph: prevent a client from exceeding the MDS
 maximum xattr size
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>,
        =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 26 May 2022 20:44:07 -0400
In-Reply-To: <3cb96552-9747-c6b4-c8d3-81af60e5ae6a@redhat.com>
References: <20220525172427.3692-1-lhenriques@suse.de>
         <fb3d817d8b6235472e517a9fc9ad0956fb4e8cf2.camel@kernel.org>
         <3cb96552-9747-c6b4-c8d3-81af60e5ae6a@redhat.com>
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

On Fri, 2022-05-27 at 08:36 +0800, Xiubo Li wrote:
> On 5/27/22 2:39 AM, Jeff Layton wrote:
> > On Wed, 2022-05-25 at 18:24 +0100, Lu=EDs Henriques wrote:
> > > The MDS tries to enforce a limit on the total key/values in extended
> > > attributes.  However, this limit is enforced only if doing a synchron=
ous
> > > operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
> > > doesn't have a chance to enforce these limits.
> > >=20
> > > This patch adds support for an extra feature bit that will allow the
> > > client to get the MDS max_xattr_pairs_size setting in the session mes=
sage.
> > > Then, when setting an xattr, the kernel will revert to do a synchrono=
us
> > > operation if that maximum size is exceeded.
> > >=20
> > > While there, fix a dout() that would trigger a printk warning:
> > >=20
> > > [   98.718078] ------------[ cut here ]------------
> > > [   98.719012] precision 65536 too large
> > > [   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnpr=
intf+0x5e3/0x600
> > > ...
> > >=20
> > > URL: https://tracker.ceph.com/issues/55725
> > > Signed-off-by: Lu=EDs Henriques <lhenriques@suse.de>
> > > ---
> > >   fs/ceph/mds_client.c | 12 ++++++++++++
> > >   fs/ceph/mds_client.h | 15 ++++++++++++++-
> > >   fs/ceph/xattr.c      | 12 ++++++++----
> > >   3 files changed, 34 insertions(+), 5 deletions(-)
> > >=20
> > > * Changes since v1
> > >=20
> > > Added support for new feature bit to get the MDS max_xattr_pairs_size
> > > setting.
> > >=20
> > > Also note that this patch relies on a patch that hasn't been merged y=
et
> > > ("ceph: use correct index when encoding client supported features"),
> > > otherwise the new feature bit won't be correctly encoded.
> > >=20
> > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > index 35597fafb48c..87a25b7cf496 100644
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -3500,6 +3500,7 @@ static void handle_session(struct ceph_mds_sess=
ion *session,
> > >   	struct ceph_mds_session_head *h;
> > >   	u32 op;
> > >   	u64 seq, features =3D 0;
> > > +	u64 max_xattr_pairs_size =3D 0;
> > >   	int wake =3D 0;
> > >   	bool blocklisted =3D false;
> > >  =20
> > > @@ -3545,6 +3546,9 @@ static void handle_session(struct ceph_mds_sess=
ion *session,
> > >   		}
> > >   	}
> > >  =20
> > > +	if (msg_version >=3D 6)
> > > +		ceph_decode_64_safe(&p, end, max_xattr_pairs_size, bad);
> > > +
> > >   	mutex_lock(&mdsc->mutex);
> > >   	if (op =3D=3D CEPH_SESSION_CLOSE) {
> > >   		ceph_get_mds_session(session);
> > > @@ -3552,6 +3556,12 @@ static void handle_session(struct ceph_mds_ses=
sion *session,
> > >   	}
> > >   	/* FIXME: this ttl calculation is generous */
> > >   	session->s_ttl =3D jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
> > > +
> > > +	if (max_xattr_pairs_size && (op =3D=3D CEPH_SESSION_OPEN)) {
> > > +		dout("Changing MDS max xattrs pairs size: %llu =3D> %llu\n",
> > > +		     mdsc->max_xattr_pairs_size, max_xattr_pairs_size);
> > > +		mdsc->max_xattr_pairs_size =3D max_xattr_pairs_size;
> > > +	}
> > >   	mutex_unlock(&mdsc->mutex);
> > >  =20
> > >   	mutex_lock(&session->s_mutex);
> > > @@ -4761,6 +4771,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
> > >   	strscpy(mdsc->nodename, utsname()->nodename,
> > >   		sizeof(mdsc->nodename));
> > >  =20
> > > +	mdsc->max_xattr_pairs_size =3D MDS_MAX_XATTR_PAIRS_SIZE;
> > > +
> > >   	fsc->mdsc =3D mdsc;
> > >   	return 0;
> > >  =20
> > > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > > index ca32f26f5eed..3db777df6d88 100644
> > > --- a/fs/ceph/mds_client.h
> > > +++ b/fs/ceph/mds_client.h
> > > @@ -29,8 +29,11 @@ enum ceph_feature_type {
> > >   	CEPHFS_FEATURE_MULTI_RECONNECT,
> > >   	CEPHFS_FEATURE_DELEG_INO,
> > >   	CEPHFS_FEATURE_METRIC_COLLECT,
> > > +	CEPHFS_FEATURE_ALTERNATE_NAME,
> > > +	CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
> > > +	CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,
> > Having to make this feature-bit-dependent kind of sucks. I wonder if it
> > could be avoided...
> >=20
> > A question:
> >=20
> > How do the MDS's discover this setting? Do they get it from the mons? I=
f
> > so, I wonder if there is a way for the clients to query the mon for thi=
s
> > instead of having to extend the MDS protocol?
>=20
> It sounds like what the "max_file_size" does, which will be recorded in=
=20
> the 'mdsmap'.
>=20
> While currently the "max_xattr_pairs_size" is one MDS's option for each=
=20
> daemon and could set different values for each MDS.
>=20
>=20

Right, but the MDS's in general don't use local config files. Where are
these settings stored? Could the client (potentially) query for them?

I'm pretty sure the client does fetch and parse the mdsmap. If it's
there then it could grab the setting for all of the MDS's at mount time
and settle on the lowest one.

I think a solution like that might be more resilient than having to
fiddle with feature bits and such...

> > >  =20
> > > -	CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_METRIC_COLLECT,
> > > +	CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,
> > >   };
> > >  =20
> > >   /*
> > > @@ -45,9 +48,16 @@ enum ceph_feature_type {
> > >   	CEPHFS_FEATURE_MULTI_RECONNECT,		\
> > >   	CEPHFS_FEATURE_DELEG_INO,		\
> > >   	CEPHFS_FEATURE_METRIC_COLLECT,		\
> > > +	CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,	\
> > >   }
> > >   #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
> > >  =20
> > > +/*
> > > + * Maximum size of xattrs the MDS can handle per inode by default.  =
This
> > > + * includes the attribute name and 4+4 bytes for the key/value sizes=
.
> > > + */
> > > +#define MDS_MAX_XATTR_PAIRS_SIZE (1<<16) /* 64K */
> > > +
> > >   /*
> > >    * Some lock dependencies:
> > >    *
> > > @@ -404,6 +414,9 @@ struct ceph_mds_client {
> > >   	struct rb_root		quotarealms_inodes;
> > >   	struct mutex		quotarealms_inodes_mutex;
> > >  =20
> > > +	/* maximum aggregate size of extended attributes on a file */
> > > +	u64			max_xattr_pairs_size;
> > > +
> > >   	/*
> > >   	 * snap_rwsem will cover cap linkage into snaprealms, and
> > >   	 * realm snap contexts.  (later, we can do per-realm snap
> > > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > > index 8c2dc2c762a4..175a8c1449aa 100644
> > > --- a/fs/ceph/xattr.c
> > > +++ b/fs/ceph/xattr.c
> > > @@ -1086,7 +1086,7 @@ static int ceph_sync_setxattr(struct inode *ino=
de, const char *name,
> > >   			flags |=3D CEPH_XATTR_REMOVE;
> > >   	}
> > >  =20
> > > -	dout("setxattr value=3D%.*s\n", (int)size, value);
> > > +	dout("setxattr value size: %ld\n", size);
> > >  =20
> > >   	/* do request */
> > >   	req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> > > @@ -1184,8 +1184,14 @@ int __ceph_setxattr(struct inode *inode, const=
 char *name,
> > >   	spin_lock(&ci->i_ceph_lock);
> > >   retry:
> > >   	issued =3D __ceph_caps_issued(ci, NULL);
> > > -	if (ci->i_xattrs.version =3D=3D 0 || !(issued & CEPH_CAP_XATTR_EXCL=
))
> > > +	required_blob_size =3D __get_required_blob_size(ci, name_len, val_l=
en);
> > > +	if ((ci->i_xattrs.version =3D=3D 0) || !(issued & CEPH_CAP_XATTR_EX=
CL) ||
> > > +	    (required_blob_size >=3D mdsc->max_xattr_pairs_size)) {
> > > +		dout("%s do sync setxattr: version: %llu size: %d max: %llu\n",
> > > +		     __func__, ci->i_xattrs.version, required_blob_size,
> > > +		     mdsc->max_xattr_pairs_size);
> > >   		goto do_sync;
> > > +	}
> > >  =20
> > >   	if (!lock_snap_rwsem && !ci->i_head_snapc) {
> > >   		lock_snap_rwsem =3D true;
> > > @@ -1201,8 +1207,6 @@ int __ceph_setxattr(struct inode *inode, const =
char *name,
> > >   	     ceph_cap_string(issued));
> > >   	__build_xattrs(inode);
> > >  =20
> > > -	required_blob_size =3D __get_required_blob_size(ci, name_len, val_l=
en);
> > > -
> > >   	if (!ci->i_xattrs.prealloc_blob ||
> > >   	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
> > >   		struct ceph_buffer *blob;
>=20

--=20
Jeff Layton <jlayton@kernel.org>
