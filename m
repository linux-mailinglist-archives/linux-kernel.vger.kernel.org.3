Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132FF587817
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiHBHo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiHBHo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:44:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53D5B86E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:44:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id i71so6154031pge.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1D2oLWG7uQaOqEoFCHXc8g0emq/ruhZmSY5cz5yFk1I=;
        b=ScwG7jXOeCieDgrJu3SLQOb/Fy6a9hGaKBBduXXJ+DtnXb+mKEc89rxTJPbvBTGF37
         CrG4vir+tmxMT85uvgNjrIItNkOPhxysAtkzh0IuaOoOP68qMBBAKxh+KrT9MWcSzA8a
         /E5vt3d/+zGd55M/SDbIOTAB0ZfeA2MgTWDYGbM/4Vu69IqZ6u22YXyvjvc6DeBf3I4h
         uUYU+nm1RO14SP/Gv/XJxDnfOQv/GLcPo7sVlYH8JI92KRnOlKkTCLc+dvM3+epeiADp
         GaDzxb37X1kOlhzAueco3mbalptANE/9JBxIid9X51Oy9NYkenT9p5+RzBB1/IH0f2u0
         9EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1D2oLWG7uQaOqEoFCHXc8g0emq/ruhZmSY5cz5yFk1I=;
        b=Go0KRUSDtDl2aqWDE84NSjKygfElrat3Wm7h30Hy0Zbyhi74V1+yZ0q3lYwgVrjbRI
         wIckTgCb72TF68xoYqaMKzzht+cpkMzdYee5+FDcr2qOH02YRp/ebUQ98//O4ra9giBq
         lcgZfZYyEir5756aEsyRqqnCZq3icCzXHEQi18tYPGf8UFoat30VozhRB0pOq+fRCc8H
         b9IN/x3rKLkAjrocH2x0UGqOVFl2pg1n3jgBSzC2b80UuDBSGSNWTted8p86pz9I+Ysp
         L1edf5WlRektjEDsqfxe1XK1K0o805y3v7PVxfagqenH56Bq6PsCS7SyaZwJ6AerSltQ
         zy9g==
X-Gm-Message-State: ACgBeo2qFZCKaU9Y2439CHwHKIuPoEIviiXs9qybZt3Flvj0M+lwnjCo
        ktcKRb7zpif8xHW6bVcmDIh0fO4vUds=
X-Google-Smtp-Source: AA6agR71MEayIQcupqFmvpR+6eqV6gC2T8JGeM+JRd6PgJQPYG7wiz0ujRNQAaK7TcDj4gIGLYECIQ==
X-Received: by 2002:a05:6a00:1a90:b0:52d:7eac:ce98 with SMTP id e16-20020a056a001a9000b0052d7eacce98mr7937585pfv.71.1659426294922;
        Tue, 02 Aug 2022 00:44:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x134-20020a62868c000000b0050dc7628178sm10067725pfd.82.2022.08.02.00.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 00:44:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     johan@kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] gnss:using the pm_runtime_resume_and_get  to simplify the code
Date:   Tue,  2 Aug 2022 07:44:50 +0000
Message-Id: <20220802074450.1648528-1-ye.xingchen@zte.com.cn>
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

Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
and pm_runtime_put_noidle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gnss/serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index 5d8e9bfb24d0..71feca5eb70b 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -32,9 +32,8 @@ static int gnss_serial_open(struct gnss_device *gdev)
 	serdev_device_set_baudrate(serdev, gserial->speed);
 	serdev_device_set_flow_control(serdev, false);
 
-	ret = pm_runtime_get_sync(&serdev->dev);
+	ret = pm_runtime_resume_and_get(&serdev->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(&serdev->dev);
 		goto err_close;
 	}
 
-- 
2.25.1
