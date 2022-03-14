Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D2B4D8FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbiCNWpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245734AbiCNWpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:45:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B063933E9D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:44:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 1860E1F42F1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647297850;
        bh=x9ELuT5l87DnnSxAfWp7rgapLQDyu7nCQiypyxue8IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6N++5nfqRD0boSbFJxQcOnXA9/pCYptAUc8bZa2zby8TB7CKKiTR3X+qp+B3yfDk
         9zgtO/1mqB05Zua/kKRTOJ460ClV0HwLDLKvn6jIf+njMGkZiWUq8GZsKsLDjAI9L6
         Lzswb9elaeqRVq6zrt9nx2D0F1nqI60oNfBygabp9P0HH3nZffZgiECPGDlitz3lVk
         3nJOj0Rg1RVHiekjvmrYPJ/BFtu+H3EeKe3BEWPljIn/PnLD/xTRiKQE/8i74rwoEy
         KTNqxJpN9NgwwSg2zl+tOttLTd25iYCkbephf90vr2I+77nqtXJqGvumSbFa86dsNC
         YBW381Vt+wgUg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v2 1/8] drm/virtio: Correct drm_gem_shmem_get_sg_table() error handling
Date:   Tue, 15 Mar 2022 01:42:46 +0300
Message-Id: <20220314224253.236359-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
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

drm_gem_shmem_get_sg_table() never ever returned NULL on error. Correct
the error handling to avoid crash on OOM.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index f293e6ad52da..bea7806a3ae3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -168,9 +168,11 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 	 * since virtio_gpu doesn't support dma-buf import from other devices.
 	 */
 	shmem->pages = drm_gem_shmem_get_sg_table(&bo->base);
-	if (!shmem->pages) {
+	ret = PTR_ERR(shmem->pages);
+	if (ret) {
 		drm_gem_shmem_unpin(&bo->base);
-		return -EINVAL;
+		shmem->pages = NULL;
+		return ret;
 	}
 
 	if (use_dma_api) {
-- 
2.35.1

