Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E504A481B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378828AbiAaNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378773AbiAaNa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:30:59 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27228C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:30:59 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u18so26578285edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYXT4gk9Y9FOFainIjJpNI+kWx4yyUZQOTZKalRd39c=;
        b=CfG+bbxHn3DWKPjtpt+3xZ7qduSJwpg0aGX9FQyrRQA0KOZwyb9M3WgqguoiXeNPEk
         +N7J9WhWXKSkIJ4IgHCltiBqb5MzpOEbYp2HxX7/0iTj7BHqW9XcP6lbKzNsFEW+0vDl
         AxDIgvc0PcHjwVqFf61U41SoozrXD0UqFoMmMd7+Jrlj4mvexTZbAdScQqZIZC/HJiax
         f/0lONheqr/109e3vec4U//YFYPzYIVcGCX4v7pZ344MUBZV7CjQoBVeykduVib4bW1j
         uaVg506c3E/znXkP1y5AyY9z6ag/Ivppj5J/Wc5mLSPEVeNGvxf6d0XgytliLKaJkNe2
         dAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYXT4gk9Y9FOFainIjJpNI+kWx4yyUZQOTZKalRd39c=;
        b=C8LEz2FxZ/fajSEFwTsjPOJsOS7clfIP8lbqSv0RqeM1LI5dNfXIvUr769hf1i362c
         L11R2GPpQOnezDiDw+oI5B0N0qHJ4GD3d1WeXIeo3oA2544O51wWtN4oFhKTNoKYjZYR
         EOLO1hJrU2k3Hcel3orl90HFDZCSDQuqGgGM4LU2csHg2qfr8uy87fIKYSh9Nb1yPGhs
         dlO7ryR3v6uev3ffaLZ4SyNEfPq+uH+CunUxV3cFMvOntUmsXOKlLp1aZ7Of+nGWJG8k
         oXLA5IlGmy9wgEgoqCx2p6JcOF3JQKRzVOEu0AD6EKggkZt5RMQbpr6ISzYjP9HD2M3h
         WQjw==
X-Gm-Message-State: AOAM5325VpRZlR20eY4l3fESGI1cW5jYup2E7wjQLxe/CyIFhxsWW0Z+
        SDvD4V1XrfrJ289ydNOIXI6wUfxMwy1F1w==
X-Google-Smtp-Source: ABdhPJyuvC5GvDE4LwJFy6VBvs3KgrOXAEwNnE1MF17jyqogFhzWFGAQkITBbj3l03XVNOFsX9Rp3A==
X-Received: by 2002:a05:6402:348a:: with SMTP id v10mr20807198edc.249.1643635857668;
        Mon, 31 Jan 2022 05:30:57 -0800 (PST)
Received: from fedora.robimarko.hr (cpezg-94-253-144-81-cbl.xnet.hr. [94.253.144.81])
        by smtp.googlemail.com with ESMTPSA id c22sm13094334eds.72.2022.01.31.05.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 05:30:56 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        skhan@linuxfoundation.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v10 1/6] mfd: simple-mfd-i2c: Add Delta TN48M CPLD support
Date:   Mon, 31 Jan 2022 14:30:44 +0100
Message-Id: <20220131133049.77780-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131133049.77780-1-robert.marko@sartura.hr>
References: <20220131133049.77780-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delta TN48M switches have a Lattice CPLD that serves
multiple purposes including being a GPIO expander.

So, lets use the simple I2C MFD driver to provide the MFD core.

Also add a virtual symbol which pulls in the simple-mfd-i2c driver and
provide a common symbol on which the subdevice drivers can depend on.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v9:
* Rebased onto 5.17-rc1

Changes in v9:
* Depend on ARCH_MVEBU or COMPILE_TEST

Changes in v2:
* Drop the custom MFD driver and header
* Use simple I2C MFD driver
---
 drivers/mfd/Kconfig          | 11 +++++++++++
 drivers/mfd/simple-mfd-i2c.c |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ba0b3eb131f1..be1ad8ce54aa 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -297,6 +297,17 @@ config MFD_ASIC3
 	  This driver supports the ASIC3 multifunction chip found on many
 	  PDAs (mainly iPAQ and HTC based ones)
 
+config MFD_TN48M_CPLD
+	tristate "Delta Networks TN48M switch CPLD driver"
+	depends on I2C
+	depends on ARCH_MVEBU || COMPILE_TEST
+	select MFD_SIMPLE_MFD_I2C
+	help
+	  Select this option to enable support for Delta Networks TN48M switch
+	  CPLD. It consists of reset and GPIO drivers. CPLD provides GPIOS-s
+	  for the SFP slots as well as power supply related information.
+	  SFP support depends on the GPIO driver being selected.
+
 config PMIC_DA903X
 	bool "Dialog Semiconductor DA9030/DA9034 PMIC Support"
 	depends on I2C=y
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 51536691ad9d..0d6a51ed6286 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -64,6 +64,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
+	{ .compatible = "delta,tn48m-cpld" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
-- 
2.34.1

