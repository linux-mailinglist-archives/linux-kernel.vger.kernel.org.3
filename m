Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C687959D2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbiHWHzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbiHWHzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:55:20 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB8333343
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:55:19 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y127so9757849pfy.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Z+RQpvDmeUMwkzD0zE5O9n7j7IoYm1Li9Lv8hFvLuiA=;
        b=B35tb0ihyKDB3F0yiWv9zXHButoLRNlU/g/hnff3vJGN1dshZ1QMseik2JO5v86hSy
         y2vSsDnv4mpxcMojUaw5BoFVLAgOgQyqZUqJlHFQGVwZlk9WSjkc0KwDusyvXgUoqmcD
         JKhZCUI+/P7I5X6K4xbbwKq1xdKUdp5GnMlcqlDxP0VqP32nnmfrTd7EB6pwyWMs/oR5
         iztE1mhVe7Nt0EQ8QShrgt9t1XOcCvnEGwxGBf4ze0uSECsXIgQGNIJQlt2i1cJLBSKm
         /iHm6LacJ6c9BF75ti3cvuPt4d96bnGbWsZz2irwFiWpHt1SvOifRAv3bGgH4naQ3v86
         rKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Z+RQpvDmeUMwkzD0zE5O9n7j7IoYm1Li9Lv8hFvLuiA=;
        b=6MU2Yf1zPKIy0D48aCeWGF5WScDkhzUTfxaLDsJj05cJYqtnGyEWiwF3sSIX3kPVv/
         3qGSbIQe1qGVc8fG4fBy/wYQZ3W1TtIt0kjYilEwHO4I9TLpTW+wM/ISjbdl1lQEI54J
         uj0S07DdZ35Q/q6yY9VK1ns+YfPI69hGyVDUQkH6sDsLhHQImdf3MSI8nu7MazXArCML
         ZNPbkqGtMErK+mxbGByRbs/n2pHcENIs9n9eeceQKoo6rjKW+LpydOKagSaGARhYenKy
         zQvEp6OD31N+3CeB/r4tS8WwduAx4ueISPe/mROEbdadp92kizCIJUUfWeL2dMfJAkZ2
         d7Eg==
X-Gm-Message-State: ACgBeo2xK1pv1e6jA7nc2t3k2NpxOK8rDkC/fZ+oRAjwjPr0IZE3lNJ5
        lje+MF5PBOKspXEYqQePt94=
X-Google-Smtp-Source: AA6agR593saMfnIXLLt48gWmj18L+jMdWcoS/nRdwvS8vspgXhn88hj4OSKLUYHJRJhZN6xmfOxvQA==
X-Received: by 2002:a65:460c:0:b0:429:f162:78e1 with SMTP id v12-20020a65460c000000b00429f16278e1mr20062230pgq.7.1661241319240;
        Tue, 23 Aug 2022 00:55:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i19-20020a63e913000000b0041a6638b357sm8633277pgh.72.2022.08.23.00.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:55:19 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/mediatek: Remove the unneeded result variable
Date:   Tue, 23 Aug 2022 07:55:15 +0000
Message-Id: <20220823075515.209198-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value drm_mode_config_helper_suspend() directly instead of
storing it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 5f02f8d0e4fc..91f58db5915f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -833,11 +833,8 @@ static int mtk_drm_sys_prepare(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 	struct drm_device *drm = private->drm;
-	int ret;
-
-	ret = drm_mode_config_helper_suspend(drm);
 
-	return ret;
+	return drm_mode_config_helper_suspend(drm);
 }
 
 static void mtk_drm_sys_complete(struct device *dev)
-- 
2.25.1
