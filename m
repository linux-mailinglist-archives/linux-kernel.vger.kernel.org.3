Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C26157CEF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiGUPbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGUPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:31:11 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6906A78597;
        Thu, 21 Jul 2022 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658417468; x=1689953468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I1t5fOErKc+S9ryw9hWukhTz7LniY6w8G1tUsc1Dbs0=;
  b=h/963ZjryOp5SSKZgNNnITp/n6Sb7YddlyzeDJkj09nPvXvEUng4WXrN
   v8OehTRqez207erwLHmBvI7a3/f1PzJoD7PoyozX8wHxKXL5454OxjOmy
   D5+RvboS62xNk/+uV4lYJnSnSSrD/scUB+fTJDBL5zeQbPaE8przYD+0Y
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Jul 2022 08:31:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 08:31:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Jul 2022 08:31:07 -0700
Received: from [10.253.77.242] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Jul
 2022 08:31:02 -0700
Message-ID: <3f714c34-277d-ef71-b527-f758172160f9@quicinc.com>
Date:   Thu, 21 Jul 2022 23:30:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v12 0/9] Coresight: Add support for TPDM and TPDA
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20220710021032.27455-1-quic_jinlmao@quicinc.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20220710021032.27455-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Please help to review V12 patches.

Thanks

Jinlong Mao

On 7/10/2022 10:10 AM, Mao Jinlong wrote:
> This series adds support for the trace performance monitoring and
> diagnostics hardware (TPDM and TPDA). It is composed of two major
> elements.
> a) Changes for original coresight framework to support for TPDM and TPDA.
> b) Add driver code for TPDM and TPDA.
>
> Introduction of changes for original coresight framework
> Support TPDM as new coresight source.
> Since only STM and ETM are supported as coresight source originally.
> TPDM is a newly added coresight source. We need to change
> the original way of saving coresight path to support more types source
> for coresight driver.
> The following patch is to add support more coresight sources.
>      coresight: core: Use IDR for non-cpu bound sources' paths.
>
> Introduction of TPDM and TPDA
> TPDM - The trace performance monitoring and diagnostics monitor or TPDM in
> short serves as data collection component for various dataset types
> specified in the QPMDA(Qualcomm performance monitoring and diagnostics
> architecture) spec. The primary use case of the TPDM is to collect data
> from different data sources and send it to a TPDA for packetization,
> timestamping and funneling.
>       Coresight: Add coresight TPDM source driver
>       dt-bindings: arm: Adds CoreSight TPDM hardware definitions
>       coresight-tpdm: Add DSB dataset support
>       coresight-tpdm: Add integration test support
>       docs: sysfs: coresight: Add sysfs ABI documentation for TPDM
>
> TPDA - The trace performance monitoring and diagnostics aggregator or
> TPDA in short serves as an arbitration and packetization engine for the
> performance monitoring and diagnostics network as specified in the QPMDA
> (Qualcomm performance monitoring and diagnostics architecture)
> specification. The primary use case of the TPDA is to provide
> packetization, funneling and timestamping of Monitor data as specified
> in the QPMDA specification.
> The following patch is to add driver for TPDA.
>       Coresight: Add TPDA link driver
>       dt-bindings: arm: Adds CoreSight TPDA hardware definitions
>
> The last patch of this series is a device tree modification, which add
> the TPDM and TPDA configuration to device tree for validating.
>      ARM: dts: msm: Add coresight components for SM8250
>      ARM: dts: msm: Add tpdm mm/prng for sm8250
>
> Once this series patches are applied properly, the tpdm and tpda nodes
> should be observed at the coresight path /sys/bus/coresight/devices
> e.g.
> /sys/bus/coresight/devices # ls -l | grep tpd
> tpda0 -> ../../../devices/platform/soc@0/6004000.tpda/tpda0
> tpdm0 -> ../../../devices/platform/soc@0/6c08000.mm.tpdm/tpdm0
>
> We can use the commands are similar to the below to validate TPDMs.
> Enable coresight sink first.
>
> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
> echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
> echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
> The test data will be collected in the coresight sink which is enabled.
> If rwp register of the sink is keeping updating when do
> integration_test (by cat tmc_etf0/mgmt/rwp), it means there is data
> generated from TPDM to sink.
>
> There must be a tpda between tpdm and the sink. When there are some
> other trace event hw components in the same HW block with tpdm, tpdm
> and these hw components will connect to the coresight funnel. When
> there is only tpdm trace hw in the HW block, tpdm will connect to
> tpda directly.
>    
>      +---------------+                +-------------+
>      |  tpdm@6c08000 |                |tpdm@684C000 |
>      +-------|-------+                +------|------+
>              |                               |
>      +-------|-------+                       |
>      | funnel@6c0b000|                       |
>      +-------|-------+                       |
>              |                               |
>      +-------|-------+                       |
>      |funnel@6c2d000 |                       |
>      +-------|-------+                       |
>              |                               |
>              |    +---------------+          |
>              +----- tpda@6004000  -----------+
>                   +-------|-------+
>                           |
>                   +-------|-------+
>                   |funnel@6005000 |
>                   +---------------+
>
> This patch series depends on patch series:
> "[v2,00/13] coresight: Add new API to allocate trace source ID values"
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20220704081149.16797-1-mike.leach@linaro.org/
>
> Changes from V11:
> 1. Clear bits for atid before setting them and relese atid when tpda
> remove. -- Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Mao Jinlong (9):
>    coresight: core: Use IDR for non-cpu bound sources' paths.
>    Coresight: Add coresight TPDM source driver
>    dt-bindings: arm: Adds CoreSight TPDM hardware definitions
>    coresight-tpdm: Add DSB dataset support
>    coresight-tpdm: Add integration test support
>    Coresight: Add TPDA link driver
>    dt-bindings: arm: Adds CoreSight TPDA hardware definitions
>    arm64: dts: qcom: sm8250: Add coresight components
>    arm64: dts: qcom: sm8250: Add tpdm mm/prng
>
>   .../testing/sysfs-bus-coresight-devices-tpdm  |  13 +
>   .../bindings/arm/qcom,coresight-tpda.yaml     | 111 +++
>   .../bindings/arm/qcom,coresight-tpdm.yaml     |  93 +++
>   MAINTAINERS                                   |   2 +
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          | 671 ++++++++++++++++++
>   drivers/hwtracing/coresight/Kconfig           |  23 +
>   drivers/hwtracing/coresight/Makefile          |   2 +
>   drivers/hwtracing/coresight/coresight-core.c  |  42 +-
>   drivers/hwtracing/coresight/coresight-tpda.c  | 208 ++++++
>   drivers/hwtracing/coresight/coresight-tpda.h  |  35 +
>   drivers/hwtracing/coresight/coresight-tpdm.c  | 259 +++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h  |  62 ++
>   include/linux/coresight.h                     |   1 +
>   13 files changed, 1510 insertions(+), 12 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
>
