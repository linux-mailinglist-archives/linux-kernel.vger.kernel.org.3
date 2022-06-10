Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44616546B98
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346984AbiFJRUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346451AbiFJRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:20:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F12AE0;
        Fri, 10 Jun 2022 10:20:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x4so15816106pfj.10;
        Fri, 10 Jun 2022 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1d1YjfsXHCfwVyos+52ZHT3Tu2EerzuEGkO0mh/Nu6Q=;
        b=au0Vt2lCWbjQNYZBsc6w0sdUHlRzG7uateyoAZJeIopej7HCGHyqu+76/Rnll8Kobe
         LnSqI0l4RLNjNN1RqjkTPWsuC2pUadgMzbln/NMia8AXkV62gHRQHgUIrCFa60oNNYj4
         rZr3pubnLU3Ky7IE0bQ0vzoBrqL1+I7FHMTUDSoF6yuMop2I/2dsfYY1TLc+bLG/5vjK
         NKH6LkbnoGcNYD2GSens2DUeXqu1kOu21DyOPwFmSPEmZZDiVlOptKZBQthxfKey6BnP
         P0zX80/6ZIYFT9yqJwio6fPIKHJvHbA/xaFQXfxtOZzpDZKuSbpCKZYaSvKhpl6tYtWD
         PBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1d1YjfsXHCfwVyos+52ZHT3Tu2EerzuEGkO0mh/Nu6Q=;
        b=5CCXuBMEcv8r5V5kJWUwUIJRB2NbsWHZLhZuwRZcWjzgA3zjxtfMVpL1Hybd6hpnrM
         shn/+QozK+8SP19jPwVgnE3dLG6WPRiVcFGLHi1Utmuv+gwN6zCrhdICjhuUES0aca5v
         Znva1KZ19R3sjmogFn0omvHF/ZYJGC9ku6/c5aT6Ohn3disfNdxvtfsAIi04MHSVxh4p
         xFc1EX9sfaDmo3ol/VBRP9eBWCFBm1OYyOrJXq2XD5VtlWo4WquzyIyizGXJ3z3JFjj7
         HNiOqk8M9aD7yZLXken7vgV0RpqwhGaPL3vdkbc3f3o1xxattxyM3CJiXSDWq0i3c8+m
         wHNA==
X-Gm-Message-State: AOAM531nxg94bC2yuDCREJnqB+HewEVFiveOqjUvdYq2cPa9bOMzLkrS
        XPu+wZAIF1UgpSZJ0rc81QAT3OKXw0A=
X-Google-Smtp-Source: ABdhPJzv1bPE/Sdfur21MebWfhL8/IUFnAi8/MuTCkTO+62g950KjYPUDnGxHW6lox+gRfj2JlppCQ==
X-Received: by 2002:a05:6a00:98b:b0:51b:d730:c58 with SMTP id u11-20020a056a00098b00b0051bd7300c58mr43227873pfg.23.1654881647554;
        Fri, 10 Jun 2022 10:20:47 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id b9-20020a639309000000b00405111cd999sm34273pge.36.2022.06.10.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 10:20:46 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/gem: Drop early returns in close/purge vma
Date:   Fri, 10 Jun 2022 10:20:55 -0700
Message-Id: <20220610172055.2337977-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Keep the warn, but drop the early return.  If we do manage to hit this
sort of issue, skipping the cleanup just makes things worse (dangling
drm_mm_nodes when the msm_gem_vma is freed, etc).  Whereas the worst
that happens if we tear down a mapping the GPU is accessing is that we
get GPU iova faults, but otherwise the world keeps spinning.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 3c1dc9241831..c471aebcdbab 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -62,8 +62,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 	unsigned size = vma->node.size;
 
 	/* Print a message if we try to purge a vma in use */
-	if (GEM_WARN_ON(msm_gem_vma_inuse(vma)))
-		return;
+	GEM_WARN_ON(msm_gem_vma_inuse(vma));
 
 	/* Don't do anything if the memory isn't mapped */
 	if (!vma->mapped)
@@ -128,8 +127,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
 void msm_gem_close_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
 {
-	if (GEM_WARN_ON(msm_gem_vma_inuse(vma) || vma->mapped))
-		return;
+	GEM_WARN_ON(msm_gem_vma_inuse(vma) || vma->mapped);
 
 	spin_lock(&aspace->lock);
 	if (vma->iova)
-- 
2.36.1

