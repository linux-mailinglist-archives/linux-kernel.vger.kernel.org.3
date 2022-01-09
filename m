Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1E2488C20
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiAITqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiAITqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:46:02 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72BCC06173F;
        Sun,  9 Jan 2022 11:46:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so966852wms.0;
        Sun, 09 Jan 2022 11:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I64jQZXCVAMHj3qiPQXlFwyFPvSE6eiW7ZoAMdqz8ls=;
        b=KQCLbnvm3eJk3eCKceaU3YBv8mJ1uXKEHsZqCjwWczCCD3nMETQKs1+5s51BN8quAR
         gnYwT6sSCwG9zL4Z96MAWOj5Aruya53TT9A0AtUvyJIR/nVOFZYoK9w3/MmTl/aS/2xN
         sBUiqZsf+Lh3Mk4lfhPobhpGU4dOMl9r8cQLLXJ+ToxuQR3GKaPKBuzuPFRqB24iIBe3
         okOVQ+cxcO1cjqjYNApvw3yCeDhyzSjmmi2/CC1BnzQY1cDw39KXxJZ8nyXWydPoLl6p
         bG05+wqzFGChgbBg2RcooaQprbNr1oKBI2cJ4Zxa6Ype/46BVn/P9SRK3dzKQgooTBnY
         uVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I64jQZXCVAMHj3qiPQXlFwyFPvSE6eiW7ZoAMdqz8ls=;
        b=N2FFh2wrvvqDPxf7QsX1uxUCYKYPGHTqU8093C1ZKqklvbDWs3NSWt0c1xzPEYirhk
         O1FvcjpoAZZpCaxxS8lbra941kV9AQThrejG4C01a+pq9PdeBRDL2JhhTHH2PfVfp39L
         gmfBZ83qID1Ovg1QvWr+nluHJ62EKXg3exvcT/Wd+dV0eObafjcRf2yXiuX3tOAhuk4R
         HPHWI6GE8LtTQPhr4uDd5+ZSVE9+H+TNuWBa3/IbivT58tiKVXzvAXKmgUD1g+P9enhc
         VpFq+nN6pe5gzLByrvYlh93Oy3X2bHUN+DPwMIBxgTY1p2ZFw3rn3yiv9gYuUQIrMLUF
         HIDA==
X-Gm-Message-State: AOAM531WkJ0fd45hE4j+raBUQi53ts3SvJvp7uPCGqKSulDTUjtBtiSN
        Zuwy1uHBpfNM7eXsVM5HHJVKZkLmSNU=
X-Google-Smtp-Source: ABdhPJz3jP/Cy1Ht4TO7hHZXJa4xWCunnEN72+bC7ZVYvfDYUQvMKeqaZ1QsZiejcwtGRsuqIhrecw==
X-Received: by 2002:a7b:c146:: with SMTP id z6mr18194246wmi.6.1641757559471;
        Sun, 09 Jan 2022 11:45:59 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n1sm5255449wri.46.2022.01.09.11.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 11:45:58 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Aleksandr Mezin <mezin.alexander@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] hwmon: nzxt-smart2: make array detect_fans_report static const
Date:   Sun,  9 Jan 2022 19:45:58 +0000
Message-Id: <20220109194558.45811-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array detect_fans_report on the stack but
instead it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hwmon/nzxt-smart2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
index 6e67da766969..dd892ff5a3e8 100644
--- a/drivers/hwmon/nzxt-smart2.c
+++ b/drivers/hwmon/nzxt-smart2.c
@@ -583,7 +583,7 @@ static int set_update_interval(struct drvdata *drvdata, long val)
 static int init_device(struct drvdata *drvdata, long update_interval)
 {
 	int ret;
-	u8 detect_fans_report[] = {
+	static const u8 detect_fans_report[] = {
 		OUTPUT_REPORT_ID_INIT_COMMAND,
 		INIT_COMMAND_DETECT_FANS,
 	};
-- 
2.33.1

