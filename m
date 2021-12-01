Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EFF4648DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhLAHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:37:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34410 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347638AbhLAHgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:36:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CDC2212BE;
        Wed,  1 Dec 2021 07:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638344010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwHtxVc46YPb8UzeHkCCH3qCHD5UT7RTog4F0TYwxAc=;
        b=Wgy2bDZNDKqX9Dtrl3SyxJcpkcTmqgv5GBoNMGPUAORj7yS7KHQXv15H6tjeQSMv1eV73t
        Xu4TYedX1MHPkvmUb47GeclFKuFgjF9Sbo6oRNneWfe22zFW+SAbdSrvUsbXjc97NAPSiZ
        ErJLdVFDqEHwH93tba4CRAYhl8M5mAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638344010;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwHtxVc46YPb8UzeHkCCH3qCHD5UT7RTog4F0TYwxAc=;
        b=rv0nK92DsgEhqkZxrMAoumPOvTFybZeND/3BMlMChgCBC69f0ywVTI24P4CT3wAXg5R65T
        1Gfw2YZ+ACTfrwAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 698AB13AE2;
        Wed,  1 Dec 2021 07:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S6rXFkklp2FjFwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:33:29 +0000
Subject: Re: [PATCH 16/18] crypto: dh - calculate Q from P for the full public
 key verification
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
 <20211201004858.19831-17-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <26c7fb7b-3976-44ae-4b36-0addb46e2472@suse.de>
Date:   Wed, 1 Dec 2021 08:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-17-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> As the ->q in struct dh_ctx gets never set anywhere, the code
> in dh_is_pubkey_valid() for doing the full public key validation in
> accordance to SP800-56Arev3 is effectively dead.
> 
> However, for safe-prime groups, Q = (P - 1)/2 by definition and this
> enables dh_is_pubkey_valid() to calculate Q on the fly for these groups.
> Implement this.
> 
> With this change, the last code accessing struct dh_ctx's ->q is now gone.
> Remove this member from struct dh_ctx.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/dh.c | 40 +++++++++++++++++++++++++++++-----------
>   1 file changed, 29 insertions(+), 11 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
