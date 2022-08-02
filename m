Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850F058845E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiHBWhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbiHBWhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:37:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5642517A96
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:37:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w10so14773835plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2z9VWF3hK7//dTsr3ET+yhlA0EUoj1I28bGbEnp5rNA=;
        b=DzfA8xUlGBHuYnAia4vD5rj+fXD1Re7St+u9/2ucmBIM0lCtoNKupWZ4tPkHKMBsvY
         OADjkVUYHRdAj/Z0rYGKqx2a/NcYmiVqNb3iP08kmZ6tcz4z+lXGd7FTYGPj1742wa0S
         P1/GSUMDp+tt+Is3076zFZB3jnd2itjWeLWYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2z9VWF3hK7//dTsr3ET+yhlA0EUoj1I28bGbEnp5rNA=;
        b=eqMFyzvgLUQk+TBfpnun/RU9yyRysnaZQozq4qtOdndJOrXjdXIXFJRZXIJTgoEyyK
         2V9XENCTOL9c5wZ2yrGjAzLxozGo+XpoFbhHm3TxWO3PogvPIwAgcawtbokDZtXgvq/r
         HTyB7bAqKjz0AG0WmxgsT+3Ko7SThdXm8Hga+KLt5I33uMSo/tihpTuZsIFKEua0J89n
         ctNXsOYXED4/u9LC9N+NNm/g0h8MpviqFFGogMmKKNAGDucTpDdqd7c7MGpC4l7WjXOC
         oAQctAp4sTDRaMsQw9OefGSXkEpLRZbflsbrsXhWFzVkz+SkUf6k8z95bHvmVeAGgkMY
         P8SQ==
X-Gm-Message-State: ACgBeo0OvsuSHtGJl1uz4BbjEkIPuEv3kZFnU9P53LWpcfXmE4SagGot
        RymbRX/86cvdnoLT5/Xo4FJhWw==
X-Google-Smtp-Source: AA6agR7M6AxyAEjgTDhbxQMLH7upd96AsxWNvKLSMCEEt5qLO0zW8YPaTG5Y95obmNomqZGuYa4gbg==
X-Received: by 2002:a17:902:6bc2:b0:16d:d2c2:7ff with SMTP id m2-20020a1709026bc200b0016dd2c207ffmr22353739plt.87.1659479869857;
        Tue, 02 Aug 2022 15:37:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:31c9:9937:c6bb:62f5])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b00528c066678csm11353030pfb.72.2022.08.02.15.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 15:37:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] drm/msm/dsi: Fix number of regulators for msm8996_dsi_cfg
Date:   Tue,  2 Aug 2022 15:37:33 -0700
Message-Id: <20220802153434.v3.1.I1056ee3f77f71287f333279efe4c85f88d403f65@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220802223738.898592-1-dianders@chromium.org>
References: <20220802223738.898592-1-dianders@chromium.org>
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

(no changes since v2)

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
2.37.1.455.g008518b4e5-goog

