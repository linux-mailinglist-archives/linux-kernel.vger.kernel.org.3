Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3593581921
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbiGZRvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiGZRuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:50:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63A831359;
        Tue, 26 Jul 2022 10:50:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so17956245pjq.4;
        Tue, 26 Jul 2022 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzvQD1BdX2RVx+fHXlbnajcgEgfcaBeelT02bqIAfkE=;
        b=C3rcsNLGUDjPRxfROWRdoZEqoPkKn1/Htx7zNkExFevmAr6cVYFPDwZk4cJHQuOjHg
         7zp1XEPvH9pdrPAIHxwIRBSeD9v/q5BEq8SzErK351H9HEU9UjEYJB3U7dLDRJUOeo/C
         fzsPnfbr7GciGNhhETTtlx5iIyPnhqwJepjcHeqov4vLVlLC//PFuwmy5n4ZBfFdQwEU
         9rqlJsrjcQNNRVjXyyh962ue2QdUjvI7uk/DpyP28VihilgKjyn49nDzVN43FIEUdCrW
         AeI+KADu9MKjjJHjevG34Z4qEh1wv1KPXw7Iox6VhZtIFn90D0TTjfQreasf/G7ISIij
         GpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzvQD1BdX2RVx+fHXlbnajcgEgfcaBeelT02bqIAfkE=;
        b=SyrNCgcVwVDdUh1IvtluALE97SUTrfqnUcZ2aG+eT1AvKzTgp8/lb9pXcIHYbgi7K1
         SVEwDj3Hnt0VcU/1EuJ2ub02qFwT7wEEEEwCQ23wJjtrqOU7MusRIwcCFaFr1uLq9Exr
         OIfpfTeAUKQ7I3UaQMxDtCWEcZ6+MZisJJA7lEtM2Jurwz1vdhMs0/D09Vw4Po6oVf22
         RCsc0RJviePW4+8L98Zdt4dUwTJXLo4UK0oQO1aVr3TNWomRyJtsHiShLMPN0qZ2v3ds
         92D1ufIXpSIF/7CGTaNL7Tvvy1Dqv+yP+Is8ajkDP3/G3kuJldpvVB7WZR1CBZhKt23k
         u3/w==
X-Gm-Message-State: AJIora8+KL/DmKyxU7Cdbjlk7iBunmXE01JIHyuY0SoBG+xhxBM/yUG2
        ja3QlhyXGI7zH4WwhYNV12l5Uff41Uc=
X-Google-Smtp-Source: AGRyM1sv575TC+lxA2u2e7voRIevFC2jb9zeRMsA6HFThlboaFzIal5t6kaH6LzWzhGEUpQTPqbR/w==
X-Received: by 2002:a17:90b:343:b0:1ef:b65d:f4d8 with SMTP id fh3-20020a17090b034300b001efb65df4d8mr306192pjb.187.1658857846082;
        Tue, 26 Jul 2022 10:50:46 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b0016bfe9ab1f3sm11868299pli.36.2022.07.26.10.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:50:45 -0700 (PDT)
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
Subject: [PATCH v3 11/15] drm/msm/gem: Unpin buffers earlier
Date:   Tue, 26 Jul 2022 10:50:35 -0700
Message-Id: <20220726175043.1027731-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220726175043.1027731-1-robdclark@gmail.com>
References: <20220726175043.1027731-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

We've already attached the fences, so obj->resv (which shrinker checks)
tells us whether they are still active.  So we can unpin sooner, before
we drop the queue lock.

This also avoids the need to grab the obj lock in the retire path,
avoiding potential for lock contention between submit and retire.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index adf358fb8e9d..5599d93ec0d2 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -501,11 +501,11 @@ static int submit_reloc(struct msm_gem_submit *submit, struct msm_gem_object *ob
  */
 static void submit_cleanup(struct msm_gem_submit *submit, bool error)
 {
-	unsigned cleanup_flags = BO_LOCKED;
+	unsigned cleanup_flags = BO_LOCKED | BO_OBJ_PINNED;
 	unsigned i;
 
 	if (error)
-		cleanup_flags |= BO_VMA_PINNED | BO_OBJ_PINNED;
+		cleanup_flags |= BO_VMA_PINNED;
 
 	for (i = 0; i < submit->nr_bos; i++) {
 		struct msm_gem_object *msm_obj = submit->bos[i].obj;
@@ -522,10 +522,6 @@ void msm_submit_retire(struct msm_gem_submit *submit)
 	for (i = 0; i < submit->nr_bos; i++) {
 		struct drm_gem_object *obj = &submit->bos[i].obj->base;
 
-		msm_gem_lock(obj);
-		/* Note, VMA already fence-unpinned before submit: */
-		submit_cleanup_bo(submit, i, BO_OBJ_PINNED);
-		msm_gem_unlock(obj);
 		drm_gem_object_put(obj);
 	}
 }
-- 
2.36.1

