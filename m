Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017FF528A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbiEPQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiEPQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:32:15 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426353B2BD;
        Mon, 16 May 2022 09:32:14 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G9ZZxm012847;
        Mon, 16 May 2022 16:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=M4Ucz3XpmHfg+BS5UkTAgZSf+gZkXZxwowIS8buRzAo=;
 b=GnRCwBNeQI0/gB3ErMXu8ZhkUXF2ymLYd7OKyTYWCkl/1DkeUff9B800EIWnf0AurYIB
 Rls2D7/SwLCbCBMZIXKAUxmCn1Ppbf8PTjX3rF7vpAOKyy6y1dISIPnsk7T9SS/Pagvj
 NyqGVfWolI7NPa/vvjKmwQ+6aPaPcOHyFTHaOWKDTY6Ra/K8fzEdeXcP3GUC9oREBVoP
 x7Q7vc/Jxy1M+ZflYbvNlPCThl4VWOwx+MKXCEfMHvhzgcI2whuCaW+kK+KAWWaYz6uk
 4K4ZSH6jfJshF4YvWn+9eKHooHfZNilxkQIrt9ykPg2ePj7bZO8+AOIqJ6NaFEbZG+Xs Iw== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3g3kgrdhtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 16:31:21 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 412B665;
        Mon, 16 May 2022 16:31:19 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id C3B6136;
        Mon, 16 May 2022 16:31:17 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, joel@jms.id.au
Subject: [PATCH v8 0/8] Introduce HPE GXP Architecture
Date:   Mon, 16 May 2022 11:33:10 -0500
Message-Id: <20220516163310.44842-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: fx7CeuKXYiuDZAiqqR2dEuZxtlmH3Pzk
X-Proofpoint-GUID: fx7CeuKXYiuDZAiqqR2dEuZxtlmH3Pzk
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_15,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160092
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Changes since v7:
 *Fixed comment format in watchdog driver
 *Added the Acked-by tag to the device tree patch.
 *Resubmitted the dt-bindings patches hpe,gxp and hpe,gxp-timer with
  Reviewed-by tags from previous patch in descriptions to keep patchset
  continuity for v8.
Changes since v6:
 *Resubmitted the dt-bindings patches hpe,gxp and hpe,gxp-timer with
  Reviewed-by tags from previous patch in descriptions to keep patchset
  continuity for v7.
 *Fixed the subject on dt-binding patch:
  dt-bindings: timer: hpe,gxp-timer: Creation to
  dt-bindings: timer: hpe,gxp-timer: Add HPE GXP Timer and Watchdog
 *Changed the following in MAINTAINERS:
  arch/arm/boot/dts/hpe-bmc-dl360gen10.dts to arch/arm/boot/hpe-bmc*
  arch/arm/boot/dts/hpe-gxp.dtsi to arch/arm/boot/dts/hpe-gxp*
  arch/arm/mach-hpe/gxp.c to arch/arm/mach-hpe 
 *Changed cache register area length from 0xFFC to 0x1000 in hpe-gxp.dtsi
 *Added space between "," in compatible list for the
  hpe-bmc-dl360gen10.dts
 *Added aliases, chosen, and memory to hpe-bmc-dl360gen10.dts
 *Removed memory from hpe-gxp.dtsi
 *Changed conditional statements around COMPILE_TEST and TIMER_OF if of
  for GXP in clocksource Kconfig
 *Changed commit description for watchdog driver where Adding became Add
  and compliment became complement.
 *Removed unused include files of_address.h and of_platform.h in gxp-wdt.c
 *Fixed the max timeout on watchdog to be 655350 in gxp-wdt.c
 *Changed time variable computations in gxp_wdt_set_timeout to be clear in
  gxp-wdt.c
 *Decreased reboot delay to 10ms from 100ms in gxp-wdt.c
 *Added comment to explain why it is necessary to pass the base address
  over a private interface from the timer driver in gxp-wdt.c

Changes since v5:
 *Removed generic-ohci and generic-ehci from patchset as they were
  committed to linux-next 
 *Removed watchdog node from device tree and dt-bindings documentation as
  it is not necessary since the timer creates it
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
 *Updated outdated base revision to newer one to resolve merge conflicts
  as well as pickup vendor binding change for hpe.

Changes since v3:
 *Completely redid the dtsi file to represent architecture
 *Reduced device tree size
 *Rewrote the timer driver to start the watchdog driver due to similar
  register region
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

The GXP is the HPE BMC SoC that is used in the majority of HPE current
generation servers. Traditionally the asic will last multiple
generations of server before being replaced.

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
  dt-bindings: timer: hpe,gxp-timer: Add HPE GXP Timer and Watchdog
  dt-bindings: arm: hpe: add GXP Support
  ARM: dts: Introduce HPE GXP Device tree
  MAINTAINERS: Introduce HPE GXP Architecture

 .../devicetree/bindings/arm/hpe,gxp.yaml      |  27 +++
 .../bindings/timer/hpe,gxp-timer.yaml         |  47 ++++
 MAINTAINERS                                   |  12 +
 arch/arm/Kconfig                              |   2 +
 arch/arm/Makefile                             |   1 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts      |  26 +++
 arch/arm/boot/dts/hpe-gxp.dtsi                | 127 +++++++++++
 arch/arm/configs/multi_v7_defconfig           |   3 +
 arch/arm/mach-hpe/Kconfig                     |  23 ++
 arch/arm/mach-hpe/Makefile                    |   1 +
 arch/arm/mach-hpe/gxp.c                       |  16 ++
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-gxp.c               | 209 ++++++++++++++++++
 drivers/watchdog/Kconfig                      |  11 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/gxp-wdt.c                    | 174 +++++++++++++++
 18 files changed, 691 insertions(+)
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

