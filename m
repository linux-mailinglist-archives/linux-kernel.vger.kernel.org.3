Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9EA462729
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbhK2XBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbhK2XAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:00:37 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A91C03AA2C;
        Mon, 29 Nov 2021 10:18:27 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id s37so7271592pga.9;
        Mon, 29 Nov 2021 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fUNuveYGMtrqjB2VQZVCUJJ1mSxi3vYF+lEWoSAESLM=;
        b=SdrRH1TrlPjoH3o1ImcgrE+JbnNbd74DzvJjimwCmDhp3OiBNEk18o0Ys4Uicpze3g
         zCw9IGuUC4v9BZ3CYiScmVgbZeZiuvOS2RLrM/6RhKvqepnADkdKhvVbDrJ3NewrVm2e
         QkJbwFI67r2N1UWhs9XjfbDcNC8N67++NnHIH83L8flrOCi9RFPkIyFGQxiwV1+t69kZ
         xb3y0ca8ks1Fwi5AovNNmkOezoX6/KDZR5IqLoti7r5uqWZ7tAFDuyivhX2knAKqZNQi
         4RHrssSrZg9WIhHbA/vUFfaq8NU/kED7xEz2fNqm+STCQIV0P9QO+dogodmRpk1RwMzw
         9gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fUNuveYGMtrqjB2VQZVCUJJ1mSxi3vYF+lEWoSAESLM=;
        b=40xj9Va9rI4ToSET+4h1yOyQ8UTET050SJJ7RTtVLI31JLuryD32kMDwbNHSfOPsd1
         MeG3tqAkYUXbPFkACt9/mDzr+ILxE99SIwM6kT8dlor+g5EB0FI90h5mMVqIePAWnl5a
         TBDBHcfe+fiWAH20ndctXyOFUKSZaJS6eleLP1qpcCn02po8bbJQRVm7kPCVvwnDyJom
         ltAwdAhgHievH70fL3FEUoW3oeKh+DvZbK3IxvRYI4pUCE3CFFB1psNj3Gm6TRy/GAJK
         spigzEvXJ40VGOJY9TNMaUOvZZXdcJtvbrmDjhgCp2NBCd/hcoHdHH2/zvk5aDpS7Tv+
         XLMA==
X-Gm-Message-State: AOAM532EzfOYEhDkKBFvoI/JH5T7fR2FLQKVz24qHfnFJVPcp3/ZdPnF
        YypxTed1rAUnu7wPyJPi32Q=
X-Google-Smtp-Source: ABdhPJyJeydSjX4k1OB1bo6HrPO31iSNMLC3cBqM8orkTUv7tItFGjyOmE00ZWY2AuQIhUqjA3OxNA==
X-Received: by 2002:a63:3190:: with SMTP id x138mr35037673pgx.401.1638209906886;
        Mon, 29 Nov 2021 10:18:26 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id d7sm19415554pfj.91.2021.11.29.10.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:18:25 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/gpu: Don't allow zero fence_id
Date:   Mon, 29 Nov 2021 10:23:44 -0800
Message-Id: <20211129182344.292609-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Elsewhere we treat zero as "no fence" and __msm_gem_submit_destroy()
skips removal from fence_idr.  We could alternately change this to use
negative values for "no fence" but I think it is more clear to not allow
zero as a valid fence_id.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 282628d6b72c..6cfa984dee6a 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -881,7 +881,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	 * to the underlying fence.
 	 */
 	submit->fence_id = idr_alloc_cyclic(&queue->fence_idr,
-			submit->user_fence, 0, INT_MAX, GFP_KERNEL);
+			submit->user_fence, 1, INT_MAX, GFP_KERNEL);
 	if (submit->fence_id < 0) {
 		ret = submit->fence_id = 0;
 		submit->fence_id = 0;
-- 
2.33.1

