Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42D74DD87A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiCRKyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbiCRKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:54:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF131F046C;
        Fri, 18 Mar 2022 03:52:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 479A31F37F;
        Fri, 18 Mar 2022 10:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647600777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXfpb7wjwVQw01twHwKNxKcRj4vDqzWUtV05u2Nkn0I=;
        b=CyCEy9TkNd4SQHDLCjQ+Z7qBz9b6hA+nrtXVm0X28ybh9wWoAJ+f2zkG+qEIpVtdndbkjp
        KtuyqW+6m4Cjwo8dDyUBQ20ODkH0SUGuLPHrsiMbQzBdMfp+YjX2dEpjGB2GI1FXtn4TMH
        L0N2e6YnRSdG9SuvO6P+dQyVopAnPDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647600777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXfpb7wjwVQw01twHwKNxKcRj4vDqzWUtV05u2Nkn0I=;
        b=QRieg5sgxOINijIvaSaEINBLOtuaS7wazwqKt9QIHu2vBujQBFnQZ7jFFtPnQYu+h/qp4h
        HDf2ENg16pVlaFDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C970613BB5;
        Fri, 18 Mar 2022 10:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YOdsKYhkNGKNZgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 18 Mar 2022 10:52:56 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id a443eadc;
        Fri, 18 Mar 2022 10:53:15 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/4] ceph: handle encrypted snapshot names in
 subdirectories
References: <20220317154521.6615-1-lhenriques@suse.de>
        <20220317154521.6615-3-lhenriques@suse.de>
        <61d831de-1589-3a19-8f46-a162099e75df@redhat.com>
Date:   Fri, 18 Mar 2022 10:53:15 +0000
In-Reply-To: <61d831de-1589-3a19-8f46-a162099e75df@redhat.com> (Xiubo Li's
        message of "Fri, 18 Mar 2022 12:57:34 +0800")
Message-ID: <878rt7h6qs.fsf@brahms.olymp>
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

> On 3/17/22 11:45 PM, Lu=C3=ADs Henriques wrote:
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
>>   fs/ceph/crypto.c | 189 ++++++++++++++++++++++++++++++++++++++++-------
>>   fs/ceph/crypto.h |  11 ++-
>>   2 files changed, 169 insertions(+), 31 deletions(-)
>>
>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> index beb73bbdd868..caa9863dee93 100644
>> --- a/fs/ceph/crypto.c
>> +++ b/fs/ceph/crypto.c
>> @@ -128,16 +128,100 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_r=
equest *req, struct ceph_acl_se
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
>> +	dir =3D ceph_find_inode(parent->i_sb, vino);
>> +	if (!dir) {
>> +		/* This can happen if we're not mounting cephfs on the root */
>> +		dir =3D ceph_get_inode(parent->i_sb, vino, NULL);
>
> In this case IMO you should lookup the inode from MDS instead create it i=
n the
> cache, which won't setup the encryption info needed.
>
> So later when you try to use this to dencrypt the snapshot names, you wil=
l hit
> errors ? And also the case Jeff mentioned in previous thread could happen.

No, I don't see any errors.  The reason is that if we get a I_NEW inode,
we do not have the keys to even decrypt the names.  If you mount a
filesystem using as root a directory that is inside an encrypted
directory, you'll see the encrypted snapshot name:

 # mkdir mydir
 # fscrypt encrypt mydir
 # mkdir -p mydir/a/b/c/d
 # mkdir mydir/a/.snap/myspan
 # umount ...
 # mount <mon>:<port>:/a
 # ls .snap

And we simply can't decrypt it because for that we'd need to have access
to the .fscrypt in the original filesystem mount root.

I haven't tested NFS over ceph (I don't currently have a test environment
for doing that), but I *think* the same thing will happen.  (I can try to
setup this test environment in the next couple of days.)

> I figured out another approach could resolve this more gracefully:

I took a quick look at the PR and the client patch but I suspect that Jeff
is right: this approach may greatly reduce security, which is definitely
not desirable.

Cheers,
--=20
Lu=C3=ADs


> For all the subdirs just let them inherit the encryption info from the sa=
me
> ancestor, which is initially encrypted, then in ceph_new_inode() you can =
just
> skip setting up the encryption info for all the subdirs and in MDS side w=
ill
> send back the parent's encryption info and fill it in handle_reply(), thi=
s is
> just what the .snap does.
>
> Then here you can use current inode to do the dencryption for all the sna=
pshots
> including the long snapshot names.
>
> I have raise one PR and send a kclient patch for the above basic framework
> [1][2]. But there still need a little more work you need to do based them:
>
> When lssnap you need to add one flag in LeaseStat to tell the kclient whe=
ther
> the long snap names are encrypted, this is very easy in MDS side. Then in
> kclient side you can just skip dencrypting the long snap names which are =
from
> none-encyrpted parents and for all the other just use current inode to do=
 the
> dencryption. No need to search the parent inodes for long snaps.
>
> And when lookuping a long snap name, which could be encyrpted and could b=
e not,
> then you need to parse the inode out and lookup the inode from MDS if it =
does
> not exist in cache.
>
>
> [1] https://github.com/ceph/ceph/pull/45516
>
> [2] https://patchwork.kernel.org/project/ceph-devel/list/?series=3D624492
>
>
>> +		if (!dir)
>> +			dir =3D ERR_PTR(-ENOENT);
>> +	}
>> +	if (IS_ERR(dir))
>> +		dout("Can't find inode %s (%s)\n", inode_number, name);
>> +
>> +out:
>> +	kfree(inode_number);
>> +	return dir;
>> +}
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
>> +
>> +	iname.name =3D d_name->name;
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
>>   -	if (!fscrypt_has_encryption_key(parent)) {
>> +	if (!fscrypt_has_encryption_key(dir)) {
>>   		memcpy(buf, d_name->name, d_name->len);
>> -		return d_name->len;
>> +		elen =3D d_name->len;
>> +		goto out;
>>   	}
>>     	/*
>> @@ -146,18 +230,22 @@ int ceph_encode_encrypted_dname(const struct inode=
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
>> @@ -173,12 +261,29 @@ int ceph_encode_encrypted_dname(const struct inode=
 *parent, struct qstr *d_name,
>>     	/* base64 encode the encrypted name */
>>   	elen =3D fscrypt_base64url_encode(cryptbuf, len, buf);
>> -	kfree(cryptbuf);
>>   	dout("base64-encoded ciphertext name =3D %.*s\n", elen, buf);
>> +
>> +	WARN_ON(elen > (CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE));
>> +	if ((elen > 0) && (dir !=3D parent)) {
>> +		char tmp_buf[NAME_MAX];
>> +
>> +		elen =3D snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
>> +				elen, buf, dir->i_ino);
>> +		memcpy(buf, tmp_buf, elen);
>> +	}
>> +
>> +out:
>> +	kfree(cryptbuf);
>> +	if (dir !=3D parent) {
>> +		if ((dir->i_state & I_NEW))
>> +			discard_new_inode(dir);
>> +		else
>> +			iput(dir);
>> +	}
>>   	return elen;
>>   }
>>   -int ceph_encode_encrypted_fname(const struct inode *parent, struct de=
ntry
>> *dentry, char *buf)
>> +int ceph_encode_encrypted_fname(struct inode *parent, struct dentry *de=
ntry, char *buf)
>>   {
>>   	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
>>   @@ -203,29 +308,42 @@ int ceph_encode_encrypted_fname(const struct ino=
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
>> -
>> -	if (!IS_ENCRYPTED(fname->dir)) {
>> -		oname->name =3D fname->name;
>> -		oname->len =3D fname->name_len;
>> -		return 0;
>> -	}
>> +	char *name =3D fname->name;
>> +	int name_len =3D fname->name_len;
>> +	int ret;
>>     	/* Sanity check that the resulting name will fit in the buffer */
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
>> +	if (!IS_ENCRYPTED(dir)) {
>> +		oname->name =3D fname->name;
>> +		oname->len =3D fname->name_len;
>> +		ret =3D 0;
>> +		goto out_inode;
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
>> @@ -233,7 +351,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname=
, struct fscrypt_str *tname,
>>   		oname->len =3D fname->name_len;
>>   		if (is_nokey)
>>   			*is_nokey =3D true;
>> -		return 0;
>> +		ret =3D 0;
>> +		goto out_inode;
>>   	}
>>     	if (fname->ctext_len =3D=3D 0) {
>> @@ -242,11 +361,11 @@ int ceph_fname_to_usr(const struct ceph_fname *fna=
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
>> @@ -258,9 +377,25 @@ int ceph_fname_to_usr(const struct ceph_fname *fnam=
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
>> +	if ((dir !=3D fname->dir) && !IS_ERR(dir)) {
>> +		if ((dir->i_state & I_NEW))
>> +			discard_new_inode(dir);
>> +		else
>> +			iput(dir);
>> +	}
>>   	return ret;
>>   }
>>   diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
>> index 62f0ddd30dee..3273d076a9e5 100644
>> --- a/fs/ceph/crypto.h
>> +++ b/fs/ceph/crypto.h
>> @@ -82,13 +82,16 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_=
fscrypt_auth *fa)
>>    * struct fscrypt_ceph_nokey_name {
>>    *	u8 bytes[157];
>>    *	u8 sha256[SHA256_DIGEST_SIZE];
>> - * }; // 189 bytes =3D> 252 bytes base64-encoded, which is <=3D NAME_MA=
X (255)
>> + * }; // 180 bytes =3D> 240 bytes base64-encoded, which is <=3D NAME_MA=
X (255)
>> + *
>> + * (240 bytes is the maximum size allowed for snapshot names to take in=
to
>> + *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>'.)
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
>>   @@ -97,8 +100,8 @@ void ceph_fscrypt_free_dummy_policy(struct ceph_fs_=
client
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
