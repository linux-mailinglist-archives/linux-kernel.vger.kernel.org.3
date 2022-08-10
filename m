Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D9A58EFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiHJQBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiHJQAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:00:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B651430
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:00:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a05690212cb00b006454988d225so12555160ybu.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=pLDTz62gPJ91mpDpmN3M3FTjYt7n2yiMGo8VDSMUjc8=;
        b=CR3CmM0arRVOQhak6gR9dT4pQ3WJhrVJMProQG/G7BqG+NRn7TWaCGGwjk/VzBiptS
         Y8sNFBYMvf771vrpHEe+YeNq//4JWwZQehWRUsPm5u2lKcMBK+6T6X4Nf8cjvE83xxB3
         CWeffwGIVCWudVxdbZ8K4cttPp/fUdbTQu6J+3pFk/F7lGWCUfh3WxMcCXfamSQFLp89
         uWKN1TcLe687SmwrSgo/aTQhT6OxOz/ZTL2sFYOQugPTX/CJceZpkudCJcSFdG4XIXmY
         V9GgQlkh6SMI5eqvsH+tRT5i8xFyb/isrMqMOwgf0NND+2vJNJHoK8dW3xh0aLAGK2Wx
         q58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=pLDTz62gPJ91mpDpmN3M3FTjYt7n2yiMGo8VDSMUjc8=;
        b=L+5hJRSRpJKJkuIWdEeQn9MMpystyrTBu/kc5qwWWSMYJrh/uAH4cyKcMh+yADH3aT
         fAuQ6r/mtx4j/K+NSRlpuofqjKo3Yj5VkXKFxsqR2WWYxbttiQQCS7GQcBzDRvp/hphu
         Y1hglSOTBmR2X0O1Tuzj80aCWZigdgED+WKA+MV97P5hg9+TfC6ZaiarGGz+X6qBevsr
         sl3FyGB9hT0nosNmtFb6FP1PFdRhKDD2Zg4wL7dgy8sLMsKQNauHcvpKjpaY+Hq/NdIG
         jz/UrRkdHNDuhp9IfL5Vj9kYRWhC8wBvBejTCY51eaDbUmY7obZIwJmetHQ4OOlAxXTe
         Sc1Q==
X-Gm-Message-State: ACgBeo2MmD/D28PkSqj5OBbE46DaPxRunJLnxehrAwNqJEn5Srzafe/G
        YuKWWhfcaIVzGKJgNktRW3FgxMTlaB2ivA==
X-Google-Smtp-Source: AA6agR65qiZ5vbYhy3fjKvlRcmiQty/xRvWGJlxJPIOU1OlWGvwmRmF1RTU+QX22ECvwXzaLgERL2p7DDgPJWg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:1e7:803:63a4:33])
 (user=mmandlik job=sendgmr) by 2002:a25:3182:0:b0:676:e9d3:3d16 with SMTP id
 x124-20020a253182000000b00676e9d33d16mr26508215ybx.275.1660147245644; Wed, 10
 Aug 2022 09:00:45 -0700 (PDT)
Date:   Wed, 10 Aug 2022 09:00:35 -0700
In-Reply-To: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Message-Id: <20220810085753.v5.2.Ief1110784c6c1c3ac0ee5677c2d28d785af8686d@changeid>
Mime-Version: 1.0
References: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v5 2/5] devcoredump: Add per device sysfs entry to
 enable/disable coredump
From:   Manish Mandlik <mmandlik@google.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Signed-off-by : Manish Mandlik" <mmandlik@google.com>,
        linux-bluetooth@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Won Chung <wonchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /sys/class/devcoredump/disabled provides only one-way disable
functionality. Also, disabling devcoredump using it disables the
devcoredump functionality for everyone who is using it.

Provide a way to selectively enable/disable devcoredump for the device
which is bound to a driver that implements the '.coredump()' callback.

This adds the 'coredump_disabled' driver attribute. When the driver
implements the '.coredump()' callback, 'coredump_disabled' file is added
along with the 'coredump' file in the sysfs folder of the device upon
driver binding. The file is removed when the driver is unbound.

Drivers can use this attribute to enable/disable devcoredump and the
userspace can write 0 or 1 to /sys/devices/.../coredump_disabled sysfs
entry to control enabling/disabling of devcoredump for that device.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v5:
- Use sysfs_emit(), kstrtobool() and attribute groups
- Move 'coredump_disabled' at appropriate location in 'struct device'

Changes in v4:
- New patch in the series

 drivers/base/dd.c          | 33 +++++++++++++++++++++++++++++++--
 drivers/base/devcoredump.c |  2 +-
 include/linux/device.h     |  3 +++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 11b0fb6414d3..fa01901983c8 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -426,6 +426,35 @@ static ssize_t coredump_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(coredump);
 
+static ssize_t coredump_disabled_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev->coredump_disabled);
+}
+
+static ssize_t coredump_disabled_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	bool disabled;
+
+	if (kstrtobool(buf, &disabled) < 0)
+		return -EINVAL;
+
+	dev->coredump_disabled = disabled;
+
+	return count;
+}
+static DEVICE_ATTR_RW(coredump_disabled);
+
+static struct attribute *dev_coredump_attrs[] = {
+	&dev_attr_coredump.attr,
+	&dev_attr_coredump_disabled.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(dev_coredump);
+
 static int driver_sysfs_add(struct device *dev)
 {
 	int ret;
@@ -447,7 +476,7 @@ static int driver_sysfs_add(struct device *dev)
 	if (!IS_ENABLED(CONFIG_DEV_COREDUMP) || !dev->driver->coredump)
 		return 0;
 
-	ret = device_create_file(dev, &dev_attr_coredump);
+	ret = device_add_groups(dev, dev_coredump_groups);
 	if (!ret)
 		return 0;
 
@@ -467,7 +496,7 @@ static void driver_sysfs_remove(struct device *dev)
 
 	if (drv) {
 		if (drv->coredump)
-			device_remove_file(dev, &dev_attr_coredump);
+			device_remove_groups(dev, dev_coredump_groups);
 		sysfs_remove_link(&drv->p->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
 	}
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f4d794d6bb85..c5e9af9f3181 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -255,7 +255,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	struct devcd_entry *devcd;
 	struct device *existing;
 
-	if (devcd_disabled)
+	if (devcd_disabled || dev->coredump_disabled)
 		goto free;
 
 	existing = class_find_device(&devcd_class, NULL, dev,
diff --git a/include/linux/device.h b/include/linux/device.h
index dc941997795c..41aedc74a5a8 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -526,6 +526,8 @@ struct device_physical_location {
  *              should be set by the subsystem / bus driver that discovered
  *              the device.
  *
+ * @coredump_disabled: Can be used to selectively enable/disable the coredump
+ *		functionality for a particular device via sysfs entry.
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
  * @of_node_reused: Set if the device-tree node is shared with an ancestor
@@ -637,6 +639,7 @@ struct device {
 
 	enum device_removable	removable;
 
+	bool			coredump_disabled:1;
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
-- 
2.37.1.559.g78731f0fdb-goog

