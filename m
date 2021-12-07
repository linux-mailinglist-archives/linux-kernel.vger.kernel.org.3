Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F157346B9E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhLGLSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:18:53 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:26994 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbhLGLSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638875722; x=1670411722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9qYB80hScFkXpiYvKb6UCDSX8uejBN7hKCwArmXjPoY=;
  b=bfhtOLKBUA8cPXMAvGmUZO8ALtHqEbB/FpYEFy4KmQJhEGzwnBq5BKuh
   N8+8UBrBDFoc/CIrdyVrxyxK2L/hbtJcu1w5AHxk7p8kGNx0KoPr5mVHt
   /MSd2IRe8eo1RT/szN39eXMjU7T52gOh/MEbQwBsQoYlLwAY4Q1Y7RfE+
   I+62yyoGEf61d0H1bFU4lHpA2+CyFQ5reRFyfjIA0I7si9Y2Fs5czQk4g
   s+S1ErSWw2nsqJMXAvxlemk7itIfh0OcixrqtBjba+g238x1nOq70q0QO
   IQ+bwQJZ305AMTNeYzAn9vI1wVpMbiprIyaUbftNfBvy2jzjzPky9p5+S
   g==;
IronPort-SDR: MmF0tna9UBxO1jKpwl/sUW+vKGa4LNSJayH6SxMlu4uJ89+4/abZ6G9NnIIhDHnHhVsGybsJRL
 araDDaryTkJXP4TcP06M6IqgIKgGHRjQlZrNtkWXqH8gnnDBIJkARIeMcZ2rz+N/ZW09kNi5aX
 rzhnMhUeYOfilOLPCgypVCJeYfZVykl8iR1hKHoQHslwy4ic4FmEiFbk83amnW7sR90/Ql6OUy
 hqsa5keZSI4h87qR4rupiQRSHXP9RPua7/t68T6MZhjuHyKxsf9DRrn6XqxxcZv48tME9P2HvL
 X2GsSdAZZcN7B9Aeryh9sziX
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="138939133"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2021 04:15:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Dec 2021 04:15:21 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 7 Dec 2021 04:15:19 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lee.jones@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mfd: atmel-flexcom: fix compilation warning
Date:   Tue, 7 Dec 2021 13:15:15 +0200
Message-ID: <20211207111515.814653-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "unused variable 'atmel_flexcom_pm_ops' [-Wunused-const-variable]"
compilation warning by using __maybe_unused on PM ops.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mfd/atmel-flexcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index 559eb4d352b6..33caa4fba6af 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -105,7 +105,7 @@ static int __maybe_unused atmel_flexcom_resume_noirq(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops atmel_flexcom_pm_ops = {
+static const struct dev_pm_ops __maybe_unused atmel_flexcom_pm_ops = {
 	.resume_noirq = atmel_flexcom_resume_noirq,
 };
 
-- 
2.32.0

