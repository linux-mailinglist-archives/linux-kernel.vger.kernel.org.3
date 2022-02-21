Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C604BDF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377416AbiBUOPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:15:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348396AbiBUOPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:15:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196DC1EACF;
        Mon, 21 Feb 2022 06:14:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA1FB210F1;
        Mon, 21 Feb 2022 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645452897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3M1v2or4Jwnlmx6+6YVxwUMYf/3H4VFnS1Ui00LTPU=;
        b=ejzqcEajqY845BjfqPsXhZofVhuQ4UFaectgm2JQYLRXgbBjxjQemnwAC8/r4rKjIKmSas
        Ro1dDUS2t3+z1McaQ9UfFSBs6SDeSh9i+EGlcQWoT5JYBs/NQr+R5aDh4cnnNtcpWC1557
        FDdHZtcxzIXOV4NGY+kCZU1m41iMyQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645452897;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3M1v2or4Jwnlmx6+6YVxwUMYf/3H4VFnS1Ui00LTPU=;
        b=2DR5njhyJHxjvKA3EAXfZNG8nuXBeck8/rqgvxm4QgAiGnlpH6GkuGDi+gXjMGg90oP41i
        YYGNQTo7gN+RRsDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A998F13B21;
        Mon, 21 Feb 2022 14:14:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nmLCKGGeE2JQIAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 14:14:57 +0000
Message-ID: <f4f0ea8c-d413-abe9-7e30-2c9ddc44f4ea@suse.de>
Date:   Mon, 21 Feb 2022 15:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 06/15] crypto: dh - introduce common code for built-in
 safe-prime group support
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
 <20220221121101.1615-7-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-7-nstange@suse.de>
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
> Recent work on NVME in-band authentication support ([1]) needs to invoke
> the "dh" KPP with the FFDHE safe-prime group parameters as specified in
> RFC 7919 and generate ephemeral keys suitable for the respective group. By
> coincidence, the requirements from NIST SP800-56Arev3,
> sec. 5.5.2 ("Assurance of Domain-Parameter Validity") basically boil down
> to disallowing any group parameters not among the approved safe-prime
> groups specified in either RFC 7919 or RFC 3526 in FIPS mode. Furthermore,
> SP800-56Arev3 specifies the respective security strength for each of the
> approved safe-prime groups, which has a direct impact on the minimum key
> lengths.
> 
> In this light, it's desirable to introduce built-in support for the
> RFC 7919 safe-prime groups to the kernel's DH implementation, provide a
> SP800-56Arev3 conforming key generation primitive for those and render
> non-approved group parameters unusable in FIPS mode on the way.
> 
> As suggested ([2]) in the course of discussion to previous iterations of
> this patchset, the built-in support for ffdhe groups would be best made
> available in the form of templates wrapping the existing "dh"
> implementation, one for each group specified by RFC 7919: ffdhe2048(dh),
> ffdhe3072(dh), ffdhe4096(dh), ffdhe6144(dh) and ffdhe8192(dh). As these
> templates differ only in the safe-prime constants they'd configure the
> inner "dh" transforms with, they can share almost all of their
> "dh"-wrapping template implementation code.
> 
> Introduce this common code to dh_generic. The actual dump of the RFC 7919
> safe-prime constants will be deferred to the next patch in order to
> facilitate review. The ephemeral key generation primitive mentioned above
> likewise deserves a patch on its own, as does the mechanism by which
> unapproved groups are rendered unusable in FIPS mode.
> 
> Define a struct dh_safe_prime container for specifying the individual
> templates' associated safe-prime group constants. All ffdheXYZ(dh) template
> instances will store a pointer to such a dh_safe_prime in their context
> areas each. Implement the common __dh_safe_prime_create() template
> instantiation helper. The intention is that the individual ffdheXYZ(dh)
> crypto_templates' ->create() implementations will simply forward any calls
> to __dh_safe_prime_create(), passing a suitable dh_safe_prime in addition
> to the received ->create() arguments. __dh_safe_prime_create() would then
> create and register a kpp_instance as appropriate, storing the given
> dh_safe_prime pointer alongside a crypto_kpp_spawn for the inner "dh"
> kpp_alg in the context area.
> 
> As the ffdheXYZ(dh) kpp_instances are supposed to act as proxies to the
> inner "dh" kpp_alg, make each of their associated crypto_kpp transforms to
> in turn own an inner "dh" transform, a pointer to which gets stored in the
> context area. Setup and teardown are getting handled from the outer
> ->init_tfm() and ->exit_tfm() respectively.
> 
> In order to achieve the overall goal and let the ffdheXYZ(dh) kpp_instances
> configure the inner "dh" transforms with the respective group parameters,
> make their common ->set_secret(), the new dh_safe_prime_set_secret(), fill
> in the P and G values before forwarding the call to the inner "dh"'s
> ->set_secret(). Note that the outer ->set_secret() can obtain the P value
> associated with the given ffdheXYZ(dh) kpp_instance by means of the
> dh_safe_prime referenced from the latter's context. The value of G OTOH
> always equals constant 2 for the safe-prime groups.
> 
> Finally, make the remaining two kpp_alg primitives both operating on
> kpp_requests, i.e. ->generate_public_key() and ->compute_shared_secret(),
> to merely forward any request to the inner "dh" implementation. However, a
> kpp_request instance received from the outside cannot get simply passed
> on as-is, because its associated transform (crypto_kpp_reqtfm()) will have
> been set to the outer ffdheXYZ(dh) one. In order to handle this, reserve
> some space in the outer ffdheXYZ(dh) kpp_requests' context areas for in
> turn storing an inner kpp_request suitable for "dh" each. Make the outer
> ->generate_public_key() and ->compute_shared_secret() respectively to setup
> this inner kpp_request by means of the new dh_safe_prime_prepare_dh_req()
> helper before handing it over to the "dh" implementation for further
> processing. dh_safe_prime_prepare_dh_req() basically copies the outer
> kpp_request received from the outside over to the inner one, but installs
> the inner transform and its own ->complete() proxy callback therein. This
> completion callback, the new dh_safe_prime_complete_req(), doesn't do
> anything beyond completing the outer request. Note that there exist some
> examples in crypto/, which would simply install the completion handler
> from the outer request at the inner one in similar setups, e.g. seqiv.
> However, this would mean that the user-provided completion handler won't
> get called with the address of the outer kpp_request initially submitted
> and the handler might not be prepared for this. Users could certainly work
> around this by setting the callback ->data properly, but IMO it's cleaner
> this way. Furthermore, it might make sense to extend
> dh_safe_prime_complete_req() in the future and move e.g. those
> post-computation FIPS checks from the generic "dh" implementation to the
> ffdheXYZ(dh) templates.
> 
> [1] https://lore.kernel.org/r/20211202152358.60116-1-hare@suse.de
> [2] https://lore.kernel.org/r/20211217055227.GA20698@gondor.apana.org.au
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/dh.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 208 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
