Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5002852D7D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbiESPfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbiESPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:34:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F97CEC3EF;
        Thu, 19 May 2022 08:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AE39B82568;
        Thu, 19 May 2022 15:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8935C34113;
        Thu, 19 May 2022 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652974394;
        bh=UkWTnADaSDXjOPszBLlk4uHaS7UFfFWkVlLWESKJd3g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vBYLkx/td5X4tR7Wz08yNM/UVmgB7ZXI80WbnIiuPeU24kS7pc7vpRdnvXKycB8N8
         h41PQjoLp9ZTLFdORT3cJC+/TKNWZJjJvDIGquuwFD8wLBfrVP5h/gxO2VVH8Izz0y
         ZIdKFFCeJQaklzwuzM1bb0zbMyHZWjw3wZpYTyUeVsP41JytU+DvEFb1YBN7gLAqbr
         3f2f27WLDXZ9pbPB9Hz71sdW2mTMVMDNOkmkhfuvWqPXhR20Vvhu4LYij7VgolcaVE
         T8ctpMzP3sVo7+A89lsiqdJ6VbEwFgiXPKleWUwdRexLp63jdgCz6M6dSnDDSpRul8
         4navBXXO/BWdQ==
Message-ID: <9412f05a24c8011468917d9669164d8ea181ddf4.camel@kernel.org>
Subject: Re: [PATCH] netfs: Fix gcc-12 warning by embedding vfs inode in
 netfs_i_context
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, keescook@chromium.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <smfrench@gmail.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevek@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 11:33:10 -0400
In-Reply-To: <165296786831.3591209.12111293034669289733.stgit@warthog.procyon.org.uk>
References: <165296786831.3591209.12111293034669289733.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-19 at 14:44 +0100, David Howells wrote:
> While randstruct was satisfied with using an open-coded "void *" offset
> cast for the netfs_i_context <-> inode casting, __builtin_object_size() a=
s
> used by FORTIFY_SOURCE was not as easily fooled.  This was causing the
> following complaint[1] from gcc v12:
>=20
> In file included from ./include/linux/string.h:253,
>                  from ./include/linux/ceph/ceph_debug.h:7,
>                  from fs/ceph/inode.c:2:
> In function 'fortify_memset_chk',
>     inlined from 'netfs_i_context_init' at ./include/linux/netfs.h:326:2,
>     inlined from 'ceph_alloc_inode' at fs/ceph/inode.c:463:2:
> ./include/linux/fortify-string.h:242:25: warning: call to '__write_overfl=
ow_field' declared with attribute warning:
> detected write beyond size of field (1st parameter); maybe use struct_gro=
up()? [-Wattribute-warning]
>   242 |                         __write_overflow_field(p_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>=20
> Fix this by embedding a struct inode into struct netfs_i_context (which
> should perhaps be renamed to struct netfs_inode).
>=20

Agreed. Might as well go ahead and make this change now and avoid the
churn later?

>  The struct inode
> vfs_inode fields are then removed from the 9p, afs, ceph and cifs inode
> structs and vfs_inode is then simply changed to "nic.inode" in those
> filesystems.
>=20
> Most of the changes were done with:
>=20
>   perl -p -i -e 's/vfs_inode/nic.inode/'g \
> 	`git grep -l 'vfs_inode' -- fs/{9p,afs,ceph,cifs}/*.[ch]`
>=20
> Kees suggested doing it with a pair structure[2] and a special declarator
> to insert that into the network filesystem's inode wrapper[3], but I thin=
k
> it's cleaner to embed it - and then it doesn't matter if struct
> randomisation reorders things.
>=20
> Fixes: bc899ee1c898 ("netfs: Add a netfs inode context")
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Kees Cook <keescook@chromium.org>
> cc: Jonathan Corbet <corbet@lwn.net>
> cc: Eric Van Hensbergen <ericvh@gmail.com>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Xiubo Li <xiubli@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Steve French <smfrench@gmail.com>
> cc: William Kucharski <william.kucharski@oracle.com>
> cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> cc: linux-doc@vger.kernel.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: linux-afs@lists.infradead.org
> cc: ceph-devel@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: samba-technical@lists.samba.org
> cc: linux-fsdevek@vger.kernel.org
> cc: linux-hardening@vger.kernel.org
> Link: https://lore.kernel.org/r/d2ad3a3d7bdd794c6efb562d2f2b655fb67756b9.=
camel@kernel.org/ [1]
> Link: https://lore.kernel.org/r/20220517210230.864239-1-keescook@chromium=
.org/ [2]
> Link: https://lore.kernel.org/r/20220518202212.2322058-1-keescook@chromiu=
m.org/ [3]
> ---
>=20
>  Documentation/filesystems/netfs_library.rst |   25 +++---
>  fs/9p/cache.c                               |    4 +
>  fs/9p/v9fs.c                                |    2 -
>  fs/9p/v9fs.h                                |   10 +--
>  fs/9p/vfs_addr.c                            |    2 -
>  fs/9p/vfs_inode.c                           |    2 -
>  fs/afs/callback.c                           |    2 -
>  fs/afs/dir.c                                |   32 ++++----
>  fs/afs/dir_edit.c                           |   10 +--
>  fs/afs/dir_silly.c                          |    4 +
>  fs/afs/file.c                               |    4 +
>  fs/afs/fs_operation.c                       |    6 +-
>  fs/afs/inode.c                              |   38 +++++-----
>  fs/afs/internal.h                           |   23 ++----
>  fs/afs/super.c                              |    6 +-
>  fs/afs/write.c                              |   21 +++--
>  fs/ceph/addr.c                              |    4 +
>  fs/ceph/cache.c                             |    4 +
>  fs/ceph/cache.h                             |    2 -
>  fs/ceph/caps.c                              |  104 ++++++++++++++-------=
------
>  fs/ceph/file.c                              |    2 -
>  fs/ceph/inode.c                             |   10 +--
>  fs/ceph/mds_client.c                        |    4 +
>  fs/ceph/snap.c                              |    8 +-
>  fs/ceph/super.c                             |    2 -
>  fs/ceph/super.h                             |   10 +--
>  fs/ceph/xattr.c                             |   14 ++--
>  fs/cifs/cifsfs.c                            |    8 +-
>  fs/cifs/cifsglob.h                          |   12 +--
>  fs/cifs/file.c                              |    8 +-
>  fs/cifs/fscache.c                           |    4 +
>  fs/cifs/fscache.h                           |    8 +-
>  fs/cifs/inode.c                             |    4 +
>  fs/cifs/misc.c                              |    4 +
>  fs/cifs/smb2ops.c                           |    8 +-
>  include/linux/netfs.h                       |   11 ++-
>  36 files changed, 204 insertions(+), 218 deletions(-)
>=20
> diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/=
filesystems/netfs_library.rst
> index 69f00179fdfe..5272307a0ddc 100644
> --- a/Documentation/filesystems/netfs_library.rst
> +++ b/Documentation/filesystems/netfs_library.rst
> @@ -38,29 +38,30 @@ its use on each netfs inode it is helping to manage. =
 To this end, a context
>  structure is defined::
> =20
>  	struct netfs_i_context {
> +		struct inode inode;
>  		const struct netfs_request_ops *ops;
> -		struct fscache_cookie	*cache;
> +		struct fscache_cookie *cache;
>  	};
> =20
> -A network filesystem that wants to use netfs lib must place one of these
> -directly after the VFS ``struct inode`` it allocates, usually as part of=
 its
> -own struct.  This can be done in a way similar to the following::
> +A network filesystem that wants to use netfs lib must place one of these=
 in its
> +inode wrapper struct instead of the VFS ``struct inode``.  This can be d=
one in
> +a way similar to the following::
> =20
>  	struct my_inode {
> -		struct {
> -			/* These must be contiguous */
> -			struct inode		vfs_inode;
> -			struct netfs_i_context  netfs_ctx;
> -		};
> +		struct netfs_i_context nic; /* Netfslib context and vfs inode */
>  		...
>  	};
> =20
> -This allows netfslib to find its state by simple offset from the inode p=
ointer,
> -thereby allowing the netfslib helper functions to be pointed to directly=
 by the
> -VFS/VM operation tables.
> +This allows netfslib to find its state by using ``container_of()`` from =
the
> +inode pointer, thereby allowing the netfslib helper functions to be poin=
ted to
> +directly by the VFS/VM operation tables.
> =20
>  The structure contains the following fields:
> =20
> + * ``inode``
> +
> +   The VFS inode structure.
> +
>   * ``ops``
> =20
>     The set of operations provided by the network filesystem to netfslib.
> diff --git a/fs/9p/cache.c b/fs/9p/cache.c
> index 1c8dc696d516..0f9b56ab7548 100644
> --- a/fs/9p/cache.c
> +++ b/fs/9p/cache.c
> @@ -62,12 +62,12 @@ void v9fs_cache_inode_get_cookie(struct inode *inode)
>  	version =3D cpu_to_le32(v9inode->qid.version);
>  	path =3D cpu_to_le64(v9inode->qid.path);
>  	v9ses =3D v9fs_inode2v9ses(inode);
> -	v9inode->netfs_ctx.cache =3D
> +	v9inode->nic.cache =3D
>  		fscache_acquire_cookie(v9fs_session_cache(v9ses),
>  				       0,
>  				       &path, sizeof(path),
>  				       &version, sizeof(version),
> -				       i_size_read(&v9inode->vfs_inode));
> +				       i_size_read(&v9inode->nic.inode));
> =20
>  	p9_debug(P9_DEBUG_FSC, "inode %p get cookie %p\n",
>  		 inode, v9fs_inode_cookie(v9inode));
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index e28ddf763b3b..df706c6830c6 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -625,7 +625,7 @@ static void v9fs_inode_init_once(void *foo)
>  	struct v9fs_inode *v9inode =3D (struct v9fs_inode *)foo;
> =20
>  	memset(&v9inode->qid, 0, sizeof(v9inode->qid));
> -	inode_init_once(&v9inode->vfs_inode);
> +	inode_init_once(&v9inode->nic.inode);
>  }
> =20
>  /**
> diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
> index ec0e8df3b2eb..b172e6e1a537 100644
> --- a/fs/9p/v9fs.h
> +++ b/fs/9p/v9fs.h
> @@ -109,11 +109,7 @@ struct v9fs_session_info {
>  #define V9FS_INO_INVALID_ATTR 0x01
> =20
>  struct v9fs_inode {
> -	struct {
> -		/* These must be contiguous */
> -		struct inode	vfs_inode;	/* the VFS's inode record */
> -		struct netfs_i_context netfs_ctx; /* Netfslib context */
> -	};
> +	struct netfs_i_context nic; /* Netfslib context and vfs inode */
>  	struct p9_qid qid;
>  	unsigned int cache_validity;
>  	struct p9_fid *writeback_fid;
> @@ -122,13 +118,13 @@ struct v9fs_inode {
> =20
>  static inline struct v9fs_inode *V9FS_I(const struct inode *inode)
>  {
> -	return container_of(inode, struct v9fs_inode, vfs_inode);
> +	return container_of(inode, struct v9fs_inode, nic.inode);
>  }
> =20
>  static inline struct fscache_cookie *v9fs_inode_cookie(struct v9fs_inode=
 *v9inode)
>  {
>  #ifdef CONFIG_9P_FSCACHE
> -	return netfs_i_cookie(&v9inode->vfs_inode);
> +	return netfs_i_cookie(&v9inode->nic.inode);
>  #else
>  	return NULL;
>  #endif
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 002c482794dc..191781bd77dc 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -140,7 +140,7 @@ static void v9fs_write_to_cache_done(void *priv, ssiz=
e_t transferred_or_error,
>  	    transferred_or_error !=3D -ENOBUFS) {
>  		version =3D cpu_to_le32(v9inode->qid.version);
>  		fscache_invalidate(v9fs_inode_cookie(v9inode), &version,
> -				   i_size_read(&v9inode->vfs_inode), 0);
> +				   i_size_read(&v9inode->nic.inode), 0);
>  	}
>  }
> =20
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 55367ecb9442..82c8489e86b6 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -234,7 +234,7 @@ struct inode *v9fs_alloc_inode(struct super_block *sb=
)
>  	v9inode->writeback_fid =3D NULL;
>  	v9inode->cache_validity =3D 0;
>  	mutex_init(&v9inode->v_mutex);
> -	return &v9inode->vfs_inode;
> +	return &v9inode->nic.inode;
>  }
> =20
>  /**
> diff --git a/fs/afs/callback.c b/fs/afs/callback.c
> index 1b4d5809808d..10ae6b6dad44 100644
> --- a/fs/afs/callback.c
> +++ b/fs/afs/callback.c
> @@ -30,7 +30,7 @@ void afs_invalidate_mmap_work(struct work_struct *work)
>  {
>  	struct afs_vnode *vnode =3D container_of(work, struct afs_vnode, cb_wor=
k);
> =20
> -	unmap_mapping_pages(vnode->vfs_inode.i_mapping, 0, 0, false);
> +	unmap_mapping_pages(vnode->nic.inode.i_mapping, 0, 0, false);
>  }
> =20
>  void afs_server_init_callback_work(struct work_struct *work)
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 932e61e28e5d..55455bdec230 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -109,7 +109,7 @@ struct afs_lookup_cookie {
>   */
>  static void afs_dir_read_cleanup(struct afs_read *req)
>  {
> -	struct address_space *mapping =3D req->vnode->vfs_inode.i_mapping;
> +	struct address_space *mapping =3D req->vnode->nic.inode.i_mapping;
>  	struct folio *folio;
>  	pgoff_t last =3D req->nr_pages - 1;
> =20
> @@ -153,7 +153,7 @@ static bool afs_dir_check_folio(struct afs_vnode *dvn=
ode, struct folio *folio,
>  		block =3D kmap_local_folio(folio, offset);
>  		if (block->hdr.magic !=3D AFS_DIR_MAGIC) {
>  			printk("kAFS: %s(%lx): [%llx] bad magic %zx/%zx is %04hx\n",
> -			       __func__, dvnode->vfs_inode.i_ino,
> +			       __func__, dvnode->nic.inode.i_ino,
>  			       pos, offset, size, ntohs(block->hdr.magic));
>  			trace_afs_dir_check_failed(dvnode, pos + offset, i_size);
>  			kunmap_local(block);
> @@ -183,7 +183,7 @@ static bool afs_dir_check_folio(struct afs_vnode *dvn=
ode, struct folio *folio,
>  static void afs_dir_dump(struct afs_vnode *dvnode, struct afs_read *req)
>  {
>  	union afs_xdr_dir_block *block;
> -	struct address_space *mapping =3D dvnode->vfs_inode.i_mapping;
> +	struct address_space *mapping =3D dvnode->nic.inode.i_mapping;
>  	struct folio *folio;
>  	pgoff_t last =3D req->nr_pages - 1;
>  	size_t offset, size;
> @@ -217,7 +217,7 @@ static void afs_dir_dump(struct afs_vnode *dvnode, st=
ruct afs_read *req)
>   */
>  static int afs_dir_check(struct afs_vnode *dvnode, struct afs_read *req)
>  {
> -	struct address_space *mapping =3D dvnode->vfs_inode.i_mapping;
> +	struct address_space *mapping =3D dvnode->nic.inode.i_mapping;
>  	struct folio *folio;
>  	pgoff_t last =3D req->nr_pages - 1;
>  	int ret =3D 0;
> @@ -269,7 +269,7 @@ static int afs_dir_open(struct inode *inode, struct f=
ile *file)
>  static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct ke=
y *key)
>  	__acquires(&dvnode->validate_lock)
>  {
> -	struct address_space *mapping =3D dvnode->vfs_inode.i_mapping;
> +	struct address_space *mapping =3D dvnode->nic.inode.i_mapping;
>  	struct afs_read *req;
>  	loff_t i_size;
>  	int nr_pages, i;
> @@ -287,7 +287,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode=
 *dvnode, struct key *key)
>  	req->cleanup =3D afs_dir_read_cleanup;
> =20
>  expand:
> -	i_size =3D i_size_read(&dvnode->vfs_inode);
> +	i_size =3D i_size_read(&dvnode->nic.inode);
>  	if (i_size < 2048) {
>  		ret =3D afs_bad(dvnode, afs_file_error_dir_small);
>  		goto error;
> @@ -305,7 +305,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode=
 *dvnode, struct key *key)
>  	req->actual_len =3D i_size; /* May change */
>  	req->len =3D nr_pages * PAGE_SIZE; /* We can ask for more than there is=
 */
>  	req->data_version =3D dvnode->status.data_version; /* May change */
> -	iov_iter_xarray(&req->def_iter, READ, &dvnode->vfs_inode.i_mapping->i_p=
ages,
> +	iov_iter_xarray(&req->def_iter, READ, &dvnode->nic.inode.i_mapping->i_p=
ages,
>  			0, i_size);
>  	req->iter =3D &req->def_iter;
> =20
> @@ -894,7 +894,7 @@ static struct inode *afs_do_lookup(struct inode *dir,=
 struct dentry *dentry,
> =20
>  out_op:
>  	if (op->error =3D=3D 0) {
> -		inode =3D &op->file[1].vnode->vfs_inode;
> +		inode =3D &op->file[1].vnode->nic.inode;
>  		op->file[1].vnode =3D NULL;
>  	}
> =20
> @@ -1136,7 +1136,7 @@ static int afs_d_revalidate(struct dentry *dentry, =
unsigned int flags)
>  	afs_stat_v(dir, n_reval);
> =20
>  	/* search the directory for this vnode */
> -	ret =3D afs_do_lookup_one(&dir->vfs_inode, dentry, &fid, key, &dir_vers=
ion);
> +	ret =3D afs_do_lookup_one(&dir->nic.inode, dentry, &fid, key, &dir_vers=
ion);
>  	switch (ret) {
>  	case 0:
>  		/* the filename maps to something */
> @@ -1167,7 +1167,7 @@ static int afs_d_revalidate(struct dentry *dentry, =
unsigned int flags)
>  			_debug("%pd: file deleted (uq %u -> %u I:%u)",
>  			       dentry, fid.unique,
>  			       vnode->fid.unique,
> -			       vnode->vfs_inode.i_generation);
> +			       vnode->nic.inode.i_generation);
>  			goto not_found;
>  		}
>  		goto out_valid;
> @@ -1365,7 +1365,7 @@ static void afs_dir_remove_subdir(struct dentry *de=
ntry)
>  	if (d_really_is_positive(dentry)) {
>  		struct afs_vnode *vnode =3D AFS_FS_I(d_inode(dentry));
> =20
> -		clear_nlink(&vnode->vfs_inode);
> +		clear_nlink(&vnode->nic.inode);
>  		set_bit(AFS_VNODE_DELETED, &vnode->flags);
>  		clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
>  		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
> @@ -1484,8 +1484,8 @@ static void afs_dir_remove_link(struct afs_operatio=
n *op)
>  		/* Already done */
>  	} else if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
>  		write_seqlock(&vnode->cb_lock);
> -		drop_nlink(&vnode->vfs_inode);
> -		if (vnode->vfs_inode.i_nlink =3D=3D 0) {
> +		drop_nlink(&vnode->nic.inode);
> +		if (vnode->nic.inode.i_nlink =3D=3D 0) {
>  			set_bit(AFS_VNODE_DELETED, &vnode->flags);
>  			__afs_break_callback(vnode, afs_cb_break_for_unlink);
>  		}
> @@ -1501,7 +1501,7 @@ static void afs_dir_remove_link(struct afs_operatio=
n *op)
>  			op->error =3D ret;
>  	}
> =20
> -	_debug("nlink %d [val %d]", vnode->vfs_inode.i_nlink, op->error);
> +	_debug("nlink %d [val %d]", vnode->nic.inode.i_nlink, op->error);
>  }
> =20
>  static void afs_unlink_success(struct afs_operation *op)
> @@ -1677,8 +1677,8 @@ static void afs_link_success(struct afs_operation *=
op)
>  	afs_update_dentry_version(op, dvp, op->dentry);
>  	if (op->dentry_2->d_parent =3D=3D op->dentry->d_parent)
>  		afs_update_dentry_version(op, dvp, op->dentry_2);
> -	ihold(&vp->vnode->vfs_inode);
> -	d_instantiate(op->dentry, &vp->vnode->vfs_inode);
> +	ihold(&vp->vnode->nic.inode);
> +	d_instantiate(op->dentry, &vp->vnode->nic.inode);
>  }
> =20
>  static void afs_link_put(struct afs_operation *op)
> diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
> index d98e109ecee9..dc29c93d76d3 100644
> --- a/fs/afs/dir_edit.c
> +++ b/fs/afs/dir_edit.c
> @@ -109,7 +109,7 @@ static void afs_clear_contig_bits(union afs_xdr_dir_b=
lock *block,
>   */
>  static struct folio *afs_dir_get_folio(struct afs_vnode *vnode, pgoff_t =
index)
>  {
> -	struct address_space *mapping =3D vnode->vfs_inode.i_mapping;
> +	struct address_space *mapping =3D vnode->nic.inode.i_mapping;
>  	struct folio *folio;
> =20
>  	folio =3D __filemap_get_folio(mapping, index,
> @@ -216,7 +216,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
> =20
>  	_enter(",,{%d,%s},", name->len, name->name);
> =20
> -	i_size =3D i_size_read(&vnode->vfs_inode);
> +	i_size =3D i_size_read(&vnode->nic.inode);
>  	if (i_size > AFS_DIR_BLOCK_SIZE * AFS_DIR_MAX_BLOCKS ||
>  	    (i_size & (AFS_DIR_BLOCK_SIZE - 1))) {
>  		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
> @@ -336,7 +336,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
>  	if (b < AFS_DIR_BLOCKS_WITH_CTR)
>  		meta->meta.alloc_ctrs[b] -=3D need_slots;
> =20
> -	inode_inc_iversion_raw(&vnode->vfs_inode);
> +	inode_inc_iversion_raw(&vnode->nic.inode);
>  	afs_stat_v(vnode, n_dir_cr);
>  	_debug("Insert %s in %u[%u]", name->name, b, slot);
> =20
> @@ -383,7 +383,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
> =20
>  	_enter(",,{%d,%s},", name->len, name->name);
> =20
> -	i_size =3D i_size_read(&vnode->vfs_inode);
> +	i_size =3D i_size_read(&vnode->nic.inode);
>  	if (i_size < AFS_DIR_BLOCK_SIZE ||
>  	    i_size > AFS_DIR_BLOCK_SIZE * AFS_DIR_MAX_BLOCKS ||
>  	    (i_size & (AFS_DIR_BLOCK_SIZE - 1))) {
> @@ -463,7 +463,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
>  	if (b < AFS_DIR_BLOCKS_WITH_CTR)
>  		meta->meta.alloc_ctrs[b] +=3D need_slots;
> =20
> -	inode_set_iversion_raw(&vnode->vfs_inode, vnode->status.data_version);
> +	inode_set_iversion_raw(&vnode->nic.inode, vnode->status.data_version);
>  	afs_stat_v(vnode, n_dir_rm);
>  	_debug("Remove %s from %u[%u]", name->name, b, slot);
> =20
> diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
> index 45cfd50a9521..42effe187ca1 100644
> --- a/fs/afs/dir_silly.c
> +++ b/fs/afs/dir_silly.c
> @@ -131,7 +131,7 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct =
afs_vnode *vnode,
>  			goto out;
>  	} while (!d_is_negative(sdentry));
> =20
> -	ihold(&vnode->vfs_inode);
> +	ihold(&vnode->nic.inode);
> =20
>  	ret =3D afs_do_silly_rename(dvnode, vnode, dentry, sdentry, key);
>  	switch (ret) {
> @@ -148,7 +148,7 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct =
afs_vnode *vnode,
>  		d_drop(sdentry);
>  	}
> =20
> -	iput(&vnode->vfs_inode);
> +	iput(&vnode->nic.inode);
>  	dput(sdentry);
>  out:
>  	_leave(" =3D %d", ret);
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index b9ca72fbbcf9..23e4d981ddfa 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -194,7 +194,7 @@ int afs_release(struct inode *inode, struct file *fil=
e)
>  		afs_put_wb_key(af->wb);
> =20
>  	if ((file->f_mode & FMODE_WRITE)) {
> -		i_size =3D i_size_read(&vnode->vfs_inode);
> +		i_size =3D i_size_read(&vnode->nic.inode);
>  		afs_set_cache_aux(vnode, &aux);
>  		fscache_unuse_cookie(afs_vnode_cache(vnode), &aux, &i_size);
>  	} else {
> @@ -325,7 +325,7 @@ static void afs_issue_read(struct netfs_io_subrequest=
 *subreq)
>  	fsreq->iter	=3D &fsreq->def_iter;
> =20
>  	iov_iter_xarray(&fsreq->def_iter, READ,
> -			&fsreq->vnode->vfs_inode.i_mapping->i_pages,
> +			&fsreq->vnode->nic.inode.i_mapping->i_pages,
>  			fsreq->pos, fsreq->len);
> =20
>  	afs_fetch_data(fsreq->vnode, fsreq);
> diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
> index d222dfbe976b..bf60381485f1 100644
> --- a/fs/afs/fs_operation.c
> +++ b/fs/afs/fs_operation.c
> @@ -232,14 +232,14 @@ int afs_put_operation(struct afs_operation *op)
>  	if (op->file[1].modification && op->file[1].vnode !=3D op->file[0].vnod=
e)
>  		clear_bit(AFS_VNODE_MODIFYING, &op->file[1].vnode->flags);
>  	if (op->file[0].put_vnode)
> -		iput(&op->file[0].vnode->vfs_inode);
> +		iput(&op->file[0].vnode->nic.inode);
>  	if (op->file[1].put_vnode)
> -		iput(&op->file[1].vnode->vfs_inode);
> +		iput(&op->file[1].vnode->nic.inode);
> =20
>  	if (op->more_files) {
>  		for (i =3D 0; i < op->nr_files - 2; i++)
>  			if (op->more_files[i].put_vnode)
> -				iput(&op->more_files[i].vnode->vfs_inode);
> +				iput(&op->more_files[i].vnode->nic.inode);
>  		kfree(op->more_files);
>  	}
> =20
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 2fe402483ad5..7827ef333194 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -58,7 +58,7 @@ static noinline void dump_vnode(struct afs_vnode *vnode=
, struct afs_vnode *paren
>   */
>  static void afs_set_netfs_context(struct afs_vnode *vnode)
>  {
> -	netfs_i_context_init(&vnode->vfs_inode, &afs_req_ops);
> +	netfs_i_context_init(&vnode->nic.inode, &afs_req_ops);
>  }
> =20
>  /*
> @@ -96,7 +96,7 @@ static int afs_inode_init_from_status(struct afs_operat=
ion *op,
>  	inode->i_flags |=3D S_NOATIME;
>  	inode->i_uid =3D make_kuid(&init_user_ns, status->owner);
>  	inode->i_gid =3D make_kgid(&init_user_ns, status->group);
> -	set_nlink(&vnode->vfs_inode, status->nlink);
> +	set_nlink(&vnode->nic.inode, status->nlink);
> =20
>  	switch (status->type) {
>  	case AFS_FTYPE_FILE:
> @@ -139,7 +139,7 @@ static int afs_inode_init_from_status(struct afs_oper=
ation *op,
>  	afs_set_netfs_context(vnode);
> =20
>  	vnode->invalid_before	=3D status->data_version;
> -	inode_set_iversion_raw(&vnode->vfs_inode, status->data_version);
> +	inode_set_iversion_raw(&vnode->nic.inode, status->data_version);
> =20
>  	if (!vp->scb.have_cb) {
>  		/* it's a symlink we just created (the fileserver
> @@ -163,7 +163,7 @@ static void afs_apply_status(struct afs_operation *op=
,
>  {
>  	struct afs_file_status *status =3D &vp->scb.status;
>  	struct afs_vnode *vnode =3D vp->vnode;
> -	struct inode *inode =3D &vnode->vfs_inode;
> +	struct inode *inode =3D &vnode->nic.inode;
>  	struct timespec64 t;
>  	umode_t mode;
>  	bool data_changed =3D false;
> @@ -246,7 +246,7 @@ static void afs_apply_status(struct afs_operation *op=
,
>  		 * idea of what the size should be that's not the same as
>  		 * what's on the server.
>  		 */
> -		vnode->netfs_ctx.remote_i_size =3D status->size;
> +		vnode->nic.remote_i_size =3D status->size;
>  		if (change_size) {
>  			afs_set_i_size(vnode, status->size);
>  			inode->i_ctime =3D t;
> @@ -289,7 +289,7 @@ void afs_vnode_commit_status(struct afs_operation *op=
, struct afs_vnode_param *v
>  		 */
>  		if (vp->scb.status.abort_code =3D=3D VNOVNODE) {
>  			set_bit(AFS_VNODE_DELETED, &vnode->flags);
> -			clear_nlink(&vnode->vfs_inode);
> +			clear_nlink(&vnode->nic.inode);
>  			__afs_break_callback(vnode, afs_cb_break_for_deleted);
>  			op->flags &=3D ~AFS_OPERATION_DIR_CONFLICT;
>  		}
> @@ -306,8 +306,8 @@ void afs_vnode_commit_status(struct afs_operation *op=
, struct afs_vnode_param *v
>  		if (vp->scb.have_cb)
>  			afs_apply_callback(op, vp);
>  	} else if (vp->op_unlinked && !(op->flags & AFS_OPERATION_DIR_CONFLICT)=
) {
> -		drop_nlink(&vnode->vfs_inode);
> -		if (vnode->vfs_inode.i_nlink =3D=3D 0) {
> +		drop_nlink(&vnode->nic.inode);
> +		if (vnode->nic.inode.i_nlink =3D=3D 0) {
>  			set_bit(AFS_VNODE_DELETED, &vnode->flags);
>  			__afs_break_callback(vnode, afs_cb_break_for_deleted);
>  		}
> @@ -326,7 +326,7 @@ static void afs_fetch_status_success(struct afs_opera=
tion *op)
>  	struct afs_vnode *vnode =3D vp->vnode;
>  	int ret;
> =20
> -	if (vnode->vfs_inode.i_state & I_NEW) {
> +	if (vnode->nic.inode.i_state & I_NEW) {
>  		ret =3D afs_inode_init_from_status(op, vp, vnode);
>  		op->error =3D ret;
>  		if (ret =3D=3D 0)
> @@ -430,7 +430,7 @@ static void afs_get_inode_cache(struct afs_vnode *vno=
de)
>  	struct afs_vnode_cache_aux aux;
> =20
>  	if (vnode->status.type !=3D AFS_FTYPE_FILE) {
> -		vnode->netfs_ctx.cache =3D NULL;
> +		vnode->nic.cache =3D NULL;
>  		return;
>  	}
> =20
> @@ -457,7 +457,7 @@ static void afs_get_inode_cache(struct afs_vnode *vno=
de)
>  struct inode *afs_iget(struct afs_operation *op, struct afs_vnode_param =
*vp)
>  {
>  	struct afs_vnode_param *dvp =3D &op->file[0];
> -	struct super_block *sb =3D dvp->vnode->vfs_inode.i_sb;
> +	struct super_block *sb =3D dvp->vnode->nic.inode.i_sb;
>  	struct afs_vnode *vnode;
>  	struct inode *inode;
>  	int ret;
> @@ -582,10 +582,10 @@ static void afs_zap_data(struct afs_vnode *vnode)
>  	/* nuke all the non-dirty pages that aren't locked, mapped or being
>  	 * written back in a regular file and completely discard the pages in a
>  	 * directory or symlink */
> -	if (S_ISREG(vnode->vfs_inode.i_mode))
> -		invalidate_remote_inode(&vnode->vfs_inode);
> +	if (S_ISREG(vnode->nic.inode.i_mode))
> +		invalidate_remote_inode(&vnode->nic.inode);
>  	else
> -		invalidate_inode_pages2(vnode->vfs_inode.i_mapping);
> +		invalidate_inode_pages2(vnode->nic.inode.i_mapping);
>  }
> =20
>  /*
> @@ -683,8 +683,8 @@ int afs_validate(struct afs_vnode *vnode, struct key =
*key)
>  	       key_serial(key));
> =20
>  	if (unlikely(test_bit(AFS_VNODE_DELETED, &vnode->flags))) {
> -		if (vnode->vfs_inode.i_nlink)
> -			clear_nlink(&vnode->vfs_inode);
> +		if (vnode->nic.inode.i_nlink)
> +			clear_nlink(&vnode->nic.inode);
>  		goto valid;
>  	}
> =20
> @@ -814,7 +814,7 @@ void afs_evict_inode(struct inode *inode)
>  static void afs_setattr_success(struct afs_operation *op)
>  {
>  	struct afs_vnode_param *vp =3D &op->file[0];
> -	struct inode *inode =3D &vp->vnode->vfs_inode;
> +	struct inode *inode =3D &vp->vnode->nic.inode;
>  	loff_t old_i_size =3D i_size_read(inode);
> =20
>  	op->setattr.old_i_size =3D old_i_size;
> @@ -831,7 +831,7 @@ static void afs_setattr_success(struct afs_operation =
*op)
>  static void afs_setattr_edit_file(struct afs_operation *op)
>  {
>  	struct afs_vnode_param *vp =3D &op->file[0];
> -	struct inode *inode =3D &vp->vnode->vfs_inode;
> +	struct inode *inode =3D &vp->vnode->nic.inode;
> =20
>  	if (op->setattr.attr->ia_valid & ATTR_SIZE) {
>  		loff_t size =3D op->setattr.attr->ia_size;
> @@ -863,7 +863,7 @@ int afs_setattr(struct user_namespace *mnt_userns, st=
ruct dentry *dentry,
>  		ATTR_MTIME | ATTR_MTIME_SET | ATTR_TIMES_SET | ATTR_TOUCH;
>  	struct afs_operation *op;
>  	struct afs_vnode *vnode =3D AFS_FS_I(d_inode(dentry));
> -	struct inode *inode =3D &vnode->vfs_inode;
> +	struct inode *inode =3D &vnode->nic.inode;
>  	loff_t i_size;
>  	int ret;
> =20
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 7b7ef945dc78..f9d513bbd95d 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -619,12 +619,7 @@ enum afs_lock_state {
>   * leak from one inode to another.
>   */
>  struct afs_vnode {
> -	struct {
> -		/* These must be contiguous */
> -		struct inode	vfs_inode;	/* the VFS's inode record */
> -		struct netfs_i_context netfs_ctx; /* Netfslib context */
> -	};
> -
> +	struct netfs_i_context	nic;		/* Netfslib context and vfs inode */
>  	struct afs_volume	*volume;	/* volume on which vnode resides */
>  	struct afs_fid		fid;		/* the file identifier for this inode */
>  	struct afs_file_status	status;		/* AFS status info for this file */
> @@ -675,7 +670,7 @@ struct afs_vnode {
>  static inline struct fscache_cookie *afs_vnode_cache(struct afs_vnode *v=
node)
>  {
>  #ifdef CONFIG_AFS_FSCACHE
> -	return netfs_i_cookie(&vnode->vfs_inode);
> +	return netfs_i_cookie(&vnode->nic.inode);
>  #else
>  	return NULL;
>  #endif
> @@ -685,7 +680,7 @@ static inline void afs_vnode_set_cache(struct afs_vno=
de *vnode,
>  				       struct fscache_cookie *cookie)
>  {
>  #ifdef CONFIG_AFS_FSCACHE
> -	vnode->netfs_ctx.cache =3D cookie;
> +	vnode->nic.cache =3D cookie;
>  #endif
>  }
> =20
> @@ -892,7 +887,7 @@ static inline void afs_invalidate_cache(struct afs_vn=
ode *vnode, unsigned int fl
> =20
>  	afs_set_cache_aux(vnode, &aux);
>  	fscache_invalidate(afs_vnode_cache(vnode), &aux,
> -			   i_size_read(&vnode->vfs_inode), flags);
> +			   i_size_read(&vnode->nic.inode), flags);
>  }
> =20
>  /*
> @@ -1217,7 +1212,7 @@ static inline struct afs_net *afs_i2net(struct inod=
e *inode)
> =20
>  static inline struct afs_net *afs_v2net(struct afs_vnode *vnode)
>  {
> -	return afs_i2net(&vnode->vfs_inode);
> +	return afs_i2net(&vnode->nic.inode);
>  }
> =20
>  static inline struct afs_net *afs_sock2net(struct sock *sk)
> @@ -1593,12 +1588,12 @@ extern void yfs_fs_store_opaque_acl2(struct afs_o=
peration *);
>   */
>  static inline struct afs_vnode *AFS_FS_I(struct inode *inode)
>  {
> -	return container_of(inode, struct afs_vnode, vfs_inode);
> +	return container_of(inode, struct afs_vnode, nic.inode);
>  }
> =20
>  static inline struct inode *AFS_VNODE_TO_I(struct afs_vnode *vnode)
>  {
> -	return &vnode->vfs_inode;
> +	return &vnode->nic.inode;
>  }
> =20
>  /*
> @@ -1621,8 +1616,8 @@ static inline void afs_update_dentry_version(struct=
 afs_operation *op,
>   */
>  static inline void afs_set_i_size(struct afs_vnode *vnode, u64 size)
>  {
> -	i_size_write(&vnode->vfs_inode, size);
> -	vnode->vfs_inode.i_blocks =3D ((size + 1023) >> 10) << 1;
> +	i_size_write(&vnode->nic.inode, size);
> +	vnode->nic.inode.i_blocks =3D ((size + 1023) >> 10) << 1;
>  }
> =20
>  /*
> diff --git a/fs/afs/super.c b/fs/afs/super.c
> index 1fea195b0b27..1c5ddd80860a 100644
> --- a/fs/afs/super.c
> +++ b/fs/afs/super.c
> @@ -659,7 +659,7 @@ static void afs_i_init_once(void *_vnode)
>  	struct afs_vnode *vnode =3D _vnode;
> =20
>  	memset(vnode, 0, sizeof(*vnode));
> -	inode_init_once(&vnode->vfs_inode);
> +	inode_init_once(&vnode->nic.inode);
>  	mutex_init(&vnode->io_lock);
>  	init_rwsem(&vnode->validate_lock);
>  	spin_lock_init(&vnode->wb_lock);
> @@ -700,8 +700,8 @@ static struct inode *afs_alloc_inode(struct super_blo=
ck *sb)
>  	init_rwsem(&vnode->rmdir_lock);
>  	INIT_WORK(&vnode->cb_work, afs_invalidate_mmap_work);
> =20
> -	_leave(" =3D %p", &vnode->vfs_inode);
> -	return &vnode->vfs_inode;
> +	_leave(" =3D %p", &vnode->nic.inode);
> +	return &vnode->nic.inode;
>  }
> =20
>  static void afs_free_inode(struct inode *inode)
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 4763132ca57e..1ad10e393c3a 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -146,10 +146,10 @@ int afs_write_end(struct file *file, struct address=
_space *mapping,
> =20
>  	write_end_pos =3D pos + copied;
> =20
> -	i_size =3D i_size_read(&vnode->vfs_inode);
> +	i_size =3D i_size_read(&vnode->nic.inode);
>  	if (write_end_pos > i_size) {
>  		write_seqlock(&vnode->cb_lock);
> -		i_size =3D i_size_read(&vnode->vfs_inode);
> +		i_size =3D i_size_read(&vnode->nic.inode);
>  		if (write_end_pos > i_size)
>  			afs_set_i_size(vnode, write_end_pos);
>  		write_sequnlock(&vnode->cb_lock);
> @@ -257,7 +257,7 @@ static void afs_redirty_pages(struct writeback_contro=
l *wbc,
>   */
>  static void afs_pages_written_back(struct afs_vnode *vnode, loff_t start=
, unsigned int len)
>  {
> -	struct address_space *mapping =3D vnode->vfs_inode.i_mapping;
> +	struct address_space *mapping =3D vnode->nic.inode.i_mapping;
>  	struct folio *folio;
>  	pgoff_t end;
> =20
> @@ -354,7 +354,6 @@ static const struct afs_operation_ops afs_store_data_=
operation =3D {
>  static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter=
, loff_t pos,
>  			  bool laundering)
>  {
> -	struct netfs_i_context *ictx =3D &vnode->netfs_ctx;
>  	struct afs_operation *op;
>  	struct afs_wb_key *wbk =3D NULL;
>  	loff_t size =3D iov_iter_count(iter);
> @@ -385,9 +384,9 @@ static int afs_store_data(struct afs_vnode *vnode, st=
ruct iov_iter *iter, loff_t
>  	op->store.write_iter =3D iter;
>  	op->store.pos =3D pos;
>  	op->store.size =3D size;
> -	op->store.i_size =3D max(pos + size, ictx->remote_i_size);
> +	op->store.i_size =3D max(pos + size, vnode->nic.remote_i_size);
>  	op->store.laundering =3D laundering;
> -	op->mtime =3D vnode->vfs_inode.i_mtime;
> +	op->mtime =3D vnode->nic.inode.i_mtime;
>  	op->flags |=3D AFS_OPERATION_UNINTR;
>  	op->ops =3D &afs_store_data_operation;
> =20
> @@ -554,7 +553,7 @@ static ssize_t afs_write_back_from_locked_folio(struc=
t address_space *mapping,
>  	struct iov_iter iter;
>  	unsigned long priv;
>  	unsigned int offset, to, len, max_len;
> -	loff_t i_size =3D i_size_read(&vnode->vfs_inode);
> +	loff_t i_size =3D i_size_read(&vnode->nic.inode);
>  	bool new_content =3D test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
>  	bool caching =3D fscache_cookie_enabled(afs_vnode_cache(vnode));
>  	long count =3D wbc->nr_to_write;
> @@ -844,7 +843,7 @@ ssize_t afs_file_write(struct kiocb *iocb, struct iov=
_iter *from)
>  	_enter("{%llx:%llu},{%zu},",
>  	       vnode->fid.vid, vnode->fid.vnode, count);
> =20
> -	if (IS_SWAPFILE(&vnode->vfs_inode)) {
> +	if (IS_SWAPFILE(&vnode->nic.inode)) {
>  		printk(KERN_INFO
>  		       "AFS: Attempt to write to active swap file!\n");
>  		return -EBUSY;
> @@ -957,8 +956,8 @@ void afs_prune_wb_keys(struct afs_vnode *vnode)
>  	/* Discard unused keys */
>  	spin_lock(&vnode->wb_lock);
> =20
> -	if (!mapping_tagged(&vnode->vfs_inode.i_data, PAGECACHE_TAG_WRITEBACK) =
&&
> -	    !mapping_tagged(&vnode->vfs_inode.i_data, PAGECACHE_TAG_DIRTY)) {
> +	if (!mapping_tagged(&vnode->nic.inode.i_data, PAGECACHE_TAG_WRITEBACK) =
&&
> +	    !mapping_tagged(&vnode->nic.inode.i_data, PAGECACHE_TAG_DIRTY)) {
>  		list_for_each_entry_safe(wbk, tmp, &vnode->wb_keys, vnode_link) {
>  			if (refcount_read(&wbk->usage) =3D=3D 1)
>  				list_move(&wbk->vnode_link, &graveyard);
> @@ -1033,6 +1032,6 @@ static void afs_write_to_cache(struct afs_vnode *vn=
ode,
>  			       bool caching)
>  {
>  	fscache_write_to_cache(afs_vnode_cache(vnode),
> -			       vnode->vfs_inode.i_mapping, start, len, i_size,
> +			       vnode->nic.inode.i_mapping, start, len, i_size,
>  			       afs_write_to_cache_done, vnode, caching);
>  }
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index ee8c1b099c4f..7cd5a4487eb1 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1789,7 +1789,7 @@ enum {
>  static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
>  				s64 pool, struct ceph_string *pool_ns)
>  {
> -	struct ceph_fs_client *fsc =3D ceph_inode_to_client(&ci->vfs_inode);
> +	struct ceph_fs_client *fsc =3D ceph_inode_to_client(&ci->nic.inode);
>  	struct ceph_mds_client *mdsc =3D fsc->mdsc;
>  	struct ceph_osd_request *rd_req =3D NULL, *wr_req =3D NULL;
>  	struct rb_node **p, *parent;
> @@ -1904,7 +1904,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_i=
nfo *ci,
>  				     0, false, true);
>  	err =3D ceph_osdc_start_request(&fsc->client->osdc, rd_req, false);
> =20
> -	wr_req->r_mtime =3D ci->vfs_inode.i_mtime;
> +	wr_req->r_mtime =3D ci->nic.inode.i_mtime;
>  	err2 =3D ceph_osdc_start_request(&fsc->client->osdc, wr_req, false);
> =20
>  	if (!err)
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index ddea99922073..d983513ffc7f 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -29,9 +29,9 @@ void ceph_fscache_register_inode_cookie(struct inode *i=
node)
>  	if (!(inode->i_state & I_NEW))
>  		return;
> =20
> -	WARN_ON_ONCE(ci->netfs_ctx.cache);
> +	WARN_ON_ONCE(ci->nic.cache);
> =20
> -	ci->netfs_ctx.cache =3D
> +	ci->nic.cache =3D
>  		fscache_acquire_cookie(fsc->fscache, 0,
>  				       &ci->i_vino, sizeof(ci->i_vino),
>  				       &ci->i_version, sizeof(ci->i_version),
> diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
> index 7255b790a4c1..cd74390983ad 100644
> --- a/fs/ceph/cache.h
> +++ b/fs/ceph/cache.h
> @@ -28,7 +28,7 @@ void ceph_fscache_invalidate(struct inode *inode, bool =
dio_write);
> =20
>  static inline struct fscache_cookie *ceph_fscache_cookie(struct ceph_ino=
de_info *ci)
>  {
> -	return netfs_i_cookie(&ci->vfs_inode);
> +	return netfs_i_cookie(&ci->nic.inode);
>  }
> =20
>  static inline void ceph_fscache_resize(struct inode *inode, loff_t to)
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 5c14ef04e474..1ab952b8fa69 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -492,7 +492,7 @@ static void __cap_set_timeouts(struct ceph_mds_client=
 *mdsc,
>  	struct ceph_mount_options *opt =3D mdsc->fsc->mount_options;
>  	ci->i_hold_caps_max =3D round_jiffies(jiffies +
>  					    opt->caps_wanted_delay_max * HZ);
> -	dout("__cap_set_timeouts %p %lu\n", &ci->vfs_inode,
> +	dout("__cap_set_timeouts %p %lu\n", &ci->nic.inode,
>  	     ci->i_hold_caps_max - jiffies);
>  }
> =20
> @@ -507,7 +507,7 @@ static void __cap_set_timeouts(struct ceph_mds_client=
 *mdsc,
>  static void __cap_delay_requeue(struct ceph_mds_client *mdsc,
>  				struct ceph_inode_info *ci)
>  {
> -	dout("__cap_delay_requeue %p flags 0x%lx at %lu\n", &ci->vfs_inode,
> +	dout("__cap_delay_requeue %p flags 0x%lx at %lu\n", &ci->nic.inode,
>  	     ci->i_ceph_flags, ci->i_hold_caps_max);
>  	if (!mdsc->stopping) {
>  		spin_lock(&mdsc->cap_delay_lock);
> @@ -531,7 +531,7 @@ static void __cap_delay_requeue(struct ceph_mds_clien=
t *mdsc,
>  static void __cap_delay_requeue_front(struct ceph_mds_client *mdsc,
>  				      struct ceph_inode_info *ci)
>  {
> -	dout("__cap_delay_requeue_front %p\n", &ci->vfs_inode);
> +	dout("__cap_delay_requeue_front %p\n", &ci->nic.inode);
>  	spin_lock(&mdsc->cap_delay_lock);
>  	ci->i_ceph_flags |=3D CEPH_I_FLUSH;
>  	if (!list_empty(&ci->i_cap_delay_list))
> @@ -548,7 +548,7 @@ static void __cap_delay_requeue_front(struct ceph_mds=
_client *mdsc,
>  static void __cap_delay_cancel(struct ceph_mds_client *mdsc,
>  			       struct ceph_inode_info *ci)
>  {
> -	dout("__cap_delay_cancel %p\n", &ci->vfs_inode);
> +	dout("__cap_delay_cancel %p\n", &ci->nic.inode);
>  	if (list_empty(&ci->i_cap_delay_list))
>  		return;
>  	spin_lock(&mdsc->cap_delay_lock);
> @@ -568,7 +568,7 @@ static void __check_cap_issue(struct ceph_inode_info =
*ci, struct ceph_cap *cap,
>  	 * Each time we receive FILE_CACHE anew, we increment
>  	 * i_rdcache_gen.
>  	 */
> -	if (S_ISREG(ci->vfs_inode.i_mode) &&
> +	if (S_ISREG(ci->nic.inode.i_mode) &&
>  	    (issued & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) &&
>  	    (had & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) =3D=3D 0) {
>  		ci->i_rdcache_gen++;
> @@ -583,14 +583,14 @@ static void __check_cap_issue(struct ceph_inode_inf=
o *ci, struct ceph_cap *cap,
>  	if ((issued & CEPH_CAP_FILE_SHARED) !=3D (had & CEPH_CAP_FILE_SHARED)) =
{
>  		if (issued & CEPH_CAP_FILE_SHARED)
>  			atomic_inc(&ci->i_shared_gen);
> -		if (S_ISDIR(ci->vfs_inode.i_mode)) {
> -			dout(" marking %p NOT complete\n", &ci->vfs_inode);
> +		if (S_ISDIR(ci->nic.inode.i_mode)) {
> +			dout(" marking %p NOT complete\n", &ci->nic.inode);
>  			__ceph_dir_clear_complete(ci);
>  		}
>  	}
> =20
>  	/* Wipe saved layout if we're losing DIR_CREATE caps */
> -	if (S_ISDIR(ci->vfs_inode.i_mode) && (had & CEPH_CAP_DIR_CREATE) &&
> +	if (S_ISDIR(ci->nic.inode.i_mode) && (had & CEPH_CAP_DIR_CREATE) &&
>  		!(issued & CEPH_CAP_DIR_CREATE)) {
>  	     ceph_put_string(rcu_dereference_raw(ci->i_cached_layout.pool_ns));
>  	     memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
> @@ -771,7 +771,7 @@ static int __cap_is_valid(struct ceph_cap *cap)
> =20
>  	if (cap->cap_gen < gen || time_after_eq(jiffies, ttl)) {
>  		dout("__cap_is_valid %p cap %p issued %s "
> -		     "but STALE (gen %u vs %u)\n", &cap->ci->vfs_inode,
> +		     "but STALE (gen %u vs %u)\n", &cap->ci->nic.inode,
>  		     cap, ceph_cap_string(cap->issued), cap->cap_gen, gen);
>  		return 0;
>  	}
> @@ -797,7 +797,7 @@ int __ceph_caps_issued(struct ceph_inode_info *ci, in=
t *implemented)
>  		if (!__cap_is_valid(cap))
>  			continue;
>  		dout("__ceph_caps_issued %p cap %p issued %s\n",
> -		     &ci->vfs_inode, cap, ceph_cap_string(cap->issued));
> +		     &ci->nic.inode, cap, ceph_cap_string(cap->issued));
>  		have |=3D cap->issued;
>  		if (implemented)
>  			*implemented |=3D cap->implemented;
> @@ -844,12 +844,12 @@ static void __touch_cap(struct ceph_cap *cap)
> =20
>  	spin_lock(&s->s_cap_lock);
>  	if (!s->s_cap_iterator) {
> -		dout("__touch_cap %p cap %p mds%d\n", &cap->ci->vfs_inode, cap,
> +		dout("__touch_cap %p cap %p mds%d\n", &cap->ci->nic.inode, cap,
>  		     s->s_mds);
>  		list_move_tail(&cap->session_caps, &s->s_caps);
>  	} else {
>  		dout("__touch_cap %p cap %p mds%d NOP, iterating over caps\n",
> -		     &cap->ci->vfs_inode, cap, s->s_mds);
> +		     &cap->ci->nic.inode, cap, s->s_mds);
>  	}
>  	spin_unlock(&s->s_cap_lock);
>  }
> @@ -867,7 +867,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *c=
i, int mask, int touch)
> =20
>  	if ((have & mask) =3D=3D mask) {
>  		dout("__ceph_caps_issued_mask ino 0x%llx snap issued %s"
> -		     " (mask %s)\n", ceph_ino(&ci->vfs_inode),
> +		     " (mask %s)\n", ceph_ino(&ci->nic.inode),
>  		     ceph_cap_string(have),
>  		     ceph_cap_string(mask));
>  		return 1;
> @@ -879,7 +879,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *c=
i, int mask, int touch)
>  			continue;
>  		if ((cap->issued & mask) =3D=3D mask) {
>  			dout("__ceph_caps_issued_mask ino 0x%llx cap %p issued %s"
> -			     " (mask %s)\n", ceph_ino(&ci->vfs_inode), cap,
> +			     " (mask %s)\n", ceph_ino(&ci->nic.inode), cap,
>  			     ceph_cap_string(cap->issued),
>  			     ceph_cap_string(mask));
>  			if (touch)
> @@ -891,7 +891,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *c=
i, int mask, int touch)
>  		have |=3D cap->issued;
>  		if ((have & mask) =3D=3D mask) {
>  			dout("__ceph_caps_issued_mask ino 0x%llx combo issued %s"
> -			     " (mask %s)\n", ceph_ino(&ci->vfs_inode),
> +			     " (mask %s)\n", ceph_ino(&ci->nic.inode),
>  			     ceph_cap_string(cap->issued),
>  			     ceph_cap_string(mask));
>  			if (touch) {
> @@ -919,7 +919,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *c=
i, int mask, int touch)
>  int __ceph_caps_issued_mask_metric(struct ceph_inode_info *ci, int mask,
>  				   int touch)
>  {
> -	struct ceph_fs_client *fsc =3D ceph_sb_to_client(ci->vfs_inode.i_sb);
> +	struct ceph_fs_client *fsc =3D ceph_sb_to_client(ci->nic.inode.i_sb);
>  	int r;
> =20
>  	r =3D __ceph_caps_issued_mask(ci, mask, touch);
> @@ -950,7 +950,7 @@ int __ceph_caps_revoking_other(struct ceph_inode_info=
 *ci,
> =20
>  int ceph_caps_revoking(struct ceph_inode_info *ci, int mask)
>  {
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
>  	int ret;
> =20
>  	spin_lock(&ci->i_ceph_lock);
> @@ -969,8 +969,8 @@ int __ceph_caps_used(struct ceph_inode_info *ci)
>  	if (ci->i_rd_ref)
>  		used |=3D CEPH_CAP_FILE_RD;
>  	if (ci->i_rdcache_ref ||
> -	    (S_ISREG(ci->vfs_inode.i_mode) &&
> -	     ci->vfs_inode.i_data.nrpages))
> +	    (S_ISREG(ci->nic.inode.i_mode) &&
> +	     ci->nic.inode.i_data.nrpages))
>  		used |=3D CEPH_CAP_FILE_CACHE;
>  	if (ci->i_wr_ref)
>  		used |=3D CEPH_CAP_FILE_WR;
> @@ -993,11 +993,11 @@ int __ceph_caps_file_wanted(struct ceph_inode_info =
*ci)
>  	const int WR_SHIFT =3D ffs(CEPH_FILE_MODE_WR);
>  	const int LAZY_SHIFT =3D ffs(CEPH_FILE_MODE_LAZY);
>  	struct ceph_mount_options *opt =3D
> -		ceph_inode_to_client(&ci->vfs_inode)->mount_options;
> +		ceph_inode_to_client(&ci->nic.inode)->mount_options;
>  	unsigned long used_cutoff =3D jiffies - opt->caps_wanted_delay_max * HZ=
;
>  	unsigned long idle_cutoff =3D jiffies - opt->caps_wanted_delay_min * HZ=
;
> =20
> -	if (S_ISDIR(ci->vfs_inode.i_mode)) {
> +	if (S_ISDIR(ci->nic.inode.i_mode)) {
>  		int want =3D 0;
> =20
>  		/* use used_cutoff here, to keep dir's wanted caps longer */
> @@ -1050,7 +1050,7 @@ int __ceph_caps_file_wanted(struct ceph_inode_info =
*ci)
>  int __ceph_caps_wanted(struct ceph_inode_info *ci)
>  {
>  	int w =3D __ceph_caps_file_wanted(ci) | __ceph_caps_used(ci);
> -	if (S_ISDIR(ci->vfs_inode.i_mode)) {
> +	if (S_ISDIR(ci->nic.inode.i_mode)) {
>  		/* we want EXCL if holding caps of dir ops */
>  		if (w & CEPH_CAP_ANY_DIR_OPS)
>  			w |=3D CEPH_CAP_FILE_EXCL;
> @@ -1116,9 +1116,9 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool q=
ueue_release)
> =20
>  	lockdep_assert_held(&ci->i_ceph_lock);
> =20
> -	dout("__ceph_remove_cap %p from %p\n", cap, &ci->vfs_inode);
> +	dout("__ceph_remove_cap %p from %p\n", cap, &ci->nic.inode);
> =20
> -	mdsc =3D ceph_inode_to_client(&ci->vfs_inode)->mdsc;
> +	mdsc =3D ceph_inode_to_client(&ci->nic.inode)->mdsc;
> =20
>  	/* remove from inode's cap rbtree, and clear auth cap */
>  	rb_erase(&cap->ci_node, &ci->i_caps);
> @@ -1169,7 +1169,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool q=
ueue_release)
>  		 * keep i_snap_realm.
>  		 */
>  		if (ci->i_wr_ref =3D=3D 0 && ci->i_snap_realm)
> -			ceph_change_snap_realm(&ci->vfs_inode, NULL);
> +			ceph_change_snap_realm(&ci->nic.inode, NULL);
> =20
>  		__cap_delay_cancel(mdsc, ci);
>  	}
> @@ -1188,11 +1188,11 @@ void ceph_remove_cap(struct ceph_cap *cap, bool q=
ueue_release)
> =20
>  	lockdep_assert_held(&ci->i_ceph_lock);
> =20
> -	fsc =3D ceph_inode_to_client(&ci->vfs_inode);
> +	fsc =3D ceph_inode_to_client(&ci->nic.inode);
>  	WARN_ON_ONCE(ci->i_auth_cap =3D=3D cap &&
>  		     !list_empty(&ci->i_dirty_item) &&
>  		     !fsc->blocklisted &&
> -		     !ceph_inode_is_shutdown(&ci->vfs_inode));
> +		     !ceph_inode_is_shutdown(&ci->nic.inode));
> =20
>  	__ceph_remove_cap(cap, queue_release);
>  }
> @@ -1343,7 +1343,7 @@ static void __prep_cap(struct cap_msg_args *arg, st=
ruct ceph_cap *cap,
>  		       int flushing, u64 flush_tid, u64 oldest_flush_tid)
>  {
>  	struct ceph_inode_info *ci =3D cap->ci;
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
>  	int held, revoking;
> =20
>  	lockdep_assert_held(&ci->i_ceph_lock);
> @@ -1440,7 +1440,7 @@ static void __prep_cap(struct cap_msg_args *arg, st=
ruct ceph_cap *cap,
>  static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info =
*ci)
>  {
>  	struct ceph_msg *msg;
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
> =20
>  	msg =3D ceph_msg_new(CEPH_MSG_CLIENT_CAPS, CAP_MSG_SIZE, GFP_NOFS, fals=
e);
>  	if (!msg) {
> @@ -1528,7 +1528,7 @@ static void __ceph_flush_snaps(struct ceph_inode_in=
fo *ci,
>  		__releases(ci->i_ceph_lock)
>  		__acquires(ci->i_ceph_lock)
>  {
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
>  	struct ceph_mds_client *mdsc =3D session->s_mdsc;
>  	struct ceph_cap_snap *capsnap;
>  	u64 oldest_flush_tid =3D 0;
> @@ -1621,7 +1621,7 @@ static void __ceph_flush_snaps(struct ceph_inode_in=
fo *ci,
>  void ceph_flush_snaps(struct ceph_inode_info *ci,
>  		      struct ceph_mds_session **psession)
>  {
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
>  	struct ceph_mds_client *mdsc =3D ceph_inode_to_client(inode)->mdsc;
>  	struct ceph_mds_session *session =3D NULL;
>  	int mds;
> @@ -1681,8 +1681,8 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *=
ci, int mask,
>  			   struct ceph_cap_flush **pcf)
>  {
>  	struct ceph_mds_client *mdsc =3D
> -		ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
> -	struct inode *inode =3D &ci->vfs_inode;
> +		ceph_sb_to_client(ci->nic.inode.i_sb)->mdsc;
> +	struct inode *inode =3D &ci->nic.inode;
>  	int was =3D ci->i_dirty_caps;
>  	int dirty =3D 0;
> =20
> @@ -1695,7 +1695,7 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *=
ci, int mask,
>  		return 0;
>  	}
> =20
> -	dout("__mark_dirty_caps %p %s dirty %s -> %s\n", &ci->vfs_inode,
> +	dout("__mark_dirty_caps %p %s dirty %s -> %s\n", &ci->nic.inode,
>  	     ceph_cap_string(mask), ceph_cap_string(was),
>  	     ceph_cap_string(was | mask));
>  	ci->i_dirty_caps |=3D mask;
> @@ -1711,7 +1711,7 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *=
ci, int mask,
>  				ci->i_snap_realm->cached_context);
>  		}
>  		dout(" inode %p now dirty snapc %p auth cap %p\n",
> -		     &ci->vfs_inode, ci->i_head_snapc, ci->i_auth_cap);
> +		     &ci->nic.inode, ci->i_head_snapc, ci->i_auth_cap);
>  		BUG_ON(!list_empty(&ci->i_dirty_item));
>  		spin_lock(&mdsc->cap_dirty_lock);
>  		list_add(&ci->i_dirty_item, &session->s_cap_dirty);
> @@ -1874,7 +1874,7 @@ static int try_nonblocking_invalidate(struct inode =
*inode)
> =20
>  bool __ceph_should_report_size(struct ceph_inode_info *ci)
>  {
> -	loff_t size =3D i_size_read(&ci->vfs_inode);
> +	loff_t size =3D i_size_read(&ci->nic.inode);
>  	/* mds will adjust max size according to the reported size */
>  	if (ci->i_flushing_caps & CEPH_CAP_FILE_WR)
>  		return false;
> @@ -1899,7 +1899,7 @@ bool __ceph_should_report_size(struct ceph_inode_in=
fo *ci)
>  void ceph_check_caps(struct ceph_inode_info *ci, int flags,
>  		     struct ceph_mds_session *session)
>  {
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
>  	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(inode->i_sb);
>  	struct ceph_cap *cap;
>  	u64 flush_tid, oldest_flush_tid;
> @@ -2446,7 +2446,7 @@ static void __kick_flushing_caps(struct ceph_mds_cl=
ient *mdsc,
>  	__releases(ci->i_ceph_lock)
>  	__acquires(ci->i_ceph_lock)
>  {
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
>  	struct ceph_cap *cap;
>  	struct ceph_cap_flush *cf;
>  	int ret;
> @@ -2539,7 +2539,7 @@ void ceph_early_kick_flushing_caps(struct ceph_mds_=
client *mdsc,
>  		cap =3D ci->i_auth_cap;
>  		if (!(cap && cap->session =3D=3D session)) {
>  			pr_err("%p auth cap %p not mds%d ???\n",
> -				&ci->vfs_inode, cap, session->s_mds);
> +				&ci->nic.inode, cap, session->s_mds);
>  			spin_unlock(&ci->i_ceph_lock);
>  			continue;
>  		}
> @@ -2589,7 +2589,7 @@ void ceph_kick_flushing_caps(struct ceph_mds_client=
 *mdsc,
>  		cap =3D ci->i_auth_cap;
>  		if (!(cap && cap->session =3D=3D session)) {
>  			pr_err("%p auth cap %p not mds%d ???\n",
> -				&ci->vfs_inode, cap, session->s_mds);
> +				&ci->nic.inode, cap, session->s_mds);
>  			spin_unlock(&ci->i_ceph_lock);
>  			continue;
>  		}
> @@ -2609,7 +2609,7 @@ void ceph_kick_flushing_inode_caps(struct ceph_mds_=
session *session,
> =20
>  	lockdep_assert_held(&ci->i_ceph_lock);
> =20
> -	dout("%s %p flushing %s\n", __func__, &ci->vfs_inode,
> +	dout("%s %p flushing %s\n", __func__, &ci->nic.inode,
>  	     ceph_cap_string(ci->i_flushing_caps));
> =20
>  	if (!list_empty(&ci->i_cap_flush_list)) {
> @@ -2652,10 +2652,10 @@ void ceph_take_cap_refs(struct ceph_inode_info *c=
i, int got,
>  	}
>  	if (got & CEPH_CAP_FILE_BUFFER) {
>  		if (ci->i_wb_ref =3D=3D 0)
> -			ihold(&ci->vfs_inode);
> +			ihold(&ci->nic.inode);
>  		ci->i_wb_ref++;
>  		dout("%s %p wb %d -> %d (?)\n", __func__,
> -		     &ci->vfs_inode, ci->i_wb_ref-1, ci->i_wb_ref);
> +		     &ci->nic.inode, ci->i_wb_ref-1, ci->i_wb_ref);
>  	}
>  }
> =20
> @@ -2983,7 +2983,7 @@ int ceph_get_caps(struct file *filp, int need, int =
want, loff_t endoff, int *got
>  			return ret;
>  		}
> =20
> -		if (S_ISREG(ci->vfs_inode.i_mode) &&
> +		if (S_ISREG(ci->nic.inode.i_mode) &&
>  		    ci->i_inline_version !=3D CEPH_INLINE_NONE &&
>  		    (_got & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) &&
>  		    i_size_read(inode) > 0) {
> @@ -3073,7 +3073,7 @@ enum put_cap_refs_mode {
>  static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
>  				enum put_cap_refs_mode mode)
>  {
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
>  	int last =3D 0, put =3D 0, flushsnaps =3D 0, wake =3D 0;
>  	bool check_flushsnaps =3D false;
> =20
> @@ -3181,7 +3181,7 @@ void ceph_put_cap_refs_no_check_caps(struct ceph_in=
ode_info *ci, int had)
>  void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
>  				struct ceph_snap_context *snapc)
>  {
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
>  	struct ceph_cap_snap *capsnap =3D NULL;
>  	int put =3D 0;
>  	bool last =3D false;
> @@ -3678,7 +3678,7 @@ static void handle_cap_flush_ack(struct inode *inod=
e, u64 flush_tid,
>  				     session->s_mds,
>  				     &list_first_entry(&session->s_cap_flushing,
>  						struct ceph_inode_info,
> -						i_flushing_item)->vfs_inode);
> +						i_flushing_item)->nic.inode);
>  			}
>  		}
>  		mdsc->num_cap_flushing--;
> @@ -4326,7 +4326,7 @@ unsigned long ceph_check_delayed_caps(struct ceph_m=
ds_client *mdsc)
>  			break;
>  		list_del_init(&ci->i_cap_delay_list);
> =20
> -		inode =3D igrab(&ci->vfs_inode);
> +		inode =3D igrab(&ci->nic.inode);
>  		if (inode) {
>  			spin_unlock(&mdsc->cap_delay_lock);
>  			dout("check_delayed_caps on %p\n", inode);
> @@ -4354,7 +4354,7 @@ static void flush_dirty_session_caps(struct ceph_md=
s_session *s)
>  	while (!list_empty(&s->s_cap_dirty)) {
>  		ci =3D list_first_entry(&s->s_cap_dirty, struct ceph_inode_info,
>  				      i_dirty_item);
> -		inode =3D &ci->vfs_inode;
> +		inode =3D &ci->nic.inode;
>  		ihold(inode);
>  		dout("flush_dirty_caps %llx.%llx\n", ceph_vinop(inode));
>  		spin_unlock(&mdsc->cap_dirty_lock);
> @@ -4388,7 +4388,7 @@ void __ceph_touch_fmode(struct ceph_inode_info *ci,
> =20
>  void ceph_get_fmode(struct ceph_inode_info *ci, int fmode, int count)
>  {
> -	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(ci->vfs_inode.i_sb);
> +	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(ci->nic.inode.i_sb);
>  	int bits =3D (fmode << 1) | 1;
>  	bool already_opened =3D false;
>  	int i;
> @@ -4422,7 +4422,7 @@ void ceph_get_fmode(struct ceph_inode_info *ci, int=
 fmode, int count)
>   */
>  void ceph_put_fmode(struct ceph_inode_info *ci, int fmode, int count)
>  {
> -	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(ci->vfs_inode.i_sb);
> +	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(ci->nic.inode.i_sb);
>  	int bits =3D (fmode << 1) | 1;
>  	bool is_closed =3D true;
>  	int i;
> @@ -4637,7 +4637,7 @@ int ceph_purge_inode_cap(struct inode *inode, struc=
t ceph_cap *cap, bool *invali
>  	lockdep_assert_held(&ci->i_ceph_lock);
> =20
>  	dout("removing cap %p, ci is %p, inode is %p\n",
> -	     cap, ci, &ci->vfs_inode);
> +	     cap, ci, &ci->nic.inode);
> =20
>  	is_auth =3D (cap =3D=3D ci->i_auth_cap);
>  	__ceph_remove_cap(cap, false);
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 8c8226c0feac..fb4383ca8458 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -205,7 +205,7 @@ static int ceph_init_file_info(struct inode *inode, s=
truct file *file,
>  {
>  	struct ceph_inode_info *ci =3D ceph_inode(inode);
>  	struct ceph_mount_options *opt =3D
> -		ceph_inode_to_client(&ci->vfs_inode)->mount_options;
> +		ceph_inode_to_client(&ci->nic.inode)->mount_options;
>  	struct ceph_file_info *fi;
>  	int ret;
> =20
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 63113e2a4890..0fb4ea5d4527 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -176,7 +176,7 @@ static struct ceph_inode_frag *__get_or_create_frag(s=
truct ceph_inode_info *ci,
>  	rb_insert_color(&frag->node, &ci->i_fragtree);
> =20
>  	dout("get_or_create_frag added %llx.%llx frag %x\n",
> -	     ceph_vinop(&ci->vfs_inode), f);
> +	     ceph_vinop(&ci->nic.inode), f);
>  	return frag;
>  }
> =20
> @@ -457,10 +457,10 @@ struct inode *ceph_alloc_inode(struct super_block *=
sb)
>  	if (!ci)
>  		return NULL;
> =20
> -	dout("alloc_inode %p\n", &ci->vfs_inode);
> +	dout("alloc_inode %p\n", &ci->nic.inode);
> =20
>  	/* Set parameters for the netfs library */
> -	netfs_i_context_init(&ci->vfs_inode, &ceph_netfs_ops);
> +	netfs_i_context_init(&ci->nic.inode, &ceph_netfs_ops);
> =20
>  	spin_lock_init(&ci->i_ceph_lock);
> =20
> @@ -547,7 +547,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb=
)
>  	INIT_WORK(&ci->i_work, ceph_inode_work);
>  	ci->i_work_mask =3D 0;
>  	memset(&ci->i_btime, '\0', sizeof(ci->i_btime));
> -	return &ci->vfs_inode;
> +	return &ci->nic.inode;
>  }
> =20
>  void ceph_free_inode(struct inode *inode)
> @@ -1977,7 +1977,7 @@ static void ceph_inode_work(struct work_struct *wor=
k)
>  {
>  	struct ceph_inode_info *ci =3D container_of(work, struct ceph_inode_inf=
o,
>  						 i_work);
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
> =20
>  	if (test_and_clear_bit(CEPH_I_WORK_WRITEBACK, &ci->i_work_mask)) {
>  		dout("writeback %p\n", inode);
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 00c3de177dd6..a94991a13738 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1564,7 +1564,7 @@ int ceph_iterate_session_caps(struct ceph_mds_sessi=
on *session,
>  	p =3D session->s_caps.next;
>  	while (p !=3D &session->s_caps) {
>  		cap =3D list_entry(p, struct ceph_cap, session_caps);
> -		inode =3D igrab(&cap->ci->vfs_inode);
> +		inode =3D igrab(&cap->ci->nic.inode);
>  		if (!inode) {
>  			p =3D p->next;
>  			continue;
> @@ -1622,7 +1622,7 @@ static int remove_session_caps_cb(struct inode *ino=
de, struct ceph_cap *cap,
>  	int iputs;
> =20
>  	dout("removing cap %p, ci is %p, inode is %p\n",
> -	     cap, ci, &ci->vfs_inode);
> +	     cap, ci, &ci->nic.inode);
>  	spin_lock(&ci->i_ceph_lock);
>  	iputs =3D ceph_purge_inode_cap(inode, cap, &invalidate);
>  	spin_unlock(&ci->i_ceph_lock);
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index 322ee5add942..bf7991c48c1e 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -521,7 +521,7 @@ static bool has_new_snaps(struct ceph_snap_context *o=
,
>  static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
>  				struct ceph_cap_snap **pcapsnap)
>  {
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
>  	struct ceph_snap_context *old_snapc, *new_snapc;
>  	struct ceph_cap_snap *capsnap =3D *pcapsnap;
>  	struct ceph_buffer *old_blob =3D NULL;
> @@ -652,7 +652,7 @@ static void ceph_queue_cap_snap(struct ceph_inode_inf=
o *ci,
>  int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
>  			    struct ceph_cap_snap *capsnap)
>  {
> -	struct inode *inode =3D &ci->vfs_inode;
> +	struct inode *inode =3D &ci->nic.inode;
>  	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(inode->i_sb);
> =20
>  	BUG_ON(capsnap->writing);
> @@ -712,7 +712,7 @@ static void queue_realm_cap_snaps(struct ceph_snap_re=
alm *realm)
> =20
>  	spin_lock(&realm->inodes_with_caps_lock);
>  	list_for_each_entry(ci, &realm->inodes_with_caps, i_snap_realm_item) {
> -		struct inode *inode =3D igrab(&ci->vfs_inode);
> +		struct inode *inode =3D igrab(&ci->nic.inode);
>  		if (!inode)
>  			continue;
>  		spin_unlock(&realm->inodes_with_caps_lock);
> @@ -904,7 +904,7 @@ static void flush_snaps(struct ceph_mds_client *mdsc)
>  	while (!list_empty(&mdsc->snap_flush_list)) {
>  		ci =3D list_first_entry(&mdsc->snap_flush_list,
>  				struct ceph_inode_info, i_snap_flush_item);
> -		inode =3D &ci->vfs_inode;
> +		inode =3D &ci->nic.inode;
>  		ihold(inode);
>  		spin_unlock(&mdsc->snap_flush_lock);
>  		ceph_flush_snaps(ci, &session);
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index e6987d295079..45d6b3ccf4de 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -876,7 +876,7 @@ mempool_t *ceph_wb_pagevec_pool;
>  static void ceph_inode_init_once(void *foo)
>  {
>  	struct ceph_inode_info *ci =3D foo;
> -	inode_init_once(&ci->vfs_inode);
> +	inode_init_once(&ci->nic.inode);
>  }
> =20
>  static int __init init_caches(void)
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 20ceab74e871..d1434959d5f1 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -316,11 +316,7 @@ struct ceph_inode_xattrs_info {
>   * Ceph inode.
>   */
>  struct ceph_inode_info {
> -	struct {
> -		/* These must be contiguous */
> -		struct inode vfs_inode;
> -		struct netfs_i_context netfs_ctx; /* Netfslib context */
> -	};
> +	struct netfs_i_context nic; /* Netfslib context and vfs inode */
>  	struct ceph_vino i_vino;   /* ceph ino + snap */
> =20
>  	spinlock_t i_ceph_lock;
> @@ -436,7 +432,7 @@ struct ceph_inode_info {
>  static inline struct ceph_inode_info *
>  ceph_inode(const struct inode *inode)
>  {
> -	return container_of(inode, struct ceph_inode_info, vfs_inode);
> +	return container_of(inode, struct ceph_inode_info, nic.inode);
>  }
> =20
>  static inline struct ceph_fs_client *
> @@ -1295,7 +1291,7 @@ static inline void __ceph_update_quota(struct ceph_=
inode_info *ci,
>  	has_quota =3D __ceph_has_any_quota(ci);
> =20
>  	if (had_quota !=3D has_quota)
> -		ceph_adjust_quota_realms_count(&ci->vfs_inode, has_quota);
> +		ceph_adjust_quota_realms_count(&ci->nic.inode, has_quota);
>  }
> =20
>  extern void ceph_handle_quota(struct ceph_mds_client *mdsc,
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index afec84088471..7967d2552e88 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -57,7 +57,7 @@ static bool ceph_vxattrcb_layout_exists(struct ceph_ino=
de_info *ci)
>  static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *va=
l,
>  				    size_t size)
>  {
> -	struct ceph_fs_client *fsc =3D ceph_sb_to_client(ci->vfs_inode.i_sb);
> +	struct ceph_fs_client *fsc =3D ceph_sb_to_client(ci->nic.inode.i_sb);
>  	struct ceph_osd_client *osdc =3D &fsc->client->osdc;
>  	struct ceph_string *pool_ns;
>  	s64 pool =3D ci->i_layout.pool_id;
> @@ -69,7 +69,7 @@ static ssize_t ceph_vxattrcb_layout(struct ceph_inode_i=
nfo *ci, char *val,
> =20
>  	pool_ns =3D ceph_try_get_string(ci->i_layout.pool_ns);
> =20
> -	dout("ceph_vxattrcb_layout %p\n", &ci->vfs_inode);
> +	dout("ceph_vxattrcb_layout %p\n", &ci->nic.inode);
>  	down_read(&osdc->lock);
>  	pool_name =3D ceph_pg_pool_name_by_id(osdc->osdmap, pool);
>  	if (pool_name) {
> @@ -161,7 +161,7 @@ static ssize_t ceph_vxattrcb_layout_pool(struct ceph_=
inode_info *ci,
>  					 char *val, size_t size)
>  {
>  	ssize_t ret;
> -	struct ceph_fs_client *fsc =3D ceph_sb_to_client(ci->vfs_inode.i_sb);
> +	struct ceph_fs_client *fsc =3D ceph_sb_to_client(ci->nic.inode.i_sb);
>  	struct ceph_osd_client *osdc =3D &fsc->client->osdc;
>  	s64 pool =3D ci->i_layout.pool_id;
>  	const char *pool_name;
> @@ -313,7 +313,7 @@ static ssize_t ceph_vxattrcb_snap_btime(struct ceph_i=
node_info *ci, char *val,
>  static ssize_t ceph_vxattrcb_cluster_fsid(struct ceph_inode_info *ci,
>  					  char *val, size_t size)
>  {
> -	struct ceph_fs_client *fsc =3D ceph_sb_to_client(ci->vfs_inode.i_sb);
> +	struct ceph_fs_client *fsc =3D ceph_sb_to_client(ci->nic.inode.i_sb);
> =20
>  	return ceph_fmt_xattr(val, size, "%pU", &fsc->client->fsid);
>  }
> @@ -321,7 +321,7 @@ static ssize_t ceph_vxattrcb_cluster_fsid(struct ceph=
_inode_info *ci,
>  static ssize_t ceph_vxattrcb_client_id(struct ceph_inode_info *ci,
>  				       char *val, size_t size)
>  {
> -	struct ceph_fs_client *fsc =3D ceph_sb_to_client(ci->vfs_inode.i_sb);
> +	struct ceph_fs_client *fsc =3D ceph_sb_to_client(ci->nic.inode.i_sb);
> =20
>  	return ceph_fmt_xattr(val, size, "client%lld",
>  			      ceph_client_gid(fsc->client));
> @@ -621,7 +621,7 @@ static int __set_xattr(struct ceph_inode_info *ci,
>  	}
> =20
>  	dout("__set_xattr_val added %llx.%llx xattr %p %.*s=3D%.*s\n",
> -	     ceph_vinop(&ci->vfs_inode), xattr, name_len, name, val_len, val);
> +	     ceph_vinop(&ci->nic.inode), xattr, name_len, name, val_len, val);
> =20
>  	return 0;
>  }
> @@ -863,7 +863,7 @@ struct ceph_buffer *__ceph_build_xattrs_blob(struct c=
eph_inode_info *ci)
>  	struct ceph_buffer *old_blob =3D NULL;
>  	void *dest;
> =20
> -	dout("__build_xattrs_blob %p\n", &ci->vfs_inode);
> +	dout("__build_xattrs_blob %p\n", &ci->nic.inode);
>  	if (ci->i_xattrs.dirty) {
>  		int need =3D __get_required_blob_size(ci, 0, 0);
> =20
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index 2b1a1c029c75..a4e50021f199 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -377,7 +377,7 @@ cifs_alloc_inode(struct super_block *sb)
>  	cifs_inode->flags =3D 0;
>  	spin_lock_init(&cifs_inode->writers_lock);
>  	cifs_inode->writers =3D 0;
> -	cifs_inode->vfs_inode.i_blkbits =3D 14;  /* 2**14 =3D CIFS_MAX_MSGSIZE =
*/
> +	cifs_inode->nic.inode.i_blkbits =3D 14;  /* 2**14 =3D CIFS_MAX_MSGSIZE =
*/
>  	cifs_inode->server_eof =3D 0;
>  	cifs_inode->uniqueid =3D 0;
>  	cifs_inode->createtime =3D 0;
> @@ -389,12 +389,12 @@ cifs_alloc_inode(struct super_block *sb)
>  	 * Can not set i_flags here - they get immediately overwritten to zero
>  	 * by the VFS.
>  	 */
> -	/* cifs_inode->vfs_inode.i_flags =3D S_NOATIME | S_NOCMTIME; */
> +	/* cifs_inode->nic.inode.i_flags =3D S_NOATIME | S_NOCMTIME; */
>  	INIT_LIST_HEAD(&cifs_inode->openFileList);
>  	INIT_LIST_HEAD(&cifs_inode->llist);
>  	INIT_LIST_HEAD(&cifs_inode->deferred_closes);
>  	spin_lock_init(&cifs_inode->deferred_lock);
> -	return &cifs_inode->vfs_inode;
> +	return &cifs_inode->nic.inode;
>  }
> =20
>  static void
> @@ -1414,7 +1414,7 @@ cifs_init_once(void *inode)
>  {
>  	struct cifsInodeInfo *cifsi =3D inode;
> =20
> -	inode_init_once(&cifsi->vfs_inode);
> +	inode_init_once(&cifsi->nic.inode);
>  	init_rwsem(&cifsi->lock_sem);
>  }
> =20
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 8de977c359b1..3018245784f5 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -1396,20 +1396,16 @@ void cifsFileInfo_put(struct cifsFileInfo *cifs_f=
ile);
>  #define CIFS_CACHE_RW_FLG	(CIFS_CACHE_READ_FLG | CIFS_CACHE_WRITE_FLG)
>  #define CIFS_CACHE_RHW_FLG	(CIFS_CACHE_RW_FLG | CIFS_CACHE_HANDLE_FLG)
> =20
> -#define CIFS_CACHE_READ(cinode) ((cinode->oplock & CIFS_CACHE_READ_FLG) =
|| (CIFS_SB(cinode->vfs_inode.i_sb)->mnt_cifs_flags & CIFS_MOUNT_RO_CACHE))
> +#define CIFS_CACHE_READ(cinode) ((cinode->oplock & CIFS_CACHE_READ_FLG) =
|| (CIFS_SB(cinode->nic.inode.i_sb)->mnt_cifs_flags & CIFS_MOUNT_RO_CACHE))
>  #define CIFS_CACHE_HANDLE(cinode) (cinode->oplock & CIFS_CACHE_HANDLE_FL=
G)
> -#define CIFS_CACHE_WRITE(cinode) ((cinode->oplock & CIFS_CACHE_WRITE_FLG=
) || (CIFS_SB(cinode->vfs_inode.i_sb)->mnt_cifs_flags & CIFS_MOUNT_RW_CACHE=
))
> +#define CIFS_CACHE_WRITE(cinode) ((cinode->oplock & CIFS_CACHE_WRITE_FLG=
) || (CIFS_SB(cinode->nic.inode.i_sb)->mnt_cifs_flags & CIFS_MOUNT_RW_CACHE=
))
> =20
>  /*
>   * One of these for each file inode
>   */
> =20
>  struct cifsInodeInfo {
> -	struct {
> -		/* These must be contiguous */
> -		struct inode	vfs_inode;	/* the VFS's inode record */
> -		struct netfs_i_context netfs_ctx; /* Netfslib context */
> -	};
> +	struct netfs_i_context nic; /* Netfslib context and vfs inode */
>  	bool can_cache_brlcks;
>  	struct list_head llist;	/* locks helb by this inode */
>  	/*
> @@ -1448,7 +1444,7 @@ struct cifsInodeInfo {
>  static inline struct cifsInodeInfo *
>  CIFS_I(struct inode *inode)
>  {
> -	return container_of(inode, struct cifsInodeInfo, vfs_inode);
> +	return container_of(inode, struct cifsInodeInfo, nic.inode);
>  }
> =20
>  static inline struct cifs_sb_info *
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index d511a78383c3..c194fd9f003c 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -2004,7 +2004,7 @@ struct cifsFileInfo *find_readable_file(struct cifs=
InodeInfo *cifs_inode,
>  					bool fsuid_only)
>  {
>  	struct cifsFileInfo *open_file =3D NULL;
> -	struct cifs_sb_info *cifs_sb =3D CIFS_SB(cifs_inode->vfs_inode.i_sb);
> +	struct cifs_sb_info *cifs_sb =3D CIFS_SB(cifs_inode->nic.inode.i_sb);
> =20
>  	/* only filter by fsuid on multiuser mounts */
>  	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MULTIUSER))
> @@ -2060,7 +2060,7 @@ cifs_get_writable_file(struct cifsInodeInfo *cifs_i=
node, int flags,
>  		return rc;
>  	}
> =20
> -	cifs_sb =3D CIFS_SB(cifs_inode->vfs_inode.i_sb);
> +	cifs_sb =3D CIFS_SB(cifs_inode->nic.inode.i_sb);
> =20
>  	/* only filter by fsuid on multiuser mounts */
>  	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MULTIUSER))
> @@ -4665,14 +4665,14 @@ bool is_size_safe_to_change(struct cifsInodeInfo =
*cifsInode, __u64 end_of_file)
>  		/* This inode is open for write at least once */
>  		struct cifs_sb_info *cifs_sb;
> =20
> -		cifs_sb =3D CIFS_SB(cifsInode->vfs_inode.i_sb);
> +		cifs_sb =3D CIFS_SB(cifsInode->nic.inode.i_sb);
>  		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO) {
>  			/* since no page cache to corrupt on directio
>  			we can change size safely */
>  			return true;
>  		}
> =20
> -		if (i_size_read(&cifsInode->vfs_inode) < end_of_file)
> +		if (i_size_read(&cifsInode->nic.inode) < end_of_file)
>  			return true;
> =20
>  		return false;
> diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
> index a638b29e9062..ce655baf70e3 100644
> --- a/fs/cifs/fscache.c
> +++ b/fs/cifs/fscache.c
> @@ -101,13 +101,13 @@ void cifs_fscache_get_inode_cookie(struct inode *in=
ode)
>  	struct cifs_sb_info *cifs_sb =3D CIFS_SB(inode->i_sb);
>  	struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> =20
> -	cifs_fscache_fill_coherency(&cifsi->vfs_inode, &cd);
> +	cifs_fscache_fill_coherency(&cifsi->nic.inode, &cd);
> =20
>  	cifsi->netfs_ctx.cache =3D
>  		fscache_acquire_cookie(tcon->fscache, 0,
>  				       &cifsi->uniqueid, sizeof(cifsi->uniqueid),
>  				       &cd, sizeof(cd),
> -				       i_size_read(&cifsi->vfs_inode));
> +				       i_size_read(&cifsi->nic.inode));
>  }
> =20
>  void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update)
> diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
> index 52355c0912ae..47b2210f8051 100644
> --- a/fs/cifs/fscache.h
> +++ b/fs/cifs/fscache.h
> @@ -52,10 +52,10 @@ void cifs_fscache_fill_coherency(struct inode *inode,
>  	struct cifsInodeInfo *cifsi =3D CIFS_I(inode);
> =20
>  	memset(cd, 0, sizeof(*cd));
> -	cd->last_write_time_sec   =3D cpu_to_le64(cifsi->vfs_inode.i_mtime.tv_s=
ec);
> -	cd->last_write_time_nsec  =3D cpu_to_le32(cifsi->vfs_inode.i_mtime.tv_n=
sec);
> -	cd->last_change_time_sec  =3D cpu_to_le64(cifsi->vfs_inode.i_ctime.tv_s=
ec);
> -	cd->last_change_time_nsec =3D cpu_to_le32(cifsi->vfs_inode.i_ctime.tv_n=
sec);
> +	cd->last_write_time_sec   =3D cpu_to_le64(cifsi->nic.inode.i_mtime.tv_s=
ec);
> +	cd->last_write_time_nsec  =3D cpu_to_le32(cifsi->nic.inode.i_mtime.tv_n=
sec);
> +	cd->last_change_time_sec  =3D cpu_to_le64(cifsi->nic.inode.i_ctime.tv_s=
ec);
> +	cd->last_change_time_nsec =3D cpu_to_le32(cifsi->nic.inode.i_ctime.tv_n=
sec);
>  }
> =20
> =20
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index 2f9e7d2f81b6..d79e0f650a33 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -115,7 +115,7 @@ cifs_revalidate_cache(struct inode *inode, struct cif=
s_fattr *fattr)
>  		 __func__, cifs_i->uniqueid);
>  	set_bit(CIFS_INO_INVALID_MAPPING, &cifs_i->flags);
>  	/* Invalidate fscache cookie */
> -	cifs_fscache_fill_coherency(&cifs_i->vfs_inode, &cd);
> +	cifs_fscache_fill_coherency(&cifs_i->nic.inode, &cd);
>  	fscache_invalidate(cifs_inode_cookie(inode), &cd, i_size_read(inode), 0=
);
>  }
> =20
> @@ -2499,7 +2499,7 @@ int cifs_fiemap(struct inode *inode, struct fiemap_=
extent_info *fei, u64 start,
>  		u64 len)
>  {
>  	struct cifsInodeInfo *cifs_i =3D CIFS_I(inode);
> -	struct cifs_sb_info *cifs_sb =3D CIFS_SB(cifs_i->vfs_inode.i_sb);
> +	struct cifs_sb_info *cifs_sb =3D CIFS_SB(cifs_i->nic.inode.i_sb);
>  	struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
>  	struct TCP_Server_Info *server =3D tcon->ses->server;
>  	struct cifsFileInfo *cfile;
> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
> index afaf59c22193..7cfe3aba9be9 100644
> --- a/fs/cifs/misc.c
> +++ b/fs/cifs/misc.c
> @@ -536,11 +536,11 @@ void cifs_set_oplock_level(struct cifsInodeInfo *ci=
node, __u32 oplock)
>  	if (oplock =3D=3D OPLOCK_EXCLUSIVE) {
>  		cinode->oplock =3D CIFS_CACHE_WRITE_FLG | CIFS_CACHE_READ_FLG;
>  		cifs_dbg(FYI, "Exclusive Oplock granted on inode %p\n",
> -			 &cinode->vfs_inode);
> +			 &cinode->nic.inode);
>  	} else if (oplock =3D=3D OPLOCK_READ) {
>  		cinode->oplock =3D CIFS_CACHE_READ_FLG;
>  		cifs_dbg(FYI, "Level II Oplock granted on inode %p\n",
> -			 &cinode->vfs_inode);
> +			 &cinode->nic.inode);
>  	} else
>  		cinode->oplock =3D 0;
>  }
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index d6aaeff4a30a..28b5d24796e5 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -4238,15 +4238,15 @@ smb2_set_oplock_level(struct cifsInodeInfo *cinod=
e, __u32 oplock,
>  	if (oplock =3D=3D SMB2_OPLOCK_LEVEL_BATCH) {
>  		cinode->oplock =3D CIFS_CACHE_RHW_FLG;
>  		cifs_dbg(FYI, "Batch Oplock granted on inode %p\n",
> -			 &cinode->vfs_inode);
> +			 &cinode->nic.inode);
>  	} else if (oplock =3D=3D SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
>  		cinode->oplock =3D CIFS_CACHE_RW_FLG;
>  		cifs_dbg(FYI, "Exclusive Oplock granted on inode %p\n",
> -			 &cinode->vfs_inode);
> +			 &cinode->nic.inode);
>  	} else if (oplock =3D=3D SMB2_OPLOCK_LEVEL_II) {
>  		cinode->oplock =3D CIFS_CACHE_READ_FLG;
>  		cifs_dbg(FYI, "Level II Oplock granted on inode %p\n",
> -			 &cinode->vfs_inode);
> +			 &cinode->nic.inode);
>  	} else
>  		cinode->oplock =3D 0;
>  }
> @@ -4285,7 +4285,7 @@ smb21_set_oplock_level(struct cifsInodeInfo *cinode=
, __u32 oplock,
> =20
>  	cinode->oplock =3D new_oplock;
>  	cifs_dbg(FYI, "%s Lease granted on inode %p\n", message,
> -		 &cinode->vfs_inode);
> +		 &cinode->nic.inode);
>  }
> =20
>  static void
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 1970c21b4f80..6e4e382ace03 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -119,9 +119,10 @@ typedef void (*netfs_io_terminated_t)(void *priv, ss=
ize_t transferred_or_error,
>  				      bool was_async);
> =20
>  /*
> - * Per-inode description.  This must be directly after the inode struct.
> + * Per-inode context.  This wraps the VFS inode.
>   */
>  struct netfs_i_context {
> +	struct inode		inode;		/* The VFS inode */
>  	const struct netfs_request_ops *ops;
>  #if IS_ENABLED(CONFIG_FSCACHE)
>  	struct fscache_cookie	*cache;
> @@ -297,7 +298,7 @@ extern void netfs_stats_show(struct seq_file *);
>   */
>  static inline struct netfs_i_context *netfs_i_context(struct inode *inod=
e)
>  {
> -	return (struct netfs_i_context *)(inode + 1);
> +	return container_of(inode, struct netfs_i_context, inode);
>  }
> =20
>  /**
> @@ -309,7 +310,7 @@ static inline struct netfs_i_context *netfs_i_context=
(struct inode *inode)
>   */
>  static inline struct inode *netfs_inode(struct netfs_i_context *ctx)
>  {
> -	return ((struct inode *)ctx) - 1;
> +	return &ctx->inode;
>  }
> =20
>  /**
> @@ -325,9 +326,11 @@ static inline void netfs_i_context_init(struct inode=
 *inode,
>  {
>  	struct netfs_i_context *ctx =3D netfs_i_context(inode);
> =20
> -	memset(ctx, 0, sizeof(*ctx));
>  	ctx->ops =3D ops;
>  	ctx->remote_i_size =3D i_size_read(inode);
> +#if IS_ENABLED(CONFIG_FSCACHE)
> +	ctx->cache =3D NULL;
> +#endif
>  }
> =20
>  /**
>=20
>=20

Acked-by: Jeff Layton <jlayton@kernel.org>
