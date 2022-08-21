Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE4C59B415
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 15:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiHUNqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 09:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHUNp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 09:45:59 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67BC23149;
        Sun, 21 Aug 2022 06:45:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y15so4125537pfr.9;
        Sun, 21 Aug 2022 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=YaBTeAafTRL6hxHrFujveUD7vI1ESzxhlR0TC9XQmVg=;
        b=DhnmJDYNDV2sGnrwSFyIk/BKSuKElPJXCyBchKnCDlz74WBcHuSrYnpfeIPDXZELZc
         1+UXu27cFPuh9sSVZhpZYSfHhAZayC9UgTYhEGC8aukvb7hYLQhLSZUt5QQcewvVe9iN
         fyd7o0ofG54I2KKHYiYp3SxbjsIty8477yWwsvdph1c7hjPyOPDNY3PuQgbahbtIp2s9
         jMXylXmv4fUaVJu76rLIrYLHhryGU9+PCseAbQbo5FN5E4p2gbypyTB7z4TKilYiTNTg
         OfaZLnApxhK94Fln4M7Hd/byqH9bht+YSQQ98b0iIIb4osnVL/6eER2uTXB8HfJB7L1b
         pDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=YaBTeAafTRL6hxHrFujveUD7vI1ESzxhlR0TC9XQmVg=;
        b=nrAjh3GX9xrZtSU5cOQe3NzZ3j3rFavDYSqSynyTuhqtiKcRFF+bonGujOtEJXdhoG
         thXjuedfy47/v68Sa+H5rzJMFrkTwYSqh3XgVapmsFwW99ZH25Te2n5tYXy/N+j8PRyg
         7eNcmeNUrYd/EkBYLLaFbTYAGTylw/ljx71RcknqXwVTf70g3AMfFcJvbzNwqiJldUeq
         /nHDE4cmnPVmsVzlwHv3ZXhhqLsRdevZb67tSOIZeGz7tPhIphfKbHxznYRxvLvGeyEr
         SHPCqJlC9Hd3mAs+Q4a9c4ow22ULbMyUeAxKeaAUqSTn2vFOJSsJ5b43Yz5NtD7JoQSy
         9vmQ==
X-Gm-Message-State: ACgBeo1AhGpHM449UZyLpN+fdrQOOc1rNBrAYj7JAOrSWE/6avJ1eVQY
        EtW8SiNPMg2MB+9lrfsp7ps=
X-Google-Smtp-Source: AA6agR4uz0BnklkpxqfVjpnqjZi2hV704rINDVyLzaGJKTcJC1s015zV/C9fI1LqD9jI5diNWlBskw==
X-Received: by 2002:a62:1795:0:b0:536:4e84:5ee9 with SMTP id 143-20020a621795000000b005364e845ee9mr6825115pfx.52.1661089558033;
        Sun, 21 Aug 2022 06:45:58 -0700 (PDT)
Received: from DESKTOP-KA7F9LU.localdomain ([49.207.231.90])
        by smtp.googlemail.com with ESMTPSA id d5-20020a623605000000b0052b94e757ecsm6700672pfa.213.2022.08.21.06.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:45:56 -0700 (PDT)
From:   Vimal Kumar <vimal.kumar32@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     chinmoyghosh2001@gmail.com, Vimal Kumar <vimal.kumar32@gmail.com>,
        Mintu Patel <mintupatel89@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] PM: runtime: Add support to disable wakeup sources
Date:   Sun, 21 Aug 2022 19:15:32 +0530
Message-Id: <20220821134533.22901-1-vimal.kumar32@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User could find many wakeup sources available in the bsp, which
they won't be using. Currently users can only get the status and
list of enabled wakeup sources, but users can't disable it runtime.
It's very difficult to find the driver for each wakeup sources from
where it's getting enabled and make the changes for disabling it.

This will help users to disable any wakeup sources at runtime,
avoiding any code change and re-compilation. A new class attribute
"disable_ws" will be added in the wakeup calss. If user want to disable
any wakeup sources, user need to find the wakeup dev node associated
with the particular wakeup source and write the devnode name to the
class attribute "disable_ws".

Example:
Need to disable the wakeup source '1c08000.qcom,pcie'. The dev node
associated with this wakeup source is:
cat /sys/class/wakeup3/name ==> "1c08000.qcom,pcie", then for disabling
this wakeup source :
	echo wakeup3 > /sys/class/wakeup/disable_ws

Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
Co-developed-by: Vishal Badole <badolevishal1116@gmail.com>
Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
---
 drivers/base/power/wakeup_stats.c | 63 ++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index 924fac493c4f..ad30e97f168b 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -15,6 +15,7 @@
 #include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
+#include <linux/uaccess.h>
 
 #include "power.h"
 
@@ -208,9 +209,69 @@ void wakeup_source_sysfs_remove(struct wakeup_source *ws)
 	device_unregister(ws->dev);
 }
 
+static ssize_t disable_ws_store(struct class *class,
+				struct class_attribute *attr,
+				const char *buf, size_t len)
+{
+	struct device		*dev;
+	struct wakeup_source	*ws;
+	char                    *ws_name;
+	int                     status;
+
+	ws_name = kzalloc(sizeof(*(buf)), GFP_KERNEL);
+	if (!ws_name)
+		return -ENOMEM;
+
+	if (copy_from_user(ws_name, buf, sizeof(*(buf))))
+		return -EFAULT;
+
+	dev = class_find_device_by_name(wakeup_class, ws_name);
+	if (!dev)
+		pr_err("%s : %s dev not found\n", __func__, ws_name);
+
+	ws = dev_get_drvdata(dev);
+	if (ws->dev->parent != NULL) {
+
+		status = device_wakeup_disable(ws->dev->parent);
+		if (status < 0) {
+			/* In case of virtual device, return code will be -EINVAL
+			 * then unregister the wakeup source associated with it
+			 */
+			wakeup_source_unregister(ws);
+		}
+	} else
+		/* If the parent device is NULL, just unregister the wakeup source */
+		wakeup_source_unregister(ws);
+
+	return len;
+}
+
+static CLASS_ATTR_WO(disable_ws);
+
+static struct attribute *wakeup_class_attrs[] = {
+	&class_attr_disable_ws.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(wakeup_class);
+
 static int __init wakeup_sources_sysfs_init(void)
 {
-	wakeup_class = class_create(THIS_MODULE, "wakeup");
+	int status;
+
+	wakeup_class = kzalloc(sizeof(*wakeup_class), GFP_KERNEL);
+	if (!wakeup_class)
+		return -ENOMEM;
+
+	wakeup_class->name = "wakeup";
+	wakeup_class->owner = THIS_MODULE;
+	wakeup_class->class_groups = wakeup_class_groups;
+
+	status = class_register(wakeup_class);
+
+	if (status < 0) {
+		pr_err("%s: class register failed %d\n", __func__, status);
+		return status;
+	}
 
 	return PTR_ERR_OR_ZERO(wakeup_class);
 }
-- 
2.25.1

