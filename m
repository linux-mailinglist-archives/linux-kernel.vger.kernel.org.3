Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BDB4A7A5A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347593AbiBBVZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347630AbiBBVYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:24:37 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCD1C061759
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:24:23 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s16so526771pgs.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYHfz0BsCMUpTXZNkgUYz8ce27VEmp7wwarvZ2CQUxk=;
        b=dYx+ZyVUfAx/Hz+swtu1BWE2GpqHz//uH35gVg9SpGdIogWsDrD+Zw+KMINXb7Zi1k
         4ikg38ff6XUQFN6OQRInEpe++fuQN4xmTUeePB1NmZmNzJCY3EBtd/a1kz7NfOyaj/rg
         jQavdv0QjlWy8LG+FCZjqxDt0Q4d10ZlWTKns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYHfz0BsCMUpTXZNkgUYz8ce27VEmp7wwarvZ2CQUxk=;
        b=YRK1gMO4wPcssNRnMa8/PUZ1v2wJ2gpOKlrcZB6M9a41UYMmm2t+V/ni0lQuuxtAi3
         Ngxy0/Gri/PwMC9omei0MnOATKchSLjdROdhZcfUoZ4vLPkIVp5f/Q70Xb58MgKb1eQT
         MVlc11MtMNFTuDE3MDOcsxW5dty3yX1i72ZYI0r0STvgN7txmVemoeX4yM2mb2egOJ1W
         R1uT1qD/UNU8B3sM6ZwfNYQi5FV9oaK7+5cht+0wR0ylIV2Kjxa3i7455xm/rQst1tLI
         9q4pYY1Cisi/u1IEom3vVnG1BHKFV/UL9qHbwnoTZRxF/2hKxVgSB8w8xI0TADWcODKq
         aYTg==
X-Gm-Message-State: AOAM532Ry/7kZrIGyQed0mkBRQFxmfBb9OdaHBHgX6psI5ogq0lbzkr8
        gqpf8CsoJT3n5Nq3HuKTuTGDyw==
X-Google-Smtp-Source: ABdhPJxbZKK+JzVp1VSiV8IMwDjN+ULU1FWL7BaKzFoHZemWnB0NC0mW43BobL3//Mz9CuCpR7Fzpg==
X-Received: by 2002:a05:6a00:26e9:: with SMTP id p41mr3304516pfw.1.1643837063157;
        Wed, 02 Feb 2022 13:24:23 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f1c4:10b6:b4ef:16e5])
        by smtp.gmail.com with ESMTPSA id on9sm7627983pjb.16.2022.02.02.13.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:24:22 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     pmaliset@codeaurora.org, mka@chromium.org,
        quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/14] arm64: dts: qcom: sc7280: Disable pull from pcie1_clkreq
Date:   Wed,  2 Feb 2022 13:23:43 -0800
Message-Id: <20220202132301.v3.9.I5f367dcce8107f2186b2aad4aef0dfcfafa034b9@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202212348.1391534-1-dianders@chromium.org>
References: <20220202212348.1391534-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that the PCIe clkreq pin is an output. That means we
shouldn't have a pull enabled for it. Turn it off.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("sc7280-idp: Disable pull from pcie1_clkreq") new for v3.

 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
index 82c3c8f0342b..3c5aab225748 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
@@ -827,7 +827,7 @@ &usb_2_hsphy {
 /* PINCTRL - additions to nodes defined in sc7280.dtsi */
 
 &pcie1_clkreq_n {
-	bias-pull-up;
+	bias-disable;
 	drive-strength = <2>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 6e20e8c07402..9140dca3b72a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -367,7 +367,7 @@ key_vol_up_default: key-vol-up-default {
 };
 
 &pcie1_clkreq_n {
-	bias-pull-up;
+	bias-disable;
 	drive-strength = <2>;
 };
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

