Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054E648A078
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbiAJTyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:54:53 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:38158 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbiAJTyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:54:52 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 083BA20C045B
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 0/2] Make platform_get_irq[_byname]_optional() optional
Date:   Mon, 10 Jan 2022 22:54:47 +0300
Message-ID: <20220110195449.12448-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 2 patches making platform_get_irq[_byname]_optional() return 0 on
IRQ not being found, thus aligning those with the other *_optional() APIs;
they are against the 'driver-core-linus' branch of GregKH's 'driver-core.git'
repo plus the patch disallowing IRQ0 in platform_get_irq() and its ilk:

https://lore.kernel.org/lkml/5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru/

That patch was against the 'driver-core-linus' branch, so had to do these 2
against that branch as well; tell me if I should rebase to 'driver-core-next'.

Sergey Shtylyov (2):
  platform: make platform_get_irq_optional() optional
  platform: make platform_get_irq_byname_optional() optional

 drivers/base/platform.c                       | 69 ++++++++++++-------
 drivers/char/ipmi/bt-bmc.c                    |  8 ++-
 drivers/counter/interrupt-cnt.c               |  4 +-
 drivers/edac/xgene_edac.c                     |  2 +-
 drivers/gpio/gpio-altera.c                    |  3 +-
 drivers/gpio/gpio-mvebu.c                     |  2 +-
 drivers/gpio/gpio-tqmx86.c                    |  2 +-
 drivers/gpu/drm/lima/lima_device.c            |  2 +-
 drivers/i2c/busses/i2c-brcmstb.c              |  8 +--
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
 drivers/power/supply/mp2629_charger.c         |  4 +-
 drivers/spi/spi-bcm-qspi.c                    |  2 +-
 drivers/spi/spi-hisi-sfc-v3xx.c               |  2 +-
 drivers/spi/spi-mtk-nor.c                     |  3 +-
 drivers/spi/spi-rspi.c                        |  8 +--
 drivers/thermal/rcar_gen3_thermal.c           |  2 +-
 drivers/tty/serial/8250/8250_mtk.c            |  4 +-
 drivers/tty/serial/sh-sci.c                   |  6 +-
 drivers/uio/uio_pdrv_genirq.c                 |  2 +-
 drivers/usb/cdns3/cdns3-plat.c                |  5 +-
 drivers/usb/host/xhci-mtk.c                   |  2 +-
 drivers/usb/mtu3/mtu3_core.c                  |  2 +-
 drivers/vfio/platform/vfio_platform.c         |  6 +-
 sound/soc/dwc/dwc-i2s.c                       |  4 +-
 38 files changed, 110 insertions(+), 90 deletions(-)

-- 
2.26.3

