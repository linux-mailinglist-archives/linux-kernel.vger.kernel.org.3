Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE3253A227
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350861AbiFAKM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351849AbiFAKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:12:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49CF201BC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:11:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id me5so2185836ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l4c6eL6FkT3F5Q2UMeh1SdTOW/jzEthp0aJ+P51R6LI=;
        b=uuPC3WbwM8ZeORzZE8dCBKB08/lnjrHUzk3Cg4Zg1UwAEa5bQR32aQ//XmiIHULElg
         0fZ1cMu0jjAq6JEXla/7eTnkIGUBmkDMWfdwb4XExb4NEHk98/tMZpaqIayfHyolUr3z
         FlEtKFJRBc08u1+m2weeKmvg0rujrEB/UKRv+4thJ4aeC4bqJf2UKWHZxgaiUpeknJz3
         aNQpnmjUF2fWgbwAXrwhOyF4rR1sAutZoigj5aiw4pIhv/e8Z8zLBL9iscIc22jjoDDt
         diyzJlpXBjUMWfXTt0dmcaJpqFeviYZOr3z6R/DRBE4C8SIskhupNPPszYHAHtjco+fC
         mu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4c6eL6FkT3F5Q2UMeh1SdTOW/jzEthp0aJ+P51R6LI=;
        b=bgCawGXTJOUUUl+t1Q8wDdTajiFc+Kw8T/esx5FrvDCzkgAMc0gT4aEoIwTCVTSc6R
         SVjuhO47/SOaZIK2ID839cVzzcCg1OWwFKVAY9Q0+g51t/tQxlh6rErMutWyUm7sa35N
         cOH7Cb/ftNUwOpVIDudJSX4WkimgvsFioMpVJdTxIH68kQoDC5uxpngN+2kZI0nPhCAC
         DVWzYmA05ygwsiPkaQJxHLybYEFSrTrOmIC9UdDiSEt4fh9Z5W8AzkzZvlz06EF3d8Ek
         XenAxaywnxb6yn+ZY2bF2clKO23aEJkdhUUS6mWNx3hqgHYLV/q3+knMwFg4N6ASabic
         /dtA==
X-Gm-Message-State: AOAM532ApaJ3wAJoGGch7/YLEKq/0/Krt94CoeyJ2mDGzbiQEJpo/cKM
        HTyLLV9/vdH57omfv9vDkO4ugA==
X-Google-Smtp-Source: ABdhPJwEaTgdn1GKj/YKJ6G6b9+WZD+Roai4KFJAHqMLkyF7A6Gtke8DwN+FifgXiG1cP2KFOXKohA==
X-Received: by 2002:a17:907:9719:b0:6fe:f541:fa1c with SMTP id jg25-20020a170907971900b006fef541fa1cmr40448308ejc.450.1654078311241;
        Wed, 01 Jun 2022 03:11:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m9-20020a170906580900b006feb7b1379dsm501373ejq.181.2022.06.01.03.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:11:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/4] arm64: defconfig: enable Qualcomm Bandwidth Monitor
Date:   Wed,  1 Jun 2022 12:11:39 +0200
Message-Id: <20220601101140.170504-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
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

Enable the Qualcomm Bandwidth Monitor to allow scaling interconnects
depending on bandwidth usage between CPU and memory.  This is used
already on Qualcomm SDM845 SoC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6906b83f5e45..6edbcfd3f4ca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1096,6 +1096,7 @@ CONFIG_QCOM_SOCINFO=m
 CONFIG_QCOM_STATS=m
 CONFIG_QCOM_WCNSS_CTRL=m
 CONFIG_QCOM_APR=m
+CONFIG_QCOM_ICC_BWMON=m
 CONFIG_ARCH_R8A77995=y
 CONFIG_ARCH_R8A77990=y
 CONFIG_ARCH_R8A77950=y
-- 
2.34.1

