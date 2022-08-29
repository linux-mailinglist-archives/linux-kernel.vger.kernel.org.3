Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C235A4BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiH2Man (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiH2MaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:30:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A6372B66
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:14:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so5856571pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JDJaZLLijcqBMwlRc9kgfCyfcSIJN0CihduhDouY51s=;
        b=OKJiyNZjYzCoT7bMy8Fdnn8lp2fbY6FWngivXh3cy7DsGqJ2TU5Yd04nM507M9L7Sa
         JdIlrgCJqpSmw4d7jcvBzU5hVsQoDW6A7PbY+wYuPxkXN5l9Jz4IyQL9sFK9bIpwN3hv
         pFoRhQ59kAqAWKSqXiWd8CJfGqK8iYLt8gTu6dJRQde2CjidsWrG3Nb+VgzZJ+Gt86SH
         SSCKJq51P1bQlkvQfQu58LCW5Cv4QGBK+Yz48EVlmufxpY6XqUnsUTaPoiVnLIP7y9Bs
         TVOPuYwqSMZ7jh72S0yC6F7bn3haIlljJP8Li6loaMalOVqESYT1BXMyljbzEWSDAA8P
         6/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JDJaZLLijcqBMwlRc9kgfCyfcSIJN0CihduhDouY51s=;
        b=F2biM29t/HdukjXD1Yr/x1ZFkidtGaa+FBDZ4h51rl1CZ7l/om61QS3bm3pyiM6p8v
         xQgf6AAUWt5fOZT+ltz8EUxi0+OYf3YGWmTaYn/0wI0HJFcPhO7YowalBs4YQE36wULQ
         gv3bq5hemajMVBQImRniUHmjZ29+PsusXGAJhGfn9jHfuaXbdaj1ITnpK6G7BHC5LD8J
         7znubdkuSFEvV82fm7egVCYTQhRYfRX6rOsvM8F08PlgPiftAqP2HXLf7TlHtY6AaHL7
         i9aaigAPpmJd/S+eM5yLr1AcCw9C7VHDZ4N5NLxYJsjJDjUBI76mQ9Qs9BEwjTbmYLc3
         mVKw==
X-Gm-Message-State: ACgBeo2eVqG0Qn0oi0ZVya1YxIokghib+iSKZhmLkFatkLwsW9w4ki57
        tJQYMw4jR1trpkGzdw7nuRB/DT+ssaA=
X-Google-Smtp-Source: AA6agR6SkSObjijf9vIjaEd3qEzGK9u8YDkKPh5wnfACtNxhBX00XhsdDyJPTQIos9p3nqAyKJH1fQ==
X-Received: by 2002:a17:90b:17ce:b0:1f4:d068:5722 with SMTP id me14-20020a17090b17ce00b001f4d0685722mr17863461pjb.28.1661775208159;
        Mon, 29 Aug 2022 05:13:28 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id nt15-20020a17090b248f00b001fd84a8cfc6sm4504561pjb.39.2022.08.29.05.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:13:27 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Anthony.Koo@amd.com, alex.hung@amd.com,
        Roman.Li@amd.com, Yi-Ling.Chen2@amd.com, hanghong.ma@amd.com,
        mwen@igalia.com, dingchen.zhang@amd.com
Cc:     Jerry.Zuo@amd.com, agustin.gutierrez@amd.com, dale.zhao@amd.com,
        isabbasso@riseup.net, Sungjoon.Kim@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/amd/display: remove redundant vertical_line_start variable
Date:   Mon, 29 Aug 2022 12:13:20 +0000
Message-Id: <20220829121320.267892-1-cui.jinpeng2@zte.com.cn>
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

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Return value from expression directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 37246e965457..8f4f1ea447a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3741,7 +3741,6 @@ int dcn10_get_vupdate_offset_from_vsync(struct pipe_ctx *pipe_ctx)
 	int vesa_sync_start;
 	int asic_blank_end;
 	int interlace_factor;
-	int vertical_line_start;
 
 	patched_crtc_timing = *dc_crtc_timing;
 	apply_front_porch_workaround(&patched_crtc_timing);
@@ -3757,10 +3756,8 @@ int dcn10_get_vupdate_offset_from_vsync(struct pipe_ctx *pipe_ctx)
 			patched_crtc_timing.v_border_top)
 			* interlace_factor;
 
-	vertical_line_start = asic_blank_end -
+	return asic_blank_end -
 			pipe_ctx->pipe_dlg_param.vstartup_start + 1;
-
-	return vertical_line_start;
 }
 
 void dcn10_calc_vupdate_position(
-- 
2.25.1

