Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B014DD639
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiCRIdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiCRIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 914EE27CE0C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647592344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z21mgAaVERhRl6nUpUORqr1xOUtC7LpDvCRsTkgirW0=;
        b=Oz6agsZqUIe4VTbtHZE2dneUp2x9i2vbs0JrFGI80coVhPRjPqsNZCi/Lfmj0JqIHAsdZ8
        OFzF1ty18fm1gZp0q+ROLGmFhPuB59vTMau39OMTYXuF0ZEaxrKGVHYsD26DEStySgo6a5
        lzHf0vcGm0oiKqXwQ7gqqrQVK3Fs8Oc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-K87ZefpDNhiuHkqfEr-hEg-1; Fri, 18 Mar 2022 04:32:23 -0400
X-MC-Unique: K87ZefpDNhiuHkqfEr-hEg-1
Received: by mail-pg1-f199.google.com with SMTP id i5-20020a639d05000000b003822fae3e50so559399pgd.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z21mgAaVERhRl6nUpUORqr1xOUtC7LpDvCRsTkgirW0=;
        b=x4iqz141dHXQEiD3IVa8bpuYSRROIJoyrbnHhfDk+chFdu+WH5mkfdgHovSLGbyH2Y
         KiCJijX6xZY9RwPazhpVfXFAthO3dRowX0Z8iSAiIb8jhG+oh3RdbhPu0Q6EvPVJ80n0
         rnZ1BOnOrghxmQLXY6SOgovq/vxumG3O2bDWxAqvdCnQBiySikvxNMgAqsl/+UHfYTLD
         CNWkm0PfgMaNm2tTPXnfhP8mD1zSYidIzctM4Q9FzWYlyKUUhkPQ/DiHH9JKHSNzsk4E
         CujBMUmZK3rXA4/u/HXjuti8LT+HJJP/+/e+C3EV4d3JZTxcTwEeFXaOJFBXKbadorc6
         9tfw==
X-Gm-Message-State: AOAM5311qpnqdOs3c9fPRk1EblZbq5lMVoDuxvYm75N5AwqpbFNUW1SR
        RCfMcMtDvULYQHz3+a2uzPyheGCB+CvPKnPU79Mpor+OX1puai2zPlTvdMOYhcH9xiCTqM8bPNx
        L1gw2vkreDfM3SMYL5Nrfs40Gt5qIq0dhxQxsj5ula7EJzM6uvMhkCTxhSJ6kmLhAKts5A7vqRA
        ==
X-Received: by 2002:a65:6943:0:b0:376:333b:1025 with SMTP id w3-20020a656943000000b00376333b1025mr7006336pgq.164.1647592341556;
        Fri, 18 Mar 2022 01:32:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFZCK1PpQfF+1W7Sj08bQLdJEW6ice992ozsF4Ucge04G9kGugKrcIqE+1t/SQpv8XG39h5Q==
X-Received: by 2002:a65:6943:0:b0:376:333b:1025 with SMTP id w3-20020a656943000000b00376333b1025mr7006310pgq.164.1647592341165;
        Fri, 18 Mar 2022 01:32:21 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a0010c900b004f774c13e96sm9313615pfu.19.2022.03.18.01.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 01:32:20 -0700 (PDT)
Subject: Re: [RFC PATCH v3 4/4] ceph: replace base64url by the encoding used
 for mailbox names
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220317154521.6615-1-lhenriques@suse.de>
 <20220317154521.6615-5-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <6ac92645-dede-b87c-3731-2280d59f8d8e@redhat.com>
Date:   Fri, 18 Mar 2022 16:32:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220317154521.6615-5-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/22 11:45 PM, Luís Henriques wrote:
> The base64url encoding includes the '_' character, which may cause problems
> in snapshot names (if the name starts with '_').  Thus, use the base64
> encoding defined for IMAP mailbox names (RFC 3501), which uses '+' and ','
> instead of '-' and '_'.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   fs/ceph/crypto.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++--
>   fs/ceph/crypto.h |  3 +++
>   fs/ceph/dir.c    |  2 +-
>   fs/ceph/inode.c  |  2 +-
>   4 files changed, 54 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index caa9863dee93..d6f1c444ce91 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -7,6 +7,53 @@
>   #include "mds_client.h"
>   #include "crypto.h"
>   
> +static const char base64_table[65] =
> +        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
> +
> +int ceph_base64_encode(const u8 *src, int srclen, char *dst)
> +{
> +	u32 ac = 0;
> +	int bits = 0;
> +	int i;
> +	char *cp = dst;
> +
> +	for (i = 0; i < srclen; i++) {
> +		ac = (ac << 8) | src[i];
> +		bits += 8;
> +		do {
> +			bits -= 6;
> +			*cp++ = base64_table[(ac >> bits) & 0x3f];
> +		} while (bits >= 6);
> +	}
> +	if (bits)
> +		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
> +	return cp - dst;
> +}
> +
> +int ceph_base64_decode(const char *src, int srclen, u8 *dst)
> +{
> +	u32 ac = 0;
> +	int bits = 0;
> +	int i;
> +	u8 *bp = dst;
> +
> +	for (i = 0; i < srclen; i++) {
> +		const char *p = strchr(base64_table, src[i]);
> +
> +		if (p == NULL || src[i] == 0)
> +			return -1;
> +		ac = (ac << 6) | (p - base64_table);
> +		bits += 6;
> +		if (bits >= 8) {
> +			bits -= 8;
> +			*bp++ = (u8)(ac >> bits);
> +		}
> +	}
> +	if (ac & ((1 << bits) - 1))
> +		return -1;
> +	return bp - dst;
> +}

Maybe this should be in fs/crypto.c ?

-- Xiubo

> +
>   static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
>   {
>   	struct ceph_inode_info *ci = ceph_inode(inode);
> @@ -260,7 +307,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name, char
>   	}
>   
>   	/* base64 encode the encrypted name */
> -	elen = fscrypt_base64url_encode(cryptbuf, len, buf);
> +	elen = ceph_base64_encode(cryptbuf, len, buf);
>   	dout("base64-encoded ciphertext name = %.*s\n", elen, buf);
>   
>   	WARN_ON(elen > (CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE));
> @@ -365,7 +412,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
>   			tname = &_tname;
>   		}
>   
> -		declen = fscrypt_base64url_decode(name, name_len, tname->name);
> +		declen = ceph_base64_decode(name, name_len, tname->name);
>   		if (declen <= 0) {
>   			ret = -EIO;
>   			goto out;
> diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> index 3273d076a9e5..d22316011810 100644
> --- a/fs/ceph/crypto.h
> +++ b/fs/ceph/crypto.h
> @@ -93,6 +93,9 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
>    */
>   #define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
>   
> +int ceph_base64_encode(const u8 *src, int srclen, char *dst);
> +int ceph_base64_decode(const char *src, int srclen, u8 *dst);
> +
>   void ceph_fscrypt_set_ops(struct super_block *sb);
>   
>   void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 5ae5cb778389..417d8c3a7edd 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -960,7 +960,7 @@ static int prep_encrypted_symlink_target(struct ceph_mds_request *req, const cha
>   		goto out;
>   	}
>   
> -	len = fscrypt_base64url_encode(osd_link.name, osd_link.len, req->r_path2);
> +	len = ceph_base64_encode(osd_link.name, osd_link.len, req->r_path2);
>   	req->r_path2[len] = '\0';
>   out:
>   	fscrypt_fname_free_buffer(&osd_link);
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 359e29896f16..8fd493257e0b 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -875,7 +875,7 @@ static int decode_encrypted_symlink(const char *encsym, int enclen, u8 **decsym)
>   	if (!sym)
>   		return -ENOMEM;
>   
> -	declen = fscrypt_base64url_decode(encsym, enclen, sym);
> +	declen = ceph_base64_decode(encsym, enclen, sym);
>   	if (declen < 0) {
>   		pr_err("%s: can't decode symlink (%d). Content: %.*s\n", __func__, declen, enclen, encsym);
>   		kfree(sym);
>

