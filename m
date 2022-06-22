Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE33555409A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355957AbiFVCjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFVCi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:38:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9B324584
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:38:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u37so14807994pfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGahv1UkYohRmUNftmGc3sECtNNFfGUIAgRvhZC4Bt0=;
        b=LbibEVgq4fVFIL0WpewGwGOEOv3kwfMm6PPFMGEzbGHk5MR6p2sYNX+2rsWvIsywgd
         SijJOw4KdqcFv0Ol6DRWsR3bvMNoBwIOwiUbN4rbyBIjCYUjWug/pGMEvpgnLUsViItD
         YyY62B53YGy2BVv+KApxb0zd+k7ptMSesM6Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGahv1UkYohRmUNftmGc3sECtNNFfGUIAgRvhZC4Bt0=;
        b=wekYsptWyjjB5DelHfBbRR+jrawWeKLkHTYzzUt8dbuszxIl/dgEPu6B7KdwFr4pg9
         UiVmTNg2NnSRNGonOTsSgROByLw3FWQscJaxbo2p5LCXpNmpHN2IGQgQxF7D+0fRdaUg
         awG4CGUKZSeJfNf1juJnoo20ARu2c57MVSma0C0jAS9goR6ltUfXjP57QGsjJpfErAMS
         HnYGfUwMTgAlspXS1L8aQjS7Q+ibaOlJrKd2G4GyKhGL5TkRrjzlWc/BTwHu+q5aLIxU
         v0ctIYsb70C6ols3PBuzv9E5V+8HZUtuEQqq/FkMro4NFbsBmpnFMMw8mYFZlcsKs1U+
         3gaA==
X-Gm-Message-State: AJIora/Q2AMaWDarJ0sy4o1eUxQAk/0NDF/U8i9ajOVpwxqXkMoUmJdR
        ID9lV4kdNtLBobomSaGsYAq+dQ==
X-Google-Smtp-Source: AGRyM1u8Xz3E9eBHmOq7oDjE6oJp+zYRzprNRNlxNeOfnsMRr5u7zy3v4JTXzcxNxNrSnPUsPftsjQ==
X-Received: by 2002:aa7:83d0:0:b0:50c:eb2b:8e8a with SMTP id j16-20020aa783d0000000b0050ceb2b8e8amr32998039pfn.31.1655865537928;
        Tue, 21 Jun 2022 19:38:57 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:cfc4:cd7f:b2c:a07e])
        by smtp.gmail.com with ESMTPSA id b143-20020a621b95000000b0052536c695c0sm2487026pfb.170.2022.06.21.19.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 19:38:57 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Mark Yacoub <markyacoub@chromium.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: [PATCH] drm/msm/dpu: Increment vsync_cnt before waking up userspace
Date:   Tue, 21 Jun 2022 19:38:55 -0700
Message-Id: <20220622023855.2970913-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'vsync_cnt' is used to count the number of frames for a crtc.
Unfortunately, we increment the count after waking up userspace via
dpu_crtc_vblank_callback() calling drm_crtc_handle_vblank().
drm_crtc_handle_vblank() wakes up userspace processes that have called
drm_wait_vblank_ioctl(), and if that ioctl is expecting the count to
increase it won't.

Increment the count before calling into the drm APIs so that we don't
have to worry about ordering the increment with anything else in drm.
This fixes a software video decode test that fails to see frame counts
increase on Trogdor boards.

Cc: Mark Yacoub <markyacoub@chromium.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
Fixes: 885455d6bf82 ("drm/msm: Change dpu_crtc_get_vblank_counter to use vsync count.")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 3a462e327e0e..a1b8c4592943 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1251,12 +1251,13 @@ static void dpu_encoder_vblank_callback(struct drm_encoder *drm_enc,
 	DPU_ATRACE_BEGIN("encoder_vblank_callback");
 	dpu_enc = to_dpu_encoder_virt(drm_enc);
 
+	atomic_inc(&phy_enc->vsync_cnt);
+
 	spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
 	if (dpu_enc->crtc)
 		dpu_crtc_vblank_callback(dpu_enc->crtc);
 	spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
 
-	atomic_inc(&phy_enc->vsync_cnt);
 	DPU_ATRACE_END("encoder_vblank_callback");
 }
 

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
https://chromeos.dev

