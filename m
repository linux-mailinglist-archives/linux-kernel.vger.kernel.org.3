Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0895732C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiGMJa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiGMJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C268F2E21;
        Wed, 13 Jul 2022 02:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 029CF61CC6;
        Wed, 13 Jul 2022 09:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57719C385A5;
        Wed, 13 Jul 2022 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657704622;
        bh=KEI5HMlpCOrMUecDm6ehTcV2JBjxp5VNyS4qBhBdw24=;
        h=From:To:Cc:Subject:Date:From;
        b=bBIJjsCGdafvwdRqD7Ea6g4x6iQyquNNjsn/HU14xKgcfVBdbtzmt3ttMITOCWE4k
         kuyGNFByCAJ2IuVrolN9ECMO8KxNbvOaXOh5nO4Mqv/7bqyvPC3pykJeqi38LzkaTP
         3pM5IwwwCBGOHUaAgiXIO5bDu5pIDE1nduCs9VYO3l8IYKdbru1VxvSOF1rmqQS1kl
         9paq/s89MRM8P5LbDtFhAnEPRIdstpfDBPb6/zJBrSMyLDAOsxAV9bpmxu46xSdpmN
         GFOVs5gL99v0ASPLRxzcTvZfV+pbRXrK7pkmQUZqsbWycTsutJ8/7znxbqp90QIOE+
         vFhV8xixrMc3w==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBYhH-0050L9-Fb;
        Wed, 13 Jul 2022 10:30:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Abdiel Janulgue <abdiel.janulgue@linux.intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Ayaz A Siddiqui <ayaz.siddiqui@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Casey Bowman <casey.g.bowman@intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        John Harrison <John.C.Harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matt Atwood <matthew.s.atwood@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Michael Cheng <michael.cheng@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 00/21] Fix performance regressions with TLB and add GuC support
Date:   Wed, 13 Jul 2022 10:29:57 +0100
Message-Id: <cover.1657703926.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

TLB invalidation is a slow operation. It should not be doing lightly, as it
causes performance regressions, like this:

[178.821002] i915 0000:00:02.0: [drm] *ERROR* rcs0 TLB invalidation did not complete in 4ms!

This series contain 

1) some patches that makes TLB invalidation to happen only on
active, non-wedged engines, doing cache invalidation in batch 
and only when GT objects are exposed to userspace:

  drm/i915/gt: Ignore TLB invalidations on idle engines
  drm/i915/gt: Only invalidate TLBs exposed to user manipulation
  drm/i915/gt: Skip TLB invalidations once wedged
  drm/i915/gt: Batch TLB invalidations
  drm/i915/gt: Move TLB invalidation to its own file

2) It fixes two bugs, being the first a workaround:

  drm/i915/gt: Invalidate TLB of the OA unit at TLB invalidations
  drm/i915: Invalidate the TLBs on each GT

  drm/i915/guc: Introduce TLB_INVALIDATION_ALL action

3) It adds GuC support. Besides providing TLB invalidation on some
additional hardware, this should also help serializing GuC operations
with TLB invalidation:

  drm/i915/guc: Introduce TLB_INVALIDATION_ALL action
  drm/i915/guc: Define CTB based TLB invalidation routines
  drm/i915: Add platform macro for selective tlb flush
  drm/i915: Define GuC Based TLB invalidation routines
  drm/i915: Add generic interface for tlb invalidation for XeHP
  drm/i915: Use selective tlb invalidations where supported

4) It adds the corresponding kernel-doc markups for the kAPI
used for TLB invalidation.

While I could have split this into smaller pieces, I'm opting to send
them altogether, in order for CI trybot to better verify what issues
will be closed with this series.

---

Chris Wilson (7):
  drm/i915/gt: Ignore TLB invalidations on idle engines
  drm/i915/gt: Invalidate TLB of the OA unit at TLB invalidations
  drm/i915/gt: Only invalidate TLBs exposed to user manipulation
  drm/i915/gt: Skip TLB invalidations once wedged
  drm/i915/gt: Batch TLB invalidations
  drm/i915/gt: Move TLB invalidation to its own file
  drm/i915: Invalidate the TLBs on each GT

Mauro Carvalho Chehab (8):
  drm/i915/gt: document with_intel_gt_pm_if_awake()
  drm/i915/gt: describe the new tlb parameter at i915_vma_resource
  drm/i915/guc: use kernel-doc for enum intel_guc_tlb_inval_mode
  drm/i915/guc: document the TLB invalidation struct members
  drm/i915: document tlb field at struct drm_i915_gem_object
  drm/i915/gt: document TLB cache invalidation functions
  drm/i915/guc: describe enum intel_guc_tlb_invalidation_type
  drm/i915/guc: document TLB cache invalidation functions

Piotr Piórkowski (1):
  drm/i915/guc: Introduce TLB_INVALIDATION_ALL action

Prathap Kumar Valsan (5):
  drm/i915/guc: Define CTB based TLB invalidation routines
  drm/i915: Add platform macro for selective tlb flush
  drm/i915: Define GuC Based TLB invalidation routines
  drm/i915: Add generic interface for tlb invalidation for XeHP
  drm/i915: Use selective tlb invalidations where supported

 drivers/gpu/drm/i915/Makefile                 |   1 +
 .../gpu/drm/i915/gem/i915_gem_object_types.h  |   6 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     |  28 +-
 drivers/gpu/drm/i915/gt/intel_engine.h        |   1 +
 drivers/gpu/drm/i915/gt/intel_gt.c            | 125 +-------
 drivers/gpu/drm/i915/gt/intel_gt.h            |   2 -
 .../gpu/drm/i915/gt/intel_gt_buffer_pool.h    |   3 +-
 drivers/gpu/drm/i915/gt/intel_gt_defines.h    |  11 +
 drivers/gpu/drm/i915/gt/intel_gt_pm.h         |  10 +
 drivers/gpu/drm/i915/gt/intel_gt_regs.h       |   8 +
 drivers/gpu/drm/i915/gt/intel_gt_types.h      |  22 +-
 drivers/gpu/drm/i915/gt/intel_ppgtt.c         |   8 +-
 drivers/gpu/drm/i915/gt/intel_tlb.c           | 295 ++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_tlb.h           |  30 ++
 .../gpu/drm/i915/gt/uc/abi/guc_actions_abi.h  |  54 ++++
 drivers/gpu/drm/i915/gt/uc/intel_guc.c        | 232 ++++++++++++++
 drivers/gpu/drm/i915/gt/uc/intel_guc.h        |  36 +++
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c     |  24 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_fwif.h   |   9 +
 .../gpu/drm/i915/gt/uc/intel_guc_submission.c |  91 +++++-
 drivers/gpu/drm/i915/i915_drv.h               |   4 +-
 drivers/gpu/drm/i915/i915_pci.c               |   1 +
 drivers/gpu/drm/i915/i915_vma.c               |  46 ++-
 drivers/gpu/drm/i915/i915_vma.h               |   2 +
 drivers/gpu/drm/i915/i915_vma_resource.c      |   9 +-
 drivers/gpu/drm/i915/i915_vma_resource.h      |   6 +-
 drivers/gpu/drm/i915/intel_device_info.h      |   1 +
 27 files changed, 910 insertions(+), 155 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_defines.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_tlb.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_tlb.h

-- 
2.36.1


