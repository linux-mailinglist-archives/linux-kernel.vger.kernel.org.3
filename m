Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5434475FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbhLORtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbhLORtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:49:15 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A73C061574;
        Wed, 15 Dec 2021 09:49:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id n8so17112424plf.4;
        Wed, 15 Dec 2021 09:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vhyOznyTV9QH8gu8Nw3UR7ajxbnA0HywYBCbBtVxQk=;
        b=i59SkG8ooA17j7eRaKuGmszLdXRJ9XlkzktXQQ8rUJVbMokJCHfJGPobw/+FEyDSNE
         YLm68+6WfvHEOTZMSg7AlDe1JHUKJDf/zBqyQ9KMNWWCLe9HYYaz98INVs3p7lXWCDIx
         0QaSqVYFpIioR56ieDdVVNLw06V09GTgm/E1vZUH6TWwx1OQ+x8RKHaREef0cS6tyj87
         fKakSIyukuudhrAHmaMUZ139YaCeZu054KLm+Eu74Qw0DGgjqi/a31dHkL+Mr+RMQ7F+
         5IyR4nP2VTXE1tCVczcn1fI8sPn8gGixJVpyZc9LYt6rLnvnvZ1tVlfmPpTnQwVA2Mt7
         gvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vhyOznyTV9QH8gu8Nw3UR7ajxbnA0HywYBCbBtVxQk=;
        b=UZhqQh9fORRiiP7FxkZCrORo6570OlvlSLMv2iIMuq/0phs3IiVJNdMy4+osWvKNmu
         IxhG4HaQRzriJcSpiik+ihX/cX6raylqqTeyQU1xzsOcNfDTE+Ox1+JnO4KMRzaMVgfb
         u42w0G2lvQM0ge5IEWyoQuoYvxdAO8np7pXvRSRhm9KFTvShiCgtKngIrsGIO07oAzb2
         J25B/ZBLlI+LRrrvDbphXdO4Ogjk3VXeX7igGrglSXt9v4jjfdCotnogqa0vkfHk3zKF
         BNB83oxdiRhEqnDcECePekbsKC0+20L7HAXx4aD4Nl5LVcfY3Ic/fZjVQpOsHRiA0h6G
         8Rgw==
X-Gm-Message-State: AOAM530hMzvr0ci44vBJPB+xd84X1CCWFQpy4B09eRb7+KpmWkS1saaJ
        wzHnubBwt5gfUsJ7dfkWecE=
X-Google-Smtp-Source: ABdhPJzuJWeHQYluEP13CJGwTN5jzr23DgVNc6T2g1I2OJRc/gv5jplIzA9zmffU4ahOsD85yjjodQ==
X-Received: by 2002:a17:902:a40e:b0:143:ca72:be9d with SMTP id p14-20020a170902a40e00b00143ca72be9dmr12356214plq.67.1639590553940;
        Wed, 15 Dec 2021 09:49:13 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id k19sm3318241pff.20.2021.12.15.09.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:49:12 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fernando Ramos <greenfoo@u92.eu>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-kernel@vger.kernel.org (open list),
        Masahiro Yamada <masahiroy@kernel.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH v2 0/3] drm/msm: Add display snapshot debugfs
Date:   Wed, 15 Dec 2021 09:45:05 -0800
Message-Id: <20211215174524.1742389-1-robdclark@gmail.com>
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

 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c  | 28 +++++--
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.h  | 14 +++-
 .../gpu/drm/msm/disp/msm_disp_snapshot_util.c |  9 ++-
 drivers/gpu/drm/msm/msm_debugfs.c             | 75 +++++++++++++++++++
 4 files changed, 114 insertions(+), 12 deletions(-)

-- 
2.33.1

