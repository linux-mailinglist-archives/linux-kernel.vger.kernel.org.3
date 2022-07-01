Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149CB562928
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiGACdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGACdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:06 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955CD61D47
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:33:04 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id n14so571193ilt.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlbnaEqCidtZ1IsIVoOW+yFrCUvdpeAARh0QiP5ra+4=;
        b=hgMA5IaNEQGVX4tCJORAIeJL5ttQsw1ynuCCqxQzbCpOHpuyFn9xx1W/Z5cFbU0oji
         a9j6coiNkovqlZ+ua7IR/1+Lii7JBza0DJELtH1rPNRMM1fl3EH/OOW9unhxAKmWyYaS
         R4uuc30Za5qz7UkrAF15Ys1JBSCt7tYCeBbh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlbnaEqCidtZ1IsIVoOW+yFrCUvdpeAARh0QiP5ra+4=;
        b=MBKSg8KxpWn3aNZIXNBhFbeqvYq7TUqQ9VkwRoeir0YImpDD0MpVLcqCagM4aaD1wV
         rhQveGXYrOsIyw9JLJ629TjcJXzTep1NLRBBpk+zKKM3CctBeGI7ZCFM4KchKCcEFw8M
         NNHBz1MV7Leb6DrhQrQSGOKXsoxRPx8zDX46Pqj48rc8g+1L2yw4ftdb0389JuLfGo1V
         lGr+Qv1aFQ3KV55v5X4TB5TTBT6JpmU8Ut4V0qQghLgikQ8aCDF2FxTGAYE2Ry5En4Wk
         YlZW09Q7Fih/d8BN0KiZVXBU9HeoN9fmlJM18Zeunw06RoTr3/jlbh5ol0VWfDkYm5XC
         UOmg==
X-Gm-Message-State: AJIora9hSWMtukC3+7TJ2AAtlAH+Lg4dv7JvJoa4n9BNDly/xdkl5ZVS
        pBOmFC9RAYDAEBmFUbsFUE6hw6S+iVwBuw==
X-Google-Smtp-Source: AGRyM1vPgMm/1TZoX1vO3Z/rwg1WNyTW0iGMdhlaZpO5ueZadQtPjywpiPRp/t95GiP2dsGBYKJ45w==
X-Received: by 2002:a05:6e02:1c42:b0:2da:6f6f:f149 with SMTP id d2-20020a056e021c4200b002da6f6ff149mr6907890ilg.86.1656642784041;
        Thu, 30 Jun 2022 19:33:04 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a22-20020a027356000000b00331cfbce17csm9367869jae.100.2022.06.30.19.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 19:33:03 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] misc: rtsx_usb: use separate command and response buffers
Date:   Thu, 30 Jun 2022 20:32:56 -0600
Message-Id: <07e3721804ff07aaab9ef5b39a5691d0718b9ade.1656642167.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1656642167.git.skhan@linuxfoundation.org>
References: <cover.1656642167.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtsx_usb uses same buffer for command and response. There could
be a potential conflict using the same buffer for both especially
if retries and timeouts are involved.

Use separate command and response buffers to avoid conflicts.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/misc/cardreader/rtsx_usb.c | 26 +++++++++++++++++---------
 include/linux/rtsx_usb.h           |  1 -
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index e147cc8ab0fd..4e2108052509 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -631,15 +631,18 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 
 	ucr->pusb_dev = usb_dev;
 
-	ucr->iobuf = kmalloc(IOBUF_SIZE, GFP_KERNEL);
-	if (!ucr->iobuf)
+	ucr->cmd_buf = kmalloc(IOBUF_SIZE, GFP_KERNEL);
+	if (!ucr->cmd_buf)
 		return -ENOMEM;
 
+	ucr->rsp_buf = kmalloc(IOBUF_SIZE, GFP_KERNEL);
+	if (!ucr->rsp_buf)
+		goto out_free_cmd_buf;
+
 	usb_set_intfdata(intf, ucr);
 
 	ucr->vendor_id = id->idVendor;
 	ucr->product_id = id->idProduct;
-	ucr->cmd_buf = ucr->rsp_buf = ucr->iobuf;
 
 	mutex_init(&ucr->dev_mutex);
 
@@ -667,9 +670,11 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 
 out_init_fail:
 	usb_set_intfdata(ucr->pusb_intf, NULL);
-	kfree(ucr->iobuf);
-	ucr->iobuf = NULL;
-	ucr->cmd_buf = ucr->rsp_buf = NULL;
+	kfree(ucr->rsp_buf);
+	ucr->rsp_buf = NULL;
+out_free_cmd_buf:
+	kfree(ucr->cmd_buf);
+	ucr->cmd_buf = NULL;
 	return ret;
 }
 
@@ -682,9 +687,12 @@ static void rtsx_usb_disconnect(struct usb_interface *intf)
 	mfd_remove_devices(&intf->dev);
 
 	usb_set_intfdata(ucr->pusb_intf, NULL);
-	kfree(ucr->iobuf);
-	ucr->iobuf = NULL;
-	ucr->cmd_buf = ucr->rsp_buf = NULL;
+
+	kfree(ucr->cmd_buf);
+	ucr->cmd_buf = NULL;
+
+	kfree(ucr->rsp_buf);
+	ucr->rsp_buf = NULL;
 }
 
 #ifdef CONFIG_PM
diff --git a/include/linux/rtsx_usb.h b/include/linux/rtsx_usb.h
index a07f7341ebc2..3247ed8e9ff0 100644
--- a/include/linux/rtsx_usb.h
+++ b/include/linux/rtsx_usb.h
@@ -54,7 +54,6 @@ struct rtsx_ucr {
 	struct usb_device	*pusb_dev;
 	struct usb_interface	*pusb_intf;
 	struct usb_sg_request	current_sg;
-	unsigned char		*iobuf;
 
 	struct timer_list	sg_timer;
 	struct mutex		dev_mutex;
-- 
2.34.1

