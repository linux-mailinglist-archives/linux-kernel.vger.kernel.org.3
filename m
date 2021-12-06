Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF4546975D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244700AbhLFNqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:46:42 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:29050 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244675AbhLFNqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638798192; x=1670334192;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0QW7DwiKKjDcGAgR40YyUnQsj2KHuLU2QR5LeUUkwYM=;
  b=lcDedLAh0agWaogOUlR/qEtp8a+rJ9jKWNImciFHqmK4HU3Y45TYpTYr
   5BKZ4jHGVM99i0Xw2UKZ1xvJATI6eOe7fmXX36ss0U8WQDUjmWyiHGXEq
   DUnjyK1lCdXlqxmag/szb1JEBxlVQX8Y/dTIl0Dud8sqWpwKUuE6q0viP
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 06 Dec 2021 05:43:12 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:43:11 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 05:43:11 -0800
Received: from [10.216.22.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 05:43:06 -0800
Subject: Re: [PATCH V4 2/6] dt-bindings: regulator: Add pm8008 regulator
 bindings
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
 <1637314953-4215-3-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+qn2hA4MzNEqM+@sirena.org.uk>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <30b21a08-f7f7-f3a6-a3ac-156c7f8964b1@quicinc.com>
Date:   Mon, 6 Dec 2021 19:13:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZ+qn2hA4MzNEqM+@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/25/2021 8:54 PM, Mark Brown wrote:
> On Fri, Nov 19, 2021 at 03:12:29PM +0530, Satya Priya wrote:
>
>> +properties:
>> +  compatible:
>> +    const: qcom,pm8008-regulators
> Why are we adding a separate compatible for this when we already know
> that this is a pm8008 based on the parent?


For the regulator driver to be probed we do need a separate compatible 
right? may be I didn't get your question..

My understanding is we should have a separate compatible for each 
peripheral under the parent mfd node.. like gpios, temp alarm, 
regulators etc..


>> +  vdd_l1_l2-supply:
>> +    description: Input supply phandle of ldo1 and ldo2 regulators.
> These supply nodes should be chip level, they're going into the chip and
> in general the expectation is that you should be able to describe the
> supplies going into a device without worrying about how or if any
> particular OS splits things up.

So, if i understand correctly, we don't have to mention these in the 
documentation as these are handled at framework level?

