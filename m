Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B517520CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiEJEda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiEJEbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:31:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0BF252DE3;
        Mon,  9 May 2022 21:27:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e24so14865962pjt.2;
        Mon, 09 May 2022 21:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKRAV/0WhjqQKBeF/P7yZiZfvRuC4R3b8RZ22MxUCh8=;
        b=dd6XhIeMYjfLZ5mCHf715M4qM/S4/M0cK3wDD7BFdVTchSMvP3f0lCYniK+9ItFIY9
         nE4j84r05i8BcqghbyJhXIZl5CR6xGSQvKmTDBKg+VoiKnkQxrbZabTAvzbBUYcO6Ymo
         amLq2pe2MfE07Z290U8MN2ZWomVLM/ML65I7tpEM0dzFRrYYsn6ds9Nz99rITaa9HI2s
         8795/bWTrCKMDqrwhhvOX9Q0ZYpDEcNv56dljHcH2HvzZaviz3HfnYuw1cbZ1DbMsrC1
         oHmkaH8u13PJg37BwOzFxG5nucEpwoc+zulE/Dmut7INuFKL/LHZmadxSmmubuza8mkx
         Gt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKRAV/0WhjqQKBeF/P7yZiZfvRuC4R3b8RZ22MxUCh8=;
        b=AFUf61FVXOoKXmPf0z2e2flIm7dww9yiPayIa9Obm5N2xTjrDb4LfInEMljAIIut18
         uXzbMsFvb+0Vw/pzOGJJPFIfWQq2o5k/jcij8u0UKByM1vy6noyOyZL2e6XgWvEQHEsl
         +ff/1ZFJG+HXRhUB0OnS6p/aml2HgOF7EXyJOaUJVpYaZKssoYUCNkqSWTBoLyQoCjlA
         clY/CXtfNFPofA5liXQy8hXGeE1p6z1pgggSPibVEAWrIwvH0aqYGf0zZyCW/rRIQAO2
         ascyJIr0OHY1L4QyxvSm4LlFIgEYebXD8zMOSnLyojBwdYXKFDMoHYOAkO7RgRkt5z/+
         SYAA==
X-Gm-Message-State: AOAM533v9GIFEgBJLNJWWA7YWTwATi/756pLLXolYqbUuXn8g2ZMEBq0
        eb+5RRCMZxnUMtPwyymsdpdU+/jn3bzQgg==
X-Google-Smtp-Source: ABdhPJwP3+sbRFfYAYCxxMhQ/rcMcORClDoKk5ZbOJi8iEWE1FjcZb72ntagW0TDI+sNuJJTKN//9A==
X-Received: by 2002:a17:902:eb85:b0:15e:bf29:bd9f with SMTP id q5-20020a170902eb8500b0015ebf29bd9fmr18822020plg.135.1652156847342;
        Mon, 09 May 2022 21:27:27 -0700 (PDT)
Received: from skynet-linux.local ([2401:4900:33a2:808d:da42:4e61:10ad:478d])
        by smtp.googlemail.com with ESMTPSA id x4-20020a1709028ec400b0015e8d4eb2aesm741263plo.248.2022.05.09.21.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 21:27:26 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     bjorn.andersson@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] remoteproc: qcom: wcnss: Fix handling of IRQs
Date:   Tue, 10 May 2022 09:56:53 +0530
Message-Id: <20220510042654.71152-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510042654.71152-1-sireeshkodali1@gmail.com>
References: <20220510042654.71152-1-sireeshkodali1@gmail.com>
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
2.36.0

