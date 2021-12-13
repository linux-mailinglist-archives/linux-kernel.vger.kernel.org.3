Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3097471F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhLMCRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLMCRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:17:05 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD8FC06173F;
        Sun, 12 Dec 2021 18:17:05 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id j17so13971333qtx.2;
        Sun, 12 Dec 2021 18:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evLgmZF+MStMUXwK9NXtGfPC0/tyQF0RITO4iK/gxDs=;
        b=MBe0NeM2dWXwhj44sF0kUiW3YWWnNfXSM6WQQWYjcj1ea6bPSUTQVFYpIsQXb1rsIC
         FQC7aIPkcxzO7oZvSK/3CzfIdOTCcJDBeCQVlJqLngKCx2lGqoDtgEv0xjskUhhFTtMD
         FgWLho23S9fWBN2E5YTQ8xuwOgEna/ehRMDefYZLHMZkgfqjsL+Jwgem997mvGwUv+dn
         QatDf6MN5SRLBnO5AO1x+uGElPxM05UdFogJuxnWXFHPtUoVoLt3ewXz2llfWCc9qJjz
         RySfyJ5TMAVFibkl/ryA3W4xJfGFzazmXxVIBJg8TsRvYmb4zXkcIDp7CCCgImHijirB
         CzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evLgmZF+MStMUXwK9NXtGfPC0/tyQF0RITO4iK/gxDs=;
        b=adylEqYWAFQ5EijW9/bg7iTuPFYIzdrL6gMb3LrkLCrolq0cKztsJ0qwi69k1sMcOb
         SqT/iOixDDkWRlZAO+slPwycZh0TOAgOreIqOVS1tmLQUF53B8gVnI6P93dZH3vyrPay
         szba39U9aMVxpEhhDrPODez31L2du8AxQmXqSnFtglW919csLwyqVHxFT71XGKbiOSI3
         /8U6LzrfNnGoPUw39KsPm0vbsujM+pEkhf5k9wS3cbbpev8opkwwgwJn+5okAkvJe8ok
         HRQaXO39lgvL16fEarw7qrCLjlvgtlfO2INuNAhnwk5HcKlyqXQNSJpBPm9SjgPbDBqW
         uT8w==
X-Gm-Message-State: AOAM533BVpaJo596oUyswegqtF5FZ4/soNyoxK0hperJlnH45darjUFQ
        jyF2Wc2RTBUTLlCu3wVr3Y61nWCzqiU=
X-Google-Smtp-Source: ABdhPJxMre4zIccQzX6H/dUWf0n76pvh7VABSaTKCOFZLGU3c/3gXqLKtTaKLw1T8g2sTIJyEk6mYw==
X-Received: by 2002:a05:622a:413:: with SMTP id n19mr41874429qtx.69.1639361824687;
        Sun, 12 Dec 2021 18:17:04 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c1sm7795520qte.79.2021.12.12.18.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 18:17:04 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     tony@atomide.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drivers/regulator: remove redundant ret variable
Date:   Mon, 13 Dec 2021 02:16:55 +0000
Message-Id: <20211213021655.435423-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from twlreg_write() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/regulator/twl-regulator.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 4a51cfea45ac..e2a20d512152 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -196,7 +196,6 @@ static int twl4030reg_enable(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int			grp;
-	int			ret;
 
 	grp = twlreg_grp(rdev);
 	if (grp < 0)
@@ -204,16 +203,13 @@ static int twl4030reg_enable(struct regulator_dev *rdev)
 
 	grp |= P1_GRP_4030;
 
-	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
-
-	return ret;
+	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
 }
 
 static int twl4030reg_disable(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
 	int			grp;
-	int			ret;
 
 	grp = twlreg_grp(rdev);
 	if (grp < 0)
@@ -221,9 +217,7 @@ static int twl4030reg_disable(struct regulator_dev *rdev)
 
 	grp &= ~(P1_GRP_4030 | P2_GRP_4030 | P3_GRP_4030);
 
-	ret = twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
-
-	return ret;
+	return twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_GRP, grp);
 }
 
 static int twl4030reg_get_status(struct regulator_dev *rdev)
-- 
2.25.1

