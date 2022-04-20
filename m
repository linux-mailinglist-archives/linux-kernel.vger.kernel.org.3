Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D219350854A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377385AbiDTKAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377423AbiDTKAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 883AE3D4B6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650448644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZbxWeXm1X4zfi7zki/F+6Y9tTnHLdesLwVcaLaLQFls=;
        b=ZcfYFDG99M3ujkgDZxtEOBBp1u7soAKVCauEhzD3sHQ7ur5hfKnAh9ejfWWfJ1eaTwIX97
        AEWIUEjPH97PIKvtOqMf2LS1ohWYLWhNxwm4sQ5Ihx9/H/vwxMIO29l3VQLCKXiUCjs+As
        K48NUUz6dS8NW6vD+CbbWhwf8BAcdfw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-FYWaFOFQNeiAmfQGs9-bbg-1; Wed, 20 Apr 2022 05:57:23 -0400
X-MC-Unique: FYWaFOFQNeiAmfQGs9-bbg-1
Received: by mail-wm1-f70.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso742996wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbxWeXm1X4zfi7zki/F+6Y9tTnHLdesLwVcaLaLQFls=;
        b=FpSfCUXNbdEc8CYAgDoOo7YGlBSuRm3lGh4F7RTyv/hvTYcTZ5NdKjrUZmjaO1fGFy
         pTahr+BXMt89hiOXWK66eH5TYfdA9ZepD+OYiPH1QC3FxskcbmybwR2zZVQzQPsoUheg
         NPHW8ZeYgWgYsWB9wwM4MKywZwboklotrHnSSH5Vtg3674ZNFeycVd5PXL9q0YAx+UAn
         NcFGRSHpj2uHgxsI0SnL7UyS6hP0D8Tm5yGRidtfGdjl89cdsA2A3p8tR0ht7U+xvCZ6
         vRZycI5ytldGkaq5yehrqlPwh9WzPBptgXGFNSi95iXlMcQqw3JTiGHk08iwlCM2cyPi
         0qzQ==
X-Gm-Message-State: AOAM533/vb00YtGxTvKShXeVGHQwbn4JELZAYifG7cknpNWOrfx09Yfq
        SuobVgY4v4RKVjeYd5yf7fPPK3fzp8u4ZrNgthb9BXMxWk2k7s+ziEUIKfxrNCwa7oqDm2FqK7H
        y82P8isUHMyilTRObJYDticarkESloWPjiEkNwz3aoRWGnatEAcX/SyrmDF8K9dESOIuRhSJhMH
        w=
X-Received: by 2002:a5d:6788:0:b0:207:ad57:cc71 with SMTP id v8-20020a5d6788000000b00207ad57cc71mr14714987wru.180.1650448642406;
        Wed, 20 Apr 2022 02:57:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAkCEg6ZTgvGJWDPDulGPHJ7+1EP0RT/2MwYavQA06jMb2aB4/hMSe2V5kqJ2x7FdsxgpAjA==
X-Received: by 2002:a5d:6788:0:b0:207:ad57:cc71 with SMTP id v8-20020a5d6788000000b00207ad57cc71mr14714970wru.180.1650448642139;
        Wed, 20 Apr 2022 02:57:22 -0700 (PDT)
Received: from kherbst.pingu.com (ip1f10bb48.dynamic.kabel-deutschland.de. [31.16.187.72])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c4ec800b0039290a5b827sm11376161wmq.24.2022.04.20.02.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:57:21 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/i915: Fix race in __i915_vma_remove_closed
Date:   Wed, 20 Apr 2022 11:57:20 +0200
Message-Id: <20220420095720.3331609-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i915_vma_reopen checked if the vma is closed before without taking the
lock. So multiple threads could attempt removing the vma.

Instead the lock needs to be taken before actually checking.

v2: move struct declaration

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/5732
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/i915/i915_vma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index 162e8d83691b..2efdad2b43fa 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -1615,17 +1615,17 @@ void i915_vma_close(struct i915_vma *vma)
 
 static void __i915_vma_remove_closed(struct i915_vma *vma)
 {
-	struct intel_gt *gt = vma->vm->gt;
-
-	spin_lock_irq(&gt->closed_lock);
 	list_del_init(&vma->closed_link);
-	spin_unlock_irq(&gt->closed_lock);
 }
 
 void i915_vma_reopen(struct i915_vma *vma)
 {
+	struct intel_gt *gt = vma->vm->gt;
+
+	spin_lock_irq(&gt->closed_lock);
 	if (i915_vma_is_closed(vma))
 		__i915_vma_remove_closed(vma);
+	spin_unlock_irq(&gt->closed_lock);
 }
 
 static void force_unbind(struct i915_vma *vma)
@@ -1641,6 +1641,7 @@ static void force_unbind(struct i915_vma *vma)
 static void release_references(struct i915_vma *vma, bool vm_ddestroy)
 {
 	struct drm_i915_gem_object *obj = vma->obj;
+	struct intel_gt *gt = vma->vm->gt;
 
 	GEM_BUG_ON(i915_vma_is_active(vma));
 
@@ -1651,7 +1652,9 @@ static void release_references(struct i915_vma *vma, bool vm_ddestroy)
 
 	spin_unlock(&obj->vma.lock);
 
+	spin_lock_irq(&gt->closed_lock);
 	__i915_vma_remove_closed(vma);
+	spin_unlock_irq(&gt->closed_lock);
 
 	if (vm_ddestroy)
 		i915_vm_resv_put(vma->vm);
-- 
2.35.1

