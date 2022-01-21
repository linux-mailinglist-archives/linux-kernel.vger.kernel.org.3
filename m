Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AAD49632D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiAUQyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379215AbiAUQyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:54:25 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71449C061748;
        Fri, 21 Jan 2022 08:54:23 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id w188so14286000oiw.13;
        Fri, 21 Jan 2022 08:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oJfZ9bxEyakRGqsa0D0+XQlWPcD9uzPytbmizuUotgY=;
        b=FdXBH7Iek6amWg401VuWNnvfE9n1dEqsm8gSRUc4W2+XwCI5e8f6fwvDbQmNRDjo59
         a09lHndSHbtHfW3CHRvyv2HsmMjh8igO9/R+ATU6uo0QHhcYzu2klOt4FNOFw9532/ZI
         ZFtMYQyZPg8v+a+KqFMBQMFsZva1t8R1liGLfCKUvumxuKGFg7NLOIfKtJanuco7bJzC
         iBcBgMe+6hcaFTIFg6WqQrMqDXGSrOLHFCqYYZT7BaflUtcCmG5ix3jGYyJcjp5j0q+H
         6TUB5gRoFnFR3Fb+cD9Jd9G4iWEfBpo3+2nuIB+riZi5uu5Oe46BCujP3OBfi+G/vY84
         y9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJfZ9bxEyakRGqsa0D0+XQlWPcD9uzPytbmizuUotgY=;
        b=Fkd/vc7U/B3H8K5mX/a0sf4K2z+hFAkvQiOzenoIE921cUKI45Cfs/5BJTqFK7MO8L
         TZ6xg3XzQJkdbsD/Y+Gi4lQpfL0cuWdgqgbdDL+a5+BgPUsXYTga2HWCT8XuGXcN1n6M
         w8BlOknkdl3chYuWnkFUwEAOhR1DclPxKbDT+2aQfmZLNNrtTMGV1six8U8fz/pzCL+t
         qkvtgXWaoFOt9REaSpN5y3sY8qovY0pJNjcOXtFpg5F9zbdUsgvGhAyLKnqMS8lNFYn9
         bYgmOSdv+p+weimWkiLvd6OtCx8VKWtI3L0c6tHYGqUD6bd8/pIMwA4+l2ymDkALMfk/
         JmSA==
X-Gm-Message-State: AOAM531xsBMFXetVKQhPAXGkWJnnW25g3xegOzhb3BAdy2u7YuCW426r
        7lrf+jKItdsCYrdQXDuO2n1tF2KXqpo=
X-Google-Smtp-Source: ABdhPJxVB60m/+irtROG2vo5Jixi422f8mmMPw0s5dKqSWNTf6DszjlcuSjSB8uP4NKmSlGKrxB3hQ==
X-Received: by 2002:a54:4097:: with SMTP id i23mr1250934oii.115.1642784062879;
        Fri, 21 Jan 2022 08:54:22 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:22 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 03/31] hwmon: pmbus: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:08 -0300
Message-Id: <20220121165436.30956-4-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121165436.30956-1-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum led_brightness, which contains the declaration of LED_OFF,
LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
max_brightness.
---
 drivers/hwmon/pmbus/ibm-cffps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index e3294a1a54bb..cc20a70c723b 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -382,10 +382,10 @@ static int ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
 	u8 next_led_state;
 	struct ibm_cffps *psu = container_of(led_cdev, struct ibm_cffps, led);
 
-	if (brightness == LED_OFF) {
+	if (brightness == 0) {
 		next_led_state = CFFPS_LED_OFF;
 	} else {
-		brightness = LED_FULL;
+		brightness = 255;
 
 		if (psu->led_state != CFFPS_LED_BLINK)
 			next_led_state = CFFPS_LED_ON;
@@ -426,7 +426,7 @@ static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
 		return rc;
 
 	psu->led_state = CFFPS_LED_BLINK;
-	led_cdev->brightness = LED_FULL;
+	led_cdev->brightness = 255;
 	*delay_on = CFFPS_BLINK_RATE_MS;
 	*delay_off = CFFPS_BLINK_RATE_MS;
 
@@ -442,7 +442,7 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
 	snprintf(psu->led_name, sizeof(psu->led_name), "%s-%02x", client->name,
 		 client->addr);
 	psu->led.name = psu->led_name;
-	psu->led.max_brightness = LED_FULL;
+	psu->led.max_brightness = 255;
 	psu->led.brightness_set_blocking = ibm_cffps_led_brightness_set;
 	psu->led.blink_set = ibm_cffps_led_blink_set;
 
-- 
2.34.1

