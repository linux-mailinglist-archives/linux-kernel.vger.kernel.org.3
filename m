Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E38512BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244288AbiD1Gpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiD1Gpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:45:30 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB26E5F266
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:42:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id o11so2772699qtp.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uC2h0BfliDQAIJPVK2C6qVvvyrsxrsop8K7TxsyMdpc=;
        b=PtCj5cxd2nwdfjCT2xAx8431XD0HRzDXcvGvwM/Jm8VyEthRh55eQEIDMSAiB4oyKz
         K3plNbEytTzQiPzDMwsDdXZUNFuxZKV952cwOJuWinpd2GGmUEfe/kG2Ggr0qhp3ZOpw
         yZDbt44JEDJqHQb2FkOhoifmm0q8abooC1j8r8/r1RkhUPiL11GogFKtxzDQReclL79m
         arRFRFo0oc17w+NIyBRTX6A5TIPZOKoU4+9/GncX0jpleurndMWjlqH8pfBsoC44mWPl
         iHh+jHUPe0tCZ8a1V0aJZtvhV2rYOvq14PIfeofq7O8DzjkJQsD3bithzgJAJfwqnqKd
         r7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uC2h0BfliDQAIJPVK2C6qVvvyrsxrsop8K7TxsyMdpc=;
        b=4khIgzq+DJDW+ndnm4aZLyZi2dgyIYzXcBSJj1LhNCVq99ymLIBUqOq1jPGE+jgGiM
         EOyOoGLhHVFD1pfkDqxAXTXeh9VkwYguzeWTFXaeUmg/l4uPl0GdBtTRsxwENiEhl8OO
         8QyPHcCU42ElJVIXYB+YFL74knbfbUjxp72cGzeYr1rS8MIqy3JeYrl/4E3NBtfW6PIG
         pV4wulA9Mon2Ejb95BtzkapDn8Gvbd2q0MGjLoTTDrzWngvPglZ6pbN4u/fQfRXvN99R
         IzLVhVZjKCJ7JtiuYQWdDOff4govPqQ/0u7s//0tJZbEKFi5lt3vayLPCrtHTE3M+4qu
         tFFg==
X-Gm-Message-State: AOAM533sJOoFRFUVnJArf7qQrWPs4UClqQkNnaCYOm+bmplg4Ld2G3yw
        rx33+blYKGWfmtq76DiunBmmK/a075E=
X-Google-Smtp-Source: ABdhPJyPZ7d0CNVsi/0M9pcwgfY8bVzfN0wu6geRvfv26wrRPXU+h+k+vHxWjq2/AREFvijPQTDJgg==
X-Received: by 2002:a05:622a:d5:b0:2f1:fc1d:2a1d with SMTP id p21-20020a05622a00d500b002f1fc1d2a1dmr21830414qtw.428.1651128135896;
        Wed, 27 Apr 2022 23:42:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x24-20020ae9f818000000b0069eadcdc218sm8894841qkh.135.2022.04.27.23.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 23:42:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mailbox: omap: using pm_runtime_resume_and_get to simplify the code
Date:   Thu, 28 Apr 2022 06:42:09 +0000
Message-Id: <20220428064209.3849869-1-ran.jianping@zte.com.cn>
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

From: ran jianping <ran.jianping@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/mailbox/omap-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 58f3d569f095..098c82d87137 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -856,11 +856,9 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mdev);
 	pm_runtime_enable(mdev->dev);
 
-	ret = pm_runtime_get_sync(mdev->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(mdev->dev);
+	ret = pm_runtime_resume_and_get(mdev->dev);
+	if (ret < 0)
 		goto unregister;
-	}
 
 	/*
 	 * just print the raw revision register, the format is not
-- 
2.25.1

