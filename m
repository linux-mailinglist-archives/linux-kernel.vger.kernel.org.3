Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A6B58EFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiHJQBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiHJQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:00:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B355C979
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:00:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a05690212cb00b006454988d225so12555536ybu.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=l7PZD+YaratyWuraoD6FFlyszu21r1R3dL9LFvoq6k0=;
        b=jcmeIl1NpNa7TnyD+eLPi7e6zk/kVWAJSsfHmHu3w/Xm5Sr84D4AnVAbdGqmxY1/rX
         b7fNe6NOGDHsFWsaGhR9f/rlfrEXlH6M9L1u4r3/Ir1sofL6f9v33e4TigWbRQ0Wch/t
         ia+r1izURNqhbIPH5MA4Bjb1fsSu6i0/HepEKJz0enLpMCBxfExi3+iyvcl1hQx/67zs
         UqWXZfV5UpzdnxNUFFTfYfXAnafT/Mxp9Ah54+yUeMXSCiyAiipmyL5suRHsanRZk3tv
         0Zogb17vBr2mpWIeQ9/Hoc740SfWND/RDfokXgF62wbF442ne4BhrnUWl+ti044445Tu
         NKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=l7PZD+YaratyWuraoD6FFlyszu21r1R3dL9LFvoq6k0=;
        b=LyxE4wxjFOrrVL5JASYe9/oVRw8IPl2zZqhEajhvJ4nz3uVjdZrOLE1hrfG9t1Rvyi
         SrmBfMe4zJIVB1mCqaaF4aTCuF+ZVACqEgyWqoXXnNXQj8lZk7njSKlLxT60Hb0zDHyz
         /zJGWKe5cspib+8+OD25gE51EKU5ZkVtMW305AMjAw+o/cXLltv5rMbmAQ+11vGtuSqC
         sN7X919FkvB91+SJWpW9b8nNdP9ERW1pShS/BiFTY9CKOA/dEW7HfC0yyUMBdcaQGUg6
         GQd2SCf3aQNG10u25d1bLn4Raeqeyx62TPPdEXiSNeFDkd/p8PvV/0VwGN70L60L+Thh
         gpOg==
X-Gm-Message-State: ACgBeo0OvbJ7obsIxlt9mGvafQpCLLiaoAwWWUTKa4C9s6ylfqRtrg93
        onwQRCasd9mb12QzheLo+j7PofFRryHWyw==
X-Google-Smtp-Source: AA6agR68Jx/wH/w50KMdlkv4S9EednDBP6Y2dFhbVSMU+HmwN9CXWaNd2gF+iXk9NxHzidZB/6AUpV38R0k8sg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:1e7:803:63a4:33])
 (user=mmandlik job=sendgmr) by 2002:a05:6902:15cf:b0:67c:1ee7:149 with SMTP
 id l15-20020a05690215cf00b0067c1ee70149mr8637670ybu.594.1660147251724; Wed,
 10 Aug 2022 09:00:51 -0700 (PDT)
Date:   Wed, 10 Aug 2022 09:00:37 -0700
In-Reply-To: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Message-Id: <20220810085753.v5.4.Id0d6e772f00432d55f6bcbf68a50cb4ad89396c6@changeid>
Mime-Version: 1.0
References: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v5 4/5] Bluetooth: btusb: Add btusb devcoredump support
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

(no changes since v4)

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

