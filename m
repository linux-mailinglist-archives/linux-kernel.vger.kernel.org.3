Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B1948FECE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 21:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiAPUTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 15:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbiAPUTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 15:19:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1B6C061574;
        Sun, 16 Jan 2022 12:19:07 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z22so56936532edd.12;
        Sun, 16 Jan 2022 12:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g05KffStcZJZjaUhCRWqgkCbNj/ENt20MwqZ+Pt+0FQ=;
        b=j3ZEBOL0CID00J8J3mMGsCsV/iwvDnJ1hhxdYPOWmx4iUS9hyFQl7EWREh6IewfyIS
         eAXnKCPMRsZY6tWnbCruox5TUvrt3ztXjMOOJfQFE32fcC0j+fTisUKF4vV7XZtMBrzv
         Z+/1t9UzSt93OMSPLECu2KPH9uqPEFWI51fclvlbValQY/FPHVXtm1bhPKvFa3GeOuT4
         83d1fZwTW/UfF9rSjvNea+RQ1k7mrPJb1emabAmSLXGC06KJAnVElKGyJrVjQPwpR027
         /XR9BDn2+6PLHnifRvefvHg8wqo5YjAZGu2vMn+s6kd8RnZiOYhLqIezxt5SpqfG+bcw
         ES8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g05KffStcZJZjaUhCRWqgkCbNj/ENt20MwqZ+Pt+0FQ=;
        b=BpxLrnc/FbNMT5E3MbfI+Y29RYCg4rSRUQHmgEWxGORwGW3emztV2C5zgiuAWDynf0
         XMEunZOPjX4Rdkjw3DyUT5lVc4NXkbwUR60YAp2AG2n/PDu7rqUtGp8+RfbyHFQ1ycG/
         JykRI7t4hPpWzk/xCmG9FMrESXMQLZUME0TqVMez89Ewl2N6jpn8BMsMdL8smfyjN6BP
         RsHv7i3P6QTfOlrFRJ9Rz+WYdVp/T05iqdFyofdXjLcq2KfmbLwgeSYy4HB8K+jC9fcH
         9aHMJJORMb5jaLqq92ADbXtaScTCiYI3THQTRzS8CKXYDQ6ST5PqGo3Tejr2c+NrgDHw
         XAaw==
X-Gm-Message-State: AOAM533f9lhjpWIEdjgLZzda5ajBMuB1+yc47aSdqvnOPQid39pbLnYp
        l61oCGuDniXE/wUqKd1ccaE=
X-Google-Smtp-Source: ABdhPJwQwFGg4CsDcUL/TWZj/aSc8hWlQSAlFqh+qqKqSAMC/3Gx4yoT1+VRhAQBK4I9ALMPww+iFg==
X-Received: by 2002:aa7:c98b:: with SMTP id c11mr9566528edt.104.1642364345820;
        Sun, 16 Jan 2022 12:19:05 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f4053004b601b67b388bdb4.dip0.t-ipconnect.de. [2003:cf:9f40:5300:4b60:1b67:b388:bdb4])
        by smtp.googlemail.com with ESMTPSA id eg30sm2529452edb.85.2022.01.16.12.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 12:19:05 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [ASUS EC Sensors V6 v6 3/3] hwmon: deprecate asis_wmi_ec_sensors driver
Date:   Sun, 16 Jan 2022 21:18:41 +0100
Message-Id: <20220116201843.2301438-4-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
References: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/hwmon/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2c16b19d2c03..38094c702e4d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2243,13 +2243,16 @@ config SENSORS_ASUS_WMI
 
 config SENSORS_ASUS_WMI_EC
 	tristate "ASUS WMI B550/X570"
-	depends on ACPI_WMI
+	depends on ACPI_WMI && SENSORS_ASUS_EC=n
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

