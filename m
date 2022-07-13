Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED5E573058
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiGMINY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiGMIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF11E95F8;
        Wed, 13 Jul 2022 01:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97FAA61A07;
        Wed, 13 Jul 2022 08:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10151C385A9;
        Wed, 13 Jul 2022 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=bUgQ4agLKlwNmGshtaEDNrxPp1+CT766uFeo5h9OE+s=;
        h=From:To:Cc:Subject:Date:From;
        b=LrpndDZ/qEnaIBDExfZzqcvwWZqnpmU3h7UGjJKsVZ50yh2ym5L5FQrM4Ks7AvT3r
         rskr3bJZQ5t3yUj/XRKBHRAh3Dq5Usm4zGFEQKPBTZ+aC+mQcNiixckz3P49LDY/hb
         oSbXv972pKS2eajTaWJA5rRvEEdOH1FBnY3YKre7uEGbXj3M2RjiVK4zrOTYHHtTvJ
         G5D1Q9gXQzJHnHOVGMZTo/CXWvvOLL2x7Qm2hZdqccLPWYTNx3TyPr9yYmf1cMaPwL
         1kouMRK8iXb4DaCjc3+YBwF/YppInz2qxwNyMq8Vy7+qpV9O7HvLEnOgWZHAiRxmAo
         mUzXaKshyBlsQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004zsV-9a;
        Wed, 13 Jul 2022 09:12:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/39] drm/i915: fix kernel-doc issues
Date:   Wed, 13 Jul 2022 09:11:48 +0100
Message-Id: <cover.1657699522.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
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

There are several kernel-doc markups along the i915 driver that aren't part
of the i915.rst file, nor are included on any other file under Documentation.
Maybe due to that, there are several kernel-doc markups that report problems
when checked with scripts/kernel-doc. More than that, some of them also
have problems when actually integrated at the building system, as reported
by Sphinx.

Along the issues we have:

- renamed symbols where the prototype doesn't match the kernel-doc name;
- some markups doesn't have the symbol name on it;
- typos when defining parameter;
- some parameters are missing;
- some ascii artwork aren't properly displayed after parsed by Sphinx;
- some other tags produce bad results and warnings after parsed by html build;
- some "/**" patterns exist on places that aren't kernel-doc markups.

This series, against drm-tip, fix all the above issues and all all such files to
i915.rst. This way, it will be easier to avoid other problems to be introduced.

While here, I also added SPDX on two display files. Besides being the current
way to indicate the license, it also makes easier to find all files with kernel-doc
markups, as all it is needed is to search for "/**" at i915 files to know what of
them have embedded documentation.

PS.: my end goal here is to ensure that the TLB patch series I'm about to
send will be properly documented. For that to happen, let's first fix all
warnings when building the documentation ;-)

---

v2:
- Added 3 already-existing patches form other PRs addressing some of the
  issues. The subjects were renamed, in order to describe what they're
  doing.
- Fixed checkpatch warnings;
- Added 4 additional patches at the end, documenting some structs
  at i915_gem_object_types.h and  intel_gt_pm.h, plus adding 
  intel-guc.c internal functions to the generated documentation.

Jiapeng Chong (3):
  drm/i915/gvt: Fix kernel-doc for intel_gvt_switch_mmio()
  drm/i915/gvt: Fix kernel-doc for intel_vgpu_default_mmio_write
  drm/i915/gvt: Fix kernel-doc for intel_vgpu_*_resource()

Mauro Carvalho Chehab (36):
  drm/i915: fix kernel-doc trivial warnings on i915/*.[ch] files
  drm/i915: display: fix kernel-doc markup warnings
  drm/i915: gt: fix some Kernel-doc issues
  drm/i915: gvt: fix kernel-doc trivial warnings
  drm/i915: gem: fix some Kernel-doc issues
  drm/i915: intel_wakeref.h: fix some kernel-doc markups
  drm/i915: i915_gem_ttm: fix a kernel-doc markup
  drm/i915: i915_gem_ttm_pm.c: fix kernel-doc markups
  drm/i915: gem: add kernel-doc description for some function parameters
  drm/i915: i915_gpu_error.c: document dump_flags
  drm/i915: document kernel-doc trivial issues
  drm/i915: intel_dp_link_training.c: fix kernel-doc markup
  drm/i915: intel_fb: fix a kernel-doc issue with Sphinx
  drm/i915: skl_scaler: fix return value kernel-doc markup
  drm/i915: intel_pm.c: fix some ascii artwork at kernel-doc
  drm/i915: i915_gem_region.h: fix i915_gem_apply_to_region_ops doc
  drm/i915: i915_gem_wait.c: fix a kernel-doc markup
  drm/i915: fix i915_gem_ttm_move.c DOC: markup
  drm/i915: stop using kernel-doc markups for something else
  drm/i915: dvo_ch7xxx.c: use SPDX header
  drm/i915: dvo_sil164.c: use SPDX header
  drm/i915: i915_vma_resource.c: fix some kernel-doc markups
  drm/i915: i915_gem.c fix a kernel-doc issue
  drm/i915: i915_scatterlist.h: fix some kernel-doc markups
  drm/i915: i915_deps: use a shorter title markup
  docs: gpu: i915.rst: display: add kernel-doc markups
  docs: gpu: i915.rst: gt: add more kernel-doc markups
  docs: gpu: i915.rst: GuC: add more kernel-doc markups
  docs: gpu: i915.rst: GVT: add more kernel-doc markups
  docs: gpu: i915.rst: PM: add more kernel-doc markups
  docs: gpu: i915.rst: GEM/TTM: add more kernel-doc markups
  docs: gpu: i915.rst: add the remaining kernel-doc markup files
  drm/i915 i915_gem_object_types.h: document struct i915_lut_handle
  drm/i915: document struct drm_i915_gem_object
  drm/i915: add descriptions for some RPM macros at intel_gt_pm.h
  drm/i915: add GuC functions to the documentation

 Documentation/gpu/i915.rst                    | 288 ++++++++++++++++++
 drivers/gpu/drm/i915/display/dvo_ch7017.c     |  26 +-
 drivers/gpu/drm/i915/display/dvo_ch7xxx.c     |  39 +--
 drivers/gpu/drm/i915/display/dvo_sil164.c     |  32 +-
 .../drm/i915/display/intel_display_debugfs.c  |   2 +-
 .../drm/i915/display/intel_display_power.c    |   2 +-
 .../drm/i915/display/intel_display_types.h    |   2 +-
 .../drm/i915/display/intel_dp_link_training.c |   2 +
 drivers/gpu/drm/i915/display/intel_dvo_dev.h  |   6 +-
 drivers/gpu/drm/i915/display/intel_fb.c       |   2 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c     |   4 +-
 drivers/gpu/drm/i915/display/intel_tc.c       |   2 +-
 drivers/gpu/drm/i915/display/intel_tv.c       |   2 +-
 drivers/gpu/drm/i915/display/skl_scaler.c     |   6 +-
 drivers/gpu/drm/i915/gem/i915_gem_create.c    |   8 +-
 drivers/gpu/drm/i915/gem/i915_gem_domain.c    |  17 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c    |   2 +
 drivers/gpu/drm/i915/gem/i915_gem_object.h    |   2 +-
 .../gpu/drm/i915/gem/i915_gem_object_types.h  | 212 ++++++++++---
 drivers/gpu/drm/i915/gem/i915_gem_region.h    |   8 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c       |   2 +
 drivers/gpu/drm/i915/gem/i915_gem_ttm.h       |   1 +
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c  |   4 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c    |   8 +-
 drivers/gpu/drm/i915/gem/i915_gem_wait.c      |  26 +-
 drivers/gpu/drm/i915/gt/intel_context.h       |   6 +-
 drivers/gpu/drm/i915/gt/intel_context_types.h |  63 ++--
 drivers/gpu/drm/i915/gt/intel_engine_cs.c     |   4 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h  |   1 +
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.h  |   2 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.h         |  62 ++++
 drivers/gpu/drm/i915/gt/intel_gt_types.h      |  12 +-
 drivers/gpu/drm/i915/gt/intel_gtt.h           |   6 +-
 drivers/gpu/drm/i915/gt/intel_reset_types.h   |   4 +-
 drivers/gpu/drm/i915/gt/intel_rps.c           |   4 +-
 .../gpu/drm/i915/gt/intel_timeline_types.h    |   6 +-
 .../drm/i915/gt/shaders/clear_kernel/hsw.asm  |   4 +-
 .../drm/i915/gt/shaders/clear_kernel/ivb.asm  |   4 +-
 drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h |  24 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_fwif.h   |   2 +-
 .../gpu/drm/i915/gt/uc/intel_guc_hwconfig.c   |   5 +-
 drivers/gpu/drm/i915/gvt/aperture_gm.c        |   4 +-
 drivers/gpu/drm/i915/gvt/cfg_space.c          |   2 +-
 drivers/gpu/drm/i915/gvt/dmabuf.h             |   2 +-
 drivers/gpu/drm/i915/gvt/handlers.c           |   2 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c       |   2 +-
 drivers/gpu/drm/i915/gvt/page_track.c         |   2 +-
 drivers/gpu/drm/i915/gvt/vgpu.c               |   6 +-
 drivers/gpu/drm/i915/i915_active.h            |  14 +-
 drivers/gpu/drm/i915/i915_deps.c              |   4 +-
 drivers/gpu/drm/i915/i915_drm_client.h        |   2 +-
 drivers/gpu/drm/i915/i915_drv.h               |  30 +-
 drivers/gpu/drm/i915/i915_file_private.h      |   8 +-
 drivers/gpu/drm/i915/i915_gem.c               |  12 +-
 drivers/gpu/drm/i915/i915_gpu_error.c         |   3 +-
 drivers/gpu/drm/i915/i915_gpu_error.h         |   4 +-
 drivers/gpu/drm/i915/i915_pmu.h               |  38 +--
 drivers/gpu/drm/i915/i915_request.h           |   4 +-
 drivers/gpu/drm/i915/i915_scatterlist.c       |   2 +-
 drivers/gpu/drm/i915/i915_scatterlist.h       |  12 +-
 drivers/gpu/drm/i915/i915_utils.h             |   2 +-
 drivers/gpu/drm/i915/i915_vma.c               |   2 +
 drivers/gpu/drm/i915/i915_vma_resource.c      |   4 +-
 drivers/gpu/drm/i915/i915_vma_resource.h      |   3 +-
 drivers/gpu/drm/i915/intel_pm.c               |  33 +-
 drivers/gpu/drm/i915/intel_region_ttm.c       |   3 +-
 drivers/gpu/drm/i915/intel_uncore.h           |   4 +-
 drivers/gpu/drm/i915/intel_wakeref.h          |   4 +-
 68 files changed, 795 insertions(+), 327 deletions(-)

-- 
2.36.1


