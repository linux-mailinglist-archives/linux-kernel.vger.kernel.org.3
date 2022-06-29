Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3C560B86
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiF2VTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiF2VTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:19:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347DB12741;
        Wed, 29 Jun 2022 14:19:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d129so16483979pgc.9;
        Wed, 29 Jun 2022 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=os8p+GPAgFQmOrekd67LxmGjSZ9E3oajR6XVGq4rXGs=;
        b=Fxa7JJ3tBHPzRrzLasvGyK11P7IMVCNsoz9yBpjCyeHc+PjcVwYvdEk6F3Sj/Hqe5K
         27ZH6wW65NtW05mDIiGHxfl7iulE9Wb6ZDLfc7N0wkfnaZQ0u255pw6f2ZXioQ+g8zJu
         r+XjqGvAG6Ob5J7fABtrw1dIC2hpuIR/FhFAPBXj5qkZ8WaqG6hQ/Igpw9WWVV3svRmU
         atSV23qmTPeuOeBv5E2I0bJJOrDLZIL6JcpKnuLDwy7kBcPEnOvgHIjJMEi7DjaQA/Zn
         gGq6ws2qdCXzxmBU1lNcFRbR2Hno+yiStMuyzqmdQvtLAEV30/cFeLOOUIjZWB9Gwn0k
         IV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=os8p+GPAgFQmOrekd67LxmGjSZ9E3oajR6XVGq4rXGs=;
        b=kfYbAi76+YeKcPVZoxAlGiQSV+ixDedbzMRNV7jnc95zq/l7BFOFqic06ig+myHuFb
         OOQVNUGQROY71PIFDhk/XKoFGXEPDy5jYEyO00RldATgVgadqsayr2R5q3SgIgu6RlFM
         DSYkVpPK7Bq5rAk8oCQGG2Zc1S82wF2lZjPb/aCoxM+Rqwmp2lrXnYIibUzzBU3ODVlo
         f8/TUADlblK/Z3OfK7pZWKeWQdYOCusbxDLDQWglx7FbGHdt9INbNfJuKS4aSA5TI6ar
         S+8XP6fphuj2hHug8Wj8a9bFMhWREgvSF2CW8FvAXvez3YqDQ9rkACPY6Dh7qwKFcbSE
         Ospw==
X-Gm-Message-State: AJIora9LySnGNnYc3jtgAnk/4iycf4IY5l2gQTJ1fJh5WWSWzz4mAJAH
        TRY/stASQWjMcJ9E4REswhs=
X-Google-Smtp-Source: AGRyM1uwm93lIJuDOjZiKwc+5OlO5luquq44ur9YrjetzeEh60E0gVYtcFvgBeeABInX7xJ5DufvRw==
X-Received: by 2002:a05:6a00:21c8:b0:4fd:f89f:ec0e with SMTP id t8-20020a056a0021c800b004fdf89fec0emr12174218pfj.83.1656537546574;
        Wed, 29 Jun 2022 14:19:06 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id bt11-20020a17090af00b00b001d95c09f877sm2660330pjb.35.2022.06.29.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:19:05 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Emma Anholt <emma@anholt.net>,
        linux-kernel@vger.kernel.org (open list),
        Sean Paul <sean@poorly.run>
Subject: [PATCH 0/2] drm/msm: A couple GPU devcore enhancements
Date:   Wed, 29 Jun 2022 14:19:14 -0700
Message-Id: <20220629211919.563585-1-robdclark@gmail.com>
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

A couple things useful for debugging iova faults:

1. caputre all buffer addresses and sizes even if we don't capture their
   contents.
2. capture the GEM buffer debug labels

Rob Clark (2):
  drm/msm/gpu: Capture all BO addr+size in devcore
  drm/msm/gpu: Add GEM debug label to devcore

 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  1 +
 drivers/gpu/drm/msm/msm_gpu.c           | 40 ++++++++-----------------
 drivers/gpu/drm/msm/msm_gpu.h           |  1 +
 3 files changed, 14 insertions(+), 28 deletions(-)

-- 
2.36.1

