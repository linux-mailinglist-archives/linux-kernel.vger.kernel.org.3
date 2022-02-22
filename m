Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40BC4BF8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiBVNSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiBVNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:18:12 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A02FBB0B0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:17:47 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so8311987oot.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJggk1To+XLut1ObcBuO//1+OtwNQL2IY8utthiAw+M=;
        b=M5U+hrmDa39RJmpT6cpDMWuT1ftn8C6oDHPdv+0YjkKjP3plzi/1n7Yos1ZJvj5TWL
         oSJ6jfHTPW6wOoEzXfnmv0O6XULQpIlFFRouo6PlM2daWq3ng4LttobHWIUFfhweB76U
         cbnu0WB5CVQAQUu+9ZsF71wZFXSr5Tr2Q3GSMDmVZTSvqqUBxkN8maDIQdoR6mbTHnzl
         +sXNxOLwoN5wFXpDoydePtV49H1x/bexC6s0pumgdWV1YSFBFau+iHG9qfZvXDzLh5Dp
         R5V1tJuwXzwOTm8SeUcVi5RKzf90KB6fCi/7MmcsgKU7TGU4UFNug4thzgm77mP9WDgN
         jpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJggk1To+XLut1ObcBuO//1+OtwNQL2IY8utthiAw+M=;
        b=6GtHFBpJs44cJP3s3Q1h9vTo8Hf0x76VlmRC9FjwTmHsRXwKxJI+oAkDVhg5MnDGIc
         oGNGUSVdg+gwDRhL6taeiV7lfry+qmXzSX94lH/dp7NzSQZ7yvhfEXLfl4oyjSjIk3ja
         tsdvcwMB+eWRyVeukIfrh4as8vMWJPIpO0V6h0tpgzxZq0sWzgw75hjHuS8n2g7S8ClA
         Y/LMwaneZ7j1lSfqQtmL3E0/bxpmPCrCMkf0dZr3laVisEumoWYRzECMGPSlXJpcYc4r
         /uUFIU+aMOrf1uJUsF8iq7lhC33+70RMLLLu43KEuhpxRzQYVfZ1qpot9acGsR9PDHT4
         OJVg==
X-Gm-Message-State: AOAM532ZhkKl3o2mW1Es9ED+KVgMmHzPCTBVlsgfALyFjz1gRyJrVpJy
        s/JS85tyG8FR8OV1nh4sxYdKwP5Vl++FeVZ9
X-Google-Smtp-Source: ABdhPJyEmLFkADch2Vvvvc2TiPZFt4fsErzfmYtqCPhQrfpy8eB9rJIReQvGDozdKk6LKkOtj8RqLQ==
X-Received: by 2002:a05:6870:c898:b0:ce:c0c9:660 with SMTP id er24-20020a056870c89800b000cec0c90660mr1543821oab.178.1645535866494;
        Tue, 22 Feb 2022 05:17:46 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:17:46 -0800 (PST)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, Hawking.Zhang@amd.com, john.clements@amd.com,
        tao.zhou1@amd.com, YiPeng.Chai@amd.com, luben.tuikov@amd.com,
        Stanley.Yang@amd.com, Dennis.Li@amd.com, mukul.joshi@amd.com,
        harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, magalilemes00@gmail.com,
        mwen@igalia.com, isabbasso@riseup.net,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH 02/10] drm/amdgpu: Remove tmp unused variable
Date:   Tue, 22 Feb 2022 10:16:53 -0300
Message-Id: <20220222131701.356117-3-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222131701.356117-1-maira.canal@usp.br>
References: <20220222131701.356117-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable tmp is not used in the dce_v6_0_hpd_fini and
dce_v8_0_hpd_fini functions. Therefor, the variable is removed in order to
avoid the following Clang warnings:

drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:331:6: warning: variable 'tmp' set but
not used [-Wunused-but-set-variable]
    u32 tmp;
        ^
drivers/gpu/drm/amd/amdgpu/dce_v8_0.c:325:6: warning: variable 'tmp' set but
not used [-Wunused-but-set-variable]
    u32 tmp;
        ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index b90bc2adf778..2c61f0c2e709 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -328,7 +328,6 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	u32 tmp;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -337,8 +336,7 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *adev)
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
 			continue;
 
-		tmp = RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
-		tmp &= ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
+		RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
 		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], 0);
 
 		amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 7c1379b02f94..c5e9c5dbd165 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -322,7 +322,6 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	u32 tmp;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -331,8 +330,7 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *adev)
 		if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
 			continue;
 
-		tmp = RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
-		tmp &= ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
+		RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd]);
 		WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->hpd.hpd], 0);
 
 		amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hpd.hpd);
-- 
2.35.1

