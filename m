Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA635A1809
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbiHYRfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242577AbiHYRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:35:18 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92634A803;
        Thu, 25 Aug 2022 10:35:16 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f4so16645471pgc.12;
        Thu, 25 Aug 2022 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=G4/totSXnLF4OIexpkONKiVFqcUNM6MV/u0KynK+Ngw=;
        b=KzJQ0G+219CI0rf2+YYLdSHRNlmcUIv8amjH7VFxdu55tS8n3CrqE6RQLvF61ytAiN
         SBgfiLyqfO9mMjbxWmTcS/I61O5KlJYlLDTVYBySdnSWVvKBZvIrR1Ym3BjnHc7F1eVb
         yL4IVn2l9sLadtLS6rWsF3aShUhyga/fZPGC4dSUi/0G2d9O3cb6X/P/bxvjUPYkcCQa
         RWhXt3mztUOTKZkUf4MbLUZIOEhJF8SlVnIaUFseQynWqhoxe0aipU9f593yk8rSz6Lo
         JuV2yQq5Zy6AH799+nSIN5b8Wp7yULiBVy97W3aHw1+ZPBikX4/TXI+DajAr3fyVTpKK
         ey+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=G4/totSXnLF4OIexpkONKiVFqcUNM6MV/u0KynK+Ngw=;
        b=elgHIzTBqjkjG28rQA2xpcuzN5Ng06jhHbWBkxoqCxQEB1Z2sej0LWJemluaPHJCsD
         WYYgV3yS50SjS761/lfWtqIiX81kN5dTsSYK3YFpEW9U1vsm4ldSDZZrEdOUVNEd+5ue
         BEfHiX/lWPaQmXoHvOABmqPbFVQajIWbRsTJ4qZ0aN/TQUhr0We5ddAl+ALJXesZ5FAW
         +UDi8qRbHd0NZ5oRr4m7dH6bIhEAm19LEdd/rbVb95NZVBEqeUeFMc3XcCqlSWou8tCa
         4IPj20jF1YkTj1aW138Bd19iShcu0jEyuJ/ZxdlflQqxmyD8TSSbsvkbGhmvk0DmiIcd
         HTqQ==
X-Gm-Message-State: ACgBeo092NlMAD4cT1QLRT6fVPHzn9is57K8xPB30DAiCUJuaVjw4k6D
        zOftWjwb4MiYIFuTKij2SNs=
X-Google-Smtp-Source: AA6agR6QqA2E2sYym2KZRyGTf9HFsQrvhZKE8JqQlg4PKzKbVlup5/Vgk+L9aIprKB6N2L7KFxg6FA==
X-Received: by 2002:a05:6a00:850:b0:536:341b:99b7 with SMTP id q16-20020a056a00085000b00536341b99b7mr61373pfk.47.1661448916001;
        Thu, 25 Aug 2022 10:35:16 -0700 (PDT)
Received: from DESKTOP-KA7F9LU.localdomain ([223.186.22.215])
        by smtp.googlemail.com with ESMTPSA id w7-20020a170902e88700b001725d542190sm15170110plg.181.2022.08.25.10.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:35:15 -0700 (PDT)
From:   Vimal Kumar <vimal.kumar32@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     chinmoyghosh2001@gmail.com, Vimal Kumar <vimal.kumar32@gmail.com>,
        Mintu Patel <mintupatel89@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2] PM: runtime: Add support to disable wakeup sources
Date:   Thu, 25 Aug 2022 23:04:41 +0530
Message-Id: <20220825173457.23298-1-vimal.kumar32@gmail.com>
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
 Documentation/ABI/testing/sysfs-class-wakeup | 16 +++++
 drivers/base/power/wakeup_stats.c            | 65 +++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-wakeup b/Documentation/ABI/testing/sysfs-class-wakeup
index 754aab8b6dcd..75b9a6fe737a 100644
--- a/Documentation/ABI/testing/sysfs-class-wakeup
+++ b/Documentation/ABI/testing/sysfs-class-wakeup
@@ -74,3 +74,19 @@ Contact:	Tri Vo <trong@android.com>
 Description:
 		The file contains the total amount of time this wakeup source
 		has been preventing autosleep, in milliseconds.
+
+What:		/sys/class/wakeup/disable_ws
+Date:		Aug 2022
+Contact:	Vimal Kumar <vimal.kumar@gmail.com>
+Description:
+		This file can be used to disable a wakeup source at runtime.
+		If user want to disable any wakeup sources, user need to find
+		the wakeup dev node associated with the particular wakeup source
+		and write the devnode name to this file "disable_ws".
+
+		Example:
+		If user Need to disable the wakeup source '1c08000.qcom,pcie', and
+		the wakeup dev node associated with this wakeup source is:
+			cat /sys/class/wakeup3/name ==> "1c08000.qcom,pcie"
+		Then for disabling this wakeup source :
+			echo wakeup3 > /sys/class/wakeup/disable_ws
diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index 924fac493c4f..497402a28028 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -15,6 +15,7 @@
 #include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
+#include <linux/uaccess.h>
 
 #include "power.h"
 
@@ -208,9 +209,71 @@ void wakeup_source_sysfs_remove(struct wakeup_source *ws)
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
+	ws_name = kzalloc(len+1, GFP_KERNEL);
+	if (!ws_name)
+		return -ENOMEM;
+
+	if (sscanf(buf, "%s", ws_name) != 1)
+		return -EFAULT;
+
+	dev = class_find_device_by_name(wakeup_class, ws_name);
+	if (!dev) {
+		pr_err("%s : wakeup device not found\n", __func__);
+		return -EINVAL;
+	}
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

