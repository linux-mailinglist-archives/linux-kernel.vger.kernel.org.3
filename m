Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9783F594DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242587AbiHPBZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244647AbiHPBZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:25:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A40F1CB178;
        Mon, 15 Aug 2022 14:14:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ch17-20020a17090af41100b001fa74771f61so194676pjb.0;
        Mon, 15 Aug 2022 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=X3Fu4ehStrUEKyTXt+fee6+Wug+zWXwk64af5B5Ru/4=;
        b=HaCbD+HDElK/diS+4llLWSlfdYQZ9dhgsMPOP1KRoiDFm0npey1Bqa9/oVRvRlmMgD
         9RnEx1/9LjeYmmhxwgvIEhTBuv/80m4RTRXqZ2NIIN7342CVBG8pwf7idUapDTtycmNC
         iMjnjJVXDV1snHkG/s2ykjGrlToed+buswZ10/XVNE93crGX5U9glQ6siCgMZ7wGgSuO
         +o7Swelyq6Wsr2Wm1lPPhQ7IpyEtlJVwBkiHzC/t4LsipXNSWJ8+cy3EurJuTBTncRBj
         Tka2ijvbVuiN0O8CfMRv1Db/cGVXkTPRKshz1b5h3QxyqHl1VVMQxzSG1uEXUGNLd60Y
         eLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=X3Fu4ehStrUEKyTXt+fee6+Wug+zWXwk64af5B5Ru/4=;
        b=bphC2vrKWBdIEXY1RkOZkRBrovzsBFFRKfdzxS9CMfX0gzEMQIqx5gawrn2S4Rzh/+
         De2wYLfYerU1H8mePZci82uHNVFZgmo7NgXch9hZ87KU3ELSMW7F9YXdVLd/f39Z6IOf
         jQVyqXkjPI0dPjIauIoVEcP7nkHQ+BYf+VcLqiB9J2uPbDGnZdiqBfAFKLmwUUZM/Tih
         XCP1B7w9pQb3ODaUUil/y98cb7pUaoAvWCrIWUm/gvv6wIeVLNdbY6fNpNpvnGX2LJYG
         V49CrZ0F71pZtZ3CgrQBdfSTRRTAms1+untfo8uUtP8ygwnnJZEPJcsVPaOjoLHQ48wm
         vIuw==
X-Gm-Message-State: ACgBeo2NwRLb4X3d3U4CuF1byvzX2DSgIjgt9iFyPM/cTd8/VItQjuMj
        YtpPF0bDuMBTnqXpZvLIc50=
X-Google-Smtp-Source: AA6agR44865ylIMa+b8PphQX9njk4C+gUcPVunj5mJCRWKVNX7lX7QczSovUoJeBOAsy56Hbx/SlLQ==
X-Received: by 2002:a17:903:120a:b0:172:5a63:7442 with SMTP id l10-20020a170903120a00b001725a637442mr13083405plh.55.1660598088926;
        Mon, 15 Aug 2022 14:14:48 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id a24-20020a63d418000000b004277f43b736sm3569439pgh.92.2022.08.15.14.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:14:47 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        Sean Paul <sean@poorly.run>
Subject: [PATCH v2 0/3] dma-buf: map-info support
Date:   Mon, 15 Aug 2022 14:15:11 -0700
Message-Id: <20220815211516.3169470-1-robdclark@gmail.com>
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

See 1/3 for motivation.

Rob Clark (3):
  dma-buf: Add ioctl to query mmap coherency/cache info
  drm/prime: Wire up mmap_info support
  drm/msm/prime: Add mmap_info support

 drivers/dma-buf/dma-buf.c     | 63 ++++++++++++++++++++++++++------
 drivers/gpu/drm/drm_prime.c   |  3 ++
 drivers/gpu/drm/msm/msm_gem.c | 12 +++++++
 include/drm/drm_gem.h         | 11 ++++++
 include/linux/dma-buf.h       | 11 ++++++
 include/uapi/linux/dma-buf.h  | 68 +++++++++++++++++++++++++++++++++++
 6 files changed, 158 insertions(+), 10 deletions(-)

-- 
2.36.1

