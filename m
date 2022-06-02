Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8EC53B776
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiFBKmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiFBKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:42:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FABB2B1956
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:42:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s12so4241725plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 03:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKdr7CfYzmgcmFB2loZiYlvbj5N+OaQKo7R5pMIPmm8=;
        b=A3YrpRaKmeYmIAEAeNWVkCe6dy9TDA0evXAfqjTuMB1ooxaYHhauQ/mQCJV9aAnVoW
         kXXODq0Lh2naSGw8EAakYnT2WUdDGUd98IMgUbNNJK6D6ju3AQjc9RXJQxhz/zN+TYlt
         0E33alUQvdrHLQWb3l96cHsGtZPf2qD9GiGE1JoVstN2zAUtsrlMTT1rMlBESwIvLpmc
         IFnj23t6ARNo+AuaYGYOOlckCTJDXBLwyK3ZKODyGg4Y+W5/zSE8lBs5Rq7C3FODhE11
         HoUcTRZPla70SRPatjrJFU6nh7y9yROyY42uNr3X/qtU8eiqdc67shiSX0+pxJS3B2Re
         QP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AKdr7CfYzmgcmFB2loZiYlvbj5N+OaQKo7R5pMIPmm8=;
        b=zSeOE1aGxR9FyIfF5k6JoQ91SqxZdtIsFiWAw27GU3e97ATMTMJKDP/u74OUo3I4Ng
         nwiORaHdYLTFlA7veyZIFNKJL0T/ejEvZKZlNgterFDfZX4tv+jVKA4YoYWVy/cYbyVh
         zRupvwjZaHkYf2SJlnGVMr8I+T/Sv7GTizJx6xRfDeSkifYSrCX7125Zm40lPbg4SMhF
         e4FoUbhhEkXsg4nLZikLvR5t/0DZr3JqOIWhlqpVKK2LojIjmsq13EEze+Pl6fGpeNu/
         N8CRJ5fwYXolC4mFQbOO7noM/gkd/ZqSmMoJEakODd9Z0LbyZJE3qwsETIZoGiskdeF6
         Bp0A==
X-Gm-Message-State: AOAM531Ap+J1YvAiN9bXsRZjAS/zLpSV7oAkst9aoHaN0EAGzmwz4A1s
        G+yRFbZCTPn79O7qc6YYbZk=
X-Google-Smtp-Source: ABdhPJx6r6pOwkfRgRVpSvvkjLzbWO/RgAk2huhEyWH9GDgglMzzaIMMngRVdaAYuninQmoDHkvf1A==
X-Received: by 2002:a17:90a:9cf:b0:1e3:1033:f580 with SMTP id 73-20020a17090a09cf00b001e31033f580mr4573720pjo.57.1654166552198;
        Thu, 02 Jun 2022 03:42:32 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id ku12-20020a17090b218c00b001e31feb7383sm2988516pjb.49.2022.06.02.03.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 03:42:31 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] drm/virtio: Fix NULL vs IS_ERR checking in virtio_gpu_object_shmem_init
Date:   Thu,  2 Jun 2022 14:42:22 +0400
Message-Id: <20220602104223.54527-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since drm_prime_pages_to_sg() function return error pointers.
The drm_gem_shmem_get_sg_table() function returns error pointers too.
Using IS_ERR() to check the return value to fix this.

Fixes: 2f2aa13724d5 ("drm/virtio: move virtio_gpu_mem_entry initialization to new function")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- Update Fixes tag.
- rebase the working tree.
v1 Link: https://lore.kernel.org/all/20211222072649.18169-1-linmq006@gmail.com/
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index f293e6ad52da..1cc8f3fc8e4b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -168,9 +168,9 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 	 * since virtio_gpu doesn't support dma-buf import from other devices.
 	 */
 	shmem->pages = drm_gem_shmem_get_sg_table(&bo->base);
-	if (!shmem->pages) {
+	if (IS_ERR(shmem->pages)) {
 		drm_gem_shmem_unpin(&bo->base);
-		return -EINVAL;
+		return PTR_ERR(shmem->pages);
 	}
 
 	if (use_dma_api) {
-- 
2.25.1

