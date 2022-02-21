Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E164BE534
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355521AbiBULMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:12:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355758AbiBULMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:12:22 -0500
X-Greylist: delayed 244 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 02:45:55 PST
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C2B24B;
        Mon, 21 Feb 2022 02:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645440353;
        bh=4fADd5ckbj9wLsNGEkx/YWl2k1NstFX4D6yO2oX22N8=;
        h=From:To:Cc:Subject:Date;
        b=PHaq+c8CRFQrqVX1bOSiEyUc5E5SzgmuMEyyZILgJRJj3tUm3XaVHjvTOScJwOHYL
         etsu5zHu1SgZ+rSKgDOfJczgsZSNwsgHr/9FWbVRGa37dpKGrsiii9yw3jbm+0kLtm
         DFkqRoWjSchefQtg1j5YWKviVYN7wSk2aVD3hgWA=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id 9A09E009; Mon, 21 Feb 2022 18:38:32 +0800
X-QQ-mid: xmsmtpt1645439912ty8r1galu
Message-ID: <tencent_AD2E09472E455F78B792E6BF114813B35206@qq.com>
X-QQ-XMAILINFO: Mx0gLVTpyl5nsAzj444ETocQ8S8QzHpdIe2WK5gE/ckWOfMwwiPqe8ilfBIyK6
         ObfwC/6GBi8sc4OCc/rKxo8kHDrLFR39OPI7aep7JK2Lj3eo+I1GX/hvMMNq4hhurBjTJKIFHK/H
         WbF/gDL8p9JT5N23RdNegZchcVNYTWzf8eS2qWoVkMnsKG+ZlB87nPPh7ZbK9tJgxFTELA4LCf+H
         0xL74nJKSyx6osOoKUKZWAL+L6d4wpRHKvQ3kHbtVbWmjDvOkJ2Zlat22wAwfAYdkfToo444yH3h
         deSvFU5NrEmQyqcof17yIOEM1vZ7z+BZ8/rJnrqqRJiScLFK5LUPqjhazqEQxrf2amQUAj6iCSDa
         JtHIvZo8PkoU9VnoUe+c7Z/aRV++LMv6OJGTxJwfZRtfDoI+gNmIx1iRIyk3eX5Ezqy8FqyIMzSE
         4ZPBKp3eJ8M8jBNtWIA9uU9KCzQ/Zkpbax/DgyE0y7gB1m6OVbGRoucVLo060+SsLTUy/uexUDgG
         BtM71IXXh9mKwXkIsT3RK0HNMom+DsArAilPfTkUPnUiRmwwDHOrDQ2VORWY0+W9Z2hh2pdXybWb
         /vw6tTGs0TV1IIMO17Qi/QcfgRZJFDJg3bh2B+QLrsigS7Z4Fag8fxO0Mgym1ePPVOFyxqZKnsWa
         qR2uC1AQbiDBA4/kIsUTSlIRUbys1qMFnQmslLjQMOG8328ncJdv7slSUeGpB4VMPVORbHdLYfL5
         QhV8WZKygAu3hs1cfxeXX3FhAVEamIoHOtX6GkTKgs8D2dgkTUM0tXU8kCJd0CzQ6VVyGwcHz3w2
         A2ASV9jox6ygtf8UmdYqANgxEryX8GxMeSwMNzdSI02uPhUXR7rHqfOz5bUZGG1MoVL7qitnRTkM
         GdjFO0xNBd
From:   xkernel.wang@foxmail.com
To:     FlorianSchandinat@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] video: fbdev: via: check the return value of kstrdup()
Date:   Mon, 21 Feb 2022 18:37:34 +0800
X-OQ-MSGID: <20220221103734.3394-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kstrdup() is a memory allocation function which can return NULL when
some internal memory errors happen. It is better to check the return
value of it to catch the error in time during the setup of viafb.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/video/fbdev/via/viafbdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 22deb34..2d67c92 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -1939,8 +1939,12 @@ static int __init viafb_setup(void)
 
 		if (!strncmp(this_opt, "viafb_mode1=", 12)) {
 			viafb_mode1 = kstrdup(this_opt + 12, GFP_KERNEL);
+			if (!viafb_mode1)
+				return -ENOMEM;
 		} else if (!strncmp(this_opt, "viafb_mode=", 11)) {
 			viafb_mode = kstrdup(this_opt + 11, GFP_KERNEL);
+			if (!viafb_mode)
+				return -ENOMEM;
 		} else if (!strncmp(this_opt, "viafb_bpp1=", 11)) {
 			if (kstrtouint(this_opt + 11, 0, &viafb_bpp1) < 0)
 				return -EINVAL;
@@ -1969,6 +1973,8 @@ static int __init viafb_setup(void)
 				return -EINVAL;
 		} else if (!strncmp(this_opt, "viafb_active_dev=", 17)) {
 			viafb_active_dev = kstrdup(this_opt + 17, GFP_KERNEL);
+			if (!viafb_active_dev)
+				return -ENOMEM;
 		} else if (!strncmp(this_opt,
 			"viafb_display_hardware_layout=", 30)) {
 			if (kstrtoint(this_opt + 30, 0,
@@ -1995,8 +2001,12 @@ static int __init viafb_setup(void)
 				return -EINVAL;
 		} else if (!strncmp(this_opt, "viafb_lcd_port=", 15)) {
 			viafb_lcd_port = kstrdup(this_opt + 15, GFP_KERNEL);
+			if (!viafb_lcd_port)
+				return -ENOMEM;
 		} else if (!strncmp(this_opt, "viafb_dvi_port=", 15)) {
 			viafb_dvi_port = kstrdup(this_opt + 15, GFP_KERNEL);
+			if (!viafb_dvi_port)
+				return -ENOMEM;
 		}
 	}
 	return 0;
-- 
