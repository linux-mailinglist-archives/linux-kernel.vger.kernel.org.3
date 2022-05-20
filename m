Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA31752F306
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244328AbiETSfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352752AbiETSet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:34:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E286166697;
        Fri, 20 May 2022 11:34:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so12626555wrg.3;
        Fri, 20 May 2022 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUjvuoWXG9UUtB5iaUNqYFk22P1RS1LUvWgzlAZCFx8=;
        b=cxNMpTAFuWKDIhN2tjtgTzcHUBXt6OLUdjX8CkMUG4ILZdFepZBnJGh78f/U+ubgbK
         QEXqE2+NWORsqQ/LDWmesBeli9Yri9oXsfVwkU9T/BCYB/VdAXwXs1uO9X5YO+W4ozxT
         +cWJGLN+TCd0UrT4fKmiLNIu0+HrHlPgrjt2Jm124P7EWb1UMnWaUVsnEqObXTq3kEUz
         poL6P8AgOZIf40734QR64IOAuL1uN5lcIsH1uLLRDBuvYIPgN5o/8vrgHjW1y0rn71Ja
         rJKbeZC7cG626vR96Sdje2lKqBMm9M31UngT8JLc1Pasb7kRiIpsr/GB3tNh998kIU9v
         2YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUjvuoWXG9UUtB5iaUNqYFk22P1RS1LUvWgzlAZCFx8=;
        b=rn9Z/jsAUCZvAcTdkOMtFWjBnAMbiDnaHiUN3ASQvsBAAXNYBpmftt228nPtj+E9cN
         rfsuvuA2cJpFITxWg0Jlz2O+7R3X1Lmpl5s8DQka61a+diOIHqTUqNBF4E3vFDoW0RKg
         70YZk4J8m7KKRx8Fn3YTDgXKdBo6U9vNJolXgsuje5UnWVadkijBsbPawQkgaJ8gEvOs
         y3cxZdQjsmPRVS6XTZfe6FY6fXYvdGPBOF+HrD0ySs8SQ9BZPDPPw1mXRrpizki94x69
         i7g5jcvetfPoleDNp+Uaas/Wefm9jR6Sh0x5V8aE/Y6R1t8T1ggJOUQhX8X7P/Pt6Muw
         fR4g==
X-Gm-Message-State: AOAM53261GUTIWzYQWLZwH5Wr7CD6e7PgChjXTdQzyUdzMGLUocyGUtb
        /Lzpy8oLqOo9CH5OHfDlz9k=
X-Google-Smtp-Source: ABdhPJwFMngfZzHs1Ct+MyDR7vbVpw18F8Ve40ULToUpYV59j4RanOTU6pms5G5mJh9wNR8o8jh2iQ==
X-Received: by 2002:adf:ebce:0:b0:20d:7859:494d with SMTP id v14-20020adfebce000000b0020d7859494dmr9301298wrn.590.1653071687104;
        Fri, 20 May 2022 11:34:47 -0700 (PDT)
Received: from xws.localdomain (pd9e5a9fe.dip0.t-ipconnect.de. [217.229.169.254])
        by smtp.gmail.com with ESMTPSA id r9-20020adfa149000000b0020e62feca05sm3252081wrr.32.2022.05.20.11.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:34:46 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] HID: surface-hid: Add support for hot-removal
Date:   Fri, 20 May 2022 20:34:18 +0200
Message-Id: <20220520183422.7185-7-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520183422.7185-1-luzmaximilian@gmail.com>
References: <20220520183422.7185-1-luzmaximilian@gmail.com>
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

Add support for hot-removal of SSAM HID client devices.

Once a device has been hot-removed, further communication with it should
be avoided as it may fail and time out. While the device will be removed
as soon as we detect hot-removal, communication may still occur during
teardown, especially when unregistering notifiers.

While hot-removal is a surprise event that can happen at any time, try
to avoid communication as much as possible once it has been detected to
prevent timeouts that can slow down device removal and cause issues,
e.g. when quickly re-attaching the device.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/hid/surface-hid/surface_hid_core.c | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/surface-hid/surface_hid_core.c b/drivers/hid/surface-hid/surface_hid_core.c
index e46330b2e561..87637f813de2 100644
--- a/drivers/hid/surface-hid/surface_hid_core.c
+++ b/drivers/hid/surface-hid/surface_hid_core.c
@@ -19,12 +19,30 @@
 #include "surface_hid_core.h"
 
 
+/* -- Utility functions. ---------------------------------------------------- */
+
+static bool surface_hid_is_hot_removed(struct surface_hid_device *shid)
+{
+	/*
+	 * Non-ssam client devices, i.e. platform client devices, cannot be
+	 * hot-removed.
+	 */
+	if (!is_ssam_device(shid->dev))
+		return false;
+
+	return ssam_device_is_hot_removed(to_ssam_device(shid->dev));
+}
+
+
 /* -- Device descriptor access. --------------------------------------------- */
 
 static int surface_hid_load_hid_descriptor(struct surface_hid_device *shid)
 {
 	int status;
 
+	if (surface_hid_is_hot_removed(shid))
+		return -ENODEV;
+
 	status = shid->ops.get_descriptor(shid, SURFACE_HID_DESC_HID,
 			(u8 *)&shid->hid_desc, sizeof(shid->hid_desc));
 	if (status)
@@ -61,6 +79,9 @@ static int surface_hid_load_device_attributes(struct surface_hid_device *shid)
 {
 	int status;
 
+	if (surface_hid_is_hot_removed(shid))
+		return -ENODEV;
+
 	status = shid->ops.get_descriptor(shid, SURFACE_HID_DESC_ATTRS,
 			(u8 *)&shid->attrs, sizeof(shid->attrs));
 	if (status)
@@ -88,9 +109,18 @@ static int surface_hid_start(struct hid_device *hid)
 static void surface_hid_stop(struct hid_device *hid)
 {
 	struct surface_hid_device *shid = hid->driver_data;
+	bool hot_removed;
+
+	/*
+	 * Communication may fail for devices that have been hot-removed. This
+	 * also includes unregistration of HID events, so we need to check this
+	 * here. Only if the device has not been marked as hot-removed, we can
+	 * safely disable events.
+	 */
+	hot_removed = surface_hid_is_hot_removed(shid);
 
 	/* Note: This call will log errors for us, so ignore them here. */
-	ssam_notifier_unregister(shid->ctrl, &shid->notif);
+	__ssam_notifier_unregister(shid->ctrl, &shid->notif, !hot_removed);
 }
 
 static int surface_hid_open(struct hid_device *hid)
@@ -109,6 +139,9 @@ static int surface_hid_parse(struct hid_device *hid)
 	u8 *buf;
 	int status;
 
+	if (surface_hid_is_hot_removed(shid))
+		return -ENODEV;
+
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -126,6 +159,9 @@ static int surface_hid_raw_request(struct hid_device *hid, unsigned char reportn
 {
 	struct surface_hid_device *shid = hid->driver_data;
 
+	if (surface_hid_is_hot_removed(shid))
+		return -ENODEV;
+
 	if (rtype == HID_OUTPUT_REPORT && reqtype == HID_REQ_SET_REPORT)
 		return shid->ops.output_report(shid, reportnum, buf, len);
 
-- 
2.36.1

