Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6980D4689B2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 07:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhLEGOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 01:14:50 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:27629 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhLEGOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 01:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638684681;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=f/FeaCRLOpE1tFf1np9TIYoLK6aYdRvwGnFJNttpmdA=;
    b=LUF9f0g/d3oX8BO6+vYIVvgKFPD/JFe+rjeQvzdshiEmwTq/ZVDLcdP9qvyXY01LQ5
    FkzE9SzH6AdDt5xSKNYJOsBEAvHStWYMoZdLmwrGdiCwJkHZIom37erH1vgQNKWjOxSR
    5HpycfL6bxQiZ5YM1UqWTISyFSK8cIGe0j/lsm1RM7LGSCrXhcex/fWNHvu0R5zBBvT4
    J2cxU5Jaxq6IwUMr9P3r8f2zYgxcHsPQIPyM9Bvxho22bK/0m/Sw6MgklSa8MmO+whyj
    x99qoFu8EpWb3HRsJb9/uC/3R89mcpB2doZwfy3WowHsf5vCITEnoYV31bs4G9zQmhPp
    OvDQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJfSf8vUi"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xB56BKtvI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 5 Dec 2021 07:11:20 +0100 (CET)
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
Subject: Re: [PATCH 12/18] crypto: dh - introduce support for ephemeral key generation to qat driver
Date:   Sun, 05 Dec 2021 07:11:20 +0100
Message-ID: <5375313.ZASKD2KPVS@positron.chronox.de>
In-Reply-To: <20211201004858.19831-13-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de> <20211201004858.19831-13-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 1. Dezember 2021, 01:48:52 CET schrieb Nicolai Stange:

Hi Nicolai,

> A previous patch made the dh-generic implementation's ->set_secret() to
> generate an ephemeral key in case the input ->key_size is zero, just in
> analogy with ecdh. Make the qat crypto driver's DH implementation to
> behave consistently by doing the same.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  drivers/crypto/qat/qat_common/qat_asym_algs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c
> b/drivers/crypto/qat/qat_common/qat_asym_algs.c index
> b0b78445418b..e0d3a70fa6b1 100644
> --- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
> +++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
> @@ -441,11 +441,20 @@ static int qat_dh_set_secret(struct crypto_kpp *tfm,
> const void *buf, struct qat_dh_ctx *ctx = kpp_tfm_ctx(tfm);
>  	struct device *dev = &GET_DEV(ctx->inst->accel_dev);
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
>  	qat_dh_clear_ctx(dev, ctx);


Ciao
Stephan


