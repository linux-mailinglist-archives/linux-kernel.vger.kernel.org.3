Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0068A47A7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhLTKoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:44:39 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:55553 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229612AbhLTKoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639997079; x=1671533079;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=suS+USQJ2UKVv+N/mQuXbtw7rGVSpAvqHTYphU4MZbc=;
  b=RKDc3H33WKcYouWpDTyUraXTrJtvygVZ4zXa+TEZXODsU3VSCeyB/AbM
   8cFcPnKs+PttJdv3hG+PWR/qOwma5Lb94ZrrfD+Km36rvtVsVshOMGK6t
   +i5oXRXM4qTBxbOFvDq4QBYaiAtUUDfAlv9kXXBPjHoQCCgavGFhTK/Wx
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Dec 2021 02:44:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 02:44:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 02:44:37 -0800
Received: from [10.216.48.77] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 20 Dec
 2021 02:44:33 -0800
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
 <d86e1a33-e7cf-58f7-d75b-23a0313ebde5@quicinc.com>
 <Ya4nn0/qp5El8P0L@sirena.org.uk>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <ec9eddf5-aba2-d63b-0e39-1a3d5bda3ce9@quicinc.com>
Date:   Mon, 20 Dec 2021 16:14:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya4nn0/qp5El8P0L@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/2021 8:39 PM, Mark Brown wrote:
> On Mon, Dec 06, 2021 at 08:13:57PM +0530, Satya Priya Kakitapalli (Temp) wrote:
>> On 11/25/2021 9:15 PM, Mark Brown wrote:
>>> On Fri, Nov 19, 2021 at 03:12:31PM +0530, Satya Priya wrote:
>>>> +		child_node = of_get_child_by_name(parent_node, reg->name);
>>>> +		if (!child_node) {
>>>> +			dev_err(dev, "child node %s not found\n", reg->name);
>>>> +			return -ENODEV;
>>>> +		}
>>> This could be pulled out of the array.
>> Not sure what you meant here. could you elaborate a bit?
> Why is this in every iteration of the loop?


Getting the child node here is not required anymore. This got carried 
from previous versions, I'll remove this.

