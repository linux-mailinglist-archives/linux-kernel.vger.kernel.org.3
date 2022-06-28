Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0962655F1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiF1XfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiF1XfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:35:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4232A393DF;
        Tue, 28 Jun 2022 16:35:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso14305649pjk.0;
        Tue, 28 Jun 2022 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vaT+UkiJ0ehVxWBX9B2xr4KFs7OszTBK9ROkHufIgOI=;
        b=KvgMfYwW6bO55xcTYS78EXDK4KyhYC0I79n7UFAiv2oN71X3dozvuw4IO/4buB8v+z
         jSY4/vmjn/YWkv1VA0fXbnAQ8lEnx7tzxW+7HBn965F1o0tFf5ZUvFesbqT0vQkbyfgC
         tBJUb8I3ZgWgRaKe7sHMwsCO7UKVz5NBGCP73L5pYPad6ZFcBPaMAa3U+LlTj6OIzvWI
         bJDParRTOMiCxmQC/w6Yo/mcsNeG4HsKfL/T8MMbsRZJ52L2/7BtP2kOoIWVgQpqyp+n
         pIN38FzDT4JnIUsO7w0zTxMFLJrnM+3J9CmsMpmTG//BhE//lVAi77BucSPj6qKp6qYu
         de8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vaT+UkiJ0ehVxWBX9B2xr4KFs7OszTBK9ROkHufIgOI=;
        b=6t9OVuMy9Nk8lNj5Fbc2EUdfTpXs+ZmoBJeM/DjDBfNMn3+JfS/KZpHhQlJBsClnC/
         L2aEpy8kAuo64TT8yOnKUDNIHnAZhe6SPnTIfh4eUGiuBTr/dNGrkCY1Bww58Pao++DL
         FPkhkGdme+o1WqzO7DZJRqmCrMCJpKz/FvtLFPEbRc12htR4AWRQyHztqfcrvw/x5tHF
         tJqQ8SxAbZ3sNdJUJNuiCXIgjvXPeinegYtZeSTNrzdUZzIEt96Ww9UYpX+uY04Au/Oi
         xveBiHjqH36VZfYvN0gVoSllg8rRe0mi0WJvk3EVtAbqvkkuHc41ZKo0Sa9laG6snfxn
         eABg==
X-Gm-Message-State: AJIora+u7ewMcgGo6KMok5z9k/QzuBU9KEkfq140Hfn6YKg9QHh6vGN3
        twFwnNW0ILAUZ4+QjXoCRCA=
X-Google-Smtp-Source: AGRyM1sEQP7f8OdcQ+NHqVS+ZsMay7AZxS/jUEG5b2E5pTElpDRfM9aO52b21oP6lqw8UgauG19pog==
X-Received: by 2002:a17:903:1208:b0:16b:81f6:e992 with SMTP id l8-20020a170903120800b0016b81f6e992mr7409363plh.55.1656459303698;
        Tue, 28 Jun 2022 16:35:03 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090ad48c00b001e2ebcce5d5sm442323pju.37.2022.06.28.16.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 16:35:02 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK)
Subject: [PATCH] drm/i915: Remove __dma_fence_is_chain()
Date:   Tue, 28 Jun 2022 16:35:07 -0700
Message-Id: <20220628233512.439555-1-robdclark@gmail.com>
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

drive-by cleanup

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_wait.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
index 319936f91ac5..667841780514 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
@@ -73,11 +73,6 @@ static void fence_set_priority(struct dma_fence *fence,
 	rcu_read_unlock();
 }
 
-static inline bool __dma_fence_is_chain(const struct dma_fence *fence)
-{
-	return fence->ops == &dma_fence_chain_ops;
-}
-
 void i915_gem_fence_wait_priority(struct dma_fence *fence,
 				  const struct i915_sched_attr *attr)
 {
@@ -93,7 +88,7 @@ void i915_gem_fence_wait_priority(struct dma_fence *fence,
 
 		for (i = 0; i < array->num_fences; i++)
 			fence_set_priority(array->fences[i], attr);
-	} else if (__dma_fence_is_chain(fence)) {
+	} else if (dma_fence_is_chain(fence)) {
 		struct dma_fence *iter;
 
 		/* The chain is ordered; if we boost the last, we boost all */
-- 
2.36.1

