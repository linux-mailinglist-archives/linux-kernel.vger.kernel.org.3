Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF14B37CC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 21:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiBLUQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 15:16:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiBLUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 15:16:47 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23821B42
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:16:40 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru E1DB720601B3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] Make platform_get_irq[_byname]_optional() optional
Date:   Sat, 12 Feb 2022 23:16:29 +0300
Message-ID: <20220212201631.12648-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 2 patches making platform_get_irq[_byname]_optional() return 0 on
an IRQ not being found, thus aligning those with the other *_optional() APIs;
they are against the 'driver-core-next' branch of GregKH's 'driver-core.git'
repo plus the patch disallowing IRQ0 in platform_get_irq() and its ilk (which
happily applies to 'driver-core-next' as well):

https://lore.kernel.org/lkml/5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru/

Sergey Shtylyov (2):
  platform: make platform_get_irq_optional() optional
  platform: make platform_get_irq_byname_optional() optional

 drivers/base/platform.c                       | 77 +++++++++++++------
 drivers/char/ipmi/bt-bmc.c                    |  6 +-
 drivers/counter/interrupt-cnt.c               |  4 +-
 drivers/gpio/gpio-altera.c                    |  3 +-
 drivers/gpio/gpio-mvebu.c                     |  2 +-
 drivers/gpio/gpio-tqmx86.c                    |  2 +-
 drivers/gpu/drm/lima/lima_device.c            |  2 +-
 drivers/i2c/busses/i2c-brcmstb.c              |  8 +-
 drivers/i2c/busses/i2c-ocores.c               |  4 +-
 drivers/mailbox/tegra-hsp.c                   |  4 +-
 drivers/mmc/host/sh_mmcif.c                   |  4 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c      |  4 +-
 drivers/net/can/rcar/rcar_canfd.c             |  4 +-
 drivers/net/dsa/b53/b53_srab.c                |  2 +-
 drivers/net/ethernet/davicom/dm9000.c         |  2 +-
 drivers/net/ethernet/freescale/fec_main.c     |  2 +-
 drivers/net/ethernet/freescale/fec_ptp.c      |  4 +-
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c |  4 +-
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 +-
 .../pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |  4 +-
 drivers/platform/chrome/cros_ec_lpc.c         |  2 +-
 drivers/platform/x86/intel/punit_ipc.c        |  2 +-
 drivers/spi/spi-bcm-qspi.c                    |  2 +-
 drivers/spi/spi-hisi-sfc-v3xx.c               |  2 +-
 drivers/spi/spi-mtk-nor.c                     |  3 +-
 drivers/spi/spi-rspi.c                        |  8 +-
 drivers/thermal/rcar_gen3_thermal.c           |  2 +
 drivers/tty/serial/8250/8250_mtk.c            |  4 +-
 drivers/tty/serial/sh-sci.c                   |  6 +-
 drivers/uio/uio_pdrv_genirq.c                 |  2 +-
 drivers/usb/cdns3/cdns3-plat.c                |  5 +-
 drivers/usb/host/xhci-mtk.c                   |  2 +-
 drivers/usb/mtu3/mtu3_core.c                  |  2 +-
 drivers/vfio/platform/vfio_platform.c         |  3 +-
 sound/soc/dwc/dwc-i2s.c                       |  4 +-
 36 files changed, 111 insertions(+), 86 deletions(-)

-- 
2.26.3

