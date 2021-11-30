Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DAC463D63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245262AbhK3SIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:08:15 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:27717 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbhK3SIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638295490;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=sgXX0qqHC6u3xxkgft/NyWB1WNZ9/jmvSH6gsHalGTk=;
    b=mln5GcuC7S1eN1V1lf4VL7395YWG5Ao6qeWKcvcRNyQB++V3ui5yDUenC1y+0KsqB2
    kKJ5FJ8IYJ4hlM9pvOac2wrQYecTNKEDz3R9enaAJ8qEpaVUUDk40eELWolII4KUj28U
    Vdy+6QdyLD0IfB3Sqq82vyK2AzrmBRI8rxhgYR8zmw1NpjBk0ok9lQAR/653JoRkNit4
    t0IGCK/PlLTPCClzdL6KUrgLEepkW9GoAA/u5T/JddF2fwvydW86E4vTsQFjvyoMmiAy
    BvDc6mjPGvhVars1bpWB6CsrhJ0/hyHqV31u3P6lD088X93m2B6mMXs+M0aBwLUumKMb
    lYEA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXvdOeuWroQ="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xAUI4nYUD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 Nov 2021 19:04:49 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>
Cc:     Torsten Duwe <duwe@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH 1/3] crypto: drbg - ignore jitterentropy errors if not in FIPS mode
Date:   Tue, 30 Nov 2021 19:04:48 +0100
Message-ID: <2799389.mtFdQKXovp@tauon.chronox.de>
In-Reply-To: <20211130141009.6791-2-nstange@suse.de>
References: <20211130141009.6791-1-nstange@suse.de> <20211130141009.6791-2-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. November 2021, 15:10:07 CET schrieb Nicolai Stange:

Hi Nicolai,

> A subsequent patch will make the jitterentropy RNG to unconditionally
> report health test errors back to callers, independent of whether
> fips_enabled is set or not. The DRBG needs access to a functional
> jitterentropy instance only in FIPS mode (because it's the only SP800-90B
> compliant entropy source as it currently stands). Thus, it is perfectly
> fine for the DRBGs to obtain entropy from the jitterentropy source only
> on a best effort basis if fips_enabled is off.
> 
> Make the DRBGs to ignore jitterentropy failures if fips_enabled is not set.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>

Reviewed-by: Stephan Mueller <smueller@chronox.de>

Thanks
Stephan
> ---
>  crypto/drbg.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/drbg.c b/crypto/drbg.c
> index 5977a72afb03..177983b6ae38 100644
> --- a/crypto/drbg.c
> +++ b/crypto/drbg.c
> @@ -1193,11 +1193,14 @@ static int drbg_seed(struct drbg_state *drbg, struct
> drbg_string *pers, pr_devel("DRBG: (re)seeding with %u bytes of entropy\n",
>  				 entropylen);
>  		} else {
> -			/* Get seed from Jitter RNG */
> +			/*
> +			 * Get seed from Jitter RNG, failures are
> +			 * fatal only in FIPS mode.
> +			 */
>  			ret = crypto_rng_get_bytes(drbg->jent,
>  						   entropy + entropylen,
>  						   entropylen);
> -			if (ret) {
> +			if (fips_enabled && ret) {
>  				pr_devel("DRBG: jent failed with %d\n", ret);
> 
>  				/*


Ciao
Stephan


