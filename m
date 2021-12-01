Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D684648E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347645AbhLAHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:37:39 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44342 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbhLAHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:37:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 30FCA1FD58;
        Wed,  1 Dec 2021 07:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638344057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTRhn7spL+A6iOFdvCr6/zYqdNZ0WXCKV1uGUL3ndn8=;
        b=SJZnqLD5Rx+rpwvkaCwarGNzUeNCedvdhX3UmRPc2rmcdNXJTOng5W7tLByHUl4bwFKnKf
        LFf7lYS0NdbeCRF4wTGjOUi5SQFlj1U38/L8Pf5y9orJ414TSkrbSsCB0e0X4rRxxBMu4d
        ovGokeVaN/F4Ap8aa5ebkBLXW7Uft7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638344057;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTRhn7spL+A6iOFdvCr6/zYqdNZ0WXCKV1uGUL3ndn8=;
        b=pXtxzsXTXM/qSn4JtIGeZyrOKDa/aH9zZP4A/nhf7eporYmp26VNr/32p3l07m3UlhWVD5
        IMFLdnLMR9/SAEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D44A313AE2;
        Wed,  1 Dec 2021 07:34:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VXL2Mnglp2GxFwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:34:16 +0000
Subject: Re: [PATCH 17/18] crypto: dh - try to match domain parameters to a
 known safe-prime group
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
 <20211201004858.19831-18-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1d8eb859-1d41-32e1-98b8-3ddd60e2e0ab@suse.de>
Date:   Wed, 1 Dec 2021 08:34:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-18-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> A subsequent patch will make the DH implementation to reject any input
> domain parameter set with ->group_id == dh_group_id_unknown in FIPS mode.
> However, as the keyctl(KEYCTL_DH_COMPUTE) implementation simply passes
> forward keys from userspace, it does not (and cannot) set ->group_id to
> anything else than dh_group_id_unknown.
> 
> In order to still allow for keyctl(KEYCTL_DH_COMPUTE) to work on approved
> domain parameters passed in from userspace in FIPS mode, make
> crypto_dh_decode_key() to compare them against any of the known groups and
> set ->group_id upon having found a match, if any.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/dh_helper.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
