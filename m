Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8076F572F25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiGMHY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiGMHYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:24:47 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4A3AE2A14;
        Wed, 13 Jul 2022 00:24:46 -0700 (PDT)
Received: from [192.168.87.140] (unknown [50.47.106.71])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0F8E2204DE8D;
        Wed, 13 Jul 2022 00:24:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F8E2204DE8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657697086;
        bh=xyfcr3sQR84Ly/nvTJHG4HPfK1atahpyAidjxl2yWkE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=XcZ097XeO7xeC7v5XUwwOFRNJp/3SfBdVsO4i5/EqL5rXYOykkBQcQFZrH5eUk+fH
         GdHfinkZgeYf9WzJKRJWvBSVXhqwf+/+rj3ay/Dezbp07FtUsA2j0v1iYW0PJpX9OH
         A6X9pNBzG17b2c4tBFt454w2F+v173E39Qb6miLI=
Message-ID: <7041bf01-d91f-3149-e8ba-5db4ba59f9bb@linux.microsoft.com>
Date:   Wed, 13 Jul 2022 00:24:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 1/5] crypto: aspeed: Add HACE hash driver
Content-Language: en-US
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
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
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
References: <20220705020936.1751771-1-neal_liu@aspeedtech.com>
 <20220705020936.1751771-2-neal_liu@aspeedtech.com>
 <45058512-0661-5d34-7faf-ddf3eb6142ec@linux.microsoft.com>
In-Reply-To: <45058512-0661-5d34-7faf-ddf3eb6142ec@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/12/2022 10:32 PM, Dhananjay Phadke wrote:
>> +static void aspeed_ahash_iV(struct aspeed_sham_reqctx *rctx)
>> +{
>> +    if (rctx->flags & SHA_FLAGS_SHA1)
>> +        memcpy(rctx->digest, sha1_iv, 32);
>> +    else if (rctx->flags & SHA_FLAGS_SHA224)
>> +        memcpy(rctx->digest, sha224_iv, 32);
>> +    else if (rctx->flags & SHA_FLAGS_SHA256)
>> +        memcpy(rctx->digest, sha256_iv, 32);
>> +    else if (rctx->flags & SHA_FLAGS_SHA384)
>> +        memcpy(rctx->digest, sha384_iv, 64);
>> +    else if (rctx->flags & SHA_FLAGS_SHA512)
>> +        memcpy(rctx->digest, sha512_iv, 64);
>> +    else if (rctx->flags & SHA_FLAGS_SHA512_224)
>> +        memcpy(rctx->digest, sha512_224_iv, 64);
>> +    else if (rctx->flags & SHA_FLAGS_SHA512_256)
>> +        memcpy(rctx->digest, sha512_256_iv, 64);
>> +}
> 
> Can use the "digsize" from reqctx to memcpy() instead lots of if..else
> conditionals for every request?

Sorry, meant pre-initialized ivsize not digsize, which could be
in alg wrapper structure (aspeed_hace_alg).

Thanks,
Dhananjay
