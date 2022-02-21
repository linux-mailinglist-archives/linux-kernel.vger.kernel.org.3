Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2792A4BE5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358844AbiBUNTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:19:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358840AbiBUNTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:19:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8071B1EEDA;
        Mon, 21 Feb 2022 05:18:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3EA76210F0;
        Mon, 21 Feb 2022 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645449517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qx0Q18ljVcrXhWvAQ6cUSrAVYJIdsXr8hIUlUK/8QpM=;
        b=Cqj3DkYxCZV9tKvMhc20KpHen50b9YvAxjUyjNAy5j3Xvz2X6M0bSDZR+S3amBXFlcd7E4
        GyiTc/uusdBsKhLqAoKvJRO3wfHJj0bubdlDIchD/mMCW6ZPJMlJ/ltShHLGbV4Wa1/4JU
        n5b02J35yPJl5V5IYGUmr/t7NQ9B6+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645449517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qx0Q18ljVcrXhWvAQ6cUSrAVYJIdsXr8hIUlUK/8QpM=;
        b=LofZw7M41jMg5B5ffe5yCkle/xS/uTOv0SumivGAz0qPUIAYkZOprL+M7W3Dd6TBDjORLq
        bvgQ+L7Wq+Q15pAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F39B13AF2;
        Mon, 21 Feb 2022 13:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sKQ3Ai2RE2K2fwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 13:18:37 +0000
Message-ID: <9bfe807a-d14e-feea-6fcd-b1526da16ff5@suse.de>
Date:   Mon, 21 Feb 2022 14:18:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 01/15] crypto: kpp - provide support for KPP template
 instances
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
 <20220221121101.1615-2-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-2-nstange@suse.de>
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
> The upcoming support for the RFC 7919 ffdhe group parameters will be
> made available in the form of templates like "ffdhe2048(dh)",
> "ffdhe3072(dh)" and so on. Template instantiations thereof would wrap the
> inner "dh" kpp_alg and also provide kpp_alg services to the outside again.
> Furthermore, it might be perhaps be desirable to provide KDF templates in
> the future, which would similarly wrap an inner kpp_alg and present
> themselves to the outside as another kpp_alg, transforming the shared
> secret on its way out.
> 
> Introduce the bits needed for supporting KPP template instances. Everything
> related to inner kpp_alg spawns potentially being held by such template
> instances will be deferred to a subsequent patch in order to facilitate
> review.
> 
> Define struct struct kpp_instance in close analogy to the already existing
> skcipher_instance, shash_instance and alike, but wrapping a struct kpp_alg.
> Implement the new kpp_register_instance() template instance registration
> primitive. Provide some helper functions for
> - going back and forth between a generic struct crypto_instance and the new
>    struct kpp_instance,
> - obtaining the instantiating kpp_instance from a crypto_kpp transform and
> - for accessing a given kpp_instance's implementation specific context
>    data.
> 
> Annotate everything with proper kernel-doc comments, even though
> include/crypto/internal/kpp.h is not considered for the generated docs.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/kpp.c                  | 20 +++++++++
>   include/crypto/internal/kpp.h | 83 +++++++++++++++++++++++++++++++++++
>   2 files changed, 103 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
