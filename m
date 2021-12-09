Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08CD46E587
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhLIJaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:30:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58714 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbhLIJaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:30:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1BA07210FE;
        Thu,  9 Dec 2021 09:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639042007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtKIUOMPy0NblW3VFtYGUkjRQBTszF1b6jNjkGwGIf8=;
        b=EUNner1glnq+8w2kq0hETRRjCSdDzvdHoJoeh4insomOJ5HlzGHW2jVslWvVX22RthTfvG
        HjpbQdlKiWBE8Yzo7BpmvKvwCIsYaCaVd8l1A7T8NX2MA6SOf5veTTWNhY1FViHHf2tnBE
        A4T0gChrCeDIWn9C/zydxHMfqtZ4ojs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639042007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtKIUOMPy0NblW3VFtYGUkjRQBTszF1b6jNjkGwGIf8=;
        b=o98OfxvGHLkR4BvsJUOMLqopsGw40w7E7svTOkZlboTnOQ3/YI8pZVDnfE+C9RvRNf3+xt
        z149UMO52rajHwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D6E913CB1;
        Thu,  9 Dec 2021 09:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IUSvINbLsWFueQAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:26:46 +0000
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
Subject: Re: [PATCH 18/18] crypto: dh - accept only approved safe-prime groups in FIPS mode
References: <20211201004858.19831-1-nstange@suse.de>
        <20211201004858.19831-19-nstange@suse.de>
        <aed13346-94b7-80db-5a80-058e6dfd5bd0@suse.de>
Date:   Thu, 09 Dec 2021 10:26:46 +0100
In-Reply-To: <aed13346-94b7-80db-5a80-058e6dfd5bd0@suse.de> (Hannes Reinecke's
        message of "Wed, 1 Dec 2021 08:34:49 +0100")
Message-ID: <87sfv2dt7t.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> writes:

> On 12/1/21 1:48 AM, Nicolai Stange wrote:
>> SP800-56Arev3, sec. 5.5.2 ("Assurance of Domain-Parameter Validity")
>> asserts that an implementation needs to verify domain paramtere validity,
>> which boils down to either
>> - the domain parameters corresponding to some known safe-prime group
>>    explicitly listed to be approved in the document or
>> - for parameters conforming to a "FIPS 186-type parameter-size set",
>>    that the implementation needs to perform an explicit domain parameter
>>    verification, which would require access to the "seed" and "counter"
>>    values used in their generation.
>>
>> The latter is not easily feasible and moreover, SP800-56Arev3 states that
>> safe-prime groups are preferred and that FIPS 186-type parameter sets
>> should only be supported for backward compatibility, if it all.
>>
>> Make the dh implementations reject any domain parameters which don't
>> correspond to any of the approved safe-prime groups in FIPS mode. The
>> approved safe-prime groups are the ones specified in RFC 7919 and RFC 35=
26,
>> and given that all possible values of enum dh_group_id correspond to
>> either groups from these RFCs or to dh_group_id_unknown, it suffices to
>> make crypto_dh_decode_key() to reject any parameter set where
>> ->group_id =3D=3D dh_group_id_unknown.
>>
>> As this change will effectively render the dh implementation unusable in
>> FIPS mode if neither of the CRYPTO_DH_GROUPS_RFC7919 or
>> CRYPTO_DH_GROUPS_RFC3526 Kconfig options enabled, make CRYPTO_DH imply
>> these two if CRYPTO_FIPS is set.
>>
>> Signed-off-by: Nicolai Stange <nstange@suse.de>
>> ---
>>   crypto/Kconfig     | 2 ++
>>   crypto/dh_helper.c | 4 ++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/crypto/Kconfig b/crypto/Kconfig
>> index 578711b02bb3..571f2271ad2e 100644
>> --- a/crypto/Kconfig
>> +++ b/crypto/Kconfig
>> @@ -229,6 +229,8 @@ menuconfig CRYPTO_DH
>>   	select CRYPTO_KPP
>>   	select MPILIB
>>   	select CRYPTO_RNG_DEFAULT
>> +	imply CRYPTO_DH_GROUPS_RFC7919 if CRYPTO_FIPS
>> +	imply CRYPTO_DH_GROUPS_RFC3526 if CRYPTO_FIPS
>>   	help
>>   	  Generic implementation of the Diffie-Hellman algorithm.
>>   diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
>> index cf632beca65e..f30674df0d76 100644
>> --- a/crypto/dh_helper.c
>> +++ b/crypto/dh_helper.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/export.h>
>>   #include <linux/err.h>
>>   #include <linux/string.h>
>> +#include <linux/fips.h>
>>   #include <crypto/dh.h>
>>   #include <crypto/kpp.h>
>>   #include <crypto/rng.h>
>> @@ -622,6 +623,9 @@ int crypto_dh_decode_key(const char *buf, unsigned i=
nt len, struct dh *params)
>>   	    params->g_size > params->p_size)
>>   		return -EINVAL;
>>   +	/* Only safe-prime groups are allowed in FIPS mode. */
>> +	if (fips_enabled && params->group_id =3D=3D dh_group_id_unknown)
>> +		return -EINVAL;
>>     	return 0;
>>   }
>>
> That was cheap.
> Maybe merge it with the previous patch?

FWIW, I kept this separate in v2: the code change is trivial for sure,
but as this is FIPS related, the premise might be controversial and I
don't want to hide it in a larger patch.

Thanks,

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
