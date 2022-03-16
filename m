Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3344DB910
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 20:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347035AbiCPTwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbiCPTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:52:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA5A5AEFD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 12:50:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 237E61F42B7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647460250;
        bh=2X9h3nK80lcnPb4NphKM5EwYM/7VFhDpWrcrESua5VM=;
        h=From:To:Cc:Subject:Date:From;
        b=ZC6yeoP0u5YljDKXBUmjhxMwqmEBdz/dwjVonSXoti8So2CArj1FC7/edEN2RaPaB
         3hl8lpKvTdcwzHyfr+eQaMcXIl2vtxsVuMBG9WKHUY/gyiapr9QjEpphtS+yiRPX8W
         nQri+T0ePsWuGCh3B1/2HX9zL8RzdqAQ1rYYF8TPWHcAujwhBHMj2V7wlOYxd2LuwN
         6wvLb+TjFm3QZNMwXliu+c8izhMjGjL9KZcZozlyxOY/5rhSHroylr+pOachUguNfh
         HRmwRjpzENPc9JDKc31k2ozTID8brXVm2HkA0dYA0jDQhTD7LHen5xs8CcfSZewgtt
         n3l0FfYyb+N1w==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ttm: fix uninit ptr deref in range manager alloc error path
Date:   Wed, 16 Mar 2022 19:50:34 +0000
Message-Id: <20220316195034.3821108-1-bob.beckett@collabora.com>
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

ttm_range_man_alloc would try to ttm_resource_fini the res pointer
before it is allocated.

Fixes: de3688e469b0 (drm/ttm: add ttm_resource_fini v2)

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/ttm/ttm_range_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_range_manager.c b/drivers/gpu/drm/ttm/ttm_range_manager.c
index 5662627bb933..1b4d8ca52f68 100644
--- a/drivers/gpu/drm/ttm/ttm_range_manager.c
+++ b/drivers/gpu/drm/ttm/ttm_range_manager.c
@@ -89,7 +89,7 @@ static int ttm_range_man_alloc(struct ttm_resource_manager *man,
 	spin_unlock(&rman->lock);
 
 	if (unlikely(ret)) {
-		ttm_resource_fini(man, *res);
+		ttm_resource_fini(man, &node->base);
 		kfree(node);
 		return ret;
 	}
-- 
2.25.1

