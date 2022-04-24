Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F8950D123
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiDXK2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbiDXK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:27:31 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E69E5E74B;
        Sun, 24 Apr 2022 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650795871; x=1682331871;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5EWdBAYXxR4LyG1mkoRqIGtYHft5pGIkFSUzkEcRgjI=;
  b=NIkwg+Vt4edA3vv3TewtYNzZyr8Pq5wb6ufwhVQBAhzHQUZb4aFFEZGd
   6569ud5PShF+7eMsjek2tgMEPwVeqUKaOORdLP/Kf195maq4dm031an8v
   HXH+AjFq96+D8zyVNQbdiguoGMXh/6Z9xoooRzmU5K/ZqVnXB1UOTUda4
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Apr 2022 03:23:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 03:23:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 24 Apr 2022 03:23:28 -0700
Received: from [10.216.46.93] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 24 Apr
 2022 03:23:07 -0700
Message-ID: <e85dace0-66f5-6ef1-425a-d5cff4278c19@quicinc.com>
Date:   Sun, 24 Apr 2022 15:52:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V4] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Content-Language: en-US
To:     Philipp Zabel <p.zabel@pengutronix.de>, <adrian.hunter@intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <ulf.hansson@linaro.org>, <chris@printf.net>,
        <venkatg@codeaurora.org>, <gdjakov@mm-sol.com>,
        <quic_asutoshd@quicinc.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sartgarg@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sayalil@quicinc.com>
References: <1649759983-22035-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1ee3b0619ee976eaf88e7207318770d441418c94.camel@pengutronix.de>
 <1943a5fb-cf6c-f358-9e27-408792a458ce@quicinc.com>
 <dc2252f03db5881dbb17006c910dfca54c7d2fee.camel@pengutronix.de>
 <fb6480f6-f004-c02d-09fe-92a64785a0c5@quicinc.com>
 <9b2b9460e46d8544867589ce61d380265f42cd04.camel@pengutronix.de>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <9b2b9460e46d8544867589ce61d380265f42cd04.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review.

Please find the inline comments.

Thanks,

Sajida

On 4/21/2022 3:26 PM, Philipp Zabel wrote:
> On Do, 2022-04-21 at 10:32 +0530, Sajida Bhanu (Temp) wrote:
>> Hi,
>>
>> Thanks for the review.
>>
>> Please find the inline comments.
>>
>> Thanks,
>>
>> Sajida
>>
>> On 4/19/2022 12:52 PM, Philipp Zabel wrote:
>>> Hi Sajida,
>>>
>>> On Di, 2022-04-19 at 11:46 +0530, Sajida Bhanu (Temp) wrote:
>>> [...]
>>>>>> +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
>>>>>> +{
>>>>>> +	struct reset_control *reset;
>>>>>> +	int ret = 0;
>>>>> No need to initialize ret.
>>>>>
>>>>>> +
>>>>>> +	reset = reset_control_get_optional_exclusive(dev, NULL);
>>>>>> +	if (IS_ERR(reset))
>>>>>> +		return dev_err_probe(dev, PTR_ERR(reset),
>>>>>> +				"unable to acquire core_reset\n");
>>>>>> +
>>>>>> +	if (!reset)
>>>>>> +		return ret;
>>>> Here we are returning ret directly if reset is NULL , so ret
>>>> initialization is required.
>>> You are right. I would just "return 0;" here, but this is correct as
>>> is.
>> Ok
>>>>>> +
>>>>>> +	ret = reset_control_assert(reset);
>>>>>> +	if (ret)
>>>>>> +		return dev_err_probe(dev, ret, "core_reset assert failed\n");
>>>>> Missing reset_control_put(reset) in the error path.
>>>> Sure will add
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * The hardware requirement for delay between assert/deassert
>>>>>> +	 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
>>>>>> +	 * ~125us (4/32768). To be on the safe side add 200us delay.
>>>>>> +	 */
>>>>>> +	usleep_range(200, 210);
>>>>>> +
>>>>>> +	ret = reset_control_deassert(reset);
>>>>>> +	if (ret)
>>>>>> +		return dev_err_probe(dev, ret, "core_reset deassert failed\n");
>>>>> Same as above. Maybe make both ret = dev_err_probe() and goto ...
>>>> In both cases error message is different so I think goto not good idea here.
>>> You could goto after the error message. Either way is fine.
>> Sorry didn't get this ..can  you please help
> I meant you could either use goto after the error messages:
>
> +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
> +{
> [...]
> +	ret = reset_control_assert(reset);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "core_reset assert failed\n");
> +		goto out_reset_put;
> +	}
> [...]
> +	ret = reset_control_deassert(reset);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "core_reset deassert failed\n");
> +		goto out_reset_put;
> +	}
> +
> +	usleep_range(200, 210);
> +
> +out_reset_put:
> +	reset_control_put(reset);
> +
> +	return ret;
> +}
>
> Or not use goto and copy the reset_control_put() into each error path:
>
> +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
> +{
> [...]
> +	ret = reset_control_assert(reset);
> +	if (ret) {
> +		reset_control_put(reset);
> +		return dev_err_probe(dev, ret, "core_reset assert failed\n");
> +	}
> [...]
> +	ret = reset_control_deassert(reset);
> +	if (ret) {
> +		reset_control_put(reset);
> +		return dev_err_probe(dev, ret, "core_reset deassert failed\n");
> +	}
> +
> +	usleep_range(200, 210);
> +	reset_control_put(reset);
> +
> +	return 0;
> +}
>
> regards
> Philipp
Sure I will call reset_control_put() in each error path
