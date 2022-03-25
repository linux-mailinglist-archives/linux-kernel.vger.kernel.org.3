Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D9F4E70DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358779AbiCYKMR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Mar 2022 06:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358700AbiCYKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:11:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6993A5716A;
        Fri, 25 Mar 2022 03:09:51 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22P9ZM8W013340;
        Fri, 25 Mar 2022 10:09:00 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f0t26v3s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 10:09:00 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22P9xLMJ008133;
        Fri, 25 Mar 2022 10:08:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3ew6t94x2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 10:08:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22PA8sGt53281182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 10:08:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51E1D42042;
        Fri, 25 Mar 2022 10:08:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC0BF42041;
        Fri, 25 Mar 2022 10:08:53 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 25 Mar 2022 10:08:53 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.95.248])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id E21EB220121;
        Fri, 25 Mar 2022 11:08:51 +0100 (CET)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v4 00/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
Date:   Fri, 25 Mar 2022 11:08:38 +0100
Message-Id: <20220325100849.2019209-1-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JU0KiGmldJHd887xHBSDyergg_o_ZDeg
X-Proofpoint-GUID: JU0KiGmldJHd887xHBSDyergg_o_ZDeg
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_02,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1034 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203250057
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds a new SPI driver using the spi-mem interface for the
Aspeed static memory controllers of the AST2600, AST2500 and AST2400
SoCs.

 * AST2600 Firmware SPI Memory Controller (FMC)
 * AST2600 SPI Flash Controller (SPI1 and SPI2)
 * AST2500 Firmware SPI Memory Controller (FMC)
 * AST2500 SPI Flash Controller (SPI1 and SPI2)
 * AST2400 New Static Memory Controller (also referred as FMC)
 * AST2400 SPI Flash Controller (SPI)

It is based on the current OpenBMC kernel driver [1], using directly
the MTD SPI-NOR interface and on a patchset [2] previously proposed
adding support for the AST2600 only. This driver takes a slightly
different approach to cover all 6 controllers.

It does not make use of the controller register disabling Address and
Data byte lanes because is not available on the AST2400 SoC. We could
introduce a specific handler for new features available on recent SoCs
if needed. As there is not much difference on performance, the driver
chooses the common denominator: "User mode" which has been heavily
tested in [1]. "User mode" is also used as a fall back method when
flash device mapping window is too small.

Problems to address with spi-mem were the configuration of the mapping
windows and the calibration of the read timings. The driver handles
them in the direct mapping handler when some knowledge on the size of
the flash device is know. It is not perfect but not incorrect either.
The algorithm is one from [1] because it doesn't require the DMA
registers which are not available on all controllers.

Direct mapping for writes is not supported (yet). I have seen some
corruption with writes and I preferred to use the safer and proven
method of the initial driver [1]. We can improve that later.

The driver supports Quad SPI RX transfers on the AST2600 SoC but it
didn't have the expected results. Therefore it is not activated yet.
There are some issues on the pinctrl to investigate first. 

Tested on:
 
 * OpenPOWER Palmetto (AST2400)
 * Facebook Wedge 100 BMC (AST2400) by Tao Ren <rentao.bupt@gmail.com>
 * Evaluation board (AST2500) 
 * Inspur FP5280G2 BMC (AST2500) by John Wang <wangzq.jn@gmail.com>
 * Facebook Backpack CMM BMC (AST2500) by Tao Ren <rentao.bupt@gmail.com>
 * OpenPOWER Witherspoon (AST2500)
 * Evaluation board (AST2600 A0 and A3)
 * Rainier board (AST2600)
 
[1] https://github.com/openbmc/linux/blob/dev-5.15/drivers/mtd/spi-nor/controllers/aspeed-smc.c
[2] https://patchwork.ozlabs.org/project/linux-aspeed/list/?series=212394

Thanks,

C. 

Changes in v4:

  - Rebased on 5.18 
  - Removal of the SPI-NOR base driver (we had enough tests)
  - Fix for small size flash devices on AST2600 (Potin)

Changes in v3:

 - Fixed compile warning on aspeed_spi_dirmap_read() prototype reported
   by kernel test robot 
 - Removed unnecessary entry in ast2600-fmc.yaml
 - New patch from Tao to set spi-max-frequency on all FMC devices

Changes in v2:

 - Fixed dt_binding_check warnings (Rob)
 - New entry in MAINTAINERS 
 - Addressed Lukas comments regarding the SPI controller registration
   and device removal. Checked with driver bind/unbind   
 - Introduced setup and cleanup handlers and removed routine looping
   on the DT children properties (Pratyush)
 - Clarified in commit log requirements for training.
 - Removed defconfig changes of patch 1 since they were reverted in
   the last patch (Joel)

Cédric Le Goater (9):
  ARM: dts: aspeed: Adjust "reg" property of FMC/SPI controllers
  dt-bindings: spi: Add Aspeed SMC controllers device tree binding
  spi: spi-mem: Convert Aspeed SMC driver to spi-mem
  spi: aspeed: Add support for direct mapping
  spi: aspeed: Adjust direct mapping to device size
  spi: aspeed: Workaround AST2500 limitations
  spi: aspeed: Add support for the AST2400 SPI controller
  spi: aspeed: Calibrate read timings
  ARM: dts: aspeed: Enable Dual SPI RX transfers

Potin Lai (1):
  mtd: spi-nor: aspeed: set the decoding size to at least 2MB for
    AST2600

Tao Ren (1):
  ARM: dts: aspeed-g4: Set spi-max-frequency for all flashes

 drivers/mtd/spi-nor/controllers/aspeed-smc.c  |  910 -------------
 drivers/spi/spi-aspeed-smc.c                  | 1197 +++++++++++++++++
 .../devicetree/bindings/mtd/aspeed-smc.txt    |   51 -
 .../bindings/spi/aspeed,ast2600-fmc.yaml      |   87 ++
 MAINTAINERS                                   |   10 +
 arch/arm/boot/dts/aspeed-g4.dtsi              |   16 +-
 arch/arm/boot/dts/aspeed-g5.dtsi              |   16 +-
 arch/arm/boot/dts/aspeed-g6.dtsi              |   17 +-
 drivers/mtd/spi-nor/controllers/Kconfig       |   10 -
 drivers/mtd/spi-nor/controllers/Makefile      |    1 -
 drivers/spi/Kconfig                           |   11 +
 drivers/spi/Makefile                          |    1 +
 12 files changed, 1339 insertions(+), 988 deletions(-)
 delete mode 100644 drivers/mtd/spi-nor/controllers/aspeed-smc.c
 create mode 100644 drivers/spi/spi-aspeed-smc.c
 delete mode 100644 Documentation/devicetree/bindings/mtd/aspeed-smc.txt
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml

-- 
2.34.1

