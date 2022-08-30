Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8735A7180
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiH3XQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiH3XQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:16:25 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5FD5A897
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:16 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n202so10592491iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6Cki2zIPGx1POrukQe/HlbUkh63Uf8/m2v1IMF/IUTs=;
        b=kZW7YJ0imUUssdJmbimewISxSqiEqn1g+K9BJsvsguQF1wnXRBDeyDZgNxj8mJMP0T
         eF9bl5BneyyKx+/HBQ5vra8CsSlE/2vPZ5MPryjGJpTk5GTqkkR6ZAbikV4ZKsOPq6nO
         JkgB34Qhk6z0IA9OvLVnZtLWpvwaSyLNF7+3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6Cki2zIPGx1POrukQe/HlbUkh63Uf8/m2v1IMF/IUTs=;
        b=8N3aQ3UT40wQ9bn6XVM2g1Eg3zjiobGsviMiy4DQTWT7IyX31Gs+2ht7Pj+mFmNlKs
         fbCxup4/Y8Daj3TacSZOxywxe31u+hPykk2/ZTeDWfjUOQ4wFlnKnphXH9gQSMNir77B
         Bm5Kzei7sjiPRuiWZVQRA0LxWJfDmbZXEqsmERfh+nN4YCl7cPjH+TkpryUL65jMmMcg
         H0RvslYr+FZvoHnIkKw9NOb46NAJdlR6l419Gdn/nJ8oSMxYH5xZ/gi74YV5VzZ3VHVT
         GYBKysEJzV21t3STDxKQouMC9OAOjJ/mcwuCNseQW5K20FgcNZWfJ0N+wfnNF1HtwjSg
         48pQ==
X-Gm-Message-State: ACgBeo17khssaa8dNXS+NWG6wiEUdFHtnIy0HvqDedn9cMSp+JdC3P6N
        2KlzS7f+2bmFdw6Fhs3UIPRPKA==
X-Google-Smtp-Source: AA6agR4PPQ3OCABkevBsd5VZPlwvnQiE50aYZTYSDtxDRq0jTTRX2BRq62coRRChds8lZXfAaYPaMQ==
X-Received: by 2002:a02:ce92:0:b0:34a:5b83:a0df with SMTP id y18-20020a02ce92000000b0034a5b83a0dfmr2521090jaq.307.1661901375405;
        Tue, 30 Aug 2022 16:16:15 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id z30-20020a056602081e00b0068b1858c81asm6165821iow.13.2022.08.30.16.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 16:16:15 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     hdegoede@redhat.com, mario.limonciello@amd.com, timvp@google.com,
        rafael@kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] i2c: acpi: Use ACPI GPIO wake capability bit to set wake_irq
Date:   Tue, 30 Aug 2022 17:15:37 -0600
Message-Id: <20220830171332.4.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid>
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

Device tree already has a mechanism to pass the wake_irq. It does this
by looking for the wakeup-source property and setting the
I2C_CLIENT_WAKE flag. This CL adds the ACPI equivalent. It uses at the
ACPI GpioInt wake flag to determine if the interrupt can be used to wake
the system. Previously the i2c drivers had to make assumptions and
blindly enable the wake IRQ. This can cause spurious wake events. e.g.,
If there is a device with an Active Low interrupt and the device gets
powered off while suspending, the interrupt line will go low since it's
no longer powered and wake the system. For this reason we should respect
the board designers wishes and honor the wake bit defined on the
GpioInt.

This change does not cover the ACPI Interrupt or IRQ resources.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/i2c/i2c-core-acpi.c |  8 ++++++--
 drivers/i2c/i2c-core-base.c | 17 +++++++++++------
 drivers/i2c/i2c-core.h      |  4 ++--
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index c762a879c4cc6b..cfe82a6ba3ef28 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -182,12 +182,13 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
 /**
  * i2c_acpi_get_irq - get device IRQ number from ACPI
  * @client: Pointer to the I2C client device
+ * @wake_capable: Set to 1 if the IRQ is wake capable
  *
  * Find the IRQ number used by a specific client device.
  *
  * Return: The IRQ number or an error code.
  */
-int i2c_acpi_get_irq(struct i2c_client *client)
+int i2c_acpi_get_irq(struct i2c_client *client, int *wake_capable)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
 	struct list_head resource_list;
@@ -196,6 +197,9 @@ int i2c_acpi_get_irq(struct i2c_client *client)
 
 	INIT_LIST_HEAD(&resource_list);
 
+	if (wake_capable)
+		*wake_capable = 0;
+
 	ret = acpi_dev_get_resources(adev, &resource_list,
 				     i2c_acpi_add_resource, &irq);
 	if (ret < 0)
@@ -204,7 +208,7 @@ int i2c_acpi_get_irq(struct i2c_client *client)
 	acpi_dev_free_resource_list(&resource_list);
 
 	if (irq == -ENOENT)
-		irq = acpi_dev_gpio_irq_get(adev, 0);
+		irq = acpi_dev_gpio_irq_get_wake(adev, 0, wake_capable);
 
 	return irq;
 }
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 91007558bcb260..88f4ef76235f4e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -468,6 +468,7 @@ static int i2c_device_probe(struct device *dev)
 	struct i2c_client	*client = i2c_verify_client(dev);
 	struct i2c_driver	*driver;
 	int status;
+	int acpi_wake_capable = 0;
 
 	if (!client)
 		return 0;
@@ -487,7 +488,7 @@ static int i2c_device_probe(struct device *dev)
 			if (irq == -EINVAL || irq == -ENODATA)
 				irq = of_irq_get(dev->of_node, 0);
 		} else if (ACPI_COMPANION(dev)) {
-			irq = i2c_acpi_get_irq(client);
+			irq = i2c_acpi_get_irq(client, &acpi_wake_capable);
 		}
 		if (irq == -EPROBE_DEFER) {
 			status = irq;
@@ -513,13 +514,17 @@ static int i2c_device_probe(struct device *dev)
 		goto put_sync_adapter;
 	}
 
-	if (client->flags & I2C_CLIENT_WAKE) {
+	if (client->flags & I2C_CLIENT_WAKE || acpi_wake_capable) {
 		int wakeirq;
 
-		wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
-		if (wakeirq == -EPROBE_DEFER) {
-			status = wakeirq;
-			goto put_sync_adapter;
+		if (acpi_wake_capable) {
+			wakeirq = client->irq;
+		} else {
+			wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
+			if (wakeirq == -EPROBE_DEFER) {
+				status = wakeirq;
+				goto put_sync_adapter;
+			}
 		}
 
 		device_init_wakeup(&client->dev, true);
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 87e2c914f1c57b..8e336638a0cd2e 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -61,11 +61,11 @@ static inline int __i2c_check_suspended(struct i2c_adapter *adap)
 #ifdef CONFIG_ACPI
 void i2c_acpi_register_devices(struct i2c_adapter *adap);
 
-int i2c_acpi_get_irq(struct i2c_client *client);
+int i2c_acpi_get_irq(struct i2c_client *client, int *wake_capable);
 #else /* CONFIG_ACPI */
 static inline void i2c_acpi_register_devices(struct i2c_adapter *adap) { }
 
-static inline int i2c_acpi_get_irq(struct i2c_client *client)
+static inline int i2c_acpi_get_irq(struct i2c_client *client, int *wake_capable)
 {
 	return 0;
 }
-- 
2.37.2.672.g94769d06f0-goog

