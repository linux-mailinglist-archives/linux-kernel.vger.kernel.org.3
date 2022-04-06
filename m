Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5EA4F6D76
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiDFVyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiDFVwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:52:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8E5A181;
        Wed,  6 Apr 2022 14:46:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w7so3665687pfu.11;
        Wed, 06 Apr 2022 14:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tAkFR+6vhq0o/UUKOqeWc9uPJoN5WXdSoZFQuuhB/hI=;
        b=bzbT6J2rgm/qYgWCGsRl0Bjoi13VafBGsuibq7P7WOH3DJ+fTwNs36UvugO7KgAhRW
         O6iQyRJ69joIyW7F2lw0tITOk1kQOur9BSAH2y8teHCZFnVhe4Ndd+AaL+S/r4m+bGs+
         rn4iXs7Hm/QXDJAytjB02xXIakTR6CW5XyLEm6evbcAh8diR85qgUBxpDGrPuO2+LqvD
         t31EVd7PTSQuTciEkYEtWnWeeyWKGbaNBq4Rz+g++Mx00fuqweGosuWD/d7SvI82Ed6N
         RSREDA3ygOEXaF+OK66exIm4bHX+2swqNiQO0L+LE+J5imWC3XJB5pZDr1UlQQOFaq8K
         wchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tAkFR+6vhq0o/UUKOqeWc9uPJoN5WXdSoZFQuuhB/hI=;
        b=LQNnFcbVMRpKsP/OMp15JDX/Ac6VEoh2jxFhgrqjkXPX8gkN+Al0JUg3fr7aqErn0P
         KvztbArQQ+k/MphMop2rGfAXkLwWjPci3P5jk4DBLV+6WQTk5FU3xmUmQnexJ5o/QUVK
         w9z2p5rj23NhfKBXl70xRklkMDWJtjlCv7pO5pK2bc9mQkgSM6vSuSWT0PzrUhwyGozZ
         /v5KtSxwi3r+7q6/u59RTm+L44/gUcneyrBwBTXr7Efg4U51/xxAQczqZeX6PFjssbFs
         HC34PvN2kzaa7kXu5/Cj9mcqR4DsZMzjhe3ZnVFAugNYz6gEAbGrm2Bl5owiVusCxcUo
         UPGQ==
X-Gm-Message-State: AOAM5332/oPe2t8X7WVtPJPel6VfyAziKjxk/ECxgwHfYJRUolGGUsVB
        vsMtIgvhEMN4l7gh4qBUxbg=
X-Google-Smtp-Source: ABdhPJz/PjnrL7EshfGJWR8+rAUeniiBE61/tDJkSnK+WydzixgBjZDKWQAzo2+3/4l3ggQUrTfajw==
X-Received: by 2002:a63:f005:0:b0:381:f11:730c with SMTP id k5-20020a63f005000000b003810f11730cmr8448018pgh.156.1649281596386;
        Wed, 06 Apr 2022 14:46:36 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id y16-20020a63b510000000b00398d8b19bbfsm17217112pge.23.2022.04.06.14.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:46:35 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/10] drm/msm/gem: Split out inuse helper
Date:   Wed,  6 Apr 2022 14:46:20 -0700
Message-Id: <20220406214636.1156978-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406214636.1156978-1-robdclark@gmail.com>
References: <20220406214636.1156978-1-robdclark@gmail.com>
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

Prep for a following patch, where it gets a bit more complicated.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c     | 2 +-
 drivers/gpu/drm/msm/msm_gem.h     | 1 +
 drivers/gpu/drm/msm/msm_gem_vma.c | 9 +++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

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
index 64906594fc65..dc2ae097805e 100644
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
-	if (GEM_WARN_ON(vma->inuse > 0))
+	if (GEM_WARN_ON(msm_gem_vma_inuse(vma)))
 		return;
 
 	/* Don't do anything if the memory isn't mapped */
@@ -100,7 +105,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
 void msm_gem_close_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
 {
-	if (GEM_WARN_ON(vma->inuse > 0 || vma->mapped))
+	if (GEM_WARN_ON(msm_gem_vma_inuse(vma) || vma->mapped))
 		return;
 
 	spin_lock(&aspace->lock);
-- 
2.35.1

