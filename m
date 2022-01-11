Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A181B48B50F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbiAKSE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345215AbiAKSEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:04:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DCC06175A;
        Tue, 11 Jan 2022 10:03:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so1955679wmo.5;
        Tue, 11 Jan 2022 10:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WeChSL/PK3cTCR4nBb15abfCYrnb9MpWAs0c9CeMy0Y=;
        b=Y94wa84w/JmLuTeW8JfatuMj0XVe8JaA8qVrtlKu5Yker3Xx/aQNNqMDru8RR8Kna/
         8oQnjPnFe7A02q9eoe9QMi2kc0aCrxQIfE/xey5/7Z7AuvtPXVvtdtuhh+Mm+9X5qEiv
         5euYx65igPiqrfqs3UrmwQSAJLdMKNMKUIv2I+hVlwLbl41J/dAMyUNkAKsDVTKOvCnY
         bio+Z9t9D7MSQNI3i4c3OmYXJJPyw+X4RkR4xZCYJn/dDa7H3SSXmAscqjXkOX67AZlE
         NuiIDIKmtPZIjtguNyMshlLPYT0e+6WrTg95bmD946TF/1BgCTW6vVVaPypI1uZkrO40
         F2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WeChSL/PK3cTCR4nBb15abfCYrnb9MpWAs0c9CeMy0Y=;
        b=Y5AV0O/+X1GntxFH7xHVezX9K/1CvfOVJP9X2OZG34Re9Io8oJOpKjA+hz52RonmKG
         GPvzndU8H7Xpf/88wLhsLiaWtI+VmS09C8bklBStTPXb3Kn0eDVedMYgESJQ3XbelIFq
         ZOnWCbqznevFvKzCkRQyHq2d8NXpVXvJ2OnoZ8Tfpjp2ougFvQQZ3/ZBriUlOgnAwBE7
         lf2hwf7iYD3RHOR4wZWVTtGl0pR4mEs8WGdrKyC6iVAvO3shbmuLn4zb4KY6/WnRu3UP
         cx/CXBARTvXQUAv4ICYy9HeE4EfsSCfIpJHIQQr4NkRbZR3sY/GzJadmOIRYrFJHNs9A
         mJhg==
X-Gm-Message-State: AOAM530BTqCBkLWCJXUQcZ//4UVjTEofkdJlEk+n2i4z2XxLV9k4HGCh
        1DrYem/py0Czgi3e0dTLNn4=
X-Google-Smtp-Source: ABdhPJzI21DafyxbjZfHlH1uHuwnv97rJI7uNtKSoFkIAHa4FKcRzFVz20pkljwKjq8dZJXhcNnKgA==
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr3459968wmq.152.1641924238573;
        Tue, 11 Jan 2022 10:03:58 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f0b7c00c3a5ee4155775dd9.dip0.t-ipconnect.de. [2003:cf:9f0b:7c00:c3a5:ee41:5577:5dd9])
        by smtp.googlemail.com with ESMTPSA id l6sm2255429wmq.22.2022.01.11.10.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:03:58 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v5 3/3] hwmon: deprecate asis_wmi_ec_sensors driver
Date:   Tue, 11 Jan 2022 19:03:46 +0100
Message-Id: <20220111180347.1245774-4-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111180347.1245774-1-eugene.shalygin@gmail.com>
References: <20220111180347.1245774-1-eugene.shalygin@gmail.com>
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

