Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716875163EB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbiEALAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 07:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242879AbiEALAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:00:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D021E21
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 03:57:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n18so10540133plg.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 03:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ref09pVzmKehKJLaE3ql7rgQqo+jRk+JJ3BJb/yQNDo=;
        b=EIiptmIOKoBAtGUjy79Rt6qQSdXP4sps+nmcDoC+HGp6BYYOOIzpc4iG104sUaHPbg
         9HqBOLWttihdDo0Pr+hUp3DUdBQZsgfgIFaT5kWRyPAKgVsLsW9Hl2LAWoWg+yI0idSC
         9im+lU6Cs36BZXmCopazdDCAAYi6otrXiaqk9HN47M25aME4JMxCLNr8gCf4NEhar3VO
         7UKoqS0VmExOrUdn3sYNl2cp1pNJamlw8158Aui8lsw5yT8pdWtIgIwmZvuYy9QoOwVC
         St+PouMioyuXozPKfXhQEY6B/YnXOLsw2EBWy7gVmYexthMZjTfcujQ3CkaHct4M4GQ1
         vpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ref09pVzmKehKJLaE3ql7rgQqo+jRk+JJ3BJb/yQNDo=;
        b=PnPSCS9YQEUtzx22Ka+BHd1w25s/BMK6RieWf/JmCeIaD4bFu/4qygdVeL8BX45wIS
         FmS5dojsUehFHr0A94kiPWuV8mSnf6E1aKOWtLxIa/gFPfaOofRMR/oBEkhegZIA5RHP
         5LlYFMEAnajbTK1hCV56rUTKRzyxUi24XtOwS1Enh+4gjkLscwVJu6xVlxgWDH/SKlFT
         WBl9UBwk+5x7PoM2hktK9wL7p6IQKap7MCXM4HnDrsEuU1bY2I2qr9Zg8VZJhEWXIvHQ
         JxTYQM7MOg4BZPzwXgZiSq6sMPN6/XJCIAjwn4EtKymeyIZw33F5Q6g3EY3AtFBrnHbb
         jRBw==
X-Gm-Message-State: AOAM533AbgjVwB668vqkg0f+i9N4aZBQGNr5nhDOjNl2pg5BFKCAJDyo
        f0qgebmDg6+MIJbaRyimpurJ4Q==
X-Google-Smtp-Source: ABdhPJxXhYMF5cj6UvI5DKwEl9ozDUat1mEVxojaSzu68hCpYfpsnF7sdxQri4SH/D0isUTD91DS/w==
X-Received: by 2002:a17:90a:a58d:b0:1db:ed34:e46d with SMTP id b13-20020a17090aa58d00b001dbed34e46dmr12731557pjq.124.1651402626080;
        Sun, 01 May 2022 03:57:06 -0700 (PDT)
Received: from localhost ([49.7.45.235])
        by smtp.gmail.com with ESMTPSA id g11-20020aa7818b000000b0050dc76281d5sm2811611pfi.175.2022.05.01.03.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 03:57:05 -0700 (PDT)
From:   Jian Zhang <zhangjian.3032@bytedance.com>
To:     openbmc@lists.ozlabs.org, joel@jms.id.au, clg@kaod.org
Cc:     zhangjian_linux@163.com, Jian Zhang <zhangjian.3032@bytedance.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org (open list),
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT),
        linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT)
Subject: [PATCH linux dev-5.15] soc: aspeed: abr: Add sysfs attrs for flash toggle
Date:   Sun,  1 May 2022 18:56:44 +0800
Message-Id: <20220501105644.355062-1-zhangjian.3032@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the flash toggle function in soc ast2600.
Add two sysfs attrs named "access_primary" and "access_backup"

attr "access_primary": Appears only in the backup flash startup
store: Non-zero values will clear "Boot Flash source select indicator"
to '0', the next reboot will boot from primary flash. Nothing will be
done at 0.
show: 0 means the next reboot will boot from primary, 1 will boot from
backup.

attr "access_backup": Appears only in the primary flash startup
store: Non-zero values are the timeout time for abr WDT, WDT will be
turned on immediately if written. The maximum value is 0x3ff, and unit
is "0.1s". zero value will disable WDT.
show: the time left(unit is 0.1s) in WDT timer. 0 means timer is not
enabled. Thus, A non-zero value means that waiting until the WTD times
out will automatically start from the backup.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 drivers/spi/spi-aspeed.c              | 62 ++++++++++++++++++
 include/linux/soc/aspeed/aspeed-abr.h | 93 +++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 include/linux/soc/aspeed/aspeed-abr.h

diff --git a/drivers/spi/spi-aspeed.c b/drivers/spi/spi-aspeed.c
index 909b5fb175d6..abe3bfe2bd42 100644
--- a/drivers/spi/spi-aspeed.c
+++ b/drivers/spi/spi-aspeed.c
@@ -24,6 +24,7 @@
 #include <linux/sizes.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/soc/aspeed/aspeed-abr.h>
 
 /* ASPEED FMC/SPI memory control register related */
 #define OFFSET_CE_TYPE_SETTING		0x00
@@ -127,6 +128,54 @@ struct aspeed_spi_controller {
 	spinlock_t lock;
 };
 
+static ssize_t access_primary_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct aspeed_spi_controller *ast_ctrl = dev_get_drvdata(dev);
+
+	return _access_primary_show(ast_ctrl->regs, attr, buf);
+}
+
+static ssize_t access_primary_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	struct aspeed_spi_controller *ast_ctrl = dev_get_drvdata(dev);
+
+	return _access_primary_store(ast_ctrl->regs, attr, buf, size);
+}
+
+static ssize_t access_backup_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct aspeed_spi_controller *ast_ctrl = dev_get_drvdata(dev);
+
+	return _access_backup_show(ast_ctrl->regs, attr, buf);
+}
+
+static ssize_t access_backup_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t size)
+{
+	struct aspeed_spi_controller *ast_ctrl = dev_get_drvdata(dev);
+
+	return _access_backup_store(ast_ctrl->regs, attr, buf, size);
+}
+
+static DEVICE_ATTR_RW(access_primary);
+static DEVICE_ATTR_RW(access_backup);
+
+static struct attribute *bswitch_primary_attrs[] = {
+	&dev_attr_access_primary.attr, NULL
+};
+
+static struct attribute *bswitch_backup_attrs[] = {
+	&dev_attr_access_backup.attr, NULL
+};
+
+ATTRIBUTE_GROUPS(bswitch_primary);
+ATTRIBUTE_GROUPS(bswitch_backup);
+
 static uint32_t
 aspeed_2600_spi_segment_start(struct aspeed_spi_controller *ast_ctrl,
 			      uint32_t reg)
@@ -1393,6 +1442,19 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto end;
 
+	if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-fmc")) {
+		/* if boot from alt source, show access_primary, otherwise show access_backup */
+		if (readl(ast_ctrl->regs + OFFSET_ABR_CTRL_STATUS) &
+		    ABR_BOOT_SRC_INDICATE) {
+
+			if (devm_device_add_groups(dev, bswitch_primary_groups))
+				dev_warn(dev, "Could not add access_primary\n");
+		} else {
+			if (devm_device_add_groups(dev, bswitch_backup_groups))
+				dev_warn(dev, "Could not add access_backup\n");
+		}
+	}
+
 	ret = devm_spi_register_master(dev, spi_ctrl);
 
 end:
diff --git a/include/linux/soc/aspeed/aspeed-abr.h b/include/linux/soc/aspeed/aspeed-abr.h
new file mode 100644
index 000000000000..3542f76e0232
--- /dev/null
+++ b/include/linux/soc/aspeed/aspeed-abr.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ASPEED_ABR_H__
+#define __ASPEED_ABR_H__
+
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/io.h>
+
+#define OFFSET_ABR_CTRL_STATUS 0x64
+#define OFFSET_ABR_TIMER_RELOAD 0x68
+#define OFFSET_ABR_TIMER_RESTART 0x6c
+
+#define ABR_WDT_ENABLE BIT(0)
+#define ABR_BOOT_SRC_INDICATE BIT(4)
+#define ABR_RESTART_MAGIC 0x4755
+#define ABR_CLEAR_BOOT_SRC_MAGIC (0xEA << 16)
+#define ABR_RELOAD_MAX_VALUE 0x3ff
+
+static inline ssize_t _access_primary_show(void __iomem *regs,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	u32 status = readl(regs + OFFSET_ABR_CTRL_STATUS);
+
+	return sysfs_emit(buf, "%u\n", !(status & ABR_BOOT_SRC_INDICATE));
+}
+
+static inline ssize_t _access_primary_store(void __iomem *regs,
+					    struct device_attribute *attr,
+					    const char *buf, size_t size)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	/* write bit[23:16] = 0xEA */
+	if (val)
+		writel(readl(regs + OFFSET_ABR_CTRL_STATUS) |
+			       ABR_CLEAR_BOOT_SRC_MAGIC,
+		       regs + OFFSET_ABR_CTRL_STATUS);
+
+	return size;
+}
+
+static inline ssize_t _access_backup_show(void __iomem *regs,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	u32 status = readl(regs + OFFSET_ABR_CTRL_STATUS);
+	u32 timer_reload = readl(regs + OFFSET_ABR_TIMER_RELOAD);
+
+	if (!(status & ABR_WDT_ENABLE))
+		return sysfs_emit(buf, "%u\n", 0);
+	/* [31:16] Counter value status */
+	return sysfs_emit(buf, "%u\n", timer_reload >> 16);
+}
+
+static inline ssize_t _access_backup_store(void __iomem *regs,
+					   struct device_attribute *attr,
+					   const char *buf, size_t size)
+{
+	unsigned long count;
+
+	if (kstrtoul(buf, 10, &count))
+		return -EINVAL;
+
+	/* disable watchdog */
+	if (count == 0) {
+		writel(0, regs + OFFSET_ABR_CTRL_STATUS);
+		return size;
+	}
+
+	/*
+	 * bit[12:0] : Reload value of expire time
+	 * The time unit is 0.1 second. Default set at 22 seconds
+	 * 0: Immediately timeout
+	 */
+	count = count < ABR_RELOAD_MAX_VALUE ? count : ABR_RELOAD_MAX_VALUE;
+
+	writel(0, regs + OFFSET_ABR_CTRL_STATUS);
+	writel(count, regs + OFFSET_ABR_TIMER_RELOAD);
+
+	/* Write 0x4755 value to load the reload value into watchdog counter */
+	writel(ABR_RESTART_MAGIC, regs + OFFSET_ABR_TIMER_RESTART);
+
+	/* Enable watchdog */
+	writel(ABR_WDT_ENABLE, regs + OFFSET_ABR_CTRL_STATUS);
+	return size;
+}
+
+#endif
-- 
2.25.1

