Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A21475A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbhLON5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:57:14 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:11699 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237608AbhLON5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639576633; x=1671112633;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lW8SqESUer69FBFblprQugSwYclNXs7bvRX3fGDyr2I=;
  b=ijnL/bq6qOs+1wLjcZ+xUnH4q0pQBbiUGciu/gDEdqCg/J63lK40otDH
   cucuHpyJEn4CLY/z+96AS0/oXPj40WNcSSBzj8EokuyoqHGXIyEoTzsD6
   XTYjT7FiP5inX5Lz3HbCXv5ETePDEGNZYaedONgLNJIiFGNjNfxch6x5I
   0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Dec 2021 05:57:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:57:12 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 05:57:12 -0800
Received: from [10.50.9.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 15 Dec
 2021 05:57:07 -0800
Message-ID: <9012a424-ae61-e7e1-0aca-4558f847ff99@quicinc.com>
Date:   Wed, 15 Dec 2021 19:26:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V6 0/7] Add driver support for Data Capture and Compare
 Engine(DCC) for SM8150,SC7280,SC7180,SDM845
Content-Language: en-CA
To:     Alex Elder <elder@ieee.org>,
        Souradeep Chowdhury <schowdhu@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, <vkoul@kernel.org>
References: <cover.1628617260.git.schowdhu@codeaurora.org>
 <f283eb6c-fa39-c4bc-5da8-747ce20317da@ieee.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <f283eb6c-fa39-c4bc-5da8-747ce20317da@ieee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/2021 4:05 AM, Alex Elder wrote:
> On 8/10/21 12:54 PM, Souradeep Chowdhury wrote:
>> DCC(Data Capture and Compare) is a DMA engine designed for debugging 
>> purposes.In case of a system
>> crash or manual software triggers by the user the DCC hardware stores 
>> the value at the register
>> addresses which can be used for debugging purposes.The DCC driver 
>> provides the user with sysfs
>> interface to configure the register addresses.The options that the 
>> DCC hardware provides include
>> reading from registers,writing to registers,first reading and then 
>> writing to registers and looping
>> through the values of the same register.
>
> I realize this was posted a long time ago but I spent a little
> time on it today, and I have some comments for you to consider.
> You'll need to post another version of this series if you're
> going to address some of my comments.
>
> Most of the comments are in patch 2, which contains all the code
> and the sysfs documentation.  I have no comments on patches 3
> (MAINTAINERS update) or 4 through 7 (DTS updates for specific
> platforms).
>
> First, a few comments on this cover page.  The most trivial
> comment is:  Please make your lines narrower than 80 columns,
> like the rest of the patches.
>
> I appreciate that this goes into some detail about how this
> feature has been used.  But I think it could benefit from
> a little better high-level overview of what it *does*.
> Your first paragraph is a concise summary, but I find it
> doesn't evoke a model in my mind of what exactly is going
> on, or what the hardware is doing.  In fact, if you can
> provide a good high-level overview it might belong at the
> top of "dcc.c" in comments.
>
> Looking at the code (but not in any great depth), I see
> that there are "linked lists" of what appear to be things
> for the hardware to do with memory when this hardware is
> "triggered."  If I understand it right, there can be up
> to 8 of these lists (though some versions of hardware
> might advertise the number supported via a register).
>
> If the following is wrong, I hope you'll offer a comparable
> explanation and will correct my misunderstanding.
>
> Each list consists of a set of actions to take.  The actions
> available include: reading a register (possibly <count> times
> in succession); writing a register; and read/modify/writing
> a register (affecting only bits in a given mask).  Actually,
> the way looping works is a little confusing to me.
>
> Each list can be enabled and disabled separately.  When
> triggered, all lists are executed, and (somehow) the result
> is saved into a buffer that can be read via /dev/dcc_sram.
>
> So you use these sysfs files to configure the actions you'd
> like to take when a "trigger" is signaled.  The content of
> /dev/dcc_sram can then be read to see what output your
> lists produced.
>
> Is that close to correct?  If it is, great; I want to be
> sure I understand what the hardware is supposed to do
> before I comment much more on the way you represent it
> in the driver and in sysfs.
>
>> In certain cases a register write needs to be executed for accessing 
>> the rest of the registers,
>> also the user might want to record the changing values of a register 
>> with time for which he has the
>> option to use the loop feature.
>>
>> The options mentioned above are exposed to the user by sysfs files 
>> once the driver is probed.The
>> details and usage of this sysfs files are documented in 
>> Documentation/ABI/testing/sysfs-driver-dcc.
>
> Once you've confirmed I understand what's supposed to happen
> when the trigger fires, I think I'll have some comments on
> the way you represent the actions in these lists.  But
> for now, maybe keep things as you have them, but address
> some of the comments I'm giving you today.  Copy me on
> future revisions and I'll plan to review again.
>
> OK, that's enough on this file for now.  Onto the binding and
> the code...
>
>                     -Alex
>
Hi Alex.

Thanks for your feedback. The understanding is correct regarding DCC 
hardware.

Will address all the comments and post the next version copying you.

Thanks,

Souradeep

>> As an example let us consider a couple of debug scenarios where DCC 
>> has been proved to be effective
>> for debugging purposes:-
>>
>> i)TimeStamp Related Issue
>>
>> On SC7180, there was a coresight timestamp issue where it would 
>> occasionally be all 0 instead of proper
>> timestamp values.
>>
>> Proper timestamp:
>> Idx:3373; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 
>> 0x13004d8f5b7aa; CC=0x9e
>>
>> Zero timestamp:
>> Idx:3387; ID:10; I_TIMESTAMP : Timestamp.; Updated val = 0x0; CC=0xa2
>>
>> Now this is a non-fatal issue and doesn't need a system reset, but 
>> still needs
>> to be rootcaused and fixed for those who do care about coresight etm 
>> traces.
>> Since this is a timestamp issue, we would be looking for any 
>> timestamp related
>> clocks and such.
>>
>> o we get all the clk register details from IP documentation and 
>> configure it
>> via DCC config syfs node. Before that we set the current linked list.
>>
>> /* Set the current linked list */
>> echo 3 > /sys/bus/platform/devices/10a2000.dcc/curr_list
>>
>> /* Program the linked list with the addresses */
>> echo 0x10c004 > /sys/bus/platform/devices/10a2000.dcc/config
>> echo 0x10c008 > /sys/bus/platform/devices/10a2000.dcc/config
>> echo 0x10c00c > /sys/bus/platform/devices/10a2000.dcc/config
>> echo 0x10c010 > /sys/bus/platform/devices/10a2000.dcc/config
>> ..... and so on for other timestamp related clk registers
>>
>> /* Other way of specifying is in "addr len" pair, in below case it
>> specifies to capture 4 words starting 0x10C004 */
>>
>> echo 0x10C004 4 > /sys/bus/platform/devices/10a2000.dcc/config
>>
>> /* Enable DCC */
>> echo 1 > /sys/bus/platform/devices/10a2000.dcc/enable
>>
>> /* Run the timestamp test for working case */
>>
>> /* Send SW trigger */
>> echo 1 > /sys/bus/platform/devices/10a2000.dcc/trigger
>>
>> /* Read SRAM */
>> cat /dev/dcc_sram > dcc_sram1.bin
>>
>> /* Run the timestamp test for non-working case */
>>
>> /* Send SW trigger */
>> echo 1 > /sys/bus/platform/devices/10a2000.dcc/trigger
>>
>> /* Read SRAM */
>> cat /dev/dcc_sram > dcc_sram2.bin
>>
>> Get the parser from [1] and checkout the latest branch.
>>
>> /* Parse the SRAM bin */
>> python dcc_parser.py -s dcc_sram1.bin --v2 -o output/
>> python dcc_parser.py -s dcc_sram2.bin --v2 -o output/
>>
>> Sample parsed output of dcc_sram1.bin:
>>
>> <hwioDump version="1">
>>          <timestamp>03/14/21</timestamp>
>>              <generator>Linux DCC Parser</generator>
>>                  <chip name="None" version="None">
>>                  <register address="0x0010c004" value="0x80000000" />
>>                  <register address="0x0010c008" value="0x00000008" />
>>                  <register address="0x0010c00c" value="0x80004220" />
>>                  <register address="0x0010c010" value="0x80000000" />
>>              </chip>
>>      <next_ll_offset>next_ll_offset : 0x1c </next_ll_offset>
>> </hwioDump>
>>
>> ii)NOC register errors
>>
>> A particular class of registers called NOC which are functional 
>> registers was reporting
>> errors while logging the values.To trace these errors the DCC has 
>> been used effectively.
>> The steps followed were similar to the ones mentioned above.
>> In addition to NOC registers a few other dependent registers were 
>> configured in DCC to
>> monitor it's values during a crash. A look at the dependent register 
>> values revealed that
>> the crash was happening due to a secured access to one of these 
>> dependent registers.
>> All these debugging activity and finding the root cause was achieved 
>> using DCC.
>>
>> DCC parser is available at the following open source location
>>
>> https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/tools/tree/dcc_parser 
>>
>>
>> Changes in v6:
>>
>> *Added support in the dcc driver to handle multiple Qualcomm SoCs 
>> including SC7180,SC7280,SDM845
>>   along with existing SM8150.
>>   *Added the support node in the respective device tree files for 
>> SC7180,SC7280,SDM845.
>>
>> Souradeep Chowdhury (7):
>>    dt-bindings: Added the yaml bindings for DCC
>>    soc: qcom: dcc:Add driver support for Data Capture and Compare
>>      unit(DCC)
>>    MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
>>      support
>>    arm64: dts: qcom: sm8150: Add Data Capture and Compare(DCC) support
>>      node
>>    arm64: dts: qcom: sc7280: Add Data Capture and Compare(DCC) support
>>      node
>>    arm64: dts: qcom: sc7180: Add Data Capture and Compare(DCC) support
>>      node
>>    arm64: dts: qcom: sdm845: Add Data Capture and Compare(DCC) support
>>      node
>>
>>   Documentation/ABI/testing/sysfs-driver-dcc         |  114 ++
>>   .../devicetree/bindings/arm/msm/qcom,dcc.yaml      |   43 +
>>   MAINTAINERS                                        |    8 +
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi               |    6 +
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi               |    6 +
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi               |    6 +
>>   arch/arm64/boot/dts/qcom/sm8150.dtsi               |    6 +
>>   drivers/soc/qcom/Kconfig                           |    8 +
>>   drivers/soc/qcom/Makefile                          |    1 +
>>   drivers/soc/qcom/dcc.c                             | 1549 
>> ++++++++++++++++++++
>>   10 files changed, 1747 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-dcc
>>   create mode 100644 
>> Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
>>   create mode 100644 drivers/soc/qcom/dcc.c
>>
>
