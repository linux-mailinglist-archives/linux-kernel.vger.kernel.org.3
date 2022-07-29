Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A9E584DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiG2JGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiG2JGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:06:49 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B23650065
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:06:47 -0700 (PDT)
Received: from alisa-ThinkPad-T440s.. (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 575CF40737DF;
        Fri, 29 Jul 2022 09:06:44 +0000 (UTC)
From:   Alisa Khabibrakhmanova <khabibrakhmanova@ispras.ru>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Alisa Khabibrakhmanova <khabibrakhmanova@ispras.ru>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] drm/via: Add new condition to via_dma_cleanup()
Date:   Fri, 29 Jul 2022 12:06:43 +0300
Message-Id: <20220729090643.240778-1-khabibrakhmanova@ispras.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YuAjDvYey1hhI1AJ@ravnborg.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer dev_priv->mmio, which was checked for NULL at via_do_init_map(),
is passed to via_do_cleanup_map() and is dereferenced there without check.

The patch adds the condition in via_dma_cleanup() which prevents potential NULL
pointer dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 22f579c621e2 ("drm: Add via unichrome support")
Signed-off-by: Alisa Khabibrakhmanova <khabibrakhmanova@ispras.ru>
---
 drivers/gpu/drm/via/via_dri1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/via/via_dri1.c b/drivers/gpu/drm/via/via_dri1.c
index d695d9291ece..691e3ceb0062 100644
--- a/drivers/gpu/drm/via/via_dri1.c
+++ b/drivers/gpu/drm/via/via_dri1.c
@@ -2961,7 +2961,7 @@ int via_dma_cleanup(struct drm_device *dev)
 		drm_via_private_t *dev_priv =
 		    (drm_via_private_t *) dev->dev_private;
 
-		if (dev_priv->ring.virtual_start) {
+		if (dev_priv->ring.virtual_start && dev_priv->mmio) {
 			via_cmdbuf_reset(dev_priv);
 
 			drm_legacy_ioremapfree(&dev_priv->ring.map, dev);
-- 
2.34.1

