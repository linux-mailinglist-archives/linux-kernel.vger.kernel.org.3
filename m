Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ADC4A7C66
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348310AbiBCAJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:09:49 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:22850 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241194AbiBCAJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643846987; x=1675382987;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uTzf33I/3Zp/7jFnhbki7u7w8ZOQrs+HCUnkN+xtD3Y=;
  b=RdLaMr2olLiipx53YnsG2IPaU+aAzqRaUOe1CCy0mL7a8fFQazaNniOA
   uQ80GiPy6+V2mKLrtI3IWCnTC+S5OSb3MYs1jRTPmMBoST/2AD5Qk3gBX
   ESWY/wm2UTq/bowD4FTuEHj6qr0lfl+Wxmt63JMl/l5OM/qly9/vMew0W
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Feb 2022 16:09:47 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 16:09:46 -0800
Received: from [10.46.160.247] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 2 Feb 2022
 16:09:46 -0800
Subject: Re: [RESEND PATCH 1/2] dt-bindings: firmware: arm,scmi: define
 support for name based regulators
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "Cristian Marussi" <cristian.marussi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>
References: <cover.1643069954.git.quic_collinsd@quicinc.com>
 <fcd130891cc1d52cb09b8bfc866ab7ef1ce3b2a1.1643069954.git.quic_collinsd@quicinc.com>
 <YfREsxeSSX2pbALf@sirena.org.uk>
 <8355035c-6d90-adfd-c4e1-7bb37a2d8055@quicinc.com>
 <YfrBharI91QYkPR1@sirena.org.uk>
From:   David Collins <quic_collinsd@quicinc.com>
Message-ID: <532aa931-2471-8fb3-0db4-7ab8a60333e8@quicinc.com>
Date:   Wed, 2 Feb 2022 16:09:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfrBharI91QYkPR1@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 9:38 AM, Mark Brown wrote:
>> The system layout that this patch is targeted for consists of an SCMI
>> platform implemented in software in the primary Linux OS on the
>> application processor and an SCMI agent in a guest VM (also running
>> Linux).  This provides paravirtualized regulator control to the guest VM
>> where full virtualization is not supported.
> 
>> During the course of development of these software images, it may be
>> necessary to add or reorder the set of SCMI voltage domains (regulators)
>> implemented on the platform side.  If the voltage domains are only
>> identified and matched based on the ID number, then it is easy for the
>> platform and agent to get out of sync.
> 
>> Using the voltage domain name instead of ID number for identification
>> and matching provides robust assurance of correct regulator usage in the
>> face of domains being added, removed, or reordered on the platform side.
> 
> This seems like a scenario where the DT should be being generated at
> runtime along with the virtualisation of the platform?  TBH a setup
> where this is an issue feels like it's asking for trouble.

I'm not familiar with runtime device tree generation.  Could you please
point to an example of it or documentation for it?  How would this
handle kernel devices on the VM side which need a phandle to an
scmi-regulator DT subnode in order to get a pointer to the corresponding
regulator device at runtime via devm_regulator_get()?

>>>> +              regulator-name: true
> 
>>> This is abusing the existing regulator-name property which is there to
>>> allow a human readable descriptive string to be attached to a regulator.
>>> It should have no effect other than being included in diagnostic output.
> 
>> Would you be ok with a new DT property being added in place of
>> "regulator-name" in this patch which serves the same matching purpose
>> (perhaps "arm,scmi-domain-name")?
> 
> Yes, it needs to be a new property.

Ok, I'll modify the series in V2 to use a different property.

Thanks,
David
