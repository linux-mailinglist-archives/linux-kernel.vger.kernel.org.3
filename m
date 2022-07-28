Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6D05842FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiG1PVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiG1PVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:21:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F562491;
        Thu, 28 Jul 2022 08:21:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sz17so3715041ejc.9;
        Thu, 28 Jul 2022 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YEir7AE9Ws+RmW/sodChSCIEWr1J7MkIMYSUtdJkuKk=;
        b=SmgUF5EU+KWwGQ6TQef/B3s18NFjKon04gUJnbrKPqTPjzJlpmu20yLLYlsD2g2bn2
         7D9TM/l0VU5tR5WVzcWuKFkpgt/xvFF9vyQ47X6XG7NokcD07h/EYkhJTR7rEctVLnvq
         s2Y7LmRKGCEVa07Vjj6E90zajpcJ6efs1o8PADx+7o3Xa8kPPtCdB/+n4b8fp19DBxBi
         1FqozyryLUiPnLKxuuj43kkbmXvK/9vh17jbvKfbhw518T7m6dWwxwtxdM5xg5/VHDUq
         T+EeSRYVhN28rgju0kHSP9GPHQmKhr413DGHGqRLFiZZrKWIAKF3IfYTYCV1vZqGSMbk
         d9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEir7AE9Ws+RmW/sodChSCIEWr1J7MkIMYSUtdJkuKk=;
        b=qDhCssfLqCeCdDf+jKqqizO9H5zjFQoEzY6y3ihW2ezJeQCowqXO8ewbVWcczppxgb
         jMH06epvtBVUeShIDHkQdxbgqAY7YDS1NHpqV0ZUszfMUzxjkr3WVG8hQtyQZkzjonBB
         1oymbBt9HlyRZ96gLr87eLYfbo2TV4ht3UNKL/suHNFn/3Gd2alojIDHUMes3Yo+fZH3
         nDoZDXdL0/ZqvWg/jgDdC28mPYES3vQCunNvUqFg5Pvq9gpoIhxp7QaWne58Go0eFrMp
         +ZNNekCOSQ5WMlq8RM8TCm7bNIVEPbGDetoWM9+bWe1JQXe8MxFCELEx6JNLjC9dqxrB
         Ylzw==
X-Gm-Message-State: AJIora/xW/64F/0o5Q6KYZVoVYBGtg5l2h72Dqty6pyhF0WSGO33RUlc
        mMO5FOrYQhsWvZKYGC5p+/ukObFHqvY=
X-Google-Smtp-Source: AGRyM1v5AkuvtsQvsa8GWZ6nfDgP5XKmB/xkCUILQh8aQKb5QgkAASW1WicKfiPBL6q9UzBz/se9tg==
X-Received: by 2002:a17:907:7ea4:b0:72b:6929:4571 with SMTP id qb36-20020a1709077ea400b0072b69294571mr20682759ejc.257.1659021701963;
        Thu, 28 Jul 2022 08:21:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c001-5600-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c001:5600::e63])
        by smtp.googlemail.com with ESMTPSA id e20-20020a170906315400b0072a881b21d8sm525006eje.119.2022.07.28.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:21:41 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, sander@svanheule.net,
        mail@birger-koblitz.de,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] spi: realtek-rtl: Add compile testing support
Date:   Thu, 28 Jul 2022 17:21:17 +0200
Message-Id: <20220728152118.1429161-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728152118.1429161-1-martin.blumenstingl@googlemail.com>
References: <20220728152118.1429161-1-martin.blumenstingl@googlemail.com>
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
 drivers/spi/Kconfig  | 9 +++++++++
 drivers/spi/Makefile | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8e550269d488..d8b55efb05d5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -969,6 +969,15 @@ config SPI_MXS
 	help
 	  SPI driver for Freescale MXS devices.
 
+config SPI_REALTEK_RTL
+	tristate "Realtek RTL SPI controller"
+	depends on HAS_IOMEM
+	depends on MACH_REALTEK_RTL || COMPILE_TEST
+	default MACH_REALTEK_RTL
+	help
+	  SPI driver for the hardware found on Realtek RLTL8380, RTL8382,
+	  RTL8391, RTL8392 and RTL8393 SoCs.
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

