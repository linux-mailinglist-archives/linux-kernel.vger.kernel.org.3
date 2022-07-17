Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8057774A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 18:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiGQQUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 12:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQQUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 12:20:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B33A18F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 09:20:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a15so9795587pjs.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3QM0VGwZJMhBsJE0onY0hM94jbomNudisRDkMA5phA=;
        b=XC49hl0Qoew2RD7oOXd1YLrAttGqaR8lA/xJayGMOA7KPOtm69P5LIAUTNSjlTIZBF
         baH7+u+MkADowl23la0Ld7o2G1TyHaouqxPWE586BiPJNGyP1xxHHKeeqvroWR/uf+gO
         9DhwKT4yDJHVTpieh7AIIaEzxnXdEuzC64nnTyPLU6+ygByfJAp7BHdWb9H5PPuXKhkc
         NrbfQnOhxeYsVuhtGRBB39jn6q5iGyj67CohnEhYfYHOxu5hqW0GDCW4p0rRNO0JM+3O
         lNTNvVRPno+ytNlKfCV2ikbLNUOjDepKmZVj5pc4Goxpiwz6xNMLou90aLu1s/XlDWjU
         EL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=u3QM0VGwZJMhBsJE0onY0hM94jbomNudisRDkMA5phA=;
        b=U0d7N1DZ5Vbx6opk6N9K786mzgYL72eu1N9wnrQpUJ8W1Wxn8ndpwSG2XZg4Skn/lQ
         k76jcLxcK/pYudYx/BY0sZl2+xXPkhVE6g5Zr4V8XFR6xeC0cqA1m6AUTGu4k5xDwDHa
         cmdyKBAAEFMU9f4ssjtssaPEAVm7SKPxrDJiC97PerNhOTDcDnWVTkvu+5AzSxVZa0H5
         /Xr0LDaZVzOhhmy24ZslipwDOaTlXidx3YPucctfJxkZYmWOM5SN2GVGrow63Cn6vI5I
         nNgUDvo2XBLlRgiaiYiSz9gMYPz2HFVXatwg/HHaEmHf3cNZyFGKJV6GY/GL5zfG9wwT
         iPBQ==
X-Gm-Message-State: AJIora8AqbI0UXUxEPEQXxxwMhN8YGxah0Jsyy27E2w3xrqLYmPCmKk+
        YC6en3UQJjdMZksfiixPgtjDa5O8kIwj2A==
X-Google-Smtp-Source: AGRyM1ve/k7uBaojTv42vcU8qIxzNJZnzgL1eV24bkOlshzh2Z01ipo8jmARjSC9DhQ4kvDO93eO/Q==
X-Received: by 2002:a17:90b:1a81:b0:1f0:77a7:907f with SMTP id ng1-20020a17090b1a8100b001f077a7907fmr29012948pjb.49.1658074850832;
        Sun, 17 Jul 2022 09:20:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u142-20020a627994000000b0051c758a3957sm7690289pfc.149.2022.07.17.09.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 09:20:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Matthew Auld <matthew.auld@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Subject: [PATCH] drm/i915: Fix 32-bit build
Date:   Sun, 17 Jul 2022 09:20:46 -0700
Message-Id: <20220717162046.710290-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aff1e0b09b54 ("drm/i915/ttm: fix sg_table construction") introduces
an additional parameter to i915_rsgt_from_mm_node(). The parameter is used
to calculate segment_pages. This in turn is used in DIV_ROUND_UP() as
divisor. So far segment_pages was a constant and handled without divide
operation. Since it is no longer constant, a divide operation is now
necessary. This results in build errors on 32-bit builds.

x86_64-linux-ld: drivers/gpu/drm/i915/i915_scatterlist.o:
	in function `i915_rsgt_from_mm_node':
i915_scatterlist.c:(.text+0x196): undefined reference to `__udivdi3'

Fix the problem by using DIV_ROUND_UP_ULL() instead of DIV_ROUND_UP().

Fixes: aff1e0b09b54 ("drm/i915/ttm: fix sg_table construction")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I took a stab at the problem. Please ignore the noise if it has already
been fixed with a different patch.

 drivers/gpu/drm/i915/i915_scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_scatterlist.c b/drivers/gpu/drm/i915/i915_scatterlist.c
index f63b50b71e10..b81d5658c222 100644
--- a/drivers/gpu/drm/i915/i915_scatterlist.c
+++ b/drivers/gpu/drm/i915/i915_scatterlist.c
@@ -96,7 +96,7 @@ struct i915_refct_sgt *i915_rsgt_from_mm_node(const struct drm_mm_node *node,
 
 	i915_refct_sgt_init(rsgt, node->size << PAGE_SHIFT);
 	st = &rsgt->table;
-	if (sg_alloc_table(st, DIV_ROUND_UP(node->size, segment_pages),
+	if (sg_alloc_table(st, DIV_ROUND_UP_ULL(node->size, segment_pages),
 			   GFP_KERNEL)) {
 		i915_refct_sgt_put(rsgt);
 		return ERR_PTR(-ENOMEM);
-- 
2.36.2

