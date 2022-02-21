Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC35E4BE411
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377550AbiBUOT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:19:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355413AbiBUOTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:19:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC67DF63;
        Mon, 21 Feb 2022 06:18:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7694210F2;
        Mon, 21 Feb 2022 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645453137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xxr/6OQc+Bxx8pFttpuydG62fEzQhQfQZUGA5IMxB5U=;
        b=b3khxO2fYc9PBGzGo+2jYX1o20L+e7nrMU1q0bQfr0v1FVFtrNE2I4TjP2TUTg7/xOUEkN
        xhc07juXIEWhRm9QJ3YVQInNH+DYjo/yH7xlUtbHScuOSsAa8PavLkVoJdzmE6vUOkwj8o
        s4zz7NHfoJjYfm+ouauViCnHciXzDi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645453137;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xxr/6OQc+Bxx8pFttpuydG62fEzQhQfQZUGA5IMxB5U=;
        b=GpRTZXBlAtlZJM3wVOMSJzEhvqvQNV9HTB8+i+mKu28QtkD4/HT6VxRjZc7Qxp3gSpqV8Q
        w4UoSCnogxT0YTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79FF113B2F;
        Mon, 21 Feb 2022 14:18:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WjD+GlGfE2KnIgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 14:18:57 +0000
Message-ID: <19c194f4-74f0-8dc6-ae30-9a74872cf0d4@suse.de>
Date:   Mon, 21 Feb 2022 15:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 11/15] crypto: dh - allow for passing NULL to the
 ffdheXYZ(dh)s' ->set_secret()
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
 <20220221121101.1615-12-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-12-nstange@suse.de>
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
> Ephemeral key generation can be requested from any of the ffdheXYZ(dh)
> variants' common ->set_secret() by passing it an (encoded) struct dh
> with the key parameter being unset, i.e. with ->key_size == 0. As the
> whole purpose of the ffdheXYZ(dh) templates is to fill in the group
> parameters as appropriate, they expect ->p and ->g to be unset in any
> input struct dh as well. This means that a user would have to encode an
> all-zeroes struct dh instance via crypto_dh_encode_key() when requesting
> ephemeral key generation from a ffdheXYZ(dh) instance, which is kind of
> pointless.
> 
> Make dh_safe_prime_set_secret() to decode a struct dh from the supplied
> buffer only if the latter is non-NULL and initialize it with all zeroes
> otherwise.
> 
> That is, it is now possible to call
> 
>    crypto_kpp_set_secret(tfm, NULL, 0);
> 
> on any ffdheXYZ(dh) tfm for requesting ephemeral key generation.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/dh.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
