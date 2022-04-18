Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2C504CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiDRGdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiDRGdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:33:45 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91D518E17
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:31:06 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id n11so10409800qvl.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=13gEdwjzZtrsDNRdX2M5Qu4lIBynbl3JS4I2GZ0m2HM=;
        b=V6/qBut7IBTQ9nycZFR1dq8jB7GKhk/jPr203FGo9Pp6O7iuX8V5GfvnvZrVeB4Oox
         blJtXe1CJIg4PcSejFisvKrWo9srrX+dKN9KmamE2PcYUbDmQPEvxWZL8dwelHC1p1et
         WoM6Xa//j5OG28MGW4/+v3T95FVd11MR2wrG1eo42GGxIqsMSR+L5M7vtQR1I8F1b4G/
         UB5BDAD2sA5yOUebIz9huaq5dtUdNZVJqjBMWmrpMnxBlC3XHhpPytRHwbCJVT8ip73J
         Gydu8rwX+yWlsmU4hoH9suLs2G1pMQHFcQ91T2nfhlpHmIucEXcJQT0eU/U1EfNqP4k2
         Mpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=13gEdwjzZtrsDNRdX2M5Qu4lIBynbl3JS4I2GZ0m2HM=;
        b=6NWfIOgTlOR6b/+nsxwvVClA6QvKO87Ju/Zqr245UCNvzUd2TOYitxfzKXDyWaWxW9
         PZ0NysCGJ+Q69TG89VjOJ/qf5Pcy78bd1PC4UesE1ZEeZ+wFgeGgE4cN14e9fMaY9kDD
         Kg8TWzBcsu/O1QV4twhAmWAaE3SYQ1xKAluK69URpVYrweq2c8nbjADq1GDjDbH8H7dr
         P+qDC/txOdsKHM0Afi9T2odCJ5mvLUyVz3H89A3OerStxMF9fqprrTbUXiljUBL5veDS
         IB0+dWrlp2Z/t/qxbwme8b72aAZ9PbBJYeUguj+a5W2GRTfH15RT10Svqs9U4ccsxFld
         JYxg==
X-Gm-Message-State: AOAM531fITIhyjmBrCj6heQk3jVAB+viynf/uoS8qKyv7diM3ES13hdr
        7zQWwHCKr7jMr7ESsW+27f3iemcXrsk=
X-Google-Smtp-Source: ABdhPJy89sP3ypq9n+7pzOa8sRKHFCbu3yst7J48TBIOK9iKtj/vZjPRVbM+/ApPBqX1mZyR9QXUxw==
X-Received: by 2002:ad4:5deb:0:b0:446:44ec:8d88 with SMTP id jn11-20020ad45deb000000b0044644ec8d88mr6683849qvb.126.1650263466019;
        Sun, 17 Apr 2022 23:31:06 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c20-20020a05622a059400b002e1d59e68f3sm7254031qtb.48.2022.04.17.23.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 23:31:05 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     nm@ti.com
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] soc: ti: pm33xx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 06:30:59 +0000
Message-Id: <20220418063059.2558074-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/soc/ti/pm33xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 7bab4bbaf02d..ce09c42eaed2 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -555,11 +555,9 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 #endif /* CONFIG_SUSPEND */
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		goto err_pm_runtime_disable;
-	}
 
 	ret = pm_ops->init(am33xx_do_sram_idle);
 	if (ret) {
-- 
2.25.1


