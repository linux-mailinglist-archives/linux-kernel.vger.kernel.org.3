Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52D14DD8A0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiCRLCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiCRLCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:02:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA162D7AB8;
        Fri, 18 Mar 2022 04:00:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE4D61F37F;
        Fri, 18 Mar 2022 11:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647601242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Vuh3O9eyEuHOTOc+qt7uPyagmvow+tO0+oz5YGwEKA=;
        b=f9CAciRLzvZ9GZZ++BdciFx1J1GtkkG6pOhBTZu5HUZ3txU8XnVOhNCn3zGyarRNuyMFct
        fgsLfPAhjkezxQaDLBN1K7RiuAnz17b0uVx9RI0j3YPME92TG+1y6rpiUbvFpvwr6gH8Fc
        Kw/f1ocLUvJhotKeXTT7ONWy29sPO8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647601242;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Vuh3O9eyEuHOTOc+qt7uPyagmvow+tO0+oz5YGwEKA=;
        b=ap8/ok7wQUIprvZSPOtB2jvvREHQ0aOx/IqBUU5D7VQFLA322d7cvlbyLJM/BbKOEJ7nRo
        EbUD5x15VmgIDnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63D5D13B67;
        Fri, 18 Mar 2022 11:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m/NUFVpmNGIoagAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 18 Mar 2022 11:00:42 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 6caa1e61;
        Fri, 18 Mar 2022 11:01:01 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/4] ceph: replace base64url by the encoding used
 for mailbox names
References: <20220317154521.6615-1-lhenriques@suse.de>
        <20220317154521.6615-5-lhenriques@suse.de>
        <6ac92645-dede-b87c-3731-2280d59f8d8e@redhat.com>
Date:   Fri, 18 Mar 2022 11:01:01 +0000
In-Reply-To: <6ac92645-dede-b87c-3731-2280d59f8d8e@redhat.com> (Xiubo Li's
        message of "Fri, 18 Mar 2022 16:32:15 +0800")
Message-ID: <8735jfh6du.fsf@brahms.olymp>
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
>> The base64url encoding includes the '_' character, which may cause probl=
ems
>> in snapshot names (if the name starts with '_').  Thus, use the base64
>> encoding defined for IMAP mailbox names (RFC 3501), which uses '+' and '=
,'
>> instead of '-' and '_'.
>>
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>   fs/ceph/crypto.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++--
>>   fs/ceph/crypto.h |  3 +++
>>   fs/ceph/dir.c    |  2 +-
>>   fs/ceph/inode.c  |  2 +-
>>   4 files changed, 54 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> index caa9863dee93..d6f1c444ce91 100644
>> --- a/fs/ceph/crypto.c
>> +++ b/fs/ceph/crypto.c
>> @@ -7,6 +7,53 @@
>>   #include "mds_client.h"
>>   #include "crypto.h"
>>   +static const char base64_table[65] =3D
>> +        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789=
+,";
>> +
>> +int ceph_base64_encode(const u8 *src, int srclen, char *dst)
>> +{
>> +	u32 ac =3D 0;
>> +	int bits =3D 0;
>> +	int i;
>> +	char *cp =3D dst;
>> +
>> +	for (i =3D 0; i < srclen; i++) {
>> +		ac =3D (ac << 8) | src[i];
>> +		bits +=3D 8;
>> +		do {
>> +			bits -=3D 6;
>> +			*cp++ =3D base64_table[(ac >> bits) & 0x3f];
>> +		} while (bits >=3D 6);
>> +	}
>> +	if (bits)
>> +		*cp++ =3D base64_table[(ac << (6 - bits)) & 0x3f];
>> +	return cp - dst;
>> +}
>> +
>> +int ceph_base64_decode(const char *src, int srclen, u8 *dst)
>> +{
>> +	u32 ac =3D 0;
>> +	int bits =3D 0;
>> +	int i;
>> +	u8 *bp =3D dst;
>> +
>> +	for (i =3D 0; i < srclen; i++) {
>> +		const char *p =3D strchr(base64_table, src[i]);
>> +
>> +		if (p =3D=3D NULL || src[i] =3D=3D 0)
>> +			return -1;
>> +		ac =3D (ac << 6) | (p - base64_table);
>> +		bits +=3D 6;
>> +		if (bits >=3D 8) {
>> +			bits -=3D 8;
>> +			*bp++ =3D (u8)(ac >> bits);
>> +		}
>> +	}
>> +	if (ac & ((1 << bits) - 1))
>> +		return -1;
>> +	return bp - dst;
>> +}
>
> Maybe this should be in fs/crypto.c ?

Yeah, if the solution is to modify the base64 encoding, that's my
preference too (in the series cover-letter this would correspond to
alternative #3).

[ In fact, I've probably done something very wrong here, as I didn't even
  mentioned that this patch is basically a copy of someone else's code; I
  simply modified the table used.  So, please do *not* consider merging
  this patch. ]

Cheers,
--=20
Lu=C3=ADs

>
> -- Xiubo
>
>> +
>>   static int ceph_crypt_get_context(struct inode *inode, void *ctx, size=
_t len)
>>   {
>>   	struct ceph_inode_info *ci =3D ceph_inode(inode);
>> @@ -260,7 +307,7 @@ int ceph_encode_encrypted_dname(struct inode *parent=
, struct qstr *d_name, char
>>   	}
>>     	/* base64 encode the encrypted name */
>> -	elen =3D fscrypt_base64url_encode(cryptbuf, len, buf);
>> +	elen =3D ceph_base64_encode(cryptbuf, len, buf);
>>   	dout("base64-encoded ciphertext name =3D %.*s\n", elen, buf);
>>     	WARN_ON(elen > (CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE));
>> @@ -365,7 +412,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname=
, struct fscrypt_str *tname,
>>   			tname =3D &_tname;
>>   		}
>>   -		declen =3D fscrypt_base64url_decode(name, name_len, tname->name);
>> +		declen =3D ceph_base64_decode(name, name_len, tname->name);
>>   		if (declen <=3D 0) {
>>   			ret =3D -EIO;
>>   			goto out;
>> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
>> index 3273d076a9e5..d22316011810 100644
>> --- a/fs/ceph/crypto.h
>> +++ b/fs/ceph/crypto.h
>> @@ -93,6 +93,9 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fs=
crypt_auth *fa)
>>    */
>>   #define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
>>   +int ceph_base64_encode(const u8 *src, int srclen, char *dst);
>> +int ceph_base64_decode(const char *src, int srclen, u8 *dst);
>> +
>>   void ceph_fscrypt_set_ops(struct super_block *sb);
>>     void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index 5ae5cb778389..417d8c3a7edd 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -960,7 +960,7 @@ static int prep_encrypted_symlink_target(struct ceph=
_mds_request *req, const cha
>>   		goto out;
>>   	}
>>   -	len =3D fscrypt_base64url_encode(osd_link.name, osd_link.len,
>> req->r_path2);
>> +	len =3D ceph_base64_encode(osd_link.name, osd_link.len, req->r_path2);
>>   	req->r_path2[len] =3D '\0';
>>   out:
>>   	fscrypt_fname_free_buffer(&osd_link);
>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>> index 359e29896f16..8fd493257e0b 100644
>> --- a/fs/ceph/inode.c
>> +++ b/fs/ceph/inode.c
>> @@ -875,7 +875,7 @@ static int decode_encrypted_symlink(const char *encs=
ym, int enclen, u8 **decsym)
>>   	if (!sym)
>>   		return -ENOMEM;
>>   -	declen =3D fscrypt_base64url_decode(encsym, enclen, sym);
>> +	declen =3D ceph_base64_decode(encsym, enclen, sym);
>>   	if (declen < 0) {
>>   		pr_err("%s: can't decode symlink (%d). Content: %.*s\n", __func__, d=
eclen, enclen, encsym);
>>   		kfree(sym);
>>
>
