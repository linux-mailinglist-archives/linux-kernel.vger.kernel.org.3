Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C66C5045B3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 00:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiDPWgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 18:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiDPWgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 18:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 975D9265B
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650148452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4ouuJnJQp4IGN8I0+Gam0bFswWMP7CzxEr+ECX/m5CA=;
        b=cwGVA1SMn+xEPspXABh7/2QFfCMk6k3u3nRLUKscEoJEr63y0Zqy8oDw3UyCWgYD5DFNhn
        yTFVqIhMuFieY1x25XfWCSAC91YRUxGAX4RTN0Fdvaxsi1tt/k2jnPyJx5B78jlsDhD78O
        MPly9qgzB3mMVAQZzRT+mnVDdVMP2hY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-iDNWV6zHMlWhlkTtc009YQ-1; Sat, 16 Apr 2022 18:34:09 -0400
X-MC-Unique: iDNWV6zHMlWhlkTtc009YQ-1
Received: by mail-qk1-f197.google.com with SMTP id h8-20020a05620a244800b00699fb28d5e4so7711880qkn.22
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 15:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ouuJnJQp4IGN8I0+Gam0bFswWMP7CzxEr+ECX/m5CA=;
        b=Qmg+46NXXJ6m83e7CinzUTOsFUzPItjC2Lqv/lbskYX7UJvkjw01V2cKuACofQo0gF
         VjxpaAcjI5NKfnP7e5yjWlXcwhVGPNn85dWXMf1hYDWqOrj99UcN5CR+IbVohEuWTEmh
         mlsCRsyB86hcq1Aargcgjro3n84+bNUuMty5NjfD9M0omn+P6Pe+1Dq8bA0BuD/RIGsb
         TZ9fRJCbZRlWVCtv+0N+64DwwryW9Bd5ULSOMAVzhQMENsyMti7/yXGFE2ZAWddF+ILC
         tBWAhwbsizhFGNl8rqqXAZthQwt6T0OYu5bWQXSNFaLycrVqkM6Z1OH9F3TOyS3mT0EJ
         Vz0A==
X-Gm-Message-State: AOAM531BniA3A9Tmj9Me/vmsKilyFlGOuKfwFvzzijbo5aNOLQO5WaFV
        YyNqmew18rpooQ8+4t2pFTuZ6/nK1WNx9FIpJTZrdWvgzISRS+ZL9jjMKq4YUSN52Fe7duyeo+q
        8/Q+RKhFRpOTMrGCa9mWtsbQ+
X-Received: by 2002:a05:620a:cf2:b0:69c:4dc4:8944 with SMTP id c18-20020a05620a0cf200b0069c4dc48944mr2940663qkj.553.1650148449025;
        Sat, 16 Apr 2022 15:34:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCgSH8or87FJu0ZT9dvXV57n7uWYJZDIsex3cv5/l1u5s9UMBP5GIBcNqRLvUrEyps6t5lOQ==
X-Received: by 2002:a05:620a:cf2:b0:69c:4dc4:8944 with SMTP id c18-20020a05620a0cf200b0069c4dc48944mr2940650qkj.553.1650148448824;
        Sat, 16 Apr 2022 15:34:08 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a12eb00b0069c88d15b6asm3422412qkl.68.2022.04.16.15.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 15:34:08 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] drm/i915: change node clearing from memset to initialization
Date:   Sat, 16 Apr 2022 18:34:01 -0400
Message-Id: <20220416223401.1720193-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In insert_mappable_node(), the parameter node is
cleared late in node's use with memset.
insert_mappable_node() is a singleton, called only
from i915_gem_gtt_prepare() which itself is only
called by i915_gem_gtt_pread() and
i915_gem_gtt_pwrite_fast() where the definition of
node originates.

Instead of using memset, initialize node to 0 at its
definitions.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: restore clearing of flags

 drivers/gpu/drm/i915/i915_gem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 2e10187cd0a0..268b1f66b873 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -69,7 +69,6 @@ insert_mappable_node(struct i915_ggtt *ggtt, struct drm_mm_node *node, u32 size)
 	if (err)
 		return err;
 
-	memset(node, 0, sizeof(*node));
 	err = drm_mm_insert_node_in_range(&ggtt->vm.mm, node,
 					  size, 0, I915_COLOR_UNEVICTABLE,
 					  0, ggtt->mappable_end,
@@ -381,7 +380,7 @@ i915_gem_gtt_pread(struct drm_i915_gem_object *obj,
 	struct drm_i915_private *i915 = to_i915(obj->base.dev);
 	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
 	intel_wakeref_t wakeref;
-	struct drm_mm_node node;
+	struct drm_mm_node node = {};
 	void __user *user_data;
 	struct i915_vma *vma;
 	u64 remain, offset;
@@ -538,7 +537,7 @@ i915_gem_gtt_pwrite_fast(struct drm_i915_gem_object *obj,
 	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
 	struct intel_runtime_pm *rpm = &i915->runtime_pm;
 	intel_wakeref_t wakeref;
-	struct drm_mm_node node;
+	struct drm_mm_node node = {};
 	struct i915_vma *vma;
 	u64 remain, offset;
 	void __user *user_data;
-- 
2.27.0

