Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7049771F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiAXB5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbiAXB5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:57:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1613C061747;
        Sun, 23 Jan 2022 17:57:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l25so10744796wrb.13;
        Sun, 23 Jan 2022 17:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRAWtfjjgO5udN5+BKSAfe9dAH85zJZw/J7zjuoQ9nM=;
        b=c9f6IIBB8FlBAuFUxvYHyUyIJ/MMh+cd36ZS2+/lhy5hLoFtpIZcJ/Txw5qCwkWXqA
         u0LaNm4r2vKVsvF6ajUvjgwoCCAYbWxNC2ZO75/3vck77ikvB7t561g3MQ5J+xbsUiAG
         hhJe+ovdcfyX8MUzZMDxZQaETisUk2hXxKj6Nctol9JZD/qOJEXSbRBS0dmeQqg3KBV6
         bOk4q6u5dn7wFC3vcHjQHNoKqRodtazSxFdiCNdHDBzhjxWemYiSfU58FHzolZahxi8i
         S9C3EX1lir9/IFZ9pjgbttITNW6szWDTCxtqFCX7GpRZdmDeD8N0B5FKO4ttZgSVCO1T
         IEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRAWtfjjgO5udN5+BKSAfe9dAH85zJZw/J7zjuoQ9nM=;
        b=WTj4I8pU09ze1BWIHf/VdIqsRHD+ARmX84YsGB0ke/NspeIaFfzvi+GFJGNq8PFHer
         pZSrRHqkxQtIKSS9DxztfmETe1bfYjotvc86wT/IsbEYlYH8gQetETFAyqjH0wZh3/D7
         1UI3HU+kHuF/FzQnTKefcAvMXEWWT/qei8Fspr6KiG2tNnu4VC2/stnFonc7INq+4eLv
         9Dw3Dbp6/KExGoixZyEefFx08HvBoMw1Xe55PD/AZ+Ybt6a965iPVUvdfkvVQA5ED1xM
         XbCAwix18oHP7XLYYPbiXpgc/dnT9s/pIuSmYSpCkWU7mjKalHAnDfP7yitTbPMQtPjB
         GhxA==
X-Gm-Message-State: AOAM5327e+oDUjO+31RfT03L1SpVhDgrVQMGy3fL+oO/vtsZK87niyeN
        5Uqgmhz8sEiGIaK3C5WA9FI=
X-Google-Smtp-Source: ABdhPJzYsuWvUDQQfvodp82LdgctD280nTfzbf0fRw+leVVltl0i5d+eYA8teGCbYbYvw8EO+3APHQ==
X-Received: by 2002:a5d:584e:: with SMTP id i14mr12541907wrf.690.1642989442567;
        Sun, 23 Jan 2022 17:57:22 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id i2sm3224968wmq.23.2022.01.23.17.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 17:57:22 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        oleksandr@natalenko.name, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [ASUS EC Sensors v8 3/3] hwmon: deprecate asis_wmi_ec_sensors driver
Date:   Mon, 24 Jan 2022 02:56:45 +0100
Message-Id: <20220124015658.687309-4-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124015658.687309-1-eugene.shalygin@gmail.com>
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate the asus_wmi_ec_sensors driver in favor of the asus_ec_sensors

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
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

