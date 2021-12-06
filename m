Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1903E469955
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344416AbhLFOrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344492AbhLFOr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:47:27 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E155C061A83;
        Mon,  6 Dec 2021 06:43:59 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id r130so10383509pfc.1;
        Mon, 06 Dec 2021 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ueJ3ENdYQwdAnZUR0jwTMvgqEAvFkFlJ+tOxyrQuoM=;
        b=eKUK4oeffpDFrOIcrd6YjCzbxAAOYJAacT7R0ceieexXSoqnDn89fAW5IZ89CtwUPX
         Ylonl5dEiIrJJE2uJTAPvYp1TdW8aV3r/qWt9t9QmMki02L7Ja+XAvR4LGiCruWguZU6
         oue1cRAeOu+xXUhwIvzQCyvLv0icRBYSbIdZWOtsAMPCfnavEZNem0n6hxXbtkDp3o4w
         3hbGqYmVbRZ+0NXbPJsslt/N8zZftVd8sYX1/OTcAVAjH1whoGz7qD3j6HzP9t8GmXn7
         WWf7v3qVqyLxFmGvHkni3mCvoSqIKfleIYTrZJxMrv9wcPMLOZ7R6pdYaLp0XU+Ztnjo
         4SMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ueJ3ENdYQwdAnZUR0jwTMvgqEAvFkFlJ+tOxyrQuoM=;
        b=RkEfArnqXBItTD4leu+CUBwyppq/TyZMWyqHOk1DQKttiilXKv97rw0hqPUJ7FUswq
         MK0sGof3wFUp5axph9BZoh4iGUM5bAsrSWXQZUSlc7AHH2wPqFT4qEOHde2ra4z6S+Sy
         rr17ybWsyYdmYPfa4eOYHr4LZyyU9worvzojdeEZuzfrAjj77QYvclqFRyzETkXTODhW
         GR4iYRS9VcNb2QqT3hN4elZCl8LnWnpxhmbROug2A/OnJqjeuJUy7SuntKqxppPC5gDb
         g+NYfLkpQ+ym0sBGfqcLHZq+t5usniN5blATFnsto/cnT6hfPH9y6Jay91EnGbQueESz
         O7FQ==
X-Gm-Message-State: AOAM533vafjemfCPj9gHEHDuuCEn70Sh963le4Bf7epEcn1jZ0KBdkcj
        JYZwiHNxeO5GYCshViKPwRmCO2b1Jns5mb+d
X-Google-Smtp-Source: ABdhPJzjAaRwPWf2FOsHrrxhz6lOslW9EqVZSa2c3WyRyabJkY1IVyZGYnUmLd6Sbtk+Br45POWCtA==
X-Received: by 2002:a63:aa0b:: with SMTP id e11mr6392862pgf.335.1638801838078;
        Mon, 06 Dec 2021 06:43:58 -0800 (PST)
Received: from localhost.localdomain (host-219-71-72-98.dynamic.kbtelecom.net. [219.71.72.98])
        by smtp.gmail.com with ESMTPSA id d12sm13516595pfu.91.2021.12.06.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 06:43:57 -0800 (PST)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, vz@mleia.com,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] watchdog: Fix file path that does not exist
Date:   Mon,  6 Dec 2021 22:42:24 +0800
Message-Id: <20211206144224.2931-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the file path are now under drivers/watchdog/ instead of
drivers/char/watchdog/

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/watchdog/davinci_wdt.c | 2 +-
 drivers/watchdog/it8712f_wdt.c | 2 +-
 drivers/watchdog/ixp4xx_wdt.c  | 2 +-
 drivers/watchdog/max63xx_wdt.c | 2 +-
 drivers/watchdog/pnx4008_wdt.c | 2 +-
 drivers/watchdog/scx200_wdt.c  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index e6eaba6bae5b..91e548ad046f 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/char/watchdog/davinci_wdt.c
+ * drivers/watchdog/davinci_wdt.c
  *
  * Watchdog driver for DaVinci DM644x/DM646x processors
  *
diff --git a/drivers/watchdog/it8712f_wdt.c b/drivers/watchdog/it8712f_wdt.c
index 3ce6a58bd81e..cb60ed310ab6 100644
--- a/drivers/watchdog/it8712f_wdt.c
+++ b/drivers/watchdog/it8712f_wdt.c
@@ -6,7 +6,7 @@
  *
  *	Based on info and code taken from:
  *
- *	drivers/char/watchdog/scx200_wdt.c
+ *	drivers/watchdog/scx200_wdt.c
  *	drivers/hwmon/it87.c
  *	IT8712F EC-LPC I/O Preliminary Specification 0.8.2
  *	IT8712F EC-LPC I/O Preliminary Specification 0.9.3
diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
index 31b03fa71341..59369cf7f082 100644
--- a/drivers/watchdog/ixp4xx_wdt.c
+++ b/drivers/watchdog/ixp4xx_wdt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * drivers/char/watchdog/ixp4xx_wdt.c
+ * drivers/watchdog/ixp4xx_wdt.c
  *
  * Watchdog driver for Intel IXP4xx network processors
  *
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 9e1541cfae0d..69349f1d0f34 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -1,5 +1,5 @@
 /*
- * drivers/char/watchdog/max63xx_wdt.c
+ * drivers/watchdog/max63xx_wdt.c
  *
  * Driver for max63{69,70,71,72,73,74} watchdog timers
  *
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index e0ea133c1690..94d54247fcab 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/char/watchdog/pnx4008_wdt.c
+ * drivers/watchdog/pnx4008_wdt.c
  *
  * Watchdog driver for PNX4008 board
  *
diff --git a/drivers/watchdog/scx200_wdt.c b/drivers/watchdog/scx200_wdt.c
index 7b5e18323f3f..77e630797572 100644
--- a/drivers/watchdog/scx200_wdt.c
+++ b/drivers/watchdog/scx200_wdt.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* drivers/char/watchdog/scx200_wdt.c
+/* drivers/watchdog/scx200_wdt.c
 
    National Semiconductor SCx200 Watchdog support
 
-- 
2.25.1

