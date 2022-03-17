Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4875E4DCBB6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiCQQwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiCQQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:52:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BEC20A959;
        Thu, 17 Mar 2022 09:51:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id kx13-20020a17090b228d00b001c6715c9847so3736292pjb.1;
        Thu, 17 Mar 2022 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1fhGdDZ+4+A9O0kCAE2qwkKzIiiq6BxVXVjKbXoOSjc=;
        b=ac9lDNWQnaCjB8ARNToKqWJDqJP5c28Oek7OnIM8tObf04cglsVkYnXBmiuN9c3Vv5
         2NYJaoYf5XGUKw3PSYK+DyxInZZKD+1OAcKuFi5M5X8gN4eXpwEBM/lXs/2jp4AB3HtV
         Op8GJqf+gOusx4Twv2NDLrsanY7dvJieFhLKej2mwDe8ynGiPDWcxYkH8fIoFoeHSzDD
         S3QJ4T2e0YrbaBaapqQuGQ2R+jZ3nxjWphDWla4JwCtJCimnu3watw7KvWCSxfPq8yw1
         pN1Efdd8hY6wHe2SlJHqkKgy1i+D5xu9uPDhn10kskC5Oix83cLBVBFyURLBiUmXw8kg
         OJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1fhGdDZ+4+A9O0kCAE2qwkKzIiiq6BxVXVjKbXoOSjc=;
        b=YPuKVmZm5Af6Gmzn53K5gggdKEK7JA4qWxu1GBI4p40WRCsWWoW+wLAT+NtJZnummY
         jz2yNQ58jn9ycy01iDjWnfLtY9SSoMU08X7zbiar5CHp4LmqVNNLYRzVJYEm5c4MuFq+
         a2GC0se8dBU5N6DOCg5El5PnJVqK9cTNqmS7cfWos2HR5TysoRJINF1AUqbT4AG9hXEr
         xrfGyeLRQYojqzO8H9iCdXDZG6Yt7XWOOZRDVBGuTMgNW0uZ8IvoVJr41/fopiQto4Pq
         bJuLSlt/d7QVhBY9c6MvUyYtu/QZN6bG8N1dNW9D+Vh2t6T6+fyyB8e8l7/NR79k934L
         PZzg==
X-Gm-Message-State: AOAM530HXYH9uR7qmaduymxiMEPIwn9gfV9eRhvMZd629U0hJ0CBAgbT
        gB43C//P3/5SpS/W9yFMA74=
X-Google-Smtp-Source: ABdhPJwOV8GUTP9XpL07YdxSy7tQQ35mfNlI37jPr60/Ls8AYizX9BfbQrjuvdQDSL4LF/zStG7h0w==
X-Received: by 2002:a17:90b:1d8d:b0:1c4:ba77:3e29 with SMTP id pf13-20020a17090b1d8d00b001c4ba773e29mr6509256pjb.206.1647535868296;
        Thu, 17 Mar 2022 09:51:08 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id d19-20020a056a00199300b004f7b7bb0733sm7071888pfl.60.2022.03.17.09.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 09:51:07 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list),
        Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: [PATCH v2 0/3] drm/msm: Add comm/cmdline override
Date:   Thu, 17 Mar 2022 09:51:37 -0700
Message-Id: <20220317165144.222101-1-robdclark@gmail.com>
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

Add a way to override comm/cmdline per-drm_file.  This is useful for
VM scenarios where the host process is just a proxy for the actual
guest process.

Rob Clark (3):
  drm/msm: Add support for pointer params
  drm/msm: Split out helper to get comm/cmdline
  drm/msm: Add a way to override processes comm/cmdline

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 49 ++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  4 +-
 drivers/gpu/drm/msm/msm_drv.c           |  8 ++--
 drivers/gpu/drm/msm/msm_gpu.c           | 40 ++++++++++++--------
 drivers/gpu/drm/msm/msm_gpu.h           | 10 ++++-
 drivers/gpu/drm/msm/msm_rd.c            |  5 ++-
 drivers/gpu/drm/msm/msm_submitqueue.c   |  2 +
 include/uapi/drm/msm_drm.h              |  4 ++
 8 files changed, 94 insertions(+), 28 deletions(-)

-- 
2.35.1

