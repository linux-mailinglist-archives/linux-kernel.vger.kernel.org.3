Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29604BE9AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377577AbiBUOSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:18:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377561AbiBUOSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:18:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EC31EC49;
        Mon, 21 Feb 2022 06:17:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F226C1F38E;
        Mon, 21 Feb 2022 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645453067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4YgPMB9NeywRhtm0UZX07u6pHaxZIzV2bUydzsgb44=;
        b=gswwhnBXHiRa/iGCN7bvNy2a170al8dZyj4OIRF7PF+NrMcQD+Ujs8r8ZLSwNqEdr3xRox
        +g2bnjlPfhx5Al0RMqsokSgJ2mj7lUv/2cr4Gq4y4OjhIqmZgRMX00PtV5tHg/x/0T+o2U
        NF8ikIkhHP344Q7lP05H+uS2CAzGoSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645453067;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4YgPMB9NeywRhtm0UZX07u6pHaxZIzV2bUydzsgb44=;
        b=cqgmW/eLrNQx1UvrPhg8LO6r7xcHu58BIOdP8m/x5RPDCvMbQX7wkkmJMbEybgaJICotFm
        Uysoa5eIoQQC28Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DED6113B2F;
        Mon, 21 Feb 2022 14:17:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kN1yNQufE2L6IQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 14:17:47 +0000
Message-ID: <16d9e3a3-f463-35e9-ddc7-632bfb278eda@suse.de>
Date:   Mon, 21 Feb 2022 15:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 09/15] crypto: dh - implement private key generation
 primitive for ffdheXYZ(dh)
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
 <20220221121101.1615-10-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-10-nstange@suse.de>
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
> The support for NVME in-band authentication currently in the works ([1])
> needs to generate ephemeral DH keys for use with the RFC 7919 safe-prime
> FFDHE groups.
> 
> In analogy to ECDH and its ecc_gen_privkey(), implement a
> dh_safe_prime_gen_privkey() and invoke it from the ffdheXYZ(dh) templates'
> common ->set_secret(), i.e. dh_safe_prime_set_secret(), in case the input
> ->key_size is zero.
> 
> As the RFC 7919 FFDHE groups are classified as approved safe-prime groups
> by SP800-56Arev3, it's worthwhile to make the new
> dh_safe_prime_gen_privkey() to follow the approach specified in
> SP800-56Arev3, sec. 5.6.1.1.3 ("Key-Pair Generation Using Extra Random
> Bits") in order to achieve conformance.
> 
> SP800-56Arev3 specifies a lower as well as an upper bound on the generated
> key's length:
> - it must be >= two times the maximum supported security strength of
>    the group in question and
> - it must be <= the length of the domain parameter Q.
> 
> For any safe-prime group Q = (P - 1)/2 by definition and the individual
> maximum supported security strengths as specified by SP800-56Arev3 have
> been made available as part of the FFDHE dh_safe_prime definitions
> introduced with a previous patch. Make dh_safe_prime_gen_privkey() pick
> twice the maximum supported strength rounded up to the next power of two
> for the output key size. This choice respects both, the lower and upper
> bounds given by SP800-90Arev3 for any of the approved safe-prime groups and
> is also in line with the NVME base spec 2.0, which requires the key size to
> be >= 256bits.
> 
> [1] https://lore.kernel.org/r/20211202152358.60116-1-hare@suse.de
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/Kconfig |   1 +
>   crypto/dh.c    | 140 +++++++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 138 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
