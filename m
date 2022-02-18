Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A4F4BBA71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiBROLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:11:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiBROLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:11:03 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD702B2C7A;
        Fri, 18 Feb 2022 06:10:46 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 34D672001A;
        Fri, 18 Feb 2022 14:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645193444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mI/XiwDXECsFaDoObAE8vWmYY15ZcyitEJ8Rz7zoe20=;
        b=g5h+KeK6KNwKUMWtVb7F9PC7MWeFcItnJBcblNTilsogE1ASpIzw9HO3Vtkx0bSVUtZc1f
        kyzzqoMhegtNHDww92TkCjWV7cRfoncNlRL2TWx2NTgKxS3K1DCe7+iINNTYxS4h9sQDUD
        nWJfKp8OVKsOHI/PynVDihmkUYY/lU1JDV9HxDrl0i4Cbxgvay19lS5qIsCAlL7nMc1YDR
        11wZMsxbooW9D9mysze6Si1DwIfgnuZrU8hcTQrnetEtFPZGDI6Trz5XKN8DXr7nzbK54j
        +v8BVAI8IepflsvP8UaX1TaMCN7DVdkjtPe7+IpoiQKV6aPfxuID3tYRZv3pig==
Date:   Fri, 18 Feb 2022 15:10:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [GIT PULL] : spi-mem/ecc changes for 5.18
Message-ID: <20220218151041.76f8a72b@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Here are the changes that I've piled up in the MTD spi-mem-ecc branch. I
will merge this branch into mtd/next very soon but here is a PR for you
as well if needed.

Thanks, Miqu=C3=A8l

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/spi-=
mem-ecc-for-5.18

for you to fetch changes up to 00360ebae483e603d55ec9a7231b787cb80ffe13:

  spi: mxic: Add support for pipelined ECC operations (2022-02-10 09:32:30 =
+0100)

----------------------------------------------------------------
Topic branch bringing-in changes related to the support of ECC engines
that can be used by SPI controllers to manage SPI NANDs as well as
possibly by parallel NAND controllers. In particular, it brings support
for Macronix ECC engine that can be used with Macronix SPI controller.

The changes touch the NAND core, the NAND ECC core, the spi-mem layer, a
SPI controller driver and add a new NAND ECC driver, as well as a number
of binding updates.

Binding changes:
* Vendor prefixes: Clarify Macronix prefix
* SPI NAND: Convert spi-nand description file to yaml
* Raw NAND chip: Create a NAND chip description
* Raw NAND controller:
  - Harmonize the property types
  - Fix a comment in the examples
  - Fix the reg property description
* Describe Macronix NAND ECC engine
* Macronix SPI controller:
  - Document the nand-ecc-engine property
  - Convert to yaml
  - The interrupt property is not mandatory

NAND core changes:
* ECC:
  - Add infrastructure to support hardware engines
  - Add a new helper to retrieve the ECC context
  - Provide a helper to retrieve a pilelined engine device

NAND-ECC changes:
* Macronix ECC engine:
  - Add Macronix external ECC engine support
  - Support SPI pipelined mode

SPI-NAND core changes:
* Delay a little bit the dirmap creation
* Create direct mapping descriptors for ECC operations

SPI-NAND driver changes:
* macronix: Use random program load

SPI changes:
* Macronix SPI controller:
  - Fix the transmit path
  - Create a helper to configure the controller before an operation
  - Create a helper to ease the start of an operation
  - Add support for direct mapping
  - Add support for pipelined ECC operations
* spi-mem:
  - Introduce a capability structure
  - Check the controller extra capabilities
  - cadence-quadspi/mxic: Provide capability structures
  - Kill the spi_mem_dtr_supports_op() helper
  - Add an ecc parameter to the spi_mem_op structure

----------------------------------------------------------------
Mason Yang (1):
      mtd: spinand: macronix: Use random program load

Miquel Raynal (28):
      dt-bindings: mtd: nand-controller: Fix the reg property description
      dt-bindings: mtd: nand-controller: Fix a comment in the examples
      dt-bindings: mtd: nand-controller: Harmonize the property types
      dt-bindings: mtd: nand-chip: Create a NAND chip description
      dt-bindings: mtd: spi-nand: Convert spi-nand description file to yaml
      dt-bindings: vendor-prefixes: Clarify Macronix prefix
      dt-bindings: spi: mxic: The interrupt property is not mandatory
      dt-bindings: spi: mxic: Convert to yaml
      dt-bindings: spi: mxic: Document the nand-ecc-engine property
      dt-bindings: mtd: Describe Macronix NAND ECC engine
      mtd: nand: ecc: Add infrastructure to support hardware engines
      mtd: nand: Add a new helper to retrieve the ECC context
      mtd: nand: mxic-ecc: Add Macronix external ECC engine support
      mtd: nand: ecc: Provide a helper to retrieve a pilelined engine device
      mtd: nand: mxic-ecc: Support SPI pipelined mode
      spi: spi-mem: Introduce a capability structure
      spi: spi-mem: Check the controller extra capabilities
      spi: cadence-quadspi: Provide a capability structure
      spi: mxic: Provide a capability structure
      spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
      spi: spi-mem: Add an ecc parameter to the spi_mem_op structure
      mtd: spinand: Delay a little bit the dirmap creation
      mtd: spinand: Create direct mapping descriptors for ECC operations
      spi: mxic: Fix the transmit path
      spi: mxic: Create a helper to configure the controller before an oper=
ation
      spi: mxic: Create a helper to ease the start of an operation
      spi: mxic: Add support for direct mapping
      spi: mxic: Add support for pipelined ECC operations

 Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.yaml |  77 +++
 Documentation/devicetree/bindings/mtd/nand-chip.yaml             |  70 +++
 Documentation/devicetree/bindings/mtd/nand-controller.yaml       |  72 +--
 Documentation/devicetree/bindings/mtd/spi-nand.txt               |   5 -
 Documentation/devicetree/bindings/mtd/spi-nand.yaml              |  27 +
 Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml     |  65 +++
 Documentation/devicetree/bindings/spi/spi-mxic.txt               |  34 --
 Documentation/devicetree/bindings/vendor-prefixes.yaml           |   3 +
 drivers/mtd/nand/Kconfig                                         |   6 +
 drivers/mtd/nand/Makefile                                        |   1 +
 drivers/mtd/nand/core.c                                          |  10 +-
 drivers/mtd/nand/ecc-mxic.c                                      | 879 +++=
+++++++++++++++++++++++++++++
 drivers/mtd/nand/ecc.c                                           | 119 +++=
++
 drivers/mtd/nand/spi/core.c                                      |  51 +-
 drivers/mtd/nand/spi/macronix.c                                  |   2 +-
 drivers/spi/Kconfig                                              |   1 +
 drivers/spi/spi-cadence-quadspi.c                                |  10 +-
 drivers/spi/spi-mem.c                                            |  32 +-
 drivers/spi/spi-mxic.c                                           | 340 +++=
++++++---
 include/linux/mtd/nand-ecc-mxic.h                                |  49 ++
 include/linux/mtd/nand.h                                         |  49 ++
 include/linux/mtd/spinand.h                                      |   2 +
 include/linux/spi/spi-mem.h                                      |  26 +-
 include/linux/spi/spi.h                                          |   3 +
 24 files changed, 1731 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-en=
gine.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/nand-chip.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
 create mode 100644 drivers/mtd/nand/ecc-mxic.c
 create mode 100644 include/linux/mtd/nand-ecc-mxic.h
