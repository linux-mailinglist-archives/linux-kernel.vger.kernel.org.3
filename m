Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32CB54CCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbiFOPaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355419AbiFOP2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BC929379
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 466D96172D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC96C3411E;
        Wed, 15 Jun 2022 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655306866;
        bh=za6XXTXlSO5nrJLYy1rtvLJPylpkekf8kTgLIY5cAts=;
        h=From:To:Cc:Subject:Date:From;
        b=cARUWPwSj3OREgsOA5jp6Q6lZIrXQOTUxGJKDSiCSwiW3GZNOyb8zjF0o1L+83oWA
         O+h8HaQxKFQezSv6vLQedS41KF+H0o+YLTFl78wlbzXnHfRkF0QCKGvK8N//LROjtU
         dQb2+swSxqDdQ0d2xDqlahKFVR6TUvfk9+/6PbSb4WyvsFX3NnIxXL+H2i+x7eYJcA
         Imv01jXfonh8Xda27c5WVi0malHtrOcYWW94sA8y8piLFIJvEMsZKoH7hwESd8qQY8
         JcT6ziT2UQdBfkiNRauRdngekgfilwuqyIHzYy3NoXTq88KZjByvBzljCEs8Dw4184
         izBQuxjI8S3LA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o1Uvm-00A4Ja-AR;
        Wed, 15 Jun 2022 16:27:42 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chris Wilson <chris.p.wilson@intel.com>,
        tvrtko.ursulin@linux.intel.com, Fei Yang <fei.yang@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        mauro.chehab@linux.intel.com,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Bruce Chang <yu.bruce.chang@intel.com>,
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
        Matt Roper <matthew.d.roper@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Fix TLB invalidate issues with Broadwell
Date:   Wed, 15 Jun 2022 16:27:34 +0100
Message-Id: <cover.1655306128.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i915 selftest hangcheck is causing the i915 driver timeouts, as reported
by Intel CI bot:

	http://gfx-ci.fi.intel.com/cibuglog-ng/issuefilterassoc/24297?query_key=42a999f48fa6ecce068bc8126c069be7c31153b4

When such test runs, the only output is:

	[   68.811639] i915: Performing live selftests with st_random_seed=0xe138eac7 st_timeout=500
	[   68.811792] i915: Running hangcheck
	[   68.811859] i915: Running intel_hangcheck_live_selftests/igt_hang_sanitycheck
	[   68.816910] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
	[   68.841597] i915: Running intel_hangcheck_live_selftests/igt_reset_nop
	[   69.346347] igt_reset_nop: 80 resets
	[   69.362695] i915: Running intel_hangcheck_live_selftests/igt_reset_nop_engine
	[   69.863559] igt_reset_nop_engine(rcs0): 709 resets
	[   70.364924] igt_reset_nop_engine(bcs0): 903 resets
	[   70.866005] igt_reset_nop_engine(vcs0): 659 resets
	[   71.367934] igt_reset_nop_engine(vcs1): 549 resets
	[   71.869259] igt_reset_nop_engine(vecs0): 553 resets
	[   71.882592] i915: Running intel_hangcheck_live_selftests/igt_reset_idle_engine
	[   72.383554] rcs0: Completed 16605 idle resets
	[   72.884599] bcs0: Completed 18641 idle resets
	[   73.385592] vcs0: Completed 17517 idle resets
	[   73.886658] vcs1: Completed 15474 idle resets
	[   74.387600] vecs0: Completed 17983 idle resets
	[   74.387667] i915: Running intel_hangcheck_live_selftests/igt_reset_active_engine
	[   74.889017] rcs0: Completed 747 active resets
	[   75.174240] intel_engine_reset(bcs0) failed, err:-110
	[   75.174301] bcs0: Completed 525 active resets

After that, the machine just silently hangs.

Bisecting the issue, the patch that introduced the regression is:

    7938d61591d3 ("drm/i915: Flush TLBs before releasing backing store")

Reverting it fix the issues, but introduce other problems, as TLB
won't be invalidated anymore. So, instead, let's fix the root cause.

It turns that the TLB flush logic ends conflicting with i915 reset,
which is called during selftest hangcheck. So, the TLB cache should
be serialized, but other TLB fix patches are required for this one
to work.

Tested on an Intel NUC5i7RYB with an i7-5557U Broadwell CPU.

Chris Wilson (6):
  drm/i915/gt: Ignore TLB invalidations on idle engines
  drm/i915/gt: Invalidate TLB of the OA unit at TLB invalidations
  drm/i915/gt: Skip TLB invalidations once wedged
  drm/i915/gt: Only invalidate TLBs exposed to user manipulation
  drm/i915/gt: Serialize GRDOM access between multiple engine resets
  drm/i915/gt: Serialize TLB invalidates with GT resets

 drivers/gpu/drm/i915/gem/i915_gem_pages.c | 10 +++---
 drivers/gpu/drm/i915/gt/intel_gt.c        | 43 +++++++++++++++++++----
 drivers/gpu/drm/i915/gt/intel_gt_pm.h     |  3 ++
 drivers/gpu/drm/i915/gt/intel_reset.c     | 37 ++++++++++++++-----
 drivers/gpu/drm/i915/i915_vma.c           |  3 +-
 5 files changed, 75 insertions(+), 21 deletions(-)

-- 
2.36.1


