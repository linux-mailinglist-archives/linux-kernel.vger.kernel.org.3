Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A7958DB36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244717AbiHIPgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244477AbiHIPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:35:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF5BF17
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:35:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m123-20020a253f81000000b0066ff6484995so9955135yba.22
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=ufjJg4VVxq92WaQVQMCk9m8A9i0qlvuSNS+kFeik61o=;
        b=RXu3e9SK5+03ky70/ZSYqs7MjiZvc9YX8O0kcstuAXa9Vy+FUrLRu0P3u9RZbyS3GO
         uywN6ssmvzu30Orf42VVSWqugtBcqXvHbO8FJGI31043kSPsYS716n3vGr8BAJ9TASdz
         GQH5Ulz7Vt2ZkO3MryQ9PHpAw/exu8PIiXdNUmlAzpfpPM/G2vl1c1CuIDbvwMwy2N13
         MzTq+yNDPsiezUtdKXjhsA9X4v5L2Af97WhuVXu4dYIKgXSRWU5s2zt6KvVNYJKAhEVU
         Zvx+YQxCBYTmKKhb5OvQrIH+TwprGSeVeemIngULueJd6P3ixMGdgKFaE7ecH7qPaSkx
         jSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ufjJg4VVxq92WaQVQMCk9m8A9i0qlvuSNS+kFeik61o=;
        b=sfsTGKwA9u/WpiRbIEgyZSCn6Bq5cNgHn5U99zDIegyAp5yhiS/SkEfTICAfUQZ0v6
         S+r1Tp+71//FRdyGV/gQmWns/OFaSZKjYA8UEjDM+WAWeWTJqPY159C05+YWflzvEW5s
         xnyB2KMUGOBA9+Ekh9h1TL07vBz1e9iGFYsQqWJDI38pXHzuo11ZrNgr61hWoT0DpUaV
         woul1H5HFl2bnUYNFGHO7O5xvoM0OXT3+kT6UcMqS+yUBaSFG8Cm3+tHuTvDO+mv08ub
         j0C33IVlppnjJ4NmPVbdFmPPqJYvtsugh2rYrSA1uZ86QtAX+ZKoelDW3w1/3au8VcOv
         HfQQ==
X-Gm-Message-State: ACgBeo13I77TTBPSyHapflYtZ18IA48n/EaSMmtQ+zVLtRGg01TMIPuH
        E0XrPG4F6ifRBmN494/1bXVP/CYyCkWqYg==
X-Google-Smtp-Source: AA6agR50yechnFMMM/5FXSXojXIsB/DsnQjLhjvw2CWMNyh2fsc0MANYCEgYqrlhNUHXxpVmIu+tPlAXSV59cw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:91a6:8007:96f6:3fb3])
 (user=mmandlik job=sendgmr) by 2002:a25:dc81:0:b0:67c:1421:12bc with SMTP id
 y123-20020a25dc81000000b0067c142112bcmr5401827ybe.267.1660059348675; Tue, 09
 Aug 2022 08:35:48 -0700 (PDT)
Date:   Tue,  9 Aug 2022 08:35:26 -0700
In-Reply-To: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Message-Id: <20220809083112.v4.4.Id0d6e772f00432d55f6bcbf68a50cb4ad89396c6@changeid>
Mime-Version: 1.0
References: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 4/5] Bluetooth: btusb: Add btusb devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the btusb driver side .coredump() callback to
trigger a devcoredump via sysfs and .enable_coredump() callback to
check if the devcoredump functionality is enabled for a device.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v4:
- New patch in the series

 drivers/bluetooth/btusb.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 30dd443f395f..b00851327aa3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1510,6 +1510,15 @@ static void btusb_isoc_tx_complete(struct urb *urb)
 	kfree_skb(skb);
 }
 
+#ifdef CONFIG_DEV_COREDUMP
+static bool btusb_coredump_enabled(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	return !data->intf->dev.coredump_disabled;
+}
+#endif
+
 static int btusb_open(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -3765,6 +3774,9 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 	hdev->wakeup = btusb_wakeup;
+#ifdef CONFIG_DEV_COREDUMP
+	hdev->dump.enabled = btusb_coredump_enabled;
+#endif
 
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
@@ -4180,6 +4192,17 @@ static int btusb_resume(struct usb_interface *intf)
 }
 #endif
 
+#ifdef CONFIG_DEV_COREDUMP
+static void btusb_coredump(struct device *dev)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+	struct hci_dev *hdev = data->hdev;
+
+	if (!dev->coredump_disabled && hdev->dump.coredump)
+		hdev->dump.coredump(hdev);
+}
+#endif
+
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
@@ -4191,6 +4214,14 @@ static struct usb_driver btusb_driver = {
 	.id_table	= btusb_table,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
+
+#ifdef CONFIG_DEV_COREDUMP
+	.drvwrap = {
+		.driver = {
+			.coredump = btusb_coredump,
+		},
+	},
+#endif
 };
 
 module_usb_driver(btusb_driver);
-- 
2.37.1.559.g78731f0fdb-goog

