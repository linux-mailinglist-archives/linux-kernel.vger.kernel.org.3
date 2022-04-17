Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152555049D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 00:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiDQWkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 18:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiDQWkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 18:40:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531A71706F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 15:37:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 7B73D1F40EAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650235062;
        bh=1ir1kXOoDBYMTq2gw1c/hNFv88UQm29tKUM6x3KBBGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hea1EvPZUMcEaDCrh7oNSCd6BUH9Ahes2H0SWknm39s8kYQm5qNtTGJonYei0/jjr
         3VplLfEpBM1Em8Im+zYVaUK3gS7ECtwqIsbDKBydkwaI4rA0MRhzcSVCCpdvFyzqe5
         HYFKv1EzPs2L9mFTskpTrsR8V+IucPcXifyatoqf8b3GvjtrfRXPCwn5ip6OmN7o6s
         HlzGRFb08p6N11BxqbqWICdBssB6G7qDFPS3YOCKRHcWoYVQaoCbiJ/tqXTBL2Z1Qi
         zqMUjTDHWHlXeGEn2fGB0PsYvmqZZqXkJfeWXYT8H1RFu9cGzLt11TAqw5D1N7Nb8s
         FlYjM5K5yRHtA==
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
        Robin Murphy <robin.murphy@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v4 08/15] drm/virtio: Use dev_is_pci()
Date:   Mon, 18 Apr 2022 01:37:00 +0300
Message-Id: <20220417223707.157113-9-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
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
2.35.1

