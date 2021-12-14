Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C220847497B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbhLNRd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhLNRdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:33:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBDAC061574;
        Tue, 14 Dec 2021 09:33:55 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u80so18433572pfc.9;
        Tue, 14 Dec 2021 09:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aiq9nNSvlZRUirau9B4I1N3QBcTBVS4NyHnI1Y/cwlI=;
        b=mZkyLk6P3Fp0rIPqxiycuhn3j5MLBRUp2miZAgxJhL0SIlwWwjdR6y+PuFOQi9pg1z
         f0vJkHft1DfFaFyxh6nB/BI4Gs1M0f+ceJtVSg7dkI+oSnL3GdC/wf7mVgx2w1BuHacQ
         xvAW3TzawJRnN2JZdJvyzSIZiM4F7cN4CGmQmv6cUvVUr929Uu+KQwSHu6iYWMUttB1M
         LUBk/9EjVuw/g8bSyY2jiYlfmONM/IGUNnI3qYluzJfcTSdAb8c1e35D6beJPwcROSdO
         /h41ViHPDrk9Fu4pH8fdaQuHdLBhSwiAhmAtfDwe02wAAmTUqVbTCtyeIMlBDaTybmrX
         Xnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aiq9nNSvlZRUirau9B4I1N3QBcTBVS4NyHnI1Y/cwlI=;
        b=ZzwnLr1rJhPjeVC6Fozow4bYH3EstS4arpXLEE1osQpE8PKMDElx6JAwfGzH5dZmmy
         eQ2QkHZBUYnkQWUD1kwRb+eQ3qlj8xOrqp5OhNOE1KNUS9goXfOdFQSEPJfwvVE9PhDT
         Jr4Drr95FidqRuN1yz5z/PtctmJqfdk58m14wkC418GXvlUMF6wgU7Bq9lpISlms2bNT
         Mfnk7tq6GhPO1RMRgSxQxhDoGHUrgTfdcRJqi9NiKQvr7XMqZmBA104mR14TJ8OmgPhy
         ybkq9E4L1jVGnpuCgAwCzHWBtfhkCV5T1dyItDtXDk2zBBSs0fmiEBd/OH5iCZttNlQk
         9EHg==
X-Gm-Message-State: AOAM533MlF4Xz0o6FJbg8eLFuOyQ247yopahqAY5/Qm22gkgPBs85Mva
        BMGHxPg7bJPNTQkmwscBCWQ=
X-Google-Smtp-Source: ABdhPJxQRcmEWi0VOIERaMxn3AGDNXnCT28ghoDG1tX8uXegK9zrHvboi8MntbRDd9WYTe1yrWhwCA==
X-Received: by 2002:a05:6a00:809:b0:4b1:33bd:82f5 with SMTP id m9-20020a056a00080900b004b133bd82f5mr5350689pfk.71.1639503234457;
        Tue, 14 Dec 2021 09:33:54 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id l13sm438617pfu.149.2021.12.14.09.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:33:53 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fernando Ramos <greenfoo@u92.eu>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-kernel@vger.kernel.org (open list),
        Masahiro Yamada <masahiroy@kernel.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 0/3] drm/msm: Add display snapshot debugfs
Date:   Tue, 14 Dec 2021 09:38:58 -0800
Message-Id: <20211214173917.1496290-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

This series adds a "kms" debugfs file to dump display register + atomic
state, which is useful for debugging issues that don't trigger a display
error irq (such as dsi phy misconfiguration).

Rob Clark (3):
  drm/msm/disp: Tweak display snapshot to match gpu snapshot
  drm/msm/disp: Export helper for capturing snapshot
  drm/msm/debugfs: Add display/kms state snapshot

 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c  | 28 ++++--
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.h  | 14 ++-
 .../gpu/drm/msm/disp/msm_disp_snapshot_util.c |  9 +-
 drivers/gpu/drm/msm/msm_debugfs.c             | 90 +++++++++++++++++++
 4 files changed, 129 insertions(+), 12 deletions(-)

-- 
2.33.1

