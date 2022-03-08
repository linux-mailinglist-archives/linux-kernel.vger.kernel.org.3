Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B1D4D18FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347107AbiCHNSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347094AbiCHNSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:18:38 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD3D68
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:17:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id BE0921F4404A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646745458;
        bh=x9ELuT5l87DnnSxAfWp7rgapLQDyu7nCQiypyxue8IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AisYgY0SCcQ5uduxHtXdKUR2x0DoQxIo226widUi6WSmtBN1xj8h9SZTrrSUfiGIy
         llAL/4sMgykVk4nZLHf0mtj2emCXySfJQJSXNdeOSfHAtasXicNewl/AONMV5ZyFP2
         Mh8GEjMu2Dtjv/rFeFOqc794iaNlOJdOg0fwO5xwSDifSptRzZPvUpiGhUnJYySVq9
         jhUFKIhW/D/Go75+oMcrGP80IruArXJEuMdnUPMbwFRA/v1mrp1aU1jdg9GjCJqT7G
         i6szm0wpV/RBuzl6mjP+++y/La8Ogbyse7wLBDrktUDEVAmISM68uVLMUulwt5gHUO
         rFOjfwWn3X6iA==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 1/5] drm/virtio: Correct drm_gem_shmem_get_sg_table() error handling
Date:   Tue,  8 Mar 2022 16:17:21 +0300
Message-Id: <20220308131725.60607-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
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

