Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B89C504F31
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiDRLFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiDRLFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:05:11 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8F01A051;
        Mon, 18 Apr 2022 04:02:32 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id d9so10679302qvm.4;
        Mon, 18 Apr 2022 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KwyseOOW8ChvqPT7t3ckfOEHdSmRiVst/y+aZ/NPYUo=;
        b=fhwKvHlQvWSErlvuHEOQV61vM9QDuO7iyItC1b8C6uYG9HeMpNY7D9BdW3rTBv/iGP
         hitq+IsFJt6MiRR8eOEtGp5DON1aLP9lrqw/zOudU89PR+kral5pgNrOACPMdef5wyir
         7frcBAMsGSxrv1tYIZWDqUmRV9zW4ANUJtOG0wrZQNs8IDbxA+ESZvGZXcB83TQw8ZZd
         Wz8+3Wh5XQALq4oYPVqyjvGutgLxqWRM6xHrwvPeH055K6dcqgmY8Ux/zaxltCXPEkUB
         rnyeL7EtyxENvifQN+GT2HZFK26/S4uPxKmo9qJV197zGFp/eJNysAXPfzTWafjCCVxg
         JtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KwyseOOW8ChvqPT7t3ckfOEHdSmRiVst/y+aZ/NPYUo=;
        b=Fg1Ro6CkCuqgV9ZLXfs9JaSLmg0rGhzJQ+xJ/zxlelB+MbihSaqxHdW98oek3OJoZo
         KB9LyCWHpBw2Sa+FyrvzNQh41lN8GP3JFgN98Q0f6jHwelCvWs1rBbrtT+qv53eZjApp
         JsM0pkQDqZe3+h9y2W5bXSbFzzt/XB0u2wKphdpgYdZ9L9q2Jn7F23sm9dfHOqp5WV8D
         QyGB9ScYM3Z9jarSvMzQrxE0++F/sGe8ic3YhDp9wYREsVCQ80EyoZ9XEsG/6GarrFu6
         NcdUTACK2cMNUQmMxVSdBPpxa/LAGPkKHko94Ejf0fdhz6QA3yYBwTsgqNPZtQwSJhAa
         1jxg==
X-Gm-Message-State: AOAM530TJF7aLm1kuxvHLxq2RrdHJJQzAUE88HDXtgarbnbDlry8QCBg
        30EZ5hTGpyWi98i9xm/ka5g=
X-Google-Smtp-Source: ABdhPJxMIDn5qytDBPSrxbwbIdtXiejKYID5KVncidHchhwfS1ZrsT3BwN3BDL9UBNxbz4evzaWIdQ==
X-Received: by 2002:a05:6214:2627:b0:446:6577:6ef8 with SMTP id gv7-20020a056214262700b0044665776ef8mr1281153qvb.85.1650279751970;
        Mon, 18 Apr 2022 04:02:31 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s3-20020a05622a1a8300b002f15bb78651sm7412969qtc.38.2022.04.18.04.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:02:31 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 11:02:26 +0000
Message-Id: <20220418110226.2559081-1-chi.minghao@zte.com.cn>
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
 drivers/spi/spi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9bb5400af205..b7a45a8f8ee4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1607,9 +1607,8 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	mutex_lock(&ctlr->io_mutex);
 
 	if (!was_busy && ctlr->auto_runtime_pm) {
-		ret = pm_runtime_get_sync(ctlr->dev.parent);
+		ret = pm_runtime_resume_and_get(ctlr->dev.parent);
 		if (ret < 0) {
-			pm_runtime_put_noidle(ctlr->dev.parent);
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
 			mutex_unlock(&ctlr->io_mutex);
@@ -3540,10 +3539,9 @@ int spi_setup(struct spi_device *spi)
 	}
 
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
-		status = pm_runtime_get_sync(spi->controller->dev.parent);
+		status = pm_runtime_resume_and_get(spi->controller->dev.parent);
 		if (status < 0) {
 			mutex_unlock(&spi->controller->io_mutex);
-			pm_runtime_put_noidle(spi->controller->dev.parent);
 			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 				status);
 			return status;
-- 
2.25.1


