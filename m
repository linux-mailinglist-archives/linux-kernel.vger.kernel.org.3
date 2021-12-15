Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FD5475128
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 04:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbhLODAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 22:00:50 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41435 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239445AbhLODAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 22:00:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V-gJWWD_1639537246;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V-gJWWD_1639537246)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Dec 2021 11:00:46 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tomba@kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, bparrot@ti.com,
        narmstrong@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/omap: Fix NULL but dereferenced coccicheck error
Date:   Wed, 15 Dec 2021 11:00:44 +0800
Message-Id: <20211215030044.57748-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/gpu/drm/omapdrm/omap_overlay.c:89:22-25: ERROR: r_ovl is NULL
but dereferenced.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: e02b5cc9e898 ("drm/omap: Add a 'right overlay' to plane state")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/omapdrm/omap_overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_overlay.c b/drivers/gpu/drm/omapdrm/omap_overlay.c
index 10730c9b2752..b0bc9ad2ef73 100644
--- a/drivers/gpu/drm/omapdrm/omap_overlay.c
+++ b/drivers/gpu/drm/omapdrm/omap_overlay.c
@@ -86,7 +86,7 @@ int omap_overlay_assign(struct drm_atomic_state *s, struct drm_plane *plane,
 		r_ovl = omap_plane_find_free_overlay(s->dev, overlay_map,
 						     caps, fourcc);
 		if (!r_ovl) {
-			overlay_map[r_ovl->idx] = NULL;
+			overlay_map[ovl->idx] = NULL;
 			*overlay = NULL;
 			return -ENOMEM;
 		}
-- 
2.20.1.7.g153144c

