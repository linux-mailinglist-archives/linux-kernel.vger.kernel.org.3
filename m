Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437634D7DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiCNI4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiCNI4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C9BB21E0D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647248090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIJ/XdhiSHiz1Dwyti9r5Q5k2KkrWFb2HsslCKJ86nI=;
        b=TmxRPnfuM7UTkAGg6hsI7JD3IW8Rs6jYvTwJhVQuhaR11AC7WzObm43R/ddxN0Iy5mOY0k
        A1OeVXRM85pI54S3zv/lscS/HtwN/8WIIEU2yVTZiADoF6sOz6U4qNA+RC5bI8W1/1etnY
        pJP2/xj3DnrJmwf1nrHTzRXNnl/Tlqg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-Tye3AYCbPJ-rXXim-k3JqA-1; Mon, 14 Mar 2022 04:54:49 -0400
X-MC-Unique: Tye3AYCbPJ-rXXim-k3JqA-1
Received: by mail-pf1-f200.google.com with SMTP id l138-20020a628890000000b004f7cb47178cso1306458pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YIJ/XdhiSHiz1Dwyti9r5Q5k2KkrWFb2HsslCKJ86nI=;
        b=tYDmZPshUXPgIrQiiiLAGD2gQqh9iVk6S1mzkPvjdMqTvHdq/7paJy+jdInmHTUV0S
         moX80PlycnitMBZM1jG5QhoHVpuvC5MoHV+SeYY8RqkCTPZ8C1MEC298qtKy+oCMOFB+
         VKiej8LDZxWGX2iR9Nk7jYb07uIrZyBHv3tHEcWMgBh+d3KOL4qJZ9OZgj2j5M18rVZb
         zn9ZJqEDpO3sCcudgmvBiicOvvGTZwkUSu/ruyjdWhQmzFRBaOC+kOhEVuefTOt0eFBW
         dDKrGIKLnRlpP1jzor/SoCeSNl4Xf2/joYhUPD9133QOBjMIkut9Ud4arX5n9Caq2Asl
         gvwg==
X-Gm-Message-State: AOAM533PF5SxgJ5FdxbW3Dcr9KindpgAtD7ieX468EoPMXjyHaOV1v3z
        RXd0DvxVRxDd0t9klw+bH4ekSuF1xX9sM5kzMVUyfqTY02B7cVrQhgOOTV7bbgkP0XNCQgGpVIq
        Nr0hPXpWB6LLVOeID7RF9GmG+fbr5iHCEJEXlCreueoN01cO1NDcUG5FcFZVjc6njxRwigR5aKg
        ==
X-Received: by 2002:a17:902:d2d0:b0:151:a404:dee with SMTP id n16-20020a170902d2d000b00151a4040deemr22417476plc.74.1647248087425;
        Mon, 14 Mar 2022 01:54:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYlQzxs06DNBYKOJLwwa0UtFywmgUiWf9JkeDTBNjOva1utPBUzKlN654i2BQm1yG7Sc8PVg==
X-Received: by 2002:a17:902:d2d0:b0:151:a404:dee with SMTP id n16-20020a170902d2d000b00151a4040deemr22417449plc.74.1647248087006;
        Mon, 14 Mar 2022 01:54:47 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e18-20020a63d952000000b00372a1295210sm15732771pgj.51.2022.03.14.01.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 01:54:46 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] ceph: add support for handling encrypted snapshot
 names in subtree
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220310172616.16212-1-lhenriques@suse.de>
 <20220310172616.16212-3-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <cea390c2-9166-abac-0e1e-06c6b36ec62d@redhat.com>
Date:   Mon, 14 Mar 2022 16:54:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220310172616.16212-3-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/11/22 1:26 AM, Luís Henriques wrote:
> When creating a snapshot, the .snap directories for every subdirectory will
> show the snapshot name in the "long format":
>
>    # mkdir .snap/my-snap
>    # ls my-dir/.snap/
>    _my-snap_1099511627782
>
> Encrypted snapshots will need to be able to handle these snapshot names by
> encrypting/decrypting only the snapshot part of the string ('my-snap').
>
> Also, since the MDS prevents snapshot names to be bigger than 240 characters
> it is necessary to adapt CEPH_NOHASH_NAME_MAX to accommodate this extra
> limitation.

Maybe we should update this info in Documentation/filesystems/ceph.rst.

- Xiubo


>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   fs/ceph/crypto.c | 146 +++++++++++++++++++++++++++++++++++++++++------
>   fs/ceph/crypto.h |   9 ++-
>   2 files changed, 134 insertions(+), 21 deletions(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index 5a87e7385d3f..e315e3650ea7 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -128,15 +128,89 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_se
>   	swap(req->r_fscrypt_auth, as->fscrypt_auth);
>   }
>   
> -int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
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
> + *
> + * This function parses these snapshot names and returns the inode
> + * <INODE-NUMBER>.  'name_len' will also bet set with the <SNAPSHOT-NAME>
> + * length.
> + */
> +static struct inode *parse_longname(const struct inode *parent, const char *name,
> +				    int *name_len)
> +{
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
> +	/* Get the inode number */
> +	inode_number = kmemdup_nul(name_end + 1,
> +				   orig_len - *name_len - 2,
> +				   GFP_KERNEL);
> +	if (!inode_number)
> +		return ERR_PTR(-ENOMEM);
> +	ret = kstrtou64(inode_number, 0, &vino.ino);
> +	if (ret) {
> +		dout("Failed to parse inode number: %s\n", name);
> +		dir = ERR_PTR(ret);
> +		goto out;
> +	}
> +	/* And finally the inode */
> +	dir = ceph_get_inode(parent->i_sb, vino, NULL);
> +	if (IS_ERR(dir))
> +		dout("Can't find inode %s (%s)\n", inode_number, name);
> +
> +out:
> +	kfree(inode_number);
> +	return dir;
> +}
> +
> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry, char *buf)
>   {
> +	struct inode *dir = parent;
> +	struct qstr iname;
> +	int name_len = dentry->d_name.len;
>   	u32 len;
>   	int elen;
>   	int ret;
> -	u8 *cryptbuf;
> +	u8 *cryptbuf = NULL;
>   
>   	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
>   
> +	iname.name = dentry->d_name.name;
> +	iname.len = dentry->d_name.len;
> +
> +	/* Handle the special case of snapshot names that start with '_' */
> +	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (iname.name[0] == '_')) {
> +		dir = parse_longname(parent, iname.name, &name_len);
> +		if (IS_ERR(dir))
> +			return PTR_ERR(dir);
> +		iname.name++; /* skip initial '_' */
> +		iname.len = name_len;
> +	}
> +
>   	/*
>   	 * convert cleartext dentry name to ciphertext
>   	 * if result is longer than CEPH_NOKEY_NAME_MAX,
> @@ -144,18 +218,22 @@ int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentr
>   	 *
>   	 * See: fscrypt_setup_filename
>   	 */
> -	if (!fscrypt_fname_encrypted_size(parent, dentry->d_name.len, NAME_MAX, &len))
> -		return -ENAMETOOLONG;
> +	if (!fscrypt_fname_encrypted_size(dir, iname.len, NAME_MAX, &len)) {
> +		elen = -ENAMETOOLONG;
> +		goto out;
> +	}
>   
>   	/* Allocate a buffer appropriate to hold the result */
>   	cryptbuf = kmalloc(len > CEPH_NOHASH_NAME_MAX ? NAME_MAX : len, GFP_KERNEL);
> -	if (!cryptbuf)
> -		return -ENOMEM;
> +	if (!cryptbuf) {
> +		elen = -ENOMEM;
> +		goto out;
> +	}
>   
> -	ret = fscrypt_fname_encrypt(parent, &dentry->d_name, cryptbuf, len);
> +	ret = fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
>   	if (ret) {
> -		kfree(cryptbuf);
> -		return ret;
> +		elen = ret;
> +		goto out;
>   	}
>   
>   	/* hash the end if the name is long enough */
> @@ -171,8 +249,18 @@ int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentr
>   
>   	/* base64 encode the encrypted name */
>   	elen = fscrypt_base64url_encode(cryptbuf, len, buf);
> -	kfree(cryptbuf);
>   	dout("base64-encoded ciphertext name = %.*s\n", elen, buf);
> +	if ((elen > 0) && (dir != parent)) {
> +		char tmp_buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
> +
> +		elen = sprintf(tmp_buf, "_%.*s_%ld", elen, buf, dir->i_ino);
> +		memcpy(buf, tmp_buf, elen);
> +	}
> +out:
> +	kfree(cryptbuf);
> +	if (dir != parent)
> +		iput(dir);
> +
>   	return elen;
>   }
>   
> @@ -197,8 +285,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   	int ret;
>   	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
>   	struct fscrypt_str iname;
> +	struct inode *dir = fname->dir;
> +	char *name = fname->name;
> +	int name_len = fname->name_len;
>   
> -	if (!IS_ENCRYPTED(fname->dir)) {
> +	if (!IS_ENCRYPTED(dir)) {
>   		oname->name = fname->name;
>   		oname->len = fname->name_len;
>   		return 0;
> @@ -208,20 +299,29 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   	if (fname->name_len > FSCRYPT_BASE64URL_CHARS(NAME_MAX))
>   		return -EIO;
>   
> -	ret = __fscrypt_prepare_readdir(fname->dir);
> +	/* Handle the special case of snapshot names that start with '_' */
> +	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name[0] == '_')) {
> +		dir = parse_longname(dir, name, &name_len);
> +		if (IS_ERR(dir))
> +			return PTR_ERR(dir);
> +		name++; /* skip '_' */
> +	}
> +
> +	ret = __fscrypt_prepare_readdir(dir);
>   	if (ret)
> -		return ret;
> +		goto out_inode;
>   
>   	/*
>   	 * Use the raw dentry name as sent by the MDS instead of
>   	 * generating a nokey name via fscrypt.
>   	 */
> -	if (!fscrypt_has_encryption_key(fname->dir)) {
> +	if (!fscrypt_has_encryption_key(dir)) {
>   		memcpy(oname->name, fname->name, fname->name_len);
>   		oname->len = fname->name_len;
>   		if (is_nokey)
>   			*is_nokey = true;
> -		return 0;
> +		ret = 0;
> +		goto out_inode;
>   	}
>   
>   	if (fname->ctext_len == 0) {
> @@ -230,11 +330,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   		if (!tname) {
>   			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
>   			if (ret)
> -				return ret;
> +				goto out_inode;
>   			tname = &_tname;
>   		}
>   
> -		declen = fscrypt_base64url_decode(fname->name, fname->name_len, tname->name);
> +		declen = fscrypt_base64url_decode(name, name_len, tname->name);
>   		if (declen <= 0) {
>   			ret = -EIO;
>   			goto out;
> @@ -246,9 +346,19 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   		iname.len = fname->ctext_len;
>   	}
>   
> -	ret = fscrypt_fname_disk_to_usr(fname->dir, 0, 0, &iname, oname);
> +	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
> +	if (!ret && (dir != fname->dir)) {
> +		name_len = snprintf(tname->name, tname->len, "_%.*s_%ld",
> +				    oname->len, oname->name,
> +				    dir->i_ino);
> +		memcpy(oname->name, tname->name, name_len);
> +		oname->len = name_len;
> +	}
>   out:
>   	fscrypt_fname_free_buffer(&_tname);
> +out_inode:
> +	if ((dir != fname->dir) && !IS_ERR(dir))
> +		iput(dir);
>   	return ret;
>   }
>   
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index 1e08f8a64ad6..189af2404165 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -75,13 +75,16 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
>    * smaller size. If the ciphertext name is longer than the value below, then
>    * sha256 hash the remaining bytes.
>    *
> - * 189 bytes => 252 bytes base64-encoded, which is <= NAME_MAX (255)
> + * 180 bytes => 240 bytes base64-encoded, which is <= NAME_MAX (255)
> + *
> + * (Note: 240 bytes is the maximum size allowed for snapshot names to take into
> + *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>')
>    *
>    * Note that for long names that end up having their tail portion hashed, we
>    * must also store the full encrypted name (in the dentry's alternate_name
>    * field).
>    */
> -#define CEPH_NOHASH_NAME_MAX (189 - SHA256_DIGEST_SIZE)
> +#define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
>   
>   void ceph_fscrypt_set_ops(struct super_block *sb);
>   
> @@ -90,7 +93,7 @@ void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
>   int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
>   				 struct ceph_acl_sec_ctx *as);
>   void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
> -int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf);
> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry, char *buf);
>   
>   static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
>   {
>

