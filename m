Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2506470004
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbhLJLiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:38:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33202 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbhLJLiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:38:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D483F210FE;
        Fri, 10 Dec 2021 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639136075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6ePi3hTkUBiB+y5lkAK8MT/DnDNYS2aMa6C1+bd0iI=;
        b=ltaFNQqOGAbLrGmPLLJFdfvLO1uWqPQxwJyPVMcn1EFyzUU0HcsreJaQd+45NKRiH5380/
        pQgMB7N/5hP2nfDMaRgzMP15VHXSyFMNAT8/18QlIQniA5VBC8Y4cP8XiW090o+HcRqSd/
        fkBcgnU997+M2rpSfoa6P8OZVUZM3Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639136075;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6ePi3hTkUBiB+y5lkAK8MT/DnDNYS2aMa6C1+bd0iI=;
        b=l6N0rnxDc47bVA9Xw3Xiy1uAcyz3hyOMHHiOKLC4azh6FQchREYyHNRiaCcUbOsDnhqS//
        z39DXGw0UCquCJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCB8513DDE;
        Fri, 10 Dec 2021 11:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gp7BLUs7s2GYbgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 10 Dec 2021 11:34:35 +0000
Subject: Re: [PATCH v2 05/18] crypto: testmgr - add DH RFC 7919 ffdhe3072 test
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
References: <20211209090358.28231-1-nstange@suse.de>
 <20211209090358.28231-6-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <36bdb97b-ddec-146a-b337-685b3ea049fe@suse.de>
Date:   Fri, 10 Dec 2021 12:34:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211209090358.28231-6-nstange@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:03 AM, Nicolai Stange wrote:
> The previous patch introduced support for the safe-prime groups specified
> by RFC 7919. In order to test this functionality, add a corresponding
> ffdhe3072 test vector to testmgr. The choice of ffdhe3072 over e.g.
> ffdhe2048 is justified by the fact that the NVMe spec mandates it for its
> TLS profile.
> 
> The test data has been generated with OpenSSL.
> 
> Note that this new entry provides test coverage for the recent change to
> crypto_dh_encode_key(), which made it to skip the serialization of domain
> parameters for known groups, i.e. those with
> ->group_id != DH_GROUP_ID_UNKNOWN.
> 
> Moreover, a future patch will make the DH implementation to reject domain
> parameters not corresponding to some safe-prime group approved by
> SP800-56Arev3 in FIPS mode and the existing DH test vectors don't qualify.
> So this patch here will ensure that there's still some suitable test vector
> available.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  crypto/testmgr.h | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
