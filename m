Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE15659A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiGDPUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiGDPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:20:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D910FE6;
        Mon,  4 Jul 2022 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GcBIE8F1Amhld86dWfigGM4Z1aJl6HhmPq0gymmt37g=; b=Y9uYw+EXJiWS8zl4Zcb6tlYkGl
        d2PjqZGF64zWe7kTqQHg9Fzh1vuRY+Qsu6wLI21ezbQWf91+UTqUnV1E1/ZN9gz56acNlj0uMM++3
        Az9GydpPSOv0hidBJnLbxULDj4ahiWUY+W8GXWYIINP67ue9B0uPRJwEf7L+II+9m1q2uc5QfdAsT
        sB9vASPDwp6uX8bDAF5IK/AE6uhwyeTW6C2ReucCt5gCvMoeFwb02r6WeYbxAY2/ofQuzlWVh/elj
        o8S9TIs9SbR8puNdkmYMNhmAO7tHw9iHduTFKxPEFVdvodJ10/lQS3Z2ucIYE1p3MYGTZZEXKwiZh
        YzX+T9Sw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8NsB-009fdZ-CO; Mon, 04 Jul 2022 15:20:27 +0000
Message-ID: <3770bc6d-b3cc-9e49-a832-4c15af0b5f1a@infradead.org>
Date:   Mon, 4 Jul 2022 08:20:24 -0700
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220704121730.127925-3-krzysztof.kozlowski@linaro.org>
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

Hi,

On 7/4/22 05:17, Krzysztof Kozlowski wrote:
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index e718b8735444..2c8091535bf7 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -228,4 +228,19 @@ config QCOM_APR
>  	  application processor and QDSP6. APR is
>  	  used by audio driver to configure QDSP6
>  	  ASM, ADM and AFE modules.
> +
> +config QCOM_ICC_BWMON
> +	tristate "QCOM Interconnect Bandwidth Monitor driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select PM_OPP
> +	help
> +	  Sets up driver monitoring bandwidth on various interconnects and

	  Sets up driver bandwidth monitoring

would be better, I think.

> +	  based on that voting for interconnect bandwidth, adjusting their
> +	  speed to current demand.
> +	  Current implementation brings support for BWMON v4, used for example
> +	  on SDM845 to measure bandwidth between CPU (gladiator_noc) and Last
> +	  Level Cache (memnoc).  Usage of this BWMON allows to remove some of
> +	  the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
> +	  memory throughput even with lower CPU frequencies.

-- 
~Randy
