Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8454D18FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347110AbiCHNSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiCHNSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:18:40 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A3465CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:17:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id A43E61F44049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646745457;
        bh=zcqcE7dIUc7tx7i1KnnMTJpX/TOVNA/MHpX4Pjw5exg=;
        h=From:To:Cc:Subject:Date:From;
        b=HKfueVRLzYyO7heYtKq0P/VcD/mvjVk9O+tlsnYuUALjo1FEabj4WwLBiVWL4Av90
         uVcDFyMWpNldyoeq/D1suqnKq1P0WFuhcj4bj5KWotnShNHJdaomZzegK+sgxLzaGh
         UPRHSrtVQqZMvjiaJ2+DHew1T80/308r6GFNpQpATODJcrO2YO63bZNR+t3o3YBD4c
         m7uy3eScR6qnPupk0ewJL2RF8oj9M2lV0b5ZxjCdUfhs1RYJ8zSS6EnScZRIidZXTR
         ASbl241baqqO2DnpZ4AHIJIvPbrifE/YXG8iUN/PnlBTF1gPVJ3Fi63Luk8a4YanB3
         JOs7NFZaib1bA==
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
Subject: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
Date:   Tue,  8 Mar 2022 16:17:20 +0300
Message-Id: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
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

Hello,

This patchset introduces memory shrinker for the VirtIO-GPU DRM driver.
During OOM, the shrinker will release BOs that are marked as "not needed"
by userspace using the new madvise IOCTL. The userspace in this case is
the Mesa VirGL driver, it will mark the cached BOs as "not needed",
allowing kernel driver to release memory of the cached shmem BOs on lowmem
situations, preventing OOM kills.

This patchset includes couple fixes for problems I found while was working
on the shrinker, it also includes prerequisite DMA API usage improvement
needed by the shrinker.

The Mesa and IGT patches will be kept on hold until this kernel series
will be approved and applied.

This patchset was tested using Qemu and crosvm, including both cases of
IOMMU off/on.

Mesa: https://gitlab.freedesktop.org/digetx/mesa/-/commits/virgl-madvise
IGT:  https://gitlab.freedesktop.org/digetx/igt-gpu-tools/-/tree/virtio-madvise

Dmitry Osipenko (5):
  drm/virtio: Correct drm_gem_shmem_get_sg_table() error handling
  drm/virtio: Check whether transferred 2D BO is shmem
  drm/virtio: Unlock GEM reservations in error code path
  drm/virtio: Improve DMA API usage for shmem BOs
  drm/virtio: Add memory shrinker

 drivers/gpu/drm/virtio/Makefile               |   3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c          |  22 +++-
 drivers/gpu/drm/virtio/virtgpu_drv.h          |  31 ++++-
 drivers/gpu/drm/virtio/virtgpu_gem.c          |  84 ++++++++++++
 drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c | 124 ++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c        |  37 ++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c          |  17 ++-
 drivers/gpu/drm/virtio/virtgpu_object.c       |  63 +++------
 drivers/gpu/drm/virtio/virtgpu_plane.c        |  17 ++-
 drivers/gpu/drm/virtio/virtgpu_vq.c           |  30 +++--
 include/uapi/drm/virtgpu_drm.h                |  14 ++
 11 files changed, 373 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_gem_shrinker.c

-- 
2.35.1

