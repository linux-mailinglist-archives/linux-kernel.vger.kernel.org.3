Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D5D4DE1F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbiCRTwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiCRTv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:51:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0382D2E8435
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:50:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 9A2AE1F45B08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647633030;
        bh=9bigV/sYB4FUqshAYJdxs+cHARVqE00dOiOAg3Egs9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=gDqPOrSjJ86k3/PKnd8PPM1RMLwNcZ91aYkmOXXsSFBIn8gTvQ/FZXK08Katx/ZiZ
         I8O3uG04Kq3RwGkO2127RrkM5BKVP+aiLSBRF1dneFE5QTaZi7yoOEkkviTJ9vLrSz
         7qHjX7+sDOKZz7JLeqodv+QtFd/kTxMQ3s9aHnOv4xJoH7/FdA0qzwmlf0CipF3zcB
         uv64JtT1fhiJUGvraQaRCDlgfhio7TD2iX6Zg1jrd3TqVQZKxJQuMwibHnvQC3CWlC
         DE0qHvObvxA1dcS4sL96zUgi6JgoKE1EUEwjhDFT6+TomJpFjbd0L0kdTXNO3L46df
         edaJbSf6GkoHg==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ttm: fix potential null ptr deref in when mem space alloc fails
Date:   Fri, 18 Mar 2022 19:50:04 +0000
Message-Id: <20220318195004.416539-1-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when allocating a resource in place it is common to free the buffer's
resource, then allocate a new resource in a different placement.

e.g. amdgpu_bo_create_kernel_at calls ttm_resource_free, then calls
ttm_bo_mem_space.

In this situation, bo->resource will be null as it is cleared during
the initial freeing of the previous resource.
This leads to a null deref.

Fixes: d3116756a710 (drm/ttm: rename bo->mem and make it a pointer)

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index db3dc7ef5382..62b29ee7d040 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -875,7 +875,7 @@ int ttm_bo_mem_space(struct ttm_buffer_object *bo,
 	}
 
 error:
-	if (bo->resource->mem_type == TTM_PL_SYSTEM && !bo->pin_count)
+	if (bo->resource && bo->resource->mem_type == TTM_PL_SYSTEM && !bo->pin_count)
 		ttm_bo_move_to_lru_tail_unlocked(bo);
 
 	return ret;
-- 
2.25.1

