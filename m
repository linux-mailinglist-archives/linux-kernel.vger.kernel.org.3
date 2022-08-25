Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95375A0A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiHYH2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbiHYH2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:28:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2076440;
        Thu, 25 Aug 2022 00:28:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x14-20020a17090a8a8e00b001fb61a71d99so4045837pjn.2;
        Thu, 25 Aug 2022 00:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=o4ZPaiscy7+RYaipvTVXhM3gfUJGfdg1a2QcIEgV5dQ=;
        b=Ygd4c7iUeHIcrXqOuUXT6yh8eKwHGxQg7mUCsomyr/2FfttbnZ2UZylWq1xNuU+I0S
         yuoeXisb4bLFYL4p5/7uTKO+O72HFRDRpusIKvIv4wQM0uxkvuLxKg3pBDZeGmTqmtry
         JPYs7cNfXp0/7xCFdL4q5PHULvolYepaxJVvLkM2TRteW0MZ0t9I2xFSuppSbDXhlYSL
         mrJZ6UPhbgOIUzDPcInWKSGMsGVeKJGlQpBS3SMPe9x6752FgsEdZzBrd+Lk03ex9r7O
         EvQiLQXMCYuoK/ojfZgaapl89NX8JqMrHFpYZ6naRGovYYfB1QWd5BFPy1bKk0FoGBCg
         D63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=o4ZPaiscy7+RYaipvTVXhM3gfUJGfdg1a2QcIEgV5dQ=;
        b=n2J5vsdD5fyoS7xWyDwiG51sSgHVMg3KAEA3H+i7OkQWfRyrDtzWHNacQPA3rwVNMm
         ZCn26/vTEbm58N8w7Xyj0vxrOnY/M4ryPxPMVNl/CfNyQOmMuaAJmNdkDpOoy6NYSFl0
         k1QGg9WG8DC2R/ARGOX3CB+9Pijt7PcOXWAm9MWhUNcoMxrcGuWcwZrgauZhxO/+IHtX
         7+1YNlCKq/fYgZkL8PvO9aLJvxk6KHqxn2DZggtpevx6rJviadTMxwSMpdNVUiZ00zhI
         esboMN448u9Lf96WLHlDhbwjDK+2zqpnGnaq5ALgaVuQaK3SgdjlF+dz8xkZUBkfTM57
         E3vw==
X-Gm-Message-State: ACgBeo2hbqnHWPXV9lqmS/8yvuduKi67IbFkztXyagBHZ3HbwRNhtvy7
        +tbpgr5LAv0KyxVImTYfIQU=
X-Google-Smtp-Source: AA6agR7Ev/Ch8MSTyvzH0nVCJleuwkC4U9TzWiA35FvJDp2BTholaHOWIKqofQ7f0d355BHvVuHWHQ==
X-Received: by 2002:a17:90b:1c0d:b0:1fb:7c92:1373 with SMTP id oc13-20020a17090b1c0d00b001fb7c921373mr7967786pjb.24.1661412513039;
        Thu, 25 Aug 2022 00:28:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m14-20020a62a20e000000b0052d4afc4302sm14672131pff.175.2022.08.25.00.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:28:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] spi: pxa2xx: Remove the unneeded result variable
Date:   Thu, 25 Aug 2022 07:28:28 +0000
Message-Id: <20220825072828.229294-1-ye.xingchen@zte.com.cn>
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

Return the value clk_prepare_enable() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/spi/spi-pxa2xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 838d12e65144..986ffc4bf1ed 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1873,10 +1873,8 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
-	int status;
 
-	status = clk_prepare_enable(drv_data->ssp->clk);
-	return status;
+	return clk_prepare_enable(drv_data->ssp->clk);
 }
 #endif
 
-- 
2.25.1
