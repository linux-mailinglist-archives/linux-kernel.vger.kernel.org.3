Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC3524170
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349607AbiELAQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349611AbiELAPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:15:54 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5636586;
        Wed, 11 May 2022 17:15:49 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e2fa360f6dso4861061fac.2;
        Wed, 11 May 2022 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uocv32A42nu0KZF7Yg0Y4JkBC2sf3Jsh4f2LBZHV7do=;
        b=CLylvKJ7toAIWbWncI9CKpK04030wQp7GI52qUfnWV2M9naUOsmaoJi3NBs5aIAXPy
         i9zG2rJqJhulsH9n3T67Sik8zTTb4fvpGXDAdJRBfXHZiXWTbCOhpOsfkfUYDfNgvOt1
         uJ9/9+FVKc1YJOtAseNwxrI8KvabUHKzBzRBLGYMHE4AOquD3EAC22Cuukc4WHh+pHhq
         KPF7KUouHdKPgG75q7b0/MW7sKVhg1oAsaAv6p2a491qgqZdS++7/7CcRl10rkTu+hvt
         DFVpY3lUtRXVhtVFBSG/Bejdy3PwlfHVHrKx21me2SxS4zC61JsVz3Rby1S+L1GW4syl
         oyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uocv32A42nu0KZF7Yg0Y4JkBC2sf3Jsh4f2LBZHV7do=;
        b=UgMZRmhLwWgcpgpeeTwnT/0LhR/eVJFm9KfQsRa+0minWTDfpW8kkL24e5sZD3x1E/
         RqlZOSdIPz1RmjFa0vzx9bD6guTsEojsaC/N3r+d7QO2uwIWcmyg/kwvSH1U3OesPKF4
         IfDLYI5QjI+M1HYSQSCMU8mCm+/9QS7aHwDgYAxclEQIN5pwkOEM+VYFFX+fG5t3Q+6+
         kaJWKzhuNQiN2mr5SQqaoDOAn0Zk2EhQ42FQ2goNjmnsKtAxdu0oa4+GplD2GZQs6nrx
         vjs3GnrXcMwn+5z7Uop3iCMP4uyfW9FZvcXCEXelMvkB1sjEmdm8DlAicOSQHcvKRMHg
         Ra0Q==
X-Gm-Message-State: AOAM531c61AzZZgYlO4Zbeq5XT4M7T4dCoButa8obBM/8Y9+WR4WGAXI
        Z1mzUJS7rK2qSv9/mN2wZQhwhKArwdw0vg==
X-Google-Smtp-Source: ABdhPJwoDecLr2WXu80NgjTEUn84SQe11nQvDvepCnDLJCLW5E0woMI4dASTPgEEhcQZl/Gn4kWyVg==
X-Received: by 2002:a05:6870:4341:b0:da:b3f:2b26 with SMTP id x1-20020a056870434100b000da0b3f2b26mr4359163oah.197.1652314548599;
        Wed, 11 May 2022 17:15:48 -0700 (PDT)
Received: from max-lenovo.. (169-231-139-87.wireless.ucsb.edu. [169.231.139.87])
        by smtp.gmail.com with ESMTPSA id z23-20020a9d65d7000000b0060603221235sm1392635oth.5.2022.05.11.17.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 17:15:48 -0700 (PDT)
From:   Max Fletcher <fletcher0max@gmail.com>
To:     djogorchock@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Max Fletcher <fletcher0max@gmail.com>
Subject: [PATCH 2/2] HID: nintendo: add parameter to swap face buttons
Date:   Wed, 11 May 2022 17:15:00 -0700
Message-Id: <20220512001500.16739-2-fletcher0max@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512001500.16739-1-fletcher0max@gmail.com>
References: <20220512001500.16739-1-fletcher0max@gmail.com>
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

Add the module parameter "faceswap" that swaps the face (ABXY) buttons to match the printed layout. This will be helpful for people who prefer to use the Nintendo layout over the Xbox layout.

Signed-off-by: Max Fletcher <fletcher0max@gmail.com>
---
 drivers/hid/hid-nintendo.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 7735971ede3f..925cdcd0ac77 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -32,6 +32,7 @@
 #include <linux/jiffies.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/power_supply.h>
 #include <linux/spinlock.h>
 
@@ -320,6 +321,8 @@ struct joycon_imu_cal {
 	s16 scale[3];
 };
 
+bool faceswap;
+
 /*
  * All the controller's button values are stored in a u32.
  * They can be accessed with bitwise ANDs.
@@ -1351,10 +1354,17 @@ static void joycon_parse_report(struct joycon_ctlr *ctlr,
 		input_report_key(dev, BTN_START, btns & JC_BTN_PLUS);
 		input_report_key(dev, BTN_THUMBR, btns & JC_BTN_RSTICK);
 		input_report_key(dev, BTN_MODE, btns & JC_BTN_HOME);
-		input_report_key(dev, BTN_X, btns & JC_BTN_Y);
-		input_report_key(dev, BTN_Y, btns & JC_BTN_X);
-		input_report_key(dev, BTN_B, btns & JC_BTN_A);
-		input_report_key(dev, BTN_A, btns & JC_BTN_B);
+		if (!faceswap) {
+			input_report_key(dev, BTN_X, btns & JC_BTN_Y);
+			input_report_key(dev, BTN_Y, btns & JC_BTN_X);
+			input_report_key(dev, BTN_B, btns & JC_BTN_A);
+			input_report_key(dev, BTN_A, btns & JC_BTN_B);
+		} else {
+			input_report_key(dev, BTN_Y, btns & JC_BTN_Y);
+			input_report_key(dev, BTN_X, btns & JC_BTN_X);
+			input_report_key(dev, BTN_A, btns & JC_BTN_A);
+			input_report_key(dev, BTN_B, btns & JC_BTN_B);
+		}
 	}
 
 	input_sync(dev);
@@ -2313,6 +2323,10 @@ static const struct hid_device_id nintendo_hid_devices[] = {
 };
 MODULE_DEVICE_TABLE(hid, nintendo_hid_devices);
 
+module_param(faceswap, bool, 0440);
+MODULE_PARM_DESC(faceswap,
+		 "Swaps the face buttons to match the printed layout");
+
 static struct hid_driver nintendo_hid_driver = {
 	.name		= "nintendo",
 	.id_table	= nintendo_hid_devices,
-- 
2.35.3

