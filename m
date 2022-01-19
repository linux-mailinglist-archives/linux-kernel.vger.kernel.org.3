Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627AD493BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355141AbiASOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiASOc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:32:28 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B521DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:32:27 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x11so10228343lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NB/vQ4pMEzBEyabQQGEF0mW1uoppa6ljxHmIWmaiMMU=;
        b=TcmfJNZ45XN49S6qVu3+pGBvHpDDsGV5+10C5dJQTTRgv8Mrqk7px7RkbmQHa7Yj4V
         +BjADP9LvJ9VTzpfqUuTGkWy44yC0oYwKYqZ98Y7y5pp4HwUobhpmNOGU3roh3OPwzGz
         ZVznxZz2ylWvO6E8beMcjnDUVGUxGzFjdqePvNaGDDz55fl5U0my8gp3WazZeKUp9Y5t
         bNLxAv5XpED5j7JXpuDLPwnFYqzCVyyEgi7XYoY+lufbpGZrUFYxe81MKuD9ti5ha8+y
         iHDRjya7cXT7EZGFGJxgw7iyTTB+MIcsUGZ1NTVjVecM0vcuLFhzWKbT6ZPe6D3bNcIg
         op+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NB/vQ4pMEzBEyabQQGEF0mW1uoppa6ljxHmIWmaiMMU=;
        b=LKda6vEkaFgPoB47EOii6MEffNq/GcUEM/AEZblWAoGC6ErGidpIaXiX5XZuhh4eSK
         yhMLn2QXR+PKbB9dOgO1Vfr8/ePEiEEXXJAlfujyH6a7ybTirRp/rbmHAo/dMYMPHebG
         jzOYkreYNupcCY5UOJHa1vI6cbXKGtkgPCSP+bLObEnhkaWAK4Wu4R8aYwojoZsY24UM
         Z/icTQFn8RKe47L/bDqbndw5eP3jplZ2zSOEU5h9hgFIVVVk4GxYty+eQqeZm0uOYmtv
         0YyjnWWKkZ/Um4T3XgRW/GCKJEm6Vpd6C9u3uXsPzz5T5r0y3hFMv1ZTr+gabDWs5hql
         1y1A==
X-Gm-Message-State: AOAM533k3ulkLHsA7nalt+LgwS2qmB0MDItcgb2gwhLsVuEqBCjnVhlW
        Q2sYmjS4NRcbF9HIcUa+8UClzQ==
X-Google-Smtp-Source: ABdhPJz84y58rnuSFcOOsyInV+5CQShzojBGnQl4qUf416L86uWHT+PtC0/JfyQJvkcPYkw286uj9Q==
X-Received: by 2002:a19:7010:: with SMTP id h16mr27670537lfc.561.1642602746102;
        Wed, 19 Jan 2022 06:32:26 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id bu1sm2033020lfb.164.2022.01.19.06.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:32:25 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] irq: manage power of chip hierarchy
Date:   Wed, 19 Jan 2022 17:32:11 +0300
Message-Id: <20220119143211.633399-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of hierarchical irq domains, it can be not enough to enable
power of the topmost chip at irq request time. Need to handle entire
chip hierarchy.

This patch updates irq_chip_pm_(get|put) to do so.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 kernel/irq/chip.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index f895265d7548..d1b786f29d30 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1569,15 +1569,30 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
  */
 int irq_chip_pm_get(struct irq_data *data)
 {
+#if IS_ENABLED(CONFIG_PM)
+	struct device *dev = data->chip->parent_device;
 	int retval;
 
-	if (IS_ENABLED(CONFIG_PM) && data->chip->parent_device) {
-		retval = pm_runtime_get_sync(data->chip->parent_device);
+#if IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY)
+	if (data->parent_data) {
+		retval = irq_chip_pm_get(data->parent_data);
+		if (retval < 0)
+			return retval;
+	}
+#endif
+
+	if (dev) {
+		retval = pm_runtime_get_sync(dev);
 		if (retval < 0) {
-			pm_runtime_put_noidle(data->chip->parent_device);
+			pm_runtime_put_noidle(dev);
+#if IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY)
+			if (data->parent_data)
+				irq_chip_pm_put(data->parent_data);
+#endif
 			return retval;
 		}
 	}
+#endif	/* CONFIG_PM */
 
 	return 0;
 }
@@ -1594,8 +1609,24 @@ int irq_chip_pm_put(struct irq_data *data)
 {
 	int retval = 0;
 
-	if (IS_ENABLED(CONFIG_PM) && data->chip->parent_device)
-		retval = pm_runtime_put(data->chip->parent_device);
+#if IS_ENABLED(CONFIG_PM)
+	do {
+		struct device *dev = data->chip->parent_device;
+		int retval2;
+
+		if (dev) {
+			retval2 = pm_runtime_put(dev);
+			if (retval == 0 && retval2 < 0)
+				retval = retval2;
+		}
+
+#if IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY)
+		data = data->parent_data;
+#else
+		data = NULL;
+#endif
+	} while (data);
+#endif	/* CONFIG_PM */
 
-	return (retval < 0) ? retval : 0;
+	return retval;
 }
-- 
2.30.2

