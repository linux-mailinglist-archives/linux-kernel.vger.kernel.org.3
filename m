Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153324EE602
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbiDAC0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbiDAC0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:26:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E3792320
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:24:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p17so1240682plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LooVy6HxBljYsBOT5BZDR0fJDc4Rp8fN59jEgY+o0DI=;
        b=PJAxfuVD6PmKHxbahwunHYBhTlcgqbr8BH03aEQ7YdBeYh0l8U1M+pgy+mr9SEeoJX
         spL22iG8LTYMgQoBYGlE7JsmG25ZPJjbYzqJgTUYalOgziSNfj4aEBd0+3qR4DQedjLu
         ZRZPZr/+0ck7AP7BQvcFp4UV2cft/iM9QSGzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LooVy6HxBljYsBOT5BZDR0fJDc4Rp8fN59jEgY+o0DI=;
        b=o4V4am3/+kcZBQB/w2Bhy4lqQilXyiwuj6bkJFGY8RzIJT1y1H0eTPF2wTZ+CyC/oH
         AqSDYdlHFZx/flUzyIG3owB6SjD7UibSOl3iQHwFqIbbwYTXrmF8z1SB10/mSTmMYhCg
         2S2l+DmX8ifI+6X6yuausF2ENHN3i0MsOrhTxklzt4TsQfdbT3j/ASPx+qgI5nZRz5XD
         QnNihEKVKnfIUtfxn2mXx5/Kgrn6QoZB84K/5qE2VB8S6JozVoHRgy2xBWdShv6ARiSX
         uDZxgf29t0W2l9KWPhUbx46kuhuz/bB3/MU1HJFvW0hL3X+lfo/xosTexX+9NbILrDBy
         8SfQ==
X-Gm-Message-State: AOAM53166AAXBOupvnv8Y2Ho83Xty0hhU98YhL3xAXiGc9AFR5XCtWl5
        pLvu4UxodFjq7hn+8UZRve6zj4DL3JR0BQ==
X-Google-Smtp-Source: ABdhPJx3cds3IJYsBVyQKsdjyy6GrzZdmfUcleihi5PO6oQwuyC6RYYe7HrHRCWYE9lO/XrCkzT6Rw==
X-Received: by 2002:a17:903:110f:b0:154:c7a4:9371 with SMTP id n15-20020a170903110f00b00154c7a49371mr8265857plh.75.1648779880649;
        Thu, 31 Mar 2022 19:24:40 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:2248:fc58:91aa:767])
        by smtp.gmail.com with UTF8SMTPSA id b7-20020a056a00114700b004f7be3231d6sm815989pfm.7.2022.03.31.19.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 19:24:40 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>, stable@vger.kernel.org
Subject: [PATCH v3] iommu/vt-d: calculate mask for non-aligned flushes
Date:   Fri,  1 Apr 2022 11:24:30 +0900
Message-Id: <20220401022430.1262215-1-stevensd@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

To properly flush the IOTLB, both the start and end pfns need to be
equal after applying the mask. That means that the most efficient mask
to use is the index of the lowest bit that is equal where all higher
bits are also equal. For example, if pfn=0x17f and pages=3, then
end_pfn=0x181, so the smallest mask we can use is 8. Any differences
above the highest bit of pages are due to carrying, so by xnor'ing pfn
and end_pfn and then masking out the lower order bits based on pages, we
get 0xffffff00, where the first set bit is the mask we want to use.

Fixes: 6fe1010d6d9c ("vfio/type1: DMA unmap chunking")
Cc: stable@vger.kernel.org
Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
The seeds of the bug were introduced by f76aec76ec7f6, which
simultaniously added the alignement requirement to the iommu driver and
made the iova allocator return aligned iovas. However, I don't think
there was any way to trigger the bug at that time. The tagged VFIO
change is one that actually introduced a code path that could trigger
the bug. There may also be other ways to trigger the bug that I am not
aware of.

v1 -> v2:
 - Calculate an appropriate mask for non-size-aligned iovas instead
   of falling back to domain selective flush.
v2 -> v3:
 - Add more detail to commit message.

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
2.35.1.1094.g7c7d902a7c-goog

