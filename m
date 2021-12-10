Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2247000B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbhLJLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:38:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33240 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbhLJLip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:38:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2F7E1210FE;
        Fri, 10 Dec 2021 11:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639136109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s//Xyr2vcUyv1kwXdQNN6eSotv9mCjoaNs6MD+O+gBk=;
        b=PFVGW/nnxxPv3gogjxKEFJcPIpfY5fo24OqTmlfM48xM+tAG3Yp+qMnrl+Nu9UCozvYSwc
        MPIrzCcFo87RfOjC9NdwtIybmPkYrThfnGWXPeCxNmeQiw4Q9jq3/M/edeOnHnKfRWDDmS
        DoGQcdhtIZS3TpD6qNUVvClsdm27PKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639136109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s//Xyr2vcUyv1kwXdQNN6eSotv9mCjoaNs6MD+O+gBk=;
        b=NB1VCA4M1sUs6jClHBLcqmdVkHq4hEwi1aKDz23RvfO7V/9tAbeW3hrnUWYgmx8tbDAapX
        T9j6uMtfIKUPo8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A64D13DDE;
        Fri, 10 Dec 2021 11:35:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rQ4fBm07s2EJbwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 10 Dec 2021 11:35:09 +0000
Subject: Re: [PATCH v2 06/18] crypto: dh - introduce RFC 3526 safe-prime
 groups
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
 <20211209090358.28231-7-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8954c4c9-6fa6-aed9-f0be-4873118efb16@suse.de>
Date:   Fri, 10 Dec 2021 12:35:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211209090358.28231-7-nstange@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:03 AM, Nicolai Stange wrote:
> A future patch will make the DH implementation to reject domain parameters
> not corresponding to any of the safe-prime groups approved by SP800-56Arev3
> in FIPS mode.
> 
> The MODP groups specified by RFC 3526 are among those approved safe-prime
> groups. Make them known to the kernel in order to enable the DH
> implementation to recognize those when passed in from e.g. the
> keyctl(KEYCTL_DH_COMPUTE) syscall.
> 
> More specifically, introduce corresponding members to enum dh_group_id
> as well as entries with the resp. domain parameters to the
> safe_prime_groups[] array queried by crypto_dh_decode_key(). The resp.
> ->max_strength value is set to the maximum supported security strength as
> specified in SP800-56Arev3.
> 
> As the domain parameters consume an substantial amount of space, make
> RFC 3526 safe-prime group support selectable by means of the new
> CRYPTO_DH_GROUPS_RFC3526 Kconfig option.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  crypto/Kconfig      |   6 ++
>  crypto/dh_helper.c  | 216 ++++++++++++++++++++++++++++++++++++++++++++
>  include/crypto/dh.h |   7 ++
>  3 files changed, 229 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
