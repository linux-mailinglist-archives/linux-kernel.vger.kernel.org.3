Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042384BBA9E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiBROaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:30:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiBROaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:30:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 517F45B884
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645194592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cre5M583hm0qhLExvImfc/VgDcRzV3gtvq6Dg7X1ldM=;
        b=H/GBBCvOGROrJPGmMC9QvXWee+S+GKDSoSknJqAwaOokvhxqgOiRdYSl0ENsFnTD2M0UXZ
        GFYCMHyP4M1NNozOPG0UEHxA1JydVdkKPiiBXf2k653XwTMwkE3O4pa9Aze3xrHd9Ur7X1
        Xer/7StNB88KjCBWd/AT0TAcKmaKfig=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-Qj0_L57pNFiq2cDW9ApNaQ-1; Fri, 18 Feb 2022 09:29:51 -0500
X-MC-Unique: Qj0_L57pNFiq2cDW9ApNaQ-1
Received: by mail-qv1-f69.google.com with SMTP id kc30-20020a056214411e00b0042cb92fe8bbso8993453qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Cre5M583hm0qhLExvImfc/VgDcRzV3gtvq6Dg7X1ldM=;
        b=RGiSlaIFf4dC3+HOWeClYKErC+71W1snHXb6tbuHIKFVOrct99IuHObOsUOaxBI7yy
         8cro7o9zQjgl/sO4beHifkP0+vyWwl40kzF0+Bk4IIYl7F5yKfZb/uQfGRz2e9bZGzJ9
         CNSzhFqWLx+pHhQFAk5tQfo8AB7azLjpRoEvbEtNBs344xJljUhEbExjMiRFOA8f1VIa
         7VJTbeHGqiiU8i0x18zmmKm7M/DqTssVhIxd8qn/QnQmwBqmDPDTBMJEB0paMIZDFIhE
         aeYex69ggkL6HnOiI4O3lhlN2nr0HFuLYMiHWwerld1kWxsru0DMf5RvTn/Rupkz8VNc
         R0lg==
X-Gm-Message-State: AOAM5304QGCk+6t22KBu+aWkKYB6Pv/etmVu31T5m/0JBCEk7W95Tlpw
        nJo0kx0dvd8Z2IzU14tioCDfzkCBuX0K//NT/QjTCQv5NJVuQyB7G5Kaxl4Le+1Vb+8f6F2hoJC
        tojkJTJMIHsZNjfwnGO1funMl
X-Received: by 2002:a0c:be8f:0:b0:42c:5083:c6d2 with SMTP id n15-20020a0cbe8f000000b0042c5083c6d2mr5952010qvi.86.1645194590525;
        Fri, 18 Feb 2022 06:29:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6spxCalP4ZsB+KSA5YXirNzgk82RqD8K1eLb67sD60cSs8GVpewcKL+2Q5q7aU7TWOZo3LA==
X-Received: by 2002:a0c:be8f:0:b0:42c:5083:c6d2 with SMTP id n15-20020a0cbe8f000000b0042c5083c6d2mr5951987qvi.86.1645194590259;
        Fri, 18 Feb 2022 06:29:50 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x13sm23119558qko.114.2022.02.18.06.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 06:29:49 -0800 (PST)
Subject: Re: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
 info
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "corbet@lwn.net" <corbet@lwn.net>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-3-tianfei.zhang@intel.com>
 <0de9c8fb-0f04-684f-630c-1d13b0b55ba1@redhat.com>
 <BN9PR11MB54839B6D444DCEB7FD789F33E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <447ce66b-dea7-da2b-6879-e4d37a74ba7d@redhat.com>
Date:   Fri, 18 Feb 2022 06:29:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB54839B6D444DCEB7FD789F33E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/17/22 10:53 PM, Zhang, Tianfei wrote:
>
>> -----Original Message-----
>> From: Tom Rix <trix@redhat.com>
>> Sent: Tuesday, February 15, 2022 10:49 PM
>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao <hao.wu@intel.com>;
>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: corbet@lwn.net
>> Subject: Re: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq info
>>
>>
>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>> From: Tianfei Zhang <tianfei.zhang@intel.com>
>>>
>>> The feature ID of "Port User Interrupt" and the "PMCI Subsystem" are
>>> identical, 0x12, but one is for FME, other is for Port. It should
>>> check the feature type While parsing the irq info in
>>> parse_feature_irqs().
>> This seems like a bug fix and not part of iofs feature.
>>
>> Split this out of the patchset.

?

>>
>> This is a workaround a hardware problem, there should be some comments to
>> the effect that you can't trust _this_ or _that_ feature id and some special
>> handling earlier.
>>
>> The ambiguity of feature id is a problem, and this sort of bug will happen again.
>>
>> What can be done to prevent this in the future ?
> This patch is not workaround, this is a bug fix for DFL driver.
> The root cause is that DLF driver miss check the feature type while parsing the interrupt information,
> because some Feature IDs are identical between FME and Port, like PMCI in FME and "Port User Interrupt"
> in Port.
> The definition of Feature ID is here:
> https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feature-ids.rst
Helpful but hidden.  At least a link to this should be added to 
Documentation/fpga/dfl.rst.
>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>> ---
>>>    drivers/fpga/dfl.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c index
>>> 599bb21d86af..26f8cf890700 100644
>>> --- a/drivers/fpga/dfl.c
>>> +++ b/drivers/fpga/dfl.c
>>> @@ -940,9 +940,14 @@ static int parse_feature_irqs(struct
>> build_feature_devs_info *binfo,
>>>    {
>>>    	void __iomem *base = binfo->ioaddr + ofst;
>>>    	unsigned int i, ibase, inr = 0;
>>> +	enum dfl_id_type type;
>>>    	int virq;
>>>    	u64 v;
>>>
>>> +	type = feature_dev_id_type(binfo->feature_dev);
>>> +	if (type >= DFL_ID_MAX)
>>> +		return -EINVAL;
>>> +
>>>    	/*
>>>    	 * Ideally DFL framework should only read info from DFL header, but
>>>    	 * current version DFL only provides mmio resources information for
>>> @@ -959,16 +964,22 @@ static int parse_feature_irqs(struct
>> build_feature_devs_info *binfo,
>>>    	 */
>>>    	switch (fid) {
>>>    	case PORT_FEATURE_ID_UINT:
>>> +		if (type != PORT_ID)
>>> +			break;
>> Instead of embedding a break in the switch, break the switch into fme switch
>> and port switch
>>
>> if (type == PORT_ID)
>>
>>     port-switch
>>
>> else if (type == FME_ID
>>
>>     fme-switch
> Your suggestion is looks good  for me, I will change on next version.
>
>> Tom
>>
>>>    		v = readq(base + PORT_UINT_CAP);
>>>    		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
>>>    		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
>>>    		break;
>>>    	case PORT_FEATURE_ID_ERROR:
>>> +		if (type != PORT_ID)
>>> +			break;
>>>    		v = readq(base + PORT_ERROR_CAP);
>>>    		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
>>>    		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
>>>    		break;
>>>    	case FME_FEATURE_ID_GLOBAL_ERR:
>>> +		if (type != FME_ID)
>>> +			break;
>>>    		v = readq(base + FME_ERROR_CAP);
>>>    		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
>>>    		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);

