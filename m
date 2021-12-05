Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F924689B5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 07:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhLEGOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 01:14:53 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:24361 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhLEGOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 01:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638684683;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TKuuuo85OThae+nAGSC0rFg1MzW4ZqICR5245aK6xpM=;
    b=A28jzU/JGYOx+o9g3hdqToMfH2K4sSnTOLygXpK4UQL67t0By2jkOuz0gLRNOBcPsh
    VAKx6kb76aC8FA6DPjPLD1uuOhUxNNTS5+1SPe6Hy9H3jbea5CDgiU+bjoeWlw4NScdg
    3dMPM91zk1/qC8u+v92RgYu0r2ATas5XKYn4v8oE21hDtwkn3lIYEWtHGr6vY98k8pvp
    auLneoQbXR78Sxp3q8zQpF7JBXoOQAEs5RvoPrOn6vCSeC8FbmkcHlm4JbL31wUxxYFy
    hOsKrF7dIo2ck+FTj2ldaH/y/vCPAX2y1dQv2oHZktNroRLQEsT2fChFO5tutGFpBZhb
    sJ/w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJfSf8vUi"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xB56BNtvJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 5 Dec 2021 07:11:23 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>
Cc:     Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH 10/18] crypto: dh - introduce support for ephemeral key generation to dh-generic
Date:   Sun, 05 Dec 2021 07:11:22 +0100
Message-ID: <1972149.YKUYFuaPT4@positron.chronox.de>
In-Reply-To: <20211201004858.19831-11-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de> <20211201004858.19831-11-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 1. Dezember 2021, 01:48:50 CET schrieb Nicolai Stange:

Hi Nicolai,

> The support for NVME in-band authentication currently in the works ([1])
> needs to generate ephemeral DH keys. Make dh-generic's ->set_secret()
> to generate an ephemeral key via the recently added crypto_dh_gen_privkey()
> in case the input ->key_size is zero. Note that this behaviour is in
> analogy to ecdh's ->set_secret().
> 
> [1] https://lkml.kernel.org/r/20211122074727.25988-4-hare@suse.de
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  crypto/dh.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/crypto/dh.c b/crypto/dh.c
> index 131b80064cb1..2e49b114e038 100644
> --- a/crypto/dh.c
> +++ b/crypto/dh.c
> @@ -71,25 +71,41 @@ static int dh_set_secret(struct crypto_kpp *tfm, const
> void *buf, {
>  	struct dh_ctx *ctx = dh_get_ctx(tfm);
>  	struct dh params;
> +	char key[CRYPTO_DH_MAX_PRIVKEY_SIZE];
> +	int err;
> 
>  	/* Free the old MPI key if any */
>  	dh_clear_ctx(ctx);
> 
> -	if (crypto_dh_decode_key(buf, len, &params) < 0)
> +	err = crypto_dh_decode_key(buf, len, &params);
> +	if (err)
>  		goto err_clear_ctx;
> 
> -	if (dh_set_params(ctx, &params) < 0)
> +	if (!params.key_size) {

As this params data may come from user space, shouldn't we use the same logic 
as in ecdh's set_key function:

if (!params.key || !params.key_size)

?


> +		err = crypto_dh_gen_privkey(params.group_id, key,
> +					    &params.key_size);
> +		if (err)
> +			goto err_clear_ctx;
> +		params.key = key;
> +	}
> +
> +	err = dh_set_params(ctx, &params);
> +	if (err)
>  		goto err_clear_ctx;
> 
>  	ctx->xa = mpi_read_raw_data(params.key, params.key_size);
> -	if (!ctx->xa)
> +	if (!ctx->xa) {
> +		err = -EINVAL;
>  		goto err_clear_ctx;
> +	}
> +
> +	memzero_explicit(key, sizeof(key));
> 
>  	return 0;
> 
>  err_clear_ctx:
>  	dh_clear_ctx(ctx);
> -	return -EINVAL;
> +	return err;
>  }
> 
>  /*


Ciao
Stephan


