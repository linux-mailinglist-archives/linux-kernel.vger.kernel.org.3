Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404774BE360
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377470AbiBUOQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:16:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiBUOQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:16:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD151EADE;
        Mon, 21 Feb 2022 06:15:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA47D2111A;
        Mon, 21 Feb 2022 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645452952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dWqt3VWBGlRkPBTMmfSvFa9xtdEZO2vK14SIjOC8a8=;
        b=aBBaOWgmlRdt3USVzLbh0kZQrjvNCWNzZWYpEooLwgLnvtDRJSdiiAuNq+cF3SMdCDK4YP
        Ejqy+AI9PfyuJuky/xAGeuUXskj2EwF9GQdtumvVlQES3ugomDhBvWNvKv6VIXrCDE9F0p
        921s0Zvc20Y4mWsobvj4dmPBOyMTqWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645452952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dWqt3VWBGlRkPBTMmfSvFa9xtdEZO2vK14SIjOC8a8=;
        b=ElqO+pSvHlSR2OseQaUnS32gtmkOVD5nCH+bIWY3U1NtkR//7kGdmZR8jhpGS2XVN4XFvA
        ytajUS8+tMCU5iDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A2DE13B21;
        Mon, 21 Feb 2022 14:15:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gbinHJieE2LsIAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 14:15:52 +0000
Message-ID: <354c93c4-1a3a-a22b-1bd6-0815d4128aa0@suse.de>
Date:   Mon, 21 Feb 2022 15:15:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 07/15] crypto: dh - implement ffdheXYZ(dh) templates
Content-Language: en-US
To:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20220221121101.1615-1-nstange@suse.de>
 <20220221121101.1615-8-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-8-nstange@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 13:10, Nicolai Stange wrote:
> Current work on NVME in-band authentication support ([1]) needs to invoke
> DH with the FFDHE safe-prime group parameters specified in RFC 7919.
> 
> Introduce a new CRYPTO_DH_RFC7919_GROUPS Kconfig option. If enabled, make
> dh_generic register a couple of ffdheXYZ(dh) templates, one for each group:
> ffdhe2048(dh), ffdhe3072(dh), ffdhe4096(dh), ffdhe6144(dh) and
> ffdhe8192(dh). Their respective ->set_secret() expects a (serialized)
> struct dh, just like the underlying "dh" implementation does, but with the
> P and G values unset so that the safe-prime constants for the given group
> can be filled in by the wrapping template.
> 
> Internally, a struct dh_safe_prime instance is being defined for each of
> the ffdheXYZ(dh) templates as appropriate. In order to prepare for future
> key generation, fill in the maximum security strength values as specified
> by SP800-56Arev3 on the go, even though they're not needed at this point
> yet.
> 
> Implement the respective ffdheXYZ(dh) crypto_template's ->create() by
> simply forwarding any calls to the __dh_safe_prime_create() helper
> introduced with the previous commit, passing the associated dh_safe_prime
> in addition to the received ->create() arguments.
> 
> [1] https://lore.kernel.org/r/20211202152358.60116-1-hare@suse.de
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/Kconfig |   6 +
>   crypto/dh.c    | 298 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 303 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
