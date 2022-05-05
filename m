Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AF751B5D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbiEEC00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiEEC0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:26:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF054B863
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:22:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so6779227pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kWQfwEbK95xky/d4HhQ+FlkuBESmRWEkmfG0y0k6Yc=;
        b=E0/AMlIWlX2QfzeIjcII6CLO40b23wuotJIrvhbNd29xWOYF75GL9IxyRjbMEH3naM
         AsANCB3Fy3cr+5nzf3JHIOq+IjfbunSJufgQwTLzJbcW5i4TNAm/jUfGuve/2eOUzskf
         qXW4/DtXMQVPBSUo5zeSWcV+yX7YMsXsG4EhHGrVql08nzJ55l01RXDHJxKNwPzdHGQX
         bebb41ewRaKFw7OVwBKjJJgNLG7ib7GwVPZC3sivigfMwK1dVKPUz4fiEcy+v/U5yArC
         fIt9K9Ov6hZRs+8jNuT6VW9MPd5jf/P+fNfC7AWpBWs6ybvF7ber7gshyXRhW3tSeJ79
         NaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kWQfwEbK95xky/d4HhQ+FlkuBESmRWEkmfG0y0k6Yc=;
        b=4YYmj0eh/dQhMVAAeMh6lVHlYe1S446Ht2HaLrBo4Sd4D0s+ulkUIGqwrIzT4mmbol
         YnHB53GKf1urc9TnW7dHFEi0VWg4SeHa2q2HoTCgb0R4L7rboAXEkPWOtYUVUezCusAP
         yqA/LLAVlT2UV9mffrvJSz77+IIyOjnuEdUpfgaf8Qjdws6VcO41d/rZxyZ1Xw54NOBt
         ySS4PsMNvgoI4U0YuZZrGFbKBZPDwqm8RkrkUNDBSc2X2g10HJIZqBuJ/5DtMc9qI9lK
         A2+GGNo9MM8wFHUumXEorSg4SBodG+tzp/eiwIr0p/pbrfJ2rNaqgrJ4SuUaj9XNsKnS
         uaXw==
X-Gm-Message-State: AOAM530Tk6P5UjCoLKM1OPiob8NHh/6yTnYpebUMZNMw+Ylq59XN7Ydr
        YN+QMRogI1qtruvP00P0WpA=
X-Google-Smtp-Source: ABdhPJw1cWNP932SAnVrBHZI77Y5r2z3v4pkPgX8TpSZkODTuCZDIKhl7JkWU4n/DJecOdGqzDQ5rw==
X-Received: by 2002:a17:90b:380b:b0:1dc:6d24:76ff with SMTP id mq11-20020a17090b380b00b001dc6d2476ffmr3271725pjb.42.1651717364762;
        Wed, 04 May 2022 19:22:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q4-20020a056a00150400b0050dc76281a1sm86482pfu.123.2022.05.04.19.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:22:44 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, andrey.grodzovsky@amd.com, Felix.Kuehling@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amdgpu: simplify the return expression of vega10_ih_hw_init()
Date:   Thu,  5 May 2022 02:22:39 +0000
Message-Id: <20220505022239.58334-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 3070466f54e1..cdd599a08125 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -521,14 +521,9 @@ static int vega10_ih_sw_fini(void *handle)
 
 static int vega10_ih_hw_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	r = vega10_ih_irq_init(adev);
-	if (r)
-		return r;
-
-	return 0;
+	return vega10_ih_irq_init(adev);
 }
 
 static int vega10_ih_hw_fini(void *handle)
-- 
2.25.1


