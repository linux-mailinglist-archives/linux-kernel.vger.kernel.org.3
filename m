Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93C44647FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhLAH1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:27:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33090 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347257AbhLAH1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:27:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BFA44212B8;
        Wed,  1 Dec 2021 07:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638343450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnDi3sGGm2HtsUtJBMOousjRN938B8FttR9twXqvuJo=;
        b=r2I5Fr5c7ANZgMIcfRvswzfmI6+1nUICuWQlbqs4g9ByR1SZMlkcGOXAAZ8gF56qJiek3L
        GeXdCwmWx5IBIx41B5fde3T/onoIFPm1zQS0ebBg2yZPbzwKANOOdiPJUiTE23ARe4W8PV
        I54pWJJA1NUU6cBMYO2uUnSbKVbzRBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638343450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnDi3sGGm2HtsUtJBMOousjRN938B8FttR9twXqvuJo=;
        b=qJ4k4TTl0cF3TlGmqVymMe6dbzurt7CftesG+GUWeH3fL8qX/QkerSbtdpXzI4dJoYR4KG
        6VbhaTbm30bnHcAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6624913AE2;
        Wed,  1 Dec 2021 07:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EmInGBojp2FCFAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:24:10 +0000
Subject: Re: [PATCH 05/18] crypto: testmgr - add DH RFC 7919 ffdhe2048 test
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
 <20211201004858.19831-6-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <cc024490-168a-938e-771d-dc5e6af94f43@suse.de>
Date:   Wed, 1 Dec 2021 08:24:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-6-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> The previous patch introduced support for the safe-prime groups specified
> by RFC 7919. In order to test this functionality, add a corresponding test
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
>   crypto/testmgr.h | 94 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 93 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
