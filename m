Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9FC535075
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347618AbiEZOSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbiEZOR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:17:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E11C5D85;
        Thu, 26 May 2022 07:17:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n10so1867944pjh.5;
        Thu, 26 May 2022 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqp8p6dvroeiC54jkhE16BLbyPM4g2cKppPUEf1uy+E=;
        b=DZPOcRp/JiVYvEFcRQAH5tbraHLBq6VaSInl4Yt+QtNgDstXmDNvbJWln1DoENQ3wU
         8BKqmgVb+rYqa8buGVZi/QVRN1un03iTUNEQV89HTvwSpxJGh6sE9vIWhD6IKenKJRYM
         oePpRzxdk5wbu/9xdhQebXpcMDg0g4CIvsO5+E6MBJBxdxSlvZBND54oMq1bFIOkHLeJ
         EkdBPxJqcT/jF4Q1nNJ3T2ryhXjVXegm9eqM83LNCthgz5CxTTAMWsjpfO99mrRbTWBN
         stX+bbOp7X2dvTfK+MOYjrd8YSDkFiXO2TrD28VZIXeAUyir+6Y55zukfMYkFGI7Az33
         yDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqp8p6dvroeiC54jkhE16BLbyPM4g2cKppPUEf1uy+E=;
        b=ib6cwbL753GkCQ2ZDL4vJqlzz0aAIxiEaey3rQeUVur/ZckE5vcqb6n6hrnkfDFVwA
         GTrPA6rUTBx8yquibP57CrTaW1w+jj/5jA4bJXrA6dsJDP7yOYriyC1RcvLprITzshAl
         i0ysNQo4x8bwCmTYqYnz9F+AxGt+3WFqNqeXqOerExlfXMewMjowvp1ZHB5rVsZzm1pA
         WoK7riY7DwuggRLfMJcCW65muP9y3AGB/ZYorOFDBbGz3gapKrQF5meMs2GGdXhoRyy/
         tk5QvWrb0zYGvXphsbFzJHFuhgO6k+Ue2IN7lSKT24XZ6a0vTsSDzdkLD7fC++AaKo40
         wYVA==
X-Gm-Message-State: AOAM5312Rg/KybLEGZgpjXxVq0OaVHlDgo23f8EPqoubRolmVR09av9F
        SGGb8nKuX0vFf7IU8rk02E5oBJ/iAFq+ig==
X-Google-Smtp-Source: ABdhPJzXauDC5mHpQro6WPQ6VgZdWHenwZFmdbqW+481l/pRnvkghzR6UXlKA2kcSinaALSorbgICQ==
X-Received: by 2002:a17:903:20f:b0:158:d86a:f473 with SMTP id r15-20020a170903020f00b00158d86af473mr38357376plh.92.1653574676237;
        Thu, 26 May 2022 07:17:56 -0700 (PDT)
Received: from skynet-linux.local ([122.173.191.164])
        by smtp.googlemail.com with ESMTPSA id ei3-20020a17090ae54300b001dedb8bbe66sm1546622pjb.33.2022.05.26.07.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:17:55 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     bjorn.andersson@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] remoteproc: qcom: wcnss: Fix handling of IRQs
Date:   Thu, 26 May 2022 19:47:39 +0530
Message-Id: <20220526141740.15834-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220526141740.15834-1-sireeshkodali1@gmail.com>
References: <20220526141740.15834-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wcnss_get_irq function is expected to return a value > 0 in the
event that an IRQ is succssfully obtained, but it instead returns 0.
This causes the stop and ready IRQs to never actually be used despite
being defined in the device-tree. This patch fixes that.

Fixes: aed361adca9f ("remoteproc: qcom: Introduce WCNSS peripheral image loader")
Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/remoteproc/qcom_wcnss.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 9a223d394087..68f37296b151 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -467,6 +467,7 @@ static int wcnss_request_irq(struct qcom_wcnss *wcnss,
 			     irq_handler_t thread_fn)
 {
 	int ret;
+	int irq_number;
 
 	ret = platform_get_irq_byname(pdev, name);
 	if (ret < 0 && optional) {
@@ -477,14 +478,19 @@ static int wcnss_request_irq(struct qcom_wcnss *wcnss,
 		return ret;
 	}
 
+	irq_number = ret;
+
 	ret = devm_request_threaded_irq(&pdev->dev, ret,
 					NULL, thread_fn,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"wcnss", wcnss);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "request %s IRQ failed\n", name);
+		return ret;
+	}
 
-	return ret;
+	/* Return the IRQ number if the IRQ was successfully acquired */
+	return irq_number;
 }
 
 static int wcnss_alloc_memory_region(struct qcom_wcnss *wcnss)
-- 
2.36.1

