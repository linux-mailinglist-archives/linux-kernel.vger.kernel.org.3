Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2534D8061
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiCNLJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiCNLJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:09:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41545261D;
        Mon, 14 Mar 2022 04:08:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFF071F37E;
        Mon, 14 Mar 2022 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647256117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi7SZjSI36nXBHnNoVmANTe9vus9riVYEtxAsTixiYw=;
        b=xPh8+W3RAYtEmKy3t1boNjT+GhSdztl8poE1P/x4RlKw6VOL7XJ92KI0QPz2FGv1LNYi5C
        f1TVTCC/3myfkeQiMM5JMuz3G5CRsk1JgoqdaJ53KyKpA9HSzmvpc8zPi3N1fmHqGKScLN
        OESZxG9jfBLhFmpqhqKpljjv5p+cV6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647256117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi7SZjSI36nXBHnNoVmANTe9vus9riVYEtxAsTixiYw=;
        b=3+bPm7u/E+ZMpEjaardHKSt7lOop0HnOOHe7ft1TDsk/LGjvK9XRtl3zKXNJmaUp+Pa0N1
        Dz3kmkzYwKEhcnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A77113ADA;
        Mon, 14 Mar 2022 11:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3S/2IjUiL2KkGgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 14 Mar 2022 11:08:37 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id bda6b5b1;
        Mon, 14 Mar 2022 11:08:55 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] ceph: add support for handling encrypted
 snapshot names in subtree
References: <20220310172616.16212-1-lhenriques@suse.de>
        <20220310172616.16212-3-lhenriques@suse.de>
        <cea390c2-9166-abac-0e1e-06c6b36ec62d@redhat.com>
Date:   Mon, 14 Mar 2022 11:08:55 +0000
In-Reply-To: <cea390c2-9166-abac-0e1e-06c6b36ec62d@redhat.com> (Xiubo Li's
        message of "Mon, 14 Mar 2022 16:54:40 +0800")
Message-ID: <87sfrk94fs.fsf@brahms.olymp>
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

Xiubo Li <xiubli@redhat.com> writes:

> On 3/11/22 1:26 AM, Lu=C3=ADs Henriques wrote:
>> When creating a snapshot, the .snap directories for every subdirectory w=
ill
>> show the snapshot name in the "long format":
>>
>>    # mkdir .snap/my-snap
>>    # ls my-dir/.snap/
>>    _my-snap_1099511627782
>>
>> Encrypted snapshots will need to be able to handle these snapshot names =
by
>> encrypting/decrypting only the snapshot part of the string ('my-snap').
>>
>> Also, since the MDS prevents snapshot names to be bigger than 240 charac=
ters
>> it is necessary to adapt CEPH_NOHASH_NAME_MAX to accommodate this extra
>> limitation.
>
> Maybe we should update this info in Documentation/filesystems/ceph.rst.

Yep, sure.  This definitely needs to be documented somewhere.

Cheers,
--=20
Lu=C3=ADs

>
> - Xiubo
>
>
>>
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>   fs/ceph/crypto.c | 146 +++++++++++++++++++++++++++++++++++++++++------
>>   fs/ceph/crypto.h |   9 ++-
>>   2 files changed, 134 insertions(+), 21 deletions(-)
>>
>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> index 5a87e7385d3f..e315e3650ea7 100644
>> --- a/fs/ceph/crypto.c
>> +++ b/fs/ceph/crypto.c
>> @@ -128,15 +128,89 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_re=
quest *req, struct ceph_acl_se
>>   	swap(req->r_fscrypt_auth, as->fscrypt_auth);
>>   }
>>   -int ceph_encode_encrypted_fname(const struct inode *parent, struct de=
ntry
>> *dentry, char *buf)
>> +/*
>> + * User-created snapshots can't start with '_'.  Snapshots that start w=
ith this
>> + * character are special (hint: there aren't real snapshots) and use the
>> + * following format:
>> + *
>> + *   _<SNAPSHOT-NAME>_<INODE-NUMBER>
>> + *
>> + * where:
>> + *  - <SNAPSHOT-NAME> - the real snapshot name that may need to be decr=
ypted,
>> + *  - <INODE-NUMBER> - the inode number for the actual snapshot
>> + *
>> + * This function parses these snapshot names and returns the inode
>> + * <INODE-NUMBER>.  'name_len' will also bet set with the <SNAPSHOT-NAM=
E>
>> + * length.
>> + */
>> +static struct inode *parse_longname(const struct inode *parent, const c=
har *name,
>> +				    int *name_len)
>> +{
>> +	struct inode *dir =3D NULL;
>> +	struct ceph_vino vino =3D { .snap =3D CEPH_NOSNAP };
>> +	char *inode_number;
>> +	char *name_end;
>> +	int orig_len =3D *name_len;
>> +	int ret =3D -EIO;
>> +
>> +	/* Skip initial '_' */
>> +	name++;
>> +	name_end =3D strrchr(name, '_');
>> +	if (!name_end) {
>> +		dout("Failed to parse long snapshot name: %s\n", name);
>> +		return ERR_PTR(-EIO);
>> +	}
>> +	*name_len =3D (name_end - name);
>> +	if (*name_len <=3D 0) {
>> +		pr_err("Failed to parse long snapshot name\n");
>> +		return ERR_PTR(-EIO);
>> +	}
>> +	/* Get the inode number */
>> +	inode_number =3D kmemdup_nul(name_end + 1,
>> +				   orig_len - *name_len - 2,
>> +				   GFP_KERNEL);
>> +	if (!inode_number)
>> +		return ERR_PTR(-ENOMEM);
>> +	ret =3D kstrtou64(inode_number, 0, &vino.ino);
>> +	if (ret) {
>> +		dout("Failed to parse inode number: %s\n", name);
>> +		dir =3D ERR_PTR(ret);
>> +		goto out;
>> +	}
>> +	/* And finally the inode */
>> +	dir =3D ceph_get_inode(parent->i_sb, vino, NULL);
>> +	if (IS_ERR(dir))
>> +		dout("Can't find inode %s (%s)\n", inode_number, name);
>> +
>> +out:
>> +	kfree(inode_number);
>> +	return dir;
>> +}
>> +
>> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *de=
ntry, char *buf)
>>   {
>> +	struct inode *dir =3D parent;
>> +	struct qstr iname;
>> +	int name_len =3D dentry->d_name.len;
>>   	u32 len;
>>   	int elen;
>>   	int ret;
>> -	u8 *cryptbuf;
>> +	u8 *cryptbuf =3D NULL;
>>     	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
>>   +	iname.name =3D dentry->d_name.name;
>> +	iname.len =3D dentry->d_name.len;
>> +
>> +	/* Handle the special case of snapshot names that start with '_' */
>> +	if ((ceph_snap(dir) =3D=3D CEPH_SNAPDIR) && (iname.name[0] =3D=3D '_')=
) {
>> +		dir =3D parse_longname(parent, iname.name, &name_len);
>> +		if (IS_ERR(dir))
>> +			return PTR_ERR(dir);
>> +		iname.name++; /* skip initial '_' */
>> +		iname.len =3D name_len;
>> +	}
>> +
>>   	/*
>>   	 * convert cleartext dentry name to ciphertext
>>   	 * if result is longer than CEPH_NOKEY_NAME_MAX,
>> @@ -144,18 +218,22 @@ int ceph_encode_encrypted_fname(const struct inode=
 *parent, struct dentry *dentr
>>   	 *
>>   	 * See: fscrypt_setup_filename
>>   	 */
>> -	if (!fscrypt_fname_encrypted_size(parent, dentry->d_name.len, NAME_MAX=
, &len))
>> -		return -ENAMETOOLONG;
>> +	if (!fscrypt_fname_encrypted_size(dir, iname.len, NAME_MAX, &len)) {
>> +		elen =3D -ENAMETOOLONG;
>> +		goto out;
>> +	}
>>     	/* Allocate a buffer appropriate to hold the result */
>>   	cryptbuf =3D kmalloc(len > CEPH_NOHASH_NAME_MAX ? NAME_MAX : len, GFP=
_KERNEL);
>> -	if (!cryptbuf)
>> -		return -ENOMEM;
>> +	if (!cryptbuf) {
>> +		elen =3D -ENOMEM;
>> +		goto out;
>> +	}
>>   -	ret =3D fscrypt_fname_encrypt(parent, &dentry->d_name, cryptbuf, len=
);
>> +	ret =3D fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
>>   	if (ret) {
>> -		kfree(cryptbuf);
>> -		return ret;
>> +		elen =3D ret;
>> +		goto out;
>>   	}
>>     	/* hash the end if the name is long enough */
>> @@ -171,8 +249,18 @@ int ceph_encode_encrypted_fname(const struct inode =
*parent, struct dentry *dentr
>>     	/* base64 encode the encrypted name */
>>   	elen =3D fscrypt_base64url_encode(cryptbuf, len, buf);
>> -	kfree(cryptbuf);
>>   	dout("base64-encoded ciphertext name =3D %.*s\n", elen, buf);
>> +	if ((elen > 0) && (dir !=3D parent)) {
>> +		char tmp_buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
>> +
>> +		elen =3D sprintf(tmp_buf, "_%.*s_%ld", elen, buf, dir->i_ino);
>> +		memcpy(buf, tmp_buf, elen);
>> +	}
>> +out:
>> +	kfree(cryptbuf);
>> +	if (dir !=3D parent)
>> +		iput(dir);
>> +
>>   	return elen;
>>   }
>>   @@ -197,8 +285,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fn=
ame,
>> struct fscrypt_str *tname,
>>   	int ret;
>>   	struct fscrypt_str _tname =3D FSTR_INIT(NULL, 0);
>>   	struct fscrypt_str iname;
>> +	struct inode *dir =3D fname->dir;
>> +	char *name =3D fname->name;
>> +	int name_len =3D fname->name_len;
>>   -	if (!IS_ENCRYPTED(fname->dir)) {
>> +	if (!IS_ENCRYPTED(dir)) {
>>   		oname->name =3D fname->name;
>>   		oname->len =3D fname->name_len;
>>   		return 0;
>> @@ -208,20 +299,29 @@ int ceph_fname_to_usr(const struct ceph_fname *fna=
me, struct fscrypt_str *tname,
>>   	if (fname->name_len > FSCRYPT_BASE64URL_CHARS(NAME_MAX))
>>   		return -EIO;
>>   -	ret =3D __fscrypt_prepare_readdir(fname->dir);
>> +	/* Handle the special case of snapshot names that start with '_' */
>> +	if ((ceph_snap(dir) =3D=3D CEPH_SNAPDIR) && (name[0] =3D=3D '_')) {
>> +		dir =3D parse_longname(dir, name, &name_len);
>> +		if (IS_ERR(dir))
>> +			return PTR_ERR(dir);
>> +		name++; /* skip '_' */
>> +	}
>> +
>> +	ret =3D __fscrypt_prepare_readdir(dir);
>>   	if (ret)
>> -		return ret;
>> +		goto out_inode;
>>     	/*
>>   	 * Use the raw dentry name as sent by the MDS instead of
>>   	 * generating a nokey name via fscrypt.
>>   	 */
>> -	if (!fscrypt_has_encryption_key(fname->dir)) {
>> +	if (!fscrypt_has_encryption_key(dir)) {
>>   		memcpy(oname->name, fname->name, fname->name_len);
>>   		oname->len =3D fname->name_len;
>>   		if (is_nokey)
>>   			*is_nokey =3D true;
>> -		return 0;
>> +		ret =3D 0;
>> +		goto out_inode;
>>   	}
>>     	if (fname->ctext_len =3D=3D 0) {
>> @@ -230,11 +330,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fna=
me, struct fscrypt_str *tname,
>>   		if (!tname) {
>>   			ret =3D fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
>>   			if (ret)
>> -				return ret;
>> +				goto out_inode;
>>   			tname =3D &_tname;
>>   		}
>>   -		declen =3D fscrypt_base64url_decode(fname->name, fname->name_len,
>> tname->name);
>> +		declen =3D fscrypt_base64url_decode(name, name_len, tname->name);
>>   		if (declen <=3D 0) {
>>   			ret =3D -EIO;
>>   			goto out;
>> @@ -246,9 +346,19 @@ int ceph_fname_to_usr(const struct ceph_fname *fnam=
e, struct fscrypt_str *tname,
>>   		iname.len =3D fname->ctext_len;
>>   	}
>>   -	ret =3D fscrypt_fname_disk_to_usr(fname->dir, 0, 0, &iname, oname);
>> +	ret =3D fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
>> +	if (!ret && (dir !=3D fname->dir)) {
>> +		name_len =3D snprintf(tname->name, tname->len, "_%.*s_%ld",
>> +				    oname->len, oname->name,
>> +				    dir->i_ino);
>> +		memcpy(oname->name, tname->name, name_len);
>> +		oname->len =3D name_len;
>> +	}
>>   out:
>>   	fscrypt_fname_free_buffer(&_tname);
>> +out_inode:
>> +	if ((dir !=3D fname->dir) && !IS_ERR(dir))
>> +		iput(dir);
>>   	return ret;
>>   }
>>   diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
>> index 1e08f8a64ad6..189af2404165 100644
>> --- a/fs/ceph/crypto.h
>> +++ b/fs/ceph/crypto.h
>> @@ -75,13 +75,16 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_=
fscrypt_auth *fa)
>>    * smaller size. If the ciphertext name is longer than the value below=
, then
>>    * sha256 hash the remaining bytes.
>>    *
>> - * 189 bytes =3D> 252 bytes base64-encoded, which is <=3D NAME_MAX (255)
>> + * 180 bytes =3D> 240 bytes base64-encoded, which is <=3D NAME_MAX (255)
>> + *
>> + * (Note: 240 bytes is the maximum size allowed for snapshot names to t=
ake into
>> + *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>')
>>    *
>>    * Note that for long names that end up having their tail portion hash=
ed, we
>>    * must also store the full encrypted name (in the dentry's alternate_=
name
>>    * field).
>>    */
>> -#define CEPH_NOHASH_NAME_MAX (189 - SHA256_DIGEST_SIZE)
>> +#define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
>>     void ceph_fscrypt_set_ops(struct super_block *sb);
>>   @@ -90,7 +93,7 @@ void ceph_fscrypt_free_dummy_policy(struct ceph_fs_c=
lient
>> *fsc);
>>   int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inod=
e,
>>   				 struct ceph_acl_sec_ctx *as);
>>   void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct c=
eph_acl_sec_ctx *as);
>> -int ceph_encode_encrypted_fname(const struct inode *parent, struct dent=
ry *dentry, char *buf);
>> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *de=
ntry, char *buf);
>>     static inline int ceph_fname_alloc_buffer(struct inode *parent, stru=
ct
>> fscrypt_str *fname)
>>   {
>>
>

