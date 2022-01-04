Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75104840D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiADL20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiADL2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:28:23 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E90DC061761;
        Tue,  4 Jan 2022 03:28:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v11so31985514pfu.2;
        Tue, 04 Jan 2022 03:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8DPQAM5n/7CIbAlmu2xJBzlGFegSXdSezbkc3xUc1Cs=;
        b=W1YB9jrfC5th/K0fddsWXfcj6l0G4wjQHJXLEB/E9pe6yd3jaXVCbk9KbavUIdgJRk
         I5NmdQcGrNUBgP9zzMDgKmErzh1a+596fj2+WyPetGYh9Izz0jZRC/lOEHE3wwD4HUt3
         dAV0yT9nCZuRgXP/kM7kDtfuOqoE/8Ff+GY/8m/bA5xcc2ChtrCFjzAiqXzYzdSkBeeK
         NAn9iAipImAIMd7qMhtRncLwM2M0s1cVYYpffAOmuWlRzB5YqSrQr3mKBAc/z8Ahs4l5
         PTAJpLVWHe/Fsl2K1z/EvhE92z8WvDmlY6/k9Zbpc67s+ZuyNm1jzh7E1PItleLUgkus
         kgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8DPQAM5n/7CIbAlmu2xJBzlGFegSXdSezbkc3xUc1Cs=;
        b=RgP2UvSqvIG/1Tluzc7FnehBimvRisU9tLfS6ijTrj/QLzPMx/oXeTcobHPgtiTmsL
         kXWfRwtbKtmyrd0+We+iQsN0L38rqr4Hk2uGjaDDxvm3ySA6W2dyB0GK1164X46pHhsi
         GAksNBtJ1c0CYo5AWgEmAcxLELHaZP7BTJ96TvLl/+K/DIM09+64M/HQcLe0zmusJi4+
         Sjhe2Y3X0Gw27EgG7hQEJTy7pxZCMIHq7Jja2czLw0M2Nm3TzVozFYtfOLCdAeLWCVVY
         3qUiMFsGjpNjKQuVp6ZgEA6ClbzDqCt7wQkuRe7941KP62v5BV3YB2kJNU5YJtKBzC0W
         g5BQ==
X-Gm-Message-State: AOAM533AN2XqiC5Eb47Ejbz0zY+3r8PsBzoD6O35Qm9LUakjKJBGM56R
        AzHdTkCpej1gYSWuHwMDj7lrT9Rs7+0=
X-Google-Smtp-Source: ABdhPJzHX6L4/qEuItAyFZAaeyfEiQ+ko+9B3H8xNbwDjaxzynZvK0FJYwiQTBYZvV0xOD78m0q7hA==
X-Received: by 2002:a63:4507:: with SMTP id s7mr43066703pga.252.1641295702911;
        Tue, 04 Jan 2022 03:28:22 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f4sm39404828pfj.25.2022.01.04.03.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 03:28:22 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jdelvare@suse.com
Cc:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/hwmon: remove redundant res variable
Date:   Tue,  4 Jan 2022 11:28:18 +0000
Message-Id: <20220104112818.602025-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from inb_p() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/hwmon/nct6683.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index 6a9f420e7d32..ab02e967f73d 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -495,13 +495,10 @@ static inline long in_from_reg(u16 reg, u8 src)
 
 static u16 nct6683_read(struct nct6683_data *data, u16 reg)
 {
-	int res;
-
 	outb_p(0xff, data->addr + EC_PAGE_REG);		/* unlock */
 	outb_p(reg >> 8, data->addr + EC_PAGE_REG);
 	outb_p(reg & 0xff, data->addr + EC_INDEX_REG);
-	res = inb_p(data->addr + EC_DATA_REG);
-	return res;
+	return inb_p(data->addr + EC_DATA_REG);
 }
 
 static u16 nct6683_read16(struct nct6683_data *data, u16 reg)
-- 
2.25.1

