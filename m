Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF347477E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhLNQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbhLNQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:16:50 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3132DC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso1195060wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CZZLzZT+BfXZxuiWnfdsUBig8FB5HFw4bFDfrJMVxBE=;
        b=ZbsiTILxVwE+Mq5B2ldENFVbQR3Ef5AQqGKImqM0vYBNKQRq4VXebDs+VzMeA7lNyo
         9k54ajpM/gxe33caNzDBWOZGapQ0IWdBl6+aBicSLAhYUXs5WRO0ssUhuFxr3Gn82cVs
         03Nt9F7xT7O4eWf+Zqe3d9VAyldbE/boIdNFU7a+SlGYaFFfSHQtotbOkBOgH4gzJBYh
         9xMDVLENbS5jCHEPoXwukvV4uaetTmqJBdxJA7aeh3LiYv3devjViiEVL1LA+WUVmFZy
         pMyw/b/Cng9TZw4ko0qDgDvlEMTQzoMfifNSVOuvUipev7O6ZubH9f2kXIzvI8ZpVu/d
         280g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZZLzZT+BfXZxuiWnfdsUBig8FB5HFw4bFDfrJMVxBE=;
        b=IBtkjs61GsVADRyQPTjCBAqgLZMTZI7QwlsB7s3qWWJC/2XZmCfHH2h6ut5Cjv0SFU
         ic1xx7kI35X/m2qh5EERE4FigjWmDbe2BNciOoBQiI7WkJeXyeJruFjyD0Vanp7/IgKF
         K7TnlqNfmIz7Du2sGEAtdnmDwuT+NlKx2SJuq6RDcZJ3mhqvbkY7jDqcjyW4h+QChltR
         s1iva6k8dhBmWI5DQadd1U21SVGw9CJnwPAte8mWPqdSo0ITJPIcCw6aYcjKSiUw+T1l
         xcGwFNOwfG9fBOC0oXA5M9SLcD3XpPAnU5ZnUCTbybK4bAck1VFQu0h5Mg02IZPs5V+n
         oQpg==
X-Gm-Message-State: AOAM533/9U933Kpjozl3CIvShnFZpZbfPxSCyhmLUNjOaELJzoxrtQqV
        R7OVWj06IOQJg4nSPH6ONHpOyQ==
X-Google-Smtp-Source: ABdhPJybmeQUJDbSW+3oV4zoGrLw5BsgeTTY17hfAtBVbVlqViN7SPJa0Cp1TzI6xxs3Sofx3yGN+A==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr47072072wmj.149.1639498608721;
        Tue, 14 Dec 2021 08:16:48 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a9sm295116wrt.66.2021.12.14.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:16:48 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 09/18] staging: media: zoran: move config select on primary kconfig
Date:   Tue, 14 Dec 2021 16:16:27 +0000
Message-Id: <20211214161636.1886900-10-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214161636.1886900-1-clabbe@baylibre.com>
References: <20211214161636.1886900-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all kconfigs for card selection are bool, this causes all selected modules
to be always built-in.
Prevent this by moving selects to the main tristate kconfig.

By doing this, remove also all "if MEDIA_SUBDRV_AUTOSELECT" which are
wrong, since zoran always need them to work.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/Kconfig | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/zoran/Kconfig b/drivers/staging/media/zoran/Kconfig
index 4067fa93d44d..faef008b8554 100644
--- a/drivers/staging/media/zoran/Kconfig
+++ b/drivers/staging/media/zoran/Kconfig
@@ -4,6 +4,16 @@ config VIDEO_ZORAN
 	depends on !ALPHA
 	depends on DEBUG_FS
 	select VIDEOBUF2_DMA_CONTIG
+	select VIDEO_ADV7170 if VIDEO_ZORAN_LML33R10
+	select VIDEO_ADV7175 if VIDEO_ZORAN_DC10 || VIDEO_ZORAN_DC30
+	select VIDEO_BT819 if VIDEO_ZORAN_LML33
+	select VIDEO_BT856 if VIDEO_ZORAN_LML33 || VIDEO_ZORAN_AVS6EYES
+	select VIDEO_BT866 if VIDEO_ZORAN_AVS6EYES
+	select VIDEO_KS0127 if VIDEO_ZORAN_AVS6EYES
+	select VIDEO_SAA711X if VIDEO_ZORAN_BUZ || VIDEO_ZORAN_LML33R10
+	select VIDEO_SAA7110 if VIDEO_ZORAN_DC10
+	select VIDEO_SAA7185 if VIDEO_ZORAN_BUZ
+	select VIDEO_VPX3220 if VIDEO_ZORAN_DC30
 	help
 	  Say Y for support for MJPEG capture cards based on the Zoran
 	  36057/36067 PCI controller chipset. This includes the Iomega
@@ -17,8 +27,6 @@ config VIDEO_ZORAN
 config VIDEO_ZORAN_DC30
 	bool "Pinnacle/Miro DC30(+) support"
 	depends on VIDEO_ZORAN
-	select VIDEO_ADV7175 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_VPX3220 if MEDIA_SUBDRV_AUTOSELECT
 	help
 	  Support for the Pinnacle/Miro DC30(+) MJPEG capture/playback
 	  card. This also supports really old DC10 cards based on the
@@ -35,16 +43,12 @@ config VIDEO_ZORAN_ZR36060
 config VIDEO_ZORAN_BUZ
 	bool "Iomega Buz support"
 	depends on VIDEO_ZORAN_ZR36060
-	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_SAA7185 if MEDIA_SUBDRV_AUTOSELECT
 	help
 	  Support for the Iomega Buz MJPEG capture/playback card.
 
 config VIDEO_ZORAN_DC10
 	bool "Pinnacle/Miro DC10(+) support"
 	depends on VIDEO_ZORAN_ZR36060
-	select VIDEO_SAA7110 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_ADV7175 if MEDIA_SUBDRV_AUTOSELECT
 	help
 	  Support for the Pinnacle/Miro DC10(+) MJPEG capture/playback
 	  card.
@@ -52,8 +56,6 @@ config VIDEO_ZORAN_DC10
 config VIDEO_ZORAN_LML33
 	bool "Linux Media Labs LML33 support"
 	depends on VIDEO_ZORAN_ZR36060
-	select VIDEO_BT819 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_BT856 if MEDIA_SUBDRV_AUTOSELECT
 	help
 	  Support for the Linux Media Labs LML33 MJPEG capture/playback
 	  card.
@@ -61,8 +63,6 @@ config VIDEO_ZORAN_LML33
 config VIDEO_ZORAN_LML33R10
 	bool "Linux Media Labs LML33R10 support"
 	depends on VIDEO_ZORAN_ZR36060
-	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_ADV7170 if MEDIA_SUBDRV_AUTOSELECT
 	help
 	  support for the Linux Media Labs LML33R10 MJPEG capture/playback
 	  card.
@@ -70,8 +70,5 @@ config VIDEO_ZORAN_LML33R10
 config VIDEO_ZORAN_AVS6EYES
 	bool "AverMedia 6 Eyes support"
 	depends on VIDEO_ZORAN_ZR36060
-	select VIDEO_BT856 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_BT866 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_KS0127 if MEDIA_SUBDRV_AUTOSELECT
 	help
 	  Support for the AverMedia 6 Eyes video surveillance card.
-- 
2.32.0

