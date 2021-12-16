Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9648476783
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhLPBry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhLPBry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:47:54 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BEC061574;
        Wed, 15 Dec 2021 17:47:54 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id k4so21618940pgb.8;
        Wed, 15 Dec 2021 17:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=I+AOmwm2BG541EsRFlS96j4s+ZQa+V+JtdC+54LpZE0=;
        b=MkZM9t8FM37d+qg+Qp6jvP/F7EjoAXrYnR5fGp3I5M1uO82mxywxp6pg0rlAsCAIYS
         M6qrOxuFC54DFAg2wdsgtSC2BjFXtHtgJDaU3KoxkO4dVyDrCG6F8fssms7UaTY0hbfz
         c1I2HiGlVAiR38w3zMcjAw8CNaKMPx03SiV6gQZzAWzCohl03pi7ArVQ7OyTZtHn7UOw
         m9vbTxhT/aCJMneQLM40Vpw6V4FmR2lG9e1YQZWam5K0mTWdgB9lcmmZriihbRN1Egeq
         mMaGxklrkgFNkp4aZBZ2Gta3xHDMwsl3hffTPltwkqbmLyfoIsgW5qyQltUiPR+zOm7o
         8h1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I+AOmwm2BG541EsRFlS96j4s+ZQa+V+JtdC+54LpZE0=;
        b=D+7sJwPQpNAbTuzHb3rBy/I5j+4Zi8zSmfQcfpXg4iqSckNgLNcp3RplWZgewPXpTA
         prV2mmADCqlg4xKnT0ow31tGAdL+J5k5u0GdEPzjnuio2wPnD7yeSXQ87rLEToUxqnv1
         9esEi4XgXx2hWeKm7F6/GzGgsTc9ro37le1PbbDkwbc33NxeV3mNzmEo2f0mr1E+SVwn
         my0+/YWIV/5W1snScpIny0YCmFP8KGMo3ACkFl1p2u2PJaKOiDxOcynGIcW4Xr8v9Jem
         vqBAj4haR03RDx9TxM5eFJG/GSs/mQb+6AYrL7pDyv9mAMKAiSfweXWbONcGQBtk5iAE
         eSpA==
X-Gm-Message-State: AOAM533z/cL2xO1krblcYEBQn89zXSLh79Fb7kSMqQRqDawzJdJcPoHA
        /YPMcT+OntxK6ZduEGlVy8w=
X-Google-Smtp-Source: ABdhPJxWPJyMEb1mIndwQ5pxfrUxe8JmopVqieVpWYe/VMB+iRM4KKtGpSFCGwft5lSxa7KGavzmhw==
X-Received: by 2002:a63:6ac2:: with SMTP id f185mr10194403pgc.198.1639619273526;
        Wed, 15 Dec 2021 17:47:53 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:468:5e1b:4e:ef0f:3395:e69f])
        by smtp.gmail.com with ESMTPSA id qe12sm6384691pjb.29.2021.12.15.17.47.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Dec 2021 17:47:53 -0800 (PST)
From:   Johnny Chuang <johnny.chuang.emc@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Harry Cutts <hcutts@chromium.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>
Cc:     James Chen <james.chen@emc.com.tw>,
        Jennifer Tsai <jennifer.tsai@emc.com.tw>,
        Paul Liang <paul.liang@emc.com.tw>,
        Jeff Chuang <jeff.chuang@emc.com.tw>
Subject: [PATCH] Input: elants_i2c - fix to check the Remark ID of the updated firmware
Date:   Thu, 16 Dec 2021 09:53:23 +0800
Message-Id: <1639619603-20616-1-git-send-email-johnny.chuang.emc@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eKTH3900/eKTH5312 series do not support
the firmware update rules of Remark ID.
Exclude two series and keep the original rules to check the Remark ID.

Signed-off-by: Johnny Chuang <johnny.chuang.emc@gmail.com>
---
 drivers/input/touchscreen/elants_i2c.c | 48 +++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 7e13a66..99151a1 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -117,6 +117,19 @@
 #define ELAN_POWERON_DELAY_USEC	500
 #define ELAN_RESET_DELAY_MSEC	20
 
+/* FW boot code version */
+#define BC_VER_H_BYTE_FOR_EKTH3900x1_I2C        0x72
+#define BC_VER_H_BYTE_FOR_EKTH3900x2_I2C        0x82
+#define BC_VER_H_BYTE_FOR_EKTH3900x3_I2C        0x92
+#define BC_VER_H_BYTE_FOR_EKTH5312x1_I2C        0x6D
+#define BC_VER_H_BYTE_FOR_EKTH5312x2_I2C        0x6E
+#define BC_VER_H_BYTE_FOR_EKTH5312cx1_I2C       0x77
+#define BC_VER_H_BYTE_FOR_EKTH5312cx2_I2C       0x78
+#define BC_VER_H_BYTE_FOR_EKTH5312x1_I2C_USB    0x67
+#define BC_VER_H_BYTE_FOR_EKTH5312x2_I2C_USB    0x68
+#define BC_VER_H_BYTE_FOR_EKTH5312cx1_I2C_USB   0x74
+#define BC_VER_H_BYTE_FOR_EKTH5312cx2_I2C_USB   0x75
+
 enum elants_chip_id {
 	EKTH3500,
 	EKTF3624,
@@ -736,6 +749,37 @@ static int elants_i2c_validate_remark_id(struct elants_data *ts,
 	return 0;
 }
 
+static bool elants_i2c_check_remark_id(struct elants_data *ts)
+{
+	struct i2c_client *client = ts->client;
+	bool check;
+	const u8 bootcode_version = ts->iap_version;
+
+	/* I2C eKTH3900 and eKTH5312 are NOT support Remark ID */
+	if ((bootcode_version == BC_VER_H_BYTE_FOR_EKTH3900x1_I2C) ||
+	    (bootcode_version == BC_VER_H_BYTE_FOR_EKTH3900x2_I2C) ||
+	    (bootcode_version == BC_VER_H_BYTE_FOR_EKTH3900x3_I2C) ||
+	    (bootcode_version == BC_VER_H_BYTE_FOR_EKTH5312x1_I2C) ||
+	    (bootcode_version == BC_VER_H_BYTE_FOR_EKTH5312x2_I2C) ||
+	    (bootcode_version == BC_VER_H_BYTE_FOR_EKTH5312cx1_I2C) ||
+	    (bootcode_version == BC_VER_H_BYTE_FOR_EKTH5312cx2_I2C) ||
+	    (bootcode_version == BC_VER_H_BYTE_FOR_EKTH5312x1_I2C_USB) ||
+	    (bootcode_version == BC_VER_H_BYTE_FOR_EKTH5312x2_I2C_USB) ||
+	    (bootcode_version == BC_VER_H_BYTE_FOR_EKTH5312cx1_I2C_USB) ||
+	    (bootcode_version == BC_VER_H_BYTE_FOR_EKTH5312cx2_I2C_USB)) {
+		dev_dbg(&client->dev,
+			"eKTH3900/eKTH5312(0x%02x) are not support remark id\n",
+			bootcode_version);
+		check = false;
+	} else if (bootcode_version >= 0x60) {
+		check = true;
+	} else {
+		check = false;
+	}
+
+	return check;
+}
+
 static int elants_i2c_do_update_firmware(struct i2c_client *client,
 					 const struct firmware *fw,
 					 bool force)
@@ -749,7 +793,9 @@ static int elants_i2c_do_update_firmware(struct i2c_client *client,
 	u16 send_id;
 	int page, n_fw_pages;
 	int error;
-	bool check_remark_id = ts->iap_version >= 0x60;
+	bool check_remark_id;
+
+	check_remark_id = elants_i2c_check_remark_id(ts);
 
 	/* Recovery mode detection! */
 	if (force) {
-- 
2.7.4

