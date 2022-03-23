Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0A4E4BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 05:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiCWFA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 01:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiCWFAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:00:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C5A6E8F5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 21:59:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s8so584157pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 21:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=BIi8aIx4Pvfk7S17+jHZfQfpXJsGvw744CrZCscalCQ=;
        b=aAi92wzJLgsGIKJgq7Znwh4Z1TY6RlFPcBQjYeecZaydciy/T2xFC1Cy/JVio4wzzU
         0hos1L5o56Ipj+8vvPoVMwsfHD4sjbifeWgLanzAKXcmHGYVeSwFoj8csV4IyneU/DOM
         ivY6B52fpxOCMCxVJbdm/rQ7ZGnpCJ4MT6xVLCZnsciva0ipk45ZeNcaE9536miI5zAy
         8zF5PeF8vKud7NWVQByUkUbkyRe7vaFGARJg4IJwAUx9j1Wm98wt5qsjvJR8yLo2AuVS
         JE23U4yqFJg/Uo87aFdBEMJ2oXHeYqnE58t1dfh4FsMPJB2odpT2KC0xwvzBxMhgN0t8
         kyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BIi8aIx4Pvfk7S17+jHZfQfpXJsGvw744CrZCscalCQ=;
        b=M189toFECeyx6/8ro1LCcpgv+zYzdMce7dqqMLShxEErFWJCjDCXNzw9dOcPrqS9yX
         QM/0KqGw5VMpzABPyUtIDtvlDEie+708pN9vLdJec/QCAsFDaFJj9d2zsIb/1C0CiJzu
         WiNMUFLfz7AnH4apDSj7eLRAHKg3kLQnh3fDJ4r71ycdWXjdkRzPKPs23kEPNVO/pN1Q
         oG//28cRYRgCataobLQDffuRFC8LpibT+DvZ2uXbDd+QRL5Qj6oIKJjS7jmDeSC3eEwQ
         PSz4Q/85Imri6vdWkHnsN//AdwvXS7RelwMNp8BTLpw4sg3lDkJ33bFQJ5zNzH0otTjr
         jzcQ==
X-Gm-Message-State: AOAM531Pe9euseEOIRmWIxfAjMjt7xBKanSS1Qok6N4Kczf33n2veNpV
        QW3D4Zd0bLDKgOmuBi7oDNGX3Uq3Auc=
X-Google-Smtp-Source: ABdhPJxT3nV21O8ewfKHSo+/v54T6KxtacyvyURGdHb3ZOw8IJ4BvfJmvnNUK0cUqVJ6d5CP0k5GGA==
X-Received: by 2002:a63:f10c:0:b0:382:623b:3bb9 with SMTP id f12-20020a63f10c000000b00382623b3bb9mr13433546pgi.97.1648011565675;
        Tue, 22 Mar 2022 21:59:25 -0700 (PDT)
Received: from localhost.localdomain ([157.49.70.34])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090a02d700b001bf6ef9daafsm4323380pjd.38.2022.03.22.21.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 21:59:25 -0700 (PDT)
From:   Sathish Kumar <skumark1902@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Sathish Kumar <skumark1902@gmail.com>
Subject: [PATCH v3] staging: rtl8712: Use completions for signaling
Date:   Wed, 23 Mar 2022 10:25:15 +0530
Message-Id: <20220323045515.2513-1-skumark1902@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r8712_sitesurvey_cmd() uses a variable to notify r8712_SetFilter() that it
has completed operation. There is no sort of assurance that the variable will
actually change and it could cache the value the first time it is read and
then never update it for the whole loop logic.

Use completion variables because they are better suited for the purpose.

This patch fixes the checkpatch.pl warnings like:
CHECK: Avoid CamelCase: <blnEnableRxFF0Filter>
+   u8 blnEnableRxFF0Filter;

Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
---
Changes in v2:
  - Remove the "bln" prefix

Changes in v3:
  - Replace the variable used for signaling with completion
---
 drivers/staging/rtl8712/drv_types.h   | 3 +--
 drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
 drivers/staging/rtl8712/usb_intf.c    | 2 +-
 drivers/staging/rtl8712/xmit_linux.c  | 8 +-------
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index a44d04effc8b..76ac798642bd 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -157,12 +157,11 @@ struct _adapter {
 	struct iw_statistics iwstats;
 	int pid; /*process id from UI*/
 	struct work_struct wk_filter_rx_ff0;
-	u8 blnEnableRxFF0Filter;
-	spinlock_t lock_rx_ff0_filter;
 	const struct firmware *fw;
 	struct usb_interface *pusb_intf;
 	struct mutex mutex_start;
 	struct completion rtl8712_fw_ready;
+	struct completion rx_filter_ready;
 };
 
 static inline u8 *myid(struct eeprom_priv *peepriv)
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index acda930722b2..f5746020a1b7 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -202,7 +202,7 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
 	mod_timer(&pmlmepriv->scan_to_timer,
 		  jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
 	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_SITE_SURVEY);
-	padapter->blnEnableRxFF0Filter = 0;
+	complete(&padapter->rx_filter_ready);
 	return _SUCCESS;
 }
 
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index ee4c61f85a07..8df50e24f2b8 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -568,7 +568,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 	/* step 6. Load the firmware asynchronously */
 	if (rtl871x_load_fw(padapter))
 		goto deinit_drv_sw;
-	spin_lock_init(&padapter->lock_rx_ff0_filter);
+	init_completion(&padapter->rx_filter_ready);
 	mutex_init(&padapter->mutex_start);
 	return 0;
 
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 90d34cf9d2ff..4a93839bf947 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -95,18 +95,12 @@ void r8712_SetFilter(struct work_struct *work)
 	struct _adapter *adapter = container_of(work, struct _adapter,
 						wk_filter_rx_ff0);
 	u8  oldvalue = 0x00, newvalue = 0x00;
-	unsigned long irqL;
 
 	oldvalue = r8712_read8(adapter, 0x117);
 	newvalue = oldvalue & 0xfe;
 	r8712_write8(adapter, 0x117, newvalue);
 
-	spin_lock_irqsave(&adapter->lock_rx_ff0_filter, irqL);
-	adapter->blnEnableRxFF0Filter = 1;
-	spin_unlock_irqrestore(&adapter->lock_rx_ff0_filter, irqL);
-	do {
-		msleep(100);
-	} while (adapter->blnEnableRxFF0Filter == 1);
+	wait_for_completion(&adapter->rx_filter_ready);
 	r8712_write8(adapter, 0x117, oldvalue);
 }
 
-- 
2.17.1

