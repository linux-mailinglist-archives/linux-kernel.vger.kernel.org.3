Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F266046489F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347825AbhLAHe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:34:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43868 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347871AbhLAHeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:34:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6BC601FD34;
        Wed,  1 Dec 2021 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638343859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1xhFQfIiWxh3xMg/S/ml88VGtVEqWibfFdmSOqVFtU=;
        b=vxR+AXG4+ceQebwgk++Hoe6mPt2Nz8xBn5pGLAaAoSIg/Ie5KUUCwXnK6gi74Qi7KoDvvb
        aFACyk6/k/f8U+hGvqKcEPR68qxjHlRY4OzeuUvTl+A5rhYkLiHxgnSQ4JNCaFZBvegH5N
        lEH35oSs1Db8pYZfXHGBulBqy7zGImI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638343859;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1xhFQfIiWxh3xMg/S/ml88VGtVEqWibfFdmSOqVFtU=;
        b=tQuKrElVsYllUs6PGLOKR19Icd72uvbHZJ6KUhTGjdalQej7VYO8KrXlxSU06xr+TaUI2W
        PWzqbkE8c/HeYXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 286F313AE2;
        Wed,  1 Dec 2021 07:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NS6GCLMkp2GbFgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:30:59 +0000
Subject: Re: [PATCH 12/18] crypto: dh - introduce support for ephemeral key
 generation to qat driver
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
 <20211201004858.19831-13-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6acc828d-0a37-50ef-e7e6-fd9b14a0e9f3@suse.de>
Date:   Wed, 1 Dec 2021 08:30:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-13-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> A previous patch made the dh-generic implementation's ->set_secret() to
> generate an ephemeral key in case the input ->key_size is zero, just in
> analogy with ecdh. Make the qat crypto driver's DH implementation to
> behave consistently by doing the same.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   drivers/crypto/qat/qat_common/qat_asym_algs.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
Similar here.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
