Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49BC517850
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387426AbiEBUnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387227AbiEBUmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:42:52 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277BCBC84;
        Mon,  2 May 2022 13:39:22 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242H4SDZ029192;
        Mon, 2 May 2022 20:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=0lgM69fOppr6pqtLZNoS0IboU+vfK8goPkZKdLUQYRw=;
 b=nyWhhrk9+SxkQL05TLyw5qarK/yitmsgLf/WPjLBMLjBszVn5cMc1fgxcyZh/qFR+bDp
 MefXyLNpatKndweHZoKHJ6DUYq/Jjaf6qwd0Hiwufla0r4eEr/aT5m7p6heviaBRpDit
 TYhXQu0gW5D0agWKsR/etTjsJGzbWOsOCwJMt2wPAMAzZP8n63txcinwdpeKMSjcwUVb
 oZYl4U9etiANzhAVE/tr2MI+gTYhOOLGHuMZ1nT1WjHA9mzPGboEYAUKP3uj8bhL2aXV
 CPvyhaDftEQzIl4yxr9iYTBPnXcAR7lanjxQaQmw5kKiM5+4tNKgthQIjtGySL2g15wX uw== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ftkcjsr8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 20:38:23 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 369979D;
        Mon,  2 May 2022 20:38:22 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 5738C46;
        Mon,  2 May 2022 20:38:20 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, joel@jms.id.au
Subject: [PATCH v6 0/8] Introduce HPE GXP Architecture
Date:   Mon,  2 May 2022 15:40:12 -0500
Message-Id: <20220502204012.88268-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: vHUDX6axyP5rl0TDSUiLDaokz0rKINV4
X-Proofpoint-ORIG-GUID: vHUDX6axyP5rl0TDSUiLDaokz0rKINV4
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_06,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020153
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Changes since v5:
 *Removed generic-ohci and generic-ehci from patchset as they were
 committed to linux-next
 *Removed watchdog node from device tree and dt-bindings documentation
 as it is not necessary since the timer creates it
 *Added cache controller to device tree
 *Fixed l2c initialization by making l2c_aux_map=~1
 *Corrected Kconfig punctuation and wording in mach-hpe
 *Added oneOf to hpe,gxp.yaml
 *Set additionalProperties to false on hpe,gxp-timer
 *Added space after "," in compatible lists
 *Switched hpe,gxp-timer.yaml title to Timer from TIMER
 *Switched clockname from iopclk to iop
 *Added clock labels clock-0 and clock-1 to device tree
 *Added dma-ranges to ahb in device tree
 *Fixed static device issue in timer-gxp.c with platform_device_alloc
 *Fixed timer-gxp.c initialization to exit cleanly
 *Corrected all subjects and descriptions for every commit
 *Added information about bootloader to mach-hpe patch

Changes since v4:
 *Fixed version mismatch with patchset across all patches
 *Fixed typos with ochi -> ohci echi -> ehci
 *Adjusted Watchdog Kconfig file
 *Adjusted various commit comments
 *Removed un-necessary include file
 *Updated outdated base revision to newer one to resolve merge
  conflicts as well as pickup vendor binding change for hpe.

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
 *Changed from txt->yaml

Changes since v1:
 *Fixed compiler warnings

The GXP is the HPE BMC SoC that is used in the majority
of HPE current generation servers. Traditionally the asic will
last multiple generations of server before being replaced.

Info about SoC:

 HPE GXP is the name of the HPE Soc. This SoC is used to implement many
 BMC features at HPE. It supports ARMv7 architecture based on the Cortex
 A9 core. It is capable of using an AXI bus to which a memory controller
 is attached. It has multiple SPI interfaces to connect boot flash and
 BIOS flash. It uses a 10/100/1000 MAC for network connectivity. It has
 multiple i2c engines to drive connectivity with a host infrastructure.
 The initial patches enable the watchdog and timer enabling the host to
 be able to boot.

Nick Hawkins (8):
  ARM: hpe: Introduce the HPE GXP architecture
  ARM: configs: multi_v7_defconfig: Add HPE GXP ARCH
  watchdog: hpe-wdt: Introduce HPE GXP Watchdog
  clocksource/drivers/timer-gxp: Add HPE GXP Timer
  dt-bindings: timer: hpe,gxp-timer: Creation
  dt-bindings: arm: hpe: add GXP Support
  ARM: dts: Introduce HPE GXP Device tree
  MAINTAINERS: Introduce HPE GXP Architecture

 .../devicetree/bindings/arm/hpe,gxp.yaml      |  27 +++
 .../bindings/timer/hpe,gxp-timer.yaml         |  47 ++++
 MAINTAINERS                                   |  12 +
 arch/arm/Kconfig                              |   2 +
 arch/arm/Makefile                             |   1 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts      |  13 ++
 arch/arm/boot/dts/hpe-gxp.dtsi                | 132 +++++++++++
 arch/arm/configs/multi_v7_defconfig           |   3 +
 arch/arm/mach-hpe/Kconfig                     |  23 ++
 arch/arm/mach-hpe/Makefile                    |   1 +
 arch/arm/mach-hpe/gxp.c                       |  16 ++
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-gxp.c               | 209 ++++++++++++++++++
 drivers/watchdog/Kconfig                      |  11 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/gxp-wdt.c                    | 166 ++++++++++++++
 18 files changed, 675 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hpe,gxp.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 create mode 100644 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
 create mode 100644 arch/arm/boot/dts/hpe-gxp.dtsi
 create mode 100644 arch/arm/mach-hpe/Kconfig
 create mode 100644 arch/arm/mach-hpe/Makefile
 create mode 100644 arch/arm/mach-hpe/gxp.c
 create mode 100644 drivers/clocksource/timer-gxp.c
 create mode 100644 drivers/watchdog/gxp-wdt.c

-- 
2.17.1

