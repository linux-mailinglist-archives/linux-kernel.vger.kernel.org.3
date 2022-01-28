Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30884A0416
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiA1XJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:09:35 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:10080 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243573AbiA1XJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643411374; x=1674947374;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/WErSQ5riLjTn9G82iWYYkqLnkTM7a6hv6C1CsU4/Wc=;
  b=U04MmxlRcwoYYqlGGmwnFCId4ynwzyuk1vC+YhBdrqnqMSPaG+1h6BzC
   oMKQpeQleFOIrNtflnGlZVKtfpViJR+KVSpB95LtCu9qmKph1c5xBvAiA
   sR/DjUQJC0o+9iaYIYwbxB5ZwdGg9OQpTlDEf+5z1nNZVAmFvHhqUOiTM
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jan 2022 15:09:33 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:09:33 -0800
Received: from [10.46.160.247] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 28 Jan
 2022 15:09:31 -0800
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
From:   David Collins <quic_collinsd@quicinc.com>
Message-ID: <8355035c-6d90-adfd-c4e1-7bb37a2d8055@quicinc.com>
Date:   Fri, 28 Jan 2022 15:09:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfREsxeSSX2pbALf@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 11:32 AM, Mark Brown wrote:
> On Mon, Jan 24, 2022 at 04:27:35PM -0800, David Collins wrote:
> 
>> Name based SCMI regulator specification helps ensure that an SCMI
>> agent doesn't need to be aware of the numbering scheme used for
> 
> What is a "SCMI agent" in this context?  This is changing how the DT
> bindings are specified, at some point things are going to need to be
> hard coded.

An SCMI agent is the entity that issues SCMI commands (i.e. the
consumer).  An SCMI platform is the entity that receives the SCMI
commands and performs the necessary operations (i.e. the provider).
This is the terminology used in the ARM SCMI spec [1].

A typical system layout could have an agent that is the application
processor (running Linux) and a platform that is an embedded controller.

The system layout that this patch is targeted for consists of an SCMI
platform implemented in software in the primary Linux OS on the
application processor and an SCMI agent in a guest VM (also running
Linux).  This provides paravirtualized regulator control to the guest VM
where full virtualization is not supported.

During the course of development of these software images, it may be
necessary to add or reorder the set of SCMI voltage domains (regulators)
implemented on the platform side.  If the voltage domains are only
identified and matched based on the ID number, then it is easy for the
platform and agent to get out of sync.

Using the voltage domain name instead of ID number for identification
and matching provides robust assurance of correct regulator usage in the
face of domains being added, removed, or reordered on the platform side.


>> +              regulator-name: true
>> +
>> +            anyOf:
>> +              - required:
>> +                  - reg
>> +              - required:
>> +                  - regulator-name
> 
> This is abusing the existing regulator-name property which is there to
> allow a human readable descriptive string to be attached to a regulator.
> It should have no effect other than being included in diagnostic output.

Would you be ok with a new DT property being added in place of
"regulator-name" in this patch which serves the same matching purpose
(perhaps "arm,scmi-domain-name")?

Thanks,
David

[1]: https://developer.arm.com/documentation/den0056/latest
