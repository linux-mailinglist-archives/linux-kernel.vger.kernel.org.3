Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC897492757
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbiARNiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239194AbiARNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:38:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6ABC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 05:38:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 980171F43F1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642513086;
        bh=gAJqDSZX33NiJSylH50FUmE5ljeiUi+EvyLQjN8gu0s=;
        h=From:To:Cc:Subject:Date:From;
        b=en6ZVaKEZ5/Pcq6HgkiyVqRZ/ISe6Mx4RYmT5gQQ1+x6gnXvJVHmWg0exmzoyqhvJ
         7prirfD4v9hYzp5XMmqJrbD/N+j0Ex5Ke3RPaWsww6YSLbc+5R6jC1y6XNDDiq1D0D
         woERW0SCrQa8NcH8w9osIcXVQz56C0dluayI0XUvsgbRxBzP72fzktTf1gdFNmzr3S
         3sqs6dbyBdjpARKvso0i2HYRiy4nDc4RwdrI5s6a4oyb7XCylZxytyXZEs3JW5PBsG
         2g6jXjZVV1Sb+OOFpuOCJpPyjlbhO1gZH3wRXPjSrKPHYLzFkBMnVUg+qxfenY707V
         QeGBbOq7IBg5g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] drm: mediatek: mtk_drm_plane: Use kmalloc in mtk_plane_duplicate_state
Date:   Tue, 18 Jan 2022 14:37:58 +0100
Message-Id: <20220118133759.112458-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to zero out the newly allocated memory because we are
duplicating all members of struct mtk_plane_state: switch to kmalloc
to save some overhead.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index c74cb94e445e..39cb9a80d976 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -57,7 +57,7 @@ static struct drm_plane_state *mtk_plane_duplicate_state(struct drm_plane *plane
 	struct mtk_plane_state *old_state = to_mtk_plane_state(plane->state);
 	struct mtk_plane_state *state;
 
-	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return NULL;
 
-- 
2.33.1

