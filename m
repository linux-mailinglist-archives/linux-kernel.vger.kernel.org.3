Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CC546BEA0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhLGPJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:09:54 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:32970 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233762AbhLGPJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638889583; x=1670425583;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fU//TcKKhH46diZheIx8cFcX5pnBOhrdWPeL3XWH9KA=;
  b=w/EMEwB0VWuvH/3jttBEDNWtSrMLFvGoIDbW4JQrCFtCu5PVqqXPeXhQ
   Mia/EE0xnCG+Tzpjbwy8Jp7w/p7OnzJ7EnSs1ZRH8Pyum6hBv3JzWY1PO
   xG5RySNouPt7WJS2N+gzQ22CwN29tdyUdW4q8EgH2Yq6VJjITxGkxBhls
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Dec 2021 07:06:22 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:06:21 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 07:06:21 -0800
Received: from [10.216.26.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 7 Dec 2021
 07:06:16 -0800
Subject: Re: [PATCH V4 1/6] dt-bindings: regulator: Add
 "regulator-min-dropout-voltage-microvolt"
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
 <1637314953-4215-2-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+o9sQpECZSrieN@sirena.org.uk>
 <d828f2a1-03e8-d6ee-4ab7-39bf677093b7@quicinc.com>
 <Ya5VhkggWdjYyTHL@sirena.org.uk>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <6a44cb99-6894-c9ce-4f1e-5dee0939598c@quicinc.com>
Date:   Tue, 7 Dec 2021 20:36:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya5VhkggWdjYyTHL@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/2021 11:55 PM, Mark Brown wrote:
> On Mon, Dec 06, 2021 at 06:33:26PM +0530, Satya Priya Kakitapalli (Temp) wrote:
>> On 11/25/2021 8:47 PM, Mark Brown wrote:
>>> Usually this is a fixed property of the regulator rather than something
>>> that varies per board - why have a DT property?
>> The min-dropout value (headroom) varies with boards, that's why we have a DT
>> property for it. We overwrite the default value in driver with actual value
>> read from DT
> Interesting.  How exactly does that end up happening - presumably other
> systems are going to run into it?


The parent supplies such as "vdd-l1-l2" are coming from other pmic 
regulators, which are shared supplies with other subsystems like BT, 
Display etc, they vary between boards as per requirements, so we cannot 
expect these to be fixed and so are the headroom values. We get the 
headroom values from PMIC systems team for every target.


> If you do have board designs which somehow managed to introduce
> additional dropouts (seems pretty concerning TBH) then I think the best
> way to handle that is to add a generic property for it and have that
> either added on to or override the requirements of the regulator itself
> which should continue to be defined in the driver.  That way only boards
> with issues need to do anything which will avoid bugs with the property
> being omitted in what should be the common case.
