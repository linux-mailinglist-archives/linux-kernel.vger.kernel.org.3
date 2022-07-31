Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1758614E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbiGaUWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbiGaUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:22:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975664D6;
        Sun, 31 Jul 2022 13:22:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s11so14848edd.13;
        Sun, 31 Jul 2022 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyXmWjI9o9olvXNDQPhAOA1IXnwkAZgs2FqrU3xtmOE=;
        b=QQRSqQyWC+vR6eHMG1h1ioiQ89dWvw+KbWaEyqCBjLwgN2H54xS4F7RgQPWyEWcGB2
         T9TqHv6ybPEY0jr3MIdHMrVd/KhEBtnJbR2xhalwF1BRMgu6KOViPhuvzIP86d5kUWj4
         iE1F49MNhyiQ65OvRCWTxVAIrklGfxw6+cMabTajcoEi5w2mPts5NjXQkFN+UGHesF/5
         b0mcMzFDtsarvVjNrVg2eWYxM8ZA8qaVRUUhJacGGnCyJPnaWDKSi4aOeiyHsTJDab+k
         Si/MKFHYE+rXudoK+0cKHvu0six6ZGwnzGSIHfNo+ADNxZjdlI5Yr0ZbwCwz+SzY5rRP
         yVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyXmWjI9o9olvXNDQPhAOA1IXnwkAZgs2FqrU3xtmOE=;
        b=fH6AQuy3NoY8mMdNjaQmJ0A9eICv2olzrYWLbnAw6DZVuqmC3r4btdYdDVaenJCmEK
         q1MmDo419KnMe+yFQ1nU02hdmsavkfK5iLgs1MDNjI/bH5iMaIwjPew3UFjgb6UNjiV1
         +/dfTMgz3UfF2Rapha2t3XmFJmHNY9pfDixLveHfyR9gbdKQCH9UahmvTJ9dLjtJXRjg
         wyv22u3bgPuIFhZq+bz/lJNqT4NRXF3JAVUawozv2empHlhPcYXAawf/0QUba5SvW2Wg
         7EwDiD7opeZEucXMN4EB/z+/GtGIvPX9ARjVRlpDMBsQxJsOmk9GK+cC5UzEENXIt9f4
         an9g==
X-Gm-Message-State: AJIora963pa1IFnORKYid8x4gIJWTHCo0vGsjwPoTvsGKbjruF++9cyL
        z4Vk5U0RxSBPU1+CxxGmAuo7wYILrdY=
X-Google-Smtp-Source: AGRyM1vYMSeRuYQ50NbD3dcUNneq8NiOxtqAgoau5e3QwcJHjcgYs+MU456Ar9WyVEVNcQMvFvUFng==
X-Received: by 2002:a05:6402:44d:b0:43b:e6e2:c98 with SMTP id p13-20020a056402044d00b0043be6e20c98mr12769777edw.323.1659298928183;
        Sun, 31 Jul 2022 13:22:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-115-050-116.95.115.pool.telefonica.de. [95.115.50.116])
        by smtp.googlemail.com with ESMTPSA id q23-20020aa7cc17000000b0043d0955d546sm4978629edt.69.2022.07.31.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 13:22:07 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, sander@svanheule.net,
        mail@birger-koblitz.de,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/2] spi: realtek-rtl: Add compile testing support
Date:   Sun, 31 Jul 2022 22:21:51 +0200
Message-Id: <20220731202152.1358252-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220731202152.1358252-1-martin.blumenstingl@googlemail.com>
References: <20220731202152.1358252-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for compile testing the spi-realtek-rtl driver to increase
build testing coverage.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/spi/Kconfig  | 11 +++++++++++
 drivers/spi/Makefile |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8e550269d488..4b84f27fae2b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -969,6 +969,17 @@ config SPI_MXS
 	help
 	  SPI driver for Freescale MXS devices.
 
+config SPI_REALTEK_RTL
+	tristate "Realtek RTL SPI controller"
+	depends on MACH_REALTEK_RTL || COMPILE_TEST
+	default MACH_REALTEK_RTL
+	help
+	  SPI driver for the hardware found on Realtek RLTL8380, RTL8382,
+	  RTL8391, RTL8392 and RTL8393 SoCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called spi-realtek-rtl.
+
 config SPI_TEGRA210_QUAD
 	tristate "NVIDIA Tegra QSPI Controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 18bf3d8c6df7..9fe4a2aa0fd7 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -105,7 +105,7 @@ obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
 obj-$(CONFIG_SPI_ROCKCHIP_SFC)		+= spi-rockchip-sfc.o
 obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
-obj-$(CONFIG_MACH_REALTEK_RTL)		+= spi-realtek-rtl.o
+obj-$(CONFIG_SPI_REALTEK_RTL)		+= spi-realtek-rtl.o
 obj-$(CONFIG_SPI_RPCIF)			+= spi-rpc-if.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
-- 
2.37.1

