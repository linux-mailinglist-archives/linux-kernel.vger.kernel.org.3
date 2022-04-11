Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68A84FC744
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350346AbiDKWDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350375AbiDKWCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:02:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7F9E39
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:00:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 81CE41F438CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649714423;
        bh=CWqvGLqMByoxyOodrX4VDvjOrVtokLSbI2qbVKtiRlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ohca8T9NknI5hVHqu9rr5ZgXYuOC9GXZJtDtkVbj/OxMg8xZc+KmY1YlqktGRzbvn
         RHHj5zlXOhIHZ1svIKMTtBTL6ieioJoyny22GnBKVQyb1Ns6Mjx3MQaHCkf70/myPB
         KV7fN6iulrVusmojzr5DBZ5ymQGAPvmIycGUAtmOgpqwparzpS98z+VKZ8l1tSULGF
         rEyX4IQ/DaUNR82ij5YKRy6pVvkfdA6l4cBlsINwR3h6ITsWIKx4W5mLI8cFfnW3Pm
         87J8ylqNdiZH2vkmXUjfuS7k/ZWAIfkvsVU8WDUz7Lsc5ulnU8BZMw0dBu2TBOo90J
         zqjruRAl8rwdg==
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
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v3 04/15] drm/virtio: Unlock reservations on dma_resv_reserve_fences() error
Date:   Tue, 12 Apr 2022 00:59:26 +0300
Message-Id: <20220411215937.281655-5-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411215937.281655-1-dmitry.osipenko@collabora.com>
References: <20220411215937.281655-1-dmitry.osipenko@collabora.com>
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

Unlock reservations on dma_resv_reserve_fences() error to fix recursive
locking of the reservations when this error happens.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 580a78809836..7db48d17ee3a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -228,8 +228,10 @@ int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 
 	for (i = 0; i < objs->nents; ++i) {
 		ret = dma_resv_reserve_fences(objs->objs[i]->resv, 1);
-		if (ret)
+		if (ret) {
+			virtio_gpu_array_unlock_resv(objs);
 			return ret;
+		}
 	}
 	return ret;
 }
-- 
2.35.1

