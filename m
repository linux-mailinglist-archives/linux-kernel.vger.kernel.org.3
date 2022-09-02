Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324535AA95D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiIBIEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiIBIEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:04:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628ECB7281
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:04:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mj6so1315727pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=xoQDghImqhS/6zj7SGq6Ohv76jgSNxfDTje/23luiDU=;
        b=NnS+8SedQ4bz6H/oZQ1r2rl1gOu8h2hljraTclYGG0SXW4GsDCNk2TJNSSffzRM1zx
         Yccpx43h5qtuL3gBQptoagxx1lNxQMdML75CvVHkf6ZEwq8cYcSgNWnGNSFLBczwd5Ga
         ztKJ5126sthQ4MOk67HUBHslAqxzIB1Ig2yJd7BDiqJ38IfPilF69EPUl6evMArGMR8F
         j5pKdcvmBFKHF/BhoU7iGtc+QAKR8mAn/j6UXYRJN4bCA+/8S9EAh/IndwCg1LRG+iPO
         bq8qrbdsEwxOmMQmaLqUg3eqGQbM3oMbaKNrS72frXo+MD5iQIsd+f8mzYkYq/kdMUry
         IWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xoQDghImqhS/6zj7SGq6Ohv76jgSNxfDTje/23luiDU=;
        b=2fgaS56mNfo9uqByf1IkfSvD63cP4v1JHhob8PBLElBY8nCb6VfwygFfgMWvjJLHN9
         O44AYlIq9fDW3BXndZiOmnYhElPQB+2tftBbvwkezcHIIquyrOlNGz+OOYmY1TRViZhj
         NdTaBcl3edRkOh879v1zcAtDTd041S1zidSlqw/GiZozO5DLGAL4l4kNNqgUIeK/RXio
         3ROtOdhskd9mTnOxpWyUpMEaGYdsbTeT8XB0v0/q7XGIoMFi7L82zDDmdF/yEkASDFc8
         IUqHD6tkaEL+vXwFKUb/x6uvp3PoqBaEm06zF1cm6GXZemu7mB5Pu0z/+XzlWiRWLfpm
         Tm/A==
X-Gm-Message-State: ACgBeo0A1QRJGnDs+IXj36TUqGVMCA2PvmhfyIE05Eoy7tWXO89/JCOt
        RGI63+W+FoyIQnMcYlJkOFI=
X-Google-Smtp-Source: AA6agR5s2iXThen35iy1rvWxabUcM2CsCsvtmeSug61sb89oguI2Y19eHb4TmPs1cyoyuERCO1hycg==
X-Received: by 2002:a17:90a:174a:b0:1fd:f273:de03 with SMTP id 10-20020a17090a174a00b001fdf273de03mr3546160pjm.188.1662105847930;
        Fri, 02 Sep 2022 01:04:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c201-20020a624ed2000000b00535bf24008asm975545pfb.207.2022.09.02.01.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 01:04:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Hawking.Zhang@amd.com, Likun.Gao@amd.com,
        zhang.songyi@zte.com.cn, ray.huang@amd.com, Stanley.Yang@amd.com,
        Jack.Xiao@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/amdgpu: Remove the unneeded result variable
Date:   Fri,  2 Sep 2022 08:04:01 +0000
Message-Id: <20220902080401.320050-1-zhang.songyi@zte.com.cn>
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

From: zhang songyi <zhang.songyi@zte.com.cn>

Return the sdma_v6_0_start() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 2bc1407e885e..2cc2d851b4eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1373,12 +1373,9 @@ static int sdma_v6_0_sw_fini(void *handle)
 
 static int sdma_v6_0_hw_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	r = sdma_v6_0_start(adev);
-
-	return r;
+	return sdma_v6_0_start(adev);
 }
 
 static int sdma_v6_0_hw_fini(void *handle)
-- 
2.25.1


