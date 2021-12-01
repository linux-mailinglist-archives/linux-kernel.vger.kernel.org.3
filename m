Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267944648A3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbhLAHfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:35:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44140 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbhLAHfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:35:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BABC21FD58;
        Wed,  1 Dec 2021 07:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638343934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kb6nQl4qQtBTssrfVzXlKZrUy6UMvr5QjIRkIm4dq20=;
        b=YtEG321wBeVjP93b0LL695G3M6Tm9LTn8P937ZBpFwswTF8Ug8VN62lPMT4C7G9tdlVjsv
        dV/ckdbig5smLVw7yZpajHlZnLktxAFZj3i31WHrPVn3HyYy/icH/WAevcqgZnwdT/e/M3
        00SEOeR1DUBJbaHIcW0VDogf05C3Mb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638343934;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kb6nQl4qQtBTssrfVzXlKZrUy6UMvr5QjIRkIm4dq20=;
        b=6a3C5rd0ICRm7IB9H4wITnzrNBiepGFkFUXehVw41e5SG9RLxIPjH9DFlwVQXT++0NEaoO
        d8RdE+7IcS4JyKBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8958713AE2;
        Wed,  1 Dec 2021 07:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ioDUIP4kp2EGFwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:32:14 +0000
Subject: Re: [PATCH 14/18] lib/mpi: export mpi_rshift
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
 <20211201004858.19831-15-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <fbd7fc63-0a56-595d-346d-ae978bebb669@suse.de>
Date:   Wed, 1 Dec 2021 08:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-15-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> A subsequent patch will make the crypto/dh's dh_is_pubkey_valid() to
> calculate a safe-prime groups Q parameter from P: Q = (P - 1) / 2. For
> implementing this, mpi_rshift() will be needed. Export it so that it's
> accessible from crypto/dh.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   lib/mpi/mpi-bit.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/mpi/mpi-bit.c b/lib/mpi/mpi-bit.c
> index 142b680835df..070ba784c9f1 100644
> --- a/lib/mpi/mpi-bit.c
> +++ b/lib/mpi/mpi-bit.c
> @@ -242,6 +242,7 @@ void mpi_rshift(MPI x, MPI a, unsigned int n)
>   	}
>   	MPN_NORMALIZE(x->d, x->nlimbs);
>   }
> +EXPORT_SYMBOL_GPL(mpi_rshift);
>   
>   /****************
>    * Shift A by COUNT limbs to the left
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
