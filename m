Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833E1464815
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347305AbhLAH2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:28:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43386 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhLAH2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:28:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB16E1FD34;
        Wed,  1 Dec 2021 07:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638343523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLj01s8GQdZv5zoUcchVQ9uvHRTc8OShs3IViAEaL5I=;
        b=ZlCNcwuBrk6O808pOqY0NNjzvp3ngZ6lrAolmNVwwHFuxbddzs+YqxFaw/Jx8SBp/wMNhc
        7RX7oQFQt4uDisg+dBj0VfugWCDtn78nIaY8he5wD+Ffo4IIlYLbLKry9eGYUmY4RhSlGO
        IhZJnf/o4c6FVhvYN0YOCA2WMvOezZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638343523;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLj01s8GQdZv5zoUcchVQ9uvHRTc8OShs3IViAEaL5I=;
        b=8jklU5phSbarTO74ckJxt3OB2djWnaMALAMimxpIIRDUt/ljQZwhVad7yqNUc+pHXzwrom
        Smrc+1P1OjS8WQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 692BA13AE2;
        Wed,  1 Dec 2021 07:25:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f0cYGGMjp2GpFAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:25:23 +0000
Subject: Re: [PATCH 07/18] crypto: testmgr - add DH RFC 3526 modp2048 test
 vector
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
 <20211201004858.19831-8-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9b87b348-1e4d-d7f0-2780-c428556c8204@suse.de>
Date:   Wed, 1 Dec 2021 08:25:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-8-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> The previous patch introduced support for the safe-prime groups specified
> by RFC 3526. In order to test this functionality, add a corresponding test
> vector to testmgr. The test data has been generated with OpenSSL.
> 
> Note that this new entry provides test coverage for the recent change to
> crypto_dh_encode_key(), which made it to skip the serialization of domain
> parameters for known groups, i.e. those with
> ->group_id != dh_group_id_unknown.
> 
> Moreover, a future patch will make the DH implementation to reject domain
> parameters not corresponding to some safe-prime group approved by
> SP800-56Arev3 in FIPS mode and the existing DH test vectors don't qualify.
> So this patch here will ensure that there's still some suitable test vector
> available.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/testmgr.h | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 92 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
