Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB6A5957CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiHPKPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiHPKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:14:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17346D6318
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660642658; x=1692178658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I+l1Yy0Jsg/6z3gHEU6yDZymdLIl3LFJwl5JDwIrv3I=;
  b=criNiMvr4Fkj2YQEqigrO3iuFlq3f8e6oKWKZwEIti7l0XdymUTO0ADF
   1/zigUu/cfKb86MFP+u/R3LQ6WG6xNT/KEruinCaDjJyKzK6ihlzJCs/d
   DVMDqrLx31/MBLdItTpSOVnNxbHGSom8Sel35BoMfL45GoJMaT/pYo6fs
   NTPxx/THNaibPv+6QVkj8wXq1Gp60eg224DarbQRa3+qHbAZR4tMprxdI
   D09lQzdVlGDj1vtNXjI+au6Wn5CI4SUrbKa96ROO4HXYqJUtEOuh4/Biy
   Uy6a0A5dmEE69AmkOiTBfH1K26YhRlRYma7vEhvDXEjpasgzpxYfqm/RZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293446786"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="293446786"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:35:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="733231012"
Received: from clbarnes-mobl.amr.corp.intel.com (HELO paris.amr.corp.intel.com) ([10.254.7.166])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:35:40 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@linux.ie,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com
Subject: [PATCH v7 0/8] Fixes integer overflow or integer truncation issues in page lookups, ttm place configuration and scatterlist creation
Date:   Tue, 16 Aug 2022 18:35:17 +0900
Message-Id: <20220816093525.184940-1-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes integer overflow or integer truncation issues in
page lookups, ttm place configuration and scatterlist creation, etc.
We need to check that we avoid integer overflows when looking up a page,
and so fix all the instances where we have mistakenly used a plain integer
instead of a more suitable long.
And there is an impedance mismatch between the scatterlist API using
unsigned int and our memory/page accounting in unsigned long. That is we
may try to create a scatterlist for a large object that overflows returning
a small table into which we try to fit very many pages. As the object size
is under the control of userspace, we have to be prudent and catch the
conversion errors. To catch the implicit truncation as we switch from
unsigned long into the scatterlist's unsigned int, we use our overflows_type
check and report E2BIG prior to the operation. This is already used in
our create ioctls to indicate if the uABI request is simply too large for
the backing store. 
And ttm place also has the same problem with scatterlist creation,
and we fix the integer truncation problem with the way approached by
scatterlist creation.
And It corrects the error code to return -E2BIG when creating gem objects
using ttm or shmem, if the size is too large in each case.
In order to provide a common macro, it moves and adds a few utility macros
into overflow/util_macros header

v7: Fix to use WARN_ON() macro where GEM_BUG_ON() macro was used. (Jani)
v6: Move macro addition location so that it can be used by other than drm subsystem (Jani, Mauro, Andi)
    Fix to follow general use case for GEM_BUG_ON(). (Jani)
v5: Fix an alignment to match open parenthesis
    Fix macros to be enclosed in parentheses for complex values
    Fix too long line warning
v4: Fix build warnins that reported by kernel test robot. (kernel test robot <lkp@intel.com>)
    Add kernel-doc markups to the kAPI functions and macros (Mauoro)
v3: Modify overflows_type() macro to consider signed data types and
	add is_type_unsigned() macro (Mauro)
    Make not use the same macro name on a function. (Mauro)
    For kernel-doc, macros and functions are handled in the same namespace,
    the same macro name on a function prevents ever adding documentation for it.
    Not to change execution inside a macro. (Mauro)
    Fix the problem that safe_conversion() macro always returns true (G.G)
    Add safe_conversion_gem_bug_on() macro and remove temporal SAFE_CONVERSION() macro. (G.G.)

Chris Wilson (3):
  drm/i915/gem: Typecheck page lookups
  drm/i915: Check for integer truncation on scatterlist creation
  drm/i915: Remove truncation warning for large objects

Gwan-gyeong Mun (5):
  overflow: Move and add few utility macros into overflow
  util_macros: Add exact_type macro to catch type mis-match while
    compiling
  drm/i915: Check for integer truncation on the configuration of ttm
    place
  drm/i915: Check if the size is too big while creating shmem file
  drm/i915: Use error code as -E2BIG when the size of gem ttm object is
    too large

 drivers/gpu/drm/i915/gem/i915_gem_internal.c  |   6 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c    |   7 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h    | 303 +++++++++++++++---
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     |  27 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c      |   4 +
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c     |  19 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c       |  23 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |   5 +-
 .../drm/i915/gem/selftests/i915_gem_context.c |  12 +-
 .../drm/i915/gem/selftests/i915_gem_mman.c    |   8 +-
 .../drm/i915/gem/selftests/i915_gem_object.c  |   8 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c             |   9 +-
 drivers/gpu/drm/i915/i915_gem.c               |  18 +-
 drivers/gpu/drm/i915/i915_scatterlist.h       |  11 +
 drivers/gpu/drm/i915/i915_utils.h             |   6 +-
 drivers/gpu/drm/i915/i915_vma.c               |   8 +-
 drivers/gpu/drm/i915/intel_region_ttm.c       |  17 +-
 include/linux/overflow.h                      |  54 ++++
 include/linux/util_macros.h                   |  25 ++
 19 files changed, 477 insertions(+), 93 deletions(-)

-- 
2.37.1

