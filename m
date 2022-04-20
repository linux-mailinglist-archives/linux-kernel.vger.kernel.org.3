Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE43508B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379951AbiDTPDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379881AbiDTPC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:02:56 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877E11A20;
        Wed, 20 Apr 2022 08:00:09 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KETO8K024773;
        Wed, 20 Apr 2022 14:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=SrJ1s9ybwVbdOOH7gaX0781T69f23uJScMgAQXx2D9s=;
 b=mVF4jgUb+ooe5pMgvTeUB8D2IRz/uWHiglputfztkKAkwk6gsaEwG7oS6upmuSAJYrZC
 mRfEWStqBrfn7UfCC1Hkk4ZwoJjL/NddIwX58nxUWasnE4DzlZFoKqqN7KtY7SFn6i7O
 ZyyU49dZzCjy7/k13YU7u0/BiUb4cPgkjl2iHV+hr2+cz6yC4u8akKmVK2UnKZUn/yo7
 XPQjmMzexasVeotZmsUxRgRaToSjYjK1zG8W+qodNuWZ+cYXHDMw1Gj5rTt4sehGTcct
 0UnZinGKVaYO6VVwAKA3PLjMwP60njxIfyEIE4otZ2EVXQ/2SBaooxc/hVVaU3P07gjR 2Q== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjkypr8t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:59:15 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id F03E255;
        Wed, 20 Apr 2022 14:59:13 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 711514A;
        Wed, 20 Apr 2022 14:59:12 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org, wim@linux-watchdog.org,
        linux@roeck-us.net, linux@armlinux.org.uk, arnd@arndb.de,
        olof@lixom.net, joel@jms.id.au, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 00/11] ARM: Introduce HPE GXP Architecture
Date:   Wed, 20 Apr 2022 10:01:14 -0500
Message-Id: <20220420150114.47356-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: HaEgkcqBFgiSzCPe6r6przRCKLH88dHH
X-Proofpoint-GUID: HaEgkcqBFgiSzCPe6r6przRCKLH88dHH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1011 adultscore=0
 impostorscore=0 mlxlogscore=851 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200089
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Changes since v3:
 *Completely redid the dtsi file to represent architecture
 *Reduced device tree size
 *Rewrote the timer driver to start the watchdog driver due
 to similar register region
 *Made adjustments to timer
 *Made adjustments to watchdog
 *Changed gxp.yaml to hpe,gxp.yaml with changes
 *Updated Maintainers to represent new file names
 *Added hpe bindings to generic-ehci and generic-ohci
 *Fixed clock architecture to be accurate

Changes since v2:
 *Reduced size of changes, put them into patchset format

Changes since v1:
 *Fixed compiler warnings

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
 boot. Based on feedback from the device tree gxp-timer now
 creates a gxp-wdt child because of similar register region.

Nick Hawkins (11):
  arch: arm: mach-hpe: Introduce the HPE GXP architecture
  arch: arm: configs: multi_v7_defconfig
  drivers: wdt: Introduce HPE GXP SoC Watchdog
  clocksource/drivers: Add HPE GXP timer
  dt-bindings: timer: Add HPE GXP Timer Binding
  dt-bindings: watchdog: Add HPE GXP Watchdog timer binding
  dt-bindings: arm: Add HPE GXP Binding
  dt-bindings: usb: generic-echi:  Add HPE GXP echi binding
  dt-bindings: usb: generic-ochi:  Add HPE GXP ochi binding
  arch: arm: boot: dts: Introduce HPE GXP Device tree
  maintainers: Introduce HPE GXP Architecture

 .../devicetree/bindings/arm/hpe,gxp.yaml      |  22 +++
 .../bindings/timer/hpe,gxp-timer.yaml         |  49 +++++
 .../devicetree/bindings/usb/generic-ehci.yaml |   1 +
 .../devicetree/bindings/usb/generic-ohci.yaml |   1 +
 .../bindings/watchdog/hpe,gxp-wdt.yaml        |  30 +++
 MAINTAINERS                                   |  13 ++
 arch/arm/Kconfig                              |   2 +
 arch/arm/Makefile                             |   1 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts      |  13 ++
 arch/arm/boot/dts/hpe-gxp.dtsi                | 128 ++++++++++++
 arch/arm/configs/multi_v7_defconfig           |   3 +
 arch/arm/mach-hpe/Kconfig                     |  17 ++
 arch/arm/mach-hpe/Makefile                    |   1 +
 arch/arm/mach-hpe/gxp.c                       |  16 ++
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-gxp.c               | 183 ++++++++++++++++++
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/gxp-wdt.c                    | 166 ++++++++++++++++
 21 files changed, 666 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hpe,gxp.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
 create mode 100644 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
 create mode 100644 arch/arm/boot/dts/hpe-gxp.dtsi
 create mode 100644 arch/arm/mach-hpe/Kconfig
 create mode 100644 arch/arm/mach-hpe/Makefile
 create mode 100644 arch/arm/mach-hpe/gxp.c
 create mode 100644 drivers/clocksource/timer-gxp.c
 create mode 100644 drivers/watchdog/gxp-wdt.c

-- 
2.17.1

