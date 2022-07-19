Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13D57A4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbiGSRSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGSRSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:18:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493FA45F7A;
        Tue, 19 Jul 2022 10:18:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so16408888pjf.2;
        Tue, 19 Jul 2022 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wgjlxY2vwEbbQYsymCaoGbyx7Qj5nQdz14BXeMbJhaU=;
        b=p4ebQ4x0Es+yVhm5HbrlBJIuofxFuJNJ5oU8LI9n1tczXrvXmtO3qAKCKDxkGi0W/i
         o3gLj5uG6j884yw/HhZktPPXikTr1ONquivno9qlPTYgbIf9QqUKQxx/+x9BmEM6OIya
         myPyER21Y0uFH44HARRLyb0MfU3qw2VD+RBpZ+zthxaOraRhsoo+YeQx47nG2Y8bxqaP
         b153dVsRW78UAua4re115PJ++Gd3al/roKZZBVd/n5JoMIgIsQYcFvMZgjnhQaX/sIQP
         xS11hKrxHDUnGm+ctazTNAUV94CypiPZ7cofGKf/4h88Dks88wWu8BTKDKL5IjfI0MGV
         2LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wgjlxY2vwEbbQYsymCaoGbyx7Qj5nQdz14BXeMbJhaU=;
        b=uki1JtqqOXOtJZJPgKPJMlndsqcia8GMHnVk3a1Nah/oha2tPKdspVEo4Nr/Eqau5t
         UlKPf00DjMeGTy/StMXeDi8DH1zNf21ywx01NfOfv4rY075Q9sonKBCH1MC0rLciY8JE
         X1mSqGvVjx0Xr/JC7fvVlMxWiVwpnKPKztgkGup2HNZcQeYUj/vZLNC8bX2DoXr6rvb4
         0ph/pABErKVBuBJVKDQz7MtnXU1jfzPCz3d9jg7fQQxrO0+hlCST/1muVqWTZlgEGJbS
         YnVpZ9ETFVRqTknkGDVACLwG/g+OvJIMPCMKnzntYIxT1IY3ZwWv+UMkAzpCjpxO4mvB
         x1IA==
X-Gm-Message-State: AJIora9lUv5Cxw2/LxpMXba2TncrQ9lpaogHA+USN2dBXjmcpxqI0Zak
        mVuV8IOaZ/nS55uyMx4FAss=
X-Google-Smtp-Source: AGRyM1tiIGFdkSIYREuKSjwYhFDnYD5jN1rCGiePbxyhzgQNo3Q1PYnMml4qKU9sYeo6X8ydRXwkpQ==
X-Received: by 2002:a17:902:ebcb:b0:168:e3ba:4b5a with SMTP id p11-20020a170902ebcb00b00168e3ba4b5amr34258744plg.11.1658251118481;
        Tue, 19 Jul 2022 10:18:38 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id ij19-20020a170902ab5300b0016b865ea2ddsm11892850plb.85.2022.07.19.10.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:18:37 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        linux-kernel@vger.kernel.org (open list),
        Sean Paul <sean@poorly.run>
Subject: [PATCH v2 00/13] drm+msm: Shrinker and LRU rework
Date:   Tue, 19 Jul 2022 10:18:44 -0700
Message-Id: <20220719171900.289265-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Mostly a resend with a small fix in the last patch (and a couple early
patches drop out when rebasing).

original description below:

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

Rob Clark (13):
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
 drivers/gpu/drm/msm/msm_gem.c          | 149 +++++++-------------
 drivers/gpu/drm/msm/msm_gem.h          | 112 +--------------
 drivers/gpu/drm/msm/msm_gem_prime.c    |   4 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 164 ++++++++++------------
 drivers/gpu/drm/msm/msm_gem_submit.c   |  78 ++++-------
 drivers/gpu/drm/msm/msm_gpu.c          |   3 -
 drivers/gpu/drm/msm/msm_gpu.h          |  10 +-
 drivers/gpu/drm/msm/msm_gpu_trace.h    |  36 +++--
 drivers/gpu/drm/msm/msm_submitqueue.c  |   1 +
 include/drm/drm_gem.h                  |  56 ++++++++
 13 files changed, 483 insertions(+), 401 deletions(-)

-- 
2.36.1

