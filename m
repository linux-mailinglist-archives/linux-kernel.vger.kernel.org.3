Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBCF4DD8D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiCRLUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiCRLUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 428711F518A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647602351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UONd3q2YLgqxD2EnfqHD0wohIbn0VlIUvhSeKJBQ4Fc=;
        b=WGbZfPNSy8BhURATsJJzOGF0Y2v3s7NHRxtKhH8DlMn/AtGSanKDmS1NAfzZ4HxIGE0N1T
        LxRc5/O0hJwxR4E2+TaOi7cY6YgFPeHL1zxm71aaa06bc8rAjvpSrhq8jGfBwq84pIHW0Y
        T4tIdL/kduYvJKgUKuhxzfxTIH7htKs=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-bfev1T9vMMKS2WOH0jMVLA-1; Fri, 18 Mar 2022 07:19:10 -0400
X-MC-Unique: bfev1T9vMMKS2WOH0jMVLA-1
Received: by mail-pg1-f197.google.com with SMTP id r11-20020a63440b000000b0038068f34b0cso3247406pga.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UONd3q2YLgqxD2EnfqHD0wohIbn0VlIUvhSeKJBQ4Fc=;
        b=JU28cVfulX5aeMjGtW7C9bxuFmXKQMxCsNEGTFHrb16Q7acVsqqhM/9o5lkxti7Izs
         HgQhpibnTMRfje/1vkqk0unjZcS7tXAxXPzUQ8VJOnN24VlSam8xnZwDjSJofzrDmULf
         TE9HxSJXwd01mNlQ0yO3qWBkQOMv2PnXqiklLs/uGN+Ifm1I/ots9lRxdhXn/Ec9LRWf
         ByYSzQDlj/H9FH0WaizN9m3JatyldYYPGBJItK6TRYbGUXqmCu8N+ROmVpWguKHU0ClU
         PQ8fKAC1/U8YgQPesoKNE5oaWWA71yAlWGi0yq4zgxfBFDOrZpNrFm2ZVXHXpdrqgcfi
         eK4A==
X-Gm-Message-State: AOAM530N1wzzyARh/2C2f51CaEXswXa9y5C9qI1beBHFL9tBmQSoAhzM
        A5ir17ZiexARA4ljY1fbrWroPGDfjq3mH5bEUjR8EzAV8MMEJ/ny0DqQS2ETm7FRb3JQL4r0G3c
        kFP5KoHAQU7R0pzaJjV3G83zx3f3foL2MCRCendodEdwMxfNNY46JRT3mzRflzb7BXYQSTe54vw
        ==
X-Received: by 2002:a17:902:7c94:b0:14d:77d2:a72e with SMTP id y20-20020a1709027c9400b0014d77d2a72emr9388239pll.153.1647602348853;
        Fri, 18 Mar 2022 04:19:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp5h4hAsx/OHxaiUELO0PWpWNRgX5cpDI60S9o6Xeo6PJq4U+OSJbsbQwM4SQcHNnUhMFmnw==
X-Received: by 2002:a17:902:7c94:b0:14d:77d2:a72e with SMTP id y20-20020a1709027c9400b0014d77d2a72emr9388199pll.153.1647602348337;
        Fri, 18 Mar 2022 04:19:08 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g9-20020a056a0023c900b004f736d081d9sm9943297pfc.64.2022.03.18.04.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 04:19:06 -0700 (PDT)
Subject: Re: [RFC PATCH v3 2/4] ceph: handle encrypted snapshot names in
 subdirectories
To:     Jeff Layton <jlayton@kernel.org>,
        =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220317154521.6615-1-lhenriques@suse.de>
 <20220317154521.6615-3-lhenriques@suse.de>
 <61d831de-1589-3a19-8f46-a162099e75df@redhat.com>
 <6f7a8581c24b09c2fe7c167f68d0f9d12a0b1427.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <c54fade2-2532-b693-2d6f-44d990f477f1@redhat.com>
Date:   Fri, 18 Mar 2022 19:19:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <6f7a8581c24b09c2fe7c167f68d0f9d12a0b1427.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/18/22 5:57 PM, Jeff Layton wrote:
> On Fri, 2022-03-18 at 12:57 +0800, Xiubo Li wrote:
>> On 3/17/22 11:45 PM, Luís Henriques wrote:
>>> When creating a snapshot, the .snap directories for every subdirectory will
>>> show the snapshot name in the "long format":
>>>
>>>     # mkdir .snap/my-snap
>>>     # ls my-dir/.snap/
>>>     _my-snap_1099511627782
>>>
>>> Encrypted snapshots will need to be able to handle these snapshot names by
>>> encrypting/decrypting only the snapshot part of the string ('my-snap').
>>>
>>> Also, since the MDS prevents snapshot names to be bigger than 240 characters
>>> it is necessary to adapt CEPH_NOHASH_NAME_MAX to accommodate this extra
>>> limitation.
>>>
>>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>>> ---
>>>    fs/ceph/crypto.c | 189 ++++++++++++++++++++++++++++++++++++++++-------
>>>    fs/ceph/crypto.h |  11 ++-
>>>    2 files changed, 169 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>>> index beb73bbdd868..caa9863dee93 100644
>>> --- a/fs/ceph/crypto.c
>>> +++ b/fs/ceph/crypto.c
>>> @@ -128,16 +128,100 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_se
>>>    	swap(req->r_fscrypt_auth, as->fscrypt_auth);
>>>    }
>>>    
>>> -int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name, char *buf)
>>> +/*
>>> + * User-created snapshots can't start with '_'.  Snapshots that start with this
>>> + * character are special (hint: there aren't real snapshots) and use the
>>> + * following format:
>>> + *
>>> + *   _<SNAPSHOT-NAME>_<INODE-NUMBER>
>>> + *
>>> + * where:
>>> + *  - <SNAPSHOT-NAME> - the real snapshot name that may need to be decrypted,
>>> + *  - <INODE-NUMBER> - the inode number for the actual snapshot
>>> + *
>>> + * This function parses these snapshot names and returns the inode
>>> + * <INODE-NUMBER>.  'name_len' will also bet set with the <SNAPSHOT-NAME>
>>> + * length.
>>> + */
>>> +static struct inode *parse_longname(const struct inode *parent, const char *name,
>>> +				    int *name_len)
>>>    {
>>> +	struct inode *dir = NULL;
>>> +	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
>>> +	char *inode_number;
>>> +	char *name_end;
>>> +	int orig_len = *name_len;
>>> +	int ret = -EIO;
>>> +
>>> +	/* Skip initial '_' */
>>> +	name++;
>>> +	name_end = strrchr(name, '_');
>>> +	if (!name_end) {
>>> +		dout("Failed to parse long snapshot name: %s\n", name);
>>> +		return ERR_PTR(-EIO);
>>> +	}
>>> +	*name_len = (name_end - name);
>>> +	if (*name_len <= 0) {
>>> +		pr_err("Failed to parse long snapshot name\n");
>>> +		return ERR_PTR(-EIO);
>>> +	}
>>> +
>>> +	/* Get the inode number */
>>> +	inode_number = kmemdup_nul(name_end + 1,
>>> +				   orig_len - *name_len - 2,
>>> +				   GFP_KERNEL);
>>> +	if (!inode_number)
>>> +		return ERR_PTR(-ENOMEM);
>>> +	ret = kstrtou64(inode_number, 0, &vino.ino);
>>> +	if (ret) {
>>> +		dout("Failed to parse inode number: %s\n", name);
>>> +		dir = ERR_PTR(ret);
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* And finally the inode */
>>> +	dir = ceph_find_inode(parent->i_sb, vino);
>>> +	if (!dir) {
>>> +		/* This can happen if we're not mounting cephfs on the root */
>>> +		dir = ceph_get_inode(parent->i_sb, vino, NULL);
>> In this case IMO you should lookup the inode from MDS instead create it
>> in the cache, which won't setup the encryption info needed.
>>
>> So later when you try to use this to dencrypt the snapshot names, you
>> will hit errors ? And also the case Jeff mentioned in previous thread
>> could happen.
>>
>> I figured out another approach could resolve this more gracefully:
>>
>> For all the subdirs just let them inherit the encryption info from the
>> same ancestor, which is initially encrypted, then in ceph_new_inode()
>> you can just skip setting up the encryption info for all the subdirs and
>> in MDS side will send back the parent's encryption info and fill it in
>> handle_reply(), this is just what the .snap does.
>>
>> Then here you can use current inode to do the dencryption for all the
>> snapshots including the long snapshot names.
>>
>> I have raise one PR and send a kclient patch for the above basic
>> framework [1][2]. But there still need a little more work you need to do
>> based them:
>>
>> When lssnap you need to add one flag in LeaseStat to tell the kclient
>> whether the long snap names are encrypted, this is very easy in MDS
>> side. Then in kclient side you can just skip dencrypting the long snap
>> names which are from none-encyrpted parents and for all the other just
>> use current inode to do the dencryption. No need to search the parent
>> inodes for long snaps.
>>
>> And when lookuping a long snap name, which could be encyrpted and could
>> be not, then you need to parse the inode out and lookup the inode from
>> MDS if it does not exist in cache.
>>
>>
>> [1] https://github.com/ceph/ceph/pull/45516
>>
>> [2] https://patchwork.kernel.org/project/ceph-devel/list/?series=624492
>>
>
> So basically all directories and parents would share the same nonce?
>
> That doesn't sound very secure. Doing that for snapshots is one thing,
> but I think having a different nonce for each directories is generally a
> better outcome.
>
> Can we not just do this sort of inheritance for snapshot directories?

Yeah, this is just a proposal. Let's drop this.

- Xiubo


>
>>> +		if (!dir)
>>> +			dir = ERR_PTR(-ENOENT);
>>> +	}
>>> +	if (IS_ERR(dir))
>>> +		dout("Can't find inode %s (%s)\n", inode_number, name);
>>> +
>>> +out:
>>> +	kfree(inode_number);
>>> +	return dir;
>>> +}
>>> +
>>> +int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name, char *buf)
>>> +{
>>> +	struct inode *dir = parent;
>>> +	struct qstr iname;
>>>    	u32 len;
>>> +	int name_len;
>>>    	int elen;
>>>    	int ret;
>>> -	u8 *cryptbuf;
>>> +	u8 *cryptbuf = NULL;
>>> +
>>> +	iname.name = d_name->name;
>>> +	name_len = d_name->len;
>>> +
>>> +	/* Handle the special case of snapshot names that start with '_' */
>>> +	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name_len > 0) &&
>>> +	    (iname.name[0] == '_')) {
>>> +		dir = parse_longname(parent, iname.name, &name_len);
>>> +		if (IS_ERR(dir))
>>> +			return PTR_ERR(dir);
>>> +		iname.name++; /* skip initial '_' */
>>> +	}
>>> +	iname.len = name_len;
>>>    
>>> -	if (!fscrypt_has_encryption_key(parent)) {
>>> +	if (!fscrypt_has_encryption_key(dir)) {
>>>    		memcpy(buf, d_name->name, d_name->len);
>>> -		return d_name->len;
>>> +		elen = d_name->len;
>>> +		goto out;
>>>    	}
>>>    
>>>    	/*
>>> @@ -146,18 +230,22 @@ int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name,
>>>    	 *
>>>    	 * See: fscrypt_setup_filename
>>>    	 */
>>> -	if (!fscrypt_fname_encrypted_size(parent, d_name->len, NAME_MAX, &len))
>>> -		return -ENAMETOOLONG;
>>> +	if (!fscrypt_fname_encrypted_size(dir, iname.len, NAME_MAX, &len)) {
>>> +		elen = -ENAMETOOLONG;
>>> +		goto out;
>>> +	}
>>>    
>>>    	/* Allocate a buffer appropriate to hold the result */
>>>    	cryptbuf = kmalloc(len > CEPH_NOHASH_NAME_MAX ? NAME_MAX : len, GFP_KERNEL);
>>> -	if (!cryptbuf)
>>> -		return -ENOMEM;
>>> +	if (!cryptbuf) {
>>> +		elen = -ENOMEM;
>>> +		goto out;
>>> +	}
>>>    
>>> -	ret = fscrypt_fname_encrypt(parent, d_name, cryptbuf, len);
>>> +	ret = fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
>>>    	if (ret) {
>>> -		kfree(cryptbuf);
>>> -		return ret;
>>> +		elen = ret;
>>> +		goto out;
>>>    	}
>>>    
>>>    	/* hash the end if the name is long enough */
>>> @@ -173,12 +261,29 @@ int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name,
>>>    
>>>    	/* base64 encode the encrypted name */
>>>    	elen = fscrypt_base64url_encode(cryptbuf, len, buf);
>>> -	kfree(cryptbuf);
>>>    	dout("base64-encoded ciphertext name = %.*s\n", elen, buf);
>>> +
>>> +	WARN_ON(elen > (CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE));
>>> +	if ((elen > 0) && (dir != parent)) {
>>> +		char tmp_buf[NAME_MAX];
>>> +
>>> +		elen = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
>>> +				elen, buf, dir->i_ino);
>>> +		memcpy(buf, tmp_buf, elen);
>>> +	}
>>> +
>>> +out:
>>> +	kfree(cryptbuf);
>>> +	if (dir != parent) {
>>> +		if ((dir->i_state & I_NEW))
>>> +			discard_new_inode(dir);
>>> +		else
>>> +			iput(dir);
>>> +	}
>>>    	return elen;
>>>    }
>>>    
>>> -int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
>>> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry, char *buf)
>>>    {
>>>    	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
>>>    
>>> @@ -203,29 +308,42 @@ int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentr
>>>    int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>>>    		      struct fscrypt_str *oname, bool *is_nokey)
>>>    {
>>> -	int ret;
>>> +	struct inode *dir = fname->dir;
>>>    	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
>>>    	struct fscrypt_str iname;
>>> -
>>> -	if (!IS_ENCRYPTED(fname->dir)) {
>>> -		oname->name = fname->name;
>>> -		oname->len = fname->name_len;
>>> -		return 0;
>>> -	}
>>> +	char *name = fname->name;
>>> +	int name_len = fname->name_len;
>>> +	int ret;
>>>    
>>>    	/* Sanity check that the resulting name will fit in the buffer */
>>>    	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
>>>    		return -EIO;
>>>    
>>> -	ret = __fscrypt_prepare_readdir(fname->dir);
>>> +	/* Handle the special case of snapshot names that start with '_' */
>>> +	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name_len > 0) &&
>>> +	    (name[0] == '_')) {
>>> +		dir = parse_longname(dir, name, &name_len);
>>> +		if (IS_ERR(dir))
>>> +			return PTR_ERR(dir);
>>> +		name++; /* skip initial '_' */
>>> +	}
>>> +
>>> +	if (!IS_ENCRYPTED(dir)) {
>>> +		oname->name = fname->name;
>>> +		oname->len = fname->name_len;
>>> +		ret = 0;
>>> +		goto out_inode;
>>> +	}
>>> +
>>> +	ret = __fscrypt_prepare_readdir(dir);
>>>    	if (ret)
>>> -		return ret;
>>> +		goto out_inode;
>>>    
>>>    	/*
>>>    	 * Use the raw dentry name as sent by the MDS instead of
>>>    	 * generating a nokey name via fscrypt.
>>>    	 */
>>> -	if (!fscrypt_has_encryption_key(fname->dir)) {
>>> +	if (!fscrypt_has_encryption_key(dir)) {
>>>    		if (fname->no_copy)
>>>    			oname->name = fname->name;
>>>    		else
>>> @@ -233,7 +351,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>>>    		oname->len = fname->name_len;
>>>    		if (is_nokey)
>>>    			*is_nokey = true;
>>> -		return 0;
>>> +		ret = 0;
>>> +		goto out_inode;
>>>    	}
>>>    
>>>    	if (fname->ctext_len == 0) {
>>> @@ -242,11 +361,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>>>    		if (!tname) {
>>>    			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
>>>    			if (ret)
>>> -				return ret;
>>> +				goto out_inode;
>>>    			tname = &_tname;
>>>    		}
>>>    
>>> -		declen = fscrypt_base64url_decode(fname->name, fname->name_len, tname->name);
>>> +		declen = fscrypt_base64url_decode(name, name_len, tname->name);
>>>    		if (declen <= 0) {
>>>    			ret = -EIO;
>>>    			goto out;
>>> @@ -258,9 +377,25 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>>>    		iname.len = fname->ctext_len;
>>>    	}
>>>    
>>> -	ret = fscrypt_fname_disk_to_usr(fname->dir, 0, 0, &iname, oname);
>>> +	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
>>> +	if (!ret && (dir != fname->dir)) {
>>> +		char tmp_buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
>>> +
>>> +		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
>>> +				    oname->len, oname->name, dir->i_ino);
>>> +		memcpy(oname->name, tmp_buf, name_len);
>>> +		oname->len = name_len;
>>> +	}
>>> +
>>>    out:
>>>    	fscrypt_fname_free_buffer(&_tname);
>>> +out_inode:
>>> +	if ((dir != fname->dir) && !IS_ERR(dir)) {
>>> +		if ((dir->i_state & I_NEW))
>>> +			discard_new_inode(dir);
>>> +		else
>>> +			iput(dir);
>>> +	}
>>>    	return ret;
>>>    }
>>>    
>>> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
>>> index 62f0ddd30dee..3273d076a9e5 100644
>>> --- a/fs/ceph/crypto.h
>>> +++ b/fs/ceph/crypto.h
>>> @@ -82,13 +82,16 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
>>>     * struct fscrypt_ceph_nokey_name {
>>>     *	u8 bytes[157];
>>>     *	u8 sha256[SHA256_DIGEST_SIZE];
>>> - * }; // 189 bytes => 252 bytes base64-encoded, which is <= NAME_MAX (255)
>>> + * }; // 180 bytes => 240 bytes base64-encoded, which is <= NAME_MAX (255)
>>> + *
>>> + * (240 bytes is the maximum size allowed for snapshot names to take into
>>> + *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>'.)
>>>     *
>>>     * Note that for long names that end up having their tail portion hashed, we
>>>     * must also store the full encrypted name (in the dentry's alternate_name
>>>     * field).
>>>     */
>>> -#define CEPH_NOHASH_NAME_MAX (189 - SHA256_DIGEST_SIZE)
>>> +#define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
>>>    
>>>    void ceph_fscrypt_set_ops(struct super_block *sb);
>>>    
>>> @@ -97,8 +100,8 @@ void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
>>>    int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
>>>    				 struct ceph_acl_sec_ctx *as);
>>>    void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
>>> -int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name, char *buf);
>>> -int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf);
>>> +int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name, char *buf);
>>> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *dentry, char *buf);
>>>    
>>>    static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
>>>    {
>>>

