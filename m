Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A92B474758
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhLNQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhLNQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:16:45 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117FCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:45 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p18so14622112wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZX+m9eRP3G6qa3o26UuCwjfzdvb0rxacvbcUwg9LjVM=;
        b=T7EoM7c6Sk022NWt5q8QI8ShLGTFYSNYidgGL8J4+k0ABRAXcsARMRQMbJ0Zc5gLME
         vwl/OnAi09m6K9yCcSLj3M4uiDaS9NG1ibkgun+W+I9+ETW13U2juydwXkKP6CNaccE7
         2ubatLNZY9OiZS/uiWFGCltszRFE0qfrVtx9t+RdUyaeUKny+ETTNkjlzlBKjdGV5Ps+
         OtZI2/oK3d5/+Dx7Ptdw2Uj4y1QvK6Nyy6K8jlkdUxxCsxlTUyc7cOmxOzdtzafk3fUs
         rzOt6SNbm0SYqDNG0V7Kzcs/UaXuuMQfmk9TDaBkodkpUpYuwNlpPpFVdj7ZYd0twO/M
         /RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZX+m9eRP3G6qa3o26UuCwjfzdvb0rxacvbcUwg9LjVM=;
        b=2hIJKJdv/mzCYjCs44KEn0Hew1Pi8kjISfQqw/+MzZctDoG8LULxhfewT1AdjeK2C4
         okIuAd7+PKtn6tHggkLepfufImu3ltMrjgSVCKZ3uu95RQ68Yk0tjDScvYdvgsjfFcFU
         OrmvB0UQq55Gxg4ni5KlvlkUZL17IfUpKPCtxiYocM2RDefhp/SWkkkdzwMG9Ka0MZf2
         qQvhWGFZBXLRk5iHqtYI9xifFOQLT9AbvZ6kLU9R/RCoz4sodwEy92S7lgd/+0sAMb+a
         Vgmbi5nvqEcwy/caaHNuI7eFzIxnS8SR2KnfW/rxtV8KSdsAF0r/aYsJkz9Fr/foF7RL
         4eOg==
X-Gm-Message-State: AOAM533fvhc+ZYspim5PEhN7itKoYgCUkZy4Ql93EpcdRAUVbrx7VNhH
        bHX6HoF9liknCJ9vyCH7UIux8A==
X-Google-Smtp-Source: ABdhPJw6Q5uDW7bfECCayVdeOzj/tVZOc9GBRSpmdGpoot4fKLzdcuBHluJ/v6BPqVrCAASIM86lFw==
X-Received: by 2002:a05:600c:3b28:: with SMTP id m40mr47730200wms.100.1639498603551;
        Tue, 14 Dec 2021 08:16:43 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a9sm295116wrt.66.2021.12.14.08.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:16:43 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 02/18] staging: media: zoran: use module_pci_driver
Date:   Tue, 14 Dec 2021 16:16:20 +0000
Message-Id: <20211214161636.1886900-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214161636.1886900-1-clabbe@baylibre.com>
References: <20211214161636.1886900-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code by using module_pci_driver()

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 3bc0e64f1007..f1465fbf98af 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -1314,23 +1314,4 @@ static struct pci_driver zoran_driver = {
 	.remove = zoran_remove,
 };
 
-static int __init zoran_init(void)
-{
-	int res;
-
-	res = pci_register_driver(&zoran_driver);
-	if (res) {
-		pr_err("Unable to register ZR36057 driver\n");
-		return res;
-	}
-
-	return 0;
-}
-
-static void __exit zoran_exit(void)
-{
-	pci_unregister_driver(&zoran_driver);
-}
-
-module_init(zoran_init);
-module_exit(zoran_exit);
+module_pci_driver(zoran_driver);
-- 
2.32.0

