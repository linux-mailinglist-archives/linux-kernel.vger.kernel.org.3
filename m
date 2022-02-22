Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1070A4BF905
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiBVNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiBVNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:18:59 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B503FC087C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:30 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id p15so14411274oip.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mAHBtmtMrIy2W3kHZTCvcn0QTbxMEFt0geIwL6YcBKU=;
        b=nwAqmSQ2vzkc3R4j/kHBj0KGZ82kOVGgV5IRWLnHakRqcnRlMTi9QWOODmUlZsR7Rn
         o5IZ/CoGQE9VyVOfT0qR0kyflmOFoLDdau0bR8Qx7YSRA9/5elfqnOn/Db86bYKBkTeG
         0FuUP7l9/VpIBYdcnESdf/CvwXHQQLYEOB0EVwZ28H8YarTK9fUla0EAV4crC8sBDwSK
         vK5gyqkTUzozj5/qxd5GkZ5NhYLamohIpzpxY8vU8KW8athgQctX6BWp5EFF6/l+oZxt
         TJKlTbCIQ94AB6watlHLY3iubMMGfwBc7yDlOMTMT2vEHeGzMGLD1S5iJBJVQ0MbIGtX
         2MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAHBtmtMrIy2W3kHZTCvcn0QTbxMEFt0geIwL6YcBKU=;
        b=ER2oXlG8/uGeHfhqxIbDGzTogOIyzD8lRerRPne8sYjW4yFoCINCqAEewoWA3EHRUx
         g+Jqn9YBLA3Ivqaor1k/GvRoyozlrIUwYvB32+wTOaUJ98QHB6ZUI4xqFNZNZczS6Yzr
         7g4c0tNRnySdA8oJQzsVOePHKZQXaJfda/myXVwLZndArhO3iH5lmGWT0smXdgLD5Z4r
         2h0RgbXamxVyjjxCPfZr2xD3gzbrw+VPDsmUTDw39zDK1OXrpPe8mKdUktZYPqLzm/Zt
         0WpSZFBB7TGPMxNrjnno/3zwYnIQMiTq2fh2czECNQk08b37oZjBMiEodQef8+C+ZDBw
         kWxg==
X-Gm-Message-State: AOAM532QUAvgb1zVSCqdQoQzqVGlIl5hl47EhsiVmiiSl/rr9OkMVKbL
        aX5PSjZ3LqlnqyLsPGSGWKY5OA==
X-Google-Smtp-Source: ABdhPJx8Rjrh7CF6sfeCwjuZInz6fzuEKQI/zgh6IVqdopcXaKbEaCWXyeks31/XR48U1/2OPddz9g==
X-Received: by 2002:a05:6808:1646:b0:2d4:428c:659e with SMTP id az6-20020a056808164600b002d4428c659emr1885513oib.20.1645535910109;
        Tue, 22 Feb 2022 05:18:30 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:18:29 -0800 (PST)
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
Subject: [PATCH 08/10] drm/amd/display: Remove unused variable
Date:   Tue, 22 Feb 2022 10:16:59 -0300
Message-Id: <20220222131701.356117-9-maira.canal@usp.br>
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

Remove the variable clamshell_closed from the function
dcn10_align_pixel_clocks.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2063:7:
warning: variable 'clamshell_closed' set but not used
[-Wunused-but-set-variable]
    bool clamshell_closed = false;
         ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 8dc1afc03961..559aa45f27e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2060,14 +2060,11 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 	uint32_t embedded_pix_clk_100hz;
 	uint16_t embedded_h_total;
 	uint16_t embedded_v_total;
-	bool clamshell_closed = false;
 	uint32_t dp_ref_clk_100hz =
 		dc->res_pool->dp_clock_source->ctx->dc->clk_mgr->dprefclk_khz*10;
 
 	if (dc->config.vblank_alignment_dto_params &&
 		dc->res_pool->dp_clock_source->funcs->override_dp_pix_clk) {
-		clamshell_closed =
-			(dc->config.vblank_alignment_dto_params >> 63);
 		embedded_h_total =
 			(dc->config.vblank_alignment_dto_params >> 32) & 0x7FFF;
 		embedded_v_total =
-- 
2.35.1

