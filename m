Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80804DBBBC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352965AbiCQAaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351452AbiCQAaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:30:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C831CB06;
        Wed, 16 Mar 2022 17:29:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p17so3138163plo.9;
        Wed, 16 Mar 2022 17:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xY4eVwxpzHGCfj7b88lwUJ2AvwKczsPBBzYysmGRLe4=;
        b=Vxg9k7ppY8aEm3bUKevEnXzPV2EAe+vCVpwTYJAGDuHoNeaIFmhjFnFY0g8tUIUP2w
         RR9hlL2z8EaXmlfpubXj+D7rC4Xx0RT9rBQQ3D8dcZ/DcKcFteupGzF6+/npdnChH59t
         d9Y0FqdpJVQ+e9MlGtYC2Omy4/kf/Uaml3BHl/66+98A39xtfDHgijvf6R56NFbJ93H+
         YVUx5Sd/6x3uiX9EcxZu75AFwboVJlK3bAMH6tQj6cQdYtTeMRf5BzDVV5WazBAIoRhQ
         DMlJ6Ck0JA1S9tMkf7MxnqB9neJAHB7Z2dnRLheTCDjoayM/Ti7o9tIf8GTdg3UPMiZb
         xtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xY4eVwxpzHGCfj7b88lwUJ2AvwKczsPBBzYysmGRLe4=;
        b=qKlqyMLB+Kgbv2eASeT7k5z7LsptKqzJV1iKWmJkfE2eLqpZRNOT7xuel3z1O7EEbN
         ZGuEPxP9UB83WpLj+3LD2mcOVHzHuxT0JTS4cPNZkLb7BniJif2iGulPChue5PCYOVcR
         GwTVhomi2LphkJShMDsu2H9aSk8Yrm/36XnBV5JjSOc5dzxLKJopJgpD/eNsVilRVw2J
         tMGyXNsPGHdpnjetXOiet9vhF2DeZgrP2vJxdoDsbUxbaZEYGXjfFD+YEgY0xnttS0P6
         s5L/gaACiAaKNU1QJdf5zrhb5LWOp0WBdfJApylTNmLBr0qJ2YVjdF6FijTkDfBG8KwA
         dUHg==
X-Gm-Message-State: AOAM530qp5GRg5CkJHwOg6l0owUvvwRHfXg9tGsY5pzzTVvyEXZCnyIw
        X4JvlmhjdSh6DTzBa+3yfzg=
X-Google-Smtp-Source: ABdhPJwXzQw7lHULSNga6Fsbn7ySFowlWuVSdMyItvEwBCJ0Dl/fPQjn/OualJKEREoTViv0bz/HWg==
X-Received: by 2002:a17:90b:3147:b0:1c5:d647:f76b with SMTP id ip7-20020a17090b314700b001c5d647f76bmr13011678pjb.161.1647476944517;
        Wed, 16 Mar 2022 17:29:04 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b004fa2830a03esm832272pfw.200.2022.03.16.17.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 17:29:03 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list),
        Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: [PATCH 0/3] drm/msm: Add comm/cmdline override
Date:   Wed, 16 Mar 2022 17:29:42 -0700
Message-Id: <20220317002950.193449-1-robdclark@gmail.com>
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

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 46 +++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  4 +--
 drivers/gpu/drm/msm/msm_drv.c           |  8 ++---
 drivers/gpu/drm/msm/msm_gpu.c           | 39 ++++++++++++---------
 drivers/gpu/drm/msm/msm_gpu.h           | 10 ++++--
 drivers/gpu/drm/msm/msm_rd.c            |  5 +--
 drivers/gpu/drm/msm/msm_submitqueue.c   |  2 ++
 include/uapi/drm/msm_drm.h              |  4 +++
 8 files changed, 90 insertions(+), 28 deletions(-)

-- 
2.35.1

