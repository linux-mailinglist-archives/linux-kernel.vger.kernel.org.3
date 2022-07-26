Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D775818A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiGZRjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiGZRix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:38:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CBA3247E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:38:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so13943531pjf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65z5UblURAWtS2HSo73KtitpLtnM0+IbS2Ko/ylefao=;
        b=JKQA2DZRhmMHgWDjn9IqsGd1TVfsl2/RxaGpJxPdD+c34DkWDAWNsu9qO/xRlhSFNz
         jTRpE4I/X989DPF2x2DVjb248ibAsnZJAf3O+WByNYpcxeOcUzjim7Qd2uty5uDE1x73
         d5LtxHUT2N3mk77hhhR51bamkKwqf1Z9L7fP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65z5UblURAWtS2HSo73KtitpLtnM0+IbS2Ko/ylefao=;
        b=YgNC+R0qR+N0i0yV6uoc7nu9gwo3mBEucKx9kw1ECjLK2c5jzsUNZ5L63uBe1BEsF9
         YUQDV3gOnhgrAHAo4pdouf/LmQ3wTtQjqGl6uJGzP3L0LmY48MO6FKXCbtLm/rDoUpLc
         DJOj/gFYrey9qp9uKDaD37x+tu91Gb8qvk0xtjmULGptmdPGGa8AiM5n4xVvljoVYQzs
         1eIhqFjkBaCbw1MjnkO7XsINIV5O6sobU1ll4p7EsiZR6OTGBAQmLzSr1VqfoqyCkqWx
         PFgnzFEAD73cwcpzqH48CBBtZ3gdiVmXH3Rc8opeyxkm8slsPjlxeMZJBJ8ZmuviTPj9
         EpEA==
X-Gm-Message-State: AJIora98q7h8yJzVtsGAVw8YwFyo6uScqAwXhhjm5wMfQKwkxdiIZRxv
        4K1FVUFZQF1dVUkBl/U6URebNQ==
X-Google-Smtp-Source: AGRyM1vaj4AnRg3w38ziBsA+HO1alVRbJxT5BFBbzuR9W1nR9nbx4to4YrRPWTU9jI9OfC/TAk1BDg==
X-Received: by 2002:a17:902:f541:b0:16d:46f1:bd17 with SMTP id h1-20020a170902f54100b0016d46f1bd17mr18371237plf.18.1658857122699;
        Tue, 26 Jul 2022 10:38:42 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8693:e9aa:75c0:5134])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b0016d9ecd71f4sm245884plb.77.2022.07.26.10.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:38:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] drm/msm/dsi: Fix number of regulators for msm8996_dsi_cfg
Date:   Tue, 26 Jul 2022 10:38:18 -0700
Message-Id: <20220726103631.v2.1.I1056ee3f77f71287f333279efe4c85f88d403f65@changeid>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
In-Reply-To: <20220726173824.1166873-1-dianders@chromium.org>
References: <20220726173824.1166873-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3 regulators are specified listed but the number 2 is specified. Fix
it.

Fixes: 3a3ff88a0fc1 ("drm/msm/dsi: Add 8x96 info in dsi_cfg")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Fix number of regulators for msm8996_dsi_cfg") new for v2.

 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 2c23324a2296..02000a7b7a18 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -109,7 +109,7 @@ static const char * const dsi_8996_bus_clk_names[] = {
 static const struct msm_dsi_config msm8996_dsi_cfg = {
 	.io_offset = DSI_6G_REG_SHIFT,
 	.reg_cfg = {
-		.num = 2,
+		.num = 3,
 		.regs = {
 			{"vdda", 18160, 1 },	/* 1.25 V */
 			{"vcca", 17000, 32 },	/* 0.925 V */
-- 
2.37.1.359.gd136c6c3e2-goog

