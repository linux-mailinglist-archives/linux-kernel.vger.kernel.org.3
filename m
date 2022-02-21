Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4136C4BE855
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377575AbiBUOTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:19:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377553AbiBUOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:19:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88031EAF0;
        Mon, 21 Feb 2022 06:19:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8728C1F392;
        Mon, 21 Feb 2022 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645453167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PplAQrKmxzsDEtiJUisik7ljgWy4gBQOYQX852NcVuA=;
        b=lJiEz8bF80z3nvp2fWWCbpjo/Bl/NYvAbX4LTq0Rc0La8ojFuc1v6o2i5HcKs8Uf6tbFrP
        N4W/jSixoTTYKvuVH9UAqOCAyCNKoM+HBq1DVwNo4KyfKyWeNkYxsgie00dWSjYvFHVxzQ
        n/ZzAS2LOp/AxHMS2iPQXid905f6QkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645453167;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PplAQrKmxzsDEtiJUisik7ljgWy4gBQOYQX852NcVuA=;
        b=RidsX5GKFnj9ticviAfUlb5nIDN2yrGyDxhHTgjUFNCAHfu3Y90NvWBQ944mFLHorYBM9o
        yzFtgyEuu5KVpeAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E3D413B2F;
        Mon, 21 Feb 2022 14:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 714fFG+fE2LxIgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 14:19:27 +0000
Message-ID: <1ea809a9-6f36-aa02-cb68-f0a435f32398@suse.de>
Date:   Mon, 21 Feb 2022 15:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 12/15] crypto: api - allow algs only in specific
 constructions in FIPS mode
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
 <20220221121101.1615-13-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-13-nstange@suse.de>
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
> Currently we do not distinguish between algorithms that fail on
> the self-test vs. those which are disabled in FIPS mode (not allowed).
> Both are marked as having failed the self-test.
> 
> Recently the need arose to allow the usage of certain algorithms only
> as arguments to specific template instantiations in FIPS mode. For
> example, standalone "dh" must be blocked, but e.g. "ffdhe2048(dh)" is
> allowed. Other potential use cases include "cbcmac(aes)", which must
> only be used with ccm(), or "ghash", which must be used only for
> gcm().
> 
> This patch allows this scenario by adding a new flag FIPS_INTERNAL to
> indicate those algorithms that are not FIPS-allowed. They can then be
> used as template arguments only, i.e. when looked up via
> crypto_grab_spawn() to be more specific. The FIPS_INTERNAL bit gets
> propagated upwards recursively into the surrounding template
> instances, until the construction eventually matches an explicit
> testmgr entry with ->fips_allowed being set, if any.
> 
> The behaviour to skip !->fips_allowed self-test executions in FIPS
> mode will be retained. Note that this effectively means that
> FIPS_INTERNAL algorithms are handled very similarly to the INTERNAL
> ones in this regard. It is expected that the FIPS_INTERNAL algorithms
> will receive sufficient testing when the larger constructions they're
> a part of, if any, get exercised by testmgr.
> 
> Note that as a side-effect of this patch algorithms which are not
> FIPS-allowed will now return ENOENT instead of ELIBBAD. Hopefully
> this is not an issue as some people were relying on this already.
> 
> Link: https://lore.kernel.org/r/YeEVSaMEVJb3cQkq@gondor.apana.org.au
> Originally-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/algapi.c        | 18 ++++++++++++++++--
>   crypto/api.c           | 19 +++++++++++++++++--
>   crypto/tcrypt.c        |  4 ++--
>   crypto/testmgr.c       | 23 +++++++++++++++++++----
>   include/linux/crypto.h |  9 +++++++++
>   5 files changed, 63 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
