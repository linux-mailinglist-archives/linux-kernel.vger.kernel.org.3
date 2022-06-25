Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587B955AD47
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiFYWzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiFYWzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:55:41 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C6713F70;
        Sat, 25 Jun 2022 15:55:33 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e63so5664768pgc.5;
        Sat, 25 Jun 2022 15:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzvQD1BdX2RVx+fHXlbnajcgEgfcaBeelT02bqIAfkE=;
        b=KOon/w2LGkob1wGHBBHJ89ou2eb0xLTun9FBY+3NZx1eWwTZfXTXIZMhvRPRLmKDF8
         Dwcda1Jw30GegUsGq5yykO+9LaY0RQMTKOnYMfyANn2a3+wdtlv9dtjcONuRm0GcVBgA
         3NtzNN7r099vZD9WVBGppQ5Lg4tknfuXe6UWFAk00weyuLfuLdo3YKh3dsJwT5jnH9hz
         gsgkoC0W0L+kjPHRjXkc+EzynBBIR4R0S+Rp8DRGu6WKIfxLtVnuRk06VDkwWsV9R1q1
         0mxtU8/2yxnVxUA8PrhSm4XyZX9ZDNMbykvOViY/ldaB3UAeRLHbSYMkhzp8lGDDsH2A
         yftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzvQD1BdX2RVx+fHXlbnajcgEgfcaBeelT02bqIAfkE=;
        b=jmpe3wY28YdtwIaiY6+GHvBgHs9tN0qlrsTRikhEQCdGb1EU9GyctqecSBEYsj6k9B
         7OIH93iyxypPqAY5edVxlhYu/qS2E+KldmnPUttfI1KLJdEO/N7gqU3UwQioHCOpFOqH
         Bq2CCIzfMb+wMRwGzDUrAvQa7v1EY5IME7hAX0haa2rnlmgkLpH+mQoDQXr82fIJc16j
         we2dWAUOaKzzCAxH8qEKINzOFUi7Ce+brkBtMhPfvCa9jy8RFatvzWgsqPmkvrRRNLel
         xP4F80+es9F5P7LYX0RLNrI381HxtW6AmOmZkTsVp1zT63m4MAlWApz4eRBNshMubMPq
         Jmqg==
X-Gm-Message-State: AJIora9/fOZtqDP23Iswke6+5SCNdMM8OepY1bU7wmOnJbJdMPwzWzUF
        5gJWqvtlDIT0EcG5SW7CQUc=
X-Google-Smtp-Source: AGRyM1vj3PKBYedlufVclRfXmk3uILPeCT+e1vBK/3Ya1177jHlJLFqiGL7Ag79Bl3wRNNifT2aS0g==
X-Received: by 2002:a63:b94a:0:b0:40c:e843:a1dc with SMTP id v10-20020a63b94a000000b0040ce843a1dcmr5370006pgo.441.1656197733393;
        Sat, 25 Jun 2022 15:55:33 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id jb20-20020a170903259400b0016a11b9aeb2sm4171689plb.187.2022.06.25.15.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:55:32 -0700 (PDT)
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
Subject: [PATCH 13/15] drm/msm/gem: Unpin buffers earlier
Date:   Sat, 25 Jun 2022 15:54:48 -0700
Message-Id: <20220625225454.81039-14-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625225454.81039-1-robdclark@gmail.com>
References: <20220625225454.81039-1-robdclark@gmail.com>
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

