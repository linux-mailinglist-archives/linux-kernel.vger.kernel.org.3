Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8FF570B87
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiGKU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiGKUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CA34BD2B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 312C56163B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18447C341CF;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=Ytm8lOtM2ZW3u6HFTfJHPS0amLWiRmN8kvQskKiiVU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwGfCkfX3nYC47OQqpZ8FV98aJRke1aSDCk7e7ry+7rAV9xyagDR6xY4bK/h0deVf
         j3OtE++T8tEIxNjZO8D+lQBKjayK11JIOW4CT03E1tEWjlk+Rr4fhNKTL4i7bABaab
         kVIwTLGTLAcua036C13j1UC607AN4dMumjj8/5SD3DhOgxYFEysVeeJAqEo0CGPVho
         y575drwE7SPdtEv1Zjzg0juLAVS1LG9Eof7tk6Za+tsxsQ2+h+YeFzK2G01ImwqFh6
         MRLdTnC6o+eJ+5L/G1P0dVF/CJg2Jy8nOFd4ph95AxPFt4aCfuxj1xXdEMsKXA10Ly
         XFmh5eelFgsrw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e7d-CB;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/32] drm/i915: gvt: fix kernel-doc trivial warnings
Date:   Mon, 11 Jul 2022 21:24:49 +0100
Message-Id: <15fc6317ef5eb4ad7123d627c58c4aa04a4eae87.1657565224.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657565224.git.mchehab@kernel.org>
References: <cover.1657565224.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions seem to have been renamed without updating the kernel-doc
markup causing warnings. Also, struct intel_vgpu_dmabuf_obj is not
properly documented, but has a kerneld-doc markup.

Fix those warnings:
	drivers/gpu/drm/i915/gvt/aperture_gm.c:308: warning: expecting prototype for inte_gvt_free_vgpu_resource(). Prototype was for intel_vgpu_free_resource() instead
	drivers/gpu/drm/i915/gvt/aperture_gm.c:344: warning: expecting prototype for intel_alloc_vgpu_resource(). Prototype was for intel_vgpu_alloc_resource() instead
	drivers/gpu/drm/i915/gvt/cfg_space.c:257: warning: expecting prototype for intel_vgpu_emulate_cfg_read(). Prototype was for intel_vgpu_emulate_cfg_write() instead
	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or member 'vgpu' not described in 'intel_vgpu_dmabuf_obj'
	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or member 'info' not described in 'intel_vgpu_dmabuf_obj'
	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or member 'dmabuf_id' not described in 'intel_vgpu_dmabuf_obj'
	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or member 'kref' not described in 'intel_vgpu_dmabuf_obj'
	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or member 'initref' not described in 'intel_vgpu_dmabuf_obj'
	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or member 'list' not described in 'intel_vgpu_dmabuf_obj'
	drivers/gpu/drm/i915/gvt/handlers.c:3066: warning: expecting prototype for intel_t_default_mmio_write(). Prototype was for intel_vgpu_default_mmio_write() instead
	drivers/gpu/drm/i915/gvt/mmio_context.c:560: warning: expecting prototype for intel_gvt_switch_render_mmio(). Prototype was for intel_gvt_switch_mmio() instead
	drivers/gpu/drm/i915/gvt/page_track.c:131: warning: expecting prototype for intel_vgpu_enable_page_track(). Prototype was for intel_vgpu_disable_page_track() instead
	drivers/gpu/drm/i915/gvt/vgpu.c:215: warning: expecting prototype for intel_gvt_active_vgpu(). Prototype was for intel_gvt_activate_vgpu() instead
	drivers/gpu/drm/i915/gvt/vgpu.c:230: warning: expecting prototype for intel_gvt_deactive_vgpu(). Prototype was for intel_gvt_deactivate_vgpu() instead
	drivers/gpu/drm/i915/gvt/vgpu.c:358: warning: expecting prototype for intel_gvt_destroy_vgpu(). Prototype was for intel_gvt_destroy_idle_vgpu() instead

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gvt/aperture_gm.c  | 4 ++--
 drivers/gpu/drm/i915/gvt/cfg_space.c    | 2 +-
 drivers/gpu/drm/i915/gvt/dmabuf.h       | 2 +-
 drivers/gpu/drm/i915/gvt/handlers.c     | 2 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c | 2 +-
 drivers/gpu/drm/i915/gvt/page_track.c   | 2 +-
 drivers/gpu/drm/i915/gvt/vgpu.c         | 6 +++---
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/aperture_gm.c b/drivers/gpu/drm/i915/gvt/aperture_gm.c
index 557f3314291a..c6498414a0cc 100644
--- a/drivers/gpu/drm/i915/gvt/aperture_gm.c
+++ b/drivers/gpu/drm/i915/gvt/aperture_gm.c
@@ -298,7 +298,7 @@ static int alloc_resource(struct intel_vgpu *vgpu,
 }
 
 /**
- * inte_gvt_free_vgpu_resource - free HW resource owned by a vGPU
+ * intel_vgpu_free_resource - free HW resource owned by a vGPU
  * @vgpu: a vGPU
  *
  * This function is used to free the HW resource owned by a vGPU.
@@ -328,7 +328,7 @@ void intel_vgpu_reset_resource(struct intel_vgpu *vgpu)
 }
 
 /**
- * intel_alloc_vgpu_resource - allocate HW resource for a vGPU
+ * intel_vgpu_alloc_resource - allocate HW resource for a vGPU
  * @vgpu: vGPU
  * @param: vGPU creation params
  *
diff --git a/drivers/gpu/drm/i915/gvt/cfg_space.c b/drivers/gpu/drm/i915/gvt/cfg_space.c
index dad3a6054335..a0fc6d356588 100644
--- a/drivers/gpu/drm/i915/gvt/cfg_space.c
+++ b/drivers/gpu/drm/i915/gvt/cfg_space.c
@@ -243,7 +243,7 @@ static void emulate_pci_bar_write(struct intel_vgpu *vgpu, unsigned int offset,
 }
 
 /**
- * intel_vgpu_emulate_cfg_read - emulate vGPU configuration space write
+ * intel_vgpu_emulate_cfg_write - emulate vGPU configuration space write
  * @vgpu: target vgpu
  * @offset: offset
  * @p_data: write data ptr
diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.h b/drivers/gpu/drm/i915/gvt/dmabuf.h
index 5f8f03fb1d1b..3dcdb6570eda 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.h
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.h
@@ -48,7 +48,7 @@ struct intel_vgpu_fb_info {
 	struct intel_vgpu_dmabuf_obj *obj;
 };
 
-/**
+/*
  * struct intel_vgpu_dmabuf_obj- Intel vGPU device buffer object
  */
 struct intel_vgpu_dmabuf_obj {
diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index beea5895e499..aa0216fb1ab3 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -3052,7 +3052,7 @@ int intel_vgpu_default_mmio_read(struct intel_vgpu *vgpu, unsigned int offset,
 }
 
 /**
- * intel_t_default_mmio_write - default MMIO write handler
+ * intel_vgpu_default_mmio_write - default MMIO write handler
  * @vgpu: a vGPU
  * @offset: access offset
  * @p_data: write data buffer
diff --git a/drivers/gpu/drm/i915/gvt/mmio_context.c b/drivers/gpu/drm/i915/gvt/mmio_context.c
index c85bafe7539e..1c6e941c9666 100644
--- a/drivers/gpu/drm/i915/gvt/mmio_context.c
+++ b/drivers/gpu/drm/i915/gvt/mmio_context.c
@@ -546,7 +546,7 @@ static void switch_mmio(struct intel_vgpu *pre,
 }
 
 /**
- * intel_gvt_switch_render_mmio - switch mmio context of specific engine
+ * intel_gvt_switch_mmio - switch mmio context of specific engine
  * @pre: the last vGPU that own the engine
  * @next: the vGPU to switch to
  * @engine: the engine
diff --git a/drivers/gpu/drm/i915/gvt/page_track.c b/drivers/gpu/drm/i915/gvt/page_track.c
index 3375b51c75f1..df34e73cba41 100644
--- a/drivers/gpu/drm/i915/gvt/page_track.c
+++ b/drivers/gpu/drm/i915/gvt/page_track.c
@@ -120,7 +120,7 @@ int intel_vgpu_enable_page_track(struct intel_vgpu *vgpu, unsigned long gfn)
 }
 
 /**
- * intel_vgpu_enable_page_track - cancel write-protection on guest page
+ * intel_vgpu_disable_page_track - cancel write-protection on guest page
  * @vgpu: a vGPU
  * @gfn: the gfn of guest page
  *
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 46da19b3225d..8e71cda19995 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -205,7 +205,7 @@ static void intel_gvt_update_vgpu_types(struct intel_gvt *gvt)
 }
 
 /**
- * intel_gvt_active_vgpu - activate a virtual GPU
+ * intel_gvt_activate_vgpu - activate a virtual GPU
  * @vgpu: virtual GPU
  *
  * This function is called when user wants to activate a virtual GPU.
@@ -219,7 +219,7 @@ void intel_gvt_activate_vgpu(struct intel_vgpu *vgpu)
 }
 
 /**
- * intel_gvt_deactive_vgpu - deactivate a virtual GPU
+ * intel_gvt_deactivate_vgpu - deactivate a virtual GPU
  * @vgpu: virtual GPU
  *
  * This function is called when user wants to deactivate a virtual GPU.
@@ -348,7 +348,7 @@ struct intel_vgpu *intel_gvt_create_idle_vgpu(struct intel_gvt *gvt)
 }
 
 /**
- * intel_gvt_destroy_vgpu - destroy an idle virtual GPU
+ * intel_gvt_destroy_idle_vgpu - destroy an idle virtual GPU
  * @vgpu: virtual GPU
  *
  * This function is called when user wants to destroy an idle virtual GPU.
-- 
2.36.1

