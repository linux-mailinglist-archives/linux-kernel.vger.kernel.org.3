Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DAF5AA2D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiIAWVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiIAWUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:20:44 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5389865820;
        Thu,  1 Sep 2022 15:19:09 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 87CBE1289;
        Fri,  2 Sep 2022 00:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662070747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nio5VShjR36b7TNhjr6zMAaYgoDj7l1SrZJTJgFGB7c=;
        b=1f3mCveFHUvdTH1jA4jGLzsgo2CvDgXYFTqOjEGEEdhh2daSMOgbqnyp4BEVdlC8m5KIXt
        mvhSwTppEScHSESXoREW2Hcqgm1kkpWHhu/vicu4Mc1A/f/88kYoFL+vM5saBE5cxEdy0G
        t+Efgla6IJr3X+XiUWAhKY4kWzSeC/F+I7ZSGhDIOafwwmbeCLGKyoETJWY5YzND+5hBwt
        yP083TZsAVWYMBSLLJSJgS/FQ8LWgutgwIpzD0MPVwUPGDU10n10sOkg7DxNwhmZFTFJ1x
        UZvPap5/IzIaCFRMY7LBpFa/ESthVvNTic6o6Plwu0Iho1esP3KKuvvW5gSJiQ==
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
Date:   Fri,  2 Sep 2022 00:18:37 +0200
Message-Id: <20220901221857.2600340-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now the third attempt to fetch the MAC addresses from the VPD
for the Kontron sl28 boards. Previous discussions can be found here:
https://lore.kernel.org/lkml/20211228142549.1275412-1-michael@walle.cc/


NVMEM cells are typically added by board code or by the devicetree. But
as the cells get more complex, there is (valid) push back from the
devicetree maintainers to not put that handling in the devicetree.

Therefore, introduce NVMEM layouts. They operate on the NVMEM device and
can add cells during runtime. That way it is possible to add more complex
cells than it is possible right now with the offset/length/bits
description in the device tree. For example, you can have post processing
for individual cells (think of endian swapping, or ethernet offset
handling).

The imx-ocotp driver is the only user of the global post processing hook,
convert it to nvmem layouts and drop the global post pocessing hook. Please
note, that this change is only compile-time tested.

You can also have cells which have no static offset, like the
ones in an u-boot environment. The last patches will convert the current
u-boot environment driver to a NVMEM layout and lifting the restriction
that it only works with mtd devices. But as it will change the required
compatible strings, it is marked as RFC for now. It also needs to have
its device tree schema update which is left out here. These two patches
are not expected to be applied, but rather to show another example of
how to use the layouts.

For now, the layouts are selected by a specific compatible string in a
device tree. E.g. the VPD on the kontron sl28 do (within a SPI flash node):
  compatible = "kontron,sl28-vpd", "user-otp";
or if you'd use the u-boot environment (within an MTD patition):
  compatible = "u-boot,env", "nvmem";

The "user-otp" (or "nvmem") will lead to a NVMEM device, the
"kontron,sl28-vpd" (or "u-boot,env") will then apply the specific layout
on top of the NVMEM device.

NVMEM layouts as modules?
While possible in principle, it doesn't make any sense because the NVMEM
core can't be compiled as a module. The layouts needs to be available at
probe time. (That is also the reason why they get registered with
subsys_initcall().) So if the NVMEM core would be a module, the layouts
could be modules, too.

Michael Walle (20):
  net: add helper eth_addr_add()
  of: base: add of_parse_phandle_with_optional_args()
  nvmem: core: add an index parameter to the cell
  nvmem: core: move struct nvmem_cell_info to nvmem-provider.h
  nvmem: core: drop the removal of the cells in nvmem_add_cells()
  nvmem: core: add nvmem_add_one_cell()
  nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()
  nvmem: core: introduce NVMEM layouts
  nvmem: core: add per-cell post processing
  nvmem: core: allow to modify a cell before adding it
  nvmem: imx-ocotp: replace global post processing with layouts
  nvmem: cell: drop global cell_post_process
  nvmem: core: drop priv pointer in post process callback
  dt-bindings: mtd: relax the nvmem compatible string
  dt-bindings: nvmem: add YAML schema for the sl28 vpd layout
  nvmem: layouts: add sl28vpd layout
  nvmem: core: export nvmem device size
  arm64: dts: ls1028a: sl28: get MAC addresses from VPD
  RFC nvmem: layouts: rewrite the u-boot-env driver as a NVMEM layout
  RFC nvmem: layouts: u-boot-env: add device node

 .../devicetree/bindings/mtd/mtd.yaml          |   7 +-
 .../nvmem/layouts/kontron,sl28-vpd.yaml       |  67 +++++
 Documentation/driver-api/nvmem.rst            |  15 ++
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts     |   8 +
 .../fsl-ls1028a-kontron-sl28-var1.dts         |   2 +
 .../fsl-ls1028a-kontron-sl28-var2.dts         |   4 +
 .../fsl-ls1028a-kontron-sl28-var4.dts         |   2 +
 .../freescale/fsl-ls1028a-kontron-sl28.dts    |  13 +
 drivers/nvmem/Kconfig                         |   4 +
 drivers/nvmem/Makefile                        |   1 +
 drivers/nvmem/core.c                          | 251 +++++++++++++-----
 drivers/nvmem/imx-ocotp.c                     |  32 ++-
 drivers/nvmem/layouts/Kconfig                 |  22 ++
 drivers/nvmem/layouts/Makefile                |   7 +
 drivers/nvmem/layouts/sl28vpd.c               | 144 ++++++++++
 drivers/nvmem/layouts/u-boot-env.c            | 146 ++++++++++
 drivers/nvmem/u-boot-env.c                    | 218 ---------------
 include/linux/etherdevice.h                   |  14 +
 include/linux/nvmem-consumer.h                |  16 +-
 include/linux/nvmem-provider.h                |  90 ++++++-
 include/linux/of.h                            |  25 ++
 21 files changed, 775 insertions(+), 313 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
 create mode 100644 drivers/nvmem/layouts/Kconfig
 create mode 100644 drivers/nvmem/layouts/Makefile
 create mode 100644 drivers/nvmem/layouts/sl28vpd.c
 create mode 100644 drivers/nvmem/layouts/u-boot-env.c
 delete mode 100644 drivers/nvmem/u-boot-env.c

-- 
2.30.2

