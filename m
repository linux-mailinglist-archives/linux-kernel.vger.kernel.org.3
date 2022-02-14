Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C624B53A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355299AbiBNOqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:46:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355293AbiBNOqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:46:44 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C454B49258;
        Mon, 14 Feb 2022 06:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644849997; x=1676385997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+l53Hua9fkEIFmmqEjw4dcEf35mZ4hjl1Qu/diz2400=;
  b=MqO8S8gVuzOAGHc5igzU1rnCbaQUfF6Cw7iCiWlx5gVHHmg0flZ4IwR+
   rpJjWfut61Z6JlvFuhdPYouDWmBp0QeAplGM5Vv7kiLfsr3bO9K61yvMb
   vCwdXtOmTkZIU0y7wlWjkxYlp/ldNzMefvzlhshkFcFkywiLrh47KJnr5
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 14 Feb 2022 06:46:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 06:46:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 06:46:35 -0800
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 14 Feb 2022 06:46:32 -0800
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH V4 2/2] soc: qcom: smem: validate fields of shared structures
Date:   Mon, 14 Feb 2022 20:16:14 +0530
Message-ID: <1644849974-8043-2-git-send-email-quic_deesin@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644849974-8043-1-git-send-email-quic_deesin@quicinc.com>
References: <1644849974-8043-1-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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
 drivers/soc/qcom/smem.c | 81 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 96444ff..644844b 100644
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
 
+	if (WARN_ON((void *)end > p_end || (void *)cached > p_end))
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
 
@@ -515,9 +525,13 @@ static void *qcom_smem_get_global(struct qcom_smem *smem,
 		region = &smem->regions[i];
 
 		if ((u32)region->aux_base == aux_base || !aux_base) {
+			e_size = le32_to_cpu(entry->size);
+			entry_offset = le32_to_cpu(entry->offset);
+
 			if (size != NULL)
-				*size = le32_to_cpu(entry->size);
-			return region->virt_base + le32_to_cpu(entry->offset);
+				*size = e_size;
+
+			return region->virt_base + entry_offset;
 		}
 	}
 
@@ -531,8 +545,12 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
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
@@ -542,36 +560,65 @@ static void *qcom_smem_get_private(struct qcom_smem *smem,
 			goto invalid_canary;
 
 		if (le16_to_cpu(e->item) == item) {
-			if (size != NULL)
-				*size = le32_to_cpu(e->size) -
-					le16_to_cpu(e->padding_data);
+			if (size != NULL) {
+				e_size = le32_to_cpu(e->size);
+				padding_data = le16_to_cpu(e->padding_data);
 
-			return uncached_entry_to_item(e);
+				if (WARN_ON(e_size > part->size || padding_data > e_size))
+					return ERR_PTR(-EINVAL);
+
+				*size = e_size - padding_data;
+			}
+
+			item_ptr = uncached_entry_to_item(e);
+			if (WARN_ON(item_ptr > p_end))
+				return ERR_PTR(-EINVAL);
+
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
+
+			item_ptr = cached_entry_to_item(e);
+			if (WARN_ON(item_ptr < (void *)phdr))
+				return ERR_PTR(-EINVAL);
 
-			return cached_entry_to_item(e);
+			return item_ptr;
 		}
 
 		e = cached_entry_next(e, part->cacheline);
 	}
 
+	if (WARN_ON((void *)e < (void *)phdr))
+		return ERR_PTR(-EINVAL);
+
 	return ERR_PTR(-ENOENT);
 
 invalid_canary:
@@ -648,14 +695,23 @@ int qcom_smem_get_free_space(unsigned host)
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
@@ -918,13 +974,12 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
 static int qcom_smem_map_toc(struct qcom_smem *smem, struct smem_region *region)
 {
 	u32 ptable_start;
-	int ret;
 
 	/* map starting 4K for smem header */
-	region->virt_base = devm_ioremap_wc(dev, region->aux_base, SZ_4K);
+	region->virt_base = devm_ioremap_wc(smem->dev, region->aux_base, SZ_4K);
 	ptable_start = region->aux_base + region->size - SZ_4K;
 	/* map last 4k for toc */
-	smem->ptable = devm_ioremap_wc(dev, ptable_start, SZ_4K);
+	smem->ptable = devm_ioremap_wc(smem->dev, ptable_start, SZ_4K);
 
 	if (!region->virt_base || !smem->ptable)
 		return -ENOMEM;
-- 
2.7.4

