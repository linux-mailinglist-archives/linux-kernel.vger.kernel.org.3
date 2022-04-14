Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A325008F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbiDNI7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiDNI7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:59:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE0A673FA;
        Thu, 14 Apr 2022 01:56:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bg24so4530746pjb.1;
        Thu, 14 Apr 2022 01:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJj0UqeehCQsN4Xsljy1mLrJNDwRrnMwVoHxOrCmruk=;
        b=XAnSCPf45feayAiQJDcbbOZGPr0mczsE1EkeRIwDufqq9WNmmSL+PC4z/OB1sA55Og
         BstOunTuD1XzQ9WNDjtymkIfjab7utQO9ZqfaieqtpxERYy7eHZJGtllMkzcuDdzkAPq
         2HhvOLMlfFnmH7rHGeBB0BXxgNrESRnv+mCoSTPRdJmYAOGTtpgxameDcoOFsAmb3Z/Y
         ql6UMD86vSkooNh3ukOHfpAK9mGj+xNSllANOaXHI9t/vav+vNP3M9mbsWmzsiBk5g0n
         BbKjwJfGN/WIXyd8/mhwtbUqB3ycSLusVw8YKeKbbMPhhj5oVFcrUTt3Z5KLwcNTO8CY
         JZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJj0UqeehCQsN4Xsljy1mLrJNDwRrnMwVoHxOrCmruk=;
        b=270yLdHe9oz5UbNGNDp6MQp1xjF0B32QubFCHyx8mB8w3OjCp7GdZDH1bCCgKYSRh5
         0HKbdopQOZ6oXFW5HMGGlK76Qi9q3wWd0oaFzyQT8I0sQdJB46gAQX8+9WNfDQfhbkYq
         8Q2NXtgik3+PP7qdtdE2MmRvvcjXoKLq9Tepw9Db9RzplWkzvy8LU8S+xvry1wxpvROa
         7mP/yVk65ib+m7ecBrzHXltYMyNIETIuBRXh/nyu94cA+cM8oehnskbMIM4dgR6n8Ncq
         UE/XCUmU8RqkpICtUFyL4HsxR9O7FtiYNWAeZ7yJmSMAcoH2On1GpR/oIkplIR355Lav
         jyeQ==
X-Gm-Message-State: AOAM533+kefi/VqEvH4ECDUO1BHDxUcpNH3ZwUM4Mv5yMyAF9gQLiwbn
        xAK0nTmqZHRMzTZFJUO4Mt8=
X-Google-Smtp-Source: ABdhPJyU1GAJajitmjYE1zlcwQQKHg0fVH3VBwvjDNx5ASzWtGEu2JKZslqCcLzQGqSVtvdAwW8Bqg==
X-Received: by 2002:a17:90a:f00c:b0:1cb:8361:c78e with SMTP id bt12-20020a17090af00c00b001cb8361c78emr2566127pjb.133.1649926601047;
        Thu, 14 Apr 2022 01:56:41 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t14-20020a056a00138e00b004fb1d833668sm1550715pfg.33.2022.04.14.01.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:56:40 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Thu, 14 Apr 2022 08:56:37 +0000
Message-Id: <20220414085637.2541805-1-chi.minghao@zte.com.cn>
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
 drivers/spi/spi-cadence-quadspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b0c9f62ccefb..eda0646fb6a1 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1707,11 +1707,9 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		goto probe_master_put;
-	}
 
 	ret = clk_prepare_enable(cqspi->clk);
 	if (ret) {
-- 
2.25.1


