Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0845AA8E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiIBHmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbiIBHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:42:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1857EB95B2;
        Fri,  2 Sep 2022 00:42:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so1390284pji.1;
        Fri, 02 Sep 2022 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Z0YY5SlVj7HcaFNWbRM+lhVkfrb4GMSpXziny001FcU=;
        b=hqgsjhzB1o8wTQ602kSCRkczNJTT09e/8jNlx/ixm2EajvVGpQFqhJHgATya/tI37W
         vxGKayvxCiJ0zzj5yVPiEgKCYRm09/SUMoDpBPsk/3GWY/h2po5+g6lRZ3zApF/y7vxq
         raGH4A4DHR5zxJXGS6tMXoig5IQGRrFfQgcYOyOyd2AMbX1PF6sCVtsfUPur55XsjdGn
         xFEm4bAaJVfCYr4svO5GJnPgID0NFy0FQObArBDduLnmEQMjwH5RHTVZ8qTZQuQrUzDV
         1g2fLKht502RUlfm3qx2Zu1oahkaw6ulVPDE/F3HCwgdV9DVxsgH0CQvrRp00c1jYcMO
         YJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Z0YY5SlVj7HcaFNWbRM+lhVkfrb4GMSpXziny001FcU=;
        b=UfqdiBuRI9uEFoooZP7HvqXUQ4/ohn5mSPK9PcViP6554g6WbLiEhQpnoCj8B8CYhR
         A83e8zkjbsmsgtMOHXBD7iK8IsxmRVCfp/yem//Im1uSO9i7GPM2b/U+SdTHmfKj8ZwM
         mkZWGNTQcr6CXnlop/enUaDs760fqYQy0Z9rFEMkxg2y56hWta0Px8zAfzabmmHyBSCQ
         Y0cFy4d2EN1KqqU7FUiGstHL221JfsxF+lrfC7zywGcKmA6/gBKVXYOj9NDNuVrEl2Sd
         ZNJKSROcK5ZgoORCRXqswlPbMmB/uZqBCS+BF2MTjJZIAdcSM/gCgV+8YYpXbDULqDwr
         Io4Q==
X-Gm-Message-State: ACgBeo2Uzr7yygCEW5KHsRnVl8Ieu/MGzFVZ51OAvU/+QOAfiBKMppnd
        5PfoK6/24NeP+yLNo6NXxI2BHphJVbY=
X-Google-Smtp-Source: AA6agR44WL03ikpEw2iC0BP9uX0OPoF5iXx+3bxru1JRr0ztgOTQx1b6r6p2JiOhIyeXNg1wRLUlug==
X-Received: by 2002:a17:903:1209:b0:16b:81f6:e952 with SMTP id l9-20020a170903120900b0016b81f6e952mr35888420plh.48.1662104523554;
        Fri, 02 Sep 2022 00:42:03 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id p3-20020aa79e83000000b005371689d70fsm941905pfq.120.2022.09.02.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:42:03 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/acpi/acpi_video: check return value of acpi_get_parent()
Date:   Fri,  2 Sep 2022 00:41:44 -0700
Message-Id: <20220902074144.2209674-1-floridsleeves@gmail.com>
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

Check return status of acpi_get_parent() to confirm whether it fails.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/acpi/acpi_video.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 5cbe2196176d..5fca9a39b1a4 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+	// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  video.c - ACPI Video Driver
  *
@@ -1753,6 +1753,7 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 	int result;
 	static int count;
 	char *name;
+	acpi_status status;
 
 	result = acpi_video_init_brightness(device);
 	if (result)
@@ -1766,8 +1767,9 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 		return;
 	count++;
 
-	acpi_get_parent(device->dev->handle, &acpi_parent);
-
+	status = acpi_get_parent(device->dev->handle, &acpi_parent);
+	if (ACPI_FAILURE(status))
+		return;
 	pdev = acpi_get_pci_dev(acpi_parent);
 	if (pdev) {
 		parent = &pdev->dev;
-- 
2.25.1

