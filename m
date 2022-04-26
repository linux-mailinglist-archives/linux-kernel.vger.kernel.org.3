Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B800F50F0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244737AbiDZGLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiDZGLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:11:49 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8FB644C;
        Mon, 25 Apr 2022 23:08:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650953320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ug9uQ7MO8p5lAMaOYLg82gdoR0QvVH+wRiaruaTU7/M=;
        b=H0dx5u62TZdPskxIIVhdsChJfduatSw8eVPGqkb/o6/xCbHB6fmS99y1cn+Np4lvGH8eXC
        h1wqWv/cVIwctMp8/GQI7KJTI4av9hLXnIdVhWaMVLPbGoQfrT2bq1Nt+gxYstLkt2OhpC
        hHwKYlaC3fnbkznyLO6tBkT22Yd6nGM=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH v2 0/4] drm/nvdla: Add driver support for NVDLA
Date:   Tue, 26 Apr 2022 14:07:57 +0800
Message-Id: <20220426060808.78225-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVIDIA Deep Learning Accelerator (NVDLA) is an open source IP
which is integrated into NVIDIA Jetson AGX Xavier,
so add driver support for this accelerator."

v1->v2:
*Rename nvdla_drm.[ch] to nvdla_drv.[ch] and rename nvdla_ioctl.h to nvdla_drm.h,
 move it to uapi.
 comments link: https://lore.kernel.org/lkml/20bac605-97e6-e5cd-c4e4-83a8121645d8@amd.com/
*Remove the  onexistent filename  in Makefile
 comments link: https://lore.kernel.org/lkml/202204201512.pp20MXT5-lkp@intel.com/
*Sort file names alphabetically in Makefile.
*Rearrange the error messages, and use drm_err/_dbg() instead of pr_err/_dbg().
*Replace  "dla_" prefix with "nvdla_"
*Check the iosys_map by iosys_map_is_null(), and check "ret" directly.
*Using iosys_map_memcpy_to/_from() for iosys_map instead of memcpy()
*Fix parameter error "dma_buf_vunmap(buf, ptr)", use "&map" instead of "ptr"
*Use iosys_map instead of kvaddr and use "iosys_map_set_vaddr()" to initialize iosys_map
*Using "vma->vm_pgoff -= drm_vma_node_start(&obj->vma_node)" to update vm_pgoff is cleaner
*Remove the unused nvdla_drm_gem_mmap, register drm_gem_mmap to file_operations directly.
*Use DEFINE_DRM_GEM_FOPS() to define nvdla_drm_fops.
*Remove the unused nvdla_drm_gem_mmap_buf, register drm_gem_prime_mmap to drm_driver directly.
 comments link: https://lore.kernel.org/lkml/7fa19996-5830-af3d-ab24-08c76e1d5604@suse.de/
*Fix typo and some code style
*Remove unused function nvdla_get_time_us()
 comments link: https://lore.kernel.org/lkml/0fa9ab41-c18e-a569-e6fe-a0e9d965905e@stargateuniverse.net/

Cai Huoqing (4):
  MAINTAINERS: Add the driver info of the NVDLA
  drm/nvdla: Add driver support for NVDLA
  drm/nvdla: Add register head file of NVDLA
  drm/nvdla/uapi: Add UAPI of NVDLA driver

 MAINTAINERS                             |    7 +
 drivers/gpu/drm/Kconfig                 |    2 +
 drivers/gpu/drm/Makefile                |    1 +
 drivers/gpu/drm/nvdla/Kconfig           |    8 +
 drivers/gpu/drm/nvdla/Makefile          |   17 +
 drivers/gpu/drm/nvdla/nvdla_bdma.c      |  198 +
 drivers/gpu/drm/nvdla/nvdla_cache.c     |  202 +
 drivers/gpu/drm/nvdla/nvdla_cdp.c       |  299 ++
 drivers/gpu/drm/nvdla/nvdla_common.c    |  293 ++
 drivers/gpu/drm/nvdla/nvdla_common.h    |  835 +++
 drivers/gpu/drm/nvdla/nvdla_conv.c      |  684 +++
 drivers/gpu/drm/nvdla/nvdla_drv.c       |  694 +++
 drivers/gpu/drm/nvdla/nvdla_drv.h       |  129 +
 drivers/gpu/drm/nvdla/nvdla_engine.c    |  233 +
 drivers/gpu/drm/nvdla/nvdla_engine.h    |  272 +
 drivers/gpu/drm/nvdla/nvdla_gem.c       |  358 ++
 drivers/gpu/drm/nvdla/nvdla_pdp.c       |  448 ++
 drivers/gpu/drm/nvdla/nvdla_reg.h       | 6411 +++++++++++++++++++++++
 drivers/gpu/drm/nvdla/nvdla_rubik.c     |  214 +
 drivers/gpu/drm/nvdla/nvdla_sched.h     |   37 +
 drivers/gpu/drm/nvdla/nvdla_scheduler.c | 1012 ++++
 drivers/gpu/drm/nvdla/nvdla_sdp.c       |  723 +++
 include/uapi/drm/nvdla_drm.h            |   99 +
 23 files changed, 13176 insertions(+)
 create mode 100644 drivers/gpu/drm/nvdla/Kconfig
 create mode 100644 drivers/gpu/drm/nvdla/Makefile
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_bdma.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_cache.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_cdp.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_common.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_common.h
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_conv.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_drv.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_drv.h
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_engine.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_engine.h
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_gem.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_pdp.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_reg.h
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_rubik.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_sched.h
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_scheduler.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_sdp.c
 create mode 100644 include/uapi/drm/nvdla_drm.h

-- 
2.25.1

