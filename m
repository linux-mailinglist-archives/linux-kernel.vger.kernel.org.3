Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84304B061D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiBJGMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:12:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiBJGMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:12:10 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF3810CB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:12:12 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j12so4180902qtr.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 22:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrZYZhVieaqUVr9oKAFnYwTp3j/qeulQmt2ZySmuWeQ=;
        b=UT4Dl+p/YSVrocXeWDiK+6I87l9ZhKpYNodmNNUudH8LJCpzfFqdzLA9kNP46ISFy1
         LDlO4L3hrcqAb6hWjOwxjJYDEELQeVbNtE2kNCC7afieSt/D2FSl4uCc9yc3w7XZXGZw
         AvcY9l1Y/12IurnciB9utSodjMLXP4w2SXog24+x7y4lrQmdKjIq6Jq+og3jYqbpAegI
         GRHDWQXpyiC8R7Jhmf1eomY3eLQZRDBwSe48FwVsSo3Ck5T4MR1wgFhva4PgbOtD2OUY
         u9g7/z7QUHfu9e4cArDKJBzQNqQ9FBCJ1PZmZMsN8m7QbwrromM9bYl6kExsPD7D9jyy
         ZcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrZYZhVieaqUVr9oKAFnYwTp3j/qeulQmt2ZySmuWeQ=;
        b=UfI56vBYWvmGKs42m9vk71HKFaKevJD4OZZOkaMECbTc26OU8zaBLiCLSzG+mgcioQ
         53v+4mi0KkzCQcNWV9c0hb0qkSBHYBHKGRHpdDp9czy6tVRjGe3+33QrsYkaKfppa7aN
         yypxpkuKykD+7TUxXa3sZDMw8/ZnU6LAYjiw4+ZRGlzlI1HAxLGuPXn/ElPa8n7Psfqw
         ZA5AvlAUIHxYCCeztBa6VCPft8MEhGq87axYlWmS/UvpSIv0gW6Wf/VB/2915PrCDk8c
         a7B2/uCMXvOBNmrkSKQxS0yFMpUBkLr+4fRsvCK+v0ZHz+lxTIeIH7gM4Xx2FMH15wX+
         knfw==
X-Gm-Message-State: AOAM533QRkmwpbqHwi79jgtMNCMpI5wfso2fs9gu36+jChJjPkN3aT5H
        e0TKZZrYboiPcQBNEBez204=
X-Google-Smtp-Source: ABdhPJzsa2hL8YGGhXHZpNoEomnhQ6Wwhy3EqJ/StnQcNRNmyAYikGzhfkdlM7ir7IIPmj6w5cq/pQ==
X-Received: by 2002:a05:622a:1a18:: with SMTP id f24mr3814901qtb.158.1644473531544;
        Wed, 09 Feb 2022 22:12:11 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bq41sm9273835qkb.9.2022.02.09.22.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 22:12:11 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     codrin.ciubotariu@microchip.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drivers/misc: Fix IRQ check
Date:   Thu, 10 Feb 2022 06:12:04 +0000
Message-Id: <20220210061204.1608604-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

platform_get_irq() returns negative error number instead 0 on failure.
Fix the check of return value to catch errors correctly.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/misc/atmel-ssc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index d6cd5537126c..69f9b0336410 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -232,9 +232,9 @@ static int ssc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(ssc->clk);
 
 	ssc->irq = platform_get_irq(pdev, 0);
-	if (!ssc->irq) {
+	if (ssc->irq < 0) {
 		dev_dbg(&pdev->dev, "could not get irq\n");
-		return -ENXIO;
+		return ssc->irq;
 	}
 
 	mutex_lock(&user_lock);
-- 
2.25.1

