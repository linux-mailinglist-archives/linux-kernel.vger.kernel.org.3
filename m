Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D657F5A7179
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiH3XQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiH3XQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:16:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824BA580A6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:14 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q81so10586971iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uHcOw2fkc1mUCVLkWIQ/7iJDKjHGetIDOudBHVaaJ2Y=;
        b=GJ52cOXmzwgv2qJ9IsGzDAd2k3eYsUINNJc2MC+WuamRiHzEjFjjYpK7vegX/+07Cl
         Rej9NMfnZKk+04EBi94UYyw9SKPQXY0lOFGjPKl0+bwv5geiR1nR3HPwwekhekSSeUfh
         P8wdrmYLFGCt4zXKuCYu8W6TRU7KGLZWm2LSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uHcOw2fkc1mUCVLkWIQ/7iJDKjHGetIDOudBHVaaJ2Y=;
        b=qDGx+MlmarGhDRSpWDCzoryEZo0c/66aV1WxX9XcK0YuLcRDo0QPYXSKrk/jRadonA
         S53zgg0X1urrI8AwR4eNYlkJjWeXsn3gD8Buxqd+xGfQ35tfAQb5YF5U3ZqzDHxVx+74
         efFkq8doHrflNjoDBN553jF1To3JZBI/4ZHSaG26xGur4A8xfUamCTwxM4AAlkEz0QCD
         DUbDRPxrsV4hHwTdDOihtW+GZfi6uFbvD6/s66JrAkcJokvGpGK2khlgoF8pBTnX2Ia2
         PrPYycFCRxA8f+06wOaCHW6yl9vUMO/BQ2Q1OroFaDt0iI3knj6yMbrqTocWoPJ0jLgn
         AYqw==
X-Gm-Message-State: ACgBeo2tUB+fiSkv61kUiRQadTcgUNbni5zM8rUOZM+lnDp1LVubXOh6
        gzp/qx3+FZp3h3ukJR9etNrGuQ==
X-Google-Smtp-Source: AA6agR6sZcv5V28LEmNjFke5lkNoOXfN/MPFIdlkw8agvXIDe4597M1xNLIJgNOBnjXc0kWrOliwcw==
X-Received: by 2002:a05:6638:2410:b0:34a:11e6:f171 with SMTP id z16-20020a056638241000b0034a11e6f171mr13609920jat.146.1661901373664;
        Tue, 30 Aug 2022 16:16:13 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id z30-20020a056602081e00b0068b1858c81asm6165821iow.13.2022.08.30.16.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 16:16:12 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     hdegoede@redhat.com, mario.limonciello@amd.com, timvp@google.com,
        rafael@kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Angela Czubak <acz@semihalf.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] HID: i2c-hid: Use PM subsystem to manage wake irq
Date:   Tue, 30 Aug 2022 17:15:35 -0600
Message-Id: <20220830171332.2.Id4b4bdfe06e2caf2d5a3c9dd4a9b1080c38b539c@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220830231541.1135813-1-rrangel@chromium.org>
References: <20220830231541.1135813-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C hid driver is currently manually managing the wake
IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
and instead relies on the PM subsystem. This is done by calling
dev_pm_set_wake_irq.

i2c_device_probe already calls dev_pm_set_wake_irq when using device
tree, so it's only required when using ACPI. The net result is that this
change should be a no-op. i2c_device_remove also already calls
dev_pm_clear_wake_irq, so we don't need to do that in this driver.

I tested this on an ACPI system that has a HID touchscreen and verified
the IRQ was armed for wake on suspend.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/hid/i2c-hid/i2c-hid-core.c | 33 +++++++++++-------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index baa169fadd6632..0b7a1a8b3e9a33 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/device.h>
 #include <linux/wait.h>
 #include <linux/err.h>
@@ -116,7 +117,6 @@ struct i2c_hid {
 
 	wait_queue_head_t	wait;		/* For waiting the interrupt */
 
-	bool			irq_wake_enabled;
 	struct mutex		reset_lock;
 
 	struct i2chid_ops	*ops;
@@ -1036,6 +1036,15 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	if (ret < 0)
 		goto err_powered;
 
+	/*
+	 * Systems using device tree should set up wakeup via DTS,
+	 * the rest will configure device as wakeup source by default.
+	 */
+	if (!client->dev.of_node) {
+		device_init_wakeup(&client->dev, true);
+		dev_pm_set_wake_irq(&client->dev, client->irq);
+	}
+
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
 		ret = PTR_ERR(hid);
@@ -1119,7 +1128,6 @@ static int i2c_hid_core_suspend(struct device *dev)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
 	int ret;
-	int wake_status;
 
 	ret = hid_driver_suspend(hid, PMSG_SUSPEND);
 	if (ret < 0)
@@ -1130,16 +1138,8 @@ static int i2c_hid_core_suspend(struct device *dev)
 
 	disable_irq(client->irq);
 
-	if (device_may_wakeup(&client->dev)) {
-		wake_status = enable_irq_wake(client->irq);
-		if (!wake_status)
-			ihid->irq_wake_enabled = true;
-		else
-			hid_warn(hid, "Failed to enable irq wake: %d\n",
-				wake_status);
-	} else {
+	if (!device_may_wakeup(&client->dev))
 		i2c_hid_core_power_down(ihid);
-	}
 
 	return 0;
 }
@@ -1150,18 +1150,9 @@ static int i2c_hid_core_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
-	int wake_status;
 
-	if (!device_may_wakeup(&client->dev)) {
+	if (!device_may_wakeup(&client->dev))
 		i2c_hid_core_power_up(ihid);
-	} else if (ihid->irq_wake_enabled) {
-		wake_status = disable_irq_wake(client->irq);
-		if (!wake_status)
-			ihid->irq_wake_enabled = false;
-		else
-			hid_warn(hid, "Failed to disable irq wake: %d\n",
-				wake_status);
-	}
 
 	enable_irq(client->irq);
 
-- 
2.37.2.672.g94769d06f0-goog

