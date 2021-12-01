Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D19146483B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbhLAHbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:31:24 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43490 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhLAHbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:31:22 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E367F1FD58;
        Wed,  1 Dec 2021 07:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638343680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vITv66nrLsCY3ceXgLRzjbEaUVbSjy/+8VfYifLFPEo=;
        b=SX5L1dGtRG+RvZG/1Bo+Qft9yPaSAFz3aOBFznojsOCcw7Pn6vB92t3m36kOk5mqKJW2u0
        gdd8AaTTHLIdU97qFariE2AOo1mG+sNIQb9rh+LgC9+Ec12m/VoaMx7nLBVzY1J81TwJE2
        CtnFYmco/QWMUy7CPuy2fEyC3Z57BV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638343680;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vITv66nrLsCY3ceXgLRzjbEaUVbSjy/+8VfYifLFPEo=;
        b=oDoBI18+Vig9glTMBXiwpSYWxmYyleZE5pghZmFKvJewFrW0eN19JLkXdBHQLW6t+4orz2
        BcrzrW3xuZITltCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0E4D13AE2;
        Wed,  1 Dec 2021 07:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vL0PJgAkp2FxFQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:28:00 +0000
Subject: Re: [PATCH 08/18] crypto: testmgr - run only subset of DH vectors
 based on config
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
References: <20211201004858.19831-1-nstange@suse.de>
 <20211201004858.19831-9-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e93452b8-5779-c2a8-b099-3910eba9a88e@suse.de>
Date:   Wed, 1 Dec 2021 08:28:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-9-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> With the previous patches, the testmgr now has up to four test vectors for
> DH which all test more or less the same thing:
> - the two vectors from before this series,
> - the vector for the ffdhe2048 group, enabled if
>    CONFIG_CRYPTO_DH_GROUPS_RFC7919 is set and
> - the vector for the modp2048 group, similarly enabled if
>    CONFIG_CRYPTO_DH_GROUPS_RFC3526 is set.
> 
> In order to avoid too much redundancy during DH testing, enable only a
> subset of these depending on the kernel config:
> - if CONFIG_CRYPTO_DH_GROUPS_RFC7919 is set, enable only the ffdhe2048
>    vector,
> - otherwise, if CONFIG_CRYPTO_DH_GROUPS_RFC3526 is set, enable only
>    the modp2048 vector and
> - only enable the original two vectors if neither of these options
>    has been selected.
> 
> Note that an upcoming patch will make the DH implementation to reject any
> domain parameters not corresponding to some safe-prime group approved by
> SP800-56Arev3 in FIPS mode. Thus, having CONFIG_FIPS enabled, but
> both of CONFIG_CRYPTO_DH_GROUPS_RFC7919 and
> CONFIG_CRYPTO_DH_GROUPS_RFC3526 unset wouldn't make much sense as it would
> render the DH implementation unusable in FIPS mode. Conversely, any
> reasonable configuration would ensure that the original, non-conforming
> test vectors would not get to run in FIPS mode.
> 

For some weird reason the NVMe spec mandates for its TLS profile the 
ffdhe3072 group, so I would prefer if you would be using that as the 
default group for testing.

> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/testmgr.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
> index d18844c7499e..b295512c8f22 100644
> --- a/crypto/testmgr.h
> +++ b/crypto/testmgr.h
> @@ -1331,8 +1331,7 @@ static const struct kpp_testvec dh_tv_template[] = {
>   	.expected_a_public_size = 256,
>   	.expected_ss_size = 256,
>   	},
> -#endif /* IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC7919) */
> -#if IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526)
> +#elif IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526)
>   	{
>   	.secret =
>   #ifdef __LITTLE_ENDIAN
> @@ -1423,7 +1422,7 @@ static const struct kpp_testvec dh_tv_template[] = {
>   	.expected_a_public_size = 256,
>   	.expected_ss_size = 256,
>   	},
> -#endif /* IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526) */
> +#else
>   	{
>   	.secret =
>   #ifdef __LITTLE_ENDIAN
> @@ -1642,6 +1641,7 @@ static const struct kpp_testvec dh_tv_template[] = {
>   	.expected_a_public_size = 256,
>   	.expected_ss_size = 256,
>   	},
> +#endif
>   };
>   
>   static const struct kpp_testvec curve25519_tv_template[] = {
> 
... and maybe add a config option to run a full test.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
