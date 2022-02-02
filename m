Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A14A7A46
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347623AbiBBVYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347536AbiBBVYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:24:20 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7418C06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:24:20 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i30so405065pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5qCBCKfP+j2HtZn2zMmVI6QfVCuXgmfkA60ibxCLXgs=;
        b=f3nZ1EzYLBy7tnJJ+R0jdFG+yS+atHgKHNCLxveKGXKQiMOlgQEaUjZU6xlVij4pb/
         W7q3Hg8Qr6HevsZXJulOBWMr6yF2kxt4BmmPVbKF/B8ax/QmFiBF8NuST5CArY/i0IgB
         +EF4n1qgauGccnEerahlqdTneqwozLQiwcKlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5qCBCKfP+j2HtZn2zMmVI6QfVCuXgmfkA60ibxCLXgs=;
        b=4glOj5ch4OS4Cr0h1OmWZ8FVmNNGgNQgC/+lxOl+eKAQ8tZRVfem9FV7m0Hee3E0HS
         hQQWP1awSBE110msrmoUSEc9dGUdnnghjn94fgyIUw2GQw4k9oFUhAG2in6cvR2s1huA
         +J9RUJ1dFh6e/zUQldoz59yRNs4+Uv/fP5zjg007ijSad0G27StT4UDxB3kfHat21Rf+
         Xv2DPoHX0LdnfDiTld5pxgdK4DhHIYRkM4zmNBFNP/B69S5bgjgf2tC/0qVHyozwtkLT
         c/Fsv69EjiJWEr7OUFCZKiklZSpbYeRilS6egzgKitP1JNXdZqTkHtcOeyFIMMY3oJIP
         ioAQ==
X-Gm-Message-State: AOAM532Ie43b+ULLcIn5EmgU+pzGh94mM5g/qV9vNWALJOmmNMS+DrOd
        dtRyA1s0oOgvO7YLiW8/MjeWSA==
X-Google-Smtp-Source: ABdhPJwPT54MjvO3Gz+8X9q/NBFTjhdeFn3zIeltngAbKTcjcpYU137ZDJA3wRFQRbOPxYWXylY52A==
X-Received: by 2002:a05:6a00:130a:: with SMTP id j10mr30426747pfu.32.1643837060244;
        Wed, 02 Feb 2022 13:24:20 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f1c4:10b6:b4ef:16e5])
        by smtp.gmail.com with ESMTPSA id on9sm7627983pjb.16.2022.02.02.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:24:19 -0800 (PST)
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
Subject: [PATCH v3 07/14] arm64: dts: qcom: sc7280: Add edp_out port and HPD lines
Date:   Wed,  2 Feb 2022 13:23:41 -0800
Message-Id: <20220202132301.v3.7.Ic84bb69c45be2fccf50e3bd17b845fe20eec624c@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202212348.1391534-1-dianders@chromium.org>
References: <20220202212348.1391534-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like dp_out, we should have defined edp_out in sc7280.dtsi so we don't
need to do this in the board files.

Like dp_hot_plug_det, we should define edp_hot_plug_det in
sc7280.dtsi.

We should set the default pinctrl for edp_hot_plug_det in
sc7280.dtsi. NOTE: this is _unlike_ the dp_hot_plug_det. It is
reasonable that in some boards the dedicated DP Hot Plug Detect will
not be hooked up in favor of Type C mechanisms. This is unlike eDP
where the Hot Plug Detect line (which functions as "panel ready" in
eDP) is highly likely to be used by boards.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("Add edp_out port and HPD lines") new for v3.

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 4d5892411a38..3f9837921c17 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3010,6 +3010,8 @@ mdss_dsi_phy: phy@ae94400 {
 
 			mdss_edp: edp@aea0000 {
 				compatible = "qcom,sc7280-edp";
+				pinctrl-names = "default";
+				pinctrl-0 = <&edp_hot_plug_det>;
 
 				reg = <0 0xaea0000 0 0x200>,
 				      <0 0xaea0200 0 0x200>,
@@ -3052,12 +3054,18 @@ mdss_edp: edp@aea0000 {
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
+
 					port@0 {
 						reg = <0>;
 						edp_in: endpoint {
 							remote-endpoint = <&dpu_intf5_out>;
 						};
 					};
+
+					port@1 {
+						reg = <1>;
+						edp_out: endpoint { };
+					};
 				};
 
 				edp_opp_table: opp-table {
@@ -3277,6 +3285,11 @@ dp_hot_plug_det: dp-hot-plug-det {
 				bias-disable;
 			};
 
+			edp_hot_plug_det: edp-hot-plug-det {
+				pins = "gpio60";
+				function = "edp_hot";
+			};
+
 			pcie1_clkreq_n: pcie1-clkreq-n {
 				pins = "gpio79";
 				function = "pcie1_clkreqn";
-- 
2.35.0.rc2.247.g8bbb082509-goog

