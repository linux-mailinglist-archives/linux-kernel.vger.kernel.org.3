Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB8D509635
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347772AbiDUFGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiDUFGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:06:32 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A6DE08F;
        Wed, 20 Apr 2022 22:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650517424; x=1682053424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eU7QDjI4vyI81/XW/z3kwNXUIF5FPDflWs0YKsUKWWk=;
  b=VeId9NL4Hs68D7a2KqGLLh9LhkiOJx+XLJz+GEOiC7CfTfdkt7PXSVOr
   zHyKtP5hl8k+ZcuCoidG3W+FDCLLuGztuVI6lWOWCjbNTLY6aZNt97tnn
   KDDaDPgYMbuNAyyxsVqDfXRmRfAX53ruFxzPl4t4oVs+vofV/qIXq0kAu
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 20 Apr 2022 22:03:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 22:03:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Apr 2022 22:03:08 -0700
Received: from [10.216.45.250] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Apr
 2022 22:03:03 -0700
Message-ID: <fb6480f6-f004-c02d-09fe-92a64785a0c5@quicinc.com>
Date:   Thu, 21 Apr 2022 10:32:57 +0530
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
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <dc2252f03db5881dbb17006c910dfca54c7d2fee.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

On 4/19/2022 12:52 PM, Philipp Zabel wrote:
> Hi Sajida,
>
> On Di, 2022-04-19 at 11:46 +0530, Sajida Bhanu (Temp) wrote:
> [...]
>>>> +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
>>>> +{
>>>> +	struct reset_control *reset;
>>>> +	int ret = 0;
>>> No need to initialize ret.
>>>
>>>> +
>>>> +	reset = reset_control_get_optional_exclusive(dev, NULL);
>>>> +	if (IS_ERR(reset))
>>>> +		return dev_err_probe(dev, PTR_ERR(reset),
>>>> +				"unable to acquire core_reset\n");
>>>> +
>>>> +	if (!reset)
>>>> +		return ret;
>> Here we are returning ret directly if reset is NULL , so ret
>> initialization is required.
> You are right. I would just "return 0;" here, but this is correct as
> is.
Ok
>>>> +
>>>> +	ret = reset_control_assert(reset);
>>>> +	if (ret)
>>>> +		return dev_err_probe(dev, ret, "core_reset assert failed\n");
>>> Missing reset_control_put(reset) in the error path.
>> Sure will add
>>>> +
>>>> +	/*
>>>> +	 * The hardware requirement for delay between assert/deassert
>>>> +	 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
>>>> +	 * ~125us (4/32768). To be on the safe side add 200us delay.
>>>> +	 */
>>>> +	usleep_range(200, 210);
>>>> +
>>>> +	ret = reset_control_deassert(reset);
>>>> +	if (ret)
>>>> +		return dev_err_probe(dev, ret, "core_reset deassert failed\n");
>>> Same as above. Maybe make both ret = dev_err_probe() and goto ...
>> In both cases error message is different so I think goto not good idea here.
> You could goto after the error message. Either way is fine.

Sorry didn't get this ..can  you please help

>
> regards
> Philipp
