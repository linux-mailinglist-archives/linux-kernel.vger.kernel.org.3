Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE60C4B9BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiBQJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:17:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiBQJRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:17:17 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594B71954ED;
        Thu, 17 Feb 2022 01:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645089421; x=1676625421;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=oUrBOOhUtVa5tBC0AGFI7A9amW5osL3J4YgUSZTAuO0=;
  b=rJOiQeqRq8DdNPymW5K5LOiv4pe4GoHRTmq0qQxheMh60jE91bur9PHY
   MPYLn8l/R4BztVukimpGtILEx91U3BHlumhuxN/W9JBIHEoQjsFLWdghk
   LgoPJ/B0pZiOeauU5zC0Rn5LJIrv6fwrk2Lmb9UxuW+FGoPPICO37qOyA
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Feb 2022 01:17:00 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 01:17:00 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Feb 2022 01:16:59 -0800
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 17 Feb
 2022 01:16:41 -0800
Message-ID: <ab88b2b2-e44b-e783-3372-d23f56ce24e9@quicinc.com>
Date:   Thu, 17 Feb 2022 17:16:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 00/10] Coresight: Add support for TPDM and TPDA
Content-Language: en-US
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
To:     Mike Leach <mike.leach@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com>
 <CAJ9a7VhZtNrj9S4T=dNDOWT9fEcnm1qqtp+4h3EqytidDwEd5Q@mail.gmail.com>
 <0c87c995-142c-9c8f-5a9a-02e3a1119cce@quicinc.com>
In-Reply-To: <0c87c995-142c-9c8f-5a9a-02e3a1119cce@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/2022 12:17 PM, Jinlong Mao wrote:
>
> On 2/10/2022 6:30 PM, Mike Leach wrote:
>> Hello  Mao,
>>
>> I have looked through this set and have a few general questions.
>>
>> My understanding based on the information in the code is that the TPDM
>> devices will always send data to the TPDA device, the TPDM is not
>> capable of directly driving the ATB itself?
>> The TPDA device  will then packetize the inputs and output these to
>> the ATB over the normal CoreSight architecture to a standard ETR / ETF
>> for collection.
>>
>> Looking at the TPDM driver - it is assigned a trace ID but never
>> actually uses it in the hardware. My assumption here is that this is
>> used purely to satisfy the requirement that the CoreSight core has
>> that all sources have a unique trace id?
>>
>> For the TPDA driver you assign an ATID as an attribute in device tree,
>> and then program this into the devices control register.
>>
>> The trace IDs in ETM / ETE / STM, are programmed into the hardware and
>> these values drive the ATID value on the trace bus. So assigning an
>> ATID value to the TPDA driver through device tree will lead to clashes
>> with the assignment of trace IDs in the other driver software.
>>
>> The topology here appears to me that you have multiple  "data source"
>> devices TPDM, supplying a TPDA - which is the real CoreSight "trace
>> source" from the viewpoint of the trace bus and CoreSight
>> infrastructure.
>> To get this to work in the current CoreSight driver stack, you have
>> assigned the TPDM as a source type, and the TPDA as a link to ensure
>> that when a TPDM is started, all the components on the path to the
>> sink are activated.
>> This is fine.
>>
>> If my assumptions above are all accurate I suggest the following 
>> improvements
>>
>> For TPDA drop the device tree assignment of ATID and instead use the
>> coresight_get_system_trace_id() function you introduce in the 2nd
>> patch in this set.
>>
>> For TPDM you have assigned a unique source sub-type
>> CORESIGHT_DEV_SUBTYPE_SOURCE_SYS.- this could become
>> CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY. If the trace ID assigned to
>> this device is only to satisfy the unique ID requirement and is not
>> used elsewhere, then the sub type could become
>> CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY. We can agree that this sub
>> type does not need a unique ID and acts as none ATB a source for
>> another component, The core code can be altered to drop the
>> requirement for this sub-type and trace ID can be dropped for this
>> component.
>>
>> You should be aware that we are in the process of re-designed how
>> trace IDs are allocated. The current mechanism does not scale for
>> large multi-core systems (currently broken for any system > 46 cores),
>> and as you have discovered there is a need for additional allocation
>> of IDs. Also the ETE / TRBE combination does not need a trace ID.  A
>> dynamic allocation system is being proposed.
>>
>> Regards
>>
>> Mike
>
>
> Hi  Mike,
>
> Your assumptions above are all correct.
> TPDMs connect to the same TPDA will share the atid of the TPDA.
> We have a PC tool to parse the TPDM trace data. It needs the fixed 
> atid for each TPDA to identify the data.
> So we configure the atid for TPDA in device tree with fixed ids.
> I will discuss with internal tool team to see if TPDA's id can become 
> dynamic when parse the data.
>
> Apart from the TPDA's atid, we also have some other sources with fixed 
> id in HW on our internal device.
> Do you have any suggestion to how to allocate the IDs for the source 
> with fixed id in HW ?
>
> Thanks
> Jinlong Mao
>
Hi Mike & Mathieu & Suzuki,


Could you please help to review the other patches while we are 
discussing with internal tool team about the trace_id change ?


Thanks

Jinlong Mao


>
>>
>>
>> On Wed, 9 Feb 2022 at 10:57, Mao Jinlong <quic_jinlmao@quicinc.com> 
>> wrote:
>>> This series adds support for the trace performance monitoring and
>>> diagnostics hardware (TPDM and TPDA). It is composed of two major
>>> elements.
>>> a) Changes for original coresight framework to support for TPDM and 
>>> TPDA.
>>> b) Add driver code for TPDM and TPDA.
>>>
>>> Introduction of changes for original coresight framework
>>> Support TPDM as new coresight source.
>>> Since only STM and ETM are supported as coresight source originally.
>>> TPDM is a newly added coresight source. We need to change
>>> the original way of saving coresight path to support more types source
>>> for coresight driver.
>>> The following patch is to add support more coresight sources.
>>>      Use IDR to maintain all the enabled sources' paths.
>>>      coresight: Use bitmap to assign trace id to the sources
>>>
>>> Introduction of TPDM and TPDA
>>> TPDM - The trace performance monitoring and diagnostics monitor or 
>>> TPDM in
>>> short serves as data collection component for various dataset types
>>> specified in the QPMDA(Qualcomm performance monitoring and diagnostics
>>> architecture) spec. The primary use case of the TPDM is to collect data
>>> from different data sources and send it to a TPDA for packetization,
>>> timestamping and funneling.
>>>      Coresight: Add coresight TPDM source driver
>>>      dt-bindings: arm: Adds CoreSight TPDM hardware definitions
>>>      coresight-tpdm: Add DSB dataset support
>>>      coresight-tpdm: Add integration test support
>>>      docs: sysfs: coresight: Add sysfs ABI documentation for TPDM
>>>
>>> TPDA - The trace performance monitoring and diagnostics aggregator or
>>> TPDA in short serves as an arbitration and packetization engine for the
>>> performance monitoring and diagnostics network as specified in the 
>>> QPMDA
>>> (Qualcomm performance monitoring and diagnostics architecture)
>>> specification. The primary use case of the TPDA is to provide
>>> packetization, funneling and timestamping of Monitor data as specified
>>> in the QPMDA specification.
>>> The following patch is to add driver for TPDA.
>>>      Coresight: Add TPDA link driver
>>>      dt-bindings: arm: Adds CoreSight TPDA hardware definitions
>>>
>>> The last patch of this series is a device tree modification, which add
>>> the TPDM and TPDA configuration to device tree for validating.
>>>      ARM: dts: msm: Add coresight components for SM8250
>>>
>>> Once this series patches are applied properly, the tpdm and tpda nodes
>>> should be observed at the coresight path /sys/bus/coresight/devices
>>> e.g.
>>> /sys/bus/coresight/devices # ls -l | grep tpd
>>> tpda0 -> ../../../devices/platform/soc@0/6004000.tpda/tpda0
>>> tpdm0 -> ../../../devices/platform/soc@0/6c08000.mm.tpdm/tpdm0
>>>
>>> We can use the commands are similar to the below to validate TPDMs.
>>> Enable coresight sink first.
>>>
>>> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
>>> echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
>>> echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
>>> echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
>>> The test data will be collected in the coresight sink which is enabled.
>>> If rwp register of the sink is keeping updating when do
>>> integration_test (by cat tmc_etf0/mgmt/rwp), it means there is data
>>> generated from TPDM to sink.
>>>
>>> Changes from V2:
>>> 1. Use bitmap to assign the trace id. (Mathieu Poirier)
>>>
>>> Mao Jinlong (10):
>>>    Use IDR to maintain all the enabled sources' paths.
>>>    coresight: Use bitmap to assign trace id to the sources
>>>    Coresight: Add coresight TPDM source driver
>>>    dt-bindings: arm: Adds CoreSight TPDM hardware definitions
>>>    coresight-tpdm: Add DSB dataset support
>>>    coresight-tpdm: Add integration test support
>>>    docs: sysfs: coresight: Add sysfs ABI documentation for TPDM
>>>    Coresight: Add TPDA link driver
>>>    dt-bindings: arm: Adds CoreSight TPDA hardware definitions
>>>    ARM: dts: msm: Add coresight components for SM8250
>>>
>>>   .../testing/sysfs-bus-coresight-devices-tpdm  |   6 +
>>>   .../bindings/arm/coresight-tpda.yaml          | 129 ++++
>>>   .../bindings/arm/coresight-tpdm.yaml          |  81 ++
>>>   .../devicetree/bindings/arm/coresight.txt     |   7 +
>>>   MAINTAINERS                                   |   1 +
>>>   .../arm64/boot/dts/qcom/sm8250-coresight.dtsi | 690 
>>> ++++++++++++++++++
>>>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |   2 +
>>>   drivers/hwtracing/coresight/Kconfig           |  33 +
>>>   drivers/hwtracing/coresight/Makefile          |   2 +
>>>   drivers/hwtracing/coresight/coresight-core.c  | 127 ++--
>>>   drivers/hwtracing/coresight/coresight-tpda.c  | 193 +++++
>>>   drivers/hwtracing/coresight/coresight-tpda.h  |  32 +
>>>   drivers/hwtracing/coresight/coresight-tpdm.c  | 270 +++++++
>>>   drivers/hwtracing/coresight/coresight-tpdm.h  |  57 ++
>>>   include/linux/coresight-pmu.h                 |  11 +
>>>   include/linux/coresight.h                     |   1 +
>>>   16 files changed, 1592 insertions(+), 50 deletions(-)
>>>   create mode 100644 
>>> Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/arm/coresight-tpda.yaml
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>>>   create mode 100644 arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
>>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
>>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
>>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
>>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
>>>
>>> -- 
>>> 2.17.1
>>>
>>
>> -- 
>> Mike Leach
>> Principal Engineer, ARM Ltd.
>> Manchester Design Centre. UK
