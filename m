Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA2556AD57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiGGVTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiGGVTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:19:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC398313A8;
        Thu,  7 Jul 2022 14:19:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y141so21848637pfb.7;
        Thu, 07 Jul 2022 14:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Mqly/bmUD1+v4qx6JacIhpg9Ul0/6TMbAP2G8iAsIU=;
        b=Jy4LjqYXsHRJLEuWMy15VqPLyEiaTsf1cyTgG4LnEAnQ7+ZyzBgRaBgfsI3OLsSR25
         AuLZIiP5ku1xcxEhyGX5xE6iCy8uPyufdJk38lQyS+2dEFVCnjKfrxa9QjazqgFtkLNt
         XalKugilrwzxZdCPatAWtUZ10lmpfA0Dtsql+0SPL9T2QedYTIpGZoBWxMfR+mvz1XxA
         oIianSf1mDs/H+/vYnKJFDZ2HpWIwjTIINByzQRlhyKgKGjFW1OTLD/crJxSprvn7wwb
         D0tbQYBroY3kOJ8Syaut1HUYM0gwZXrTTqT3pWsLinpnHkfx4W6B1d29eeE02zENM2E5
         4wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Mqly/bmUD1+v4qx6JacIhpg9Ul0/6TMbAP2G8iAsIU=;
        b=L/qETWjrX7A90bI8m0ja6buSlEPyCLCrGbLW/L9m9U1k0oPqeECVT20nSb5DCzHtb/
         cLgDTz9yYVELo4zvl/gpp0DtJ0JX1359nal9O50Mv6mLKfyfnI7pjRUDxw28unPEOJh3
         vbhf+71Zl34U7QEivlKHRC2SkY335HXqp8SwqR8c5H9xdipFEmPAV/HbEiBQ00ambkeG
         bWIGZ4pTv7v+rRL9FP56r81qKJqvtFhe0MfvWNOMG7DaKypyRfzZPRc7+pMYCE5V/6xc
         Qle4gjqj6EqEnTHR3o5G3YvRwnspNK5AdGFNSdQbNdBSjEJwjRdL6b3CqLHMgLDKeb89
         iJAg==
X-Gm-Message-State: AJIora8vHH7VqyhCu7dBjYmoa1pWOmvybzPG+ZN+eNfE39SLEatkWCYy
        EXmjsyiYkDLT88FAIOcrf7Q=
X-Google-Smtp-Source: AGRyM1t5W9ZMr1j90syEK2lDjCt9pxLeU/e2mHN5T0KEFQkQACvggQZHVEjihw+PqNIHYc4CePKp/g==
X-Received: by 2002:a63:5cd:0:b0:412:b163:b7e1 with SMTP id 196-20020a6305cd000000b00412b163b7e1mr51911pgf.451.1657228786230;
        Thu, 07 Jul 2022 14:19:46 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f70c00b0016bfa1a5170sm5207389plo.285.2022.07.07.14.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 14:19:45 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Fernando Ramos <greenfoo@u92.eu>,
        Mark Yacoub <markyacoub@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/dpu: Fix for non-visible planes
Date:   Thu,  7 Jul 2022 14:20:00 -0700
Message-Id: <20220707212003.1710163-1-robdclark@gmail.com>
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

Fixes `kms_cursor_crc --run-subtest cursor-offscreen`.. when the cursor
moves offscreen the plane becomes non-visible, so we need to skip over
it in crtc atomic test and mixer setup.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 4dd0ce09ca74..4ba000951a90 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -422,6 +422,9 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 		if (!state)
 			continue;
 
+		if (!state->visible)
+			continue;
+
 		pstate = to_dpu_plane_state(state);
 		fb = state->fb;
 
@@ -1195,6 +1198,9 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 		if (cnt >= DPU_STAGE_MAX * 4)
 			continue;
 
+		if (!pstate->visible)
+			continue;
+
 		pstates[cnt].dpu_pstate = dpu_pstate;
 		pstates[cnt].drm_pstate = pstate;
 		pstates[cnt].stage = pstate->normalized_zpos;
-- 
2.36.1

