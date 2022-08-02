Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A68587F69
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbiHBPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbiHBPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:51:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334373F337;
        Tue,  2 Aug 2022 08:51:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p8so13801247plq.13;
        Tue, 02 Aug 2022 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FzvQD1BdX2RVx+fHXlbnajcgEgfcaBeelT02bqIAfkE=;
        b=gyJP/xxOXSRqgltSY6MkFDlfxok3ZireuVXp4CDqtTjrutwuMplFbCh+3nG4pa0MYW
         O1i/IDxYXB5GWQEa2h/8BclQIu7fJFhdTb1UbBQuOqal0b/te/FXbS5DGyOENv8V2ZC3
         e0FxaB4NpVSBOrK+1HbDBDDsV7CddlDJaVQEuSeWE19EVEK+HY5z9Gt5t+9MkDojAhJv
         NT80ariNQXjQpxcjVr2wjKnldhFOUsmLlGLtFKl7jsx+13EEMnneqEuAmigPPcXJvMPq
         DPZjy5mX6M7VCyL+DBo1Qdaq7sFVxWr1hTRW/zvw41YgBT/87nW7rBVrtjvsyRIuJxTN
         4UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FzvQD1BdX2RVx+fHXlbnajcgEgfcaBeelT02bqIAfkE=;
        b=dMQV9S7JaSWLx08YYrJPoUsHueD93fdTFC0cqAIhrFvXAnNWV84px7DENR4JOOsd/O
         MafgHgl20L9FkGOaNRPrhfTR9GFmBQi4FvKaLFAOzZD2a/UB/wbYTxwn1fFf21WiQp8j
         CmlbxmZ0myoa9TYWMmv8Q2sTmM5SVqgiYiBedNuV9tNdnd7aoS6t9UBago7AxzE7BDDw
         7acU6B6bGFL9fxYdf6ONl0Nf+gCKJ+Ndxvf+9suiQ7RzVV/NAnXekmw2Yjw6aFnyKjIR
         fMTNm0dlX3U8rcNESUK3FGZ339w3B/tIEeBwg2PNIFFtxajYvlmFamNO/VAGewqT+4o0
         ZhXA==
X-Gm-Message-State: ACgBeo0I5W8LzmOkrpnAvlphHCAeg2547BLqNtzusbONK4yoezuVIVSr
        JY58Trp5UOayVcbdsi3cCSU=
X-Google-Smtp-Source: AA6agR5riFYgIxD5qt970Uy22d2sGuBlqC5eT/s6nbNG9HJYGy8kuF+I9Yeo95ehMIRdQhNhcsu4qA==
X-Received: by 2002:a17:90a:1943:b0:1ef:8146:f32f with SMTP id 3-20020a17090a194300b001ef8146f32fmr137919pjh.112.1659455507557;
        Tue, 02 Aug 2022 08:51:47 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090332cd00b0016edd557412sm6301857plr.201.2022.08.02.08.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:51:46 -0700 (PDT)
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
Subject: [PATCH v4 11/15] drm/msm/gem: Unpin buffers earlier
Date:   Tue,  2 Aug 2022 08:51:44 -0700
Message-Id: <20220802155152.1727594-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220802155152.1727594-1-robdclark@gmail.com>
References: <20220802155152.1727594-1-robdclark@gmail.com>
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

