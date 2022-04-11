Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC36B4FC713
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350271AbiDKWAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350259AbiDKWAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:00:36 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E8812634;
        Mon, 11 Apr 2022 14:58:21 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h5so14399582pgc.7;
        Mon, 11 Apr 2022 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SGa5BVmzMUOjfF5fklYjMnwty8EXXy2NltxcnqNLnSI=;
        b=NpgvKbziTPlvUGcW9mmJML9sHLc+zWxqDmsbtj0YPGHgvqfUVIRhOCs3jBrfYtBflP
         BRRRrlWxy5weosAOCDvRt+HTgIMiHC4IyBg1lVwBPuClbtSTdYvZjN0ilyUxUPAp6bSR
         qdXkyjlUAO7DrzOh9WlMRCFziz1oabCONC3bcjLB4faf87UIN36nQEPlkZcITeUiQX7p
         GEI4xjRFYuLgb8IyjCIpB7+7V6YWolJPj74Aqu8bNBZ/OjhUAjCi+FlHm/TivQCo12F4
         NdjlLeqYsDbx7moYxmicY/LFN1ZiEFhLi4L/wOVMvsqDGaEmYM4E9WNf+KJBZSZSR0gQ
         OCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGa5BVmzMUOjfF5fklYjMnwty8EXXy2NltxcnqNLnSI=;
        b=ovbsceJpscktHnUYyye92esfcS7GIC2Mj69uTNii2wNdAD0S6xXZjKudygmUT/Zqm/
         ipa3JrEB0p48IUMVRD8pf8WyuC6cVqI9pLHGC7FIjmSTbQXRkz0w/xo4GOTjapVHnpWn
         HcwttQ4AERKVrGMWK3VxOrNhgRWJC5p838xXnQwpj5gEn8BkIy92nNjSKAetsIMHDPHq
         ZYpHk6W8FH8l75SVDyrRTjtBdrISCp8qyvXM2HsbC6jasTZtespWYbe4In17h/TztDcM
         eC48x4pXtbUC01e0LxPTJP5auyEA9g7urDTJezgMNjV9GllYltMw3VSJudrCAiG5fRTn
         JOuw==
X-Gm-Message-State: AOAM531MckOFpfE/ujpPq5aPfdxAaHzsNpTDSj50THoAIY1i3UGVkbin
        CBtWcCL5zW9GbBMKBHUdUd0=
X-Google-Smtp-Source: ABdhPJzwPB9DkLCamMEM9k77qgBonZ3Mia3qrEXeQdTkvM8+jJIvPtn5pD698qi/bI9kLsDk9wifFQ==
X-Received: by 2002:a63:fe4d:0:b0:39d:20ac:d7f7 with SMTP id x13-20020a63fe4d000000b0039d20acd7f7mr6811611pgj.369.1649714301088;
        Mon, 11 Apr 2022 14:58:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id mw10-20020a17090b4d0a00b001c7cc82daabsm461830pjb.1.2022.04.11.14.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:58:20 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 03/10] drm/msm/gem: Convert some missed GEM_WARN_ON()s
Date:   Mon, 11 Apr 2022 14:58:32 -0700
Message-Id: <20220411215849.297838-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411215849.297838-1-robdclark@gmail.com>
References: <20220411215849.297838-1-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index f914ddbaea89..64906594fc65 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -44,7 +44,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 	unsigned size = vma->node.size << PAGE_SHIFT;
 
 	/* Print a message if we try to purge a vma in use */
-	if (WARN_ON(vma->inuse > 0))
+	if (GEM_WARN_ON(vma->inuse > 0))
 		return;
 
 	/* Don't do anything if the memory isn't mapped */
@@ -61,7 +61,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
 {
-	if (!WARN_ON(!vma->iova))
+	if (!GEM_WARN_ON(!vma->iova))
 		vma->inuse--;
 }
 
@@ -73,7 +73,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
 	unsigned size = npages << PAGE_SHIFT;
 	int ret = 0;
 
-	if (WARN_ON(!vma->iova))
+	if (GEM_WARN_ON(!vma->iova))
 		return -EINVAL;
 
 	/* Increase the usage counter */
@@ -100,7 +100,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
 void msm_gem_close_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
 {
-	if (WARN_ON(vma->inuse > 0 || vma->mapped))
+	if (GEM_WARN_ON(vma->inuse > 0 || vma->mapped))
 		return;
 
 	spin_lock(&aspace->lock);
@@ -120,7 +120,7 @@ int msm_gem_init_vma(struct msm_gem_address_space *aspace,
 {
 	int ret;
 
-	if (WARN_ON(vma->iova))
+	if (GEM_WARN_ON(vma->iova))
 		return -EBUSY;
 
 	spin_lock(&aspace->lock);
-- 
2.35.1

