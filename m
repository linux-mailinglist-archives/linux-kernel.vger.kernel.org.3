Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3324BCF4F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbiBTPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244057AbiBTPQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5382434BA8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n8so8119623wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTxil4tJAf7UWV/C+fdAyAmzi/s2rC1+JHkkEn5O+kc=;
        b=W6jE4/hlEtzS/97aFCDxz1egBSagCoiMlFBkAw2mMapYpV/64jueKf+g2IXT0dq0oU
         o+seqx2E98v25O3UpymfVb0sAgYFKD1QOcVW5fc6qRbIYDaN4W5y2u6bHr61bcBjF8Ow
         DyUvoFSnah5ig8CNQEkccmSA7p9e7Ks566Gv/+aeepskukN+FepVgVZwyOxnjvhftW46
         TfjSFqND32K6J8e/+emj4jqct/ZPJcDayv1zTyhC5Ay6V9HBphWnE6SNKHgGR2UHcBlU
         KUeTQp5VfD3H/Q+e+A+Bit+PvOJigv9+HeFz5/ZUpobFeq7fypqL9uhQlgQ9n77DqvyS
         UoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTxil4tJAf7UWV/C+fdAyAmzi/s2rC1+JHkkEn5O+kc=;
        b=5VXuEuz5vJioMkhVPUBX6fLu/4O6MNNnmRDfh7AZai2GSh1Y5q4Xk50/nJb3N/FSb4
         llA+Ikyk5BqHA3qKo4DNSeiqNGILKVHmyzCkwjBmk5qeFFZhyhb//Bxvsmo5+52CAUet
         ar4y9k/WUAZrZ37wulCrdkqFN2+WUj2uANQbgHXCj52eWd4LMJP4i36xtv20KY386Uqo
         e+atKp4Mbgzuq2k4B/OClRhMiCuWcOhrTi9FcdvJTgE/felofs4ILskoFE3c3MQV1SdW
         EYAXaIn/TRykVPlZbWr6h1iiMptd3Pu+ElbK4VxhfHJItNtekeFlopCxOIy7asyA+QCz
         tXGA==
X-Gm-Message-State: AOAM533A9QMpG27efFMSnYehQQI1xgjOta6O6YYZj7kF5FfJbpWglD/q
        MHLVVfuMZwXm0m/Tu6T921K0lA==
X-Google-Smtp-Source: ABdhPJxodz3Wa8AyRRUgIvZmgYEH8Ien0j7scKm5f9ldW92NAk//RZkYT9xo6oUiayXz8T6X7H/OjQ==
X-Received: by 2002:a05:600c:2f01:b0:37b:aa49:3864 with SMTP id r1-20020a05600c2f0100b0037baa493864mr14495015wmn.74.1645370149750;
        Sun, 20 Feb 2022 07:15:49 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:49 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/13] nvmem: core: Remove unused devm_nvmem_unregister()
Date:   Sun, 20 Feb 2022 15:15:15 +0000
Message-Id: <20220220151527.17216-2-srinivas.kandagatla@linaro.org>
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

There are no users and seems no will come of the devm_nvmem_unregister().
Remove the function and remove the unused devm_nvmem_match() along with it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 22 ----------------------
 include/linux/nvmem-provider.h |  8 --------
 2 files changed, 30 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9fd1602b539d..39cb659ea580 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -945,28 +945,6 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_nvmem_register);
 
-static int devm_nvmem_match(struct device *dev, void *res, void *data)
-{
-	struct nvmem_device **r = res;
-
-	return *r == data;
-}
-
-/**
- * devm_nvmem_unregister() - Unregister previously registered managed nvmem
- * device.
- *
- * @dev: Device that uses the nvmem device.
- * @nvmem: Pointer to previously registered nvmem device.
- *
- * Return: Will be negative on error or zero on success.
- */
-int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
-{
-	return devres_release(dev, devm_nvmem_release, devm_nvmem_match, nvmem);
-}
-EXPORT_SYMBOL(devm_nvmem_unregister);
-
 static struct nvmem_device *__nvmem_device_get(void *data,
 			int (*match)(struct device *dev, const void *data))
 {
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index c9a3ac9efeaa..50caa117cb62 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -135,8 +135,6 @@ void nvmem_unregister(struct nvmem_device *nvmem);
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *cfg);
 
-int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
-
 void nvmem_add_cell_table(struct nvmem_cell_table *table);
 void nvmem_del_cell_table(struct nvmem_cell_table *table);
 
@@ -155,12 +153,6 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 	return nvmem_register(c);
 }
 
-static inline int
-devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
 static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
 
-- 
2.21.0

