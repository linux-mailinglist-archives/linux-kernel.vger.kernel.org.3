Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B594D8FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbiCNWp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245741AbiCNWpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:45:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E44731215
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:44:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 8CD1E1F42F1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647297848;
        bh=TBiQJ/3o+3HqewXSmJJNojpMEgQPTJ/rcTSNGsZwh3M=;
        h=From:To:Cc:Subject:Date:From;
        b=en6b8z9V7kLLfYzoQx6/slBRRue0IjwXU9C3tQR2jh1W2M4s5NwmhqFsLpUfCpr9B
         hxCMFZwSQTNdkrmT0poA6F/YCzXL8kwlWouSfHltsm99nI1lgKh0qYkMgr9Nbe3BnN
         VAm8/PHWyHbGPWHt781VyJxa0A6UZJqrV2pC/9nkvZ1D8ewNtBhg3duNomES6FSyDi
         9fgXOereBA1sMzukXNRd+WyUV6LNfhqbxdCiloCOu0lXLb6i2dyAGwcPQ6CFuvLNO2
         Pq4Ey7mKZUY3P51At41jZEdXSOAKN7M1Up5Udp3BwC2s0zR13uozNd0kFP/xJXgiPZ
         hBqQIgsHAe5xQ==
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
Subject: [PATCH v2 0/8] Add memory shrinker to VirtIO-GPU DRM driver
Date:   Tue, 15 Mar 2022 01:42:45 +0300
Message-Id: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
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

This patchset includes couple fixes for problems of VirtIO-GPU driver that
I found while was working on the shrinker, it also includes prerequisite
DMA API usage improvement needed by the shrinker.

The Mesa and IGT patches will be kept on hold until this kernel series
will be approved and applied.

This patchset was tested using Qemu and crosvm, including both cases of
IOMMU off/on.

Note that this patchset only enables initial shrinking of the guest memory,
shrinking of the host memory is unsupported yet.

Mesa: https://gitlab.freedesktop.org/digetx/mesa/-/commits/virgl-madvise
IGT:  https://gitlab.freedesktop.org/digetx/igt-gpu-tools/-/tree/virtio-madvise

Changelog:

v2: - Improved shrinker by using a more fine-grained locking to reduce
      contention during scan of objects and dropped locking from the
      'counting' callback by tracking count of shrinkable pages. This
      was suggested by Rob Clark in the comment to v1.

    - Factored out common shrinker code into drm_gem_shmem_helper.c
      and switched Panfrost driver to use the new common memory shrinker.
      This was proposed by Thomas Zimmermann in his prototype series that
      he shared with us in the comment to v1. Note that I only compile-tested
      the Panfrost driver.

    - Shrinker now takes object_name_lock during scan to prevent racing
      with dma-buf exporting.

    - Shrinker now takes vmap_lock during scan to prevent racing with shmem
      vmap/unmap code.

    - Added "Correct doc-comment of drm_gem_shmem_get_sg_table()" patch,
      which I sent out previously as a standalone change, since the
      drm_gem_shmem_helper.c is now touched by this patchset anyways and
      it doesn't hurt to group all the patches together.

Dmitry Osipenko (8):
  drm/virtio: Correct drm_gem_shmem_get_sg_table() error handling
  drm/virtio: Check whether transferred 2D BO is shmem
  drm/virtio: Unlock GEM reservations in error code path
  drm/virtio: Improve DMA API usage for shmem BOs
  drm/shmem-helper: Correct doc-comment of drm_gem_shmem_get_sg_table()
  drm/shmem-helper: Add generic memory shrinker
  drm/virtio: Support memory shrinking
  drm/panfrost: Switch to generic memory shrinker

 drivers/gpu/drm/drm_gem_shmem_helper.c     | 196 ++++++++++++++++++++-
 drivers/gpu/drm/panfrost/Makefile          |   1 -
 drivers/gpu/drm/panfrost/panfrost_device.h |   4 -
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  19 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c    |  27 +--
 drivers/gpu/drm/panfrost/panfrost_gem.h    |   9 -
 drivers/gpu/drm/panfrost/panfrost_job.c    |  22 ++-
 drivers/gpu/drm/virtio/virtgpu_drv.c       |  22 ++-
 drivers/gpu/drm/virtio/virtgpu_drv.h       |  26 ++-
 drivers/gpu/drm/virtio/virtgpu_gem.c       |  96 ++++++++++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c     |  37 ++++
 drivers/gpu/drm/virtio/virtgpu_kms.c       |  17 +-
 drivers/gpu/drm/virtio/virtgpu_object.c    |  78 ++++----
 drivers/gpu/drm/virtio/virtgpu_plane.c     |  17 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c        |  30 +++-
 include/drm/drm_device.h                   |   4 +
 include/drm/drm_gem.h                      |  11 ++
 include/drm/drm_gem_shmem_helper.h         |  25 +++
 include/uapi/drm/virtgpu_drm.h             |  14 ++
 19 files changed, 544 insertions(+), 111 deletions(-)

-- 
2.35.1

