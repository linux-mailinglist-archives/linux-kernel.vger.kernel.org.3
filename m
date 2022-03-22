Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DD34E3916
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 07:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiCVGiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 02:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbiCVGiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 02:38:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79B513DF9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 23:36:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k6so7488640plg.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 23:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G6vvJq5zoMKlH4LeyY++zNuuhHapBdcqnf3yKUaAlL4=;
        b=EFWlNhWZpicfIkIQP2h4g+pbFMtlmTLoWAm+LXiEA0O4kM1lViKFAHnYxbXcPrcx5E
         SprX6bMQEVYLdXjPKX3ZO/bPWgoY5ZaNNnqWJJKPHnSxzklPbBxQT3Ofcaqv1gWy7TAQ
         Sv0o60MHo6ih6uoTTCZvQKZveKBweJ6+VPj6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G6vvJq5zoMKlH4LeyY++zNuuhHapBdcqnf3yKUaAlL4=;
        b=5uZiSZ1IRPqQ+LAlaeTnfw1JbxxPMkEnitTKPHujboLO3wzjXURp37WcSt97G7oNqo
         MhHwu4Xx7ao/+oM8qS2ydtC2j3utlElWGIw4A6UNGg01YcQSEZS+QOl7tfL9uSBXE3gP
         mRF1Gz7r03D6KxtnqY324GV5DSNhNMlL2Lw+wPTZXLmkTDMb1H5H8Yt69Qy0CHeB+1jG
         1W2BSZQBJSyQWLz3qNJ1kEe5Wa035I2AtqUXLPVsFFBTfxfDTNMXnhzNnCb6mEEgPjpA
         AQadxHwM90NDpfMd63zRPjL1qzxv2D0S+mypMpKD9JGEWkWZmQnpx0P5697GftKzsv5n
         QZtg==
X-Gm-Message-State: AOAM5333usPYX5FU7W0/AhPtrm3pWh8o2zOS3oM38NXpOz83GsT23a3r
        JPCKyl4kwmoz6EVe+6Rhx3aprQ==
X-Google-Smtp-Source: ABdhPJwYVDLjrioQC821Tnchg1fLRlY6qHPW4SoqkFywCCr1nD6wcEkSOGlMlHmEuN5luqRgjiFbtw==
X-Received: by 2002:a17:902:bcc2:b0:14f:23c6:c8c5 with SMTP id o2-20020a170902bcc200b0014f23c6c8c5mr16437126pls.131.1647930994318;
        Mon, 21 Mar 2022 23:36:34 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:e974:e434:a940:4f9f])
        by smtp.gmail.com with UTF8SMTPSA id gb5-20020a17090b060500b001c6d46f7e75sm1491413pjb.30.2022.03.21.23.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 23:36:33 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
Date:   Tue, 22 Mar 2022 15:35:55 +0900
Message-Id: <20220322063555.1422042-1-stevensd@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Calculate the appropriate mask for non-size-aligned page selective
invalidation. Since psi uses the mask value to mask out the lower order
bits of the target address, properly flushing the iotlb requires using a
mask value such that [pfn, pfn+pages) all lie within the flushed
size-aligned region.  This is not normally an issue because iova.c
always allocates iovas that are aligned to their size. However, iovas
which come from other sources (e.g. userspace via VFIO) may not be
aligned.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
v1 -> v2:
 - Calculate an appropriate mask for non-size-aligned iovas instead
   of falling back to domain selective flush.

 drivers/iommu/intel/iommu.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5b196cfe9ed2..ab2273300346 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1717,7 +1717,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  unsigned long pfn, unsigned int pages,
 				  int ih, int map)
 {
-	unsigned int mask = ilog2(__roundup_pow_of_two(pages));
+	unsigned int aligned_pages = __roundup_pow_of_two(pages);
+	unsigned int mask = ilog2(aligned_pages);
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain->iommu_did[iommu->seq_id];
 
@@ -1729,10 +1730,30 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	if (domain_use_first_level(domain)) {
 		domain_flush_piotlb(iommu, domain, addr, pages, ih);
 	} else {
+		unsigned long bitmask = aligned_pages - 1;
+
+		/*
+		 * PSI masks the low order bits of the base address. If the
+		 * address isn't aligned to the mask, then compute a mask value
+		 * needed to ensure the target range is flushed.
+		 */
+		if (unlikely(bitmask & pfn)) {
+			unsigned long end_pfn = pfn + pages - 1, shared_bits;
+
+			/*
+			 * Since end_pfn <= pfn + bitmask, the only way bits
+			 * higher than bitmask can differ in pfn and end_pfn is
+			 * by carrying. This means after masking out bitmask,
+			 * high bits starting with the first set bit in
+			 * shared_bits are all equal in both pfn and end_pfn.
+			 */
+			shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
+			mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
+		}
+
 		/*
 		 * Fallback to domain selective flush if no PSI support or
-		 * the size is too big. PSI requires page size to be 2 ^ x,
-		 * and the base address is naturally aligned to the size.
+		 * the size is too big.
 		 */
 		if (!cap_pgsel_inv(iommu->cap) ||
 		    mask > cap_max_amask_val(iommu->cap))
-- 
2.35.1.894.gb6a874cedc-goog

