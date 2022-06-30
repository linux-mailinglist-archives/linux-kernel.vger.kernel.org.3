Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9A562694
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiF3XOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiF3XOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:14:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CE91261E;
        Thu, 30 Jun 2022 16:13:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4D20B82CBF;
        Thu, 30 Jun 2022 23:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12682C34115;
        Thu, 30 Jun 2022 23:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656630832;
        bh=LcRXKeZ1Ow0hvntfZpb4qJkONjz8OExyuqW5J+4q7Kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoSvl9eDCCmacnmlLHiNo082z31H5MLSLoQ4Rdb92iRFEj7W4BoIru4nAE6JjuU8D
         2+1dtFYxJfywoXYmRKF4HJItWscz/jzUIt8OhtKbXHVI+GTCx9Nsg5h9Wp1DG9GKQJ
         nInVCBkU4Kly6kpTv1PN9Qa8P0783hHkdoQlt9aKVxEYmSSjU9SxTnel9MfSrSAkoQ
         LFvw8oParpJnSER0mLFm+GbhzshGUOC9SNYDFAJauaElbH6cbqI44tGMN1qi/1+k45
         y7tmy007zcRUtTtW0chZMyS100zB2ESC5s7Z0TzT+0FyZKpM4LM+Mi1pcveONf5foC
         j67ADcgHIidkg==
Date:   Fri, 1 Jul 2022 02:13:48 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Eric Biggers <ebiggers@google.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KEYS: asymmetric: enforce SM2 signature use pkey algo
Message-ID: <Yr4uLEmN0Jeh3dGC@kernel.org>
References: <20220628033720.43847-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628033720.43847-1-tianjia.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:37:20AM +0800, Tianjia Zhang wrote:
> The signature verification of SM2 needs to add the Za value and
> recalculate sig->digest, which requires the detection of the pkey_algo
> in public_key_verify_signature(). As Eric Biggers said, the pkey_algo
> field in sig is attacker-controlled and should be use pkey->pkey_algo
> instead of sig->pkey_algo, and secondly, if sig->pkey_algo is NULL, it
> will also cause signature verification failure.
> 
> The software_key_determine_akcipher() already forces the algorithms
> are matched, so the SM3 algorithm is enforced in the SM2 signature,
> although this has been checked, we still avoid using any algorithm
> information in the signature as input.
> 
> Fixes: 215525639631 ("X.509: support OSCCA SM2-with-SM3 certificate verification")
> Reported-by: Eric Biggers <ebiggers@google.com>
> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  crypto/asymmetric_keys/public_key.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> index 7c9e6be35c30..2f8352e88860 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -304,6 +304,10 @@ static int cert_sig_digest_update(const struct public_key_signature *sig,
>  
>  	BUG_ON(!sig->data);
>  
> +	/* SM2 signatures always use the SM3 hash algorithm */
> +	if (!sig->hash_algo || strcmp(sig->hash_algo, "sm3") != 0)
> +		return -EINVAL;
> +
>  	ret = sm2_compute_z_digest(tfm_pkey, SM2_DEFAULT_USERID,
>  					SM2_DEFAULT_USERID_LEN, dgst);
>  	if (ret)
> @@ -414,8 +418,7 @@ int public_key_verify_signature(const struct public_key *pkey,
>  	if (ret)
>  		goto error_free_key;
>  
> -	if (sig->pkey_algo && strcmp(sig->pkey_algo, "sm2") == 0 &&
> -	    sig->data_size) {
> +	if (strcmp(pkey->pkey_algo, "sm2") == 0 && sig->data_size) {
>  		ret = cert_sig_digest_update(sig, tfm);
>  		if (ret)
>  			goto error_free_key;
> -- 
> 2.24.3 (Apple Git-128)
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
