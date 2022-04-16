Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BB45037B6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 19:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiDPR0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 13:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiDPR0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 13:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FD3636310
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650129819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xZJdeEB7LRc/tdjD5XNMXjOZKOVeiea7oToBzOvG+54=;
        b=RhNHyzXdCK5qnxc71MDklCG1d9x3pUG/HigvsHNjyDlWJjI2mJhHIcS4fXBGhja4JMJBJW
        7bP8rcxY4W8KcQW6Gbi54GBEieVznP8qOdR/V8j/WOJ3UTH9s4mHx9fQcfv4fw/r+h/RAH
        yNGAQW+ski9h7STMZugr9RrIS5HGlI4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-lB8fv_yWNUacXzKj8OH83A-1; Sat, 16 Apr 2022 13:23:37 -0400
X-MC-Unique: lB8fv_yWNUacXzKj8OH83A-1
Received: by mail-qt1-f200.google.com with SMTP id w18-20020ac857d2000000b002f1fa23a40eso87361qta.14
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 10:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xZJdeEB7LRc/tdjD5XNMXjOZKOVeiea7oToBzOvG+54=;
        b=jK39xS7JL/TR1/DcZ9BXF7+5NEGGp6FIWw/rBJHVaR+P0md8Ow4odHOmXgpXh5rzg0
         LzuxCnFHoxBsYEIJPiNC0KnfVgch3Z76IbAW/avYZvOdyjQLlNhc/wrMz9fyGjZUHWZq
         3j8BW1HjO3XHcsmJCuOsVlVrxzJoag+Yg1jkqncgiSWJIdVquhwiJMhm/Efe8X/qvFUr
         FobI0UXF/NLB3x2G05T2ncih3zi//EpdaDXfW/BmqyEEVqPxY+NJEX4sMw7eQkE9jFTR
         Bbje/nWq8jApDhQuL1aQVm9WtnXa2hImTBJMfUlz0Bmz7OGFvVGmqpJrulWrsi30iZEF
         2ChQ==
X-Gm-Message-State: AOAM531fVVTrg4pPtOF7tV1/+1i18hidKnfd6lmv8pzW0h4pUPIzhMPQ
        61lxdpPWi5k3CA/viX16Ay5OBy6/wTJqeGKNhPTylhlir6XxGB/TzDKcrm2wPcLeDFxuyQUT0JI
        KZ+2gHdRccYpBV5ixHIDAJCZj
X-Received: by 2002:ac8:59d4:0:b0:2e1:f86d:b38c with SMTP id f20-20020ac859d4000000b002e1f86db38cmr2760712qtf.285.1650129817219;
        Sat, 16 Apr 2022 10:23:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAEeXarJj7i8MC2Tcj5mB+1+LrS7bjnC2aeIcVvjZ6kbGfJHZPt0VaVk2XcNDtSL6OwKTS1g==
X-Received: by 2002:ac8:59d4:0:b0:2e1:f86d:b38c with SMTP id f20-20020ac859d4000000b002e1f86db38cmr2760702qtf.285.1650129817011;
        Sat, 16 Apr 2022 10:23:37 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n186-20020a37bdc3000000b0069c218173e8sm4079598qkf.112.2022.04.16.10.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 10:23:36 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/i915: change node clearing from memset to initialization
Date:   Sat, 16 Apr 2022 13:23:25 -0400
Message-Id: <20220416172325.1039795-1-trix@redhat.com>
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

Instead of using memset, initialize node to 0 at it's
definitions.  And remove unneeded clearing of the flags
element.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/i915/i915_gem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 2e10187cd0a0..7dbd0b325c43 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -69,7 +69,6 @@ insert_mappable_node(struct i915_ggtt *ggtt, struct drm_mm_node *node, u32 size)
 	if (err)
 		return err;
 
-	memset(node, 0, sizeof(*node));
 	err = drm_mm_insert_node_in_range(&ggtt->vm.mm, node,
 					  size, 0, I915_COLOR_UNEVICTABLE,
 					  0, ggtt->mappable_end,
@@ -328,7 +327,6 @@ static struct i915_vma *i915_gem_gtt_prepare(struct drm_i915_gem_object *obj,
 		goto err_ww;
 	} else if (!IS_ERR(vma)) {
 		node->start = i915_ggtt_offset(vma);
-		node->flags = 0;
 	} else {
 		ret = insert_mappable_node(ggtt, node, PAGE_SIZE);
 		if (ret)
@@ -381,7 +379,7 @@ i915_gem_gtt_pread(struct drm_i915_gem_object *obj,
 	struct drm_i915_private *i915 = to_i915(obj->base.dev);
 	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
 	intel_wakeref_t wakeref;
-	struct drm_mm_node node;
+	struct drm_mm_node node = {};
 	void __user *user_data;
 	struct i915_vma *vma;
 	u64 remain, offset;
@@ -538,7 +536,7 @@ i915_gem_gtt_pwrite_fast(struct drm_i915_gem_object *obj,
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

