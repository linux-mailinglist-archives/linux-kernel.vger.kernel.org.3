Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29A75A7F54
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiHaNyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiHaNyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:54:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2C1D5DF8;
        Wed, 31 Aug 2022 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661954063; x=1693490063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gyEojnlQjCe3v5sdt3k5m72tiWFtmQ8vuKeg6aSWPto=;
  b=wnBS6XzH4gUOQK6M8bN8SRYyj2F4MaVn7wxk3LjzoVYRYo59C3YD07sN
   yR1ZL8sm+rUhnKBnfqIpoFYQ46+nn2SQ9fKDtMPFbtBcPgx6dTKy1VIox
   O0gIO4EzL9u1iT5QJBFjG6zRf0DDf535lJqEX7O7yL8he1VOwE88TmuE5
   0DUXKbigozrRNL1/RO4ZDVs3NQkOperW8j9PNPY+fM3o9cYslnkFujCv4
   QudJxftdGrHiKSJlwnB4G6l+Xn4Wu5o+3MGgFC6DayVWFKYm6Gy6LnLl9
   YsyTDBQ5sRbRcIc9U2kWoSiAmXRIH0frBuPlh04r1yUgtQRXQNyEwMLxO
   w==;
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="188825298"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 06:54:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 06:54:21 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 06:54:19 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] pinctrl: at91: cleanups
Date:   Wed, 31 Aug 2022 16:56:33 +0300
Message-ID: <20220831135636.3176406-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Machine specific PM code was calling gpio driver specific code to enable
wakeup interrupts. Moved this code to the pinctrl-at91 driver as close
as possible to the moment machine specific code is executed (in .noirq
member of struct dev_pm_ops). The code has been tested on sama5d2_xplained,
sama5d3_xplained, sam9x60ek, sama7g5ek.

Along with it added 2 cleanups.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  pinctrl: at91: use kernel-doc style for documentation of
    at91_gpio_chip
  pinctrl: at91: move gpio suspend/resume calls to driver's context
  pinctrl: at91: use dev_dbg() instead of printk()

 arch/arm/mach-at91/pm.c        |  15 -----
 drivers/pinctrl/pinctrl-at91.c | 105 +++++++++++++++++----------------
 include/soc/at91/pm.h          |  16 -----
 3 files changed, 55 insertions(+), 81 deletions(-)
 delete mode 100644 include/soc/at91/pm.h

-- 
2.34.1

