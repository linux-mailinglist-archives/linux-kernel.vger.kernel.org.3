Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64F584C53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiG2HEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiG2HEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DC02F39D;
        Fri, 29 Jul 2022 00:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F64861A15;
        Fri, 29 Jul 2022 07:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65564C433D7;
        Fri, 29 Jul 2022 07:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659078239;
        bh=fzCBMgJfZnLfcaUhqg9JhjJadviES9eqpXWT+njnHTg=;
        h=From:To:Cc:Subject:Date:From;
        b=Yyf+039YkXdBICHTs98ag+yEw6yF8QT8bAC4OODtkBlfhp67tCKgZ0MU0tvVTt3P7
         ztzi//nINQlNfrWF/sRHa9IbEpSr8xHs3szShKGlnKD4Xz+GlZJuL2podux/40S7O2
         rFAtudqi+0tdIV3mNkmc3BFMRyETo55M/BW1I/jdxu/k+Af2/lexXThSYjJ4HhFWtC
         K1LXYO7FQZVrvJKw+k0j6lgO7zEU3Fyrfl8/mKhqGproj2TD3rF9LvN05xkh1zdPRr
         YzRUBYS7UWan8d4R0g6R3WI67B3G6Br3q37o9b7fkn0Cmsmm8DwsjyZcZUbzCVg5BN
         MYmUuL6/R7E2w==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oHK2O-005nBq-Vd;
        Fri, 29 Jul 2022 09:03:56 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Move TLB invalidation code for its own file and document it
Date:   Fri, 29 Jul 2022 09:03:53 +0200
Message-Id: <cover.1659077372.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more things to be added to TLB invalidation. Before doing that,
move the code to its own file, and add the relevant documentation.

Patch 1 only moves the code and do some function renames. No functional
change.

Patch 2 adds documentation for the TLB invalidation algorithm and functions.

---

v2: only patch 2 (kernel-doc) was modified:

  - The kernel-doc markups for TLB were added to i915.rst doc;
  - Some minor fixes at the texts;
  - Use a table instead of a literal block while explaining how the algorithm works.
    That should make easier to understand the logic, both in text form and after
    its conversion to HTML/PDF;
  - Remove mention for GuC, as this depends on a series that will be sent later.

Chris Wilson (1):
  drm/i915/gt: Move TLB invalidation to its own file

Mauro Carvalho Chehab (1):
  drm/i915/gt: document TLB cache invalidation functions

 Documentation/gpu/i915.rst                |   7 +
 drivers/gpu/drm/i915/Makefile             |   1 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c |   4 +-
 drivers/gpu/drm/i915/gt/intel_gt.c        | 168 +----------------
 drivers/gpu/drm/i915/gt/intel_gt.h        |  12 --
 drivers/gpu/drm/i915/gt/intel_tlb.c       | 208 ++++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_tlb.h       | 130 ++++++++++++++
 drivers/gpu/drm/i915/i915_vma.c           |   1 +
 8 files changed, 352 insertions(+), 179 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_tlb.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_tlb.h

-- 
2.36.1


