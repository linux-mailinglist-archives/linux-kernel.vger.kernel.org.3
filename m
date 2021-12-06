Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC5469956
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344440AbhLFOrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:47:51 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:55410 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344389AbhLFOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638801848; x=1670337848;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uBJ2zkiFvu00Yi/5NH9N/e6yzlPbxov/hI2FT8VWLBE=;
  b=i8/jtPW9anoFfo4IVlttAlyKwHO8VeTSwMV6RCAITvWN9tQiPKRUokVJ
   FMJ4X2wDb/zvs/u6waPk9gJpwHAA9SNUHA8I+F5gt9BjPgGrw3hUqujFb
   /rb0UfinuZlVI7e5MarUDwOc29Bs3VEGdPpA9S99it41D5uk3kkner4xD
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Dec 2021 06:44:07 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 06:44:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 06:44:07 -0800
Received: from [10.216.22.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 06:44:02 -0800
Subject: Re: [PATCH V4 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
To:     Mark Brown <broonie@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, <swboyd@chromium.org>,
        <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-5-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+vnV12gDCtia5S@sirena.org.uk>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <d86e1a33-e7cf-58f7-d75b-23a0313ebde5@quicinc.com>
Date:   Mon, 6 Dec 2021 20:13:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZ+vnV12gDCtia5S@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/25/2021 9:15 PM, Mark Brown wrote:
> On Fri, Nov 19, 2021 at 03:12:31PM +0530, Satya Priya wrote:
>
>> +	for (reg = &reg_data[0]; reg->name; reg++) {
> Why is this not just iterating from 0 to ARRAY_SIZE() - that's the more
> normal way to write things and doesn't require a terminator on the
> array.


While changing some other things in the probe I made this change, but I 
think this is not necessary, I'll change it to iterate from 0 to 
ARRAY_SIZE()


>> +		child_node = of_get_child_by_name(parent_node, reg->name);
>> +		if (!child_node) {
>> +			dev_err(dev, "child node %s not found\n", reg->name);
>> +			return -ENODEV;
>> +		}
> This could be pulled out of the array.

Not sure what you meant here. could you elaborate a bit?


>    I think you're also missing an
> of_node_put() on the child_node.


I'll add it in the next version.


>> +		rc = of_property_read_u32(child_node, "reg", &base);
>> +		if (rc < 0) {
>> +			dev_err(dev, "%s: failed to get regulator base rc=%d\n",
>> +						reg->name, rc);
>> +			return rc;
>> +		}
> It's not clear to me why this in particular is being read out of the DT
> binding, I'd expect this to be in the array describing the regulator the
> same as everything else?

I thought that the base address would change with boards, but seems it 
doesn't change. I'll add this in the array.


