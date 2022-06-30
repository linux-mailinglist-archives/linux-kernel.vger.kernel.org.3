Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5834B5623EB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiF3UIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbiF3UH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:07:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633574506F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:07:58 -0700 (PDT)
Received: from dimapc.. (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B15A660198A;
        Thu, 30 Jun 2022 21:07:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656619677;
        bh=GeAjvmf+urVtW31vmebmoRtvHFY653QOqua5mOTvkSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VbB4ZOCJC+c+Y/MR1xX3Oav+CB3vQfwwq4q/RdEi0jvay8fgzvzUCDZf0e49O9Z5X
         LHgCCiTRvH+jN3odtLCMFtJF7vp+Qf7GKfoAfXwvrWyL+CCHj8hsogZeq7PItfADsI
         HUh9uEL1gj78ULc90Gia8fj8lq3jr55eN2jhgEPVhYCL33FQnTwP7CfrjbbuRO7+d3
         GchOKe/FW+RI6p5cxIuKntlY3U8gM3TUc14g4t0zD3cD4jm6+uhFmAkn9ZKAA14IJA
         iXdpDJu5o2ZcHZtRMamoxPgkTV6gPsflXAjrLMHsZ+bFKElk0OKsanY15M8w4RoL3j
         wz4ZhXWwEBplw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
Subject: [PATCH v7 4/9] drm/virtio: Unlock reservations on dma_resv_reserve_fences() error
Date:   Thu, 30 Jun 2022 23:07:21 +0300
Message-Id: <20220630200726.1884320-5-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlock reservations on dma_resv_reserve_fences() error to fix recursive
locking of the reservations when this error happens.

Cc: stable@vger.kernel.org
Fixes: c8d4c18bfbc4 ("dma-buf/drivers: make reserving a shared slot mandatory v4")
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
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
2.36.1

