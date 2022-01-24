Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3CE497705
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiAXBy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:54:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:20509 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240747AbiAXByP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642989255; x=1674525255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8QsQEKSxoLGHydWZTS5T8WXMzBP5ZWfGvu6Ze1y391U=;
  b=HmjPJ0I7fUjK05LRt3yk8Fy/iRmUsSIS7UL3AtG6XI/dLSIGi6ojslZQ
   +jZBfDmV7ruuU+AvcZ/0oxCMTY6YAdeUROg3laUEBHcmzycaBH2Z3vI+n
   HMCt507oTKSbZIHcaLzES9rrFj7Vc0e7YUqCvBMvQIAUuG4FE9autOdGn
   M8J8xvZ0cL4iDAuv6SSw/2Xs201VOuLNLfoYa8AcDXlp9qa491oA4Sas3
   P3SShzo8FlHwwSyybOV0nLxXYt31kx1F1Naq4SqkM3kA9xtjuuikNB2Yg
   QEi7eM/1TlfoL+cveDEwXAWZMhJbP0WyhNe3+tO/FVBoPifJJxkgSqm5F
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306658422"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306658422"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627320407"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:15 -0800
From:   ira.weiny@intel.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Ira Weiny <ira.weiny@intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH V2 6/7] drm/amdgpu: Ensure kunmap is called on error
Date:   Sun, 23 Jan 2022 17:54:08 -0800
Message-Id: <20220124015409.807587-7-ira.weiny@intel.com>
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

Add amdgpu_bo_kunmap() to that case to ensure the mapping is cleaned up.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
NOTE: It seems like this function could use a fair bit of refactoring
but this is the easiest way to fix the actual bug.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 6f8de11a17f1..b3ffd0f6b35f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -889,6 +889,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 		return 0;
 
 	default:
+		amdgpu_bo_kunmap(bo);
 		DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
 	}
 
-- 
2.31.1

