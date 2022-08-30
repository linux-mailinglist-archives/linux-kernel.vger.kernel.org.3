Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56225A6DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiH3TqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiH3TqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:46:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F335F6CF61;
        Tue, 30 Aug 2022 12:46:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bt10so16983605lfb.1;
        Tue, 30 Aug 2022 12:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=StwtrRo41Q02kq4392RIAvwdz46GplrH2vSGAt0nUXg=;
        b=BlRUPU4UIkeSNpc47ExwZ1yYCzf5rZtwrGcCNlMv0ncDh2kkBhEnYjEqan/q68hoA2
         R+GKANoLKpsVg+YZEtFLV315YVo8ano+jygioVbFcwVh7VzppzWBLnrfUBfmm3c/nJuB
         ZoHMuJ3rXr+j67kW6zgzBibwREVusZMo2oAgwCcgYyzhP220JHc5Po0GfotTVNOdE/I4
         uXBGNF0bMWxtPO31D5ciaLV9bwRS5n3U1/oHrxnMZkZ0snLxDMwjj5tNZC4IcoETQpf4
         YGnH/7w4B8FEa0MYdlXA9orsbLbvRIBXjETxGNteGu+M5cx8x57oIz/UyKdvSQPvSwLW
         3nhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=StwtrRo41Q02kq4392RIAvwdz46GplrH2vSGAt0nUXg=;
        b=mzONbHWZ2tSJTNYEmZHO5ScyUM2gxZnZvxW+N3omG8bNM4EULZP3JY77V3LB4vyla6
         jj0dPmgJIG6MUxDBL8Idx71aWb2FqdbvdpKP8d3drhJgmQD+mXP01BKhCPndDr1QfP7x
         9TDBNmbdPqDFVJwwjUBgpKI1/8Ohekjgw2aNquYMnu1Q4P6jm8W/O5E0A3wOUOyzXu24
         zQQx0WPpz/Z2tSWWvGMzNWK7/p+uOUA3aUVGjV7T5KoJSMATrWz5JI42hHAOjwpRQX3e
         ZPNxZHQRJsH4kPouzVreAu4OMnnn/ps5d6iKbqn/QVa96pxxNkTcUVzogFh8rqrTTrLT
         W9ZA==
X-Gm-Message-State: ACgBeo0ROCYCvInedGdUP5SLZt1uhpHHQCGn9o1lFXR0JmQhS8PiTj+M
        +ycyh2z2Te93mxKRxtyki2DzycFVS0o=
X-Google-Smtp-Source: AA6agR60F2b2j2MMUdo1tHPJmFq5KZwHFivwiIzQK491Kn221YlIC+Ab1SZqoqNwUcJTaPVtxrFF0g==
X-Received: by 2002:a05:6512:32aa:b0:494:653b:765c with SMTP id q10-20020a05651232aa00b00494653b765cmr4390917lfe.337.1661888762371;
        Tue, 30 Aug 2022 12:46:02 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g20-20020a05651222d400b004948b61f780sm1036lfu.144.2022.08.30.12.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 12:46:01 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        marcus.folkesson@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: Add driver for VRC-2 Car Controller
Date:   Tue, 30 Aug 2022 21:50:55 +0200
Message-Id: <20220830195055.1812192-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830195055.1812192-1-marcus.folkesson@gmail.com>
References: <20220830195055.1812192-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VRC-2 is 2-axis controller often used in car simulators.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 MAINTAINERS            |   6 +++
 drivers/hid/Kconfig    |   9 ++++
 drivers/hid/Makefile   |   1 +
 drivers/hid/hid-vrc2.c | 100 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 drivers/hid/hid-vrc2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 216b9f021f72..33010f93c993 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8919,6 +8919,12 @@ F:	drivers/hid/hid-sensor-*
 F:	drivers/iio/*/hid-*
 F:	include/linux/hid-sensor-*
 
+HID VRC-2 CAR CONTROLLER DRIVER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-vrc2.c
+
 HID WACOM DRIVER
 M:	Ping Cheng <ping.cheng@wacom.com>
 M:	Jason Gerecke  <jason.gerecke@wacom.com>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index d8313d36086c..518e0a5a7852 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -481,6 +481,15 @@ config HID_VIEWSONIC
 	help
 	  Support for ViewSonic/Signotec PD1011 signature pad.
 
+config HID_VRC2
+	tristate "VRC-2 Car Controller"
+	depends on HID
+	help
+        Support for VRC-2 2-axis Car Controller
+
+        To compile this driver as a module, choose M here: the
+        module will be called hid-vrc2.
+
 config HID_XIAOMI
 	tristate "Xiaomi"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 85d50ab352ee..32ab85b1a776 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -137,6 +137,7 @@ obj-$(CONFIG_HID_XINMO)		+= hid-xinmo.o
 obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
 obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
 obj-$(CONFIG_HID_VIEWSONIC)	+= hid-viewsonic.o
+obj-$(CONFIG_HID_VRC2)		+= hid-vrc2.o
 
 wacom-objs			:= wacom_wac.o wacom_sys.o
 obj-$(CONFIG_HID_WACOM)		+= wacom.o
diff --git a/drivers/hid/hid-vrc2.c b/drivers/hid/hid-vrc2.c
new file mode 100644
index 000000000000..43c98607b837
--- /dev/null
+++ b/drivers/hid/hid-vrc2.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HID driver for VRC-2 2-axis Car controller
+ *
+ * Copyright (C) 2022 Marcus Folkesson <marcus.folkesson@gmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+/*
+ * VID/PID are probably "borrowed", so keep them locally and
+ * do not populate hid-ids.h with those.
+ */
+#define USB_VENDOR_ID_VRC2	(0x07c0)
+#define USB_DEVICE_ID_VRC2	(0x1125)
+
+static __u8 vrc2_rdesc_fixed[] = {
+	0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
+	0x09, 0x04,        // Usage (Joystick)
+	0xA1, 0x01,        // Collection (Application)
+	0x09, 0x01,        //   Usage (Pointer)
+	0xA1, 0x00,        //   Collection (Physical)
+	0x09, 0x30,        //     Usage (X)
+	0x09, 0x31,        //     Usage (Y)
+	0x15, 0x00,        //     Logical Minimum (0)
+	0x26, 0xFF, 0x07,  //     Logical Maximum (2047)
+	0x35, 0x00,        //     Physical Minimum (0)
+	0x46, 0xFF, 0x00,  //     Physical Maximum (255)
+	0x75, 0x10,        //     Report Size (16)
+	0x95, 0x02,        //     Report Count (2)
+	0x81, 0x02,        //     Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+	0xC0,              //   End Collection
+	0x75, 0x08,        //   Report Size (8)
+	0x95, 0x03,        //   Report Count (3)
+	0x81, 0x03,        //   Input (Cnst,Var,Abs)
+	0xC0,              // End Collection
+};
+
+static __u8 *vrc2_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+				unsigned int *rsize)
+{
+	if (*rsize == 23)
+		return rdesc;
+
+	hid_info(hdev, "fixing up VRC-2 report descriptor\n");
+	*rsize = sizeof(vrc2_rdesc_fixed);
+	return vrc2_rdesc_fixed;
+}
+
+static int vrc2_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+
+	/*
+	 * The device gives us 2 separate USB endpoints.
+	 * One of those (the one with report descriptor size of 23) is just bogus so ignore it
+	 */
+	if (hdev->dev_rsize == 23)
+		return -ENODEV;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void vrc2_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id vrc2_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_VRC2, USB_DEVICE_ID_VRC2) },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(hid, vrc2_devices);
+
+static struct hid_driver vrc2_driver = {
+	.name = "vrc2",
+	.id_table = vrc2_devices,
+	.report_fixup = vrc2_report_fixup,
+	.probe = vrc2_probe,
+	.remove = vrc2_remove,
+};
+module_hid_driver(vrc2_driver);
+
+MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
+MODULE_DESCRIPTION("HID driver for VRC-2 2-axis Car controller");
+MODULE_LICENSE("GPL");
-- 
2.37.1

