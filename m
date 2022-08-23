Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476FB59E422
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiHWNVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbiHWNVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:21:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFE914358F
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661249995; x=1692785995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UOoUeBZGBezcH2/KZ3Ntl67gRI+FunItzjnXIPT1M5k=;
  b=XVQllFo5uDm7nUhUjPjuUeBQOZK2SnwcxMw7yWHGtgw1hIanVnkl5zsj
   7FBn+XW5mdaTeML8OHSWKiCUig8GCr9Xxqr9RT5gOHUq/4Rum6nL31SH/
   L4l2jI0oR2KI+sN2WBh/ovCnBlyPez/8710j6IPB8dUqoIn3Lot8vjzqI
   JRzwqC17JUWKXt8Wc/1pnwYHjf0ZzrGMP94mM4UFxsEQrB1IqHCQVjXOR
   MxoH8zjxGuOQPq+Pkblc+7qkqmk1xIGecbh3ZPKncnWen9C/LVAGkF9Kc
   mPpQiEH++I6ADOh4+g/DsPTgPM4yf4mIVYCXgdIh6YISVJHWb0r6irGBo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="357627018"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="357627018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 03:17:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="751639865"
Received: from jabish-mobl2.amr.corp.intel.com (HELO paris.amr.corp.intel.com) ([10.254.9.209])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 03:17:42 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@linux.ie,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com,
        intel-gfx-trybot@lists.freedesktop.org
Subject: [PATCH v8 0/8] Fixes integer overflow or integer truncation issues in page lookups, ttm place configuration and scatterlist creation
Date:   Tue, 23 Aug 2022 19:17:21 +0900
Message-Id: <20220823101729.2098841-1-gwan-gyeong.mun@intel.com>
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
unsigned long into the scatterlist's unsigned int, we use improved
overflows_type check and report E2BIG prior to the operation. This is
already used in our create ioctls to indicate if the uABI request is simply
too large for the backing store. 
And ttm place also has the same problem with scatterlist creation,
and we fix the integer truncation problem with the way approached by
scatterlist creation.
And It corrects the error code to return -E2BIG when creating gem objects
using ttm or shmem, if the size is too large in each case.
In order to provide a common macro, it moves and adds a few utility macros
into overflow/util_macros header

v8: Add check_assign() and remove safe_conversion() (Kees)
    Replace safe_conversion() with check_assign() (Kees)
    Fix overflows_type() to use gcc's built-in overflow function (Andrzej)
    Add overflows_ptr() to allow overflow checking when assigning a value
    into a pointer variable (G.G.)
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
 drivers/gpu/drm/i915/i915_user_extensions.c   |   2 +-
 drivers/gpu/drm/i915/i915_utils.h             |   6 +-
 drivers/gpu/drm/i915/i915_vma.c               |   8 +-
 drivers/gpu/drm/i915/intel_region_ttm.c       |  17 +-
 include/linux/overflow.h                      |  67 ++++
 include/linux/util_macros.h                   |  25 ++
 20 files changed, 491 insertions(+), 94 deletions(-)

-- 
2.37.1

