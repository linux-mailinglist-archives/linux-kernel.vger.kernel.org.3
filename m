Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC604932B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350878AbiASCJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:09:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35102 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348213AbiASCI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:08:57 -0500
X-UUID: ac524a30fcce437b86ab5caa99937360-20220119
X-UUID: ac524a30fcce437b86ab5caa99937360-20220119
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 769824493; Wed, 19 Jan 2022 10:08:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 19 Jan 2022 10:08:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 10:08:52 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Sneddon <dan.sneddon@microchip.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Miles Chen" <miles.chen@mediatek.com>
Subject: [PATCH] usb: gadget: at91_udc: fix incorrect print type
Date:   Wed, 19 Jan 2022 10:08:49 +0800
Message-ID: <20220119020849.25732-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a build error observed with ARCH=arm DEFCONFIG=allmodconfig build.

drivers/usb/gadget/udc/at91_udc.h:174:42: error: format '%d' expects argument of type 'int', but argument 3 has type 'struct gpio_desc *' [-Werror=format=]

Fixes: 4a555f2b8d31 ("usb: gadget: at91_udc: Convert to GPIO descriptors")
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/usb/gadget/udc/at91_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index dd0819df096e..9040a0561466 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1895,7 +1895,7 @@ static int at91udc_probe(struct platform_device *pdev)
 					at91_vbus_irq, 0, driver_name, udc);
 			if (retval) {
 				DBG("request vbus irq %d failed\n",
-				    udc->board.vbus_pin);
+				    desc_to_gpio(udc->board.vbus_pin));
 				goto err_unprepare_iclk;
 			}
 		}
-- 
2.18.0

