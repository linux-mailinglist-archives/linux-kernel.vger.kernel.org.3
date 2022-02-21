Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799AC4BE4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377366AbiBUOMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:12:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353585AbiBUOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:12:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451901EACD;
        Mon, 21 Feb 2022 06:11:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D3E5F1F38E;
        Mon, 21 Feb 2022 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645452708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6uHCum8Pw6ZWN7KnQa/P524zda2v8fedeXCTldYkBQ=;
        b=UNHCvmB7fPPddZ/gsqYr1fvwQy++5pXY8+Oy9/5waECnQPJxQw41p+Xkqx5FH57sURlXOO
        M0d7wyKsom3ytiqlvcYUaI75IhgScZWMPfpdg2kC6pvE/wKj+3N5ILcc5Ri9kddhNJxFFA
        8o/wXSDMaQq6U4jAhpnhpUP/ei1ZtUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645452708;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6uHCum8Pw6ZWN7KnQa/P524zda2v8fedeXCTldYkBQ=;
        b=+bZ96k2G1tXwyuWbKb4uiHC3+AGk1a0E99+fm9s9ZoilUrM7T49Z1EYsL6ZNZUEAQgQflS
        sPzdRJd4wLzuCzCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A064713B21;
        Mon, 21 Feb 2022 14:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yr1XJKSdE2JxHgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 14:11:48 +0000
Message-ID: <2cead7a0-8e52-54a6-831d-3ba1e2b277cd@suse.de>
Date:   Mon, 21 Feb 2022 15:11:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 02/15] crypto: kpp - provide support for KPP spawns
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
 <20220221121101.1615-3-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-3-nstange@suse.de>
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
> 
> The primitves needed for providing kpp_alg services from template instances
> have been introduced with the previous patch. Continue this work now and
> implement everything needed for enabling template instances to make use
> of inner KPP algorithms like "dh".
> 
> More specifically, define a struct crypto_kpp_spawn in close analogy to
> crypto_skcipher_spawn, crypto_shash_spawn and alike. Implement a
> crypto_grab_kpp() and crypto_drop_kpp() pair for binding such a spawn to
> some inner kpp_alg and for releasing it respectively. Template
> implementations can instantiate transforms from the underlying kpp_alg by
> means of the new crypto_spawn_kpp(). Finally, provide the
> crypto_spawn_kpp_alg() helper for accessing a spawn's underlying kpp_alg
> during template instantiation.
> 
> Annotate everything with proper kernel-doc comments, even though
> include/crypto/internal/kpp.h is not considered for the generated docs.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/kpp.c                  |  9 +++++
>   include/crypto/internal/kpp.h | 75 +++++++++++++++++++++++++++++++++++
>   2 files changed, 84 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
