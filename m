Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B74D5449
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbiCJWLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344259AbiCJWLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:11:08 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F83E144F4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:10:06 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id w27so11909569lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tK2DffIcTcbFc6YisuU/CAQwL4qcT6NxH18APJQxTOM=;
        b=6cuUYOWDZHQoQ6qpPp6RnzAvQBz6h92+KoZ33nIdPkqIvU2W3u6mLlvhvmWle6XFED
         kXAiC1L8EQiqKTXQ3Ho94WG9scxPyfupoBAWL+YUJnuL5tL7P9JphrpZafP4O3YsUath
         Vrc82QS6C8qTWn5v5SZgYPp8lGlK7QrNDqQMYk7JmsFeYzrqeEEK/09KNEGkr+Ezexw4
         Bony9rQnL03NYGjciFb/d4QY+mkq7MMTd9tWI3LTG+m42hLELjfivY3KLgbY5I0vbsUb
         qhHaxJNmgi4XUJermkRRSX4mhnScQW9lP6h/B1T93XlTWcHgRejZ0L5bRuA8K6Z3/m2a
         xSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tK2DffIcTcbFc6YisuU/CAQwL4qcT6NxH18APJQxTOM=;
        b=3VE5cP7ZWswk+No6XPO03l1v5/4s16uifcg0/7kfxkt/b64+ljDEH9eCa60UpcsGy3
         xhzBAykLXlXIJpHgtULnuMqQUpzbCE2RYIlVf4/IS9XJGGjJt2eQ0ir5T3lqMgJHPd1Q
         z3KU5L+BZdATU53wDKmOkzMXBMmTHcKIqrEY2mPfoyEOrTrNA5tp1rq6FyUhFNT2M9mW
         rFUauotlLP3DNeZvJNtEMBcEjqX65eWsbGnhH8aHRmve/OB6I9uFS2Bn4fXAIxZoVkoy
         IQhEol8Lf+XsWbHJFGrBDJwwBnxkWCPVUJEY67MbDPWWdrqs57eDT8sMNbu8GbzI1wHQ
         JADQ==
X-Gm-Message-State: AOAM531ImiB4Bm3Bd20nPsZ5vEjNE1QesXd0TGEj9TrfQHWqDaEcCZD5
        yeygkjh4o31pN86lGayh6C23hoyTZJvL/w==
X-Google-Smtp-Source: ABdhPJz2GDfFMCRDAfn/kgAPWUdUq7NUrA3/jXOsH3Chmz4MUG5XOWiU1VjW7Up0DEynwppO5C4wjw==
X-Received: by 2002:a05:6512:c03:b0:447:7912:7e6b with SMTP id z3-20020a0565120c0300b0044779127e6bmr4237365lfu.508.1646950204381;
        Thu, 10 Mar 2022 14:10:04 -0800 (PST)
Received: from dabros-l.roam.corp.google.com ([185.157.14.92])
        by smtp.gmail.com with ESMTPSA id c23-20020a196557000000b004481befdc8bsm1201593lfj.161.2022.03.10.14.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:09:55 -0800 (PST)
From:   Jan Dabros <jsd@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     wsa@kernel.org, upstream@semihalf.com, jsd@semihalf.com
Subject: [PATCH v2 -next] i2c: designware: Remove code duplication
Date:   Thu, 10 Mar 2022 23:09:32 +0100
Message-Id: <20220310220932.140973-1-jsd@semihalf.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code by moving common part to one function.

Signed-off-by: Jan Dabros <jsd@semihalf.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v1->v2:
* Add kudos for Andy who suggested this change
* Get rid of extra function and move common code to psp_send_i2c_req
* Update commit message and commit title
  (was "i2c:designware: Add helper to remove redundancy")
 drivers/i2c/busses/i2c-designware-amdpsp.c | 35 ++++++++++------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-amdpsp.c b/drivers/i2c/busses/i2c-designware-amdpsp.c
index c64e459afb5c..5c32255c3239 100644
--- a/drivers/i2c/busses/i2c-designware-amdpsp.c
+++ b/drivers/i2c/busses/i2c-designware-amdpsp.c
@@ -214,17 +214,28 @@ static int psp_send_i2c_req(enum psp_i2c_req_type i2c_req_type)
 				PSP_I2C_REQ_RETRY_DELAY_US,
 				PSP_I2C_REQ_RETRY_CNT * PSP_I2C_REQ_RETRY_DELAY_US,
 				0, req);
-	if (ret)
+	if (ret) {
+		dev_err(psp_i2c_dev, "Timed out waiting for PSP to %s I2C bus\n",
+			(i2c_req_type == PSP_I2C_REQ_ACQUIRE) ?
+			"release" : "acquire");
 		goto cleanup;
+	}
 
 	ret = status;
-	if (ret)
+	if (ret) {
+		dev_err(psp_i2c_dev, "PSP communication error\n");
 		goto cleanup;
+	}
 
 	dev_dbg(psp_i2c_dev, "Request accepted by PSP after %ums\n",
 		jiffies_to_msecs(jiffies - start));
 
 cleanup:
+	if (ret) {
+		dev_err(psp_i2c_dev, "Assume i2c bus is for exclusive host usage\n");
+		psp_i2c_mbox_fail = true;
+	}
+
 	kfree(req);
 	return ret;
 }
@@ -249,16 +260,8 @@ static int psp_acquire_i2c_bus(void)
 	};
 
 	status = psp_send_i2c_req(PSP_I2C_REQ_ACQUIRE);
-	if (status) {
-		if (status == -ETIMEDOUT)
-			dev_err(psp_i2c_dev, "Timed out waiting for PSP to release I2C bus\n");
-		else
-			dev_err(psp_i2c_dev, "PSP communication error\n");
-
-		dev_err(psp_i2c_dev, "Assume i2c bus is for exclusive host usage\n");
-		psp_i2c_mbox_fail = true;
+	if (status)
 		goto cleanup;
-	}
 
 	psp_i2c_sem_acquired = jiffies;
 	psp_i2c_access_count++;
@@ -294,16 +297,8 @@ static void psp_release_i2c_bus(void)
 
 	/* Send a release command to PSP */
 	status = psp_send_i2c_req(PSP_I2C_REQ_RELEASE);
-	if (status) {
-		if (status == -ETIMEDOUT)
-			dev_err(psp_i2c_dev, "Timed out waiting for PSP to acquire I2C bus\n");
-		else
-			dev_err(psp_i2c_dev, "PSP communication error\n");
-
-		dev_err(psp_i2c_dev, "Assume i2c bus is for exclusive host usage\n");
-		psp_i2c_mbox_fail = true;
+	if (status)
 		goto cleanup;
-	}
 
 	dev_dbg(psp_i2c_dev, "PSP semaphore held for %ums\n",
 		jiffies_to_msecs(jiffies - psp_i2c_sem_acquired));
-- 
2.31.0

