Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E86949770B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbiAXByc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:54:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:20505 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240744AbiAXByO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642989254; x=1674525254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KXyxgwUM4bkXvDM+XyNRIjGv+8i1m09MysFfC7KN7A8=;
  b=Z5Pco8GtxyNqDKHUduC4Y5R1leAPoQimDF9hc5zhPoj+FVuA0vh1wmDh
   pZ+VoB9cvt5zLgNojaVNON8cnUhXY9liwJ8RvZzYHeUjDxHzKIV1gVd8H
   Bxgx43wjXXq22Vt1ReBrG/PxC844XN5EWBK+dJNs46gCLP4LBB8WV1AKT
   TjFX2etnIjedsIIoCYdzKAXVTMOcAwIMCSzFjziVpzHxsnDRrFXCQc7UK
   6y55KOKzsWN3D4Z8TvB0PnuuLfSJWqhnq6PI0qHF0Sj4/4x8xZ8y06XM9
   uLyjCXDfA2nyCPowq2Za0HrUuqrSCbHgS4c2vko9KHOHzL6UeXq2E7mpK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306658415"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306658415"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627320397"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:14 -0800
From:   ira.weiny@intel.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Ira Weiny <ira.weiny@intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH V2 4/7] drm/radeon: Replace kmap() with kmap_local_page()
Date:   Sun, 23 Jan 2022 17:54:06 -0800
Message-Id: <20220124015409.807587-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124015409.807587-1-ira.weiny@intel.com>
References: <20220124015409.807587-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap() is being deprecated and this usage is local to the thread.  Use
kmap_local_page() instead.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 11b21d605584..76d7906e1785 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -907,11 +907,11 @@ static ssize_t radeon_ttm_gtt_read(struct file *f, char __user *buf,
 
 		page = rdev->gart.pages[p];
 		if (page) {
-			ptr = kmap(page);
+			ptr = kmap_local_page(page);
 			ptr += off;
 
 			r = copy_to_user(buf, ptr, cur_size);
-			kunmap(rdev->gart.pages[p]);
+			kunmap_local(ptr);
 		} else
 			r = clear_user(buf, cur_size);
 
-- 
2.31.1

