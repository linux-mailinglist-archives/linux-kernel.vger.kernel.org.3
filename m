Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFEB49F164
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345611AbiA1Cyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345586AbiA1Cyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:54:51 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE9C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:54:51 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s9so9754425oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vOanCSySDZmTUn1LqqVwq/prLxQXPGe2dFE2HwY+tRc=;
        b=Bq+ONCJneuMbBHf9kxpPG8WmOD0Eb1dgbQOsFxyeZVMHyHoT+uYByqwCu0VdaMoiR0
         qMlL9UJ6lBs6YeNlQFj59L9cyvI826WQHIslfarIm7TSropMPQL5GN2vLkXpk4v7HS6X
         zqdJ1pCMJvgTkG7zFFfH6LEW0X+mbA+FB22pxTH7mtd0rRwsRyAtHoOfcnKMjwt5gHuN
         nXtY3uGJFRM1iowAUg4mOIKY+YX/XxQbUwZ2qn+q0bLAeMbkQcL0o72vlUd8jtjoVlxT
         PYEtMr7SkvHGF/2vtsyY0qXHml4TfeGhniBVngKFWon2pDM/P5TmSBjOZf1Lndklsr1M
         2y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vOanCSySDZmTUn1LqqVwq/prLxQXPGe2dFE2HwY+tRc=;
        b=0Yy5NuVDAJU11piW5AnPwBSxcORl712v26jM1QifUMdHlJLsY3zAL+KcgdQpG0Gx1x
         lEwpfSLJBFuHvyLIZrZwQjll96yHNI8Ti4Ey3dCc2wSgS9bWb8c/ef8YCJz4F4NiOW9b
         6IwLOBwic2liFQRErsT6JI1VUM/bJyHtTeS8a9fkVqHi5aP+s01RdsXI1fUXyKFedyOy
         l9EJIc43GyvMr+wkALbnd2Z4cfC8DrD+EIFeNPuCAAaVFsfIrEuyWy9kVcXmUP5tZ8f1
         EV/WOms4u3bUTlPMtI7yIfhlOW2MwBoEIBtg3fcuKEEo7iptYmLa8w9nV8Y/xfwOcxXY
         lTbg==
X-Gm-Message-State: AOAM530Kh8Qgtapa+W/RfXp4rtBicM9WyK+f2uJEjk2SpYLeaBENmhTs
        rBcIOZZzjEiivBabh5LgmF5BtQ==
X-Google-Smtp-Source: ABdhPJwQw+JC6FRgLIV2UEMFwTOJiyKWKfSvMfln22ofFJ5qYzvyNpIpNppTEJbt0Fu5RqnXuVgk7g==
X-Received: by 2002:a05:6808:201d:: with SMTP id q29mr9195342oiw.247.1643338490629;
        Thu, 27 Jan 2022 18:54:50 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k6sm5677352oop.28.2022.01.27.18.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 18:54:50 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] soc: qcom: mdt_loader: Allow hash segment to be split out
Date:   Thu, 27 Jan 2022 18:55:03 -0800
Message-Id: <20220128025513.97188-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128025513.97188-1-bjorn.andersson@linaro.org>
References: <20220128025513.97188-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been observed that some firmware found in a Qualcomm SM8450 device
has the hash table in a separate .bNN file. Use the newly extracted
helper function to load this segment from the separate file, if it's
determined that the hashes are not part of the already loaded firmware.

In order to do this, the function needs access to the firmware basename
and to provide more useful error messages a struct device to associate
the errors with.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c  |  7 ++++---
 drivers/soc/qcom/mdt_loader.c       | 29 +++++++++++++++++++++--------
 include/linux/soc/qcom/mdt_loader.h |  6 ++++--
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 43ea8455546c..a2c231a17b2b 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -928,7 +928,8 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
 	regmap_write(halt_map, offset + AXI_HALTREQ_REG, 0);
 }
 
-static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw)
+static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
+				const char *fw_name)
 {
 	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS;
 	dma_addr_t phys;
@@ -939,7 +940,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw)
 	void *ptr;
 	int ret;
 
-	metadata = qcom_mdt_read_metadata(fw, &size);
+	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
 	if (IS_ERR(metadata))
 		return PTR_ERR(metadata);
 
@@ -1289,7 +1290,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	/* Initialize the RMB validator */
 	writel(0, qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
 
-	ret = q6v5_mpss_init_image(qproc, fw);
+	ret = q6v5_mpss_init_image(qproc, fw, qproc->hexagon_mdt_image);
 	if (ret)
 		goto release_firmware;
 
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index c9e5bdfac371..4372d8e38b29 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -121,13 +121,15 @@ EXPORT_SYMBOL_GPL(qcom_mdt_get_size);
  *
  * Return: pointer to data, or ERR_PTR()
  */
-void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len)
+void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
+			     const char *fw_name, struct device *dev)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_hdr *ehdr;
 	size_t hash_offset;
 	size_t hash_size;
 	size_t ehdr_size;
+	ssize_t ret;
 	void *data;
 
 	ehdr = (struct elf32_hdr *)fw->data;
@@ -149,14 +151,25 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len)
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	/* Is the header and hash already packed */
-	if (ehdr_size + hash_size == fw->size)
+	/* Copy ELF header */
+	memcpy(data, fw->data, ehdr_size);
+
+	if (ehdr_size + hash_size == fw->size) {
+		/* Firmware is split and hash is packed following the ELF header */
 		hash_offset = phdrs[0].p_filesz;
-	else
+		memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
+	} else if (phdrs[1].p_offset + hash_size <= fw->size) {
+		/* Hash is in its own segment, but within the loaded file */
 		hash_offset = phdrs[1].p_offset;
-
-	memcpy(data, fw->data, ehdr_size);
-	memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
+		memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
+	} else {
+		/* Hash is in its own segment, beyond the loaded file */
+		ret = mdt_load_split_segment(data + ehdr_size, phdrs, 1, fw_name, dev);
+		if (ret) {
+			kfree(data);
+			return ERR_PTR(ret);
+		}
+	}
 
 	*data_len = ehdr_size + hash_size;
 
@@ -190,7 +203,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
 	if (pas_init) {
-		metadata = qcom_mdt_read_metadata(fw, &metadata_len);
+		metadata = qcom_mdt_read_metadata(fw, &metadata_len, fw_name, dev);
 		if (IS_ERR(metadata)) {
 			ret = PTR_ERR(metadata);
 			dev_err(dev, "error %d reading firmware %s metadata\n",
diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
index afd47217996b..46bdb7bace9a 100644
--- a/include/linux/soc/qcom/mdt_loader.h
+++ b/include/linux/soc/qcom/mdt_loader.h
@@ -23,7 +23,8 @@ int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
 			  const char *fw_name, int pas_id, void *mem_region,
 			  phys_addr_t mem_phys, size_t mem_size,
 			  phys_addr_t *reloc_base);
-void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len);
+void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
+			     const char *fw_name, struct device *dev);
 
 #else /* !IS_ENABLED(CONFIG_QCOM_MDT_LOADER) */
 
@@ -51,7 +52,8 @@ static inline int qcom_mdt_load_no_init(struct device *dev,
 }
 
 static inline void *qcom_mdt_read_metadata(const struct firmware *fw,
-					   size_t *data_len)
+					   size_t *data_len, const char *fw_name,
+					   struct device *dev)
 {
 	return ERR_PTR(-ENODEV);
 }
-- 
2.33.1

