Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC4565DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiGDTPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiGDTPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:15:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BE76351;
        Mon,  4 Jul 2022 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9LEtZ7AeBNN6P70RAq3sG9bOAFlAYv5x5HPRLtRJ+C4=; b=pw1Zw0tibK+sD2iCiB4IwoFEFf
        163lTNfUK64j7CDKzhzuYZXLNznA7TJNPEpD/Durtmk4qqNOgJc9x4ZxVHbRVRLv01kzuuB+f+cJ4
        CxTZEczO/AytaFQOJ6uSUUM7SPESP1D4ks5M3ilbVCFydWe813COKbqRkuMemd6SVkLSsGV275lM6
        2lNbhzRQrzy8B/7wgNNs7i/NTqVTgEnKlqXUuiSb8Y/4KLM++gwtn9I7LyMKFz1+OAaSLnLpaoXs5
        No5yJ2kqN4nvlMFZvmcm4MAkpXJ2T2z+KqBjHgHoliz1+J5f+KNZvCHbxPep6YCfEQQG/R6odJIDx
        LRz+mfoQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8RXr-00B9Ry-GN; Mon, 04 Jul 2022 19:15:43 +0000
Message-ID: <d803c02c-1a9c-59be-969a-5e4daae5f59c@infradead.org>
Date:   Mon, 4 Jul 2022 12:15:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 2/4] soc: qcom: icc-bwmon: Add bandwidth monitoring
 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220704121730.127925-1-krzysztof.kozlowski@linaro.org>
 <20220704121730.127925-3-krzysztof.kozlowski@linaro.org>
 <3770bc6d-b3cc-9e49-a832-4c15af0b5f1a@infradead.org>
 <9cd658cd-3b8c-89d1-651d-ce81794fb68c@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <9cd658cd-3b8c-89d1-651d-ce81794fb68c@linaro.org>
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



On 7/4/22 08:22, Krzysztof Kozlowski wrote:
> On 04/07/2022 17:20, Randy Dunlap wrote:
>> Hi,
>>
>> On 7/4/22 05:17, Krzysztof Kozlowski wrote:
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index e718b8735444..2c8091535bf7 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -228,4 +228,19 @@ config QCOM_APR
>>>  	  application processor and QDSP6. APR is
>>>  	  used by audio driver to configure QDSP6
>>>  	  ASM, ADM and AFE modules.
>>> +
>>> +config QCOM_ICC_BWMON
>>> +	tristate "QCOM Interconnect Bandwidth Monitor driver"
>>> +	depends on ARCH_QCOM || COMPILE_TEST
>>> +	select PM_OPP
>>> +	help
>>> +	  Sets up driver monitoring bandwidth on various interconnects and
>>
>> 	  Sets up driver bandwidth monitoring
>>
>> would be better, I think.
> 
> It's a driver which monitors bandwidth, so your version sounds a bit
> like monitoring of driver's bandwidth.
> 
> Maybe should be:
>     Sets up driver which monitors bandwidth...
> ?

Yes, that's OK.
Thanks.

-- 
~Randy
