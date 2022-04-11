Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E1E4FBEDF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346977AbiDKOTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347373AbiDKORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E313D2A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=M0aJmcvaHNk4LpPmqAEEtWAyy41LjIkdy7oI6Fnqk2k=; b=UEgr8k6CDxVVDFlZfsdPUi94z5
        uatExKYeyLMXOHnUbHxu/UckxQ4559pqxgYeXCFI7OMDnIPiSfOJnBc2aWeEct9MwgyvB7D7pUKCX
        6F5pzTPf/cF8k2YUxdxdMXFc56ZgENSv2rjB9oLZOP+MzQBWGfZhgbBl2bWQHdwkwBQ2gLDxDAbhc
        ax8koAk3m9o2Rgw0jdxqcAIklWZGHf7z+IVF22MNnJoJAlo29dVn4H6yGxhRIoFsysbmppG6Z8BqE
        5dTCwBuqw4yww0/FaqSfcaM1uXEaT07RB0GuemsFHRfNkSWFaF8ZjJCruA/h1o7B8YSm1KhjqWgoG
        0EW7ZfZg==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndup8-009Ksx-W5; Mon, 11 Apr 2022 14:15:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/34] drm/i915/gvt: streamline intel_vgpu_create
Date:   Mon, 11 Apr 2022 16:13:54 +0200
Message-Id: <20220411141403.86980-26-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411141403.86980-1-hch@lst.de>
References: <20220411141403.86980-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize variables at declaration time, avoid pointless gotos and
cater for the fact that intel_gvt_create_vgpu can't return NULL.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index f908867223aec..11bce3a91a225 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -720,26 +720,19 @@ int intel_gvt_set_edid(struct intel_vgpu *vgpu, int port_num)
 
 static int intel_vgpu_create(struct mdev_device *mdev)
 {
-	struct intel_vgpu *vgpu = NULL;
+	struct device *pdev = mdev_parent_dev(mdev);
+	struct intel_gvt *gvt = kdev_to_i915(pdev)->gvt;
 	struct intel_vgpu_type *type;
-	struct device *pdev;
-	struct intel_gvt *gvt;
-	int ret;
-
-	pdev = mdev_parent_dev(mdev);
-	gvt = kdev_to_i915(pdev)->gvt;
+	struct intel_vgpu *vgpu;
 
 	type = &gvt->types[mdev_get_type_group_id(mdev)];
-	if (!type) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!type)
+		return -EINVAL;
 
 	vgpu = intel_gvt_create_vgpu(gvt, type);
-	if (IS_ERR_OR_NULL(vgpu)) {
-		ret = vgpu == NULL ? -EFAULT : PTR_ERR(vgpu);
-		gvt_err("failed to create intel vgpu: %d\n", ret);
-		goto out;
+	if (IS_ERR(vgpu)) {
+		gvt_err("failed to create intel vgpu: %ld\n", PTR_ERR(vgpu));
+		return PTR_ERR(vgpu);
 	}
 
 	INIT_WORK(&vgpu->release_work, intel_vgpu_release_work);
@@ -749,10 +742,7 @@ static int intel_vgpu_create(struct mdev_device *mdev)
 
 	gvt_dbg_core("intel_vgpu_create succeeded for mdev: %s\n",
 		     dev_name(mdev_dev(mdev)));
-	ret = 0;
-
-out:
-	return ret;
+	return 0;
 }
 
 static int intel_vgpu_remove(struct mdev_device *mdev)
-- 
2.30.2

