Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED17460F53
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhK2Hch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:32:37 -0500
Received: from forward100o.mail.yandex.net ([37.140.190.180]:51296 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231872AbhK2Hag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:30:36 -0500
Received: from iva4-d8b0e1d849e5.qloud-c.yandex.net (iva4-d8b0e1d849e5.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:825:0:640:d8b0:e1d8])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 948ED52AA678;
        Mon, 29 Nov 2021 10:27:13 +0300 (MSK)
Received: from iva6-2d18925256a6.qloud-c.yandex.net (iva6-2d18925256a6.qloud-c.yandex.net [2a02:6b8:c0c:7594:0:640:2d18:9252])
        by iva4-d8b0e1d849e5.qloud-c.yandex.net (mxback/Yandex) with ESMTP id xdeE83QEUJ-RDC0OG9d;
        Mon, 29 Nov 2021 10:27:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1638170833;
        bh=JYQsy4mOX+raRW9UXfPNZdvs9lW5+P8ca7w6o6pREMY=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=mwT4VtTil47JBnyhUQH5ovT0MLlTcsk3JDXfiJ0DmXJ5h3cZqk9EVR9jKJDuES55s
         fjDLihf0XP42qvC1XU3R2TIxWG5qpF++EtC/RhAI8uU48qx/Ag4coC8KEDhIOTDQGQ
         /7E5F4e+X7gnEAiELQewkG2vDnJnNUWB7FTbrodQ=
Authentication-Results: iva4-d8b0e1d849e5.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva6-2d18925256a6.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id wqH2Ri6STH-RCLicaq7;
        Mon, 29 Nov 2021 10:27:12 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Support Opensource <support.opensource@diasemi.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rtc: da9063: add as wakeup source
Date:   Mon, 29 Nov 2021 10:26:49 +0300
Message-Id: <20211129072650.22686-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As da9063 RTC is not a real I2C client, but relies on da9063 MFD 
driver, we need to explicitly mark da9063 RTC as a wakeup source 
to be able to access class/rtc/rtcN/wakealarm sysfs entry 
to set alarms, so we can wakeup from SHUTDOWN/RTC/DELIVERY mode.

As da9063 driver refuses to load without irq, we simply add it 
as a wakeup source before registering rtc device.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
v2->v3:
Adam Thomson:
Commit message more verbose.
---
 drivers/rtc/rtc-da9063.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index d4b72a9fa2ba..b9a73356bace 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -494,6 +494,8 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d: %d\n",
 			irq_alarm, ret);
 
+	device_init_wakeup(&pdev->dev, true);
+
 	return devm_rtc_register_device(rtc->rtc_dev);
 }
 
-- 
2.31.1

