Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1232E4647A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347117AbhLAHOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:14:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60656 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhLAHOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:14:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33A512170C;
        Wed,  1 Dec 2021 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638342677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGUV/rmr4WK2I6xHEGfZKUi+C6xsZwWRBRrGbtWgvDI=;
        b=USg932ykwEHtE3+p1NUw0ZYPJry/hOn8Y7rA1KWBRTT9WrPZY9HIwtnyaZ6vQBQnEI9xIb
        duQd8rNP/Gyli069lWECJEjLKSh8QmJCT2HaWl01xY6hAazKfmVFunI9dgzhfogXai/ZsK
        NfSfQ8PbYcdQ0CWlifmQw9NZ48EEyzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638342677;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGUV/rmr4WK2I6xHEGfZKUi+C6xsZwWRBRrGbtWgvDI=;
        b=JFEM7hm1HLbtYEydTN8TsYyhC6HPV4Ch+saobTqe9hcid+HeqJvFz4WdP1nmsnOR8ImyRN
        K8p10QxAW8wuiWCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED02A13AE2;
        Wed,  1 Dec 2021 07:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cCoXORQgp2E+EAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:11:16 +0000
Subject: Re: [PATCH 01/18] crypto: dh - remove struct dh's ->q member
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
 <20211201004858.19831-2-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <18cd40ee-d9a9-9fcc-1227-efd486cc72ef@suse.de>
Date:   Wed, 1 Dec 2021 08:11:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-2-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> The only current user of the DH KPP algorithm, the
> keyctl(KEYCTL_DH_COMPUTE) syscall, doesn't set the domain parameter ->q
> in struct dh. Remove it and any associated (de)serialization code in
> crypto_dh_encode_key() and crypto_dh_decode_key. Adjust the encoded
> ->secret values in testmgr's DH test vectors accordingly.
> 
> Note that the dh-generic implementation would have initialized its
> struct dh_ctx's ->q from the decoded struct dh's ->q, if present. If this
> struct dh_ctx's ->q would ever have been non-NULL, it would have enabled a
> full key validation as specified in NIST SP800-56A in dh_is_pubkey_valid().
> However, as outlined above, ->q is always NULL in practice and the full key
> validation code is effectively dead. A later patch will make
> dh_is_pubkey_valid() to calculate Q from P on the fly, if possible, so
> don't remove struct dh_ctx's ->q now, but leave it there until that has
> happened.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/dh.c         |  6 ------
>   crypto/dh_helper.c  | 17 ++++-------------
>   crypto/testmgr.h    | 16 ++++++----------
>   include/crypto/dh.h |  4 ----
>   4 files changed, 10 insertions(+), 33 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
