Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF0857075C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiGKPo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiGKPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:44:53 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0306927B30;
        Mon, 11 Jul 2022 08:44:47 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 831F016A4;
        Mon, 11 Jul 2022 18:46:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 831F016A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657554397;
        bh=BkeEs6BdCkU9ABOFSg2oG0mZd7pcIkjI6iLqkIwV09A=;
        h=From:To:CC:Subject:Date:From;
        b=HRNm31egJmUrkE4TVylKhnmeUfbj301LaVavZpiYjJYcvcHHWe4VXma2DU0aPJeq2
         35SHYZYk68ZlZ3MyU6++vixMELDHszGqDWMuLh/hOw9noZ9x4Kc3hbYN1edPMFQaYS
         8yH4BK2MTqglHbiM8zcqR6DHzqQMwyjIgPqGQnyY=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Jul 2022 18:44:44 +0300
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
Subject: [PATCH v7 0/7] clk/resets: baikal-t1: Add DDR/PCIe resets and xGMAC/SATA fixes
Date:   Mon, 11 Jul 2022 18:44:26 +0300
Message-ID: <20220711154433.15415-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks! It has been over four months since the first series submission for
review. Please merge it in.

Short summary regarding this patchset. The series starts from fixing of
the clocks glitching cause by the Renesas 5P49V6901 chip in some
circumstances. Afterwards a few more modifications are introduced to
finally finish the Baikal-T1 CCU unit support up and prepare the code
before adding the Baikal-T1 PCIe/xGMAC support. First of all it turned out
I specified wrong DW xGMAC PTP reference clock divider in my initial
patches. It must be 8, not 10. Secondly I was wrong to add a joint xGMAC
Ref and PTP clock instead of having them separately defined.  The SoC
manual describes these clocks as separate fixed clock wrappers. Finally
in order to close the SoC clock/reset support up we need to add the DDR
and PCIe interfaces reset controls support. It's done in two steps. First
I've moved the reset-controls-related code into a dedicated module. Then
the DDR/PCIe reset-control functionality is added. As the series
finalization we've decided to convert the Baikal-T1 clock/reset source
drivers to mainly being the platform device driver and pre-initialize the
basic clocks only at the early kernel boot stages.

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

Link: https://lore.kernel.org/lkml/20220610072124.8714-1-Sergey.Semin@baikalelectronics.ru/
Changelog v5:
- Just resend.
- Rebase onto the kernel v5.19-rcX.

Link: https://lore.kernel.org/linux-clk/20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru/
Changelog v6:
- Drop the patch
  [PATCH RESEND v5 1/8] reset: Fix devm bulk optional exclusive control getter
  since it has already been accepted by @Philipp.
- Refactor the reset-control code to support the linear reset IDs only.
  (@Philipp)
- Combine the reset-related code into a single file. (@Philipp)
- Drop CCU_DIV_RST_MAP() macro. It's no longer used.

Link: https://lore.kernel.org/linux-clk/20220708192725.9501-1-Sergey.Semin@baikalelectronics.ru/
Changelog v7:
- Fix "Alignment should match open parenthesis" warning for the
  pr_err() method invocations. (@Philipp)
- Drop empty line from the sys_rst_info structure initialization block.
  (@Philipp)

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-clk@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (7):
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
 drivers/clk/baikal-t1/ccu-rst.c     | 217 +++++++++++++++++++++++
 drivers/clk/baikal-t1/ccu-rst.h     |  67 +++++++
 drivers/clk/baikal-t1/clk-ccu-div.c | 263 ++++++++++++++++------------
 drivers/clk/baikal-t1/clk-ccu-pll.c | 128 +++++++++++---
 drivers/clk/clk-versaclock5.c       |   2 +-
 include/dt-bindings/reset/bt1-ccu.h |   9 +
 11 files changed, 647 insertions(+), 161 deletions(-)
 create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
 create mode 100644 drivers/clk/baikal-t1/ccu-rst.h

-- 
2.35.1

