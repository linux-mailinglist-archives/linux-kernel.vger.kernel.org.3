Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394DF5008E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbiDNI4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiDNI4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:56:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02182673E3;
        Thu, 14 Apr 2022 01:53:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso5056229pjh.3;
        Thu, 14 Apr 2022 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EXSPMekmKF60dN1LmmBevrjt9gjd/YkMCxZYCjUgnnc=;
        b=foMayma4Rv1qoP9c+LqPLX/78Edy0bpzp9UA/SdCUCmLN22putpAMYtFVkwsY0MBrr
         ei1JO1YQDsW1WSDC425nvE679EGlUFDyYCT0rhA1JO20qUO8TLGSYXk4AmEYBsg2cuZT
         HQcKXyl+OYXJujJ9xTXDbx5GsiUuL5coRWsrxBKtqV1Ai/PCF1Uulq8acVonhJeENSc/
         +ewXb2u6buaGo1oSS7JI+uAFJTca7GLTFMdLMmwNbao0ikzTXHzNXjrOh8+gcHUrFoR5
         ZuCc1OhptOeFGztnMhZn+jRnKDtUVUYnP0HMN3DSc0qzluIEyVrV05d8TKVj8J44iA1n
         Sapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EXSPMekmKF60dN1LmmBevrjt9gjd/YkMCxZYCjUgnnc=;
        b=sPFcJT/fRpU2VYKtoZzKd6ioZsKKBN2ey0szRK59YPe30kiqg+fKJvqGpK+IT2aaDi
         EE6LCFUDacdFph6e+pODCYPQ2w57ky0DLyua929VzXyf+T74Vp/jqqoVoC8n09aJybA4
         ZeUNicrH+aeyFLzTI0X4YNqCVPznnWpunbYejG/Ya9gxtrQXUSrYSAdcYaSnOFkPEbC9
         clIl5ycfRkDXaI0LoaOqa3NRDlFNRxsfOmx9dsVd5lgmGEJHW7aj5V4p5Dt6fpOf3EH2
         rrLqzJqUrCO8EbQzvN3YC2yRoWCn9yizsTUbexooXD/5T/CSm3vorUKihIKZcq6q4CvO
         aSFQ==
X-Gm-Message-State: AOAM532f9bSRG5Hv6u4Hi+xzDc53nhVaro0b9ZPsE61OGV8j28lR7Yhv
        kIUIV1tfM4QdfZzUjUMW9c8=
X-Google-Smtp-Source: ABdhPJxrcJJ2YXLVxQBa+gwO26JNd2LfOODrUftQsSjX79QfJI2pVu2CxZ2sFiWsMuIxSsr4zfGGwg==
X-Received: by 2002:a17:90a:510e:b0:1cb:b1de:27a0 with SMTP id t14-20020a17090a510e00b001cbb1de27a0mr3233504pjh.196.1649926430421;
        Thu, 14 Apr 2022 01:53:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x8-20020aa784c8000000b0050577c51d38sm1450877pfn.20.2022.04.14.01.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:53:50 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     shawnguo@kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: spi-imx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Thu, 14 Apr 2022 08:53:42 +0000
Message-Id: <20220414085343.2541608-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/spi/spi-imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b2dd0a4d2446..7f500b073d62 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1553,9 +1553,8 @@ spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_get_sync(spi_imx->dev);
+	ret = pm_runtime_resume_and_get(spi_imx->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(spi_imx->dev);
 		dev_err(spi_imx->dev, "failed to enable clock\n");
 		return ret;
 	}
@@ -1771,9 +1770,8 @@ static int spi_imx_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&spi_imx->bitbang);
 
-	ret = pm_runtime_get_sync(spi_imx->dev);
+	ret = pm_runtime_resume_and_get(spi_imx->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(spi_imx->dev);
 		dev_err(spi_imx->dev, "failed to enable clock\n");
 		return ret;
 	}
-- 
2.25.1


