Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AAA59FD49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbiHXO3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiHXO3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:29:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E84257542;
        Wed, 24 Aug 2022 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661351355; x=1692887355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6afhEAvhEDkE/G5SdTBUp5GkN6q4ddNyAjn8YS4qkao=;
  b=PzNwvwZ5Cqh94X4Ak1e9Qe2kZDVw9LpdSdnp1UDKWTHpaC37frHF2zKa
   ciE+cS/OnFVIxL0HKfH/+ggTV1Ft6g0qQvjQhH6WaC7aHUey+XxuJVerC
   8pAD1/roRwVLBfhkx56pFqkNKuV6kBI/Oa9N7gJvL9nNmms2nn4AuwJ0u
   lt6b/zSbfDyUPlKSY5SK9p3XxT7SkKnotPBiKdit1fzBurEtyTD0W8eEu
   3wHvOXNwA9X6n9ry/p1ykgpLqEm1/VdlrPSD8nOmNiqSDLIXp6QfRWVo0
   V15/D5wwRlV2/6pslgC5wibAnAGZ6XhyFqOQpC6QZy5S5LFFB1ojitnrQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="187868677"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 07:29:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 07:29:14 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 24 Aug 2022 07:29:12 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <dragan.cvetic@xilinx.com>,
        <derek.kiernan@xilinx.com>
Subject: [PATCH v1 char-misc-next 0/5] misc: microchip: pci1xxxx: Add auxiliary bus driver and the GPIO driver for PIO function of pci1xxxx. 
Date:   Thu, 25 Aug 2022 01:30:42 +0530
Message-ID: <20220824200047.150308-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
downstream ports. PIO function is one of the functions in the
multi-function endpoint. PIO function combines a GPIO controller and also
an interface to program pci1xxxx'x OTP & EEPROM. This patch adds an
auxiliary bus driver that enumerates separate child devices for gpio and
OTP/EEPROM interface and the gpio controller driver for the first child.

Kumaravel Thiagarajan (5):
  misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO
    function in the multi-function endpoint of pci1xxxx device.
  misc: microchip: pci1xxxx: load gpio driver for the gpio controller
    auxiliary device enumerated by the auxiliary bus driver.
  misc: microchip: pci1xxxx: Add functions to configure gpio pins as
    input / output, get status, handle I/O for gpio pins.
  misc: microchip: pci1xxxx: Add gpio irq handler and irq helper
    functions irq_ack, irq_mask, irq_unmask and irq_set_type of
    irq_chip.
  misc: microchip: pci1xxxx: Add power management functions - suspend &
    resume handlers.

 MAINTAINERS                                   |   8 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   3 +-
 drivers/misc/mchp_pci1xxxx/Kconfig            |  10 +
 drivers/misc/mchp_pci1xxxx/Makefile           |   1 +
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 166 +++++++
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h |  28 ++
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c   | 438 ++++++++++++++++++
 8 files changed, 654 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/mchp_pci1xxxx/Kconfig
 create mode 100644 drivers/misc/mchp_pci1xxxx/Makefile
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c

-- 
2.25.1

