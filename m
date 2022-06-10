Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405E7545D30
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346665AbiFJHWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbiFJHVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:21:43 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC66038C083
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:21:35 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 819DDBD1;
        Fri, 10 Jun 2022 10:22:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 819DDBD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654845744;
        bh=z8mq2UkwmLMqL0DG3q1BtK9e5Sy5l+mkuuDHM21YBtE=;
        h=From:To:CC:Subject:Date:From;
        b=m6eCIpghqmDeRukr/Br6GjfyvzRYxOnOv8AGjsR3DwyzaNp6wykxtCSgkvoN3pptk
         2kSPJi481Cto5P5X6ZeoVgW7cYWD4XT8ebTade/DDUoBdkGtgvg+dM1Ow4mexRsJ0V
         7KJ7AoyzVf604/r+gBjvGolMuU3S1C3J9whpcUTI=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 10:21:31 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/8] clk/resets: baikal-t1: Add DDR/PCIe resets and xGMAC/SATA fixes
Date:   Fri, 10 Jun 2022 10:21:16 +0300
Message-ID: <20220610072124.8714-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short summary regarding this patchset. The series starts from fixing a
wrong semantic of the device managed optional exclusive bulk reset control
getter. Then we suggest a fix of the clocks glitching cause by the Renesas
5P49V6901 chip in some circumstances. Afterwards a few more modifications
are introduced to finally finish the Baikal-T1 CCU unit support up and
prepare the code before adding the Baikal-T1 PCIe/xGMAC support. First of
all it turned out I specified wrong DW xGMAC PTP reference clock divider
in my initial patches. It must be 8, not 10. Secondly I was wrong to add a
joint xGMAC Ref and PTP clock instead of having them separately defined.
The SoC manual describes these clocks as separate fixed clock wrappers.
Finally in order to close the SoC clock/reset support up we need to add
the DDR and PCIe interfaces reset controls support. It's done in two
steps. First I've moved the reset-controls-related code into a dedicated
module. Then the DDR/PCIe reset-control functionality is added. As the
series finalization we've decided to convert the Baikal-T1 clock/reset
source drivers to mainly being the platform device driver and
pre-initialize the basic clocks only at the early kernel boot stages.

Link: https://lore.kernel.org/linux-pci/20220324010905.15589-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Resubmit the series with adding @Philipp to the list of the recipients.

Link: https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru/
Changelog v3:
- No comments. Just resend the series.
- Rebased from v5.17 onto v5.18-rc3.

Link: https://lore.kernel.org/linux-clk/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
Changelog v4:
- Completely split the CCU Dividers and Resets functionality up. (@Stephen)
- Add a new fixes patch: "clk: baikal-t1: Actually enable SATA internal
  ref clock".
- Add a new fixes patch: "reset: Fix devm bulk optional exclusive control
  getter".
- Add a new fixes patch: "clk: vc5: Fix 5P49V6901 outputs disabling when
  enabling FOD".
- Add a new feagure patch: "clk: baikal-t1: Convert to platform device
  driver".
- Change the internal clock ID to the XGMAC-referred name.
- Rebase onto the kernel v5.18.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-clk@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (8):
  reset: Fix devm bulk optional exclusive control getter
  clk: vc5: Fix 5P49V6901 outputs disabling when enabling FOD
  clk: baikal-t1: Fix invalid xGMAC PTP clock divider
  clk: baikal-t1: Add shared xGMAC ref/ptp clocks internal parent
  clk: baikal-t1: Add SATA internal ref clock buffer
  clk: baikal-t1: Move reset-controls code into a dedicated module
  clk: baikal-t1: Add DDR/PCIe directly controlled resets support
  clk: baikal-t1: Convert to platform device driver

 drivers/clk/baikal-t1/Kconfig       |  12 +-
 drivers/clk/baikal-t1/Makefile      |   1 +
 drivers/clk/baikal-t1/ccu-div.c     |  84 +++++++--
 drivers/clk/baikal-t1/ccu-div.h     |  17 +-
 drivers/clk/baikal-t1/ccu-pll.h     |   8 +
 drivers/clk/baikal-t1/ccu-rst.c     |  99 ++++++++++
 drivers/clk/baikal-t1/ccu-rst.h     |  79 ++++++++
 drivers/clk/baikal-t1/clk-ccu-div.c | 272 +++++++++++++++++-----------
 drivers/clk/baikal-t1/clk-ccu-pll.c | 128 ++++++++++---
 drivers/clk/baikal-t1/clk-ccu-rst.c | 257 ++++++++++++++++++++++++++
 drivers/clk/clk-versaclock5.c       |   2 +-
 include/dt-bindings/reset/bt1-ccu.h |   9 +
 include/linux/reset.h               |   2 +-
 13 files changed, 814 insertions(+), 156 deletions(-)
 create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
 create mode 100644 drivers/clk/baikal-t1/ccu-rst.h
 create mode 100644 drivers/clk/baikal-t1/clk-ccu-rst.c

-- 
2.35.1

