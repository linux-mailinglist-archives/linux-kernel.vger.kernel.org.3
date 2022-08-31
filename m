Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DC65A7F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiHaNy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiHaNyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:54:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF5F3E;
        Wed, 31 Aug 2022 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661954090; x=1693490090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EPcDBYeJU+l5J9XRw8iQR5txXkoz1uF+BFazkk+GgL4=;
  b=WU3yzkJ6pxqkicY1/SV+fq4qpCtt5p92Un0RGmMtLZcBR7KUaoTIcR5F
   oVbC3bLaYq/Xcru0yBncwT91e7WIx/0oi90YBLL/yLuyhHHosL9ZtkeoF
   n33+nXHxpnboZTSlVml1nHaDqMYuCtZMNB7zPoSYaSk8HovfB9puBL6ym
   a7OTLcH/IzIge9JnCaMscpium1uY0Y0AEf2/UnsALlnOG9pBMyWI1E7II
   n/A/fthUS9CZzXMJfD9e0zfEHKW/iWoC9wQ/1XXZAUsFKbgxxAnrMwcK3
   v0Ia+PO4AUWepsnQ39wjEph+ItSNElD/ynWVLjel/vZr4dizKpAx8UjJf
   w==;
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="178614949"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 06:54:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 06:54:29 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 06:54:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] pinctrl: at91: use dev_dbg() instead of printk()
Date:   Wed, 31 Aug 2022 16:56:36 +0300
Message-ID: <20220831135636.3176406-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220831135636.3176406-1-claudiu.beznea@microchip.com>
References: <20220831135636.3176406-1-claudiu.beznea@microchip.com>
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

Use dev_dbg() instead of printk(KERN_DEBUG) to avoid the following
checkpatch.pl warning:
"Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ... then
dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...".

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 631a6289c2b6..81dbffab621f 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1659,8 +1659,8 @@ static int at91_gpio_suspend(struct device *dev)
 	if (!at91_chip->wakeups)
 		clk_disable_unprepare(at91_chip->clock);
 	else
-		printk(KERN_DEBUG "GPIO-%c may wake for %08x\n",
-		       'A' + at91_chip->id, at91_chip->wakeups);
+		dev_dbg(dev, "GPIO-%c may wake for %08x\n",
+			'A' + at91_chip->id, at91_chip->wakeups);
 
 	return 0;
 }
-- 
2.34.1

