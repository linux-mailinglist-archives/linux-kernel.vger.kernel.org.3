Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2063509AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386838AbiDUIso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385732AbiDUIsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:48:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D6B1F8;
        Thu, 21 Apr 2022 01:45:50 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id j6so3072803qkp.9;
        Thu, 21 Apr 2022 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEFTLGDtfWVDHuldQRqU5lfCf1pN2Vgy21hTY3jHvgQ=;
        b=QhpKmsYZOuFIkN4tj3pzITIfRmGL2Vw7l/+c8exFfYc6R07W66oKCSEfVx2uaiEotL
         oMxreb9mw2xifvpnos2nFc3Y2+pdADJx2Mzr33z93JKDagA8B8gZ9M3RJmE/ZsUVBywj
         6NhWmo/mn8Hailgt9VnTYmHQr8KdQLM3r7NM+f9mZYcbuA1IASqlV+ieBLPerESqtg+N
         NnfHz6vOjwdViQaT6M6I0k1ZUuk8kYlViRnDQhJqf5nIpRDaGdrtG02MRkYw7umTQsbl
         lPLjKRJ5bJUlzzEaxEWpz3NpIyokwG7NKEcnvJvD+TYn16T+Hhh1VEjwRCLAR5Txf8JU
         pQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEFTLGDtfWVDHuldQRqU5lfCf1pN2Vgy21hTY3jHvgQ=;
        b=LoAlNiZy/NhYaSF2L3cnPqzxmTkZo06m6HvdOeKSu+it7lNW9rw6mxADeXiluSTvYD
         JonkmjVxAyb+IUtPWZTvi/hP7U8HgTA9owwWwzeXvb1tFw8RRRR84eh4oxAeHhXLU4ut
         ZLjvVgDlXqpfhawbcy99QsjQ8ZgFaChuagGd4h9UP1VcP9FJCfG+Cy5B68hC4RuuXg25
         DYdJASTSrhurCQn3Ed5IKiaHgcGRHvjifxwkQZkX1oW6FixWvL9ZqX3gs5GIbJJNdp00
         PUg+/D8U+bF1Vguw/miDnvjp2vkFcKQPjsuQ3HBZkZHYC8EhurZdb10ut60lVxjkRuZm
         DnEQ==
X-Gm-Message-State: AOAM5315yxjUKICRYas4l6D8vzAgHM7Xp5ZIoY2u69KCemrNXSFB8gYR
        8B2ToDyIBojtqgG3v7kM+p4=
X-Google-Smtp-Source: ABdhPJy4CvLhO4p7WBjhapwu+eeHntufKSaitDCKftgQbXnaIlO7ZsLftW46MkYtHfvXRPLF2+8TbQ==
X-Received: by 2002:a05:620a:4014:b0:69e:c20c:5064 with SMTP id h20-20020a05620a401400b0069ec20c5064mr7479298qko.111.1650530749339;
        Thu, 21 Apr 2022 01:45:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t17-20020a05620a035100b0069ea7219390sm2528245qkm.55.2022.04.21.01.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:45:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     thierry.reding@gmail.com, airlied@linux.ie
Cc:     daniel@ffwll.ch, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/tegra: Make use of the helper function devm_platform_ioremap_resource()
Date:   Thu, 21 Apr 2022 08:45:42 +0000
Message-Id: <20220421084542.2615381-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.Make the
code simpler without functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/gpu/drm/tegra/vic.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 1e342fa3d27b..daba4f6cc328 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -409,7 +409,6 @@ static int vic_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct host1x_syncpt **syncpts;
-	struct resource *regs;
 	struct vic *vic;
 	int err;
 
@@ -430,13 +429,7 @@ static int vic_probe(struct platform_device *pdev)
 	if (!syncpts)
 		return -ENOMEM;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs) {
-		dev_err(&pdev->dev, "failed to get registers\n");
-		return -ENXIO;
-	}
-
-	vic->regs = devm_ioremap_resource(dev, regs);
+	vic->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(vic->regs))
 		return PTR_ERR(vic->regs);
 
-- 
2.25.1


