Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131A14CAC8D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbiCBRx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244274AbiCBRx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:53:56 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6F84D264;
        Wed,  2 Mar 2022 09:53:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p4so1644129wmg.1;
        Wed, 02 Mar 2022 09:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=taNgSNhxg9N3wuTnv3IGzP0mdXY6UY0XfdCeGrzzq/Y=;
        b=MgdlIRTOp3YlTZro6MDHiqoujLSrj5MfJzYocJ8habuXr4dd7A+9HWsTXgmUqkUDKj
         B+KlGC7CX4dNJEmCGUW6RsuGT8E4BnyUpel1kJSl++W7adCyJVb5p+aeR7AX4C1ZmRM4
         3fcnbrJCwK8e+W/JbX03L1TJgDn2p58e7QNwYw1sXgL3BcOmLKAIIMGbInu/i8G7LuT5
         OS3+Py294/wKRO+5C/kjCtdQuVI8q1hsAakQVOIMWsefbncBSBvFyAmp5i0Mx/z/tqsE
         7N2Jaxf7/thUWkB6H3rf8Nj+7v1ARGUa4V8YCGkRYFPZZnI/TnrCKqsZL2Bu01dJ6UIL
         QF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=taNgSNhxg9N3wuTnv3IGzP0mdXY6UY0XfdCeGrzzq/Y=;
        b=7UsAJ2dSeffk7g4NbGGQcfr5mYvMK1NNspV79qX/Y/9mFC92sUly2VslQCiWJ+8MdE
         L0KRCM6K0AwbR6hT0aaOvRdEW+ZkBDRSCMVUJYcGy48uxkAEYEeP1PpvrQZaGdhwe6tN
         gTL1kWk2AaioKlEotCVsCUPqoW2uWy1ldCBzIWTtmcBkTwM+pC0Hk486uX9ha0RNXV8S
         kjfoDHMuGJ/PXlGrLvOh27bIwr0guU6vKgUSCsazcW0lMxsqHfAiAYQFrwchT2UKzkYg
         XCPOhD/F2TJH5MPIif3TEh0jhgacSCYj8RNz+gvb6EDVLxPYugB9lH9I9J6Ll3o/NDjI
         izSg==
X-Gm-Message-State: AOAM531GqFGBJ/VP7zxm7qKhICyfdKcSHrWDRsOgQBpCLCO/bxnFCMRw
        c3i5BqR2wr2LKs3hanUwvDU=
X-Google-Smtp-Source: ABdhPJwJ1bg/pYRWnDLXycY6T/eklZz3ePlRz0PnU/mgJ05UV7us4cJ8RzjeoXgqSrrMoxBQk4H6rg==
X-Received: by 2002:a05:600c:2e54:b0:380:d3c8:ef33 with SMTP id q20-20020a05600c2e5400b00380d3c8ef33mr737901wmf.69.1646243590547;
        Wed, 02 Mar 2022 09:53:10 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d590f000000b001f04b96f9a9sm19510wrd.42.2022.03.02.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:53:09 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH][next] drm: ssd130x: remove redundant initialization of pointer mode
Date:   Wed,  2 Mar 2022 17:53:09 +0000
Message-Id: <20220302175309.1098827-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Pointer mode is being assigned a value that is never read, it is
being re-assigned later with a new value. The initialization is
redundant and can be removed.

Cleans up clang scan build warning:
drivers/gpu/drm/solomon/ssd130x.c:582:27: warning: Value stored
to 'mode' during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 92c1902f53e4..ce4dc20412e0 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -579,7 +579,7 @@ static const struct drm_simple_display_pipe_funcs ssd130x_pipe_funcs = {
 static int ssd130x_connector_get_modes(struct drm_connector *connector)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(connector->dev);
-	struct drm_display_mode *mode = &ssd130x->mode;
+	struct drm_display_mode *mode;
 	struct device *dev = ssd130x->dev;
 
 	mode = drm_mode_duplicate(connector->dev, &ssd130x->mode);
-- 
2.34.1

