Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C71B4BDF44
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377401AbiBUOOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:14:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377394AbiBUOOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:14:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1FF1EAD3;
        Mon, 21 Feb 2022 06:13:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D14E1F38E;
        Mon, 21 Feb 2022 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645452827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rXrHnsmRYtwHTrXxYxmn/Gxy4oog3JFQ23C7y3cVu4=;
        b=nAy0Py9ViDDYmscYaiKdOym65j7kDAtjRko9oFUfuh8zFNONuInLbKw5o5S4fCA5lqpU81
        sg8oG48X4Oclpl0M6x7z3F/dbHvDhXp9RcXi2G2CFFNPkNQiOEYzxWOueA+eck/ImkCayZ
        vDgNHZOXPmaIgcaQUDu64FYN09Yelb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645452827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rXrHnsmRYtwHTrXxYxmn/Gxy4oog3JFQ23C7y3cVu4=;
        b=uU5JihMntRD7sLWLzVHJH7hnXhsAStz25eqHLqVbzTaSe2PulbbxQC2/G+dgwKntmS5/5t
        gjX3bseDz/3fJ8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14F2713B21;
        Mon, 21 Feb 2022 14:13:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qPHOARueE2KGHwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 14:13:47 +0000
Message-ID: <58407bcf-002a-72e9-0a51-04a2a410fb5a@suse.de>
Date:   Mon, 21 Feb 2022 15:13:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 05/15] crypto: dh - split out deserialization code from
 crypto_dh_decode()
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
 <20220221121101.1615-6-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-6-nstange@suse.de>
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
> A subsequent commit will introduce "dh" wrapping templates of the form
> "ffdhe2048(dh)", "ffdhe3072(dh)" and so on in order to provide built-in
> support for the well-known safe-prime ffdhe group parameters specified in
> RFC 7919.
> 
> Those templates' ->set_secret() will wrap the inner "dh" implementation's
> ->set_secret() and set the ->p and ->g group parameters as appropriate on
> the way inwards. More specifically,
> - A ffdheXYZ(dh) user would call crypto_dh_encode() on a struct dh instance
>    having ->p == ->g == NULL as well as ->p_size == ->g_size == 0 and pass
>    the resulting buffer to the outer ->set_secret().
> - This outer ->set_secret() would then decode the struct dh via
>    crypto_dh_decode_key(), set ->p, ->g, ->p_size as well as ->g_size as
>    appropriate for the group in question and encode the struct dh again
>    before passing it further down to the inner "dh"'s ->set_secret().
> 
> The problem is that crypto_dh_decode_key() implements some basic checks
> which would reject parameter sets with ->p_size == 0 and thus, the ffdheXYZ
> templates' ->set_secret() cannot use it as-is for decoding the passed
> buffer. As the inner "dh"'s ->set_secret() will eventually conduct said
> checks on the final parameter set anyway, the outer ->set_secret() really
> only needs the decoding functionality.
> 
> Split out the pure struct dh decoding part from crypto_dh_decode_key() into
> the new __crypto_dh_decode_key().
> 
> __crypto_dh_decode_key() gets defined in crypto/dh_helper.c, but will have
> to get called from crypto/dh.c and thus, its declaration must be somehow
> made available to the latter. Strictly speaking, __crypto_dh_decode_key()
> is internal to the dh_generic module, yet it would be a bit over the top
> to introduce a new header like e.g. include/crypto/internal/dh.h
> containing just a single prototype. Add the __crypto_dh_decode_key()
> declaration to include/crypto/dh.h instead.
> 
> Provide a proper kernel-doc annotation, even though
> __crypto_dh_decode_key() is purposedly not on the function list specified
> in Documentation/crypto/api-kpp.rst.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/dh_helper.c  | 27 +++++++++++++++++++--------
>   include/crypto/dh.h | 16 ++++++++++++++++
>   2 files changed, 35 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
