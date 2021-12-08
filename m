Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2255446CDCD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 07:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbhLHGfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 01:35:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34972 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbhLHGff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 01:35:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1E2B31FDFE;
        Wed,  8 Dec 2021 06:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638945123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/OFgrJg3W9nn6/Kqzh+BgZeGYFx7UuSvS81HK6RnJQ=;
        b=iDFsPJqXvCDcZRCkP21WE8uoRqRheLnzGlbYvZBBoFvWAxdC86lbmNWQZyEGpH1o+TdR22
        6I4At0mt2DvnGYOPNW3JRbJxTreDXwk3xjGwW/gTLigPHmcD/dR1Ikjd0nhvnh+Po179Bq
        UhPpsGOAPoHpZSa+aj+SKyMpMitYUeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638945123;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/OFgrJg3W9nn6/Kqzh+BgZeGYFx7UuSvS81HK6RnJQ=;
        b=lfi5w1Ph7bw+I2rCtpAIDNgDYj+DwNooYMybWDawUplTGGMR49FgFb06Q1hYExxBffk15D
        n71El7Wxyp7Y/XCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4652F13B49;
        Wed,  8 Dec 2021 06:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KRZbD2JRsGHfPwAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 08 Dec 2021 06:32:02 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
Subject: Re: [PATCH 10/18] crypto: dh - introduce support for ephemeral key generation to dh-generic
In-Reply-To: <1972149.YKUYFuaPT4@positron.chronox.de> ("Stephan
 \=\?utf-8\?Q\?M\=C3\=BCller\=22's\?\=
        message of "Sun, 05 Dec 2021 07:11:22 +0100")
References: <20211201004858.19831-1-nstange@suse.de>
        <20211201004858.19831-11-nstange@suse.de>
        <1972149.YKUYFuaPT4@positron.chronox.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
Date:   Wed, 08 Dec 2021 07:32:02 +0100
Message-ID: <87czm7ehel.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan M=C3=BCller <smueller@chronox.de> writes:

> Am Mittwoch, 1. Dezember 2021, 01:48:50 CET schrieb Nicolai Stange:
>
> Hi Nicolai,
>
>> The support for NVME in-band authentication currently in the works ([1])
>> needs to generate ephemeral DH keys. Make dh-generic's ->set_secret()
>> to generate an ephemeral key via the recently added crypto_dh_gen_privke=
y()
>> in case the input ->key_size is zero. Note that this behaviour is in
>> analogy to ecdh's ->set_secret().
>>=20
>> [1] https://lkml.kernel.org/r/20211122074727.25988-4-hare@suse.de
>>=20
>> Signed-off-by: Nicolai Stange <nstange@suse.de>
>> ---
>>  crypto/dh.c | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/crypto/dh.c b/crypto/dh.c
>> index 131b80064cb1..2e49b114e038 100644
>> --- a/crypto/dh.c
>> +++ b/crypto/dh.c
>> @@ -71,25 +71,41 @@ static int dh_set_secret(struct crypto_kpp *tfm, con=
st
>> void *buf, {
>>  	struct dh_ctx *ctx =3D dh_get_ctx(tfm);
>>  	struct dh params;
>> +	char key[CRYPTO_DH_MAX_PRIVKEY_SIZE];
>> +	int err;
>>=20
>>  	/* Free the old MPI key if any */
>>  	dh_clear_ctx(ctx);
>>=20
>> -	if (crypto_dh_decode_key(buf, len, &params) < 0)
>> +	err =3D crypto_dh_decode_key(buf, len, &params);
>> +	if (err)
>>  		goto err_clear_ctx;
>>=20
>> -	if (dh_set_params(ctx, &params) < 0)
>> +	if (!params.key_size) {
>
> As this params data may come from user space, shouldn't we use the same l=
ogic=20
> as in ecdh's set_key function:
>
> if (!params.key || !params.key_size)

crypto_dh_decode_key() always leaves params.key set even for
!params.key_size, so checking for !params.key wouldn't buy anything
here. FWIW, it seems like it's actually the same for
crypto_ecdh_decode_key().

I'd personally prefer to not add the !params.key check, because it would
suggest that there are code paths which can lead to the condition
params.key_size && !params.key. I would find this confusing when reading
the code, but OTOH I don't have strong objections, so if you insist on
adding the !params.key check, I'd be Ok with it.

Thanks,

Nicolai

>
> ?
>
>
>> +		err =3D crypto_dh_gen_privkey(params.group_id, key,
>> +					    &params.key_size);
>> +		if (err)
>> +			goto err_clear_ctx;
>> +		params.key =3D key;
>> +	}
>> +
>> +	err =3D dh_set_params(ctx, &params);
>> +	if (err)
>>  		goto err_clear_ctx;
>>=20
>>  	ctx->xa =3D mpi_read_raw_data(params.key, params.key_size);
>> -	if (!ctx->xa)
>> +	if (!ctx->xa) {
>> +		err =3D -EINVAL;
>>  		goto err_clear_ctx;
>> +	}
>> +
>> +	memzero_explicit(key, sizeof(key));
>>=20
>>  	return 0;
>>=20
>>  err_clear_ctx:
>>  	dh_clear_ctx(ctx);
>> -	return -EINVAL;
>> +	return err;
>>  }
>>=20
>>  /*
>
>
> Ciao
> Stephan
>
>

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
