Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7244DAE95
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355224AbiCPLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343563AbiCPLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:01:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBC60077;
        Wed, 16 Mar 2022 04:00:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C1961F390;
        Wed, 16 Mar 2022 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647428425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sM70Iz/zzL8rdDARgecMacKzOr4IAgxW59+OOfyajuQ=;
        b=uU0cZRVlBKXUf/R+jLICWslqJDd9nE4DVFsBsr85qy8VMNx8Y3oGHNSslldU0n6fDRb389
        +Hoc6bOUghHybUFl3OHytyDkNj2ulIGCObYx1y2wmsyGRwj0oJpoaChl9GzAo61zNwUNhV
        aXL7WpVovZFQBeGQAW8nrGJujmi4FiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647428425;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sM70Iz/zzL8rdDARgecMacKzOr4IAgxW59+OOfyajuQ=;
        b=Ik1zk3N8Zy8woyUX6ule6XPSOFHo8qUlysfb/Q/VRWocIJpxc7Sy1VW8P3tw8Xfgcx/Fw1
        +dy1sQ8LP+X8X3Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C125139FE;
        Wed, 16 Mar 2022 11:00:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 75vxA0nDMWLCKwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 16 Mar 2022 11:00:25 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 0a1379f3;
        Wed, 16 Mar 2022 11:00:42 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] ceph: add support for handling encrypted
 snapshot names
References: <20220315161959.19453-1-lhenriques@suse.de>
        <20220315161959.19453-3-lhenriques@suse.de>
        <972eafc3-93a3-b523-4ad2-e234b3664635@redhat.com>
Date:   Wed, 16 Mar 2022 11:00:42 +0000
In-Reply-To: <972eafc3-93a3-b523-4ad2-e234b3664635@redhat.com> (Xiubo Li's
        message of "Wed, 16 Mar 2022 08:47:43 +0800")
Message-ID: <87r172i2lh.fsf@brahms.olymp>
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

> On 3/16/22 12:19 AM, Lu=C3=ADs Henriques wrote:
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
>>
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>   fs/ceph/crypto.c | 158 +++++++++++++++++++++++++++++++++++++++++------
>>   fs/ceph/crypto.h |  11 ++--
>>   2 files changed, 145 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> index c125a79019b3..06a4b918201c 100644
>> --- a/fs/ceph/crypto.c
>> +++ b/fs/ceph/crypto.c
>> @@ -128,18 +128,95 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_re=
quest *req, struct ceph_acl_se
>>   	swap(req->r_fscrypt_auth, as->fscrypt_auth);
>>   }
>>   -int ceph_encode_encrypted_dname(const struct inode *parent, struct qs=
tr
>> *d_name, char *buf)
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
>>   {
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
>> +
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
>> +
>> +	/* And finally the inode */
>> +	dir =3D ceph_get_inode(parent->i_sb, vino, NULL);
>
> Maybe you should use ceph_find_inode() here ? We shouldn't insert a new o=
ne
> here. And IMO the parent dir inode must be in the cache...

Right, that makes sense.  I'll swap it for the ceph_find_inode().

>> +	if (IS_ERR(dir))
>> +		dout("Can't find inode %s (%s)\n", inode_number, name);
>> +
>> +out:
>> +	kfree(inode_number);
>> +	return dir;
>> +}
>
> Here I think you have missed one case, not all the long snap names are ne=
eded to
> be dencrypted if they are from the parent snap realms, who are not encryp=
ted,
> for example:
>
> mkdir dir1
>
> fscrypt encrypt dir1
>
> mkdir dir1/dir2
>
> mkdir .snap/root_snap
>
> mkdir dir1/.snap/dir1_snap
>
> ls dir1/dir2/.snap/
>
> _root_snap_1=C2=A0 _dir1_snap_1099511628283
>
> You shouldn't encrypt the "_root_snap_1" long name.

Ah!  Good catch!  Yes, this case isn't being covered.  I'll fix it with by
following your suggestion bellow.

>> +
>> +int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_na=
me, char *buf)
>> +{
>> +	struct inode *dir =3D parent;
>> +	struct qstr iname;
>>   	u32 len;
>> +	int name_len;
>>   	int elen;
>>   	int ret;
>> -	u8 *cryptbuf;
>> +	u8 *cryptbuf =3D NULL;
>>     	if (!fscrypt_has_encryption_key(parent)) {
>>   		memcpy(buf, d_name->name, d_name->len);
>>   		return d_name->len;
>>   	}
>>   +	iname.name =3D d_name->name;
>> +	name_len =3D d_name->len;
>> +
>> +	/* Handle the special case of snapshot names that start with '_' */
>> +	if ((ceph_snap(dir) =3D=3D CEPH_SNAPDIR) && (name_len > 0) &&
>> +	    (iname.name[0] =3D=3D '_')) {
>> +		dir =3D parse_longname(parent, iname.name, &name_len);
>> +		if (IS_ERR(dir))
>> +			return PTR_ERR(dir);
>> +		iname.name++; /* skip initial '_' */
>> +	}
>> +	iname.len =3D name_len;
>> +
>
> Maybe you can do this just before checking the fscrypt_has_encryption_key=
() to
> fix the issue mentioned above ?
>
>
>>   	/*
>>   	 * convert cleartext d_name to ciphertext
>>   	 * if result is longer than CEPH_NOKEY_NAME_MAX,
>> @@ -147,18 +224,22 @@ int ceph_encode_encrypted_dname(const struct inode=
 *parent, struct qstr *d_name,
>>   	 *
>>   	 * See: fscrypt_setup_filename
>>   	 */
>> -	if (!fscrypt_fname_encrypted_size(parent, d_name->len, NAME_MAX, &len))
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
>>   -	ret =3D fscrypt_fname_encrypt(parent, d_name, cryptbuf, len);
>> +	ret =3D fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
>>   	if (ret) {
>> -		kfree(cryptbuf);
>> -		return ret;
>> +		elen =3D ret;
>> +		goto out;
>>   	}
>>     	/* hash the end if the name is long enough */
>> @@ -174,12 +255,24 @@ int ceph_encode_encrypted_dname(const struct inode=
 *parent, struct qstr *d_name,
>>     	/* base64 encode the encrypted name */
>>   	elen =3D fscrypt_base64url_encode(cryptbuf, len, buf);
>> -	kfree(cryptbuf);
>>   	dout("base64-encoded ciphertext name =3D %.*s\n", elen, buf);
>> +
>> +	if ((elen > 0) && (dir !=3D parent)) {
>> +		char tmp_buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
>> +
>
> Do we really need FSCRYPT_BASE64URL_CHARS(NAME_MAX) ? Since you have fix =
the
> 189->180 code, then the encrypted long snap name shouldn't exceed 255.
>
> I think the NAME_MAX is enough.

Yes, correct.  I'll change that too.

> And also you should check the elen here it shouldn't exceed 240 after enc=
rypted,
> or should we fail it here directly with a warning log ?

Right, that should probably be logged.  I'll had that check.

Thanks a lot for your review, Xiubo.

Cheers,
--=20
Lu=C3=ADs

>> +		elen =3D snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
>> +				elen, buf, dir->i_ino);
>> +		memcpy(buf, tmp_buf, elen);
>> +	}
>> +
>> +out:
>> +	kfree(cryptbuf);
>> +	if (dir !=3D parent)
>> +		iput(dir);
>>   	return elen;
>>   }
>>   -int ceph_encode_encrypted_fname(const struct inode *parent, struct de=
ntry
>> *dentry, char *buf)
>> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *de=
ntry, char *buf)
>>   {
>>   	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
>>   @@ -204,11 +297,14 @@ int ceph_encode_encrypted_fname(const struct ino=
de
>> *parent, struct dentry *dentr
>>   int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_s=
tr *tname,
>>   		      struct fscrypt_str *oname, bool *is_nokey)
>>   {
>> -	int ret;
>> +	struct inode *dir =3D fname->dir;
>>   	struct fscrypt_str _tname =3D FSTR_INIT(NULL, 0);
>>   	struct fscrypt_str iname;
>> +	char *name =3D fname->name;
>> +	int name_len =3D fname->name_len;
>> +	int ret;
>>   -	if (!IS_ENCRYPTED(fname->dir)) {
>> +	if (!IS_ENCRYPTED(dir)) {
>>   		oname->name =3D fname->name;
>>   		oname->len =3D fname->name_len;
>>   		return 0;
>> @@ -218,15 +314,24 @@ int ceph_fname_to_usr(const struct ceph_fname *fna=
me, struct fscrypt_str *tname,
>>   	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
>>   		return -EIO;
>>   -	ret =3D __fscrypt_prepare_readdir(fname->dir);
>> +	/* Handle the special case of snapshot names that start with '_' */
>> +	if ((ceph_snap(dir) =3D=3D CEPH_SNAPDIR) && (name_len > 0) &&
>> +	    (name[0] =3D=3D '_')) {
>> +		dir =3D parse_longname(dir, name, &name_len);
>> +		if (IS_ERR(dir))
>> +			return PTR_ERR(dir);
>> +		name++; /* skip initial '_' */
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
>>   		if (fname->no_copy)
>>   			oname->name =3D fname->name;
>>   		else
>> @@ -234,7 +339,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname=
, struct fscrypt_str *tname,
>>   		oname->len =3D fname->name_len;
>>   		if (is_nokey)
>>   			*is_nokey =3D true;
>> -		return 0;
>> +		ret =3D 0;
>> +		goto out_inode;
>>   	}
>>     	if (fname->ctext_len =3D=3D 0) {
>> @@ -243,11 +349,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fna=
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
>> @@ -259,9 +365,21 @@ int ceph_fname_to_usr(const struct ceph_fname *fnam=
e, struct fscrypt_str *tname,
>>   		iname.len =3D fname->ctext_len;
>>   	}
>>   -	ret =3D fscrypt_fname_disk_to_usr(fname->dir, 0, 0, &iname, oname);
>> +	ret =3D fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
>> +	if (!ret && (dir !=3D fname->dir)) {
>> +		char tmp_buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
>> +
>> +		name_len =3D snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
>> +				    oname->len, oname->name, dir->i_ino);
>> +		memcpy(oname->name, tmp_buf, name_len);
>> +		oname->len =3D name_len;
>> +	}
>> +
>>   out:
>>   	fscrypt_fname_free_buffer(&_tname);
>> +out_inode:
>> +	if ((dir !=3D fname->dir) && !IS_ERR(dir))
>> +		iput(dir);
>>   	return ret;
>>   }
>>   diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
>> index 185fb4799a6d..e38a842e02a6 100644
>> --- a/fs/ceph/crypto.h
>> +++ b/fs/ceph/crypto.h
>> @@ -76,13 +76,16 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_=
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
>>   @@ -91,8 +94,8 @@ void ceph_fscrypt_free_dummy_policy(struct ceph_fs_c=
lient
>> *fsc);
>>   int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inod=
e,
>>   				 struct ceph_acl_sec_ctx *as);
>>   void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct c=
eph_acl_sec_ctx *as);
>> -int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr=
 *d_name, char *buf);
>> -int ceph_encode_encrypted_fname(const struct inode *parent, struct dent=
ry *dentry, char *buf);
>> +int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_na=
me, char *buf);
>> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *de=
ntry, char *buf);
>>     static inline int ceph_fname_alloc_buffer(struct inode *parent, stru=
ct
>> fscrypt_str *fname)
>>   {
>>
>

