Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412D0497707
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbiAXBy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:54:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:20501 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240745AbiAXByP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642989255; x=1674525255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6XGSnQ9TBlvVO/HCj7hdTuMI8xk5GqvKzVoFd47JxeM=;
  b=HpxAay3e1Sb6cpqa5PLUHH0itRrLmsJ6oZ/dZU39VtjkrSdqZle2JJQh
   gn2nU2VT2hUKGOKCFR/j4OpDi0jIYTWckRWJdUY2A1DD75Sddp5N4fsZh
   +a7w6XZcFfsuhhoUPYOh2YWs4lzxcMwRypkvZyKApQiVnPzQwCpmInxA8
   QcHLJKofSq30zEDTi9KbPyInJxb2yFvDjXodMFhSwaGHjjX1CZkJ4YKyO
   BxLXZ8ewDuODMVV0Zvm9FfGFwkky9ywwIQguAUgps1EUFXwa2UCMwD1rb
   mfi1MqdXFgo1YpxCbVS3vXliLNPnKJzrXEtHUkHrxB0SFRZ4bagc11+4h
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306658418"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306658418"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627320404"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:54:14 -0800
From:   ira.weiny@intel.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Ira Weiny <ira.weiny@intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH V2 5/7] drm/msm: Alter comment to use kmap_local_page()
Date:   Sun, 23 Jan 2022 17:54:07 -0800
Message-Id: <20220124015409.807587-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124015409.807587-1-ira.weiny@intel.com>
References: <20220124015409.807587-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap() is being deprecated.  So this comment could be misleading in the
future.

Change this comment to point to using kmap_local_page().  While here
remove 'we' from the comment.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 6cfa984dee6a..cc18d5d1fe5a 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -438,8 +438,8 @@ static int submit_reloc(struct msm_gem_submit *submit, struct msm_gem_object *ob
 		return -EINVAL;
 	}
 
-	/* For now, just map the entire thing.  Eventually we probably
-	 * to do it page-by-page, w/ kmap() if not vmap()d..
+	/* For now, just map the entire thing.  Eventually it should probably
+	 * be done page-by-page, w/ kmap_local_page() if not vmap()d..
 	 */
 	ptr = msm_gem_get_vaddr_locked(&obj->base);
 
-- 
2.31.1

