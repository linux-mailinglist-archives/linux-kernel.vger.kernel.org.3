Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECEA5838A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiG1GS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiG1GSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:18:24 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCA115D0F2;
        Wed, 27 Jul 2022 23:18:22 -0700 (PDT)
Received: from [192.168.87.140] (unknown [50.47.106.71])
        by linux.microsoft.com (Postfix) with ESMTPSA id 18D4620FE86F;
        Wed, 27 Jul 2022 23:18:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18D4620FE86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1658989102;
        bh=dOWYO9Tc9My88lpKym2V9t4KyEwrpWAjOIRXvs4C5XQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ak0uQ40xJOJRfAIrFUYHIr9TFMyUDjJbJTZm6CGUkKy+4qOq8U56I8c+XrKWgMQ8B
         csdkyl9vpQCSv5JuJFTpnLAuSRIlKNFG4wOc1us79zruuwJNmDK1gCUlFhLZtlZyG7
         wGUvBV/uHTBcB+UTdH5KjjtwmuxD2IG+4K95CEvI=
Message-ID: <450dee2f-63bf-51a7-730e-b780b594c1c5@linux.microsoft.com>
Date:   Wed, 27 Jul 2022 23:18:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 5/5] crypto: aspeed: add HACE crypto driver
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
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
References: <20220726113448.2964968-1-neal_liu@aspeedtech.com>
 <20220726113448.2964968-6-neal_liu@aspeedtech.com>
 <9d6beefe-9974-22f8-750c-68c9acb707ab@linux.microsoft.com>
 <TY2PR06MB32137A54B483D6D700BDE7EC80979@TY2PR06MB3213.apcprd06.prod.outlook.com>
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
In-Reply-To: <TY2PR06MB32137A54B483D6D700BDE7EC80979@TY2PR06MB3213.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2022 10:31 PM, Neal Liu wrote:
>> Why are separate options required for hash and crypto algorithms, if hace is
>> only hw crypto on the SoCs?
>>
>> Looks like that's requiring unnecessary __weak register / unregister functions
>> [see below].
>>
>> Couldn't just two options CONFIG_CRYPTO_DEV_ASPEED and
>> CONFIG_CRYPTO_DEV_ASPEED_DEBUG be simpler to set for downstream
>> defconfigs?
> I would like to separate different algorithms by different options for more convenient for further use and debug.
> We also have RSA engine named ACRY, and would upstream once hash & crypto being accepted.
> So combined them into one option seems not a good choice for multiple hw crypto, do you agree?

Not sure what's the use case of just enabling crypto or hash separately
out of same HW engine and esp. when there's no alternative accel 
available, but that's fine.

If ARCY is different HW engine (interface) then having separate config
sounds logical.

Multiplying DEBUG configs seems unnecessary though. With dynamic debug
any of the dev_dbg could be turned on. Suggest using single one for
the module, if not drop it altogether. Following code is still not
covered by Kconfig, it in common code.

 > +#ifdef ASPEED_HACE_DEBUG
 > +#define HACE_DBG(d, fmt, ...)	\
 > +	dev_info((d)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
 > +#else
 > +#define HACE_DBG(d, fmt, ...)	\
 > +	dev_dbg((d)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
 > +#endif

Regards,
Dhananjay


