Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC92D4CDE96
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiCDUWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCDUV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:21:59 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7F1177743;
        Fri,  4 Mar 2022 12:21:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so8811651pjb.3;
        Fri, 04 Mar 2022 12:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/syT7Y2eY46OVXh3uLQ0pEOp4t9Olrz81IvOtIGubc=;
        b=pBy/DWvZZiL+PVlFab76MNRYthBkf+JTWT0dnBB/J3HJUFg4iD/+Yn5TktceeTcFIa
         rUlXjyCodpdMxp/d9oixBNacs/pdnoxKNEjh6wBDPRAmT19PSBevFgAp3INjyiookgfh
         MbpvsZW2XIzbwQLswzB2S973dM5KNgFodXbEwzDrWFasTU4PzgD8pK9G5Z698OtsiDVJ
         ymhTaqmCBEFrplXlUYM/3WhinFrbzz3JsH/nEamX+L8+Qcc5IGaxh9MnEtYxGwEyKmf3
         Axr6ltVJD8yozzNVIRtTbF1qohzE1uf0Jdi017er2CCS0uBVjYh1Z5YmyzTt4PU12YXg
         qifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/syT7Y2eY46OVXh3uLQ0pEOp4t9Olrz81IvOtIGubc=;
        b=j23ov2vC8sdfqcd1Zf4nUHxb7oAxSp45neKNKaCb2mHPpr1JeazakqgEEcDTPyVook
         mF1fhf5bJRTrS9Ivjeh4pUV8/OPAEj5tku/xKZUHbIpuQem3OJneGgPLWMBvPy01Rt4E
         KM+uA1FpYa5X4mizg+hmLjnvx8H5uSbQd58MKTf01+IdCkYrd1n6pEoXtHsj1VsQkN4O
         Cwg6ChWB1gUjJ85p6zKalFL0r3TO0AUjoqph6rkl4X4Gn/EKkMvMkZsFSovXROYZeoCD
         X0yAEik/H18PCVmEdX9kUMfdklTYPOpL/kcbdOhcRE1LDFYImC55nnNpt6aI7CUT2xTn
         IofQ==
X-Gm-Message-State: AOAM5317SXJ8JQU+3GpzsrC1yI56kru/dzA9wn2e9CpEbIaExccDO5/8
        4ojh+vW/mCDg7nDQBvq17LU=
X-Google-Smtp-Source: ABdhPJw0l7sG4pT7XOonU9d1+7+hi2g1s/G+O0WZFo9stDIm1EKxnhjv4E/nEpUN6639n1X7lB0o5Q==
X-Received: by 2002:a17:903:1c3:b0:151:a54b:95f4 with SMTP id e3-20020a17090301c300b00151a54b95f4mr110414plh.10.1646425268705;
        Fri, 04 Mar 2022 12:21:08 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id q15-20020a63504f000000b0037425262293sm5051165pgl.43.2022.03.04.12.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:21:07 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix dirtyfb refcounting
Date:   Fri,  4 Mar 2022 12:21:45 -0800
Message-Id: <20220304202146.845566-1-robdclark@gmail.com>
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

refcount_t complains about 0->1 transitions, which isn't *quite* what we
wanted.  So use dirtyfb==1 to mean that the fb is not connected to any
output that requires dirtyfb flushing, so that we can keep the underflow
and overflow checking.

Fixes: 9e4dde28e9cd ("drm/msm: Avoid dirtyfb stalls on video mode displays (v2)")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 96b379a08327..7137492fe78e 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -37,7 +37,7 @@ static int msm_framebuffer_dirtyfb(struct drm_framebuffer *fb,
 	/* If this fb is not used on any display requiring pixel data to be
 	 * flushed, then skip dirtyfb
 	 */
-	if (refcount_read(&msm_fb->dirtyfb) == 0)
+	if (refcount_read(&msm_fb->dirtyfb) == 1)
 		return 0;
 
 	return drm_atomic_helper_dirtyfb(fb, file_priv, flags, color,
@@ -221,6 +221,8 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 		goto fail;
 	}
 
+	refcount_set(&msm_fb->dirtyfb, 1);
+
 	drm_dbg_state(dev, "create: FB ID: %d (%p)", fb->base.id, fb);
 
 	return fb;
-- 
2.35.1

