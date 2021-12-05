Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750AF4689B8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 07:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhLEGO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 01:14:58 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:16547 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhLEGOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 01:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638684687;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+n8+frBf6zx7jHVeUpPB6FrmkjWf9HAjFsL4dnKcH6I=;
    b=QIYNnTum1A0FrCkDOhRYPN0PzOsnLvw8H8YtLfI1qMbM6KGEdwtBLS5siM1N0bgg8Y
    K8Zhmg+XSO99gwkNv61sUr7YCUnfBtqWninvUcrOsdq4fyExV9zpYKaeAcPfX9XVfN/H
    pUIJjIJ2LoGt59YKWbe9KZ7yYuj9vnLwiblQZ5s5ze5PDXTsG4asCFmJMzCWCcFRmRbn
    BqHIICllC9C32XnJI4ini/Zg2/398cx7EdnshgpWkR4Zk8EV6/1nRx1HQJw4zX12eVso
    w4oNZTYhSKbYsSuTM9ZNebW8AyVYdc8pZ8wPyCScYoo2KIxiUl+jHtVOxC3biX1PB6IN
    oVAQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJfSf8vUi"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xB56BQtvK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 5 Dec 2021 07:11:26 +0100 (CET)
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
Subject: Re: [PATCH 11/18] crypto: dh - introduce support for ephemeral key generation to hpre driver
Date:   Sun, 05 Dec 2021 07:11:26 +0100
Message-ID: <2523630.fDdHjke4Dd@positron.chronox.de>
In-Reply-To: <20211201004858.19831-12-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de> <20211201004858.19831-12-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 1. Dezember 2021, 01:48:51 CET schrieb Nicolai Stange:

Hi Nicolai,

> A previous patch made the dh-generic implementation's ->set_secret() to
> generate an ephemeral key in case the input ->key_size is zero, just in
> analogy with ecdh. Make the hpre crypto driver's DH implementation to
> behave consistently by doing the same.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
> b/drivers/crypto/hisilicon/hpre/hpre_crypto.c index
> a032c192ef1d..02ca79e263f1 100644
> --- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
> +++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
> @@ -701,11 +701,20 @@ static int hpre_dh_set_secret(struct crypto_kpp *tfm,
> const void *buf, {
>  	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
>  	struct dh params;
> +	char key[CRYPTO_DH_MAX_PRIVKEY_SIZE];
>  	int ret;
> 
>  	if (crypto_dh_decode_key(buf, len, &params) < 0)
>  		return -EINVAL;
> 
> +	if (!params.key_size) {

dto.

> +		ret = crypto_dh_gen_privkey(params.group_id, key,
> +					    &params.key_size);
> +		if (ret)
> +			return ret;
> +		params.key = key;
> +	}
> +
>  	/* Free old secret if any */
>  	hpre_dh_clear_ctx(ctx, false);
> 
> @@ -716,6 +725,8 @@ static int hpre_dh_set_secret(struct crypto_kpp *tfm,
> const void *buf, memcpy(ctx->dh.xa_p + (ctx->key_sz - params.key_size),
> params.key, params.key_size);
> 
> +	memzero_explicit(key, sizeof(key));
> +
>  	return 0;
> 
>  err_clear_ctx:


Ciao
Stephan


