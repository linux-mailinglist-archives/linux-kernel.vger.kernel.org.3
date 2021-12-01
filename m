Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEDE4648A7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347528AbhLAHgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:36:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44224 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbhLAHgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:36:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EAEC41FD58;
        Wed,  1 Dec 2021 07:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638343960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7veg9LGiG+UQY9OzBV9/fH0f9UJTeD6bq9ZjO2g5No=;
        b=wIQpu+slp1gFdekDEHw8JskkvH/EZUF7cE4mXDNcv9I0lFsF7Ry2z2Lfg95YErd9Z2RZM7
        asfDEngEpZfGaFSNXais6PnSnEEW1et/3JVGliE4Del+coMAYSPdSUC1qW+gb4/LFZ515u
        sF99rpzAeP/8YEzkIb5bju4peu2Nbv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638343960;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7veg9LGiG+UQY9OzBV9/fH0f9UJTeD6bq9ZjO2g5No=;
        b=4OjtR1HM7Tu++JFoj3+LeoYNP9vemvJLoGrTIuqb/w381gWyFRbKphGhrJwDOoA42QQuwB
        52WUXqQZJLD1pNDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBEAA13AE2;
        Wed,  1 Dec 2021 07:32:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZD09LRglp2EvFwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:32:40 +0000
Subject: Re: [PATCH 15/18] crypto: dh - store group id in dh-generic's dh_ctx
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
 <20211201004858.19831-16-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <7bcdee15-1902-74d3-b5b7-1a341b0a8e60@suse.de>
Date:   Wed, 1 Dec 2021 08:32:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-16-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> A subsequent patch will make the crypto/dh's dh_is_pubkey_valid() to
> calculate the Q value from the P domain parameter for safe-prime groups,
> for which by definition Q = (P - 1)/2. However, dh_is_pubkey_valid() will
> need to check first whether the group in question is actually a safe-prime
> group. In order to make this information available, introduce a new
> ->group_id member to struct dh_ctx and let dh_set_params() set it to the
> value found in the struct dh as deserialized via crypto_dh_decode_key().
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/dh.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
