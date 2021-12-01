Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA223464898
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347575AbhLAHeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:34:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33462 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347731AbhLAHdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F771212B8;
        Wed,  1 Dec 2021 07:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638343818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNG9ad/5UniFzDXs4lAYKSt1oiq4kvb+r9wtgmP73Ys=;
        b=NZo1dGEkzGvTRfdxMDB3H18eoxfigYTcAtN1Upc1HRDLmT02IY/g/EGH8P6NZ+akCMosmn
        8r6+ENPt7ntsFJT32XZ2wKd/InhrxrHRvop6JEI88SzHknA+kBIwKT+zUzDRjB9BEmf1wK
        yjTXjiXOkrTzjaZzhYrb1dQY+jmdG3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638343818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNG9ad/5UniFzDXs4lAYKSt1oiq4kvb+r9wtgmP73Ys=;
        b=iMzKD8BEWD3nLAS2PJniifxX8EGGJAzHLuL2ZW5nS87TxSUtIkTTI7J0lDBj6fIKOtx5bp
        hj6KN/IeCe2C1BDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1171113AE2;
        Wed,  1 Dec 2021 07:30:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iGYqAYokp2FBFgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:30:18 +0000
Subject: Re: [PATCH 11/18] crypto: dh - introduce support for ephemeral key
 generation to hpre driver
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
 <20211201004858.19831-12-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1df741b5-c750-53c7-30a1-ec8424a4cd79@suse.de>
Date:   Wed, 1 Dec 2021 08:30:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-12-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> A previous patch made the dh-generic implementation's ->set_secret() to
> generate an ephemeral key in case the input ->key_size is zero, just in
> analogy with ecdh. Make the hpre crypto driver's DH implementation to
> behave consistently by doing the same.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   drivers/crypto/hisilicon/hpre/hpre_crypto.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
Can't really comment here, but FWIW:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
