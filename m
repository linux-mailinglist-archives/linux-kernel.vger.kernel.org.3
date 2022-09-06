Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89E5ADFB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiIFGX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbiIFGXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:23:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F63229807;
        Mon,  5 Sep 2022 23:23:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o4so10229900pjp.4;
        Mon, 05 Sep 2022 23:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OjOO2eTxjzUgiDmCCyRIaBy3rv+D3YVNkyt3aCr9uz4=;
        b=CAlmmmdLxymOcqdT4s8jUfswfQ8/xKoClYmcg7f1QXN5jMkUuoMI1OkN5Ymf1tKjfF
         PpmRGH1b8Zqre5hBIiK+4FKLLfsv8sb7IiuzoXN8vGKErYsMrueGIDmoJ2f8k7u0NADu
         2SbhXSLsl/b7odYPc4NXcbcFNWE9hMGrYNgF2E/i2Wg0YQOD9A0qE0+vrZUzJI1ELf1O
         SuC9v8p1sQR2thBYp9pZQLHoP1jSK8vIAG/Y7CuFpTfvNSNj90L/I6hbjIGQWbUmj5V3
         68BXNc6xdj+zwsHzWG3V7BoJdn2XfnhWfAK/HifsnJa4iqEbsfLIsesAlRI0jvh40KUY
         ozAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OjOO2eTxjzUgiDmCCyRIaBy3rv+D3YVNkyt3aCr9uz4=;
        b=cdiVZvFICW+0xGd9f4IqKnId+u06rGBr2CxmnSaL6yhK7Pdvr8YIbj5qEepdi6g5ZU
         93iUNkoa5YTyrThJUIV/jxZZYvARftFdkTRF4fBQrNlgeElgJozhUM3GB7WSs5EBPCxs
         rJ/rfzzbMkyPERhCpMVO7GqekXgWMA0p3NqwXSCQluURtTyWgr2oVeXNstHCEuHnrZZD
         EO8MW7PIJDK4JthZpF4wK+mv+HGk0JUWtrpMyx51hCxH7EfIqthx0OfP0fm4DuC+RtZ7
         ga63OCK2QOil/K+Y0TOhf0geK/MZkoCtLRQItt01yUDj4wO8f4Ya54eVzt5igwDTlku5
         OqLw==
X-Gm-Message-State: ACgBeo1LHA/pPNs4xLqID28/o//dgryWpGdVpBEOus6YvUyuO7zXWTLO
        30pe84GBs3W1GEsYny11W3sOjcWeHWA=
X-Google-Smtp-Source: AA6agR75et+nHC4NSvO2cAENtR680aqE+PjQF1X4ZsAZGVwMuNgnB4w1YlXRbCXU3pk8Z61IHgODLw==
X-Received: by 2002:a17:902:7204:b0:172:663f:80b7 with SMTP id ba4-20020a170902720400b00172663f80b7mr53258432plb.115.1662445428175;
        Mon, 05 Sep 2022 23:23:48 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id c16-20020a17090ab29000b002000d577cc3sm6154952pjr.55.2022.09.05.23.23.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Sep 2022 23:23:47 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH] phy: usb: free the buffer after reading a given nvmem cell
Date:   Tue,  6 Sep 2022 14:23:02 +0800
Message-Id: <1662445382-29879-1-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kfree() to free the buffer after calling nvmem_cell_read() to
read a given nvmem cell.

Fixes:99d9ccd97385("phy: usb: Add USB2.0 phy driver for Sunplus SP7021")
Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
 drivers/phy/sunplus/phy-sunplus-usb2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
index 5269968..c8540e1 100644
--- a/drivers/phy/sunplus/phy-sunplus-usb2.c
+++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
@@ -13,6 +13,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
@@ -92,13 +93,15 @@ static int update_disc_vol(struct sp_usbphy *usbphy)
 	otp_v = nvmem_cell_read(cell, &otp_l);
 	nvmem_cell_put(cell);
 
-	if (otp_v) {
+	if (!IS_ERR(otp_v)) {
 		set = *(otp_v + 1);
 		set = (set << (sizeof(char) * 8)) | *otp_v;
 		set = (set >> usbphy->disc_vol_addr_off) & J_DISC;
+		
+		kfree(otp_v);
 	}
-
-	if (!otp_v || set == 0)
+	
+	if (IS_ERR(otp_v) || (set == 0))
 		set = OTP_DISC_LEVEL_DEFAULT;
 
 	val = readl(usbphy->phy_regs + CONFIG7);
@@ -294,3 +297,4 @@ module_platform_driver(sunplus_usb_phy_driver);
 MODULE_AUTHOR("Vincent Shih <vincent.shih@sunplus.com>");
 MODULE_DESCRIPTION("Sunplus USB 2.0 phy driver");
 MODULE_LICENSE("GPL");
+
-- 
2.7.4

