Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9FC53E772
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbiFFO5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbiFFO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:57:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A5F2F1F3B;
        Mon,  6 Jun 2022 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=b4Cas22YvXWguCl9MVadBf58XqwkKGzOV9uwbfM1yR0=; b=U21+DJBV8mG13ppaokHm7Fb782
        OisPxobgWgrV3MykMs2B+HToa2G1JM8pcAFqzM07rEr0ATq9w9Sgxa2/XMIGwX5mBViDPvpOq+KzI
        Y4lHufHP+NFfTNoHoJEylR4cq5df1AgldeQsNDiiokFwetdgyvySGJuts+/oEnW0jn9QcN2hx2Jt7
        c9f9VBlnPJYYenO9AqdCBxw0mumB42POg+bnjGKBJqTffldzk+2LovdMaymR4aJusfnILmUzuV393
        BT0ZUra2b3MHizDhn5B8UK0ahq7z372i0+DghbNc+ivcsBBEEusRfRv/z2/yFcDGTRTGBC9P14xxj
        tD0LVESQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyEA5-005Taq-S8; Mon, 06 Jun 2022 14:56:59 +0000
Message-ID: <8f4176e7-87b0-1cf9-bcef-6a423d17fd6a@infradead.org>
Date:   Mon, 6 Jun 2022 07:56:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/5] crypto: aspeed: add HACE crypto driver
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-6-neal_liu@aspeedtech.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220606064935.1458903-6-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/5/22 23:49, Neal Liu wrote:
> diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
> index 17b800286a51..5e4d18288bf1 100644
> --- a/drivers/crypto/aspeed/Kconfig
> +++ b/drivers/crypto/aspeed/Kconfig
> @@ -20,3 +20,19 @@ config CRYPTO_DEV_ASPEED_HACE_HASH
>  	  hash driver.
>  	  Supports multiple message digest standards, including
>  	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.
> +
> +config CRYPTO_DEV_ASPEED_HACE_CRYPTO
> +        bool "Enable ASPEED Hash & Crypto Engine (HACE) crypto"
> +        depends on CRYPTO_DEV_ASPEED

The 2 lines above should be indented with one tab instead of multiple spaces.

> +	select CRYPTO_AES
> +	select CRYPTO_DES
> +	select CRYPTO_ECB
> +	select CRYPTO_CBC
> +	select CRYPTO_CFB
> +	select CRYPTO_OFB
> +	select CRYPTO_CTR
> +	help
> +	  Select here to enable ASPEED Hash & Crypto Engine (HACE)
> +	  crypto driver.
> +	  Supports AES/DES symmetric-key encryption and decryption
> +	  with ECB/CBC/CFB/OFB/CTR options.

-- 
~Randy
