Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56DC4DA97E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353560AbiCPFJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiCPFJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:09:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3680365D8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 22:08:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso3737547pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 22:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EW7VxVIhAVIvz2Mal/uBqtSahBJB+Cq+MnvTSwrQaIo=;
        b=D6XcqVyj8GGsMs37ehRYc+HeJN7yvl2QK/gEHSBqN1ZvbC3WVFHesqF5tQECJIzuQE
         JnXWj2nVRzSincmH3KsovPsJYXM0OTAZwnZ1m8vcFMyMXrExVWzf7oHc6JHBs2g1JMf5
         4nhaAGaMdE+pg3zfHp0Cptot8uGlQru55ve6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EW7VxVIhAVIvz2Mal/uBqtSahBJB+Cq+MnvTSwrQaIo=;
        b=sm4Cgn+BepSTWpmWc4YtG7kG85Aq6MiDCeswkmjet7eRzHqa4bwaPFQjmSGTk5Xe7W
         at5ByObLWfhbuvZ33B8IxjL2XVokv8ojEKVdlWrE3KVbVXPqjgHLANF70qI3IC7O/Uhi
         B5Kiti/+mI+9zG5QRY+0HD1N1z1eHJVouvs/ExJbJy9xVMydrriYB0vrUwPjWgzAgFi5
         QBK17FENsYJY10YRUppTZFjmc31MmDWR/5JU2RW74aO9Mp7ByqbYO8lG122mL5nOd8Gu
         ssuD6rgJ81DvGhbgasUhnhXO1iq9QGtelUKEQmQzQzC2UvSheLhms/ooOFw39ip39VtL
         N7Rw==
X-Gm-Message-State: AOAM531qSHMRXRPY/9sFksdx0/bNRurtfKTvRnf5gxsCeh90i/RC2kML
        i7qag5m0BsJM4VEtsb+TluT5DNPh8v73oA==
X-Google-Smtp-Source: ABdhPJz6AHG+E8sSh2/+XaimwQGJWW8QhdmvMKJnICGVZ2r6mCz6wGhhSUNZrNy7ClH1qZWeqowFog==
X-Received: by 2002:a17:90a:a018:b0:1c6:5dac:3da with SMTP id q24-20020a17090aa01800b001c65dac03damr688731pjp.195.1647407299654;
        Tue, 15 Mar 2022 22:08:19 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:3e4f:fba6:88d:becd])
        by smtp.gmail.com with UTF8SMTPSA id u8-20020a056a00098800b004f702473553sm995913pfg.6.2022.03.15.22.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 22:08:19 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH] iommu/vt-d: check alignment before using psi
Date:   Wed, 16 Mar 2022 14:07:11 +0900
Message-Id: <20220316050711.1855533-1-stevensd@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Fall back to domain selective flush if the target address is not aligned
to the mask being used for invalidation. This is necessary because page
selective invalidation masks out the lower order bits of the target
address based on the mask value, so if a non-aligned address is targeted
for psi, then mappings at the end of [pfn, pfn+pages) may not properly
be flushed from the iotlb.

This is not normally an issue because iova.c always allocates iovas that
are aligned to their size. However, iovas which come from other sources
(e.g. userspace via VFIO) may not be aligned.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5b196cfe9ed2..c122686e0a5c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1735,7 +1735,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		 * and the base address is naturally aligned to the size.
 		 */
 		if (!cap_pgsel_inv(iommu->cap) ||
-		    mask > cap_max_amask_val(iommu->cap))
+		    mask > cap_max_amask_val(iommu->cap) ||
+		    unlikely(((1 << mask) - 1) & pfn))
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 							DMA_TLB_DSI_FLUSH);
 		else
-- 
2.35.1.723.g4982287a31-goog

