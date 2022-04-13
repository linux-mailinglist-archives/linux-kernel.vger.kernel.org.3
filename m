Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9B4FF3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiDMJj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiDMJjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:39:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537AB541B4;
        Wed, 13 Apr 2022 02:37:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s137so1293701pgs.5;
        Wed, 13 Apr 2022 02:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZIbqNzlM4mGyXngbvjcRG1LQx/UAY6/404TR2/PWwFs=;
        b=j8GfcResZEwut76VbSxBlfk8dbQVlR/c6a10PTJq1uirvnk1P3Mbf+HyHcxtJ1p5hj
         Gwx43aaHNSsBcKYUlaYbg1Cg74OSxxrZFYOt2Lo9MzYF3LJPDI1DQHRWb4uKTiYnhQXA
         M+B6g4BKwOihidCO0V6RaUxc1BUESxcM71p9YUwLzUhjCBJN/YYJJGO8cSom54IT2sIC
         pysgQbnApUHSFR6rSjDTZby7noM9q80dnKDNp/cHbi0rvDVcwJQSDzdyyJo7zLfQFakh
         JCrp609KqPe+18ASLprBBLFxtgiaeaeUTI1TAmWyv/FvmGVjYjAJbL7U1+6PHkZeOnU/
         D0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZIbqNzlM4mGyXngbvjcRG1LQx/UAY6/404TR2/PWwFs=;
        b=Gd7xQZ/t8n9Tt1m28HBTrchLbH2npKgYoqT6Z/nc5aigv7a3kyRinwtviIPyFGHi3y
         zF+uQrlFJlbSQDC98T50/c8nFbVX7JnicS0PAHSnH5N6B9AJYcaznUvtUX8VMOFMPF1f
         rtIbvsm2AZqIbEZCxgZBRzGplf3lX5tt1EVxeq6NW8NsgWus10psjjAL5DYVH23idpnu
         z8oFZEvqPSODbfkCcMcX/pL7S5EkPX66S60Sa51Mx/UHsEV54Wln1Pw28ShJR6DXI3QS
         KjuOtfnHmh6FQ7xYnd/7qeP0XhrXbA1CoRMWNB0HbMCkF3uf938GW8X+xwSPSgRhoko2
         7RBw==
X-Gm-Message-State: AOAM5322AJ3w9F3sn3V5yETUgJSpxrOGIq+9luyFqm6OjY41sDWJrqkI
        1rMSPeLYlsxF4hfmGgY+4ms=
X-Google-Smtp-Source: ABdhPJyP10IR9XEvNvaxdXCbbuP6cBLOlt/6ra1wKwndHOwZHpzIuU325rdV0pyhDg3hMTSZjTFxEQ==
X-Received: by 2002:a63:ec43:0:b0:382:11ef:b94a with SMTP id r3-20020a63ec43000000b0038211efb94amr34761353pgj.409.1649842623860;
        Wed, 13 Apr 2022 02:37:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm2391836pjy.35.2022.04.13.02.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:37:03 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Wed, 13 Apr 2022 09:36:56 +0000
Message-Id: <20220413093656.2538504-1-chi.minghao@zte.com.cn>
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
 drivers/spi/spi-mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 0e8dafc62d94..7d7091aa0c22 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -262,9 +262,8 @@ static int spi_mem_access_start(struct spi_mem *mem)
 	if (ctlr->auto_runtime_pm) {
 		int ret;
 
-		ret = pm_runtime_get_sync(ctlr->dev.parent);
+		ret = pm_runtime_resume_and_get(ctlr->dev.parent);
 		if (ret < 0) {
-			pm_runtime_put_noidle(ctlr->dev.parent);
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
 			return ret;
-- 
2.25.1


