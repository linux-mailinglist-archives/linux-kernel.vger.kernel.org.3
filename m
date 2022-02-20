Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941884BCF5E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244148AbiBTPQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbiBTPQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:13 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957034BAA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f3so22705519wrh.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKYmgngOL/OskIpQJEL8+lpXd5cce8putN6D5KkxR1I=;
        b=XmEOTetEPq+ebguMkv5DCUekep7Ry8fBV+KVFTEx0YqVaaE09HLIEkimDlqeRwcQ3K
         xIyt9M6DOVhFR4sb3XWJWvzkm75+w82tfavjCjbAFHW1kLBN7/Idy1YnacNC/jsZds1G
         5x2r5KF5ECu4cAOTyDtKLm9fstLjtEc4gUD2Yx1mcJhztjq1qmxz5WZK0X8o57cf0+Jd
         AaLsHn/FatiTnsETIArlKDc6e0i+zDsjZQBJ6GBVo4IUi33Dy24KfdIC6GPLN1IzBW9p
         qzDG0BUqv6xRzhm6rRUFr3/DvqFFc0ehjxlttw8eB6KoAYiniGGlw9JePLU/9eXGxegl
         5mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKYmgngOL/OskIpQJEL8+lpXd5cce8putN6D5KkxR1I=;
        b=2GEh2rCpBcN+XaKsGJtdvO6LzJYe4abysRlko8582m7RbVFuomG4fSp1IPoGvyWGmu
         Jy+raz362GV0OiI9wffdjiB3Zf6s3Hmm0QhH5LQvMs5sRLS4fr85CacRi0AZ1Lt/0gr+
         GriuqCguVXUgprbx3YRJvs6ANPfJmqkq9NGbccZ5dYlczWHKH519MsS2N9JhLpZkFmTV
         VuWKblX0HLUX/DRJPOZf57leUrz9AFrPf+uIfXwloJXkljZuGfL8f79Y3hEBXNRKw/Y9
         3RbJhrc6wbdtj5ljxwrTUqpFiVBv3CGZTxpZnsBCWfkBA/yyFfStLIDPODCQQunrwxwC
         kJnA==
X-Gm-Message-State: AOAM530CXEHZOBgAFdEDqVV10eLgwUZ3JwvVUUxEkpiTODPNKui8MVMY
        I+Q3ug5x0xU7b8n3p049m3SKlW8ozCPz2A==
X-Google-Smtp-Source: ABdhPJyApZq+MHcbJ0UlvMxzfuc+zyXoO8IQ2MemQaQYnY2bbCTg1zOX7dGEckQgfYvtdYf0hG/Dlw==
X-Received: by 2002:adf:e98d:0:b0:1e7:5ea6:7222 with SMTP id h13-20020adfe98d000000b001e75ea67222mr12537933wrm.579.1645370150766;
        Sun, 20 Feb 2022 07:15:50 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:50 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/13] nvmem: core: Use devm_add_action_or_reset()
Date:   Sun, 20 Feb 2022 15:15:16 +0000
Message-Id: <20220220151527.17216-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Slightly simplify the devm_nvmem_register() by using the
devm_add_action_or_reset().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 39cb659ea580..327c88c432f0 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -907,9 +907,9 @@ void nvmem_unregister(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_unregister);
 
-static void devm_nvmem_release(struct device *dev, void *res)
+static void devm_nvmem_unregister(void *nvmem)
 {
-	nvmem_unregister(*(struct nvmem_device **)res);
+	nvmem_unregister(nvmem);
 }
 
 /**
@@ -926,20 +926,16 @@ static void devm_nvmem_release(struct device *dev, void *res)
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *config)
 {
-	struct nvmem_device **ptr, *nvmem;
-
-	ptr = devres_alloc(devm_nvmem_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct nvmem_device *nvmem;
+	int ret;
 
 	nvmem = nvmem_register(config);
+	if (IS_ERR(nvmem))
+		return nvmem;
 
-	if (!IS_ERR(nvmem)) {
-		*ptr = nvmem;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	ret = devm_add_action_or_reset(dev, devm_nvmem_unregister, nvmem);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return nvmem;
 }
-- 
2.21.0

