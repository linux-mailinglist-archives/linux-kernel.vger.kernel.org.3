Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD04F4A6E68
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiBBKJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:09:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34058 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiBBKJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:09:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DCFA1F37C;
        Wed,  2 Feb 2022 10:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643796594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rv3DpmMzmKwvVC3/qSgFBvA6xDpaSKNqJgEBvx5lH/8=;
        b=TENCR/hDabRnO7kSTRbkZIZ2z7f25vnwCjT6dczFEwgnrUYYXFFjvzDg/YbJhN74UMfg0X
        EruqeGJfVu+nEqls6mm8gBqeVS4r8zXnrzK//qxSPv/b21Elr+Hhr0Gq5cDuzh2E9yGm3F
        hjMmvMVpV4gpWxCJ8fu/HkmHEt+Tdc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643796594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rv3DpmMzmKwvVC3/qSgFBvA6xDpaSKNqJgEBvx5lH/8=;
        b=PLsEmUNpOxm84VIsEeLE6VrC7TR6K4vFEtNhzkf0QQ+gj0NtWXWPrTvVEWewtRmNjD1v0e
        WFMuSXwrwYdzeFCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D463813DFF;
        Wed,  2 Feb 2022 10:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S0WwMXFY+mFkWwAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 02 Feb 2022 10:09:53 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Nicolai Stange <nstange@suse.de>,
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
References: <20211209090358.28231-1-nstange@suse.de>
        <YeFWnscvXtv73KBl@gondor.apana.org.au> <87v8y4dk1c.fsf@suse.de>
        <1738803.My4pmAdfGn@tauon.chronox.de>
Date:   Wed, 02 Feb 2022 11:09:53 +0100
In-Reply-To: <1738803.My4pmAdfGn@tauon.chronox.de> (Stephan Mueller's message
        of "Fri, 28 Jan 2022 16:49:54 +0100")
Message-ID: <87czk5vatq.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

Stephan Mueller <smueller@chronox.de> writes:

> Am Freitag, 28. Januar 2022, 15:14:39 CET schrieb Nicolai Stange:
>
>> Herbert Xu <herbert@gondor.apana.org.au> writes:
>> > On Fri, Jan 14, 2022 at 10:09:02AM +0100, Nicolai Stange wrote:
>> >> This looks all good to me, but as !->fips_allowed tests aren't skipped
>> >> over anymore now, it would perhaps make sense to make their failure
>> >> non-fatal in FIPS mode. Because in FIPS mode a failure could mean a
>> >> panic and some of the existing TVs might not pass because of e.g. some
>> >> key length checks or so active only for fips_enabled...
>> >=20
>> > You mean a buggy non-FIPS algorithm that fails when tested in
>> > FIPS mode?  I guess we could skip the panic in that case if
>> > everyone is happy with that.  Stephan?
>>=20
>> One more thing I just realized: dracut's fips module ([1]) modprobes
>> tcrypt (*) and failure is considered fatal, i.e. the system would not
>> boot up.
>>=20
>> First of all this would mean that tcrypt_test() needs to ignore
>> -ECANCELED return values from alg_test() in FIPS mode, in addition to
>> the -EINVAL it is already prepared for.
>>=20
>> However, chances are that some of the !fips_allowed algorithms looped
>> over by tcrypt are not available (i.e. not enabled at build time) and as
>> this change here makes alg_test() to unconditionally attempt a test
>> execution now, this would fail with -ENOENT AFAICS.
>>=20
>> One way to work around this is to make tcrypt_test() to ignore -ENOENT
>> in addition to -EINVAL and -ECANCELED.
>>=20
>> It might be undesirable though that the test executions triggered from
>> tcrypt would still instantiate/load a ton of !fips_allowed algorithms at
>> boot, most of which will effectively be inaccessible (because they're
>> not used as FIPS_INTERNAL arguments to fips_allowed =3D=3D 1 template
>> instances).
>>=20
>> So how about making alg_test() to skip the !fips_allowed tests in FIPS
>> mode as before, but to return -ECANCELED and eventually set
>> FIPS_INTERNAL as implemented with this patch here.
>>=20
>> This would imply that FIPS_INTERNAL algorithms by themselves remain
>> untested, but I think this might be Ok as they would be usable only as
>> template arguments in fips_allowed instantiations. That is, they will
>> still receive some form of testing when the larger construction they're
>> part of gets tested.
>>=20
>> For example, going with the "dh" example, where "dh" and "ffdhe3072(dh)"
>> would have fips_allowed unset and set respecively, ffdhe3072(dh) as
>> a whole would get tested, but not the "dh" argument individually.
>>=20
>> Stephan, would this approach work from a FIPS 140-3 perspective?
>
> Are we sure that we always will have power-up tests of the compound algor=
ithms=20
> when we disable the lower-level algorithm testing?

Yes. The compound algorithms having ->fips_allowed =3D=3D 1 and alg_test_nu=
ll
entries are:

  authenc(hmac(sha1),ctr(aes))
  authenc(hmac(sha1),rfc3686(ctr(aes)))
  authenc(hmac(sha256),ctr(aes))
  authenc(hmac(sha256),rfc3686(ctr(aes)))
  authenc(hmac(sha384),ctr(aes))
  authenc(hmac(sha384),rfc3686(ctr(aes)))
  authenc(hmac(sha512),ctr(aes))
  authenc(hmac(sha512),rfc3686(ctr(aes)))

The hmac(sha*), ctr(aes) and rfc3686(ctr(aes)) all have
->fips_allowed =3D=3D 1 and proper non-alg_test_null test entries. So no
change here.

  cbc(paes)
  ctr(paes)
  ecb(paes)
  ofb(paes)
  xts(paes)
  xts4096(paes)
  xts512(paes)
  cts(cbc(paes))

As ecb(paes) has only a alg_test_null() entry, no test would have been
performed at all before this change for these. So no change here either.
=20=20
  ecb(cipher_null)

No change here either.

  pkcs1pad(rsa,sha224)
  pkcs1pad(rsa,sha384)
  pkcs1pad(rsa,sha512)

The sha* and rsa all have ->fips_allowed =3D=3D 1 and proper
non-alg_test_null test entries. So no change here.


>
> For example, consider the DH work you are preparing: we currently have a =
self=20
> test for dh - which then will be marked as FIPS_INTERNAL and not executed=
.=20
> Would we now have self tests for modpXXX(dh) or ffdheXXX(dh)?

Yes, exactly.

> If not, how would it be guaranteed that DH is tested?
>
> The important part is that the algorithm testing is guaranteed. I see a n=
umber=20
> of alg_test_null in testmgr.c. I see the potential that some algorithms d=
o not=20
> get tested at all when we skip FIPS_INTERNAL algorithms.

See above. But of course one needs to be careful not to add
->fips_allowed + alg_test_null entries for compound algorithms where any
of the template arguments isn't approved in the future.


> From a FIPS perspective it is permissible that compound algo power up tes=
ts=20
> are claimed to cover respective lower-level algos.

Perfect.

Thanks,

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
