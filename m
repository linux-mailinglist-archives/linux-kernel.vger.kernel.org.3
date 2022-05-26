Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2651D5356AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349712AbiEZX4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349834AbiEZXzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:55:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC47AED704;
        Thu, 26 May 2022 16:55:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 67E0F1F459F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653609316;
        bh=nY0MryRm8EK3fifz2ya2uo9G85zwxQHFBXlNamou3uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TPeKw0UeuJCFCD2HqILO4z07soz9OoaVsjzzQgbDfal9kRh9+jz7LvWATtBgQ/b/x
         kvsVGbXAIRgLSj/o3IsgG3e0m9ULZ09K0x1PLQHx2s1wX7O3I/nZ4aKNuIOeBTYCLM
         Jz14QKo4VICvqsgcicgS7cvaPCUF3AKEra860bEiriwvcZ5boXfPUq2UOT7/McCtXn
         7aDOtQqFws0SBl2VPJtXQ7uWVDsUi1tK8X3qWklVQr01dlx2F+Y7Edi4uXRMSP3TXf
         y/NyD+h7NZMis9pT+P/8sCSKiMGjnY/ji3qklgJLLLPGW5QIO3uMNNLCXl2TLoAgoR
         15ZWBWtRuh7HQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Qiang Yu <yuq825@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kernel@collabora.com
Subject: [PATCH v6 20/22] drm/virtio: Use dev_is_pci()
Date:   Fri, 27 May 2022 02:50:38 +0300
Message-Id: <20220526235040.678984-21-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
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

Use common dev_is_pci() helper to replace the strcmp("pci") used by driver.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 0141b7df97ec..0035affc3e59 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -87,7 +87,7 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 		return PTR_ERR(dev);
 	vdev->priv = dev;
 
-	if (!strcmp(vdev->dev.parent->bus->name, "pci")) {
+	if (dev_is_pci(vdev->dev.parent)) {
 		ret = virtio_gpu_pci_quirk(dev);
 		if (ret)
 			goto err_free;
-- 
2.35.3

