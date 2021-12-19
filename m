Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641FC47A130
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 16:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbhLSPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 10:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbhLSPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 10:34:57 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55ECC061574;
        Sun, 19 Dec 2021 07:34:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a9so14853742wrr.8;
        Sun, 19 Dec 2021 07:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFsVzNxUTe0zVj2n7sBsxSG3rvMdpK3tm6ziU6/sth4=;
        b=BZn8XdhsazbSm+T1KIeZYU/dJkqAURt9mI5DASsIbG2584MXsCyOVn+eR7/eUCVoPg
         qaJn20CPCUTx/GM7scU6TfocKN+aekA2IlfAk5VYdkNlYFLCqrKrRU7Zfb9oD02u3Dkg
         dDPrhwUiIDfgUILDUM8xyPol4M2+JAssF785XxRU/ibVvAADQDXoF32gTK+k2qashd4n
         gCbsKWBVOZBvzYxul8E6AZRFdwfDKBCkO+RysFvGnSJ0jZfXzDBAMEwErjVOEj/Bmrws
         ChdAONYUBqaDpmtKjUvAo9H6sD2scFhteoDVT8Z+kcDL7jQ9oXSctHh8QUjaUYfk7rAs
         1aDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFsVzNxUTe0zVj2n7sBsxSG3rvMdpK3tm6ziU6/sth4=;
        b=pHytYst4w38RLuutXKz0BJl1hDUpITWaD0ECH6LbLqq3dSM9So8jgeqRHCzjE474/T
         xk4XFdSZH7ZiCp1aChyHOTP0fz6m4B5rzekDff2ipMOwNYMF/VglA0cSNYoL8OqN9mn6
         4tS1LAjhYgwtfEK/zvfgG54mXsVlDivO8D2RmWcmrvY/SfZfHVnFu6MxDU0Dv89G+LMA
         uClTaiPIisjTJZ5HFWWNBjvlc3YKp25KknXM7cJ0+BIGr2OU3tdmTcE4yc6VAFGUio8a
         zGYlXd0oQQHvT+zGnD9Ehh8/L3NUImdX5FLUt2ncEstXTTZE0dmTa5/4QhWNWD4lM+zN
         NjSw==
X-Gm-Message-State: AOAM530b13isFQ19I3dGZ0n7Pm0x/fGgwYsrYtuSIkrKaflf82MYPWkN
        qJZFMxbKE1QimZDrx7EAxkBkKsQOsmo=
X-Google-Smtp-Source: ABdhPJy8sqHQb8viceLhFm/W1Wh3gIVDSOpELbiSB6yK6CD2Q1AsC1doKHe8hShOvALzCDdj8Y8cNg==
X-Received: by 2002:a5d:5988:: with SMTP id n8mr9933234wri.309.1639928095133;
        Sun, 19 Dec 2021 07:34:55 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-721d-8f00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:721d:8f00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id d2sm9262020wrw.26.2021.12.19.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 07:34:54 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ulf.hansson@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] mmc: meson-mx-sdhc: Drop unused MESON_SDHC_NUM_BUILTIN_CLKS macro
Date:   Sun, 19 Dec 2021 16:34:42 +0100
Message-Id: <20211219153442.463863-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219153442.463863-1-martin.blumenstingl@googlemail.com>
References: <20211219153442.463863-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove MESON_SDHC_NUM_BUILTIN_CLKS because it is not used anywhere in
the driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdhc-clkc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
index e1f29b279123..19200b7079a6 100644
--- a/drivers/mmc/host/meson-mx-sdhc-clkc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
@@ -12,8 +12,6 @@
 
 #include "meson-mx-sdhc.h"
 
-#define MESON_SDHC_NUM_BUILTIN_CLKS	6
-
 struct meson_mx_sdhc_clkc {
 	struct clk_mux			src_sel;
 	struct clk_divider		div;
-- 
2.34.1

