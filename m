Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A85AA9D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbiIBIU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiIBIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:20:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F3550068;
        Fri,  2 Sep 2022 01:20:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g7so2171994lfe.11;
        Fri, 02 Sep 2022 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lqYG4SM+qd4aGiGaaNdu02PgdrQxZkO5ZzkdS9dPiKA=;
        b=CZ5qvOg8aTsy1jDCkOg7doc7NNaGb66ZnplVEl8CGpn9G2Ky4/EhwuqiZWjc1WQego
         eevmVY/Tj3/sgmMtoSE1NmwGBKZXrFnvdcDJfmsv93NfWDHIw8msNvvs46vMe2F5t9iX
         X1Xq6qdSDQdEuMlGXuJPHEBq2lHfhDpChtRXod2Z1MGlHptKiOJt7l0GZEsrpdjU/v7I
         tmABemAzbVLbEQiZ0miRwunf3M1m1FuByRIDfq5z+n8LdWqYrFf9bztIvYdINW8mQ9nX
         Ms0fQz1/TjkqdaAUSw9SccpGckObo0xuMQGUYwXY53bJRhnbJGWHi+2EsCwxjsCOGnx7
         wRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lqYG4SM+qd4aGiGaaNdu02PgdrQxZkO5ZzkdS9dPiKA=;
        b=UogBU9N+xqijrmzuJcxBzBsiq0xDJ7dfmASeSDI/ZSklPlHgPbb2QpRceU/bkfmrjQ
         9Q5V2gI8bn0DGq0TZMHGdg/8rVEKj86lfxhvXwSt8mg+8WU66Jrn1XD86shtKzrHQuGn
         HB4i64k8KhZCvCO2ekPPyyP4AFPwE5/XVR+ItZR6sCWaNiuNFDx3FfMHZ384KppzAvHN
         aZT2guR4GaGdFS+3b/uQwzAxS3jWmPLSMMjVmUGY5J7TQb6QV5Dg5BAjwr3ciaG/Pju7
         4W2eDlHgZGDQtrb3CIluxw5+o86wQQGOahLgSkl6tLxrBTtVPrJgQ6fTLMlDX5PrPxVt
         4d3g==
X-Gm-Message-State: ACgBeo00J8Bo/dQdKZ9hmI9hjqMVmuXyPi/Ujv9lvImo1/85dw/wnMd4
        Ai+t992FYR24CDB5QdT6P0y+2D4WF8w=
X-Google-Smtp-Source: AA6agR6SG4a/F/2Q9ftsWcNLhA8xShwZ+ge+JAFwGjTq6Cmeoty48spL8fNZV1yEMxdEwu6he6mx3A==
X-Received: by 2002:ac2:414f:0:b0:492:ebc5:c7ef with SMTP id c15-20020ac2414f000000b00492ebc5c7efmr12728582lfi.630.1662106850325;
        Fri, 02 Sep 2022 01:20:50 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id a27-20020a05651c031b00b00263630ab29dsm108828ljp.118.2022.09.02.01.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 01:20:49 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        marcus.folkesson@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] HID: Add driver for VRC-2 Car Controller
Date:   Fri,  2 Sep 2022 10:25:52 +0200
Message-Id: <20220902082552.2433744-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902082552.2433744-1-marcus.folkesson@gmail.com>
References: <20220902082552.2433744-1-marcus.folkesson@gmail.com>
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
 MAINTAINERS            |  6 +++
 drivers/hid/Kconfig    | 10 +++++
 drivers/hid/Makefile   |  1 +
 drivers/hid/hid-vrc2.c | 91 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)
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
index d8313d36086c..910cfbaca768 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -481,6 +481,16 @@ config HID_VIEWSONIC
 	help
 	  Support for ViewSonic/Signotec PD1011 signature pad.
 
+config HID_VRC2
+	tristate "VRC-2 Car Controller"
+	depends on HID
+	help
+        Support for VRC-2 which is a 2-axis controller often used in
+        car simulators.
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
index 000000000000..80a2b7ef5e66
--- /dev/null
+++ b/drivers/hid/hid-vrc2.c
@@ -0,0 +1,91 @@
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
+};
+module_hid_driver(vrc2_driver);
+
+MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
+MODULE_DESCRIPTION("HID driver for VRC-2 2-axis Car controller");
+MODULE_LICENSE("GPL");
-- 
2.37.1

