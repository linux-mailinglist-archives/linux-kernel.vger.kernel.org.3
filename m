Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329234A7A57
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347540AbiBBVZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347669AbiBBVYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:24:45 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27518C06175E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:24:25 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h125so569491pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ByszmS3++VzU56DysBqUHdS0730VZ9qlutiOkG62SSc=;
        b=nR2MvYfzs5o5IAQK/n8ImikISS87gNJVo5eSON5hLyblMqv0Z0NdUA6xvk1zR4Og7r
         uhuAkK8C4ctlhY4Ta2kFhceB1NHDF6ilUOsM3X9CfGp84hCMXujqEYTQ4lyN2qDClMKN
         YpZ+IG5EWjEfwmazwvX9m9iUzj/oxE3OBu1KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ByszmS3++VzU56DysBqUHdS0730VZ9qlutiOkG62SSc=;
        b=h0YAL7Sl8YYAOntfPS+O1n3UwLySTg1PMWlAxuwFyFJpY8vp776gauhUJr5jC4O1Fh
         US+4dRHhMaZG4vgiGSaHFPQTY1DnDC01qEu1VoyAH8lXJlzHlLjvZUTKHPO3nA3UqPgS
         nYm2kg6OQkZkawhUEotux2x4KaTAOtItOqFLIubx2y5EsgGULFWFbTpH2hMQzOXBN1mU
         YbrDbBvbloN3qaLOrzwCPQ/fuO+iyN0wQM6T/Kc7HX1gXSXBuBqWvDXbP3ltXmKo8hgh
         QifrIb7TCHorc3uWIFjqea3Ji7CjEyljoGH0qGaDmq+jKELyzjOKdNdX5DqWHsNLbtBU
         jbPg==
X-Gm-Message-State: AOAM530ZE0HhgoZrtmGzAwQAYg0u+BuZb7Bq/zkSiKhGp1xtTFO5R/L4
        jH7EO/62RKF2adXvn8BjN6OVcQ==
X-Google-Smtp-Source: ABdhPJzVsb8lfDnT0uBdj+He/AFpZcfXHtpW/Ppb3qs9pGrZ/r77umcD1G4sWWnwf/2ezbIPN9s0zw==
X-Received: by 2002:a63:2bc5:: with SMTP id r188mr13767481pgr.363.1643837064608;
        Wed, 02 Feb 2022 13:24:24 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f1c4:10b6:b4ef:16e5])
        by smtp.gmail.com with ESMTPSA id on9sm7627983pjb.16.2022.02.02.13.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:24:24 -0800 (PST)
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
Subject: [PATCH v3 10/14] arm64: dts: qcom: sc7280: Move dp_hot_plug_det pull from SoC dtsi file
Date:   Wed,  2 Feb 2022 13:23:44 -0800
Message-Id: <20220202132301.v3.10.Id346b23642f91e16d68d75f44bcdb5b9fbd155ea@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202212348.1391534-1-dianders@chromium.org>
References: <20220202212348.1391534-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pulls should be in the board files, not in the SoC dtsi
file. Remove. Even though the sc7280 boards don't currently refer to
dp_hot_plug_det, let's re-add the pulls there just to keep this as a
no-op change. If boards don't need this / don't want it later then we
can remove it from them.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("Remove dp_hot_plug_det pull from SoC dtsi file") new for v3.

 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts | 4 ++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                   | 4 ++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi                       | 1 -
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
index 3c5aab225748..bdc3f341ecf6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
@@ -826,6 +826,10 @@ &usb_2_hsphy {
 
 /* PINCTRL - additions to nodes defined in sc7280.dtsi */
 
+&dp_hot_plug_det {
+	bias-disable;
+};
+
 &pcie1_clkreq_n {
 	bias-disable;
 	drive-strength = <2>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 9140dca3b72a..325f50925451 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -355,6 +355,10 @@ bluetooth: bluetooth {
 
 /* PINCTRL - additions to nodes defined in sc7280.dtsi */
 
+&dp_hot_plug_det {
+	bias-disable;
+};
+
 &pm7325_gpios {
 	key_vol_up_default: key-vol-up-default {
 		pins = "gpio6";
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index a2e3aa6ecdd3..1776523e169a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3282,7 +3282,6 @@ tlmm: pinctrl@f100000 {
 			dp_hot_plug_det: dp-hot-plug-det {
 				pins = "gpio47";
 				function = "dp_hot";
-				bias-disable;
 			};
 
 			edp_hot_plug_det: edp-hot-plug-det {
-- 
2.35.0.rc2.247.g8bbb082509-goog

