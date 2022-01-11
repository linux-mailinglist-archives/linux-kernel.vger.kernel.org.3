Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C0648B2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbiAKQ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242304AbiAKQ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:56:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D7C061751;
        Tue, 11 Jan 2022 08:56:54 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u21so47149113edd.5;
        Tue, 11 Jan 2022 08:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WeChSL/PK3cTCR4nBb15abfCYrnb9MpWAs0c9CeMy0Y=;
        b=FOtOUxrStn+T3pB/FldxGxcu84qkokN3ZWvfQOamdONMznMluOrdAWf0a43ARKaj7L
         NrnemdZrnfDDC8uMCqxSxVXI1muNuKs/NXudn/nPCGvXKM7QTy2qORkREXaYdLPuLDoi
         IS28szc9dH1z3O642gcwJUoDn2WTtgalSSC4tdZMn+CuXRV4kI5+LOvfGc6YpcMq1+xX
         GFyFKWJcGRBjno0wxQJ0vDz0uDNz0fPOe88pTpnM2Y5jgaHmgS7Re0rcFfFdiQ+qI/BR
         JNXptkV6nNb2V1q+66aicv+hAnlERTxnQhykrXs3YRV+CEhLXL25UR6ttQa/t4fM3YSD
         M1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WeChSL/PK3cTCR4nBb15abfCYrnb9MpWAs0c9CeMy0Y=;
        b=K53BLxB0Mofkjyt0JIeNWMuxJ28mPYoDEa2Dl1Cgr7NSQeEhq6j4a5k2yC1vYFa0+E
         x/jb/rS2jxwYoNxa+zIFE2VOVrlNFTRklnUYnkJo6c4wkvaj6DNAmTIC7JzSOnioZxFE
         ZXY4IyxoqhdV+7QMlyWARWJZAKOGrL1CiOQxKqcAjdhYRInig1bfQblJsWVgwJfwTyWM
         D5wvAs4Tr7/1SN3/l5RLIjsQ0B+pNKcY6MP8aZwmwEIcZzfGhbFhDo62wOkHEAQKf7u5
         WxmzCwpmrca1oY30eYX5hVJTUwQC8SKHGrV9woC3u+ypKWbOX2HSJZV1GIgeDHoPaglS
         ZteA==
X-Gm-Message-State: AOAM533nGVDqrWWVbU60bEbmj6I+aX9QRPvDTM1pfcQkp4QT2+uRL2oH
        c0bLvEPVo7nOIw6IaUqMqxApuftIAobR6W7a
X-Google-Smtp-Source: ABdhPJxIwNrmUBOvjf31nmz5yM7JajBXGSRI7bkJgWPa8HAhw4zxHi6tmMoo6t+ZJdxhlcWaF5c64A==
X-Received: by 2002:a05:6402:d0a:: with SMTP id eb10mr5234814edb.48.1641920212829;
        Tue, 11 Jan 2022 08:56:52 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f0b7c00c3a5ee4155775dd9.dip0.t-ipconnect.de. [2003:cf:9f0b:7c00:c3a5:ee41:5577:5dd9])
        by smtp.googlemail.com with ESMTPSA id d14sm5220986edu.57.2022.01.11.08.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:56:52 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v4 3/3] hwmon: deprecate asis_wmi_ec_sensors driver
Date:   Tue, 11 Jan 2022 17:56:27 +0100
Message-Id: <20220111165630.1155135-4-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111165630.1155135-1-eugene.shalygin@gmail.com>
References: <20220111165630.1155135-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/hwmon/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2c16b19d2c03..5e693c93d43a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2243,13 +2243,16 @@ config SENSORS_ASUS_WMI
 
 config SENSORS_ASUS_WMI_EC
 	tristate "ASUS WMI B550/X570"
-	depends on ACPI_WMI
+	depends on ACPI_WMI && !SENSORS_ASUS_EC
 	help
 	  If you say yes here you get support for the ACPI embedded controller
 	  hardware monitoring interface found in B550/X570 ASUS motherboards.
 	  This driver will provide readings of fans, voltages and temperatures
 	  through the system firmware.
 
+	  This driver is deprecated in favor of the ASUS EC Sensors driver
+	  which provides fully compatible output.
+
 	  This driver can also be built as a module. If so, the module
 	  will be called asus_wmi_sensors_ec.
 
-- 
2.34.1

