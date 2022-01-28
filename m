Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A251A49F160
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbiA1Cyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345569AbiA1Cyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:54:49 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B5C061748
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:54:49 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id v10-20020a4a860a000000b002ddc59f8900so1145806ooh.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMvqDo4o/ZptH9wsrReKbkSFrVe904arvpn9YDSHQs8=;
        b=LTAcL3dphdPohty6dcW1pBBA6UgY+g81dyLs2HLenLgXJayqlKy7WO1COIUBzWXOtQ
         98oWM4bOqAysEorM08qNVUgIzGOI0Vlu94tmLKAoCZH3W4ZnQbwO4K3Jn+9yCbp1ivln
         tw0e9jCzJ0QhNtzndEvs1SD0avNEVG1I3jCqyFWHtvAW/xkLDONabluja3R3UuUTwisJ
         Dh73kigIxm3Vyg/7oIz2nwec1QWjLtvnMUh0I4p120Vmg4QFd7SKcBGqjFsE/lCYOgZy
         QeoO8WhvFxjag+MSJkwxreeNQ3gWife8g3nwTbb5lkPdqcioczloFXJehb7tjIPM1Klx
         pnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMvqDo4o/ZptH9wsrReKbkSFrVe904arvpn9YDSHQs8=;
        b=74eLN69Vi0mZHgHH9NRtyz7cX8BsejL/nBriir95pXmzwYcCw3gvzptjUu4dEh6tSx
         iwtdkfwZwoCMDTpPHfacO1Pq55UwvYKztx4PTqstyZQUF2iuHx8X2fSMugCJ5b0oeGBj
         lKmWEd7eo2D9kBMgOcevGpkKww9ROQzwZ9OyHLYKyLKUVD4Zj0Gao+A7eOInLQ+B+O4p
         LVC0b0jyjOxt1shwR3YGWD4UdE3IcSrWqkG8wDa+oiwKyyy60v2ZnnmlRdmIJmxPtvyV
         aYytHlkCxWDg85hc/u712eAhJ+3FI3cGrnGsss+Aq3UuQ2ifspoRRHEspmRtZYdaUp9y
         Y75Q==
X-Gm-Message-State: AOAM5303wIV77p3SIrqZpj/Enq7GHjW3UqZc1sfgNDBbyQzy2TKP0WyR
        1oVcbf8NGU4QjmkyXnBD6GwA+A==
X-Google-Smtp-Source: ABdhPJwflWrHDGkphNOlxMYMDPSlfL6ZbyV+qs8klHHcrp/Gvzy2bO2LC5KDEaY+nyrZkhEUyf/60g==
X-Received: by 2002:a05:6820:610:: with SMTP id e16mr3342746oow.69.1643338488823;
        Thu, 27 Jan 2022 18:54:48 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k6sm5677352oop.28.2022.01.27.18.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 18:54:48 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] firmware: qcom: scm: Introduce pas_metadata context
Date:   Thu, 27 Jan 2022 18:55:01 -0800
Message-Id: <20220128025513.97188-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128025513.97188-1-bjorn.andersson@linaro.org>
References: <20220128025513.97188-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with Qualcomm SM8450, some new security enhancements has been
done in the secure world, which results in the requirement to keep the
metadata segment accessible by the secure world from init_image() until
auth_and_reset().

Introduce a "PAS metadata context" object that can be passed to
init_image() for tracking the mapped memory and a related release
function for client drivers to release the mapping once either
auth_and_reset() has been invoked or in error handling paths on the way
there.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/firmware/qcom_scm.c   | 39 ++++++++++++++++++++++++++++++-----
 drivers/soc/qcom/mdt_loader.c |  2 +-
 include/linux/qcom_scm.h      | 10 ++++++++-
 3 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 7db8066b19fd..3218d13cbf83 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -435,10 +435,16 @@ static void qcom_scm_set_download_mode(bool enable)
  *		and optional blob of data used for authenticating the metadata
  *		and the rest of the firmware
  * @size:	size of the metadata
+ * @ctx:	optional metadata context
  *
- * Returns 0 on success.
+ * Return: 0 on success.
+ *
+ * Upon successful return, the PAS metadata context (@ctx) will be used to
+ * track the metadata allocation, this needs to be released by invoking
+ * qcom_scm_pas_metadata_release() by the caller.
  */
-int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size)
+int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
+			    struct qcom_scm_pas_metadata *ctx)
 {
 	dma_addr_t mdata_phys;
 	void *mdata_buf;
@@ -467,7 +473,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size)
 
 	ret = qcom_scm_clk_enable();
 	if (ret)
-		goto free_metadata;
+		goto out;
 
 	desc.args[1] = mdata_phys;
 
@@ -475,13 +481,36 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size)
 
 	qcom_scm_clk_disable();
 
-free_metadata:
-	dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
+out:
+	if (ret < 0 || !ctx) {
+		dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
+	} else if (ctx) {
+		ctx->ptr = mdata_buf;
+		ctx->phys = mdata_phys;
+		ctx->size = size;
+	}
 
 	return ret ? : res.result[0];
 }
 EXPORT_SYMBOL(qcom_scm_pas_init_image);
 
+/**
+ * qcom_scm_pas_metadata_release() - release metadata context
+ * @ctx:	metadata context
+ */
+void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
+{
+	if (!ctx->ptr)
+		return;
+
+	dma_free_coherent(__scm->dev, ctx->size, ctx->ptr, ctx->phys);
+
+	ctx->ptr = NULL;
+	ctx->phys = 0;
+	ctx->size = 0;
+}
+EXPORT_SYMBOL(qcom_scm_pas_metadata_release);
+
 /**
  * qcom_scm_pas_mem_setup() - Prepare the memory related to a given peripheral
  *			      for firmware loading
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 72fc2b539213..b00586db5391 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -171,7 +171,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 			goto out;
 		}
 
-		ret = qcom_scm_pas_init_image(pas_id, metadata, metadata_len);
+		ret = qcom_scm_pas_init_image(pas_id, metadata, metadata_len, NULL);
 
 		kfree(metadata);
 		if (ret) {
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 81cad9e1e412..4d8371410b05 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -68,8 +68,16 @@ extern int qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus);
 extern void qcom_scm_cpu_power_down(u32 flags);
 extern int qcom_scm_set_remote_state(u32 state, u32 id);
 
+struct qcom_scm_pas_metadata {
+	void *ptr;
+	dma_addr_t phys;
+	ssize_t size;
+};
+
 extern int qcom_scm_pas_init_image(u32 peripheral, const void *metadata,
-				   size_t size);
+				   size_t size,
+				   struct qcom_scm_pas_metadata *ctx);
+void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
 extern int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,
 				  phys_addr_t size);
 extern int qcom_scm_pas_auth_and_reset(u32 peripheral);
-- 
2.33.1

