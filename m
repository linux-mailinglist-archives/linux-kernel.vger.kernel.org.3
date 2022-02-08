Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F8B4AD7E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358070AbiBHLvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358013AbiBHLuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:50:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B579C08E834;
        Tue,  8 Feb 2022 03:42:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04C45B81852;
        Tue,  8 Feb 2022 11:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E433CC004E1;
        Tue,  8 Feb 2022 11:42:34 +0000 (UTC)
Message-ID: <aa1312fc-197b-c1ab-6a18-369d49c1e8f8@xs4all.nl>
Date:   Tue, 8 Feb 2022 12:42:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4] dma-buf-map: Rename to iosys-map
Content-Language: en-US
To:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, airlied@linux.ie, lyude@redhat.com,
        tzimmermann@suse.de, linux-media@vger.kernel.org,
        nouveau@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20220204170541.829227-1-lucas.demarchi@intel.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220204170541.829227-1-lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/22 18:05, Lucas De Marchi wrote:
> Rename struct dma_buf_map to struct iosys_map and corresponding APIs.
> Over time dma-buf-map grew up to more functionality than the one used by
> dma-buf: in fact it's just a shim layer to abstract system memory, that
> can be accessed via regular load and store, from IO memory that needs to
> be acessed via arch helpers.
> 
> The idea is to extend this API so it can fulfill other needs, internal
> to a single driver. Example: in the i915 driver it's desired to share
> the implementation for integrated graphics, which uses mostly system
> memory, with discrete graphics, which may need to access IO memory.
> 
> The conversion was mostly done with the following semantic patch:
> 
> 	@r1@
> 	@@
> 	- struct dma_buf_map
> 	+ struct iosys_map
> 
> 	@r2@
> 	@@
> 	(
> 	- DMA_BUF_MAP_INIT_VADDR
> 	+ IOSYS_MAP_INIT_VADDR
> 	|
> 	- dma_buf_map_set_vaddr
> 	+ iosys_map_set_vaddr
> 	|
> 	- dma_buf_map_set_vaddr_iomem
> 	+ iosys_map_set_vaddr_iomem
> 	|
> 	- dma_buf_map_is_equal
> 	+ iosys_map_is_equal
> 	|
> 	- dma_buf_map_is_null
> 	+ iosys_map_is_null
> 	|
> 	- dma_buf_map_is_set
> 	+ iosys_map_is_set
> 	|
> 	- dma_buf_map_clear
> 	+ iosys_map_clear
> 	|
> 	- dma_buf_map_memcpy_to
> 	+ iosys_map_memcpy_to
> 	|
> 	- dma_buf_map_incr
> 	+ iosys_map_incr
> 	)
> 
> 	@@
> 	@@
> 	- #include <linux/dma-buf-map.h>
> 	+ #include <linux/iosys-map.h>
> 
> Then some files had their includes adjusted and some comments were
> update to remove mentions to dma-buf-map.
> 
> Since this is not specific to dma-buf anymore, move the documentation to
> the "Bus-Independent Device Accesses" section.
> 
> v2:
>   - Squash patches
> 
> v3:
>   - Fix wrong removal of dma-buf.h from MAINTAINERS
>   - Move documentation from dma-buf.rst to device-io.rst
> 
> v4:
>   - Change documentation tile and level
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  Documentation/driver-api/device-io.rst        |   9 +
>  Documentation/driver-api/dma-buf.rst          |   9 -
>  Documentation/gpu/todo.rst                    |  20 +-
>  MAINTAINERS                                   |   9 +-
>  drivers/dma-buf/dma-buf.c                     |  22 +-
>  drivers/dma-buf/heaps/cma_heap.c              |  10 +-
>  drivers/dma-buf/heaps/system_heap.c           |  10 +-
>  drivers/gpu/drm/ast/ast_drv.h                 |   2 +-
>  drivers/gpu/drm/ast/ast_mode.c                |   8 +-
>  drivers/gpu/drm/drm_cache.c                   |  18 +-
>  drivers/gpu/drm/drm_client.c                  |   9 +-
>  drivers/gpu/drm/drm_fb_helper.c               |  12 +-
>  drivers/gpu/drm/drm_gem.c                     |  12 +-
>  drivers/gpu/drm/drm_gem_cma_helper.c          |   9 +-
>  drivers/gpu/drm/drm_gem_framebuffer_helper.c  |  16 +-
>  drivers/gpu/drm/drm_gem_shmem_helper.c        |  15 +-
>  drivers/gpu/drm/drm_gem_ttm_helper.c          |   4 +-
>  drivers/gpu/drm/drm_gem_vram_helper.c         |  25 +-
>  drivers/gpu/drm/drm_internal.h                |   6 +-
>  drivers/gpu/drm/drm_mipi_dbi.c                |   8 +-
>  drivers/gpu/drm/drm_prime.c                   |   4 +-
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h         |   2 +-
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c   |   8 +-
>  drivers/gpu/drm/gud/gud_pipe.c                |   4 +-
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c   |   5 +-
>  drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |   8 +-
>  .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |   6 +-
>  .../gpu/drm/i915/gem/selftests/mock_dmabuf.c  |   6 +-
>  drivers/gpu/drm/lima/lima_gem.c               |   3 +-
>  drivers/gpu/drm/lima/lima_sched.c             |   4 +-
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c        |   7 +-
>  drivers/gpu/drm/mediatek/mtk_drm_gem.h        |   5 +-
>  drivers/gpu/drm/mgag200/mgag200_mode.c        |   4 +-
>  drivers/gpu/drm/msm/msm_drv.h                 |   4 +-
>  drivers/gpu/drm/msm/msm_gem_prime.c           |   6 +-
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |  13 +-
>  drivers/gpu/drm/qxl/qxl_display.c             |   8 +-
>  drivers/gpu/drm/qxl/qxl_draw.c                |   6 +-
>  drivers/gpu/drm/qxl/qxl_drv.h                 |  10 +-
>  drivers/gpu/drm/qxl/qxl_object.c              |   8 +-
>  drivers/gpu/drm/qxl/qxl_object.h              |   4 +-
>  drivers/gpu/drm/qxl/qxl_prime.c               |   4 +-
>  drivers/gpu/drm/radeon/radeon_gem.c           |   1 +
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c   |   9 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.h   |   5 +-
>  drivers/gpu/drm/tegra/gem.c                   |  10 +-
>  drivers/gpu/drm/tiny/cirrus.c                 |   8 +-
>  drivers/gpu/drm/tiny/gm12u320.c               |   7 +-
>  drivers/gpu/drm/ttm/ttm_bo_util.c             |  16 +-
>  drivers/gpu/drm/ttm/ttm_resource.c            |  42 +--
>  drivers/gpu/drm/ttm/ttm_tt.c                  |   8 +-
>  drivers/gpu/drm/udl/udl_modeset.c             |   3 +-
>  drivers/gpu/drm/vboxvideo/vbox_mode.c         |   4 +-
>  drivers/gpu/drm/vkms/vkms_composer.c          |   4 +-
>  drivers/gpu/drm/vkms/vkms_drv.h               |   6 +-
>  drivers/gpu/drm/vkms/vkms_plane.c             |   2 +-
>  drivers/gpu/drm/vkms/vkms_writeback.c         |   2 +-
>  drivers/gpu/drm/xen/xen_drm_front_gem.c       |   7 +-
>  drivers/gpu/drm/xen/xen_drm_front_gem.h       |   6 +-

For these three:

>  .../common/videobuf2/videobuf2-dma-contig.c   |   8 +-
>  .../media/common/videobuf2/videobuf2-dma-sg.c |   9 +-
>  .../common/videobuf2/videobuf2-vmalloc.c      |  11 +-

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans
