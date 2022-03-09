Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5650C4D35C6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbiCIQsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiCIQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:14 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBE6C1172;
        Wed,  9 Mar 2022 08:23:38 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7EF08E000B;
        Wed,  9 Mar 2022 16:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEPSbW9S4d2L35mbOYIMHxYeEfgjpCAR1ZuLCMs0vvE=;
        b=VGyCHZL3Y8HGCs4fwbr360lrpNe3EBRtoAAl7M8fFalidHko51klB1xnMggG7Hkb+OzwJc
        Jqald3bNvBj/pOd1qtGv9QXh8cWlGzWWLuwZu3SCLNgZFy58YcYDV1Oqb2ABpwxCe15yeR
        unGqq/iHozFdYTkj0CkI+toEoYn5jnXthIpJHmjGtd+sILxco7uCqQCn74fdtcoWM+KV9D
        BxtOPzpBKatEBm+VvCkFpMTYDhsaaL+OwyzzE/3Vk9hnk7lH0IxYBrSBFyKys5ylXboc1Z
        r811m2rr9d0Djjo9neDNUcYkR21N9aVYT+DDV8k9bjJi4DHFQVdi2xa8N/I2PA==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/29] rtc: efi: switch to devm_rtc_allocate_device
Date:   Wed,  9 Mar 2022 17:22:54 +0100
Message-Id: <20220309162301.61679-23-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to devm_rtc_allocate_device/devm_rtc_register_device, this allows
for further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-efi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index 138c5e0046c8..0c0e382c22e2 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -261,15 +261,16 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 	if (efi.get_time(&eft, &cap) != EFI_SUCCESS)
 		return -ENODEV;
 
-	rtc = devm_rtc_device_register(&dev->dev, "rtc-efi", &efi_rtc_ops,
-					THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&dev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
-	rtc->uie_unsupported = 1;
 	platform_set_drvdata(dev, rtc);
 
-	return 0;
+	rtc->ops = &efi_rtc_ops;
+	rtc->uie_unsupported = 1;
+
+	return devm_rtc_register_device(rtc);
 }
 
 static struct platform_driver efi_rtc_driver = {
-- 
2.35.1

