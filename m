Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5635055D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbiDRN2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 09:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbiDRNEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:04:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BCE13D19;
        Mon, 18 Apr 2022 05:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A4AAB80E59;
        Mon, 18 Apr 2022 12:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FE3C385A8;
        Mon, 18 Apr 2022 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650285928;
        bh=/tDM/kOeKnby+LKl2/CAtexYHHtPR60+MU4vvJhb8Ko=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FaBbs1vwAw8T8Gk+3hGOMiB/Gdca8mEpGMicgFL7KgwPp1hGOC3EbHMZSrPGylKHm
         1eOLqWubn1kv5D0XsiyGfj8NjBoADzelPy4GZWAqgwUQWWbLbWJ8JS0D9/wLMxIHL6
         V208HWn4/WGbi1WyfL7qsAYxU93M4en98ysq8ALT/9XsU56XGDKmBr7Zn8Kd7IveFR
         js9DgNbj5+LVcs2NTGGQVS5ocmWx6Pw1lG3X1jRXZw0NMX27GCn7F5pmHcJiutnsIK
         OPOy89ADpdlpHHBcO5PWhIp8lP9BYOSvc4ozDqId8nIylgpxUucOt0oNjE43VNTxIP
         tNnUrLgXj+ddA==
Message-ID: <e96e36b62c5bfeeda567630c2256cf8ffb0de476.camel@kernel.org>
Subject: Re: [PATCH v4 2/4] ceph: add support for handling encrypted
 snapshot names
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Apr 2022 08:45:26 -0400
In-Reply-To: <20220414135122.26821-3-lhenriques@suse.de>
References: <20220414135122.26821-1-lhenriques@suse.de>
         <20220414135122.26821-3-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-14 at 14:51 +0100, Luís Henriques wrote:
> When creating a snapshot, the .snap directories for every subdirectory will
> show the snapshot name in the "long format":
> 
>   # mkdir .snap/my-snap
>   # ls my-dir/.snap/
>   _my-snap_1099511627782
> 
> Encrypted snapshots will need to be able to handle these snapshot names by
> encrypting/decrypting only the snapshot part of the string ('my-snap').
> 
> Also, since the MDS prevents snapshot names to be bigger than 240 characters
> it is necessary to adapt CEPH_NOHASH_NAME_MAX to accommodate this extra
> limitation.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/crypto.c | 190 ++++++++++++++++++++++++++++++++++++++++-------
>  fs/ceph/crypto.h |  11 ++-
>  2 files changed, 170 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index e24e61c51118..1fa9dd634a6f 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -129,16 +129,100 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_se
>  	swap(req->r_fscrypt_auth, as->fscrypt_auth);
>  }
>  
> -int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name, char *buf)
> +/*
> + * User-created snapshots can't start with '_'.  Snapshots that start with this
> + * character are special (hint: there aren't real snapshots) and use the
> + * following format:
> + *
> + *   _<SNAPSHOT-NAME>_<INODE-NUMBER>
> + *
> + * where:
> + *  - <SNAPSHOT-NAME> - the real snapshot name that may need to be decrypted,
> + *  - <INODE-NUMBER> - the inode number for the actual snapshot

Maybe specify the base here as well? Is the number in decimal or hex?

> + *
> + * This function parses these snapshot names and returns the inode
> + * <INODE-NUMBER>.  'name_len' will also bet set with the <SNAPSHOT-NAME>
> + * length.
> + */
> +static struct inode *parse_longname(const struct inode *parent, const char *name,
> +				    int *name_len)
>  {
> +	struct inode *dir = NULL;
> +	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
> +	char *inode_number;
> +	char *name_end;
> +	int orig_len = *name_len;
> +	int ret = -EIO;
> +
> +	/* Skip initial '_' */
> +	name++;
> +	name_end = strrchr(name, '_');
> +	if (!name_end) {
> +		dout("Failed to parse long snapshot name: %s\n", name);
> +		return ERR_PTR(-EIO);
> +	}
> +	*name_len = (name_end - name);
> +	if (*name_len <= 0) {
> +		pr_err("Failed to parse long snapshot name\n");
> +		return ERR_PTR(-EIO);
> +	}
> +
> +	/* Get the inode number */
> +	inode_number = kmemdup_nul(name_end + 1,
> +				   orig_len - *name_len - 2,
> +				   GFP_KERNEL);
> +	if (!inode_number)
> +		return ERR_PTR(-ENOMEM);
> +	ret = kstrtou64(inode_number, 0, &vino.ino);

You're using 0 as the base here. Are these numbers encoded in decimal or
hex? If decimal, then this is probably safe enough. If it's in hex
though, then this could be problematic if you get a value that is
composed of only '0'-'9' characters.

It'd probably be best to use an explicit base here either way since we
presumably know how it should be encoded.

> +	if (ret) {
> +		dout("Failed to parse inode number: %s\n", name);
> +		dir = ERR_PTR(ret);
> +		goto out;
> +	}
> +
> +	/* And finally the inode */
> +	dir = ceph_find_inode(parent->i_sb, vino);
> +	if (!dir) {
> +		/* This can happen if we're not mounting cephfs on the root */
> +		dir = ceph_get_inode(parent->i_sb, vino, NULL);
> +		if (!dir)
> +			dir = ERR_PTR(-ENOENT);
> +	}
> +	if (IS_ERR(dir))
> +		dout("Can't find inode %s (%s)\n", inode_number, name);
> +
> +out:
> +	kfree(inode_number);
> +	return dir;
> +}
> +
> +int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name, char *buf)
> +{
> +	struct inode *dir = parent;
> +	struct qstr iname;
>  	u32 len;
> +	int name_len;
>  	int elen;
>  	int ret;
> -	u8 *cryptbuf;
> +	u8 *cryptbuf = NULL;
> +
> +	iname.name = d_name->name;
> +	name_len = d_name->len;
> +
> +	/* Handle the special case of snapshot names that start with '_' */
> +	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name_len > 0) &&
> +	    (iname.name[0] == '_')) {
> +		dir = parse_longname(parent, iname.name, &name_len);
> +		if (IS_ERR(dir))
> +			return PTR_ERR(dir);
> +		iname.name++; /* skip initial '_' */
> +	}
> +	iname.len = name_len;
>  
> -	if (!fscrypt_has_encryption_key(parent)) {
> +	if (!fscrypt_has_encryption_key(dir)) {
>  		memcpy(buf, d_name->name, d_name->len);
> -		return d_name->len;
> +		elen = d_name->len;
> +		goto out;
>  	}
>  
>  	/*
> @@ -147,18 +231,22 @@ int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name,
>  	 *
>  	 * See: fscrypt_setup_filename
>  	 */
> -	if (!fscrypt_fname_encrypted_size(parent, d_name->len, NAME_MAX, &len))
> -		return -ENAMETOOLONG;
> +	if (!fscrypt_fname_encrypted_size(dir, iname.len, NAME_MAX, &len)) {
> +		elen = -ENAMETOOLONG;
> +		goto out;
> +	}
>  
>  	/* Allocate a buffer appropriate to hold the result */
>  	cryptbuf = kmalloc(len > CEPH_NOHASH_NAME_MAX ? NAME_MAX : len, GFP_KERNEL);
> -	if (!cryptbuf)
> -		return -ENOMEM;
> +	if (!cryptbuf) {
> +		elen = -ENOMEM;
> +		goto out;
> +	}
>  
> -	ret = fscrypt_fname_encrypt(parent, d_name, cryptbuf, len);
> +	ret = fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
>  	if (ret) {
> -		kfree(cryptbuf);
> -		return ret;
> +		elen = ret;
> +		goto out;
>  	}
>  
>  	/* hash the end if the name is long enough */
> @@ -174,12 +262,30 @@ int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name,
>  
>  	/* base64 encode the encrypted name */
>  	elen = fscrypt_base64url_encode(cryptbuf, len, buf);
> -	kfree(cryptbuf);
>  	dout("base64-encoded ciphertext name = %.*s\n", elen, buf);
> +
> +	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
> +	WARN_ON(elen > 240);
> +	if ((elen > 0) && (dir != parent)) {
> +		char tmp_buf[NAME_MAX];
> +
> +		elen = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
> +				elen, buf, dir->i_ino);
> +		memcpy(buf, tmp_buf, elen);
> +	}
> +
> +out:
> +	kfree(cryptbuf);
> +	if (dir != parent) {
> +		if ((dir->i_state & I_NEW))
> +			discard_new_inode(dir);
> +		else
> +			iput(dir);
> +	}
>  	return elen;
>  }
>  
> -int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry, char *buf)
>  {
>  	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
>  
> @@ -204,29 +310,42 @@ int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentr
>  int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>  		      struct fscrypt_str *oname, bool *is_nokey)
>  {
> -	int ret;
> +	struct inode *dir = fname->dir;
>  	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
>  	struct fscrypt_str iname;
> -
> -	if (!IS_ENCRYPTED(fname->dir)) {
> -		oname->name = fname->name;
> -		oname->len = fname->name_len;
> -		return 0;
> -	}
> +	char *name = fname->name;
> +	int name_len = fname->name_len;
> +	int ret;
>  
>  	/* Sanity check that the resulting name will fit in the buffer */
>  	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
>  		return -EIO;
>  
> -	ret = __fscrypt_prepare_readdir(fname->dir);
> +	/* Handle the special case of snapshot names that start with '_' */
> +	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name_len > 0) &&
> +	    (name[0] == '_')) {
> +		dir = parse_longname(dir, name, &name_len);
> +		if (IS_ERR(dir))
> +			return PTR_ERR(dir);
> +		name++; /* skip initial '_' */
> +	}
> +
> +	if (!IS_ENCRYPTED(dir)) {
> +		oname->name = fname->name;
> +		oname->len = fname->name_len;
> +		ret = 0;
> +		goto out_inode;
> +	}
> +
> +	ret = __fscrypt_prepare_readdir(dir);
>  	if (ret)
> -		return ret;
> +		goto out_inode;
>  
>  	/*
>  	 * Use the raw dentry name as sent by the MDS instead of
>  	 * generating a nokey name via fscrypt.
>  	 */
> -	if (!fscrypt_has_encryption_key(fname->dir)) {
> +	if (!fscrypt_has_encryption_key(dir)) {
>  		if (fname->no_copy)
>  			oname->name = fname->name;
>  		else
> @@ -234,7 +353,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>  		oname->len = fname->name_len;
>  		if (is_nokey)
>  			*is_nokey = true;
> -		return 0;
> +		ret = 0;
> +		goto out_inode;
>  	}
>  
>  	if (fname->ctext_len == 0) {
> @@ -243,11 +363,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>  		if (!tname) {
>  			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
>  			if (ret)
> -				return ret;
> +				goto out_inode;
>  			tname = &_tname;
>  		}
>  
> -		declen = fscrypt_base64url_decode(fname->name, fname->name_len, tname->name);
> +		declen = fscrypt_base64url_decode(name, name_len, tname->name);
>  		if (declen <= 0) {
>  			ret = -EIO;
>  			goto out;
> @@ -259,9 +379,25 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>  		iname.len = fname->ctext_len;
>  	}
>  
> -	ret = fscrypt_fname_disk_to_usr(fname->dir, 0, 0, &iname, oname);
> +	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
> +	if (!ret && (dir != fname->dir)) {
> +		char tmp_buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
> +
> +		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
> +				    oname->len, oname->name, dir->i_ino);
> +		memcpy(oname->name, tmp_buf, name_len);
> +		oname->len = name_len;
> +	}
> +
>  out:
>  	fscrypt_fname_free_buffer(&_tname);
> +out_inode:
> +	if ((dir != fname->dir) && !IS_ERR(dir)) {
> +		if ((dir->i_state & I_NEW))
> +			discard_new_inode(dir);
> +		else
> +			iput(dir);
> +	}
>  	return ret;
>  }
>  
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index 0cf526f07567..0e10f934af5c 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -78,13 +78,16 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
>   * struct fscrypt_ceph_nokey_name {
>   *	u8 bytes[157];
>   *	u8 sha256[SHA256_DIGEST_SIZE];
> - * }; // 189 bytes => 252 bytes base64-encoded, which is <= NAME_MAX (255)
> + * }; // 180 bytes => 240 bytes base64-encoded, which is <= NAME_MAX (255)
> + *
> + * (240 bytes is the maximum size allowed for snapshot names to take into
> + *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>'.)
>   *
>   * Note that for long names that end up having their tail portion hashed, we
>   * must also store the full encrypted name (in the dentry's alternate_name
>   * field).
>   */
> -#define CEPH_NOHASH_NAME_MAX (189 - SHA256_DIGEST_SIZE)
> +#define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
>  
>  void ceph_fscrypt_set_ops(struct super_block *sb);
>  
> @@ -93,8 +96,8 @@ void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
>  int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
>  				 struct ceph_acl_sec_ctx *as);
>  void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
> -int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name, char *buf);
> -int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf);
> +int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name, char *buf);
> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry, char *buf);
>  
>  static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
>  {

-- 
Jeff Layton <jlayton@kernel.org>
