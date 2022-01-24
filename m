Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58616498333
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbiAXPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:11:42 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:48123 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235253AbiAXPLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643037099; x=1674573099;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/YcoCW22K4Bj4d7gqCROWQEd7ONJm4N2eOylT8ZKqls=;
  b=NCMz68fEKoIs+pYgGx+7LX5UtQX2wv/3qBtQ3KR3G8wutN2pPs8RSq5x
   hP3AsCWw25fAx584oKFwi7U3nZ1NDEnAQnvGDWrDknjmWqrC8Zq8OalLI
   0VtdG1A3gI+QQAI0+wcDs1bM09rnZkCjYoEy9sITLov0NYcGewgBTr7vr
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jan 2022 07:11:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:11:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 24 Jan 2022 07:11:38 -0800
Received: from [10.50.44.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 24 Jan
 2022 07:11:31 -0800
Subject: Re: [PATCH v2 0/7] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
To:     Baruch Siach <baruch@tkos.co.il>,
        Kathiravan T <kathirav@codeaurora.org>
CC:     Sean Anderson <sean.anderson@seco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Balaji Prakash J" <bjagadee@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "Rob Herring" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <87ee53fv01.fsf@tarshish> <1965fc315525b8ab26cf9f71f939c24d@codeaurora.org>
 <871r12g0j2.fsf@tarshish>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Message-ID: <e1309c23-530b-c698-b7ba-4f1a5226fe8c@quicinc.com>
Date:   Mon, 24 Jan 2022 20:41:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <871r12g0j2.fsf@tarshish>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baruch,

On 1/20/2022 3:59 PM, Baruch Siach wrote:
> Hi Kathiravan,
>
> On Thu, Jan 20 2022, Kathiravan T wrote:
>> On 2022-01-19 23:44, Baruch Siach wrote:
>>> Hi Sean,
>>> On Tue, Jan 18 2022, Sean Anderson wrote:
>>>> This is a rework of patches 3-5 of [1]. It attempts to correctly program
>>>> REFCLKPER and REFCLK_FLADJ based on the reference clock frequency. Since
>>>> we no longer need a special property duplicating this configuration,
>>>> snps,ref-clock-period-ns is deprecated.
>>>> Please test this! Patches 3/4 in this series have the effect of
>>>> programming REFCLKPER and REFCLK_FLADJ on boards which already configure
>>>> the "ref" clock. I have build tested, but not much else.
>>> Tested here on IPQ6010 based system. USB still works. But the with
>>> "ref"
>>> clock at 24MHz, period is calculated as 0x29. Previous
>>> snps,ref-clock-period-ns value used to be 0x32.
>>> Is that expected?
>> Yes, it is 0x29 for IPQ60xx based SoCs. In downstream it was wrongly mentioned
>> as 0x32, which was corrected recently.
> Thanks for the update. This needs fixing in upstream kernel. I'll send a
> patch.
>
> For some reason USB appears to work here with both values. Is it because
> I only use USB2 signals? If this is the case them I can not actually
> test this series on my system.

I could recollect we did see some issue on USB2.0 port as well, but it 
wasn't fatal one. Anyways it is better to test it.

Thanks,

Kathiravan T.

>
> Thanks,
> baruch
>
>>>> [1]
>>>> https://lore.kernel.org/linux-usb/20220114044230.2677283-1-robert.hancock@calian.com/
>>>> Changes in v2:
>>>> - Document clock members
>>>> - Also program GFLADJ.240MHZDECR
>>>> - Don't program GFLADJ if the version is < 2.50a
>>>> - Add snps,ref-clock-frequency-hz property for ACPI
>>>> Sean Anderson (7):
>>>>    dt-bindings: usb: dwc3: Deprecate snps,ref-clock-period-ns
>>>>    usb: dwc3: Get clocks individually
>>>>    usb: dwc3: Calculate REFCLKPER based on reference clock
>>>>    usb: dwc3: Program GFLADJ
>>>>    usb: dwc3: Add snps,ref-clock-frequency-hz property for ACPI
>>>>    arm64: dts: zynqmp: Move USB clocks to dwc3 node
>>>>    arm64: dts: ipq6018: Use reference clock to set dwc3 period
>>>>   .../devicetree/bindings/usb/snps,dwc3.yaml    |   7 +-
>>>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi         |   3 +-
>>>>   .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |   4 +-
>>>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   4 +-
>>>>   drivers/usb/dwc3/core.c                       | 112 +++++++++++++++---
>>>>   drivers/usb/dwc3/core.h                       |  17 ++-
>>>>   6 files changed, 120 insertions(+), 27 deletions(-)
>
