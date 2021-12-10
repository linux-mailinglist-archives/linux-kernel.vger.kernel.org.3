Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B946FFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbhLJLhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:37:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33142 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbhLJLhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:37:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 991ED210E9;
        Fri, 10 Dec 2021 11:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639136015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfdAnWHNWTSeLX3YLuPivSk0l3wXWy68vqkxDUuOEJE=;
        b=u1l6tidVzoiFA65vtwgwK5Ja+R80L+7st9O0ztZasGcjzbvfyMbyRgeLPdOOrBh/BE+paf
        iNtgPJ+AN8ddBSbMguBMKj2YiUxiG8qfJh+9iYaZP2zFbufRetDE6WGjI4VcnO05bt5xWb
        dXRWGyZmWUv+Pmz6WvnbfDwyklTMzSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639136015;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfdAnWHNWTSeLX3YLuPivSk0l3wXWy68vqkxDUuOEJE=;
        b=V7JZO1u5NsI5tRe3ed6xwocTxaVVMmsmd7T5+rqEIrf1xS1nq8QD038TNpsApt8zVtGXHf
        zs5fUZE+0GRAqDBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6275A13DDE;
        Fri, 10 Dec 2021 11:33:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w9cgFw87s2EtbgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 10 Dec 2021 11:33:35 +0000
To:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>, Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
References: <20211209090358.28231-1-nstange@suse.de>
 <20211209090358.28231-4-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 03/18] crypto: dh - optimize domain parameter
 serialization for well-known groups
Message-ID: <86157a11-7daa-876a-d80b-e6bda36e6368@suse.de>
Date:   Fri, 10 Dec 2021 12:33:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211209090358.28231-4-nstange@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:03 AM, Nicolai Stange wrote:
> DH users are supposed to set a struct dh instance's ->p and ->g domain
> parameters (as well as the secret ->key), serialize the whole struct dh
> instance via the crypto_dh_encode_key() helper and pass the encoded blob
> on to the DH's ->set_secret(). All three currently available DH
> implementations (generic, drivers/crypto/hisilicon/hpre/ and
> drivers/crypto/qat/) would then proceed to call the crypto_dh_decode_key()
> helper for unwrapping the encoded struct dh instance again.
> 
> Up to now, the only DH user has been the keyctl(KEYCTL_DH_COMPUTE) syscall
> and thus, all domain parameters have been coming from userspace. The domain
> parameter encoding scheme for DH's ->set_secret() has been a perfectly
> reasonable approach in this setting and the potential extra copy of ->p
> and ->g during the encoding phase didn't harm much.
> 
> However, recently, the need for working with the well-known safe-prime
> groups' domain parameters from RFC 3526 and RFC 7919 resp. arose from two
> independent developments:
> - The NVME in-band authentication support currently being worked on ([1])
>   needs to install the RFC 7919 ffdhe groups' domain parameters for DH
>   tfms.
> - In FIPS mode, there's effectively no sensible way for the DH
>   implementation to conform to SP800-56Arev3 other than rejecting any
>   parameter set not corresponding to some approved safe-prime group
>   specified in either of these two RFCs.
> 
> As the ->p arrays' lengths are in the range from 256 to 1024 bytes, it
> would be nice if that extra copy during the crypto_dh_encode_key() step
> from the NVME in-band authentication code could be avoided. Likewise, it
> would be great if the DH implementation's FIPS handling code could avoid
> attempting to match the input ->p and ->g against the individual approved
> groups' parameters via memcmp() if it's known in advance that the input
> corresponds to such one, as is the case for NVME.
> 
> Introduce a enum dh_group_id for referring to any of the safe-prime groups
> known to the kernel. The introduction of actual such safe-prime groups
> alongside with their resp. P and G parameters will be deferred to later
> patches. As of now, the new enum contains only a single member,
> DH_GROUP_ID_UNKNOWN, which is meant to be associated with parameter sets
> not corresponding to any of the groups known to the kernel, as is needed
> to continue to support the current keyctl(KEYCTL_DH_COMPUTE) syscall
> semantics.
> 
> Add a new 'group_id' member of type enum group_id to struct dh. Make
> crypto_dh_encode_key() include it in the serialization and to encode
> ->p and ->g only if it equals DH_GROUP_ID_UNKNOWN. For all other possible
> values of the encoded ->group_id, the receiving decoding primitive,
> crypto_dh_decode_key(), is made to not decode ->p and ->g from the encoded
> data, but to look them up in a central registry instead.
> 
> The intended usage pattern is that users like NVME wouldn't set any of
> the struct dh's ->p or ->g directly, but only the ->group_id for the group
> they're interested in. They'd then proceed as usual and call
> crypto_dh_encode_key() on the struct dh instance, pass the encoded result
> on to DH's ->set_secret() and the latter would then invoke
> crypto_dh_decode_key(), which would then in turn lookup the parameters
> associated with the passed ->group_id.
> 
> Note that this will avoid the extra copy of the ->p and ->g for the groups
> (to be made) known to the kernel and also, that a future patch can easily
> introduce a validation of ->group_id if in FIPS mode.
> 
> As mentioned above, the introduction of actual safe-prime groups will be
> deferred to later patches, so for now, only introduce an empty placeholder
> array safe_prime_groups[] to be queried by crypto_dh_decode_key() for
> domain parameters associated with a given ->group_id as outlined above.
> Make its elements to be of the new internal struct safe_prime_group type.
> Among the members ->group_id, ->p and ->p_size with obvious meaning, there
> will also be a ->max_strength member for storing the maximum security
> strength supported by the associated group -- its value will be needed for
> the upcoming private key generation support.
> 
> Finally, update the encoded secrets provided by the testmgr's DH test
> vectors in order to account for the additional ->group_id field expected
> by crypto_dh_decode_key() now.
> 
> [1] https://lkml.kernel.org/r/20211122074727.25988-4-hare@suse.de
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  crypto/dh_helper.c  | 90 ++++++++++++++++++++++++++++++++++++---------
>  crypto/testmgr.h    | 16 +++++---
>  include/crypto/dh.h |  6 +++
>  3 files changed, 88 insertions(+), 24 deletions(-)
> 
> diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
> index aabc91e4f63f..9f21204e5dee 100644
> --- a/crypto/dh_helper.c
> +++ b/crypto/dh_helper.c
> @@ -10,7 +10,31 @@
>  #include <crypto/dh.h>
>  #include <crypto/kpp.h>
>  
> -#define DH_KPP_SECRET_MIN_SIZE (sizeof(struct kpp_secret) + 3 * sizeof(int))
> +#define DH_KPP_SECRET_MIN_SIZE (sizeof(struct kpp_secret) + 4 * sizeof(int))
> +
> +static const struct safe_prime_group
> +{
> +	enum dh_group_id group_id;
> +	unsigned int max_strength;
> +	unsigned int p_size;
> +	const char *p;
> +} safe_prime_groups[] = {};
> +
> +/* 2 is used as a generator for all safe-prime groups. */
> +static const char safe_prime_group_g[]  = { 2 };
> +
> +static inline const struct safe_prime_group *
> +get_safe_prime_group(enum dh_group_id group_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(safe_prime_groups); ++i) {
> +		if (safe_prime_groups[i].group_id == group_id)
> +			return &safe_prime_groups[i];
> +	}
> +
> +	return NULL;
> +}
>  
>  static inline u8 *dh_pack_data(u8 *dst, u8 *end, const void *src, size_t size)
>  {
> @@ -28,7 +52,10 @@ static inline const u8 *dh_unpack_data(void *dst, const void *src, size_t size)
>  
>  static inline unsigned int dh_data_size(const struct dh *p)
>  {
> -	return p->key_size + p->p_size + p->g_size;
> +	if (p->group_id == DH_GROUP_ID_UNKNOWN)
> +		return p->key_size + p->p_size + p->g_size;
> +	else
> +		return p->key_size;
>  }
>  
>  unsigned int crypto_dh_key_len(const struct dh *p)
> @@ -45,18 +72,24 @@ int crypto_dh_encode_key(char *buf, unsigned int len, const struct dh *params)
>  		.type = CRYPTO_KPP_SECRET_TYPE_DH,
>  		.len = len
>  	};
> +	int group_id;
>  
>  	if (unlikely(!len))
>  		return -EINVAL;
>  
>  	ptr = dh_pack_data(ptr, end, &secret, sizeof(secret));
> +	group_id = (int)params->group_id;
> +	ptr = dh_pack_data(ptr, end, &group_id, sizeof(group_id));

Me being picky again.
To my knowledge, 'int' doesn't have a fixed width, but is rather only
guaranteed to hold certain values.
So as soon as one relies on any fixed size (as this one does) I tend to
use fixed size type like 'u32' to make it absolutely clear what is to be
expected here.

But the I don't know the conventions in the crypto code; if an 'int' is
assumed to be 32 bits throughout the crypto code I guess we should be fine.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
