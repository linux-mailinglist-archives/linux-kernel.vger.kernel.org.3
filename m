Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C585659A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbiGDPUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiGDPUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:20:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7885F57
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80491B810C2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 15:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C8EC3411E;
        Mon,  4 Jul 2022 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656948008;
        bh=D5q5Dno29GppKOQ4ew8H36+AhOTbVVxHP3lYtieRXwI=;
        h=From:To:Cc:Subject:Date:From;
        b=GuMul2XePRnR7RYnHMhIwS5z5XCiwMtSxgrtkQVCLbE28d+mb3262Ia/XdYoz2o4W
         bL3FUJYTLe69tzoox6yV0hdWPtIsiYVAOqMx/FjwYTJhlSlCJwmZFUuBWK6/iAGRKQ
         k5GjOCHStr1FGODKEhz5axE0dS7XoZwuVYkvKynbSfrMmW1fAgQ5CMZrDJPiWLFXOO
         HneDbpSK5A4nQEinuLvXAw2eAGIy8QW7ynTT1e0Zm61spMmUmpNJjcYxdFv41CCamn
         Uq9sBQX72T6B+K1m+LzLcWZEdQfNq7gIP+Lgr4rGUqERXFiDTL/D39mz3CVRjDhdTp
         yMNXR0E8J5K9Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o8Nro-009fKT-WA;
        Mon, 04 Jul 2022 16:20:05 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Fix TLB invalidate issues with Broadwell
Date:   Mon,  4 Jul 2022 16:20:02 +0100
Message-Id: <cover.1656921701.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
be serialized together with i915 reset.

Tested on an Intel NUC5i7RYB with an i7-5557U Broadwell CPU.

v3:
- Removed the logic that would check if the engine is awake before doing
  TLB flush invalidation as backporting PM logic up to Kernel 4.x could be
  too painful. After getting this one merged, I'll submit a separate patch
  with the PM awake logic.

v2:

- Reduced to bare minimum fixes, as this shoud be backported deeply
  into stable.


Chris Wilson (2):
  drm/i915/gt: Serialize GRDOM access between multiple engine resets
  drm/i915/gt: Serialize TLB invalidates with GT resets

 drivers/gpu/drm/i915/gt/intel_gt.c    | 15 ++++++++++-
 drivers/gpu/drm/i915/gt/intel_reset.c | 37 ++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 10 deletions(-)

-- 
2.36.1


