Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F1F470020
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbhLJLkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:40:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33478 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhLJLjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:39:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EBCD121108;
        Fri, 10 Dec 2021 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639136179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkdFI9UbtURaawwRNhX75kfGoLfWeXUlWV68RRspE9c=;
        b=dBl6yOItGP/JsS4XH15L8b1D93c7NLjDMMcXUeVb3n+5jaY/5O5VmsontyvuMoxnYA1r5U
        1hhW9Fk+EKm0fz8TfNIxKXC5UEtWhUG8hn7dfweUTcULFcqnQdQ3sUtMg4U9elvvSV+/71
        X7AK20+IbPSL5wgTsNOGbOeaeiD+Wfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639136179;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkdFI9UbtURaawwRNhX75kfGoLfWeXUlWV68RRspE9c=;
        b=Lc6GN5gEYl1gQok89kJ5rbzkIHmNFAT9s+IgmHu+jwyYu2vf7CvPJ/R1xi9i9xL+pxQcMp
        8vg8Fc2txyPDCnAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C97F713DDE;
        Fri, 10 Dec 2021 11:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dTnmMLM7s2GFbwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 10 Dec 2021 11:36:19 +0000
Subject: Re: [PATCH v2 08/18] crypto: testmgr - run only subset of DH vectors
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
References: <20211209090358.28231-1-nstange@suse.de>
 <20211209090358.28231-9-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e08d4112-e001-5cc1-ebaf-74e299af68e3@suse.de>
Date:   Fri, 10 Dec 2021 12:36:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211209090358.28231-9-nstange@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:03 AM, Nicolai Stange wrote:
> With the previous patches, the testmgr now has up to four test vectors for
> DH which all test more or less the same thing:
> - the two vectors from before this series,
> - the vector for the ffdhe3072 group, enabled if
>   CONFIG_CRYPTO_DH_GROUPS_RFC7919 is set and
> - the vector for the modp2048 group, similarly enabled if
>   CONFIG_CRYPTO_DH_GROUPS_RFC3526 is set.
> 
> In order to avoid too much redundancy during DH testing, enable only a
> subset of these depending on the kernel config:
> - if CONFIG_CRYPTO_DH_GROUPS_RFC7919 is set, enable only the ffdhe3072
>   vector,
> - otherwise, if CONFIG_CRYPTO_DH_GROUPS_RFC3526 is set, enable only
>   the modp2048 vector and
> - only enable the original two vectors if neither of these options
>   has been selected.
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
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  crypto/testmgr.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
