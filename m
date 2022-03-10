Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FBD4D528D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbiCJTvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiCJTvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:51:19 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335F0E44A4;
        Thu, 10 Mar 2022 11:50:18 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AJWPQa003313;
        Thu, 10 Mar 2022 19:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=dvZA06DuDyz0tHMZ80OSxiUXw+f4gEVK18KS3lO6TN4=;
 b=RwFqI/0ipyFrmZZKjN8T9L2nPEWwpHM+M+IZCF/UqwkCp5WrmEevqVw6rmtVG2kBc/kx
 W+sOZw6T+A/z3A6vcE5ZYdfURLf+iXFvkFTncXHKk3aGNIj/GrO+dYVESOsn36v6N7hN
 ZdXmq+yCrp1+4qseocdOS+d3x57cQ5fqxlgGdhldZu46OEKCRrSr3pPh3aP0fpM1B0gM
 qeJ8CRlyaKWrisuZVuj/mO3JAE/5DtlCgNujVOh5BtK2Hw6RpuLWbM+RpsxDUxFUf8iU
 LUn2z9KNU76TANb5mCwdX9VHJ9lz/NPUTMILzAI0cgMf1DwNkDp9jzutEprOpSYPGd5Q BQ== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3eqmhc1rrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 19:49:10 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 56B5962;
        Thu, 10 Mar 2022 19:49:08 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        wim@linux-watchdog.org, linux@roeck-us.net, linux@armlinux.org.uk,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 00/10] ARM: Introduce HPE GXP Architecture
Date:   Thu, 10 Mar 2022 13:51:23 -0600
Message-Id: <20220310195123.109359-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: WIMPhINOhMsvxEPGgufKBQf-jm8T9HtP
X-Proofpoint-ORIG-GUID: WIMPhINOhMsvxEPGgufKBQf-jm8T9HtP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=942 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100100
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Changes since v2:
 *Reduced size of changes, put them into pathset format

Changes since v1:
 *Fix compiler warnings

The GXP is the HPE BMC SoC that is used in the majority
of HPE Generation 10 servers. Traditionally the asic will
last multiple generations of server before being replaced.

Info about SoC:

  HPE GXP is the name of the HPE Soc. This SoC is used to implement
  many BMC features at HPE. It supports ARMv7 architecture based on
  the Cortex A9 core. It is capable of using an AXI bus to which
  a memory controller is attached. It has multiple SPI interfaces
  to connect boot flash and BIOS flash. It uses a 10/100/1000 MAC
  for network connectivity. It has multiple i2c engines to drive
  connectivity with a host infrastructure. The initial patches
  enable the watchdog and timer enabling the host to be able to
  boot.

Nick Hawkins (10):
  arch: arm: mach-hpe: Introduce the HPE GXP architecture
  arch: arm: configs: multi_v7_defconfig
  drivers: wdt: Introduce HPE GXP SoC Watchdog
  clocksource/drivers: Add HPE GXP timer
  dt-bindings: timer: Add HPE GXP Timer Binding
  dt-bindings: watchdog: Add HPE GXP Watchdog timer binding
  dt-bindings: arm: Add HPE GXP Binding
  dt-bindings: arm: Add HPE GXP CPU Init
  arch: arm: boot: dts: Introduce HPE GXP Device tree
  maintainers: Introduce HPE GXP Architecture

 .../cpu-enable-method/hpe,gxp-cpu-init.yaml   |  31 +++
 .../devicetree/bindings/arm/gxp.yaml          |  53 +++++
 .../bindings/timer/hpe,gxp-timer.yaml         |  45 +++++
 .../bindings/watchdog/hpe,gxp-wdt.yaml        |  37 ++++
 MAINTAINERS                                   |  14 ++
 arch/arm/Kconfig                              |   2 +
 arch/arm/Makefile                             |   1 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts      |  27 +++
 arch/arm/boot/dts/hpe-gxp.dtsi                | 148 ++++++++++++++
 arch/arm/configs/multi_v7_defconfig           |   3 +
 arch/arm/mach-hpe/Kconfig                     |  20 ++
 arch/arm/mach-hpe/Makefile                    |   1 +
 arch/arm/mach-hpe/gxp.c                       |  61 ++++++
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/gxp-timer.c               | 159 +++++++++++++++
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/gxp-wdt.c                    | 191 ++++++++++++++++++
 20 files changed, 813 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/gxp.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
 create mode 100644 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
 create mode 100644 arch/arm/boot/dts/hpe-gxp.dtsi
 create mode 100644 arch/arm/mach-hpe/Kconfig
 create mode 100644 arch/arm/mach-hpe/Makefile
 create mode 100644 arch/arm/mach-hpe/gxp.c
 create mode 100644 drivers/clocksource/gxp-timer.c
 create mode 100644 drivers/watchdog/gxp-wdt.c

-- 
2.17.1

