Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C7048E8AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiANKzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:55:49 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59506 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235571AbiANKzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:55:47 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n8KEw-0002FS-7s; Fri, 14 Jan 2022 21:55:27 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Jan 2022 21:55:26 +1100
Date:   Fri, 14 Jan 2022 21:55:26 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Stephan Mueller <smueller@chronox.de>,
        "David S. Miller" <davem@davemloft.net>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org, simo@redhat.com,
        Eric Biggers <ebiggers@kernel.org>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [v2 PATCH] crypto: api - Disallow sha1 in FIPS-mode while
 allowing hmac(sha1)
Message-ID: <YeFWnscvXtv73KBl@gondor.apana.org.au>
References: <20211209090358.28231-1-nstange@suse.de>
 <87r1a7thy0.fsf@suse.de>
 <YcvEkfS4cONDXXB9@gondor.apana.org.au>
 <2468270.qO8rWLYou6@tauon.chronox.de>
 <YdepEhTI/LB9wdJr@gondor.apana.org.au>
 <Yd0gInht+V+Kcsw2@gondor.apana.org.au>
 <871r1eyamd.fsf@suse.de>
 <Yd1dK//76455cHdz@gondor.apana.org.au>
 <YeEVSaMEVJb3cQkq@gondor.apana.org.au>
 <87k0f2hefl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0f2hefl.fsf@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 10:09:02AM +0100, Nicolai Stange wrote:
>
> I wonder whether this can be made more generic. I.e. would it be possible
> to make crypto_grab_spawn() to or in FIPS_INTERNAL into type (iff !(mask
> & FIPS_INTERNAL)) and to make crypto_register_instance() to propagate
> FIPS_INTERNAL from the template instance's spawns upwards into the
> instance's ->cra_flags?

We could certainly do something like that in future.  But it
isn't that easy because crypto_register_instance doesn't know
what the paramter algorithm(s) is/are.

> On an unrelated note, this will break trusted_key_tpm_ops->init() in
> FIPS mode, because trusted_shash_alloc() would fail to get a hold of
> sha1. AFAICT, this could potentially make the init_trusted() module_init
> to fail, and, as encrypted-keys.ko imports key_type_trusted, prevent the
> loading of that one as well. Not sure that's desired...

Well if sha1 is supposed to be forbidden in FIPS mode why should
TPM be allowed to use it? If it must be allowed, then we could
change TPM to set the FIPS_INTERNAL flag.

I think I'll simply leave out the line that actually disables sha1
for now.

> > diff --git a/crypto/api.c b/crypto/api.c
> > index cf0869dd130b..549f9aced1da 100644
> > --- a/crypto/api.c
> > +++ b/crypto/api.c
> > @@ -223,6 +223,8 @@ static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg)
> >  	else if (crypto_is_test_larval(larval) &&
> >  		 !(alg->cra_flags & CRYPTO_ALG_TESTED))
> >  		alg = ERR_PTR(-EAGAIN);
> > +	else if (alg->cra_flags & CRYPTO_ALG_FIPS_INTERNAL)
> > +		alg = ERR_PTR(-EAGAIN);
> 
> I might be mistaken, but I think this would cause hmac(sha1)
> instantiation to fail if sha1 is not already there. I.e. if hmac(sha1)
> instantiation would load sha1, then it would invoke crypto_larval_wait()
> on the sha1 larval, see the FIPS_INTERNAL and fail?

When EAGAIN is returned the lookup is automatically retried.

> However, wouldn't it be possible to simply implement FIPS_INTERNAL
> lookups in analogy to the INTERNAL ones instead? That is, would adding
> 
> 	if (!((type | mask) & CRYPTO_ALG_FIPS_INTERNAL))
> 		mask |= CRYPTO_ALG_FIPS_INTERNAL;
> 
> to the preamble of crypto_alg_mod_lookup() work instead?

If you do that then you will end up creating an infinite number
of failed templates if you lookup something like hmac(md5).  Once
the first hmac(md5) is created it must then match all subsequent
lookups of hmac(md5) in order to prevent any further creation.

> This looks all good to me, but as !->fips_allowed tests aren't skipped
> over anymore now, it would perhaps make sense to make their failure
> non-fatal in FIPS mode. Because in FIPS mode a failure could mean a
> panic and some of the existing TVs might not pass because of e.g. some
> key length checks or so active only for fips_enabled...

You mean a buggy non-FIPS algorithm that fails when tested in
FIPS mode?  I guess we could skip the panic in that case if
everyone is happy with that.  Stephan?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
