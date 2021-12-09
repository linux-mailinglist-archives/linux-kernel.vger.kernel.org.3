Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC346E9B9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhLIOTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:19:54 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:10155 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhLIOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639059380; x=1670595380;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=8yIO/L4Qk0YPt4jNf0sIEJWCtNx9mximIz5PuGv2w74=;
  b=g3AAPWizqb8uh1Se/KqIA87f/FD2+RiSiKZDSOPricMhHAwi+mRT4m9x
   6hNEURd5m9T8t2zoyRoJMuKmO1nwla7iq+ddo3GXUxLnBd/TE1Qc55nnz
   UiQtJOi48tgUFfAUaMXXHkhvKsgIcTmzIOxIB0Ac4M272NHkaSu8M2PFn
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 Dec 2021 06:16:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:16:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:19 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:15 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 0/9] Coresight: Add support for TPDM and TPDA
Date:   Thu, 9 Dec 2021 22:15:34 +0800
Message-ID: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
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
    Use IDR to maintain all the enabled sources' paths.

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

Changes from V1:
1. Use IDR to store the path of sources. (Mathieu Poirier)
2. Only add integration_test/enable/disable for TPDM. No other configs.
(Mathieu Poirier)
3. Move coresight dtsi changes to sm8250.dtsi. (Suzuki K Poulose)

Mao Jinlong (9):
  Use IDR to maintain all the enabled sources' paths.
  Coresight: Add coresight TPDM source driver
  dt-bindings: arm: Adds CoreSight TPDM hardware definitions
  coresight-tpdm: Add DSB dataset support
  coresight-tpdm: Add integration test support
  docs: sysfs: coresight: Add sysfs ABI documentation for TPDM
  Coresight: Add TPDA link driver
  dt-bindings: arm: Adds CoreSight TPDA hardware definitions
  ARM: dts: msm: Add coresight components for SM8250

 .../testing/sysfs-bus-coresight-devices-tpdm  |  12 +
 .../bindings/arm/coresight-tpda.yaml          | 131 ++++
 .../bindings/arm/coresight-tpdm.yaml          |  83 +++
 .../devicetree/bindings/arm/coresight.txt     |   7 +
 MAINTAINERS                                   |  13 +
 .../arm64/boot/dts/qcom/sm8250-coresight.dtsi | 688 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   2 +
 drivers/hwtracing/coresight/Kconfig           |  33 +
 drivers/hwtracing/coresight/Makefile          |   2 +
 drivers/hwtracing/coresight/coresight-core.c  |  79 +-
 drivers/hwtracing/coresight/coresight-tpda.c  | 201 +++++
 drivers/hwtracing/coresight/coresight-tpda.h  |  33 +
 drivers/hwtracing/coresight/coresight-tpdm.c  | 262 +++++++
 drivers/hwtracing/coresight/coresight-tpdm.h  |  62 ++
 include/linux/coresight.h                     |   1 +
 15 files changed, 1558 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h

-- 
2.17.1

