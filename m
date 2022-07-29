Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751D258542A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiG2RHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiG2RHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:07:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0806E2F6;
        Fri, 29 Jul 2022 10:07:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q16so4468115pgq.6;
        Fri, 29 Jul 2022 10:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=xOX9chVYPROOGAwdmaGgZcPW07GxLyOUqTmIVsiyRrY=;
        b=MRLwlAUouciI2C7C4GlFSSMaiCgUFvFJHEtdHFSFik2hSiv0VP8gL4ZSfprY2hsTK1
         71DIYxBGrwqXFBScOnqP+VzlVWE/yF7/4yB3mDGe+vThJBq8uPvmws21UEmirDlolpMy
         x549Jju9p8IU2GkZyiWgwKVdtIHXMUNPMhzRBu+dYou1+wt+08d0lBPCrTdJXwzkiDN6
         JGHGbeMh9SUdLwzzK3x2hd2GyvGvJjuGYxepwaCRt1WmmePQgRRw+KTKKuRl+7PDrYbw
         HFD4qHEQTMrxQPUwhb11Op/lv6vtakCbR4692upCeChRxW01QL5PORt1xeQ8tBNUL24N
         4sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=xOX9chVYPROOGAwdmaGgZcPW07GxLyOUqTmIVsiyRrY=;
        b=djydbztGHXHBVun7LQFGeDSv4F8O1hGkLCilgo2P1rnLKapzFXjA7ImEJzMwDDqEWU
         HdZ+mDcRQ2kfDpBj5WnPmcIoAUnWGHPy7Z+3MNHvbMIZZDlYmD5dJ4rpj+TdHa4xT6fB
         ner89lx5gywO6XswhAeyB+QL8mmU8mPa9/0WgrSd/snyyJ1wXgVNig3IdejBeXxzQUDp
         yXwplHUdjXoX5mWb0T5WANTBeluulvcKWiKJYdNS6WdGt8DhHwi2fSA/aW3bdrEUW+4m
         QI2z2vFo2b8isOE0tz7DEngeYXCwSP65EvzIseKMT52OCiyQ6TvZfGYvMxwSrSageYfE
         xSZA==
X-Gm-Message-State: AJIora8yKJl4NJr/lDCdVpN0QHcmg2QSkxUgTJXYOpcRqyouzzZxsXU8
        JNND5PZFzzdfLpiDMmE2IYc=
X-Google-Smtp-Source: AGRyM1uGBuQ9vqrdjA1iXWiRUZ+wtLiHx4OPCFlykBcsRNNxwJRC70pXFBsgRPqQ7gjXtfmlRSztjQ==
X-Received: by 2002:a63:4546:0:b0:41a:5e8f:508a with SMTP id u6-20020a634546000000b0041a5e8f508amr3767050pgk.419.1659114435380;
        Fri, 29 Jul 2022 10:07:15 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id bg1-20020a056a02010100b00419a6f3c8f5sm2778376pgb.19.2022.07.29.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 10:07:14 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        Sean Paul <sean@poorly.run>
Subject: [PATCH 0/3] dma-buf: map-info support
Date:   Fri, 29 Jul 2022 10:07:39 -0700
Message-Id: <20220729170744.1301044-1-robdclark@gmail.com>
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

See 1/3 for motivation.

Rob Clark (3):
  dma-buf: Add ioctl to query mmap info
  drm/prime: Wire up mmap_info support
  drm/msm/prime: Add mmap_info support

 drivers/dma-buf/dma-buf.c           | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/drm_prime.c         | 12 ++++++++++++
 drivers/gpu/drm/msm/msm_drv.c       |  1 +
 drivers/gpu/drm/msm/msm_drv.h       |  1 +
 drivers/gpu/drm/msm/msm_gem_prime.c | 11 +++++++++++
 include/drm/drm_drv.h               |  7 +++++++
 include/linux/dma-buf.h             |  7 +++++++
 include/uapi/linux/dma-buf.h        | 28 ++++++++++++++++++++++++++++
 8 files changed, 93 insertions(+)

-- 
2.36.1

