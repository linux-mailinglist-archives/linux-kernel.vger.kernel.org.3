Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB8F4D3547
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiCIQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbiCIQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:03 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E631A9E34;
        Wed,  9 Mar 2022 08:23:17 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6DAD124000E;
        Wed,  9 Mar 2022 16:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646842995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZTvslklp3c1o8lr+/78tGD5AYGEYrysKlxh3WZn15s=;
        b=oEXCiR9QBxEZaq+iKP0/y2R6V8ZwrCqwNzVmOQKofHCpB/HEgEeMXo4+h1iM/ufbk4nz4g
        qlZxP+opKaE/HGQ/XbhOK5z/NQUydyYnmtLCYroyy3uRsUisBogOcNb7hErIR3/7HeWLsC
        BGeR6eI+bVdFJ0l3663XZltUhj/DkFE9inOrVyvTiZK9F6xjgL66+Y7nWqjcCkyvTYsCzg
        uInZGVsS8ZhAfBUTXXI/jJoErkBexCaLuymNeu3gfT94NMBms2jeciByCd7ZnIcp8/Sj19
        +Ep7Fmobtz80+8FUiQD7VvdtpuNGZ5QOyvCLPas65IzKen7gP7umMUPUC0r08Q==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Joshua Kinard <kumba@gentoo.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/29] rtc: ds1685: drop no_irq
Date:   Wed,  9 Mar 2022 17:22:33 +0100
Message-Id: <20220309162301.61679-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No platforms are currently setting no_irq. Anyway, letting platform_get_irq
fail is fine as this means that there is no IRQ. In that case, clear
RTC_FEATURE_ALARM so the core knows there are no alarms.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1685.c   | 14 +++++---------
 include/linux/rtc/ds1685.h |  1 -
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 0ec1e44e3431..a24331ba8a5f 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1285,13 +1285,10 @@ ds1685_rtc_probe(struct platform_device *pdev)
 	 * there won't be an automatic way of notifying the kernel about it,
 	 * unless ctrlc is explicitly polled.
 	 */
-	if (!pdata->no_irq) {
-		ret = platform_get_irq(pdev, 0);
-		if (ret <= 0)
-			return ret;
-
-		rtc->irq_num = ret;
-
+	rtc->irq_num = platform_get_irq(pdev, 0);
+	if (rtc->irq_num <= 0) {
+		clear_bit(RTC_FEATURE_ALARM, rtc_dev->features);
+	} else {
 		/* Request an IRQ. */
 		ret = devm_request_threaded_irq(&pdev->dev, rtc->irq_num,
 				       NULL, ds1685_rtc_irq_handler,
@@ -1305,7 +1302,6 @@ ds1685_rtc_probe(struct platform_device *pdev)
 			rtc->irq_num = 0;
 		}
 	}
-	rtc->no_irq = pdata->no_irq;
 
 	/* Setup complete. */
 	ds1685_rtc_switch_to_bank0(rtc);
@@ -1394,7 +1390,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 		 * have been taken care of by the shutdown scripts and this
 		 * is the final function call.
 		 */
-		if (!rtc->no_irq)
+		if (rtc->irq_num)
 			disable_irq_nosync(rtc->irq_num);
 
 		/* Oscillator must be on and the countdown chain enabled. */
diff --git a/include/linux/rtc/ds1685.h b/include/linux/rtc/ds1685.h
index 67ee9d20cc5a..5a41c3bbcbe3 100644
--- a/include/linux/rtc/ds1685.h
+++ b/include/linux/rtc/ds1685.h
@@ -46,7 +46,6 @@ struct ds1685_priv {
 	u32 regstep;
 	int irq_num;
 	bool bcd_mode;
-	bool no_irq;
 	u8 (*read)(struct ds1685_priv *, int);
 	void (*write)(struct ds1685_priv *, int, u8);
 	void (*prepare_poweroff)(void);
-- 
2.35.1

