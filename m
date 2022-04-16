Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5985034A0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 09:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiDPHTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 03:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPHTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 03:19:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825E24BBAE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:16:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so9928386pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ozXCCzZFy+HRu2SLOUddJjWyrd/kjN8vo4xUFqlmf7A=;
        b=VqgpSn2s4VRF2ypGXaHEgF56qrSwD9NV2NEUMXLEo/5nQ5d/oCQwSV58EQiwUt0X65
         JjSzVFP5j9Px9iJ3Nc4IzwWY9U1327qNfVNTpmAKXdD1NTlhB9WRaSQ3SvG4idkRMQSC
         DGyp00+XQY4uZyPTUO6/WWOnQBQ91DL3lHhYtU8+MRvCT3x7gTHQWpyKsJhwqTmxA0Yt
         Xq8nSMagqdGzljFTwy0fd2Tev/z/asivbOTV8/2l8lKCg0svUSirnQa5YeZj69GtQNru
         vWmROyw/0rfJlcuQHSuR4OluNEikQDNE83nSWxr103n4JY4txmedzpDNFvc3lbIia0tj
         toZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ozXCCzZFy+HRu2SLOUddJjWyrd/kjN8vo4xUFqlmf7A=;
        b=NYQQH5cmIa0ix3R+fidv7J2njJOhEULbQYKis3pPILueTNYJ3byh9i23Uzt+Lna7WV
         Qzpss0PJBbixqB1JTFzFAzh6OGtPnhroA/R8gI9xoJoe7OLS7uFFGruaBw7BmxWWS6hn
         bbybYMgPoCdbHy0Sx6UhlxvHhtqF1mlRSyso+m3IZcMAXuftOxRQe0Pp0xBY/4+7SolT
         pZPXeOF8UbZNkL/3nD7j0VMNKMpuirNdXzuGX5y7vTtVLLxOaelqBHfx73hFllb0rYeZ
         VZ5iXhBr1kv3Mtai+ks0YDsylP1/6vHsVDOLzlUX4MQ4UkqnUqYRTy8qYveOKrnHx4oZ
         UXaQ==
X-Gm-Message-State: AOAM533ZgpCVVwuTSjaM/fxSOScbOiEePx4rFdYmvUOJD5VGQiRqqsv8
        5OHaJNUnVwf3eKFPXJAR49656mXuMR/3M9xZ
X-Google-Smtp-Source: ABdhPJzXxn2kvERPaatVMAFHISSK95wLaaKsK4u0JDL5ofL+u6wyg7EB7REde1pRKhDLoIn/j+39WA==
X-Received: by 2002:a17:902:ecc4:b0:158:29c6:f9b7 with SMTP id a4-20020a170902ecc400b0015829c6f9b7mr2478908plh.21.1650093407985;
        Sat, 16 Apr 2022 00:16:47 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id h72-20020a62834b000000b0050608e9824asm4909264pfe.122.2022.04.16.00.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 00:16:47 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] drm/armada: Fix a potential double free in armada_drm_bind
Date:   Sat, 16 Apr 2022 07:16:41 +0000
Message-Id: <20220416071641.30386-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

priv is a managed resource allocated with devm_drm_dev_alloc(), so there
is no need to call kfree() explicitly or there will be a double
free.

Fixes: 90ad200b4cbc ("drm/armada: Use devm_drm_dev_alloc")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/armada/armada_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 0643887800b4..142668cd6d7c 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -99,7 +99,6 @@ static int armada_drm_bind(struct device *dev)
 	if (ret) {
 		dev_err(dev, "[" DRM_NAME ":%s] can't kick out simple-fb: %d\n",
 			__func__, ret);
-		kfree(priv);
 		return ret;
 	}
 
-- 
2.17.1

