Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419B64BDC65
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377891AbiBUOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:34:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377872AbiBUOeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:34:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C79A1C116;
        Mon, 21 Feb 2022 06:33:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1654BB811C7;
        Mon, 21 Feb 2022 14:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27B4C340E9;
        Mon, 21 Feb 2022 14:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645454021;
        bh=MOKLyo7/CIj15UTSyuW2OgdaszN7jrsaNp5k1YPY3aE=;
        h=From:To:Cc:Subject:Date:From;
        b=uJF68NIcZywWr+dDWoAj52OBmNWOx64XPUk+mXZiEndyaMwIRzMKkA+e4U28CC9eq
         ez/lh5CXxMUiIct56BJw6x8vMIU+uof5pMiNMyuPftd5Ac5ZFdvaYSjeDaV+Qzt2jR
         tIxZMcE5RAzTeAG6E4Jw4b+Bjqm3Sz5f17Cle7+Q8D7OMmTN3pcptcBw9IswtuAqqQ
         IFM0MXCEPgJ2rEM9RhXXCuJywv1ICB+9IDoOaWGo75U5EhToqwCnd32Q9anVQwjrDi
         arAmdYdVZSW87OLP1wjynqpnUfs4HF305YoAO89GQ6Zi9OzsOuVZeWj3WeXvHsuhih
         BolyH1ymDSFnQ==
From:   broonie@kernel.org
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: linux-next: manual merge of the drm-intel-gt tree with the drm-intel tree
Date:   Mon, 21 Feb 2022 14:33:36 +0000
Message-Id: <20220221143337.3527550-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the drm-intel-gt tree got conflicts in:

  drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
  drivers/gpu/drm/i915/i915_drv.h
  drivers/gpu/drm/i915/i915_reg.h
  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c

between commits:

  b508d01fa577e ("drm/i915: split out i915_gem_internal.h from i915_drv.h")
  29b9702ffe70d ("drm/i915/ttm: Return some errors instead of trying memcpy move")
  9a8e720fd0641 ("drm/i915: split out gem/i915_gem_domain.h from i915_drv.h")
  b508d01fa577e ("drm/i915: split out i915_gem_internal.h from i915_drv.h")

from the drm-intel tree and commits:

  3526b607b0239 ("drm/i915/ttm: Return some errors instead of trying memcpy move")
  a413c99fc1e49 ("drm/i915: add gtt misalignment test")
  b508d01fa577e ("drm/i915: split out i915_gem_internal.h from i915_drv.h")

from the drm-intel-gt tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/i915/i915_drv.h
index ffde71b6b3f1f,6ffadf4b3f1ab..0000000000000
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@@ -1089,10 -1284,10 +1087,12 @@@ IS_SUBPLATFORM(const struct drm_i915_pr
  	IS_SUBPLATFORM(dev_priv, INTEL_DG2, INTEL_SUBPLATFORM_G10)
  #define IS_DG2_G11(dev_priv) \
  	IS_SUBPLATFORM(dev_priv, INTEL_DG2, INTEL_SUBPLATFORM_G11)
+ #define IS_DG2_G12(dev_priv) \
+ 	IS_SUBPLATFORM(dev_priv, INTEL_DG2, INTEL_SUBPLATFORM_G12)
  #define IS_ADLS_RPLS(dev_priv) \
  	IS_SUBPLATFORM(dev_priv, INTEL_ALDERLAKE_S, INTEL_SUBPLATFORM_RPL_S)
 +#define IS_ADLP_N(dev_priv) \
 +	IS_SUBPLATFORM(dev_priv, INTEL_ALDERLAKE_P, INTEL_SUBPLATFORM_N)
  #define IS_HSW_EARLY_SDV(dev_priv) (IS_HASWELL(dev_priv) && \
  				    (INTEL_DEVID(dev_priv) & 0xFF00) == 0x0C00)
  #define IS_BDW_ULT(dev_priv) \
diff --cc drivers/gpu/drm/i915/i915_reg.h
index 8e1b469a4cd1b,4b95c94084d98..0000000000000
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
diff --cc drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index 1b508c89468c1,ca4ed9dd909b8..0000000000000
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@@ -26,7 -26,7 +26,8 @@@
  #include <linux/prime_numbers.h>
  
  #include "gem/i915_gem_context.h"
 +#include "gem/i915_gem_internal.h"
+ #include "gem/i915_gem_region.h"
  #include "gem/selftests/mock_context.h"
  #include "gt/intel_context.h"
  #include "gt/intel_gpu_commands.h"
diff --git a/drivers/gpu/drm/i915/i915_gem_evict.h b/drivers/gpu/drm/i915/i915_gem_evict.h
index d4478b6ad11bb..b7f8e9435b2c6 100644
--- a/drivers/gpu/drm/i915/i915_gem_evict.h
+++ b/drivers/gpu/drm/i915/i915_gem_evict.h
@@ -12,13 +12,16 @@ struct drm_mm_node;
 struct i915_address_space;
 
 int __must_check i915_gem_evict_something(struct i915_address_space *vm,
+					  struct i915_gem_ww_ctx *ww,
 					  u64 min_size, u64 alignment,
 					  unsigned long color,
 					  u64 start, u64 end,
 					  unsigned flags);
 int __must_check i915_gem_evict_for_node(struct i915_address_space *vm,
+					 struct i915_gem_ww_ctx *ww,
 					 struct drm_mm_node *node,
 					 unsigned int flags);
-int i915_gem_evict_vm(struct i915_address_space *vm);
+int i915_gem_evict_vm(struct i915_address_space *vm,
+		      struct i915_gem_ww_ctx *ww);
 
 #endif /* __I915_GEM_EVICT_H__ */
