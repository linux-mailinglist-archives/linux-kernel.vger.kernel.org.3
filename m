Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF184E5F12
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242320AbiCXHG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiCXHGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:06:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C225E7DE23;
        Thu, 24 Mar 2022 00:04:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u26so4470528eda.12;
        Thu, 24 Mar 2022 00:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmJzxumpLQcs11vK+3c+4EgOpxANBX6MJwGXngCOMXo=;
        b=LL2eN8sSyTOZ859wDP3jr4bcEgBnKx5LwkENba4N6GLZYypfPt211FxmqWSDMQJHge
         TBqhuCw1rBMDXoSc/gzl5gOJ1TI1kDob/jdIsXZkyNYAz1UAsVpzcbn2UIeS8Yw6vncg
         Zp97G7vdkkt14jKJHjWur/+xxokAcjm2zQL0uJip4RCrPICFsRErLZ7DMGBB6ia+uHMm
         EYuObp7A3gzYScsUT8dfPLP/11gWH/60IMuyM9a+kJ4+di4B2jIEekA5G6fvVRSSyk0Q
         DZAHcILhTGzONIWvnQxHIbkKgmoK85UhJ6Z1hgi/0MWK9nQ/YQ+QUa4IArzulTJnhAow
         mwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmJzxumpLQcs11vK+3c+4EgOpxANBX6MJwGXngCOMXo=;
        b=SLoPAfXFBu+pl+qVsWAo1kxeayrAcwg5oLfDW8KzeSv7eNul03TFD2YOZLu7l3CBrW
         +oDdAQgl/taNFePa9YCmHai1NYoqzLbhfc7YuxRnqjzRPpdJx/MekwP6q1lSF+YkRFLW
         7OEtcVFPACXCZcZqAT30ZGK6ZCsHeXZ1f8HY/zz7qrVgsIQF0rxJMCui5Z5u16GVVPIj
         hOeIxN6+OZpd8GZXTM33eF/8nG97UJjjlXIsoljK2N0pUg11L5tMzB9/X6TZFY3Jlfmk
         mdOnSBrFr+lu+Iytftd7HJXs51okyaXAe/sc+GwgmTancAHyM9C3T7HM3kamnRcwAoTZ
         fC/w==
X-Gm-Message-State: AOAM533ajCSGf2GuhhL8L9qsAK4RHyc5BG2xV07K+FYkGiWWs4wRXHsh
        D/c2iQL0+4vN41DnFPJ95mw=
X-Google-Smtp-Source: ABdhPJyiRVrIl5E62lC8T6N06sfiBY9MLsiGEZ1cVBohHNstoW03QKjOTDNUo/ItSF2GAqvqzrPrpg==
X-Received: by 2002:a50:fe0d:0:b0:415:e2ee:65af with SMTP id f13-20020a50fe0d000000b00415e2ee65afmr4811578edt.383.1648105491201;
        Thu, 24 Mar 2022 00:04:51 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id d24-20020a1709067a1800b006e021f4c1c3sm753022ejo.166.2022.03.24.00.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:04:50 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] ACPI: ipmi: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:04:41 +0100
Message-Id: <20220324070441.56591-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/acpi/acpi_ipmi.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index a5fe2926bf50..0555f68c2dfd 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -353,29 +353,27 @@ static void ipmi_flush_tx_msg(struct acpi_ipmi_device *ipmi)
 static void ipmi_cancel_tx_msg(struct acpi_ipmi_device *ipmi,
 			       struct acpi_ipmi_msg *msg)
 {
-	struct acpi_ipmi_msg *tx_msg, *temp;
-	bool msg_found = false;
+	struct acpi_ipmi_msg *tx_msg = NULL, *iter, *temp;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ipmi->tx_msg_lock, flags);
-	list_for_each_entry_safe(tx_msg, temp, &ipmi->tx_msg_list, head) {
-		if (msg == tx_msg) {
-			msg_found = true;
-			list_del(&tx_msg->head);
+	list_for_each_entry_safe(iter, temp, &ipmi->tx_msg_list, head) {
+		if (msg == iter) {
+			tx_msg = iter;
+			list_del(&iter->head);
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&ipmi->tx_msg_lock, flags);
 
-	if (msg_found)
+	if (tx_msg)
 		acpi_ipmi_msg_put(tx_msg);
 }
 
 static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 {
 	struct acpi_ipmi_device *ipmi_device = user_msg_data;
-	bool msg_found = false;
-	struct acpi_ipmi_msg *tx_msg, *temp;
+	struct acpi_ipmi_msg *tx_msg = NULL, *iter, *temp;
 	struct device *dev = ipmi_device->dev;
 	unsigned long flags;
 
@@ -387,16 +385,16 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
 	}
 
 	spin_lock_irqsave(&ipmi_device->tx_msg_lock, flags);
-	list_for_each_entry_safe(tx_msg, temp, &ipmi_device->tx_msg_list, head) {
-		if (msg->msgid == tx_msg->tx_msgid) {
-			msg_found = true;
-			list_del(&tx_msg->head);
+	list_for_each_entry_safe(iter, temp, &ipmi_device->tx_msg_list, head) {
+		if (msg->msgid == iter->tx_msgid) {
+			tx_msg = iter;
+			list_del(&iter->head);
 			break;
 		}
 	}
 	spin_unlock_irqrestore(&ipmi_device->tx_msg_lock, flags);
 
-	if (!msg_found) {
+	if (!tx_msg) {
 		dev_warn(dev,
 			 "Unexpected response (msg id %ld) is returned.\n",
 			 msg->msgid);
@@ -482,15 +480,14 @@ static void ipmi_register_bmc(int iface, struct device *dev)
 
 static void ipmi_bmc_gone(int iface)
 {
-	struct acpi_ipmi_device *ipmi_device, *temp;
-	bool dev_found = false;
+	struct acpi_ipmi_device *ipmi_device = NULL, *iter, *temp;
 
 	mutex_lock(&driver_data.ipmi_lock);
-	list_for_each_entry_safe(ipmi_device, temp,
+	list_for_each_entry_safe(iter, temp,
 				 &driver_data.ipmi_devices, head) {
-		if (ipmi_device->ipmi_ifnum != iface) {
-			dev_found = true;
-			__ipmi_dev_kill(ipmi_device);
+		if (iter->ipmi_ifnum != iface) {
+			ipmi_device = iter;
+			__ipmi_dev_kill(iter);
 			break;
 		}
 	}
@@ -500,7 +497,7 @@ static void ipmi_bmc_gone(int iface)
 					struct acpi_ipmi_device, head);
 	mutex_unlock(&driver_data.ipmi_lock);
 
-	if (dev_found) {
+	if (ipmi_device) {
 		ipmi_flush_tx_msg(ipmi_device);
 		acpi_ipmi_dev_put(ipmi_device);
 	}

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

