Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B4507D47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358064AbiDSXr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiDSXr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 338D621813
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650411881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oYGafAneoUZHzEpI/8/bT8Grd+Q/phBRFprX8SG/5bY=;
        b=c0D0avCHttmjOQNEviiqVk94T5WrAKjCgPYQAHsP+OKcR6C/7b+65srCG6Df7BNbAegR5/
        8+P2cp7wDXZgj5pDixjXsJgzDbNrVzcyYrmnb+BeH9s3JEaI0UFvPrX5zdUBd8a349d9p8
        t6ZibFxNbypaveWkIf1LaiK0zhF3gu4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-A3-U_55VPByrISC6o1Aezw-1; Tue, 19 Apr 2022 19:44:40 -0400
X-MC-Unique: A3-U_55VPByrISC6o1Aezw-1
Received: by mail-wm1-f71.google.com with SMTP id m125-20020a1c2683000000b00391893a2febso76450wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYGafAneoUZHzEpI/8/bT8Grd+Q/phBRFprX8SG/5bY=;
        b=Ji9sStWBP6qDkE2Z15hnl/0bDUK4EmFRlukmHVztBaYgMCW1UAsZsSKstRtGmn1Xk7
         /pGwDlZ0SmSLZq3V7/vWb11/29bNCDMBkLztLkjGUY8RsTC/gpyrGLmVRKCPP8rytvwL
         AVLLQFTblsFmDpnGnH53XxhS4QA23f6IiAVLjynMmga6mGMQVjcfGJxPF4tDW3Sd5nks
         rMzAAjYyM2AQoj+gk+lvu7omuCvr1nh+LyFYkBO7gu+84VCBJeXqNDmCZy5y9zp+9SLv
         2X/XRdyK1dpHrZFi4HdUxKhJw7U5kDyBjx0af7wxNqbEX6UmzcOtFmVH3XIWz05D51Wy
         tZsw==
X-Gm-Message-State: AOAM531U5myaegn+TCCFcKieSbmE+tTJIQkogK9Zy0WF7i24Ig4C79UG
        iTez2q2VdtXOwfgZCGMpusEKGDawqSf7TfZGfKvnytut4i+ER28bIFasg1Km6YLKYearTmVVei4
        xTkEafQzUQtw9A+R8TAN006lddxzfczbq6g/lxsumDrxQq3eHed2oLzpC8cVBVwpO7WxkH9eoYJ
        k=
X-Received: by 2002:adf:e301:0:b0:205:db69:6dba with SMTP id b1-20020adfe301000000b00205db696dbamr13903205wrj.605.1650411878555;
        Tue, 19 Apr 2022 16:44:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd21waJxZOqKa793oN0FwdeBAnzWxA1Koh+HqrwD58qJEbPViWBCVhaKh7RSE4dFJnB0AKtQ==
X-Received: by 2002:adf:e301:0:b0:205:db69:6dba with SMTP id b1-20020adfe301000000b00205db696dbamr13903193wrj.605.1650411878317;
        Tue, 19 Apr 2022 16:44:38 -0700 (PDT)
Received: from kherbst.pingu.com (ip1f10bb48.dynamic.kabel-deutschland.de. [31.16.187.72])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b0037d1f4a2201sm16560045wma.21.2022.04.19.16.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 16:44:37 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915: Fix race in __i915_vma_remove_closed
Date:   Wed, 20 Apr 2022 01:44:36 +0200
Message-Id: <20220419234436.2638649-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i915_vma_reopen checked if the vma is closed before without taking the
lock. So multiple threads could attempt removing the vma.

Instead the lock needs to be taken before actually checking.

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/5732
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/i915/i915_vma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index 162e8d83691b..bb3b6e4bee8b 100644
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
@@ -1651,7 +1651,11 @@ static void release_references(struct i915_vma *vma, bool vm_ddestroy)
 
 	spin_unlock(&obj->vma.lock);
 
+	struct intel_gt *gt = vma->vm->gt;
+
+	spin_lock_irq(&gt->closed_lock);
 	__i915_vma_remove_closed(vma);
+	spin_unlock_irq(&gt->closed_lock);
 
 	if (vm_ddestroy)
 		i915_vm_resv_put(vma->vm);
-- 
2.35.1

