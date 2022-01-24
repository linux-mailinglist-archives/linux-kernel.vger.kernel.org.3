Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD64497931
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbiAXHMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:12:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:53043 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241712AbiAXHMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643008372; x=1674544372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5TBZFsenuHwIPheekH0b3CEaehnEyJPuQXeOFXtZL/A=;
  b=gjezBRg7+MwXko5z8nOG9kd+YmHFfkYR5vRLaoVC4Dgdsot9+oUFpyEI
   STu0yQQuomLVSb4A6wlr6TIde7sQTp5BVuFNtB7AzwsbYu3GAjeu6DdCk
   U1fcXzcVaE88N4qhP/Ks+ZakkOgVKxeSPBmi6E+VSfa8nSFXSeKySQaxz
   +e1GE4BeGihpQAquFJryua7KpMGR/gv+sKA1otj5slrafzr1NjAwflV16
   aXYSe+JwloJffh6b9Z8VZM0ZY+mF7PdezDcGa6f2IpjWv8gXqWv62TojV
   jB6dcVsDQuAfAIqWJI5+iradhZrJZLlfvk437jmL41Yed90gGv1ZWeEL6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244814249"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244814249"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 23:12:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627387804"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga004.jf.intel.com with ESMTP; 23 Jan 2022 23:12:43 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/7] drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
Date:   Mon, 24 Jan 2022 15:11:00 +0800
Message-Id: <20220124071103.2097118-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supported page sizes of an iommu_domain are saved in the pgsize_bitmap
field. Retrieve the value from the right place.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20211218074546.1772553-1-baolu.lu@linux.intel.com
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index d0d52c1d4aee..992cc285f2fe 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -133,7 +133,7 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
 		 * or equal to the system's PAGE_SIZE, with a preference if
 		 * both are equal.
 		 */
-		pgsize_bitmap = tdev->iommu.domain->ops->pgsize_bitmap;
+		pgsize_bitmap = tdev->iommu.domain->pgsize_bitmap;
 		if (pgsize_bitmap & PAGE_SIZE) {
 			tdev->iommu.pgshift = PAGE_SHIFT;
 		} else {
-- 
2.25.1

