Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEDD50846A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351564AbiDTJGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351152AbiDTJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:06:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE862E9EB;
        Wed, 20 Apr 2022 02:03:59 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id f22so505980qtp.13;
        Wed, 20 Apr 2022 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1TX3LxphyYPfykd3GExSANER38mSAXNP88zEi0V4a4=;
        b=Dh7ya4c2ZRShPzME5GPDKQPO/sW4/HMyIBuiV4A8f1hf09QRJv4BHYInf9G5xh8ax9
         itAo+PgEbcFvahcKYpQHAXx4TJ1G9dq7ph3Ce5Cr80/Xehyz1MLlno5hHhyXiYMcUQ95
         fXl2F6XoVyXWZxv+SsbMnZpjF65sd1sePXQzZLJPU/8piPzXn+JjyewdxnMByo2qyY1c
         EHRf6iDvoYX04QMGrzYF5+H9sOHSbn9sBcvxGMRVc0WZCHz5Nd8jQPBifYvLR1im+dTV
         yon6u1fD4dHgl57p0NgHKOAIqTamOLaW2ApOwcnz0ZEbJZjUfpOUWbD0jaEATcA7YPsL
         59aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1TX3LxphyYPfykd3GExSANER38mSAXNP88zEi0V4a4=;
        b=D9mXIxn9JTgXrjyiCDwbipGz8qJDqffbeBnW/TsJ9lnzeAfhUg//zAPQZFm3J7cuzk
         fj4DUoRaQBsyLfTvc03sBgmXD0EtiPwUXPl9SQMQYrWwUHmoJW1Kr8vGPd+pOAAVU2z2
         PNoB356MhKhMTmLf0QB5o1xxKCXD1Q7wv2eq2Vou4EJq3j4/t4kxD8N6/kxS1szoTG4e
         Z9cHJQVKYcGCTvEQBvE/eJSfXKmH3EOEDknSqJJsik0soAP2/bUe86Dn0uU3nrs8pjkC
         GTOx6eaBCqnw0yxnBI58ZLM6O/BZNGgX1XFiQAz0zhtOS2tR2SdTGgTEXGu+nCNnAjBX
         wWwA==
X-Gm-Message-State: AOAM531hjIBhlbLQufEkD9a0p0bwUufiRiUxO7UbRafAX+uQjGJW4RN7
        QlzxApOv7y362c61+26otWo=
X-Google-Smtp-Source: ABdhPJyWVBvS4DFoUzuUhmWNNT43TTb69T59j96Xkphuncrex//Ub01LqoYTFasZcaKrz4WtxRawxw==
X-Received: by 2002:a05:622a:40d:b0:2f3:3d14:6959 with SMTP id n13-20020a05622a040d00b002f33d146959mr3321375qtx.519.1650445438695;
        Wed, 20 Apr 2022 02:03:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 187-20020a370bc4000000b0069c8f01368csm1303613qkl.92.2022.04.20.02.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:03:58 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     alim.akhtar@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: ufs: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Wed, 20 Apr 2022 09:03:52 +0000
Message-Id: <20220420090353.2588804-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/scsi/ufs/ti-j721e-ufs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ufs/ti-j721e-ufs.c b/drivers/scsi/ufs/ti-j721e-ufs.c
index eafe0db98d54..122d650d0810 100644
--- a/drivers/scsi/ufs/ti-j721e-ufs.c
+++ b/drivers/scsi/ufs/ti-j721e-ufs.c
@@ -29,11 +29,9 @@ static int ti_j721e_ufs_probe(struct platform_device *pdev)
 		return PTR_ERR(regbase);
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		goto disable_pm;
-	}
 
 	/* Select MPHY refclk frequency */
 	clk = devm_clk_get(dev, NULL);
-- 
2.25.1


