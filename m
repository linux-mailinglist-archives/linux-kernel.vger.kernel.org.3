Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A967455A662
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 05:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiFYD2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 23:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFYD2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 23:28:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D632F3DA7A;
        Fri, 24 Jun 2022 20:28:41 -0700 (PDT)
Received: from [192.168.86.247] (23-119-123-228.lightspeed.sntcca.sbcglobal.net [23.119.123.228])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7234E20C7956;
        Fri, 24 Jun 2022 20:28:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7234E20C7956
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1656127721;
        bh=JQrEV25Qq2xdPblGSoG19vTOK76ID9Ode4ej2R5wAh8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OspP72b4TUDmYtGZoMOvxPICki6wwW3eHAaAo/JIHK4PRJagLc+N0v38EbMeQQMHE
         GQmbi9VPrzmjZCQgEKjbZsfSqFXD6mjNCv52DKX+35DahzdvBxkqCAPz007w9QwIYP
         Ov8ZnP1gQaUxChSEwjmi+22z47+4jZ4M51gTFSp4=
Message-ID: <3dde4d8e-5f97-dc07-1763-981942d23f12@linux.microsoft.com>
Date:   Fri, 24 Jun 2022 20:28:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/5] Add Aspeed crypto driver for hardware acceleration
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        BMC-SW@aspeedtech.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220624090827.3909179-1-neal_liu@aspeedtech.com>
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
In-Reply-To: <20220624090827.3909179-1-neal_liu@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neal,

On 6/24/2022 2:08 AM, Neal Liu wrote:
> Aspeed Hash and Crypto Engine (HACE) is designed to accelerate the
> throughput of hash data digest, encryption and decryption.
> 
> These patches aim to add Aspeed hash & crypto driver support.
> The hash & crypto driver also pass the run-time self tests that
> take place at algorithm registration.
> 
> Tested-by below configs:
> - CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> - CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> - CONFIG_DMA_API_DEBUG=y
> - CONFIG_DMA_API_DEBUG_SG=y
> - CONFIG_CPU_BIG_ENDIAN=y
> 
> Change since v3:
> - Use dmam_alloc_coherent() instead to manage dma_alloc_coherent().
> - Add more error handler of dma_prepare() & crypto_engine_start().
> 
> Change since v2:
> - Fix endianness issue. Tested on both little endian & big endian
>    system.
> - Use common crypto hardware engine for enqueue & dequeue requests.
> - Use pre-defined IVs for SHA-family.
> - Revise error handler flow.
> - Fix sorts of coding style problems.
> 
> Change since v1:
> - Add more error handlers, including DMA memory allocate/free, DMA
>    map/unmap, clock enable/disable, etc.
> - Fix check dma_map error for config DMA_API_DEBUG.
> - Fix dt-binding doc & dts node naming.
> 
> 
> Neal Liu (5):
>    crypto: aspeed: Add HACE hash driver
>    dt-bindings: clock: Add AST2600 HACE reset definition
>    ARM: dts: aspeed: Add HACE device controller node
>    dt-bindings: crypto: add documentation for aspeed hace
>    crypto: aspeed: add HACE crypto driver

The driver claims compatible with aspeed,ast2500-hace, but there's no
equivalent g5 DTS change (patch 3/5) or reset definition (patch 2/5) in
aspeed-clock.h? Either drop ast2500 compatible from this patch series or 
fix these.

Thanks,
Dhananjay
