Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2280148E9F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbiANMeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:34:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46536 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiANMeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:34:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FDB821995;
        Fri, 14 Jan 2022 12:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642163660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8poY4M1IFG372E11KweWs3Mw4bqPQSe2IueiIl0Mx2A=;
        b=pzZOeD0+2HDFE3xm6WG7DuzQJUD6o7HSrrytnEEj3fOw4pf/Dct3k3VsrsE84hm6lpEQ42
        885kaHtchCNK+mTjO1n56++QBgAGlFuD5n4uoeRjiQUVhb5yWHyl8wRf4TSlretEI5GJdK
        WtyFi58fKA13nr4KoCC7Lyj+sojjesk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642163660;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8poY4M1IFG372E11KweWs3Mw4bqPQSe2IueiIl0Mx2A=;
        b=avvPBmr/E/GHXPLc5QwfkPONWxKIo/THvrVUoJtreFkwV2pHwakXz1YKv7lQLEsZwVHGxr
        h7LTPZbnBH2S17AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 787D113C18;
        Fri, 14 Jan 2022 12:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HZWkG8tt4WGdbgAAMHmgww
        (envelope-from <nstange@suse.de>); Fri, 14 Jan 2022 12:34:19 +0000
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
        <YeEVSaMEVJb3cQkq@gondor.apana.org.au> <87k0f2hefl.fsf@suse.de>
        <YeFWnscvXtv73KBl@gondor.apana.org.au>
Date:   Fri, 14 Jan 2022 13:34:18 +0100
In-Reply-To: <YeFWnscvXtv73KBl@gondor.apana.org.au> (Herbert Xu's message of
        "Fri, 14 Jan 2022 21:55:26 +1100")
Message-ID: <87a6fyh4xh.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Fri, Jan 14, 2022 at 10:09:02AM +0100, Nicolai Stange wrote:
>>
>> I wonder whether this can be made more generic. I.e. would it be possible
>> to make crypto_grab_spawn() to or in FIPS_INTERNAL into type (iff !(mask
>> & FIPS_INTERNAL)) and to make crypto_register_instance() to propagate
>> FIPS_INTERNAL from the template instance's spawns upwards into the
>> instance's ->cra_flags?
>
> We could certainly do something like that in future.  But it
> isn't that easy because crypto_register_instance doesn't know
> what the paramter algorithm(s) is/are.

I was thinking of simply walking through the inst->spawns list for that.


>
>> On an unrelated note, this will break trusted_key_tpm_ops->init() in
>> FIPS mode, because trusted_shash_alloc() would fail to get a hold of
>> sha1. AFAICT, this could potentially make the init_trusted() module_init
>> to fail, and, as encrypted-keys.ko imports key_type_trusted, prevent the
>> loading of that one as well. Not sure that's desired...
>
> Well if sha1 is supposed to be forbidden in FIPS mode why should
> TPM be allowed to use it?=20

Yes, I only wanted to point out that doing that could potentially have
unforseen consequences as it currently stands, like
e.g. encrypted-keys.ko loading failures, even though the latter doesn't
even seem to use sha1 by itself.

However, this scenario would be possible only for CONFIG_TRUSTED_KEYS=3Dm,
CONFIG_TEE=3Dn and tpm_default_chip() returning something.


> If it must be allowed, then we could change TPM to set the
> FIPS_INTERNAL flag.
>
> I think I'll simply leave out the line that actually disables sha1
> for now.
>
>> > diff --git a/crypto/api.c b/crypto/api.c
>> > index cf0869dd130b..549f9aced1da 100644
>> > --- a/crypto/api.c
>> > +++ b/crypto/api.c
>> > @@ -223,6 +223,8 @@ static struct crypto_alg *crypto_larval_wait(struc=
t crypto_alg *alg)
>> >  	else if (crypto_is_test_larval(larval) &&
>> >  		 !(alg->cra_flags & CRYPTO_ALG_TESTED))
>> >  		alg =3D ERR_PTR(-EAGAIN);
>> > +	else if (alg->cra_flags & CRYPTO_ALG_FIPS_INTERNAL)
>> > +		alg =3D ERR_PTR(-EAGAIN);
>>=20
>> I might be mistaken, but I think this would cause hmac(sha1)
>> instantiation to fail if sha1 is not already there. I.e. if hmac(sha1)
>> instantiation would load sha1, then it would invoke crypto_larval_wait()
>> on the sha1 larval, see the FIPS_INTERNAL and fail?
>
> When EAGAIN is returned the lookup is automatically retried.

Ah right, just found the loop in cryptomgr_probe().


>
>> However, wouldn't it be possible to simply implement FIPS_INTERNAL
>> lookups in analogy to the INTERNAL ones instead? That is, would adding
>>=20
>> 	if (!((type | mask) & CRYPTO_ALG_FIPS_INTERNAL))
>> 		mask |=3D CRYPTO_ALG_FIPS_INTERNAL;
>>=20
>> to the preamble of crypto_alg_mod_lookup() work instead?
>
> If you do that then you will end up creating an infinite number
> of failed templates if you lookup something like hmac(md5).  Once
> the first hmac(md5) is created it must then match all subsequent
> lookups of hmac(md5) in order to prevent any further creation.

Thanks for the explanation, it makes sense now.

>
>> This looks all good to me, but as !->fips_allowed tests aren't skipped
>> over anymore now, it would perhaps make sense to make their failure
>> non-fatal in FIPS mode. Because in FIPS mode a failure could mean a
>> panic and some of the existing TVs might not pass because of e.g. some
>> key length checks or so active only for fips_enabled...
>
> You mean a buggy non-FIPS algorithm that fails when tested in
> FIPS mode?

Yes, I can't tell how realistic that is though.


> I guess we could skip the panic in that case if everyone is happy with
> that.  Stephan?
>

Thanks,

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
