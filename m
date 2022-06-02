Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD8C53BD5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiFBReO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiFBReK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:34:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AA664C4;
        Thu,  2 Jun 2022 10:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BCB7B82053;
        Thu,  2 Jun 2022 17:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBB7C385A5;
        Thu,  2 Jun 2022 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654191245;
        bh=GZog0t9rm3f0JRi4bQXq6c/X4WPAuWvY7ehb4mQ3lew=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MRqQHdDsJnUi80PI8qnZuCFvrpmItEzFprMYTqqCYqwsQSJih0y4P2FgiGTh6643/
         MCOoDp3ANK2sTUc2v1RzjqUGSnEokMclNYmMba3Czdy3Qmd2YwxZ5O8Nc/SXdei0gx
         suij4yaC4HX7n5EMngdF6Jn9wfBkpnya0SB3yoykM/32p6BbC8MdE5U8vQDlJiBedZ
         bKZmzU7UyhgsIEcsk6lWCbgJ6VLenGzxsw49TmJspwbG/NuNyhyE1wFuFswVQvmE7d
         PKytswKyqSAo6lFdoXDDokdCPro1fjrSfR3G23Smv99mMsOCuBjhabJbDr5P09Xt7S
         XcsBiKOhO7IxA==
Message-ID: <07f8e9653f9e533e7248c31deae70e35fb703a0d.camel@kernel.org>
Subject: Re: [RFC PATCH v4] ceph: prevent a client from exceeding the MDS
 maximum xattr size
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Gregory Farnum <gfarnum@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Jun 2022 13:34:03 -0400
In-Reply-To: <20220602143652.28244-1-lhenriques@suse.de>
References: <20220602143652.28244-1-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-02 at 15:36 +0100, Lu=EDs Henriques wrote:
> The MDS tries to enforce a limit on the total key/values in extended
> attributes.  However, this limit is enforced only if doing a synchronous
> operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
> doesn't have a chance to enforce these limits.
>=20
> This patch adds support for decoding the xattrs maximum size setting that=
 is
> distributed in the mdsmap.  Then, when setting an xattr, the kernel clien=
t
> will revert to do a synchronous operation if that maximum size is exceede=
d.
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
>  fs/ceph/mdsmap.c            | 28 ++++++++++++++++++++++++----
>  fs/ceph/xattr.c             | 12 ++++++++----
>  include/linux/ceph/mdsmap.h |  1 +
>  3 files changed, 33 insertions(+), 8 deletions(-)
>=20
> * Changes since v3
>=20
> As per Xiubo review:
>   - Always force a (sync) SETXATTR Op when connecting to an old cluster
>   - use '>' instead of '>=3D'
> Also fixed the warning detected by 0day.
>=20
> * Changes since v2
>=20
> Well, a lot has changed since v2!  Now the xattr max value setting is
> obtained through the mdsmap, which needs to be decoded, and the feature
> that was used in the previous revision was dropped.  The drawback is that
> the MDS isn't unable to know in advance if a client is aware of this xatt=
r
> max value.
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
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index 30387733765d..c6ce83a48175 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -13,6 +13,12 @@
> =20
>  #include "super.h"
> =20
> +/*
> + * Maximum size of xattrs the MDS can handle per inode by default.  This
> + * includes the attribute name and 4+4 bytes for the key/value sizes.
> + */
> +#define MDS_MAX_XATTR_SIZE (1<<16) /* 64K */
> +
>  #define CEPH_MDS_IS_READY(i, ignore_laggy) \
>  	(m->m_info[i].state > 0 && ignore_laggy ? true : !m->m_info[i].laggy)
> =20
> @@ -352,12 +358,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, vo=
id *end, bool msgr2)
>  		__decode_and_drop_type(p, end, u8, bad_ext);
>  	}
>  	if (mdsmap_ev >=3D 8) {
> -		u32 name_len;
>  		/* enabled */
>  		ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
> -		ceph_decode_32_safe(p, end, name_len, bad_ext);
> -		ceph_decode_need(p, end, name_len, bad_ext);
> -		*p +=3D name_len;
> +		/* fs_name */
> +		ceph_decode_skip_string(p, end, bad_ext);
>  	}
>  	/* damaged */
>  	if (mdsmap_ev >=3D 9) {
> @@ -370,6 +374,22 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, voi=
d *end, bool msgr2)
>  	} else {
>  		m->m_damaged =3D false;
>  	}
> +	if (mdsmap_ev >=3D 17) {
> +		/* balancer */
> +		ceph_decode_skip_string(p, end, bad_ext);
> +		/* standby_count_wanted */
> +		ceph_decode_skip_32(p, end, bad_ext);
> +		/* old_max_mds */
> +		ceph_decode_skip_32(p, end, bad_ext);
> +		/* min_compat_client */
> +		ceph_decode_skip_8(p, end, bad_ext);
> +		/* required_client_features */
> +		ceph_decode_skip_set(p, end, 64, bad_ext);
> +		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
> +	} else {
> +		/* This forces the usage of the (sync) SETXATTR Op */
> +		m->m_max_xattr_size =3D 0;
> +	}
>  bad_ext:
>  	dout("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
>  	     !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 8c2dc2c762a4..1be415e9220b 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1086,7 +1086,7 @@ static int ceph_sync_setxattr(struct inode *inode, =
const char *name,
>  			flags |=3D CEPH_XATTR_REMOVE;
>  	}
> =20
> -	dout("setxattr value=3D%.*s\n", (int)size, value);
> +	dout("setxattr value size: %lu\n", size);
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
> +	    (required_blob_size > mdsc->mdsmap->m_max_xattr_size)) {
> +		dout("%s do sync setxattr: version: %llu size: %d max: %llu\n",
> +		     __func__, ci->i_xattrs.version, required_blob_size,
> +		     mdsc->mdsmap->m_max_xattr_size);
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
> diff --git a/include/linux/ceph/mdsmap.h b/include/linux/ceph/mdsmap.h
> index 523fd0452856..4c3e0648dc27 100644
> --- a/include/linux/ceph/mdsmap.h
> +++ b/include/linux/ceph/mdsmap.h
> @@ -25,6 +25,7 @@ struct ceph_mdsmap {
>  	u32 m_session_timeout;          /* seconds */
>  	u32 m_session_autoclose;        /* seconds */
>  	u64 m_max_file_size;
> +	u64 m_max_xattr_size;		/* maximum size for xattrs blob */
>  	u32 m_max_mds;			/* expected up:active mds number */
>  	u32 m_num_active_mds;		/* actual up:active mds number */
>  	u32 possible_max_rank;		/* possible max rank index */

Reviewed-by: Jeff Layton <jlayton@kernel.org>
