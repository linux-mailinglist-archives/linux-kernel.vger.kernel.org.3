Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6D4FDA98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383188AbiDLIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356335AbiDLHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:35:17 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D254A3C5;
        Tue, 12 Apr 2022 00:09:14 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a11so18367725qtb.12;
        Tue, 12 Apr 2022 00:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ou8zotsDb6wXIPljnzHu4XUowbgMosM63Cn663rp46M=;
        b=LVlh/tRvH71ktLfuib9NCViHKA8f0kEJc4AmJMpKEDE5aEjyO+V+Vbm2CUWH07lJad
         8/9Tj/cMllX/mRTxp3rXVBvjiov+7QAmYwTWqc3COJWNC8H4B/h1XOUidXW+zbkzaZwP
         oD5jdVXyteqNosnRQJ3vAAHRnHa+MMkuAJzZrtJelhDsHes4oqS8RcOcL9BOxZXRTcxw
         s1KSsomLF/OjH77XNPs2juRaOEuhRKQ87HrpU+/4SzEO0JJM1jzjbW43lpadSFzTLgXN
         /J/qdATZY47naHznlo84/HmjjjBnQ5bL38g62skwnmnINWkRKGqzDEAW2O9uViIBz45V
         DK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ou8zotsDb6wXIPljnzHu4XUowbgMosM63Cn663rp46M=;
        b=r8mpVtXroBiV6zLDdXxz0XgGHE2bfOp1AcZGWAPvAj4fTrEa2WGRqKnBebYgJiszfz
         8Ge81IBoAITg50fXURXWdEeCYOFZjmF+2qJZi2oUg4zmbEIDv+WJmSIXNGUa+VNBD+vq
         iJ9Z1rtQ1BW5dYCQRZob6tt27ZFsrkNxbSWhbgHYCEaQ5kbyVC1Yd03go2hd/sXesn31
         YckH1G69pEPeSHsLhZfF3F6fCNOwS8op7iR2AJLIc87GPuubrY1TwLyXIsDfrjfwYdvp
         6TflLg3YKilsyuSfSlESlQvzkZMCEj2+puXN5mJVoqMjNv3K4YgmsHsbXFbEsU4nKU0z
         L9OA==
X-Gm-Message-State: AOAM533jL0EweC4YN7eK60dc9G+POmPgg10XqZX9fr71Uc/9E/ejAs6G
        DIwiNZFlxVd0egqlgb7Oa9E=
X-Google-Smtp-Source: ABdhPJx4DR/2lIWNbxf+QPOcGkQ+ZbHPL7PSoRYaKAeefy7mBD1ijw/kEHdShjr7h9+JBy+VPiAijA==
X-Received: by 2002:ac8:7c55:0:b0:2e1:d535:d881 with SMTP id o21-20020ac87c55000000b002e1d535d881mr2266217qtv.188.1649747353658;
        Tue, 12 Apr 2022 00:09:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm27634358qta.76.2022.04.12.00.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:09:12 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: spi-stm32-qspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 12 Apr 2022 07:09:06 +0000
Message-Id: <20220412070906.2532091-1-chi.minghao@zte.com.cn>
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
 drivers/spi/spi-stm32-qspi.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index ffdc55f87e82..b3586521d08e 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -463,11 +463,9 @@ static int stm32_qspi_poll_status(struct spi_mem *mem, const struct spi_mem_op *
 	if (!spi_mem_supports_op(mem, op))
 		return -EOPNOTSUPP;
 
-	ret = pm_runtime_get_sync(qspi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(qspi->dev);
+	ret = pm_runtime_resume_and_get(qspi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	mutex_lock(&qspi->lock);
 
@@ -490,11 +488,9 @@ static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
 	int ret;
 
-	ret = pm_runtime_get_sync(qspi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(qspi->dev);
+	ret = pm_runtime_resume_and_get(qspi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	mutex_lock(&qspi->lock);
 	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes)
@@ -536,11 +532,9 @@ static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u32 addr_max;
 	int ret;
 
-	ret = pm_runtime_get_sync(qspi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(qspi->dev);
+	ret = pm_runtime_resume_and_get(qspi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	mutex_lock(&qspi->lock);
 	/* make a local copy of desc op_tmpl and complete dirmap rdesc
@@ -583,11 +577,9 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
-	ret = pm_runtime_get_sync(qspi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(qspi->dev);
+	ret = pm_runtime_resume_and_get(qspi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	presc = DIV_ROUND_UP(qspi->clk_rate, spi->max_speed_hz) - 1;
 
@@ -851,11 +843,9 @@ static int __maybe_unused stm32_qspi_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	writel_relaxed(qspi->cr_reg, qspi->io_base + QSPI_CR);
 	writel_relaxed(qspi->dcr_reg, qspi->io_base + QSPI_DCR);
-- 
2.25.1

