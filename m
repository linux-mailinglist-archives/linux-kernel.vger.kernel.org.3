Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADF253EBF7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbiFFO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbiFFO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:58:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C744307A94;
        Mon,  6 Jun 2022 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vDRclcjga8kGMaQ++bzfqjieH/Oopd34EHTMUp62p0w=; b=kl++s1QqBSCGGS515hpbBboz0R
        OnKKNW7bq+COAZEFWPlZWPixaZdt38PrmyMbE8UTZH8ZoX0sQWG9nACQuh3bNQdQOk6KcWBS24psn
        ohEhY7YoFGQbwRMKayE947pRRIH5FkJF4vYwpyOZ9BvX9s8q0Dx8gm9TH4epY2oyLT7LX5OP8YS+z
        mwQL8I8SKC4wpEV4YGGLNHB1hUXiKcdJxo14DZjBGdfMLcBlPx0jynqMxGNkD5ldaboXAGXL95eGT
        RMC53OZRWCb57vBcNmvHxNddub59uZwVROKf+8RnfeM5nRBBKL4019rKc+RBxfr55TIbPScmeTGP4
        /OWw8NfQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyEBd-005Tbs-BR; Mon, 06 Jun 2022 14:58:33 +0000
Message-ID: <d0366136-428f-3af2-996e-a3d168b570e3@infradead.org>
Date:   Mon, 6 Jun 2022 07:58:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
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
 <20220606064935.1458903-2-neal_liu@aspeedtech.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220606064935.1458903-2-neal_liu@aspeedtech.com>
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

Hi,

On 6/5/22 23:49, Neal Liu wrote:
> diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
> new file mode 100644
> index 000000000000..17b800286a51
> --- /dev/null
> +++ b/drivers/crypto/aspeed/Kconfig
> @@ -0,0 +1,22 @@
> +config CRYPTO_DEV_ASPEED
> +	tristate "Support for Aspeed cryptographic engine driver"
> +	depends on ARCH_ASPEED
> +	help
> +	Hash and Crypto Engine (HACE) is designed to accelerate the
> +	throughput of hash data digest, encryption and decryption.
> +
> +	Select y here to have support for the cryptographic driver
> +	available on Aspeed SoC.

All of the help text above (following the 'help' line) should be indented
with one tab + 2 spaces, as is done in the help text below here.

> +
> +config CRYPTO_DEV_ASPEED_HACE_HASH
> +        bool "Enable ASPEED Hash & Crypto Engine (HACE) hash"
> +        depends on CRYPTO_DEV_ASPEED

The 2 lines above should be indented with one tab instead of multiple spaces.

> +	select CRYPTO_SHA1
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
> +	select CRYPTO_HMAC
> +	help
> +	  Select here to enable ASPEED Hash & Crypto Engine (HACE)
> +	  hash driver.
> +	  Supports multiple message digest standards, including
> +	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.

-- 
~Randy
