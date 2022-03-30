Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44564ECE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351115AbiC3Utj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiC3Utg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:49:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400E146B23;
        Wed, 30 Mar 2022 13:47:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t2so19921071pfj.10;
        Wed, 30 Mar 2022 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfjnQPsWSYFHa6/IEHWm+/2wuddS77YFSoX6K2k8WAs=;
        b=qC4uOR8IOWShCZwjgvJri6DARkuzz2I9SZJDZ4AvTXi1tq3hxOQJsE5l+kifQk5SWn
         u40vr1x2VFiEtk3vBCqTVqmO0p/2YSgtbYUP2g3+DyGI7yF6Pcv9GYZ8TPiMjcwBL90B
         gPHyEtrZstP5e410DG2KyJ4MSyFaYsXCQy676NuLB9m2dsG5YKSI0+UkCp2tPFMgv0n7
         u65aV4R7tkt+uRyuMygRTiS54EViRC/Fn2lir4czlzavyzwfI4JPjdtUI7Q+j8BDpEl1
         Xb2spl5hCkconGmuduSGN3E2H08Az6ON3hZPlRGUwWJaMcao369mKCR4msi7uWgQ03KN
         OovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfjnQPsWSYFHa6/IEHWm+/2wuddS77YFSoX6K2k8WAs=;
        b=aSnZn04+ydPKTlo5nXxcNuY0w+34iQsihnZrKwSFjGMZ1uJ0ma1oyt4vE52ShZ1e3V
         XONfJG29SO+uM9cSoyJzE8Ii+ejNAV9QUcTn2Y65i2AiWs0h9TV6WqXOW4ZVqgn0S58V
         poXNeRXbITKTPzohD8JN4PO2LJd6qG/ijhkCX48tK7jyp1iTOV09y9ECPCPcpf5zlrD4
         L9ADgj5Gzxp58j7YRpaE4FctO21OBxZAGi0vlKbQCSSLk0R3a9jHUt4/lXzK2qpKf74h
         gZkqsPj/DZBiOMaC0malZWuAz25P0EFdTIsgJJu6hW7pDe1KSPXs6mO1sMRzHmEC+GVR
         63JQ==
X-Gm-Message-State: AOAM531zv5Abc0nRzyI/rjH04JNUNHQQ4I9vaRiaEBG0DS4gQsbbLIUj
        IAqjPc68f+VNiRCBxv6G78d9d/tpkq8=
X-Google-Smtp-Source: ABdhPJxdLzVjn+t+OSFNxjZRQ67GvD+fwncEqPMil8nBUspK/F9AqvVDwI9XWwz2gknTpciSuqo5oQ==
X-Received: by 2002:a63:ea0e:0:b0:37d:f227:ec57 with SMTP id c14-20020a63ea0e000000b0037df227ec57mr7536833pgi.441.1648673269692;
        Wed, 30 Mar 2022 13:47:49 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id a7-20020aa79707000000b004fb17ad3aefsm19836938pfg.108.2022.03.30.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:47:48 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list),
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 00/10] drm/msm: Userspace allocated GPU addresses
Date:   Wed, 30 Mar 2022 13:47:45 -0700
Message-Id: <20220330204804.660819-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The first six paches are various cleanups and simplifications.  The
next two get rid of redundant vma lookups in the submit and retire
paths.  Following that, fenced vma lets us indicate a fence value
following which the vma is no longer used, which is needed because
otherwise userspace could observe the signaled fence prior to
retire_submits() finishing.  (With userspace allocated GPU addresses
userspace is tracking when a buffer is no longer used and it's vma can
be deleted.)  And finally the last patch adds the new uabi for user-
space allocated iova.

v2: Fix inuse check in last patch, split GEM_WARN_ON() conversion to
    separate patch, and nits

Rob Clark (10):
  drm/msm/gem: Move prototypes
  drm/msm/gpu: Drop duplicate fence counter
  drm/msm/gem: Convert some missed GEM_WARN_ON()s
  drm/msm/gem: Split out inuse helper
  drm/msm/gem: Drop PAGE_SHIFT for address space mm
  drm/msm: Drop msm_gem_iova()
  drm/msm/gem: Rework vma lookup and pin
  drm/msm/gem: Split vma lookup and pin
  drm/msm/gem: Add fenced vma unpin
  drm/msm: Add a way for userspace to allocate GPU iova

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  14 ++-
 drivers/gpu/drm/msm/msm_drv.c           |  21 ++++
 drivers/gpu/drm/msm/msm_drv.h           |  23 ----
 drivers/gpu/drm/msm/msm_fb.c            |  16 ++-
 drivers/gpu/drm/msm/msm_fence.c         |   6 +-
 drivers/gpu/drm/msm/msm_fence.h         |   3 +
 drivers/gpu/drm/msm/msm_gem.c           | 151 ++++++++++++++----------
 drivers/gpu/drm/msm/msm_gem.h           |  47 +++++++-
 drivers/gpu/drm/msm/msm_gem_submit.c    |  17 ++-
 drivers/gpu/drm/msm/msm_gem_vma.c       |  59 ++++++---
 drivers/gpu/drm/msm/msm_gpu.c           |   8 +-
 drivers/gpu/drm/msm/msm_gpu.h           |   2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c    |  12 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h    |   1 -
 include/uapi/drm/msm_drm.h              |   3 +
 18 files changed, 258 insertions(+), 131 deletions(-)

-- 
2.35.1

