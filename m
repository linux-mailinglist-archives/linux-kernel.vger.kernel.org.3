Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9180057A501
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiGSRTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbiGSRTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:19:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930444A816;
        Tue, 19 Jul 2022 10:19:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c6so12553262pla.6;
        Tue, 19 Jul 2022 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzvQD1BdX2RVx+fHXlbnajcgEgfcaBeelT02bqIAfkE=;
        b=JMLFaDiOl3fTF1vQ8KHqql+oNThjBy7zWx/y8DQ9Z/0c7uVTm8yACi7Z2w6/5G66/Q
         0/gthVxtHxEJoGxvMNkZA2OiexiIsS/h9L+UhaFIlsCGbSWvk5bjbugJPd5v1KD75WPT
         Lvr4foB1JtxEKojRY5LTQtiTmcLz/2hbrt2eDW9YBIy8gf1ZEsQNCYCJ866+c1VWoDYi
         jZUJHp9AukkB96Ynu/yZq6y6cUtf8U0EsOE/kfBRWOFn9zPtasaCuPV7EysePzx9c+Bw
         wuSz13pddVCYbbL6gj/OUIm/wDJVGmDeBosyBGsNqJY9rvVBRkxWz9FOrvDalIOCofGi
         gZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzvQD1BdX2RVx+fHXlbnajcgEgfcaBeelT02bqIAfkE=;
        b=3UfvsDohFFGNUWa6TWGvE+6FAss7OiyHFHzfaxj3iaxoUzb8/S08nO8bpxTxNplhWm
         atojdHRlA3kN8o+PuqH0s13QWmSF3XJAun16jqoYIx4x9tYo+tjXzfxhho/cuDPPLT4F
         tnhcFsDg4Dh6+ByLNfw/72qIru+MYc0uDfxyYtb385jEGo9P7Vp6t/eG4ZKyahBJeVxi
         5ae2+1/nOBntPGBPzPmcMo5mg2YTtU0Fa7QwR0JEmeXZxSKDMPTaUac94WcMBs8gIZk+
         4yErSlJAJ2/ZNqc8C8kRW30Lf1WDXo9UODQYz2/Ij8N5GszZmbV+uvGI8rtL/KRAy/S/
         0A7A==
X-Gm-Message-State: AJIora/pQxV+CNJalnndw4QYG6ZtvVfmfA9bPoA4pMhIMc3q+hRuZKb+
        8oq9JAgQwo6uXNtul6Fe3jU=
X-Google-Smtp-Source: AGRyM1t1cQXyO0F3MTKjBuxm2SfHhx+7oXShSQf6dGqX09a/GWI1vg9zGWJQKN+pDaC5UENRewuDqA==
X-Received: by 2002:a17:90a:df18:b0:1f2:12ba:9092 with SMTP id gp24-20020a17090adf1800b001f212ba9092mr406971pjb.204.1658251148083;
        Tue, 19 Jul 2022 10:19:08 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id n8-20020a056a00212800b0052877d6f66bsm11801040pfj.50.2022.07.19.10.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:19:07 -0700 (PDT)
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
Subject: [PATCH v2 11/13] drm/msm/gem: Unpin buffers earlier
Date:   Tue, 19 Jul 2022 10:18:55 -0700
Message-Id: <20220719171900.289265-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220719171900.289265-1-robdclark@gmail.com>
References: <20220719171900.289265-1-robdclark@gmail.com>
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

