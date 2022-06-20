Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71D75517F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbiFTMB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbiFTMBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:01:23 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5B2185;
        Mon, 20 Jun 2022 05:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655726481; x=1687262481;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=BI/ZAQkuSlLJM+0pmcV8R+KGku3iTiz769690tM0euI=;
  b=d25V9Cz7W67eWW7vWu1Yb/zLuKpJAvZdOzS4X60CNZ/C0lqU5uxxlDTw
   rSruFOFjb5uyZ00nvzZeKSEq8rA4C306ou802NryYojeWRy2qPDkDgGQY
   9ylaeWC5e4/4SD8u6NkIMId2Homs7yGJBHm/wXKDtn8TcZPJ8FuOrFW2Z
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jun 2022 05:01:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 05:01:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 05:01:20 -0700
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 05:01:15 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Hao Zhang" <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v11 0/9] Coresight: Add support for TPDM and TPDA 
Date:   Mon, 20 Jun 2022 20:00:52 +0800
Message-ID: <20220620120101.2906-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the trace performance monitoring and
diagnostics hardware (TPDM and TPDA). It is composed of two major
elements.
a) Changes for original coresight framework to support for TPDM and TPDA.
b) Add driver code for TPDM and TPDA.

Introduction of changes for original coresight framework
Support TPDM as new coresight source.
Since only STM and ETM are supported as coresight source originally.
TPDM is a newly added coresight source. We need to change
the original way of saving coresight path to support more types source
for coresight driver.
The following patch is to add support more coresight sources.
    coresight: core: Use IDR for non-cpu bound sources' paths.

Introduction of TPDM and TPDA
TPDM - The trace performance monitoring and diagnostics monitor or TPDM in
short serves as data collection component for various dataset types
specified in the QPMDA(Qualcomm performance monitoring and diagnostics
architecture) spec. The primary use case of the TPDM is to collect data
from different data sources and send it to a TPDA for packetization,
timestamping and funneling.
     Coresight: Add coresight TPDM source driver
     dt-bindings: arm: Adds CoreSight TPDM hardware definitions
     coresight-tpdm: Add DSB dataset support
     coresight-tpdm: Add integration test support
     docs: sysfs: coresight: Add sysfs ABI documentation for TPDM

TPDA - The trace performance monitoring and diagnostics aggregator or
TPDA in short serves as an arbitration and packetization engine for the
performance monitoring and diagnostics network as specified in the QPMDA
(Qualcomm performance monitoring and diagnostics architecture)
specification. The primary use case of the TPDA is to provide
packetization, funneling and timestamping of Monitor data as specified
in the QPMDA specification.
The following patch is to add driver for TPDA.
     Coresight: Add TPDA link driver
     dt-bindings: arm: Adds CoreSight TPDA hardware definitions

The last patch of this series is a device tree modification, which add
the TPDM and TPDA configuration to device tree for validating.
    ARM: dts: msm: Add coresight components for SM8250
    ARM: dts: msm: Add tpdm mm/prng for sm8250

Once this series patches are applied properly, the tpdm and tpda nodes
should be observed at the coresight path /sys/bus/coresight/devices
e.g.
/sys/bus/coresight/devices # ls -l | grep tpd
tpda0 -> ../../../devices/platform/soc@0/6004000.tpda/tpda0
tpdm0 -> ../../../devices/platform/soc@0/6c08000.mm.tpdm/tpdm0

We can use the commands are similar to the below to validate TPDMs.
Enable coresight sink first.

echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
The test data will be collected in the coresight sink which is enabled.
If rwp register of the sink is keeping updating when do
integration_test (by cat tmc_etf0/mgmt/rwp), it means there is data
generated from TPDM to sink.

There must be a tpda between tpdm and the sink. When there are some
other trace event hw components in the same HW block with tpdm, tpdm
and these hw components will connect to the coresight funnel. When
there is only tpdm trace hw in the HW block, tpdm will connect to
tpda directly.
  
    +---------------+                +-------------+
    |  tpdm@6c08000 |                |tpdm@684C000 |
    +-------|-------+                +------|------+
            |                               |
    +-------|-------+                       |
    | funnel@6c0b000|                       |
    +-------|-------+                       |
            |                               |
    +-------|-------+                       |
    |funnel@6c2d000 |                       |
    +-------|-------+                       |
            |                               |
            |    +---------------+          |
            +----- tpda@6004000  -----------+
                 +-------|-------+
                         |
                 +-------|-------+
                 |funnel@6005000 |
                 +---------------+

This patch series depends on patch series
"coresight: Add new API to allocate trace source ID values".
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20220308205000.27646-1-mike.leach@linaro.org/ 

Changes from V10:
1. Change dev_info to dev_dbg in TPDM/TPDA drivers. -- Suzuki K Poulose <suzuki.poulose@arm.com>
2. Merge sysfs API change of integration_test to integration_test driver
change. -- -- Suzuki K Poulose <suzuki.poulose@arm.com>

Mao Jinlong (9):
  coresight: core: Use IDR for non-cpu bound sources' paths.
  Coresight: Add coresight TPDM source driver
  dt-bindings: arm: Adds CoreSight TPDM hardware definitions
  coresight-tpdm: Add DSB dataset support
  coresight-tpdm: Add integration test support
  Coresight: Add TPDA link driver
  dt-bindings: arm: Adds CoreSight TPDA hardware definitions
  arm64: dts: qcom: sm8250: Add coresight components
  arm64: dts: qcom: sm8250: Add tpdm mm/prng

 .../testing/sysfs-bus-coresight-devices-tpdm  |  13 +
 .../bindings/arm/qcom,coresight-tpda.yaml     | 111 +++
 .../bindings/arm/qcom,coresight-tpdm.yaml     |  93 +++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 671 ++++++++++++++++++
 drivers/hwtracing/coresight/Kconfig           |  23 +
 drivers/hwtracing/coresight/Makefile          |   2 +
 drivers/hwtracing/coresight/coresight-core.c  |  42 +-
 drivers/hwtracing/coresight/coresight-tpda.c  | 206 ++++++
 drivers/hwtracing/coresight/coresight-tpda.h  |  35 +
 drivers/hwtracing/coresight/coresight-tpdm.c  | 259 +++++++
 drivers/hwtracing/coresight/coresight-tpdm.h  |  62 ++
 include/linux/coresight.h                     |   1 +
 13 files changed, 1508 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h

-- 
2.17.1

