Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A065458EAC7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiHJK50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHJK5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:57:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D16564D3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:57:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l22so17316816wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=0ysaBA2f8fvfJ+bdCl24YEvB2OkWOdw+12iTq6pAuz0=;
        b=O/ar/o42qj4hribZl7qVTa+3SUQCAymYUcOKFzt4k/JTRljYqgHhKrPgkpU6RXX2sP
         x2/dCw1EJM2O2ufjdy4rcix55cZIgLvd+nJths5RLsrS1RvAfDtV034jbgbgCNRNaZlY
         d146OK3/8QnFvL0da7AnQo9m01IiYUhmWqzVxPBFbMf4ofc0eUZzt32zv+mkXK7GbqjG
         osceCdHLY1spkl1jZpEnjvi6T4T+w69Mpa3KNZUF9TP6c6R8o/+9HhjJFj2IGuVQKCkb
         k5tSEqrfKOJ9Ph/jLws4a9vWHVJfRvEke2QwW+g5DZQQrd+4eqVf15O+7pBqGiXxfS5Y
         K7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0ysaBA2f8fvfJ+bdCl24YEvB2OkWOdw+12iTq6pAuz0=;
        b=7jq3U5Rp92D5e8cTtEorbx6z3OjUCg6mbKHljXWJo6f+N5WML78J98UylUcmS8YJgo
         yMZsLkf5OXoWorh+yZmIaUK+F8CaRRSkh17dBlOZrTs6/5eEqxfMYECNMPig3jxaOtgf
         hiaZjb9peLXvn/WDDH3Rz+jJHtc8GFvG8A/TU3KmOp6LFc4LIRnpHvDCSGb/zbVvqhl6
         WFZlCZ2G07y08ZFZ3amgBlahqZtqnnDgF1io6vjLgV+KwFgSsBjmfhJISimKhIIPru2H
         H4Fk3wrQ7pq3uTyv/4hNuFu59WE53i7uqNqaFN1Li5MYLgQTDJctRQnwuda+VjYMYSuH
         5oNQ==
X-Gm-Message-State: ACgBeo14MvXLTACyEOe0JM1fO47Z/AT9pp7LqSCLGWBTPmufcp9kNm3i
        MZx96qbw3fowbwg5ZL8Z+GktemzUCX5T6A==
X-Google-Smtp-Source: AA6agR54QCklcVRkNUhWXuEjVZu6HNm3T3OH+eFNyznYsPqC/KEkf/YyJUJceY7xTUGxfxy1lrE7ZQ==
X-Received: by 2002:adf:ef8c:0:b0:21e:f504:6e54 with SMTP id d12-20020adfef8c000000b0021ef5046e54mr16862258wro.476.1660129040803;
        Wed, 10 Aug 2022 03:57:20 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b003a53731f273sm2101446wmb.31.2022.08.10.03.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 03:57:20 -0700 (PDT)
From:   abel.vesa@linaro.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 1/4] arm64: dts: qcom: sdm845: Reduce reg size for aoss_qmp
Date:   Wed, 10 Aug 2022 13:57:15 +0300
Message-Id: <20220810105718.2137015-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

From: Abel Vesa <abel.vesa@linaro.org>

Like on the other platforms that provide RPMh stats, on SDM845, the
aoss_qmp reg size needs to be reduced to its actual size of 0x400,
otherwise it will overlap with the RPMh stats reg base, node that will
be added later on.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index f0e286715d1b..5bea96a9ce06 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4836,7 +4836,7 @@ aoss_reset: reset-controller@c2a0000 {
 
 		aoss_qmp: power-controller@c300000 {
 			compatible = "qcom,sdm845-aoss-qmp", "qcom,aoss-qmp";
-			reg = <0 0x0c300000 0 0x100000>;
+			reg = <0 0x0c300000 0 0x400>;
 			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
 			mboxes = <&apss_shared 0>;
 
-- 
2.34.1

