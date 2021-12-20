Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59D747B033
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhLTP2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:28:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44366 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbhLTP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:27:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C93C7212CA;
        Mon, 20 Dec 2021 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640014056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKSPc75631I2JF+wWyleMZnwcll/dhBZr2X56fLkbiA=;
        b=t+E4AFpk9/HW0Rtm+37cKYtwaPHRkd8eaAl6xehTb7IA5Zko/BT9SJbEiLHQBz8BpZoRqN
        OmYy7HGsm3b+OUP7Ku+E3F4sskcHbOiNiCpJmT+yClr39ZozcBJ5LquVo2bR+QzM1Bs7GK
        siksm5dmI7ULhrZPs8yGZ+nVXgk2j4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640014056;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKSPc75631I2JF+wWyleMZnwcll/dhBZr2X56fLkbiA=;
        b=GLYbpWy7DxLGero4pKVs73fL2BFk4qLsdDJbBrM5yTStOheRSMQ5leDYZqumdPD1vWu040
        RnUgD1lpWMfKkzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D1D513D6B;
        Mon, 20 Dec 2021 15:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AS0tFeigwGFoOgAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 20 Dec 2021 15:27:36 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Nicolai Stange <nstange@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
Subject: Re: [PATCH v2 03/18] crypto: dh - optimize domain parameter serialization for well-known groups
References: <20211209090358.28231-1-nstange@suse.de>
        <20211209090358.28231-4-nstange@suse.de>
        <20211217055227.GA20698@gondor.apana.org.au>
Date:   Mon, 20 Dec 2021 16:27:35 +0100
In-Reply-To: <20211217055227.GA20698@gondor.apana.org.au> (Herbert Xu's
        message of "Fri, 17 Dec 2021 16:52:27 +1100")
Message-ID: <87r1a7thy0.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Herbert,

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Thu, Dec 09, 2021 at 10:03:43AM +0100, Nicolai Stange wrote:
>>> diff --git a/include/crypto/dh.h b/include/crypto/dh.h
>> index 67f3f6bca527..f0ed899e2168 100644
>> --- a/include/crypto/dh.h
>> +++ b/include/crypto/dh.h
>> @@ -19,6 +19,11 @@
>>   * the KPP API function call of crypto_kpp_set_secret.
>>   */
>>=20=20
>> +/** enum dh_group_id - identify well-known domain parameter sets */
>> +enum dh_group_id {
>> +	DH_GROUP_ID_UNKNOWN =3D 0, /* Constants are used in test vectors. */
>> +};
>
> We try to avoid hard-coded ID lists like these in the Crypto API.

Just for my understanding: the problem here is having a (single) enum
for the representation of all the possible "known" groups in the first
place or more that the individual group id enum members have hard-coded
values assigned to them each?


> I've had a look at your subsequent patches and I don't think you
> really need this.
>
> For instance, instead of shoehorning this into "dh", you could
> instead create new kpp algorithms modpXXXX and ffdheXXXX which
> can be templates around the underlying dh algorithm.

FWIW, when implementing this, I considered aligning more to the ecdh
API, namely to register separate algorithms for each dh group as you
suggested above: "dh-ffdhe2048" etc. in analogy to "ecdh-nist-p192" and
alike.

The various (three in total) ecdh-nist-* kpp_alg variants differ only in
their ->init(), which would all set ->curve_id to the corresponding
ECC_CURVE_NIST_* constant as appropriate.

However, after some back and forth, I opted against doing something
similar for dh at the time, because there are quite some more possible
parameter sets than there are for ecdh, namely ten vs. three. If we were
to render the KEYCTL_DH_COMPUTE functionality unusable in FIPS mode
alltogether (see below), I could drop the MODP* group support, but that
would still leave me with the five FFDHE* kpp_alg variants I had to at
least provide separate test vectors for. I think that these five TVs
would be quite redundant as they'd all merely test the implementation of
dh_set_secret() + dh_compute_value() with different input
parameters. This might be acceptable though, I only wanted to bring it
up.


Anyway, just to make sure I'm getting it right: when you're saying
"template", you mean to implement a crypto_template for instantiating
patterns like "dh(ffdhe2048)", "dh(ffdhe3072)" and so on? The dh(...)
template instantiations would keep a crypto_spawn for referring to the
underlying, non-template "dh" kpp_alg so that "dh" implementations of
higher priority (hpre + qat) would take over once they'd become
available, correct?

AFAICS, it would make sense to introduce something like struct
kpp_instance, crypto_kpp_spawn and associated helpers as a prerequisite
then. Which wouldn't be a problem by me, just saying that it's not there
yet. I'm not sure there would be other potential users of such an
infrastructure, perhaps Stephan's SP800-108 KDF ([1]) is a candidate?


> Sure this might involve a copy of the parameters but given the speed
> of the algorithms that we're talking about here I don't think it's
> really relevant.

Ok, understood. I'm by no means a FIPS expert, but I bet I'd still have
to somehow convey a flag like "this group parameter P is approved" from
the frontend template instantiations like "dh(ffdhe2048)" to the
underlying "dh" implementation and make the latter reject any
non-approved groups. That is, with my limited experience with FIPS, I'd
expect that disabling the only known path to get non-approved parameters
into "dh", i.e. KEYCTL_DH_COMPUTE, would not be sufficient for achieving
conformance. Note that those dh_group_id's previously serialized via
crypto_dh_encode_key() served this purpose, in addition to enabling that
optimization of not copying the Ps when possible.

I'm not really sure, but simply introducing a flag like ->fips_approved
to struct dh and serializing that as an alternative would probably not
work out, because it would in theory still allow potential "dh" users to
set it (e.g. by accident) even when specifying non-approved Ps.

Stephan?


>
> That way the underlying drivers don't need to be touched at all.

FWIW, I touched the drivers only for consistency with ecdh and the
related drivers/crypto implementations, which all invoke the privkey
generation from their resp. ->set_secret().

As an alternative, I could have also made crypto_dh_encode_key() to
generate an ephemeral key on the fly for input ->key_size =3D=3D 0. This
wouldn't be much different from how I'd imagine a dh(...) template based
approach to work: its ->set_secret() would take a private key, if any,
and
- generate a private key if none has been specified,
- kmalloc() a buffer for crypto_dh_encode_key(),
- serialize the key, P and G for the underlying "dh" implementation via
  crypto_dh_encode_key(),
- pass the encoded result onwards to the underlying "dh"'s
  ->set_secret() and
- kfree() the buffer again.

So instead of having the proposed template's ->set_secret() wrapper
around crypto_dh_encode_key() to take care of generating ephemeral keys,
I could have made the latter to do that as well, I think.


> Yes I do realise that this means the keyrings DH user-space API
> cannot be used in FIPS mode, but that is probably a good thing
> as users who care about modp/ffdhe shouldn't really have to stuff
> the raw vectors into this interface just to access the kernel DH
> implementation.

The sole purpose of introducing the MODP* parameters with this patchset
had been to keep KEYCTL_DH_COMPUTE functional in FIPS mode to the extent
possible: NVMe in-band authentication OTOH needs only FFHDE*. If it
would be acceptable or even desirable to render KEYCTL_DH_COMPUTE
unusable in FIPS mode, I'd drop the MODP* related patches.

However, it would perhaps be fair to reflect KEYCTL_DH_COMPUTE's new
dependency on !fips_enabled in keyctl_capabilities() then, but this can
probably be done with a separate follow-up patch.


>
> On a side note, are there really keyrings DH users out there in
> the wild? If not can we deprecate and remove this interface
> completely?

I wondered the same when first looking into this -- a web search
returned the Embedded Linux library ([2]), which seems to rely on
KEYCTL_DH_COMPUTE for implementing TLS (web servers for embedded
devices?). Then there's the keyctl(1) utility, which exposes this
interface via its "dh_compute" subcommand. Lastly, there exist some Rust
and Go bindings also -- hard to say if anything is using those.


Thanks!

Nicolai

[1] https://lore.kernel.org/r/4642773.OV4Wx5bFTl@positron.chronox.de
[2] https://git.kernel.org/pub/scm/libs/ell/ell.git/

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
