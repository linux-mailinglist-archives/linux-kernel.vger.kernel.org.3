Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CECC599314
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbiHSCjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiHSCjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:39:36 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA905D0CB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:39:35 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10edfa2d57dso3904302fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=f+DXvIo9ecoq0rBcQpjnzRrr6tx2c4TABD6hBQaLuYo=;
        b=ZEZSv5xKyp6in4GZQw6TfdzMl3GLD8uj1NYtmZieaOaTBlRAPBYGQhypaNaz05q1fJ
         /1j7a33xURbR1R/0D+8DR2+k+EwwR6gVb9rSMECzi0p/B8ll11DW6w6JuqOFajvXnikN
         5bbhNgTpL/GdCq8Bx6DLhzFj2H+TsWTkuNdpHZKo57//mv9Dw9mvNbynzdV47ck2OCx0
         x1e4rIDpKusv8uWID0mkvPpTCmeDoK62FwaXsM1AXs5/YBePcl/GiOwXaSbhfK0yABfk
         w9IotUrw0lc4RUmTXVO7LWOKEl7EUc12Hr3URlWcTNLsVYIVEfweKRxksYA27nBMoeOc
         SIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=f+DXvIo9ecoq0rBcQpjnzRrr6tx2c4TABD6hBQaLuYo=;
        b=5hOjpQKEe3ZoK0z8suXfpOzEyx4jKPeiX3DId0kh5ZXbJxqe0RShPl0IW4ic9e2xvt
         sMywtSyAwGQSlGGar3+ic7m707k2LdYJs/4x1RD/V/2DalUqwC89HLzwsHMkaTy3TgRm
         br1h0spm8jtmga4vtmdPQWOoKbkDzOl7NOSnQQffbgNmkQv7kjv2m2beAsLvXb+Eww45
         byXuB/ni9vKpvStk0Wj0Zindjzq6h1YdkqH0txMyxruuR+Ie+gGl1m94UqzaC+nuJ8M/
         He8/bMrvwGYXJP/E9+T1TSbvDSsoLHTn1MUEDNc/IBE9f242V/MVN9gTWQZ+gGYnu4XJ
         io+w==
X-Gm-Message-State: ACgBeo19JsLfbzVhzYywNl3R3+V65ovUFr+tuKGHUztAkHAAtk0Q+8T7
        AUetHTgPagI64lkJ5gGBcj0PGA==
X-Google-Smtp-Source: AA6agR75bmRgnEj92yca41gwn1+ub0aAg8/Znvol7BHtA8AiOlawu8/2G4FIo0hiTMjeHUef6xIODQ==
X-Received: by 2002:a05:6870:f20c:b0:10e:e5e3:dac2 with SMTP id t12-20020a056870f20c00b0010ee5e3dac2mr2924694oao.228.1660876774388;
        Thu, 18 Aug 2022 19:39:34 -0700 (PDT)
Received: from localhost (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id eh41-20020a056870f5a900b0010d75440f41sm917225oab.45.2022.08.18.19.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 19:39:33 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hid-input: add Lenov Yoga C630 battery quirk
Date:   Thu, 18 Aug 2022 21:39:24 -0500
Message-Id: <20220819023924.3272-1-steev@kali.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the Surface Go devices, the Elantech touchscreen/digitizer in
the Lenovo Yoga C630 mistakenly reports the battery of the stylus, and
always reports an empty battery.

Apply the HID_BATTERY_QUIRK_IGNORE quirk to ignore this battery and
prevent the erroneous low battery warnings.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0fb720a96399..347d783da82c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -414,6 +414,7 @@
 #define USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN	0x2706
 #define I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN	0x261A
 #define I2C_DEVICE_ID_SURFACE_GO2_TOUCHSCREEN	0x2A1C
+#define I2C_DEVICE_ID_LENOVO_YOGA_C630_TOUCHSCREEN	0x279F
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 48c1c02c69f4..17a453bb09a2 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -383,6 +383,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_GO2_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_LENOVO_YOGA_C630_TOUCHSCREEN),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{}
 };
 
-- 
2.35.1

