Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E7473CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhLNFu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:50:26 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:24086 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhLNFuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639461025; x=1670997025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jmsxtLcVGJrU2P7eH+4CDEuducZWSqhxMyBLil7wn5I=;
  b=cYEnej/ps8NeE0JShDwUWPIapjz6802SYwVinLtX1cg/qBMJARdXhTs1
   C0n/97DbhW0fAuPE8vwGSM4f06cLqhggDcJZfqiFtGVHShGf0aNbu1mKT
   dqYY3+zvbUrz4tEoSPzTrtkZYEb0oXW00m8qQzqa9/2WIEym+3TRo+PTC
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Dec 2021 21:50:25 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 21:50:24 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 13 Dec 2021 21:50:15 -0800
Received: from [10.231.205.174] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 13 Dec
 2021 21:50:12 -0800
Message-ID: <3b320028-33a7-4d3a-c671-8db80d061e47@quicinc.com>
Date:   Tue, 14 Dec 2021 13:50:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RESEND PATCH v3 10/10] dt-bindings: convert qcom,spmi-pmic-arb
 binding to YAML format
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        <collinsd@codeaurora.org>, Andy Gross <agross@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <subbaram@codeaurora.org>, <tglx@linutronix.de>, <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1638403212-29265-1-git-send-email-quic_fenglinw@quicinc.com>
 <1638403212-29265-11-git-send-email-quic_fenglinw@quicinc.com>
 <1638453489.532760.3736891.nullmailer@robh.at.kernel.org>
 <20211210020549.BFA4DC004DD@smtp.kernel.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <20211210020549.BFA4DC004DD@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for late response. I had a check in the log and tried "make 
dtbs_check" at my side.
There are 5 types of warnings, I guess I can fix two types of them.

1) : qcom,spmi@400f000: 'pmic@0', 'pmic@1', 'pmic@2', 'pmic@3' do not 
match any of the regexes: 'pinctrl-[0-9]+'

This indicates the child nodes devices are not recognized, this can be 
fixed by adding pattern
properties similar to what defines in spmi.yaml. I will address it in 
next patchset.

2) qcom,spmi@400f000: reg-names: 'oneOf' conditional failed, one must be 
fixed:

This is because of the "items" defined in "reg-name" does not match 
between the dtsi nodes
and the schema in sequence wise. I will update the scheme for "reg-name" 
like this to fix it in
next patchset:
   reg-names:
     anyOf:
       - minItems: 3
       - maxItems: 3
       - enum: ["core", "intr", "cnfg"]

       - minItems: 5
       - maxItems: 5
       - enum: ["core", "intr", "cnfg", "chnls", "obsrvr"]

3) qcom,spmi@400f000: $nodename:0: 'qcom,spmi@400f000' does not match 
'^spmi@.*'

This indicates the mismatch of the device node name between the dtsi and 
schema, I guess
the fix should be in dtsi file instead of this binding, the spmi.yaml 
file has defined
the nodename with "spmi@" prefix, qcom,spmi-pmic-arb.yaml should follow 
this.
Should I make the change and update all the nodes names in dtsi file 
like this? Or can this
be ignored and leave it to dtsi file owners to update them accordingly?

4) spmi@c440000: #address-cells:0:0: 2 was expected
   spmi@c440000: #size-cells:0:0: 0 was expected

Some of the spmi device nodes specify #address-cell = < 1>, and 
#size-cell = <1>, the original
.txt binding specified #address-cell = < 2>, and #size-cell = <0>. The 
change should be in dtsi
to update them following the binding. Let me know if I should do this, 
or I can leave itto the
dtsi file owners to update them accordingly.

5) spmi@1c40000: 'cell-index' does not match any of the regexes: 
'pinctrl-[0-9]+'

"cell-index" is not used in the driver, also it doesn't exist in the 
.txt binding, so this should
be fixedin the corresponding dtsi file. Let me know if I need to fix it.

Thanks


On 2021/12/10 10:05, Stephen Boyd wrote:
> Quoting Rob Herring (2021-12-02 05:58:09)
>> On Thu, 02 Dec 2021 08:00:12 +0800, Fenglin Wu wrote:
>>> Convert the SPMI PMIC arbiter documentation to JSON/yaml. While at it,
>>> update SPMI bus "reg" items constraint for SPMI PMIC arbiter to carry
>>> it and update it with a smaller range.
>>>
>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>> ---
>>>   .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  67 -----------
>>>   .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 128 +++++++++++++++++++++
>>>   Documentation/devicetree/bindings/spmi/spmi.yaml   |   3 +-
>>>   3 files changed, 130 insertions(+), 68 deletions(-)
>>>   delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>>>   create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
>>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings.
>>
>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>> This will change in the future.
>>
>> Full log is available here: https://patchwork.ozlabs.org/patch/1562483
> Are any of these problems going to be fixed?
