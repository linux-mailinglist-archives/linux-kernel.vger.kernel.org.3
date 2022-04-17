Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782B85049D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 00:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiDQWkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 18:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiDQWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 18:40:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F2517053
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 15:37:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 3F5C31F40E94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650235054;
        bh=CWqvGLqMByoxyOodrX4VDvjOrVtokLSbI2qbVKtiRlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcJvf3E+hxnU0Nq1w3WdBJlZftcbVMiok7e+eg7Hwqv0mO18WUBg4OTVgQMjBxM7x
         yZ46LkEOyVClN6kZkvDbrxWcRUO5wd/C+d8UideAEz+At/GNknqup3auWK2DJtpzaf
         iHVksoQqaEGub4RsoCuzWViFzLG0D4Plb5w5uSB1sdFGWYlDIW2JQRbfq04+ydhnly
         rvW7DplggN8WFLcg0Ih8MyEf3KOVM9+ptSPcQ2BWOc8jRLDZQsT1vgV4RrGp0sevIL
         go3ntFW1H9oXdkcuTJkpLu7GmrdLg+0+xU6KbdIzshQNQFjUBVCDMCjrjJH2n0oMuO
         AMDsaMYO5BY2g==
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
Subject: [PATCH v4 04/15] drm/virtio: Unlock reservations on dma_resv_reserve_fences() error
Date:   Mon, 18 Apr 2022 01:36:56 +0300
Message-Id: <20220417223707.157113-5-dmitry.osipenko@collabora.com>
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

