Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6060588465
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiHBWiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiHBWhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:37:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7080E17E1F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:37:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t22so7017092pjy.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RdEXt6lST7n+LoKcJt89muoRfgacXACJbMNMi2diRZw=;
        b=meEnV6SKRxCATViJTGiI8yRisfitA/Ifcie2bONs0hT2imac/Ft1IIspNYJbX9Mesy
         AnXseRu1Y2GlCbGVQG+OMnMhtPuxW/Hi9yVjBpMAsTPuykC0AcVBPE4NtgnN0tIoHnUE
         9nDDRaQpVrMjnff9i0Puon7FVq++R7V4cSP/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RdEXt6lST7n+LoKcJt89muoRfgacXACJbMNMi2diRZw=;
        b=qvRPKvLp197YwwWlM77dijCS1tv9aMOZon/FYWD9g8IIDddhLxj100eQgUfwp59cn/
         DNlLlFogA1mTNxjDTFI8hOGGBPpSfHhQugoLWqaePAeRWGnXRse2D3OJp5u+Vw+rXwA5
         QAqLZ7qvUjhphwCA5Anj55IX5UsvkuEJcNyQb6rzJgnJFDS3lqR8Ky+CsgKDxHJkGT4n
         hqOIcIXyRMoB9MPI5WpgC76u2O/kCa4oDw6ZnCItFmwnckVOo9DhmB8og9bqLCoEt7/5
         UvqvvTNLMN4WwV9LTp08g/WkkbJOnBBvy4YW+8jg9WODrG2IchHdZg+WGaFMKGOFb69h
         kPAw==
X-Gm-Message-State: ACgBeo13vP0nIMpUnXtITBWSuEimjloWWztHsW5k1Qjkyb52RXuF6G+8
        XOUmmUgwTkkCOLVZaVQ2BTqyYA==
X-Google-Smtp-Source: AA6agR6kwuvP8bBPDHcReSHv/U+3Fz0f7n7zbRA+IblQ1fr4TmASpT5VeILMORInZ9BsNAd5WoxSOQ==
X-Received: by 2002:a17:90b:1e08:b0:1f5:1f0d:3736 with SMTP id pg8-20020a17090b1e0800b001f51f0d3736mr1776097pjb.58.1659479871969;
        Tue, 02 Aug 2022 15:37:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:31c9:9937:c6bb:62f5])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b00528c066678csm11353030pfb.72.2022.08.02.15.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 15:37:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] drm/msm/dsi: Fix number of regulators for SDM660
Date:   Tue,  2 Aug 2022 15:37:34 -0700
Message-Id: <20220802153434.v3.2.I94b3c3e412b7c208061349f05659e126483171b1@changeid>
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

1 regulators is specified listed but the number 2 is specified. This
presumably means we try to get a regulator with no name. Fix it.

Fixes: 033f47f7f121 ("drm/msm/dsi: Add DSI configuration for SDM660")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- ("Fix number of regulators for SDM660") new for v2.

 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 02000a7b7a18..72c018e26f47 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -148,7 +148,7 @@ static const char * const dsi_sdm660_bus_clk_names[] = {
 static const struct msm_dsi_config sdm660_dsi_cfg = {
 	.io_offset = DSI_6G_REG_SHIFT,
 	.reg_cfg = {
-		.num = 2,
+		.num = 1,
 		.regs = {
 			{"vdda", 12560, 4 },	/* 1.2 V */
 		},
-- 
2.37.1.455.g008518b4e5-goog

