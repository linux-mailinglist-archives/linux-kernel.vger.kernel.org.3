Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96AE46E55E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhLIJWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:22:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57710 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbhLIJWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:22:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3106F210FE;
        Thu,  9 Dec 2021 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639041508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QbRyvBJU2JXdRLiMrJcVE+/FZ0lf/5cszXO/3hkGeA=;
        b=br7GlOg3MXNIzCHMhtyt7zDsiMaTOousswnpmK8aBb2nzWt9e1wSltwPsYn88WopT1ljRh
        lRMtkGoNRe7yfGT+Aov2iywIHrzfoFPxVkXXvr6YccmSlNE83HOUbj2W/3rxTzsO7/sVib
        h/OgLLw/lS+/WRjOlXRRdn4omPtA7NA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639041508;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QbRyvBJU2JXdRLiMrJcVE+/FZ0lf/5cszXO/3hkGeA=;
        b=LtBEQO3g4DUG39BKOwhj4qJAibV+NyZab5/zl4O8H6F+tp48NFrMXpCM4xo957NtcFKG4i
        qQ3G7OmlFhiGJdAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D81013CBE;
        Thu,  9 Dec 2021 09:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yZx3IOPJsWFqcgAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:18:27 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>, Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
Subject: Re: [PATCH 08/18] crypto: testmgr - run only subset of DH vectors based on config
References: <20211201004858.19831-1-nstange@suse.de>
        <20211201004858.19831-9-nstange@suse.de>
        <e93452b8-5779-c2a8-b099-3910eba9a88e@suse.de>
Date:   Thu, 09 Dec 2021 10:18:27 +0100
In-Reply-To: <e93452b8-5779-c2a8-b099-3910eba9a88e@suse.de> (Hannes Reinecke's
        message of "Wed, 1 Dec 2021 08:28:00 +0100")
Message-ID: <87sfv2kufw.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> writes:

> On 12/1/21 1:48 AM, Nicolai Stange wrote:
>> With the previous patches, the testmgr now has up to four test vectors f=
or
>> DH which all test more or less the same thing:
>> - the two vectors from before this series,
>> - the vector for the ffdhe2048 group, enabled if
>>    CONFIG_CRYPTO_DH_GROUPS_RFC7919 is set and
>> - the vector for the modp2048 group, similarly enabled if
>>    CONFIG_CRYPTO_DH_GROUPS_RFC3526 is set.
>>
>> In order to avoid too much redundancy during DH testing, enable only a
>> subset of these depending on the kernel config:
>> - if CONFIG_CRYPTO_DH_GROUPS_RFC7919 is set, enable only the ffdhe2048
>>    vector,
>> - otherwise, if CONFIG_CRYPTO_DH_GROUPS_RFC3526 is set, enable only
>>    the modp2048 vector and
>> - only enable the original two vectors if neither of these options
>>    has been selected.
>>
>> Note that an upcoming patch will make the DH implementation to reject any
>> domain parameters not corresponding to some safe-prime group approved by
>> SP800-56Arev3 in FIPS mode. Thus, having CONFIG_FIPS enabled, but
>> both of CONFIG_CRYPTO_DH_GROUPS_RFC7919 and
>> CONFIG_CRYPTO_DH_GROUPS_RFC3526 unset wouldn't make much sense as it wou=
ld
>> render the DH implementation unusable in FIPS mode. Conversely, any
>> reasonable configuration would ensure that the original, non-conforming
>> test vectors would not get to run in FIPS mode.
>>
>
> For some weird reason the NVMe spec mandates for its TLS profile the
> ffdhe3072 group, so I would prefer if you would be using that as the
> default group for testing.

Done for v2.

>
>> Signed-off-by: Nicolai Stange <nstange@suse.de>
>> ---
>>   crypto/testmgr.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
>> index d18844c7499e..b295512c8f22 100644
>> --- a/crypto/testmgr.h
>> +++ b/crypto/testmgr.h
>> @@ -1331,8 +1331,7 @@ static const struct kpp_testvec dh_tv_template[] =
=3D {
>>   	.expected_a_public_size =3D 256,
>>   	.expected_ss_size =3D 256,
>>   	},
>> -#endif /* IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC7919) */
>> -#if IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526)
>> +#elif IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526)
>>   	{
>>   	.secret =3D
>>   #ifdef __LITTLE_ENDIAN
>> @@ -1423,7 +1422,7 @@ static const struct kpp_testvec dh_tv_template[] =
=3D {
>>   	.expected_a_public_size =3D 256,
>>   	.expected_ss_size =3D 256,
>>   	},
>> -#endif /* IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526) */
>> +#else
>>   	{
>>   	.secret =3D
>>   #ifdef __LITTLE_ENDIAN
>> @@ -1642,6 +1641,7 @@ static const struct kpp_testvec dh_tv_template[] =
=3D {
>>   	.expected_a_public_size =3D 256,
>>   	.expected_ss_size =3D 256,
>>   	},
>> +#endif
>>   };
>>     static const struct kpp_testvec curve25519_tv_template[] =3D {
>>
> ... and maybe add a config option to run a full test.

I didn't do this at this point, because I don't see much value in
running tests on more than one randomly selected DH group, i.e. on
ffdhe3072 and modp2048: both test vectors test the same code paths.

It might perhaps make sense to run tests for all the DH safe-prime
groups each for verifying that the resp. ->p primes are all correct. But
that would be a large TV dump and I'm not sure it would be desirable...

Thanks,

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
