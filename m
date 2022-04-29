Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F281514209
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354337AbiD2FyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354327AbiD2FyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:54:01 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5997EB820A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:50:44 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id e17so4697191qvj.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DklJelbXiO9l3sUAo4sjuOfTEZq9ByjiZR6q47LXluQ=;
        b=iiZWLdnO3B5+JPqgd5k43eNW94FFVOxBc/KOlQYyrvA3iQ/OVJ1wi/WgAZQJGt1+YP
         O1F92kb+g5Gfi113i583WuyQW1HbpKtVt0TYnDBetftZ/F7FwLplyQZifP4LmAteL7GS
         JTAqImUsmRlsc/u+3gq/H9ZQUcH4YOVsPgQYldCh9wrEUvqRbbUjyEMWnBOzZc13RCNl
         JaGWkNDpY7Eqd5ksCcaLsmPXPMPJF3U0PM2yYPNG95WnYAA+sqLM8BlL3ctpiiwwy2zA
         TfnOD37kj/eGBpDCFc3fzahf8qhIdgiE48J7EgJQWUKyifA/pYvv7LgOHm7DLpyMOKzH
         dw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DklJelbXiO9l3sUAo4sjuOfTEZq9ByjiZR6q47LXluQ=;
        b=pQM02DDTrPbbEZ3Ztrjp/H3KpEXUjy12z/QX4K/8vQCgGmOemP+BD1soe1gvWRJPtl
         KxuLHUGbFbLU95SYutW//k3Xnv0Hna4chPxQKWsgQBsZgtcqMHYe2Mw9LFnc01wtg9XB
         rELh/dYOuwoZYpwawwT0wqFW0g1jYpI26WKzjNUcQU+oYVVc5NKoqQ+EJKnBYyeYtBfV
         E7pfrBZTBWKpuDn0pl2W2sQoKvIS8Fusvwdq0mb8kajmt30yCJX97my+AXscWVwDTVZ4
         8Efj3+HXoZdmOB/Mck6S85StimNLaPlvDuMk+y7T+T8m5l2nJ3b1pE6XCUEZc2d9cJcz
         9ZXA==
X-Gm-Message-State: AOAM532bNmUxf1YfFahFqpOHZZePzpTEEshZ7oRg1+Ooh6V5tD1S3EeY
        5HqqCXwWSq4vKLmpZq3+hz9VhTGFjak=
X-Google-Smtp-Source: ABdhPJzCXI2X6OuPnMzQGH6YeEQlUvgt8yFPZags9OQcY0fuj65LaZ0UZaeHOysnyZ+d3Z4GR0KEJA==
X-Received: by 2002:a05:6214:2025:b0:456:3a96:f443 with SMTP id 5-20020a056214202500b004563a96f443mr16579441qvf.86.1651211443556;
        Thu, 28 Apr 2022 22:50:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bi17-20020a05620a319100b0069fb4fc24d3sm876486qkb.114.2022.04.28.22.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 22:50:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amdgpu: simplify the return expression of navi10_ih_hw_init()
Date:   Fri, 29 Apr 2022 05:50:37 +0000
Message-Id: <20220429055037.3852147-1-chi.minghao@zte.com.cn>
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
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 97201ab0965e..4b5396d3e60f 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -593,14 +593,9 @@ static int navi10_ih_sw_fini(void *handle)
 
 static int navi10_ih_hw_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	r = navi10_ih_irq_init(adev);
-	if (r)
-		return r;
-
-	return 0;
+	return navi10_ih_irq_init(adev);
 }
 
 static int navi10_ih_hw_fini(void *handle)
-- 
2.25.1


