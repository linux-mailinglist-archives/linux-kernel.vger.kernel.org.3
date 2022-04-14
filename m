Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B925008EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbiDNI5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbiDNI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:57:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027B56C11;
        Thu, 14 Apr 2022 01:55:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t12so4112293pll.7;
        Thu, 14 Apr 2022 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mb698fUGO0bHbcwTfiE84awFA8BPhX0m9yxP0nIt750=;
        b=NC0r3aSoWy3PoGi1ZG9kftXD5tkIjXF6l9lWru/YShtHYY2huRB/93RXqaZAwLZ47K
         iVhaL5P61xW4Y36eM64iUTxdN0CYz0UFs9jt0wqZSZrfAv5E7jwjN1xy5Zs/V9ZR3fA5
         fUijOzGvenngLzSds/Cnh0XoTFPwlfvT+s0aeITOyaGv8rOoMnPjW7CQ3od+KdjCIJHo
         ZNuI5DN3etJpOymVLlOIihSR+JJQeHLjqXv8bYgCbgDlFRVo7vPQPSLeGMJiT1JlBChZ
         QeamM7icb+jUsL6HPJP1+Q3rVppy5N9pBFFiTTZfi5DvRNDq1IyFHapY/2zApgLz2qJ1
         S8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mb698fUGO0bHbcwTfiE84awFA8BPhX0m9yxP0nIt750=;
        b=IuBJ8PvSm3/ZQ+1rrVD3zZ53cA1gV2zjjpU1A4OWeGKN4sZzXBLMBceTLBDD7iZ3GM
         inkWpNlwLuC/x3BnZgF6X8034V8BChBYW4374+O0C82nm7dIG1RCDh3+pZGG1XFNfqc+
         IKQ+j1mBksC0+pFsPG3YpPfyGIWbXTvOdTalvh632SkLUTo/Z/0gRZmQaeaaKomE68Vn
         JfNqcJKAFyoqB/KgSGUZ3EaUEsMYYfNeVmAzB/GSnJ33AsUODfq4QD54QLLmcqhSUl8u
         noroI+3v7Ss6xgoe7CHDaJo64ysppuk9FUAJxhBHid4BztPqP5+52y4SiAdiz9AScnWi
         1RXg==
X-Gm-Message-State: AOAM532RqRoBnLvj0hhf9x0rQ7nIzJp5x9Cl/Raq68ndkw/42OwB/Jdw
        s4hYRAN0LEjKGQQP8HQhddLtqIpyrkg=
X-Google-Smtp-Source: ABdhPJzupmwyylba5UF/AGp13OyiCVCBPL6v+WM8w1NFkkE8n283xkvtxIT2aLEqeGPAI6/p7ZYlBA==
X-Received: by 2002:a17:902:6bc9:b0:158:b9d0:1e3b with SMTP id m9-20020a1709026bc900b00158b9d01e3bmr2151959plt.84.1649926510203;
        Thu, 14 Apr 2022 01:55:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a15-20020a62e20f000000b00508363eee44sm482568pfi.219.2022.04.14.01.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:55:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: spi-sprd: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Thu, 14 Apr 2022 08:55:06 +0000
Message-Id: <20220414085506.2541732-1-chi.minghao@zte.com.cn>
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
 drivers/spi/spi-sprd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 28e70db9bbba..65b8075da4eb 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -1008,9 +1008,8 @@ static int sprd_spi_remove(struct platform_device *pdev)
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
 	int ret;
 
-	ret = pm_runtime_get_sync(ss->dev);
+	ret = pm_runtime_resume_and_get(ss->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(ss->dev);
 		dev_err(ss->dev, "failed to resume SPI controller\n");
 		return ret;
 	}
-- 
2.25.1

