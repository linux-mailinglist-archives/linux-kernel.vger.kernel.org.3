Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54DC49F163
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345601AbiA1Cyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345578AbiA1Cyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:54:50 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D34C061748
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:54:50 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id e81so9808270oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcpZYrTZZbyun9fAq1Z6HAHR568TtSyO3q30sHVzyrg=;
        b=aYSSUv4UrsBBLlwEVb1eeQr+5jS54ssOzcW8avbJ5FO94VoNFTqfnrYEvomA4zBPrq
         100BfiCNYfaFRZ5cQl3LjONgOLbPzRBSJt1P4/FU5IbiEEw0/7KkfqKxatcUymT7Sl2k
         InsKwRHGmIJazeR5DDO854gM9otPSqWbD6kxWw4YZi8NCoKdtIeLQpi811LKRUpnPFZw
         5iceGaHP47f7IfSDz4zjd3zQAUVY7BtuIO/mdIIAZFWbKe8zsEncemfLdC/CUQm5X9Z2
         r5AWYdLc866bNtEMwh0q6dl4eqKEpDQG+fmsGtZJ5UXXfP0/s9MeC3vdUwCGIfZ6G1h7
         UvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcpZYrTZZbyun9fAq1Z6HAHR568TtSyO3q30sHVzyrg=;
        b=OR558dENGQgYKS8F25uGfdEGeEezZBYJFcAfVC6VpGMmCV/i0pp8NdrnCK6uosp37+
         a2ZRnEHjCkGLtiHPlrChlseutcr4Q6MLNQgmHanAUj9dyCa9jFvZmL0Fncxp4IIwZmk+
         u5N2RujG5PiOi7F71/VjBq6qe9UHRbZGAs39fr1CkMGd4rBV5bVSw+WwPXABDnEkRo1B
         l/jVw4i6WH+1JUTTIykpM6MtPS/Mrj2N+3WKtSYKdI6VG/7NrX2I33FVyQgsJItSe2S5
         A/tZM/EHOJwdat28bnV+j957y7yvtK65gsBkNAAzlVhR9OvRsRPL8cYc+Kfm8cXM4bt6
         BTfw==
X-Gm-Message-State: AOAM532zhxX7/jVSV+lX/KhBolm93FAcCpdd1h3IdaTWeg/1/FsrqR1Z
        ACWz51ooWFMTaLRRmSUON39JRw==
X-Google-Smtp-Source: ABdhPJxXwAaYsLOeIwMHxNTMOEbWkKRk+eRrG+gSkgetkIek43FJ1geKBCagLXAC030j4XbR5JzpZg==
X-Received: by 2002:a05:6808:14c9:: with SMTP id f9mr2977531oiw.251.1643338489702;
        Thu, 27 Jan 2022 18:54:49 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k6sm5677352oop.28.2022.01.27.18.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 18:54:49 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] soc: qcom: mdt_loader: Split out split-file-loader
Date:   Thu, 27 Jan 2022 18:55:02 -0800
Message-Id: <20220128025513.97188-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128025513.97188-1-bjorn.andersson@linaro.org>
References: <20220128025513.97188-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted in a SM8450 device, the hash metadata segment is split out in a
separate .bNN file which means that the logic for loading split out
segmenents needs to be duplicated in qcom_mdt_read_metadata().

Split out the existing logic to a helper function that can be used in
both code paths.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/mdt_loader.c | 72 ++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index b00586db5391..c9e5bdfac371 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -31,6 +31,44 @@ static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
 	return true;
 }
 
+static ssize_t mdt_load_split_segment(void *ptr, const struct elf32_phdr *phdrs,
+				      unsigned int segment, const char *fw_name,
+				      struct device *dev)
+{
+	const struct elf32_phdr *phdr = &phdrs[segment];
+	const struct firmware *seg_fw;
+	char *seg_name;
+	ssize_t ret;
+
+	if (strlen(fw_name) < 4)
+		return -EINVAL;
+
+	seg_name = kstrdup(fw_name, GFP_KERNEL);
+	if (!seg_name)
+		return -ENOMEM;
+
+	sprintf(seg_name + strlen(fw_name) - 3, "b%02d", segment);
+	ret = request_firmware_into_buf(&seg_fw, seg_name, dev,
+					ptr, phdr->p_filesz);
+	if (ret) {
+		dev_err(dev, "error %zd loading %s\n", ret, seg_name);
+		kfree(seg_name);
+		return ret;
+	}
+
+	if (seg_fw->size != phdr->p_filesz) {
+		dev_err(dev,
+			"failed to load segment %d from truncated file %s\n",
+			segment, seg_name);
+		ret = -EINVAL;
+	}
+
+	release_firmware(seg_fw);
+	kfree(seg_name);
+
+	return ret;
+}
+
 /**
  * qcom_mdt_get_size() - acquire size of the memory region needed to load mdt
  * @fw:		firmware object for the mdt file
@@ -127,22 +165,19 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len)
 EXPORT_SYMBOL_GPL(qcom_mdt_read_metadata);
 
 static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
-			   const char *firmware, int pas_id, void *mem_region,
+			   const char *fw_name, int pas_id, void *mem_region,
 			   phys_addr_t mem_phys, size_t mem_size,
 			   phys_addr_t *reloc_base, bool pas_init)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_phdr *phdr;
 	const struct elf32_hdr *ehdr;
-	const struct firmware *seg_fw;
 	phys_addr_t mem_reloc;
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	phys_addr_t max_addr = 0;
 	size_t metadata_len;
-	size_t fw_name_len;
 	ssize_t offset;
 	void *metadata;
-	char *fw_name;
 	bool relocate = false;
 	void *ptr;
 	int ret = 0;
@@ -154,14 +189,6 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
-	fw_name_len = strlen(firmware);
-	if (fw_name_len <= 4)
-		return -EINVAL;
-
-	fw_name = kstrdup(firmware, GFP_KERNEL);
-	if (!fw_name)
-		return -ENOMEM;
-
 	if (pas_init) {
 		metadata = qcom_mdt_read_metadata(fw, &metadata_len);
 		if (IS_ERR(metadata)) {
@@ -258,25 +285,9 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 			memcpy(ptr, fw->data + phdr->p_offset, phdr->p_filesz);
 		} else if (phdr->p_filesz) {
 			/* Firmware not large enough, load split-out segments */
-			sprintf(fw_name + fw_name_len - 3, "b%02d", i);
-			ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
-							ptr, phdr->p_filesz);
-			if (ret) {
-				dev_err(dev, "error %d loading %s\n",
-					ret, fw_name);
+			ret = mdt_load_split_segment(ptr, phdrs, i, fw_name, dev);
+			if (ret)
 				break;
-			}
-
-			if (seg_fw->size != phdr->p_filesz) {
-				dev_err(dev,
-					"failed to load segment %d from truncated file %s\n",
-					i, fw_name);
-				release_firmware(seg_fw);
-				ret = -EINVAL;
-				break;
-			}
-
-			release_firmware(seg_fw);
 		}
 
 		if (phdr->p_memsz > phdr->p_filesz)
@@ -287,7 +298,6 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		*reloc_base = mem_reloc;
 
 out:
-	kfree(fw_name);
 
 	return ret;
 }
-- 
2.33.1

