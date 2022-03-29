Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E064EB658
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiC2XCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbiC2XCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:02:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B404A923;
        Tue, 29 Mar 2022 16:00:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y6so16404915plg.2;
        Tue, 29 Mar 2022 16:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kb2enBvHT2itfmPZn/LyeXIRT2mssdSW2pMTncu7VUg=;
        b=puHfI8biwa9WeDGDrjQTbUiPA0SNqIaybiwLPKQqjZZkKwwRmy4jt/NMqiZscmymav
         t75DPdR74eU/Qpytn4n6ein7gIlj5ztuk0SRgjAg9pYohxEMR+Yri+QXHaPPJ8gyEinP
         NimUuCnOoF8UK3V7XwBbjjJyt+cKBinW2o1f3FLKMVANdOzBUbX4L/jlpMxVyRQ3wTPx
         tnmC1qLa9BQE/1pl/uegCKHv1EF0vHMHhtgBBspbVGxIlpnhC3Y8lKqwyBdCv8md1VhJ
         tMUHJQFHplmz/VMUslFcj5RcnMwgS15kqm0G0sAGIvFb3OdL26WYo+1xxVxZWc6+GVNE
         yV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kb2enBvHT2itfmPZn/LyeXIRT2mssdSW2pMTncu7VUg=;
        b=AhUR+2VP4fPzp8ZP5WH0qFgmeJsaK3huxcfuWWVEhxitr3m5EJPRUupN9NyUs1YXxO
         Y9ISat9FLxScyUwehiJUsAy7ZKI5J17HhuxxsCAdOXfBv+Fn0mk3T21yl2W6dPIZ7I1s
         PSz9e4odNlp1OdIPMau7n5muF1c5LNYGVjMOM2xC90yGFph2oG5nFp1EX9EDuQLYRoOk
         MjEP/+25cRW8Qu9j/Nlh0520dRl3JlEF21UMnCQfcXdtcdXqLgRpyNw03D0jauQH/m9a
         bqRlkA7YQcxcQXAxP8li38N0EWzf9tCG3i2rVh87QTf0TaKAzmTEFpVirGucMSNIUIKR
         BokQ==
X-Gm-Message-State: AOAM533Mi7DrKifHLTtXSGbetXj/Og/34pPUEnkUz55NoSDe5mKqfwQO
        ez8DhsR2/Rn8XKf7inxkFlg=
X-Google-Smtp-Source: ABdhPJwNzrhzInpoi/FDNRztER1UyrSoyAS1DCtrEuns0Tb22euBv3TgxGGycQ2mD8lstHIsJz2qXg==
X-Received: by 2002:a17:902:f605:b0:14f:5d75:4fb0 with SMTP id n5-20020a170902f60500b0014f5d754fb0mr32208533plg.101.1648594826326;
        Tue, 29 Mar 2022 16:00:26 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090a3d4500b001c97528521asm4141087pjf.6.2022.03.29.16.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:00:25 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/9] drm/msm/gem: Split out inuse helper
Date:   Tue, 29 Mar 2022 16:00:51 -0700
Message-Id: <20220329230105.601666-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329230105.601666-1-robdclark@gmail.com>
References: <20220329230105.601666-1-robdclark@gmail.com>
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

Prep for a following patch.  While we are at it, convert a few remaining
WARN_ON()s to GEM_WARN_ON().

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c     |  2 +-
 drivers/gpu/drm/msm/msm_gem.h     |  1 +
 drivers/gpu/drm/msm/msm_gem_vma.c | 15 ++++++++++-----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index a4f61972667b..f96d1dc72021 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -938,7 +938,7 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m,
 				name, comm ? ":" : "", comm ? comm : "",
 				vma->aspace, vma->iova,
 				vma->mapped ? "mapped" : "unmapped",
-				vma->inuse);
+				msm_gem_vma_inuse(vma));
 			kfree(comm);
 		}
 
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 947ff7d9b471..1b7f0f0b88bf 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -61,6 +61,7 @@ struct msm_gem_vma {
 int msm_gem_init_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma, int npages,
 		u64 range_start, u64 range_end);
+bool msm_gem_vma_inuse(struct msm_gem_vma *vma);
 void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma);
 void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index f914ddbaea89..dc2ae097805e 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -37,6 +37,11 @@ msm_gem_address_space_get(struct msm_gem_address_space *aspace)
 	return aspace;
 }
 
+bool msm_gem_vma_inuse(struct msm_gem_vma *vma)
+{
+	return !!vma->inuse;
+}
+
 /* Actually unmap memory for the vma */
 void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
@@ -44,7 +49,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 	unsigned size = vma->node.size << PAGE_SHIFT;
 
 	/* Print a message if we try to purge a vma in use */
-	if (WARN_ON(vma->inuse > 0))
+	if (GEM_WARN_ON(msm_gem_vma_inuse(vma)))
 		return;
 
 	/* Don't do anything if the memory isn't mapped */
@@ -61,7 +66,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
 {
-	if (!WARN_ON(!vma->iova))
+	if (!GEM_WARN_ON(!vma->iova))
 		vma->inuse--;
 }
 
@@ -73,7 +78,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
 	unsigned size = npages << PAGE_SHIFT;
 	int ret = 0;
 
-	if (WARN_ON(!vma->iova))
+	if (GEM_WARN_ON(!vma->iova))
 		return -EINVAL;
 
 	/* Increase the usage counter */
@@ -100,7 +105,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
 void msm_gem_close_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
 {
-	if (WARN_ON(vma->inuse > 0 || vma->mapped))
+	if (GEM_WARN_ON(msm_gem_vma_inuse(vma) || vma->mapped))
 		return;
 
 	spin_lock(&aspace->lock);
@@ -120,7 +125,7 @@ int msm_gem_init_vma(struct msm_gem_address_space *aspace,
 {
 	int ret;
 
-	if (WARN_ON(vma->iova))
+	if (GEM_WARN_ON(vma->iova))
 		return -EBUSY;
 
 	spin_lock(&aspace->lock);
-- 
2.35.1

