Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA6F514503
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356225AbiD2JFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiD2JFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:05:35 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D534EC42DD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:02:15 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id b17so4915764qvf.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ftw/6Pk4qbemIBSil+khGkXsfOxW2R3zaTxbYT7tF+A=;
        b=g9I5NVSJ9ufUt1fbkyLlV3mWDiV9nFd2/RUyQGVUzcNDw9sl0UmRAWosE4/J4sazEZ
         8iWEoZ8Xx7QFktAcdgQJkezZLP6ZjvM5iVoHlj98+CHXnP7mm2DgzQNe79yqXjJt3B5l
         d9xYEkwbCpoMZ93dZXAvm5yNgaMjz5CiT4YLxKRTXCktZ8h+NLc9NbndeS5CkVnzr9eA
         SbJA2+Ryiq7ZFqqFlu9eBmDsUqDmRplRCb+SWSY6HcaIUHMDruLqyGVjEe2p8LYlrbtI
         hcoogv5MEsakduy4A1uIgDuKKYKEkt0VmtRAEJAhMh8hsjciDgAEjPwJd6iqnAIKg+sK
         g3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ftw/6Pk4qbemIBSil+khGkXsfOxW2R3zaTxbYT7tF+A=;
        b=N9N7TzjEJppZxEwX69sN6gDHCZp0iRiSUJJH69j/pC8fkNE7pjFCVd5SkXZcZvUuPY
         sr5mqAPEoz+LfFaJSE1JWqUJyKbT45PMNWgYj/oLjzcSGmW68VH/x7RZdqQoqsvL+Y7r
         Iz07vNmHg+8jnN99V/jXUefe0qFz0Ucd9TK40ZFTdEdO2OlfaIPfok16S6T9yPkp6uaZ
         P369hkkAsPb5AOmCKEz1e4/uDTwa0xB0HMhU8sPTIZy1QFgSG1PF+t3fbFZ6BQx1x0Sw
         yJDZ+ocOmXw9CvZ1hvwZW6pM5jJpPYxgfkGkCaNmGUjz0BP/l8JK0/DoeiYq20XW8HhY
         +lZw==
X-Gm-Message-State: AOAM531aWqyvdctCdgCJWfcgahdIQQuttQFqqCBvNFRLTNP2vv6pXYBl
        Y4bHkw0+7mDF57L3ir7RK3A=
X-Google-Smtp-Source: ABdhPJyn1R6CWyOXY9xNshd752lxFwFyqlwS8tg5kNtq/QkhdR372HrgV7iIUfVitFDTvN2FfKOdOg==
X-Received: by 2002:a05:6214:2485:b0:452:ce7c:2dc3 with SMTP id gi5-20020a056214248500b00452ce7c2dc3mr15545677qvb.9.1651222935039;
        Fri, 29 Apr 2022 02:02:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a0d5500b0069c59fae1a5sm1106657qkl.96.2022.04.29.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 02:02:14 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     emma@anholt.net
Cc:     mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/vc4: simplify the return expression of vc4_grab_bin_bo()
Date:   Fri, 29 Apr 2022 09:02:08 +0000
Message-Id: <20220429090208.3852879-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/vc4/vc4_bo.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index e451cc5bcfac..49c0f2ac868b 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -738,19 +738,13 @@ static const struct drm_gem_object_funcs vc4_gem_object_funcs = {
 
 static int vc4_grab_bin_bo(struct vc4_dev *vc4, struct vc4_file *vc4file)
 {
-	int ret;
-
 	if (!vc4->v3d)
 		return -ENODEV;
 
 	if (vc4file->bin_bo_used)
 		return 0;
 
-	ret = vc4_v3d_bin_bo_get(vc4, &vc4file->bin_bo_used);
-	if (ret)
-		return ret;
-
-	return 0;
+	return vc4_v3d_bin_bo_get(vc4, &vc4file->bin_bo_used);
 }
 
 int vc4_create_bo_ioctl(struct drm_device *dev, void *data,
-- 
2.25.1


