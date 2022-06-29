Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9698A560007
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiF2Mg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiF2MgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:36:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C4928714;
        Wed, 29 Jun 2022 05:36:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i205-20020a1c3bd6000000b003a03567d5e9so112274wma.1;
        Wed, 29 Jun 2022 05:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DT+Hg4MXkKGN3iF9yrZOwKd7X9E+dCZfidIy8wnPVhs=;
        b=F8o1gvCHUO0AaSUw95FBfODVx1rKjGucblSlLnK9kzaYfE4z45hG7/Q/0KjOurXk7k
         Z70esZYM27OhUOpxpekDkWnIItmpXDhFpQWwzMoeE0IBXwAC9ybEhCSq8q93QYitDjWK
         zgR4KYeevxyii1mwwruDTmr820y2WMFmVm43a6vTqkK1gI+CHQR0yidq+jmyqYIuY7nz
         8cRigmOgNQB5dVOh5+9QQPMh60cfzuHbfmuguEKDD5O8fBQ7MrH/cWNHZsYfGhbh3owv
         bEtgGvWqCJDRDrN2FskGip5MmzN9dyyDEw8ezYCegOSw94JvExbdz76QyIJ+Dbr2kKkA
         jneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DT+Hg4MXkKGN3iF9yrZOwKd7X9E+dCZfidIy8wnPVhs=;
        b=Br3tCtxtUcLj53gRoQLh9UYTjaZcv56TsRBCsl6eX2b9IVhLWK6TfCQ/PYO39WAYn4
         b7GBRnid+5OdS7EMKor2XFtKyvbhdgdrTBZ0l9IA2wu+3K4xnIfEZNC01acm1QOI65qr
         8EIXikUGUfqplGRB0ePy6onoPTisk8RDyMMvV04QuAyi7qkLIEOG8bDb9oBqVES8tu7L
         ki/WFEdk1p3cvyieu0KE7pefEffUGf75CMdYy+MDfsCzbdTVj5HscsX6tdiPK1vGyH5x
         xOCG2PHEH8oaU7c0xSSftAYcWJ5gr13ftUZt2D8bAyGVP8pSThdE1xLWAC7RqfiW9Hrw
         yrNQ==
X-Gm-Message-State: AJIora+CWEnzLwYasI8V9I/l11qyOt3BxmEjZux+HsdJs2IDIZXFb/3I
        uxiA9w8eI24P/+oMEJSj7iQ=
X-Google-Smtp-Source: AGRyM1tT3S6YJDUvU9N/m4Ujal72KTiL/+4qd507Qh2/vNqbs55SHP32TF7gvAP8aAEBEsqXzAaQ6g==
X-Received: by 2002:a7b:c003:0:b0:39c:5642:e415 with SMTP id c3-20020a7bc003000000b0039c5642e415mr5312894wmb.111.1656506183225;
        Wed, 29 Jun 2022 05:36:23 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm16658872wru.47.2022.06.29.05.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:36:22 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:36:20 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v6 1/5] crypto: aspeed: Add HACE hash driver
Message-ID: <YrxHRMoMYW+QDSnd@Red>
References: <20220629094426.1930589-1-neal_liu@aspeedtech.com>
 <20220629094426.1930589-2-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629094426.1930589-2-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Jun 29, 2022 at 05:44:22PM +0800, Neal Liu a écrit :
> Hash and Crypto Engine (HACE) is designed to accelerate the
> throughput of hash data digest, encryption, and decryption.
> 
> Basically, HACE can be divided into two independently engines
> - Hash Engine and Crypto Engine. This patch aims to add HACE
> hash engine driver for hash accelerator.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> ---

Hello

I have some minor comments below.

> +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> @@ -0,0 +1,1428 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2021 Aspeed Technology Inc.
> + */
> +
> +#include "aspeed-hace.h"
> +
> +#ifdef ASPEED_AHASH_DEBUG
> +#define AHASH_DBG(h, fmt, ...)	\
> +	dev_dbg((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
> +#else
> +#define AHASH_DBG(h, fmt, ...)	\
> +	((void)(h))
> +#endif

Hello why not direclty use dev_dbg ?
You will still need something to do to enable dev_dbg, so why force to add the need to re-compile it with ASPEED_AHASH_DEBUG ?


[...]

> +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> +		return -ENOMEM;
> +	}

An error displayed as warning.

[...]
> +	if (!sg_len) {
> +		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");

Same here. In fact you have lot of error displayed as warning in the driver.

[...]
> +/* Weak function for HACE hash */
> +void __weak aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	pr_warn("%s: Not supported yet\n", __func__);
> +}
> +
> +void __weak aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	pr_warn("%s: Not supported yet\n", __func__);
> +}

Why not use dev_warn ?


[...]

> +struct aspeed_sg_list {
> +	u32 len;
> +	u32 phy_addr;
> +};

Since it is a descriptor where all member are written with cpu_to_le32(), it should be __le32.

Regards
