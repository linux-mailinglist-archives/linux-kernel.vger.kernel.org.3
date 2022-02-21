Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1D64BE7BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377584AbiBUOUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:20:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357379AbiBUOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:20:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28BA12AF2;
        Mon, 21 Feb 2022 06:19:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 608B02111A;
        Mon, 21 Feb 2022 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645453190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xpvzMC8Ckl84xZPjUXNnHSVeQU6Bt4IElqUIe5yAtWA=;
        b=VmZaOh95QLUlV9MWk1nhRkoRJ7Z3cyoXt547oBP4p6Xvha723dErQFriFXjdy7eMkDDWZP
        7C/YYhPKHRv7lqgPROkdPmUlZV5ZGdRxJyXak4eNmrxuWw7LIX/HQ40fEtbbViCe+niHp5
        orNFlflBjdQ6te4aoxqODY1SvEgkj9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645453190;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xpvzMC8Ckl84xZPjUXNnHSVeQU6Bt4IElqUIe5yAtWA=;
        b=0wrntaKV9mIr7Mj6qfD458ZIAbj45zfLV4x0qYiA6RaUX0LGTpgCsAMuNqTeJrknHknG/g
        02KICil27wl9g2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 407EE13B2F;
        Mon, 21 Feb 2022 14:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IisJDoafE2IjIwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 14:19:50 +0000
Message-ID: <23740a5b-5c3b-d685-c1fa-99f97d5211ea@suse.de>
Date:   Mon, 21 Feb 2022 15:19:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 13/15] crypto: dh - disallow plain "dh" usage in FIPS
 mode
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
 <20220221121101.1615-14-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-14-nstange@suse.de>
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
> SP800-56Arev3, sec. 5.5.2 ("Assurance of Domain-Parameter Validity")
> asserts that an implementation needs to verify domain paramtere validity,
> which boils down to either
> - the domain parameters corresponding to some known safe-prime group
>    explicitly listed to be approved in the document or
> - for parameters conforming to a "FIPS 186-type parameter-size set",
>    that the implementation needs to perform an explicit domain parameter
>    verification, which would require access to the "seed" and "counter"
>    values used in their generation.
> 
> The latter is not easily feasible and moreover, SP800-56Arev3 states that
> safe-prime groups are preferred and that FIPS 186-type parameter sets
> should only be supported for backward compatibility, if it all.
> 
> Mark "dh" as not fips_allowed in testmgr. Note that the safe-prime
> ffdheXYZ(dh) wrappers are not affected by this change: as these enforce
> some approved safe-prime group each, their usage is still allowed in FIPS
> mode.
> 
> This change will effectively render the keyctl(KEYCTL_DH_COMPUTE) syscall
> unusable in FIPS mode, but it has been brought up that this might even be
> a good thing ([1]).
> 
> [1] https://lore.kernel.org/r/20211217055227.GA20698@gondor.apana.org.au
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/testmgr.c | 1 -
>   1 file changed, 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
