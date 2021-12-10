Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C920470EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbhLJX2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:28:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:19154 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345102AbhLJX1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639178652; x=1670714652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XiALd5f06n3blk5zwMdSEUYN4OgzR63VH6agsJ1iuzU=;
  b=beVT9UZR74keTL0gB5y/O2Upw4g/bUDwQ4CZo/OmqiXA8dektPanqxvL
   LnZTVDDxlFCPbNmzoaoPvc44/5ncRFMzh1QSMfNGUKhod8nAPTx1yCZlK
   lvmrO6rg3WQoCKP56tcxDvPBeyNwQANAEsXOLsjrI/zl/oGl6QrUqXmFU
   qawU25k3DZoFpWC4g3g7FKVH3nhV3JQAOVeAALExr74MfmCeGEsSCIOrF
   MYYOncOTFvdVycJzusY2dRCpcMlbrunDfQXR6kvGHBrGssi8tFaFveFt7
   nNyVS3ztC52uCDoPBSxhAH9CwG1F0TYCVnOet9oqMpJtJCDUtZvsosxcD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="237212377"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="237212377"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:24:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="463861465"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:24:11 -0800
From:   ira.weiny@intel.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Ira Weiny <ira.weiny@intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 5/7] drm/msm: Alter comment to use kmap_local_page()
Date:   Fri, 10 Dec 2021 15:24:02 -0800
Message-Id: <20211210232404.4098157-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211210232404.4098157-1-ira.weiny@intel.com>
References: <20211210232404.4098157-1-ira.weiny@intel.com>
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
index 282628d6b72c..654ae0d13eaf 100644
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

