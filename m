Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F2F531068
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiEWKoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiEWKnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:43:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D06D21833;
        Mon, 23 May 2022 03:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BEE0611F6;
        Mon, 23 May 2022 10:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FF9C34117;
        Mon, 23 May 2022 10:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653302633;
        bh=KHKqeND4HcHsZV3hSnR9IbU+NvEV3e6OgDuG1oSjKZg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UHvUuIdHY0cuEZJghSR2M0LGBOXAS4+svlM83FaQY+DnYTEZtgZs8Q9eVIBQMh1Y/
         CXcSLWzDou5mnTPG2Kpg9lpMw8i2DLcUpE2Tm4+yvTaPYGyAovoj9BHwryi27+Lh+j
         gtPyJQtuoKo7MGj5VT+qJfg/iVK51ztWyeDh0tuVVDTrNp7W2AYjWp8TK7LQjrAnr7
         TIhuJaUlHMcs80lfSamnJ0P/B0jbafu5TJJzcvWYrxzQGlTt4YT/jfrdSCDW/vKUxM
         K6+XGDSt/dfdtTUgG4eXoTzq22ReUaQs5ZlmjRCzJBx0ptdRGwbPrBVP1lW+KYXm9k
         RBXsgQtCC+4kg==
Message-ID: <9538ac47c919b7756d26bdb6466cc9394efefc5e.camel@kernel.org>
Subject: Re: [RFC PATCH] ceph: try to prevent exceeding the MDS maximum
 xattr size
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>,
        =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 06:43:51 -0400
In-Reply-To: <13988024-efc7-2ab1-036a-eb1d2b2fbd15@redhat.com>
References: <20220520115426.438-1-lhenriques@suse.de>
         <13988024-efc7-2ab1-036a-eb1d2b2fbd15@redhat.com>
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

On Mon, 2022-05-23 at 09:47 +0800, Xiubo Li wrote:
> On 5/20/22 7:54 PM, Lu=EDs Henriques wrote:
> > The MDS tries to enforce a limit on the total key/values in extended
> > attributes.  However, this limit is enforced only if doing a synchronou=
s
> > operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
> > doesn't have a chance to enforce these limits.
> >=20
> > This patch forces the usage of the synchronous operation if xattrs size=
 hits
> > the maximum size that is set on the MDS by default (64k).
> >=20
> > While there, fix a dout() that would trigger a printk warning:
> >=20
> > [   98.718078] ------------[ cut here ]------------
> > [   98.719012] precision 65536 too large
> > [   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprin=
tf+0x5e3/0x600
> > ...
> >=20
> > URL: https://tracker.ceph.com/issues/55725
> > Signed-off-by: Lu=EDs Henriques <lhenriques@suse.de>
> > ---
> >   fs/ceph/xattr.c | 17 +++++++++++++----
> >   1 file changed, 13 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > index afec84088471..09751a5f028c 100644
> > --- a/fs/ceph/xattr.c
> > +++ b/fs/ceph/xattr.c
> > @@ -15,6 +15,12 @@
> >   #define XATTR_CEPH_PREFIX "ceph."
> >   #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
> >  =20
> > +/*
> > + * Maximum size of xattrs the MDS can handle per inode by default.  Th=
is
> > + * includes the attribute name and 4+4 bytes for the key/value sizes.
> > + */
> > +#define MDS_MAX_XATTR_PAIRS_SIZE (1<<16) /* 64K */
>=20
> The max size is changeable in MDS side. Possibly we should do something=
=20
> as mentioned in your ceph PR [1].
>=20
> @Jeff, any better idea ?
>=20
>=20
> [1]=20
> https://github.com/ceph/ceph/pull/46357/commits/741f8ba36f14774834c0d5618=
519425ccf1ccc85#r878966753
>=20
> Thanks.
>=20
> -- Xiubo
>=20
>=20

Not really.

The idea in the github comment makes sense. Basically, make it so that
the setting isn't changeable at runtime and then have the client query
for the limit at appropriate times.

You can probably still defeat that by changing it and rebooting the MDS,
but I don't see that you can do much else.

> > +
> >   static int __remove_xattr(struct ceph_inode_info *ci,
> >   			  struct ceph_inode_xattr *xattr);
> >  =20
> > @@ -1078,7 +1084,7 @@ static int ceph_sync_setxattr(struct inode *inode=
, const char *name,
> >   			flags |=3D CEPH_XATTR_REMOVE;
> >   	}
> >  =20
> > -	dout("setxattr value=3D%.*s\n", (int)size, value);
> > +	dout("setxattr value size: ld\n", size);
> >  =20
> >   	/* do request */
> >   	req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> > @@ -1176,8 +1182,13 @@ int __ceph_setxattr(struct inode *inode, const c=
har *name,
> >   	spin_lock(&ci->i_ceph_lock);
> >   retry:
> >   	issued =3D __ceph_caps_issued(ci, NULL);
> > -	if (ci->i_xattrs.version =3D=3D 0 || !(issued & CEPH_CAP_XATTR_EXCL))
> > +	required_blob_size =3D __get_required_blob_size(ci, name_len, val_len=
);
> > +	if ((ci->i_xattrs.version =3D=3D 0) || !(issued & CEPH_CAP_XATTR_EXCL=
) ||
> > +	    (required_blob_size >=3D MDS_MAX_XATTR_PAIRS_SIZE)) {
> > +		dout("%s do sync setxattr: version: %llu blob size: %d\n",
> > +		     __func__, ci->i_xattrs.version, required_blob_size);
> >   		goto do_sync;
> > +	}
> >  =20
> >   	if (!lock_snap_rwsem && !ci->i_head_snapc) {
> >   		lock_snap_rwsem =3D true;
> > @@ -1193,8 +1204,6 @@ int __ceph_setxattr(struct inode *inode, const ch=
ar *name,
> >   	     ceph_cap_string(issued));
> >   	__build_xattrs(inode);
> >  =20
> > -	required_blob_size =3D __get_required_blob_size(ci, name_len, val_len=
);
> > -
> >   	if (!ci->i_xattrs.prealloc_blob ||
> >   	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
> >   		struct ceph_buffer *blob;
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
