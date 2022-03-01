Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8F24C8ECE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiCAPTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiCAPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:19:34 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B682E0BF;
        Tue,  1 Mar 2022 07:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646147932; x=1677683932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=b9ZaCMYU7AMRZzESuVXMPojdYou2JKYQcNtOccNCo/s=;
  b=KUHcPUkFe85CRdMeLp86jqNL0NApEWM7Nsd1UBn1I59okJtICP+McHDc
   JtM5uso8MSqvDuF4vdqWNbzwtkjhXWIR/Z6TkxBM2P2/k60AchEx+BiAl
   k4xZdj7JMhTDDDDdDpOmeTXzjVhjXWgxyvcyGn79VUDhaansHCMi38j5z
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 01 Mar 2022 07:18:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:18:52 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 07:18:51 -0800
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 07:18:49 -0800
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH V5 2/2] soc: qcom: smem: validate fields of shared structures
Date:   Tue, 1 Mar 2022 20:48:33 +0530
Message-ID: <1646147913-15791-2-git-send-email-quic_deesin@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646147913-15791-1-git-send-email-quic_deesin@quicinc.com>
References: <1646147913-15791-1-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Structures in shared memory that can be modified by remote
processors may have untrusted values, they should be validated
before use.

Adding proper validation before using fields of shared
structures.

Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
---
 drivers/soc/qcom/smem.c | 79 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 2dde9b6..7733989 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -367,13 +367,18 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 	struct smem_partition_header *phdr;
 	size_t alloc_size;
 	void *cached;
+	void *p_end;
 
 	phdr = (struct smem_partition_header __force *)part->virt_base;
+	p_end = (void *)phdr + part->size;
 
 	hdr = phdr_to_first_uncached_entry(phdr);
 	end = phdr_to_last_uncached_entry(phdr);
 	cached = phdr_to_last_cached_entry(phdr);
 
+	if (WARN_ON((void *)end > p_end || cached > p_end))
+		return -EINVAL;
+
 	while (hdr < end) {
 		if (hdr->canary != SMEM_PRIVATE_CANARY)
 			goto bad_canary;
@@ -383,6 +388,9 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 		hdr = uncached_entry_next(hdr);
 	}
 
+	if (WARN_ON((void *)hdr > p_end))
+		return -EINVAL;
+
 	/* Check that we don't grow into the cached region */
 	alloc_size = sizeof(*hdr) + ALIGN(size, 8);
 	if ((void *)hdr + alloc_size > cached) {
@@ -501,6 +509,8 @@ static void *qcom_smem_get_global(struct qcom_smem *smem,
 	struct smem_header *header;
 	struct smem_region *region;
 	struct smem_global_entry *entry;
+	u64 entry_offset;
+	u32 e_size;
 	u32 aux_base;
 	unsigned i;
 
@@ -515,9 +525,16 @@ static void *qcom_smem_get_global(struct qcom_smem *smem,
 		region = &smem->regions[i];
 
 		if ((u32)region->aux_base == aux_base || !aux_base) {
+			e_size = le32_to_cpu(entry->size);
+			entry_offset = le32_to_cpu(entry->offset);
+
+			if (WARN_ON(e_size + entry_offset > region->size))
+				return ERR_PTR(-EINVAL);
+
 			if (size != NULL)
-				*size = le32_to_cpu(entry->size);
-			return region->virt_base + le32_to_cpu(entry->offset);
+				*size = e_size;
+
+			return region->virt_base + entry_offset;
 		}
 	}
 
@@ -531,8 +548,12 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
 {
 	struct smem_private_entry *e, *end;
 	struct smem_partition_header *phdr;
+	void *item_ptr, *p_end;
+	u32 padding_data;
+	u32 e_size;
 
 	phdr = (struct smem_partition_header __force *)part->virt_base;
+	p_end = (void *)phdr + part->size;
 
 	e = phdr_to_first_uncached_entry(phdr);
 	end = phdr_to_last_uncached_entry(phdr);
@@ -542,36 +563,65 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
 			goto invalid_canary;
 
 		if (le16_to_cpu(e->item) == item) {
-			if (size != NULL)
-				*size = le32_to_cpu(e->size) -
-					le16_to_cpu(e->padding_data);
+			if (size != NULL) {
+				e_size = le32_to_cpu(e->size);
+				padding_data = le16_to_cpu(e->padding_data);
+
+				if (WARN_ON(e_size > part->size || padding_data > e_size))
+					return ERR_PTR(-EINVAL);
+
+				*size = e_size - padding_data;
+			}
+
+			item_ptr = uncached_entry_to_item(e);
+			if (WARN_ON(item_ptr > p_end))
+				return ERR_PTR(-EINVAL);
 
-			return uncached_entry_to_item(e);
+			return item_ptr;
 		}
 
 		e = uncached_entry_next(e);
 	}
 
+	if (WARN_ON((void *)e > p_end))
+		return ERR_PTR(-EINVAL);
+
 	/* Item was not found in the uncached list, search the cached list */
 
 	e = phdr_to_first_cached_entry(phdr, part->cacheline);
 	end = phdr_to_last_cached_entry(phdr);
 
+	if (WARN_ON((void *)e < (void *)phdr || (void *)end > p_end))
+		return ERR_PTR(-EINVAL);
+
 	while (e > end) {
 		if (e->canary != SMEM_PRIVATE_CANARY)
 			goto invalid_canary;
 
 		if (le16_to_cpu(e->item) == item) {
-			if (size != NULL)
-				*size = le32_to_cpu(e->size) -
-					le16_to_cpu(e->padding_data);
+			if (size != NULL) {
+				e_size = le32_to_cpu(e->size);
+				padding_data = le16_to_cpu(e->padding_data);
+
+				if (WARN_ON(e_size > part->size || padding_data > e_size))
+					return ERR_PTR(-EINVAL);
+
+				*size = e_size - padding_data;
+			}
 
-			return cached_entry_to_item(e);
+			item_ptr = cached_entry_to_item(e);
+			if (WARN_ON(item_ptr < (void *)phdr))
+				return ERR_PTR(-EINVAL);
+
+			return item_ptr;
 		}
 
 		e = cached_entry_next(e, part->cacheline);
 	}
 
+	if (WARN_ON((void *)e < (void *)phdr))
+		return ERR_PTR(-EINVAL);
+
 	return ERR_PTR(-ENOENT);
 
 invalid_canary:
@@ -648,14 +698,23 @@ int qcom_smem_get_free_space(unsigned host)
 		phdr = part->virt_base;
 		ret = le32_to_cpu(phdr->offset_free_cached) -
 		      le32_to_cpu(phdr->offset_free_uncached);
+
+		if (ret > le32_to_cpu(part->size))
+			return -EINVAL;
 	} else if (__smem->global_partition.virt_base) {
 		part = &__smem->global_partition;
 		phdr = part->virt_base;
 		ret = le32_to_cpu(phdr->offset_free_cached) -
 		      le32_to_cpu(phdr->offset_free_uncached);
+
+		if (ret > le32_to_cpu(part->size))
+			return -EINVAL;
 	} else {
 		header = __smem->regions[0].virt_base;
 		ret = le32_to_cpu(header->available);
+
+		if (ret > __smem->regions[0].size)
+			return -EINVAL;
 	}
 
 	return ret;
-- 
2.7.4

