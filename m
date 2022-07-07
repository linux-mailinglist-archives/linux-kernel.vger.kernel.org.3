Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3355E569731
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiGGBKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbiGGBKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:10:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B422D1DD;
        Wed,  6 Jul 2022 18:10:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id o25so29862147ejm.3;
        Wed, 06 Jul 2022 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDidFcTb8G4/KmS2QleAlSbeK0yWVDuk5V8OHae9RS8=;
        b=cTX/aupUeBT+1j3eSaDdpOTPluVFA82kTrBqKNR/+wKhWKOMDKOiSJ8Gjg6r6dLa+H
         2WUph9cq5wsLw1xfoF/WmMss178lpgVha+jB7icPooKSEQFvisqGtS4CFjUzQtmqaTXc
         bhMo7vTtxJiFBUu54mjB4jLa1CroeSBFa3an4Sv1dDcP1bvbM8WKeeeGC6OGlPowKZNq
         hvQODXfrEJ19JzuEFjof5LoWY2+YNqY4Egm0srfeOniU+uQKjFFj+Bwso7fbOYz0Ls52
         qmco6JL4ksu8jcVuaIxkwN8G4uetNN9HwVX6/aGxDFSGuUwiwC2oJ3mG3f09/VC9HBbe
         dEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDidFcTb8G4/KmS2QleAlSbeK0yWVDuk5V8OHae9RS8=;
        b=W82uVLJ3WK49SRSGr0/7A4HjWGzAwc4swNmqP2vwYkhWLv9F/YJD/Emr2Ie37J29KO
         +HoW1Yq812wN0lJc3SXTY8U7ff1IaTWMgyY5DiH+hEgejczC+kqQc8i0K8zgklKylorD
         IOlALDYZxYMKtQ+/U6Nm6a+Bd1E+w77for8c5Ix8lfG1bMBaOTUijT/eTMDwMSyiqqh0
         T9/HWzz2NO8AaiVOipobb+IHVHYhPjoN7mKz7dghyQWZx4GTfjYGvoEx4Fway+n86qnQ
         sVolhwPASXJitVBIza7pXDxzVCbRWEZ1nN8mePQR5vO8EU5XnvoZEXCcpFXUd60qxyjP
         xziw==
X-Gm-Message-State: AJIora8YR9qRHPf9LOqNt8iHZ6e8XGiwjrKnYBjEvkmdBPE8MxeBPAac
        ng/Gn97KK3QyVxXVqHT3TvI=
X-Google-Smtp-Source: AGRyM1t12OhXDhTDdnPUoqGOvMOXFr07AtJNnmupd71kIXv7uhkz1mApBEY0SP+QrazvWnNN1RwhIQ==
X-Received: by 2002:a17:906:604f:b0:718:e9e8:9d2a with SMTP id p15-20020a170906604f00b00718e9e89d2amr42017817ejj.315.1657156209155;
        Wed, 06 Jul 2022 18:10:09 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm6915464edv.46.2022.07.06.18.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:10:08 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 5/8] ARM: dts: qcom: disable usb phy by default for ipq8064
Date:   Thu,  7 Jul 2022 03:09:39 +0200
Message-Id: <20220707010943.20857-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707010943.20857-1-ansuelsmth@gmail.com>
References: <20220707010943.20857-1-ansuelsmth@gmail.com>
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

Disable usb phy by default. When the usb phy were pushed, half of them
were flagged as disabled by mistake.
Correctly disable all usb phy and enable them only if a device actually
use them.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index a80090f5509e..e70167870476 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1188,6 +1188,8 @@ hs_phy_1: phy@110f8800 {
 			clocks = <&gcc USB30_1_UTMI_CLK>;
 			clock-names = "ref";
 			#phy-cells = <0>;
+
+			status = "disabled";
 		};
 
 		ss_phy_1: phy@110f8830 {
@@ -1196,6 +1198,8 @@ ss_phy_1: phy@110f8830 {
 			clocks = <&gcc USB30_1_MASTER_CLK>;
 			clock-names = "ref";
 			#phy-cells = <0>;
+
+			status = "disabled";
 		};
 
 		usb3_1: usb3@110f8800 {
-- 
2.36.1

