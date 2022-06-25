Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB98A55AD1B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiFYWy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiFYWy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:54:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8D313F44;
        Sat, 25 Jun 2022 15:54:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m14so5112989plg.5;
        Sat, 25 Jun 2022 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DqnDC8wXirP0ojIZwN5KsSwyORxgkbtiz7Q3mfrD8Kc=;
        b=MXBO+4eIan2PZ4lO1kplxnoROjf5VuTEVAqDQNsrbSTaKRCLhxZ865B6v19Agg+hCl
         ou3v5RKw6rmbkb7YwdygDEjXNVXT7Y6EvIBQzh8XzlimhV+awvDUGMOmswS287gvJLt7
         0Jl/Eer6JMDwnqTmGp+9yVfyQLYl1JBQZG+zrKodE2hmVVsN4Kpo3y5oW9wRMC9kY6AE
         7AoKzEjzK/mo4zyQDZ0Fo1BRvoFrBSN/ZvP0YyXX4KMrfViPmpcP0n80GdOJIMcC4RiV
         Jwd2gR/38ejUYjEJXXx8+vUskjVAO0BWFwfF/p+ya7QkbLCHmqUz0FULtR6gcFv07bmo
         +1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DqnDC8wXirP0ojIZwN5KsSwyORxgkbtiz7Q3mfrD8Kc=;
        b=6iF2WF1AQXO6bsRv2Up/dgyJhkTuqJTFtrQqPe3saBqbQbQv/N0Uw2G7unrBATQ9Ym
         VU0IIS9unz2AUTYnVxSLS1DuCd9RVX4Nqk1+ICG1g3gIlO31II7RoyEo7c8yzzjYm69G
         K5bSK8DUPmfre3hWABh/ASh1/jamQm+zoO2FFNdcY8V16VoZI2d6anpZOrGRc8t4DLmy
         qWC9ycvFpOFH1aDPot0QS6ciCSF+66vzSB/vgvt40esZOtUasxfkXraOvNTmuZ6tnv5F
         qRtIgFFhxsLZyn3aiibT/VVGyBjzJIxTpq09y37gaNyfmzNbgxq5UW8nElyANR7rfQB/
         qIGA==
X-Gm-Message-State: AJIora+hh9TEfJnszqxipzcE4glVtj63qWdq/gzvn4C+7yCwiyRrixND
        0faBKIqY9ppdcpr9yEux/AY=
X-Google-Smtp-Source: AGRyM1vq7jldm84sPi1tL7Fyjtp/T4q7OPjF1+X6qv6C4ay0fP/kSd37XY3+58+AqGml9+7pDIGWWA==
X-Received: by 2002:a17:90a:df98:b0:1ec:96e5:b04d with SMTP id p24-20020a17090adf9800b001ec96e5b04dmr6818452pjv.185.1656197696684;
        Sat, 25 Jun 2022 15:54:56 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id h13-20020a62b40d000000b00522d32a6a38sm4094507pfn.121.2022.06.25.15.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:54:55 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        linux-kernel@vger.kernel.org (open list),
        Sean Paul <sean@poorly.run>
Subject: [PATCH 00/15] drm+msm: Shrinker and LRU rework
Date:   Sat, 25 Jun 2022 15:54:35 -0700
Message-Id: <20220625225454.81039-1-robdclark@gmail.com>
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

This is mostly motivated by getting drm/msm to pass an i-g-t shrinker
test that I've been working on.  In particular the test creates and
cycles between more GEM buffers than what will fit in RAM to force
eviction and re-pin.  (There are sub-tests that cover this case both
single threaded and with many child processes in parallel.)

Getting this test to pass necessitated a few improvements:

1. Re-ordering submit path to get rid of __GFP_NORETRY (in the common
   case, doing this for syncobjs is still TODO)
2. Decoupling locks needed in the retire path from locks that could
   be held while hitting reclaim in the submit path
3. If necessary, allow stalling on active BOs for reclaim.

The latter point is because we pin objects in the synchronous part of
the submit path (before queuing on the drm gpu-scheduler), which means
in the parallel variant of the i-g-t test, we need to be able to block
in the reclaim path until some queued work has completed/retired.

In the process of re-working how drm/msm tracks buffer state in it's
various LRU lists, I refactored out a drm_gem_lru helper which, in
theory, should be usable by other drivers and drm shmem helpers for
implementing LRU tracking and shrinker.

Rob Clark (15):
  drm/msm: Switch to pfn mappings
  drm/msm: Make enable_eviction flag static
  drm/msm: Reorder lock vs submit alloc
  drm/msm: Small submit cleanup
  drm/msm: Split out idr_lock
  drm/msm/gem: Check for active in shrinker path
  drm/msm/gem: Rename update_inactive
  drm/msm/gem: Rename to pin/unpin_pages
  drm/msm/gem: Consolidate pin/unpin paths
  drm/msm/gem: Remove active refcnt
  drm/gem: Add LRU/shrinker helper
  drm/msm/gem: Convert to using drm_gem_lru
  drm/msm/gem: Unpin buffers earlier
  drm/msm/gem: Consolidate shrinker trace
  drm/msm/gem: Evict active GEM objects when necessary

 drivers/gpu/drm/drm_gem.c              | 183 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.c          |  18 ++-
 drivers/gpu/drm/msm/msm_drv.h          |  70 +++++++---
 drivers/gpu/drm/msm/msm_gem.c          | 154 +++++++--------------
 drivers/gpu/drm/msm/msm_gem.h          | 112 +--------------
 drivers/gpu/drm/msm/msm_gem_prime.c    |   4 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 164 ++++++++++------------
 drivers/gpu/drm/msm/msm_gem_submit.c   |  78 ++++-------
 drivers/gpu/drm/msm/msm_gpu.c          |   3 -
 drivers/gpu/drm/msm/msm_gpu.h          |  10 +-
 drivers/gpu/drm/msm/msm_gpu_trace.h    |  36 +++--
 drivers/gpu/drm/msm/msm_submitqueue.c  |   1 +
 include/drm/drm_gem.h                  |  56 ++++++++
 13 files changed, 485 insertions(+), 404 deletions(-)

-- 
2.36.1

