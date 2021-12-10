Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2A470030
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhLJLlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:41:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33768 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbhLJLlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:41:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F35F210FE;
        Fri, 10 Dec 2021 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639136265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eb4zaX1qCjL7jijbTZCbjxJPZ9XZbK1lSdAhXFY9ulk=;
        b=bnwyLDqa55iGL0IUuSSQAYcks2Q2D6YlKHqOI42C/zkVfC8elX7w5vab2lVxpi9RER4lpK
        owPw+7SfA2N8ocAQfiz0bqEfmrglw9SEOBhLz7MWciT1Uqg5OqU44o3ES8/xZoCOsqeILo
        pR1fC7rfuyQ5gm/eiM7Bx7uwcYMld0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639136265;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eb4zaX1qCjL7jijbTZCbjxJPZ9XZbK1lSdAhXFY9ulk=;
        b=qXaOTvCj7K4a7VUSeE94HhiaadYhcPfjsrL5pG0SdH5GYAMgKTYa+nPmPDkCW0QG20/ctv
        MDkAeHLsmF/kggDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D25213DDE;
        Fri, 10 Dec 2021 11:37:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z51bHgk8s2EDcQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 10 Dec 2021 11:37:45 +0000
Subject: Re: [PATCH v2 18/18] crypto: dh - accept only approved safe-prime
 groups in FIPS mode
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
References: <20211209090358.28231-1-nstange@suse.de>
 <20211209090358.28231-19-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e44987d3-d838-38bc-d744-48d6010e2c59@suse.de>
Date:   Fri, 10 Dec 2021 12:37:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211209090358.28231-19-nstange@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:03 AM, Nicolai Stange wrote:
> SP800-56Arev3, sec. 5.5.2 ("Assurance of Domain-Parameter Validity")
> asserts that an implementation needs to verify domain paramtere validity,
> which boils down to either
> - the domain parameters corresponding to some known safe-prime group
>   explicitly listed to be approved in the document or
> - for parameters conforming to a "FIPS 186-type parameter-size set",
>   that the implementation needs to perform an explicit domain parameter
>   verification, which would require access to the "seed" and "counter"
>   values used in their generation.
> 
> The latter is not easily feasible and moreover, SP800-56Arev3 states that
> safe-prime groups are preferred and that FIPS 186-type parameter sets
> should only be supported for backward compatibility, if it all.
> 
> Make the dh implementations reject any domain parameters which don't
> correspond to any of the approved safe-prime groups in FIPS mode. The
> approved safe-prime groups are the ones specified in RFC 7919 and RFC 3526,
> and given that all possible values of enum dh_group_id correspond to
> either groups from these RFCs or to DH_GROUP_ID_UNKNOWN, it suffices to
> make crypto_dh_decode_key() to reject any parameter set where
> ->group_id == DH_GROUP_ID_UNKNOWN.
> 
> As this change will effectively render the dh implementation unusable in
> FIPS mode if neither of the CRYPTO_DH_GROUPS_RFC7919 or
> CRYPTO_DH_GROUPS_RFC3526 Kconfig options enabled, make CRYPTO_DH imply
> these two if CRYPTO_FIPS is set.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  crypto/Kconfig     | 2 ++
>  crypto/dh_helper.c | 4 ++++
>  2 files changed, 6 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
