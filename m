Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75755A2688
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245353AbiHZLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbiHZLEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:04:53 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69BA5FFC;
        Fri, 26 Aug 2022 04:04:46 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oRX8M-00FQ3u-DB; Fri, 26 Aug 2022 21:04:19 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Aug 2022 19:04:18 +0800
Date:   Fri, 26 Aug 2022 19:04:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
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
Subject: Re: [PATCH v10 0/5] Add Aspeed crypto driver for hardware
 acceleration
Message-ID: <YwiospkrYMevTok9@gondor.apana.org.au>
References: <20220818035956.1160585-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818035956.1160585-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:59:51AM +0800, Neal Liu wrote:
> Aspeed Hash and Crypto Engine (HACE) is designed to accelerate the
> throughput of hash data digest, encryption and decryption.
> 
> These patches aim to add Aspeed hash & crypto driver support.
> The hash & crypto driver also pass the run-time self tests that
> take place at algorithm registration.
> 
> The patch series are tested on both AST2500 & AST2600 evaluation boards.
> 
> Tested-by below configs:
> - CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> - CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> - CONFIG_DMA_API_DEBUG=y
> - CONFIG_DMA_API_DEBUG_SG=y
> - CONFIG_CPU_BIG_ENDIAN=y
> 
> Change since v9:
> - Fix unnecessary "goto xxx".
> 
> Change since v8:
> - Remove __weak functions for register/unregister crypto algos.
> - Add missing functions of unregister crypto algos.
> - Use single debug config to control debug messages.
> 
> Change since v7:
> - Define debug Kconfigs.
> - Simplify assign iv/ivsize.
> - Simplify cra_init() for hmac related init.
> 
> Change since v6:
> - Refine debug print.
> - Change aspeed_sg_list struct memeber's type to __le32.
> 
> Change since v5:
> - Re-define HACE clock define to fix breaking ABI.
> 
> Change since v4:
> - Add AST2500 clock definition & dts node.
> - Add software fallback for handling corner cases.
> - Fix copy wrong key length.
> 
> Change since v3:
> - Use dmam_alloc_coherent() instead to manage dma_alloc_coherent().
> - Add more error handler of dma_prepare() & crypto_engine_start().
> 
> Change since v2:
> - Fix endianness issue. Tested on both little endian & big endian
>   system.
> - Use common crypto hardware engine for enqueue & dequeue requests.
> - Use pre-defined IVs for SHA-family.
> - Revise error handler flow.
> - Fix sorts of coding style problems.
> 
> Change since v1:
> - Add more error handlers, including DMA memory allocate/free, DMA
>   map/unmap, clock enable/disable, etc.
> - Fix check dma_map error for config DMA_API_DEBUG.
> - Fix dt-binding doc & dts node naming.
> 
> 
> Neal Liu (5):
>   crypto: aspeed: Add HACE hash driver
>   dt-bindings: clock: Add AST2500/AST2600 HACE reset definition
>   ARM: dts: aspeed: Add HACE device controller node
>   dt-bindings: crypto: add documentation for aspeed hace
>   crypto: aspeed: add HACE crypto driver
> 
>  .../bindings/crypto/aspeed,ast2500-hace.yaml  |   53 +
>  MAINTAINERS                                   |    7 +
>  arch/arm/boot/dts/aspeed-g5.dtsi              |    8 +
>  arch/arm/boot/dts/aspeed-g6.dtsi              |    8 +
>  drivers/crypto/Kconfig                        |    1 +
>  drivers/crypto/Makefile                       |    1 +
>  drivers/crypto/aspeed/Kconfig                 |   49 +
>  drivers/crypto/aspeed/Makefile                |    9 +
>  drivers/crypto/aspeed/aspeed-hace-crypto.c    | 1135 ++++++++++++++
>  drivers/crypto/aspeed/aspeed-hace-hash.c      | 1389 +++++++++++++++++
>  drivers/crypto/aspeed/aspeed-hace.c           |  288 ++++
>  drivers/crypto/aspeed/aspeed-hace.h           |  298 ++++
>  include/dt-bindings/clock/aspeed-clock.h      |    1 +
>  include/dt-bindings/clock/ast2600-clock.h     |    1 +
>  14 files changed, 3248 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
>  create mode 100644 drivers/crypto/aspeed/Kconfig
>  create mode 100644 drivers/crypto/aspeed/Makefile
>  create mode 100644 drivers/crypto/aspeed/aspeed-hace-crypto.c
>  create mode 100644 drivers/crypto/aspeed/aspeed-hace-hash.c
>  create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
>  create mode 100644 drivers/crypto/aspeed/aspeed-hace.h
> 
> -- 
> 2.25.1

All applied.  Thanks. 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
