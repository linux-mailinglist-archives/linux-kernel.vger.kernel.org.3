Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A16448E71F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbiANJJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:09:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50598 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbiANJJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:09:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DBAFD1F3A8;
        Fri, 14 Jan 2022 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642151343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TELXAI3Qzl/xl6owlzOkCS/FBCWIrsGoCyA7bQQR3Fs=;
        b=K7D8KuAgNBfdOee6w0It8qeuWjo2jmPWqXozm3/sSyB4r4neoaedphjUoaoZoW0ikOh9YS
        p5k6zu/UVzDq3a4WbPSlpnkUAoz+ZZZ6k9i9NPIK2Hdi3bIDxSuwh1eH9kqXyeZiAbDHQj
        J7CIMVcKHR7tN7JbRI01Lm/iCxfGYig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642151343;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TELXAI3Qzl/xl6owlzOkCS/FBCWIrsGoCyA7bQQR3Fs=;
        b=B4OcpLn7M0sMApfeloEibRwplBYoEGj0uR5Db72b48GU7uKB48qFNlTuEs/MsKgVNuGB0U
        xlwxotI5PdpkFWCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 503C813BE0;
        Fri, 14 Jan 2022 09:09:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oPLHEa894WE+BgAAMHmgww
        (envelope-from <nstange@suse.de>); Fri, 14 Jan 2022 09:09:03 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Nicolai Stange <nstange@suse.de>,
        Stephan Mueller <smueller@chronox.de>,
        "David S. Miller" <davem@davemloft.net>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org, simo@redhat.com,
        Eric Biggers <ebiggers@kernel.org>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [v2 PATCH] crypto: api - Disallow sha1 in FIPS-mode while allowing hmac(sha1)
References: <20211209090358.28231-1-nstange@suse.de> <87r1a7thy0.fsf@suse.de>
        <YcvEkfS4cONDXXB9@gondor.apana.org.au>
        <2468270.qO8rWLYou6@tauon.chronox.de>
        <YdepEhTI/LB9wdJr@gondor.apana.org.au>
        <Yd0gInht+V+Kcsw2@gondor.apana.org.au> <871r1eyamd.fsf@suse.de>
        <Yd1dK//76455cHdz@gondor.apana.org.au>
        <YeEVSaMEVJb3cQkq@gondor.apana.org.au>
Date:   Fri, 14 Jan 2022 10:09:02 +0100
In-Reply-To: <YeEVSaMEVJb3cQkq@gondor.apana.org.au> (Herbert Xu's message of
        "Fri, 14 Jan 2022 17:16:41 +1100")
Message-ID: <87k0f2hefl.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

many thanks for this, I think this approach can be applied as-is to the
ffdheXYZ(dh) situation. I have some questions/comments inline.

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Tue, Jan 11, 2022 at 09:34:19PM +1100, Herbert Xu wrote:
>>
>> You're right.  The real issue is that any algorithm with no tests
>> at all is allowed in FIPS mode.  That's clearly suboptimal.  But we
>> can't just ban every unknown algorithm because we rely on that
>> to let things like echainiv through.
>>=20
>> Let me figure out a way to differentiate these two cases.
>
> So what I've done is modify hmac so that if the underlying algo
> is FIPS_INTERNAL, then we pre-emptively set FIPS_INTERNAL on the
> hmac side as well.  This can then be cleared if the hmac algorithm
> is explicitly listed as fips_allowed.

I wonder whether this can be made more generic. I.e. would it be possible
to make crypto_grab_spawn() to or in FIPS_INTERNAL into type (iff !(mask
& FIPS_INTERNAL)) and to make crypto_register_instance() to propagate
FIPS_INTERNAL from the template instance's spawns upwards into the
instance's ->cra_flags?


> ---8<---
> Currently we do not distinguish between algorithms that fail on
> the self-test vs. those which are disabled in FIPS mode (not allowed).
> Both are marked as having failed the self-test.
>
> As it has been requested that we need to disable sha1 in FIPS
> mode while still allowing hmac(sha1) this approach needs to change.

On an unrelated note, this will break trusted_key_tpm_ops->init() in
FIPS mode, because trusted_shash_alloc() would fail to get a hold of
sha1. AFAICT, this could potentially make the init_trusted() module_init
to fail, and, as encrypted-keys.ko imports key_type_trusted, prevent the
loading of that one as well. Not sure that's desired...


> This patch allows this scenario by adding a new flag FIPS_INTERNAL
> to indicate those algorithms that have passed the self-test and are
> not FIPS-allowed.  They can then be used for the self-testing of
> other algorithms or by those that are explicitly allowed to use them
> (currently just hmac).
>
> Note that as a side-effect of this patch algorithms which are not
> FIPS-allowed will now return ENOENT instead of ELIBBAD.  Hopefully
> this is not an issue as some people were relying on this already.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/crypto/algapi.c b/crypto/algapi.c
> index a366cb3e8aa1..09fb75806e87 100644
> --- a/crypto/algapi.c
> +++ b/crypto/algapi.c
> @@ -322,8 +322,16 @@ void crypto_alg_tested(const char *name, int err)
>  found:
>  	q->cra_flags |=3D CRYPTO_ALG_DEAD;
>  	alg =3D test->adult;
> -	if (err || list_empty(&alg->cra_list))
> +
> +	if (list_empty(&alg->cra_list))
> +		goto complete;
> +
> +	if (err =3D=3D -ECANCELED)
> +		alg->cra_flags |=3D CRYPTO_ALG_FIPS_INTERNAL;
> +	else if (err)
>  		goto complete;
> +	else
> +		alg->cra_flags &=3D ~CRYPTO_ALG_FIPS_INTERNAL;
>=20=20
>  	alg->cra_flags |=3D CRYPTO_ALG_TESTED;
>=20=20
> diff --git a/crypto/api.c b/crypto/api.c
> index cf0869dd130b..549f9aced1da 100644
> --- a/crypto/api.c
> +++ b/crypto/api.c
> @@ -223,6 +223,8 @@ static struct crypto_alg *crypto_larval_wait(struct c=
rypto_alg *alg)
>  	else if (crypto_is_test_larval(larval) &&
>  		 !(alg->cra_flags & CRYPTO_ALG_TESTED))
>  		alg =3D ERR_PTR(-EAGAIN);
> +	else if (alg->cra_flags & CRYPTO_ALG_FIPS_INTERNAL)
> +		alg =3D ERR_PTR(-EAGAIN);

I might be mistaken, but I think this would cause hmac(sha1)
instantiation to fail if sha1 is not already there. I.e. if hmac(sha1)
instantiation would load sha1, then it would invoke crypto_larval_wait()
on the sha1 larval, see the FIPS_INTERNAL and fail?

However, wouldn't it be possible to simply implement FIPS_INTERNAL
lookups in analogy to the INTERNAL ones instead? That is, would adding

	if (!((type | mask) & CRYPTO_ALG_FIPS_INTERNAL))
		mask |=3D CRYPTO_ALG_FIPS_INTERNAL;

to the preamble of crypto_alg_mod_lookup() work instead?

AFAICS, ...


>  	else if (!crypto_mod_get(alg))
>  		alg =3D ERR_PTR(-EAGAIN);
>  	crypto_mod_put(&larval->alg);
> @@ -233,6 +235,7 @@ static struct crypto_alg *crypto_larval_wait(struct c=
rypto_alg *alg)
>  static struct crypto_alg *crypto_alg_lookup(const char *name, u32 type,
>  					    u32 mask)
>  {
> +	const u32 fips =3D CRYPTO_ALG_FIPS_INTERNAL;
>  	struct crypto_alg *alg;
>  	u32 test =3D 0;
>=20=20
> @@ -240,8 +243,20 @@ static struct crypto_alg *crypto_alg_lookup(const ch=
ar *name, u32 type,
>  		test |=3D CRYPTO_ALG_TESTED;
>=20=20
>  	down_read(&crypto_alg_sem);
> -	alg =3D __crypto_alg_lookup(name, type | test, mask | test);
> -	if (!alg && test) {
> +	alg =3D __crypto_alg_lookup(name, (type | test) & ~fips,
> +				  (mask | test) & ~fips);
> +	if (alg) {
> +		if (((type | mask) ^ fips) & fips)
> +			mask |=3D fips;
> +		mask &=3D fips;
> +
> +		if (!crypto_is_larval(alg) &&
> +		    ((type ^ alg->cra_flags) & mask)) {
> +			/* Algorithm is disallowed in FIPS mode. */
> +			crypto_mod_put(alg);
> +			alg =3D ERR_PTR(-ENOENT);
> +		}
> +	} else if (test) {

... this check here would not be needed anymore then? But I might be
missing something.


>  		alg =3D __crypto_alg_lookup(name, type, mask);
>  		if (alg && !crypto_is_larval(alg)) {
>  			/* Test failed */
> diff --git a/crypto/hmac.c b/crypto/hmac.c
> index 25856aa7ccbf..af82e3eeb7d0 100644
> --- a/crypto/hmac.c
> +++ b/crypto/hmac.c
> @@ -169,6 +169,7 @@ static int hmac_create(struct crypto_template *tmpl, =
struct rtattr **tb)
>  	struct crypto_alg *alg;
>  	struct shash_alg *salg;
>  	u32 mask;
> +	u32 type;
>  	int err;
>  	int ds;
>  	int ss;
> @@ -182,8 +183,9 @@ static int hmac_create(struct crypto_template *tmpl, =
struct rtattr **tb)
>  		return -ENOMEM;
>  	spawn =3D shash_instance_ctx(inst);
>=20=20
> +	type =3D CRYPTO_ALG_FIPS_INTERNAL;
>  	err =3D crypto_grab_shash(spawn, shash_crypto_instance(inst),
> -				crypto_attr_alg_name(tb[1]), 0, mask);
> +				crypto_attr_alg_name(tb[1]), type, mask);
>  	if (err)
>  		goto err_free_inst;
>  	salg =3D crypto_spawn_shash_alg(spawn);
> @@ -204,6 +206,7 @@ static int hmac_create(struct crypto_template *tmpl, =
struct rtattr **tb)
>  	if (err)
>  		goto err_free_inst;
>=20=20
> +	inst->alg.base.cra_flags =3D alg->cra_flags & CRYPTO_ALG_FIPS_INTERNAL;
>  	inst->alg.base.cra_priority =3D alg->cra_priority;
>  	inst->alg.base.cra_blocksize =3D alg->cra_blocksize;
>  	inst->alg.base.cra_alignmask =3D alg->cra_alignmask;
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index 5831d4bbc64f..995d44db6154 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -1664,7 +1664,8 @@ static int test_hash_vs_generic_impl(const char *ge=
neric_driver,
>  	if (strcmp(generic_driver, driver) =3D=3D 0) /* Already the generic imp=
l? */
>  		return 0;
>=20=20
> -	generic_tfm =3D crypto_alloc_shash(generic_driver, 0, 0);
> +	generic_tfm =3D crypto_alloc_shash(generic_driver,
> +					 CRYPTO_ALG_FIPS_INTERNAL, 0);
>  	if (IS_ERR(generic_tfm)) {
>  		err =3D PTR_ERR(generic_tfm);
>  		if (err =3D=3D -ENOENT) {
> @@ -2387,7 +2388,8 @@ static int test_aead_vs_generic_impl(struct aead_ex=
tra_tests_ctx *ctx)
>  	if (strcmp(generic_driver, driver) =3D=3D 0) /* Already the generic imp=
l? */
>  		return 0;
>=20=20
> -	generic_tfm =3D crypto_alloc_aead(generic_driver, 0, 0);
> +	generic_tfm =3D crypto_alloc_aead(generic_driver,
> +					CRYPTO_ALG_FIPS_INTERNAL, 0);
>  	if (IS_ERR(generic_tfm)) {
>  		err =3D PTR_ERR(generic_tfm);
>  		if (err =3D=3D -ENOENT) {
> @@ -2986,7 +2988,8 @@ static int test_skcipher_vs_generic_impl(const char=
 *generic_driver,
>  	if (strcmp(generic_driver, driver) =3D=3D 0) /* Already the generic imp=
l? */
>  		return 0;
>=20=20
> -	generic_tfm =3D crypto_alloc_skcipher(generic_driver, 0, 0);
> +	generic_tfm =3D crypto_alloc_skcipher(generic_driver,
> +					    CRYPTO_ALG_FIPS_INTERNAL, 0);
>  	if (IS_ERR(generic_tfm)) {
>  		err =3D PTR_ERR(generic_tfm);
>  		if (err =3D=3D -ENOENT) {
> @@ -5328,7 +5331,6 @@ static const struct alg_test_desc alg_test_descs[] =
=3D {
>  	}, {
>  		.alg =3D "sha1",
>  		.test =3D alg_test_hash,
> -		.fips_allowed =3D 1,
>  		.suite =3D {
>  			.hash =3D __VECS(sha1_tv_template)
>  		}
> @@ -5613,6 +5615,13 @@ static int alg_find_test(const char *alg)
>  	return -1;
>  }
>=20=20
> +static int alg_fips_disabled(const char *driver, const char *alg)
> +{
> +	pr_info("alg: %s (%s) is disabled due to FIPS\n", alg, driver);
> +
> +	return -ECANCELED;
> +}
> +
>  int alg_test(const char *driver, const char *alg, u32 type, u32 mask)
>  {
>  	int i;
> @@ -5637,9 +5646,6 @@ int alg_test(const char *driver, const char *alg, u=
32 type, u32 mask)
>  		if (i < 0)
>  			goto notest;
>=20=20
> -		if (fips_enabled && !alg_test_descs[i].fips_allowed)
> -			goto non_fips_alg;
> -
>  		rc =3D alg_test_cipher(alg_test_descs + i, driver, type, mask);
>  		goto test_done;
>  	}
> @@ -5649,8 +5655,7 @@ int alg_test(const char *driver, const char *alg, u=
32 type, u32 mask)
>  	if (i < 0 && j < 0)
>  		goto notest;
>=20=20
> -	if (fips_enabled && ((i >=3D 0 && !alg_test_descs[i].fips_allowed) ||
> -			     (j >=3D 0 && !alg_test_descs[j].fips_allowed)))
> +	if (fips_enabled && (j >=3D 0 && !alg_test_descs[j].fips_allowed))
>  		goto non_fips_alg;
>=20=20
>  	rc =3D 0;
> @@ -5671,16 +5676,22 @@ int alg_test(const char *driver, const char *alg,=
 u32 type, u32 mask)
>  		}
>  		WARN(1, "alg: self-tests for %s (%s) failed (rc=3D%d)",
>  		     driver, alg, rc);
> -	} else {
> -		if (fips_enabled)
> -			pr_info("alg: self-tests for %s (%s) passed\n",
> -				driver, alg);
> +	} else if (fips_enabled) {
> +		pr_info("alg: self-tests for %s (%s) passed\n",
> +			driver, alg);
> +
> +		if (i >=3D 0 && !alg_test_descs[i].fips_allowed)
> +			rc =3D alg_fips_disabled(driver, alg);
>  	}
>=20=20
>  	return rc;
>=20=20
>  notest:
>  	printk(KERN_INFO "alg: No test for %s (%s)\n", alg, driver);
> +
> +	if (type & CRYPTO_ALG_FIPS_INTERNAL)
> +		return alg_fips_disabled(driver, alg);
> +
>  	return 0;
>  non_fips_alg:
>  	return -EINVAL;

This looks all good to me, but as !->fips_allowed tests aren't skipped
over anymore now, it would perhaps make sense to make their failure
non-fatal in FIPS mode. Because in FIPS mode a failure could mean a
panic and some of the existing TVs might not pass because of e.g. some
key length checks or so active only for fips_enabled...

Many thanks again!

Nicolai



> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 855869e1fd32..df3f68dfe8c7 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -132,6 +132,15 @@
>   */
>  #define CRYPTO_ALG_ALLOCATES_MEMORY	0x00010000
>=20=20
> +/*
> + * Mark an algorithm as a service implementation only usable by a
> + * template and never by a normal user of the kernel crypto API.
> + * This is intended to be used by algorithms that are themselves
> + * not FIPS-approved but may instead be used to implement parts of
> + * a FIPS-approved algorithm (e.g., sha1 vs. hmac(sha1)).
> + */
> +#define CRYPTO_ALG_FIPS_INTERNAL	0x00020000
> +
>  /*
>   * Transform masks and values (for crt_flags).
>   */

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
