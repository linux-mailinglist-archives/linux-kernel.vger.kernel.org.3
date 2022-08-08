Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8256A58CFEF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiHHVwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbiHHVwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:52:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AA11837D;
        Mon,  8 Aug 2022 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dvNfVeFM68NeDGpgWDR8lvpLIiBjBMnhp8o6sKAZx70=; b=yLmyMG0H9VbI3XPyB2a0F0I2UL
        U4uDMErbfNWJneBM5manH5HbGJmUKlIPGlSAq9glYPJX7OU6D4NOeI97RwRBKLHXs+bfiHCczFvAi
        89QGyZtfz33xlVskllnFS/3kPhH9Fhyuyg4nTLCg1vNAfN+shp3TLS6ogfa2ldpBTEN/d0EQDr983
        uyL+rXpC5Iy+hZWsYv82w77Q4ojWY0UVKX5SvnyxAD1hV6WuJOYXWuE1vvCHmV9qAeUFVjRaqOCT2
        PwcgMT7p+foybUyhbRlRxCp5kJC/SBlo9wzaZWAfhk5sRWzaiHliJy9oU3/NtSt7HoJprUi5qGvUz
        KYX6nMOg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLAfW-00GEjJ-04; Mon, 08 Aug 2022 21:52:14 +0000
Message-ID: <a7a08d22-e04a-d3c2-f245-b676aac9e551@infradead.org>
Date:   Mon, 8 Aug 2022 14:52:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 6/6] crypto: sa2ul_pka: Add SA2UL PKA driver
Content-Language: en-US
To:     Daniel Parks <danielrparks@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1659985696.git.danielrparks@ti.com>
 <b16fdaee8bcaaaa25d01c2e981ddf782ccf726b4.1659985696.git.danielrparks@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <b16fdaee8bcaaaa25d01c2e981ddf782ccf726b4.1659985696.git.danielrparks@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/8/22 12:12, Daniel Parks wrote:
> diff --git a/drivers/crypto/sa2ul_pka/Kconfig b/drivers/crypto/sa2ul_pka/Kconfig
> new file mode 100644
> index 000000000000..c4f87b14878e
> --- /dev/null
> +++ b/drivers/crypto/sa2ul_pka/Kconfig
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config CRYPTO_DEV_SA2UL_PKA
> +	tristate "Support for TI security accelerator public-key module"
> +	depends on CRYPTO_DEV_SA2UL || COMPILE_TEST
> +	select ARM64_CRYPTO
> +	select CRYPTO_AKCIPHER
> +	select CRYPTO_RSA
> +	select PACKING
> +	select CRYPTO_DH
> +	help
> +		The K3 security accelerator engine contains a public-key
> +		cryptography module. Select this if you want to use hardware
> +		acceleration for asymmetric cryptography on these devices. This
> +		engine is not available to the Linux cores on most devices; check
> +		your device tree if unsure.
> +
> +config CRYPTO_DEV_SA2UL_PKA_DEBUG
> +	bool "Debugging options for TI security accelerator public-key module"
> +	depends on CRYPTO_DEV_SA2UL_PKA
> +	default n
> +	help
> +		Enables the module options 'snapshot' and 'poison_mem' to assist
> +		in debugging the PKA driver. Choosing "y" will allow the root user
> +		to extract cryptographic keys from the driver, so do not enable in
> +		a production build.

Too much help text indentation.

from Documentation/process/coding-style.rst:

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

-- 
~Randy
