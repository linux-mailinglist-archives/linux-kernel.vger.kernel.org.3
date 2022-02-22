Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F99A4BF8FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiBVNSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiBVNSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:18:36 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B704C0842
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:08 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 12so6386233oix.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACyjILcPZ7NYc4LHqBI/xMepMYxZRqk3PuvZsYhS/Ak=;
        b=v4JuF4eo37E18crpKjb/Gy2A7pJWq76VCa+SO0Yq2LZhwxQ80IckHLVEykfxl+nfW6
         zOiTv4hSWHNOaMO3uESTI58NF+VpBtZ+ioz74gPPvRewBi5Wm/vNY4R76jnCGHoPc6H1
         D4duIjjzalbpwjn4VmFoKeov9xAV/JkbSY0bME9CiQ5EoiVvI/bAL+3PvS4rK8pcTUer
         fAL6Y8cQdpq2p3zQaGuE84a+1HeTzBv7Vxh8mUZFHbhT28l7rk9/7J139WxWOZ2t9UX0
         QfoIZcl0NVgcSrenDt/ZlCfp0kbAjFMyzQUcxgYWD2P6bDQVYoBq0GMddHGGMJx8FiVi
         Xkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACyjILcPZ7NYc4LHqBI/xMepMYxZRqk3PuvZsYhS/Ak=;
        b=5CnnKn2fWQskCatR4rDImlFuQawYVa1ZdK5Xq3E4jFLZmh1Vs5qkOhTQRDGtZwQuCA
         9OxZ5A8SoAKR26mNtSddje9TUWrAKm5lCHaf4h3FE2VMxIm6ATQOUsctp9IZo/g8QYpb
         62t3LsOVc4XXICQeIN11WH3qBa6pOZlR2B2LGfHaA3D7z/3JPy3RrJr/asHiJkbwzvYM
         gHxLtBKwMLC8BIZvlkfqQEMBLpVtPZVuR6Jtg+mHj7vyYwi7JWqTy1UFy+f0Dg9cRRIY
         fhRqj1FjFIubfiBaZWvoJdN9D2Q5z1jtAfqZskpnLEmW03beOfqpBwwauRtVHVrXdlkL
         /raw==
X-Gm-Message-State: AOAM531gt8mGVr0OfFyyKh2qpA4XZv4JVa31g+LEu6g5XCtEEATENFdn
        6vDyhxRD0M8cDVu4AE8emhF7WulLnt7dAu2u
X-Google-Smtp-Source: ABdhPJwPv6b/Py7a73THpCfPZnfM/8IqLsz85BzUx8kIjX3WPdbvzYq+DLAUFR44XYrhcXxQsPSCiA==
X-Received: by 2002:a05:6808:238e:b0:2d4:fe08:9351 with SMTP id bp14-20020a056808238e00b002d4fe089351mr1835703oib.291.1645535887885;
        Tue, 22 Feb 2022 05:18:07 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:18:07 -0800 (PST)
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
Subject: [PATCH 05/10] drm/amd/display: Remove unused dcn316_smu_set_voltage_via_phyclk function
Date:   Tue, 22 Feb 2022 10:16:56 -0300
Message-Id: <20220222131701.356117-6-maira.canal@usp.br>
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

Remove dcn316_smu_set_voltage_via_phyclk function, which is not used in the
codebase.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_smu.c:171:5:
warning: no previous prototype for function
'dcn316_smu_set_voltage_via_phyclk' [-Wmissing-prototypes]
int dcn316_smu_set_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, int
requested_phyclk_khz)
    ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 .../amd/display/dc/clk_mgr/dcn316/dcn316_smu.c   | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
index b7f9e1b34c11..fd6497fd2dc5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
@@ -168,22 +168,6 @@ int dcn316_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispc
 	return actual_dispclk_set_mhz * 1000;
 }
 
-int dcn316_smu_set_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phyclk_khz)
-{
-	int actual_phypclk_set_mhz = -1;
-
-	if (!clk_mgr->smu_present && requested_phyclk_khz)
-		return requested_phyclk_khz;
-
-	/*  Unit of SMU msg parameter is Mhz */
-	actual_phypclk_set_mhz = dcn316_smu_send_msg_with_param(
-			clk_mgr,
-			VBIOSSMC_MSG_SetPhyclkVoltageByFreq,
-			khz_to_mhz_ceil(requested_phyclk_khz));
-
-	return actual_phypclk_set_mhz * 1000;
-}
-
 int dcn316_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int requested_dcfclk_khz)
 {
 	int actual_dcfclk_set_mhz = -1;
-- 
2.35.1

