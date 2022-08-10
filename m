Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4E58E5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiHJDsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiHJDrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:47:42 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4341D804A7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:47:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so3298772otd.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5D9+PsfZh11O34sosMXObQ3c3IZI2i4ZPZyxVLOQBa4=;
        b=T/g1XNcB5lKxH1br0VWmcAt4q0w4G5U2/SXerRfzVUQdnbwacvd35mjAfU/Bmi068Y
         +S/+czJWZ81cj1oHWKyNGzr2qBn4vPFMf7BQ2vzEV2vJVl+ZnSU8IZpGTfdY834jpdUL
         dEOxluqciPcFSTJyWSb+TcTP46ch6it0DnuhmmJigfikNF2mlqq9Zyi2YJlLH/PnqH8k
         Kb3F8lCkskepTG4Y+BNIgN9IUxch1FYnjSanyRnpKC6xcw7hpflnBIz/RQjphWMvocQ+
         arI6zXPRzG/EQLKx4zwmJbN8NCDcjXZzRBtC0l/hZuUJv86DOWQMDP8mtq3Td1wWfqPO
         DqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5D9+PsfZh11O34sosMXObQ3c3IZI2i4ZPZyxVLOQBa4=;
        b=xAakd6BfE2Q6wA3/YYqQ5YpW9a1uwegVrtwGsYbTXtxvv8qyBZen/dhOhOZJvON99G
         0MgiSpGSg7sk9zf8xTjH46xf5sB4Q3LxqcGKQ2T+YGIvYyTCQ5xApjOo0cHna6XcX/5k
         Jd1fSF2N58zjc0oOOG4yG/uA+4eOOTv++dBx4OKy8QlZo5qSsLNKgHYCrYwI4MQDFkTF
         5p957dDQnGyo6bBIJvk1M8UZKIE+Dc9OzMRbKfJ74EDKD8vtrmIbY/wTqvXdW1n54fm7
         t8VSCf33cEKANVVQB1bAYDyJ+dNFT4Du6ZSo/v7wTeJ0lEZD4Avsv4sCrJqdz2G+lSFw
         YfQQ==
X-Gm-Message-State: ACgBeo3dz0PQYvE8g8lo9PLQuaXHnUSVQ7uINpQwq6W/WvgKc3U1yEru
        qhxtOmr56OD0RocA5pWWQZbZLw==
X-Google-Smtp-Source: AA6agR69SJRWOU/4f5w8UNLQmEzoPDWv9YGDIFuD4FVXTNymk7j9PuepL3ouMkNnYCNx6VtsgGiBtA==
X-Received: by 2002:a9d:7a55:0:b0:637:1874:a2cb with SMTP id z21-20020a9d7a55000000b006371874a2cbmr812155otm.318.1660103260506;
        Tue, 09 Aug 2022 20:47:40 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n2-20020a4ae742000000b00444f26822e5sm454337oov.10.2022.08.09.20.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:47:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] drm/msm/dp: Add SDM845 DisplayPort instance
Date:   Tue,  9 Aug 2022 20:50:10 -0700
Message-Id: <20220810035013.3582848-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
References: <20220810035013.3582848-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SDM845 platform has a single DisplayPort controller, with
the same design as SC7180, so add support for this by reusing the SC7180
definition.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e4a83c2cd972..699f28f2251e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -178,6 +178,7 @@ static const struct of_device_id dp_dt_match[] = {
 	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_descs },
 	{ .compatible = "qcom,sc8280xp-dp", .data = &sc8280xp_dp_descs },
 	{ .compatible = "qcom,sc8280xp-edp", .data = &sc8280xp_edp_descs },
+	{ .compatible = "qcom,sdm845-dp", .data = &sc7180_dp_descs },
 	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_descs },
 	{}
 };
-- 
2.35.1

