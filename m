Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76712464859
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347517AbhLAHcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:32:12 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43510 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347540AbhLAHcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:32:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A3C61FD58;
        Wed,  1 Dec 2021 07:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638343727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=daENsoaCp97Bu9Tq80zHy5qetiTXSh4XFCCKPoNigBk=;
        b=D+UWjBnWoLPYtKwkFkTdaO15M3QAX48NHQgLgjYuEq1uxMURyA+YmnH39pGSchTI914l5n
        VarsRy5tIsUcrjTHb3rpNJypSmhjGb0CLATA6xMAAuz17p8O1Adv6HZ462Y+h022kZUy+F
        0phfTCvEJTe6fKKXoLuKuz1LQ43Mesc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638343727;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=daENsoaCp97Bu9Tq80zHy5qetiTXSh4XFCCKPoNigBk=;
        b=+lpIEvQkIoYZ0VpmXcVA+d4bSYBzIjJ3avxzc811+R9GlWNAoo4CTx0Hfsaw7lF8qAP0XI
        h0FfSmGo25yKRVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E781E13AE2;
        Wed,  1 Dec 2021 07:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xi+iNy4kp2GoFQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:28:46 +0000
Subject: Re: [PATCH 09/18] crypto: dh - implement private key generation
 primitive
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
 <20211201004858.19831-10-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b0c981ed-2ba2-e884-d2b5-4d4b3fc8c04b@suse.de>
Date:   Wed, 1 Dec 2021 08:28:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-10-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> The support for NVME in-band authentication currently in the works ([1])
> needs to generate ephemeral DH keys.
> 
> Implement crypto_dh_gen_privkey() which is intended to be used from
> the DH implementations just in analogy to how ecc_gen_privkey() is used
> for ECDH.
> 
> Make the new crypto_dh_gen_privkey() to follow the approach specified
> in SP800-56Arev3, sec. 5.6.1.1.3 ("Key-Pair Generation Using Extra Random
> Bits").
> 
> SP800-56Arev3 specifies a lower as well as an upper bound on the generated
> key's length:
> - it must be >= two times the maximum supported security strength of
>    the group in question and
> - it must be <= the length of the domain parameter Q.
> Both of these are available only for the safe-prime groups from
> RFC 3526 or RFC 7919, which had been introduced to the kernel with previous
> patches: for any safe-prime group Q = (P - 1)/2 by definition and the
> individual maximum supported security strength as specified by
> SP800-56Arev3 has already been made available alongside the resp. domain
> parameters with said previous patches. Restrict crypto_dh_gen_privkey() to
> these safe-prime groups, i.e. to those groups with any group_id but
> dh_group_id_unknown. Make it pick twice the maximum supported strength
> rounded up to the next power of two for the output key size. This choice
> respects both, the lower and upper bounds given by SP800-90Arev3 for
> all safe-prime groups known to the kernel by now and is also in line with
> the NVME base spec 2.0, which requires the key size to be >= 256bits.
> 
> [1] https://lkml.kernel.org/r/20211122074727.25988-4-hare@suse.de
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/Kconfig      |   1 +
>   crypto/dh_helper.c  | 128 ++++++++++++++++++++++++++++++++++++++++++++
>   include/crypto/dh.h |  22 ++++++++
>   3 files changed, 151 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
