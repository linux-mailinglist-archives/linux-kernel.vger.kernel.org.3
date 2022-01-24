Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1DB497709
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbiAXByd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:54:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:20509 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240748AbiAXByQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642989256; x=1674525256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BBygKGffoL5d5GTpz8jASmHam5hJkymlp1BmAKuyaH0=;
  b=PD4oMlRRxBya31CJ67nZZoXbbELU3HVJQjWbceQvGLHUaFyLNA5lHoLo
   tK4Hh9B7pCs4dGRaVVmN+i3QsbfN4F1rMe+bVqsJQDrxJcN8rLj5p2/X1
   4iYnPYLv/zhZXGFJ7fhf6OzpaSgvKGwe8A/t1MVt9l+fr3D+AtA3A6hMj
   tfFjpWpxWfAc9rc5100fSjdwnGX65fbB+dO3zTZ6dsbPnlJxbSCSw5b0Z
   coR9aE+6m8k0RVOPvJxHYOZnvZrLRAi+sOBhPR32k0XFAtoMuQ79TuABF
   W6kovrFCD39/5EKHxVbmiAXD+MrsdVR64pQuAmW/WQFj5DBx4hvKCX0U3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306658425"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306658425"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627320411"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:15 -0800
From:   ira.weiny@intel.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Ira Weiny <ira.weiny@intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH V2 7/7] drm/radeon: Ensure kunmap is called on error
Date:   Sun, 23 Jan 2022 17:54:09 -0800
Message-Id: <20220124015409.807587-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124015409.807587-1-ira.weiny@intel.com>
References: <20220124015409.807587-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The default case leaves the buffer object mapped in error.

Add radeon_bo_kunmap() to that case to ensure the mapping is cleaned up.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
NOTE: It seems like this function could use a fair bit of refactoring
but this is the easiest way to fix the actual bug.
---
 drivers/gpu/drm/radeon/radeon_uvd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index 377f9cdb5b53..7cca283f6202 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -560,6 +560,7 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 
 	default:
 
+		radeon_bo_kunmap(bo);
 		DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
 		return -EINVAL;
 	}
-- 
2.31.1

