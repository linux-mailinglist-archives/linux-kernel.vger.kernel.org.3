Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5757D9D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 07:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiGVFqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 01:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVFqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 01:46:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6449828E2D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 22:46:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y15so3722826plp.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 22:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6qfhPAy8G5zOKXkzHRwmclNoof4w9jm+4E/34Uladc=;
        b=cHB4LGemLVKSmj7vIqudOT4rb8eK3hifxuVpyTKQObGe1B1OAgzyplRwS9TXdWrrb8
         /PXXHZiWEwPcQyLAxeK5hAmzBDqN319dRuRRvT2ivBEgUZiFoEz9ochiZ7peaHdWUUuw
         weeECXcbp4Nu5QJ5U0VZa+mtSJtS3TjmB4NDTrGEaOYlbc0u4gM6VvsXGAtDyGRsgMkP
         5q6KDvVXJ4nVgat+EkamuciEgFy9rcHlHRe3shVv94oh1D+7F3NjTgL7WPWZt+rYiNJs
         qh3cKNOKFbkwmzZS3M6w4sz1elm/Mk+yWNXRydLELVxlNdzRB/gaNKrbxp/SoVo6+BrU
         mcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6qfhPAy8G5zOKXkzHRwmclNoof4w9jm+4E/34Uladc=;
        b=XDGLrde9YtplMO5VT+xpnUtVc0npng7WGdNyU0NX380f+Kj+na9JYCrS6281RRn7g2
         yWc7KEm9+jrI+Zy3pwbyTomDIm7PTshiaC1t2w5RiXsiq1XxEhYqT5DUrjmC15uXfvZH
         AsNru8AQLDELb6Nz0w4YlinkRnO5wDumkxazwqJUl2N1PSI7t2BQWyIDaA1eb6GQb3bk
         nuvdif9yZ8GgUFPaLyHaEnJhhg6N6ukVnJDCzatgTNSJV/H8pnoXjqdLnvJJvgiL5Pz0
         pYwZ9TvkZ8uHB3ONaxuXAOjOe+wHiR53MVWSQn+XOps8uMDFcygarEEhavdLQKC30g4L
         IZgw==
X-Gm-Message-State: AJIora/QalsN1uws9T64Boyc+7xOzCDJ5H8ydJGxUD6SNAfagO0tgQUO
        OKMatU6si6t+XPzCZ32prjo=
X-Google-Smtp-Source: AGRyM1vLyGOb7NwDZ9WM8jk8/cs6v6fEQDmS9jj8M4ss/nc1OZ6VmQuOmkHyzvm2Fl8j85gUE9lVPQ==
X-Received: by 2002:a17:90a:7a8b:b0:1f0:80db:129c with SMTP id q11-20020a17090a7a8b00b001f080db129cmr2232441pjf.209.1658468775865;
        Thu, 21 Jul 2022 22:46:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r5-20020a635145000000b0040dd052ab11sm2532555pgl.58.2022.07.21.22.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 22:46:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     matthias.bgg@gmail.com, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] soc: mediatek:fix the compile warning which about svs_resume() and svs_suspend() When the static function are not be used,there gonna be a WARNNING for it. Ignore these  will make the compile to sucess and should not effect any other thing.
Date:   Fri, 22 Jul 2022 05:46:09 +0000
Message-Id: <20220722054609.1501177-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Reported-by: Zeal Robot<ye.xingchen@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/soc/mediatek/mtk-svs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index dee8664a12fd..f411fcda8c6d 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1478,7 +1478,7 @@ static int svs_start(struct svs_platform *svsp)
 	return 0;
 }
 
-static int svs_suspend(struct device *dev)
+__maybe_unused static int svs_suspend(struct device *dev)
 {
 	struct svs_platform *svsp = dev_get_drvdata(dev);
 	struct svs_bank *svsb;
@@ -1512,7 +1512,7 @@ static int svs_suspend(struct device *dev)
 	return 0;
 }
 
-static int svs_resume(struct device *dev)
+__maybe_unused static int svs_resume(struct device *dev)
 {
 	struct svs_platform *svsp = dev_get_drvdata(dev);
 	int ret;
-- 
2.25.1
