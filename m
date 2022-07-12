Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8930571696
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiGLKHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiGLKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:07:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C78AB68E;
        Tue, 12 Jul 2022 03:07:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t3so9204313edd.0;
        Tue, 12 Jul 2022 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XbujW824CNr3VEPvbgVSYfLKtCakKHejuLWKhEvhbjo=;
        b=j+7XQV2J1dvTbZpa/Qhzqdb5dvUbDMSITE7NK+nJ05nRbIyW2HOb1z8ONEJBotPGrc
         Axg6CPGNl3V53glbEhCLpWZVH3fY34rxCtQvg7J9IoCNGwJbkiLaK7g8rutEFVpDa675
         bRtxHCbQl5bF8neunMcUi2tMDl94hGvx03sxZmNgFzc2kMAInovQoX4tWTjteRsRQna7
         LNaRCyE/zXJDS9OTWxy9kbCMDWdk8jQqIckNfuAW0eKysKLJsLjEz3BJo55lJd15Jy1/
         yFxkkOtpdB8S04LeXobipJ+i9RINdNUvv4lfmNyCJ4SidOWDgqgemSvuS6XzRywDf2Ha
         2GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbujW824CNr3VEPvbgVSYfLKtCakKHejuLWKhEvhbjo=;
        b=to0FhJ3sYu5VIXOvSFt5x4s4far+exSoZtThmu79nRvY3J+uNDU7r1/WhGbbfgHvOZ
         iJ8o7Oo2D689KRk9loY9Yvb7TlRHAnP6HKZ7bji8xmILg11fC+LyV+mXlYZ0G4TimlOl
         BSad8xE5lL6EPdxBWEfgtcVZciBeMwcGtHp9QClnsnzsR8PFrVsVSH3Rs+nYKbcwd5o8
         gMqna225EsiS/A2QSWPKbyfCpo2pZCEy7i8EFnqyG3SatrtKX/SQLsmjj1JhS0NzDdbd
         sP4V0fHtfZIdodMAIawqqbcRLuLbNmwK50W1c4f/q/4Qvk7TWegt0Uo7BVCohBxxfWce
         bbeg==
X-Gm-Message-State: AJIora8LdgXVBxAjQrAnzGCA5b4vMhrFx5UFGLB0QrBEWIK3uOOsHlav
        6x4unpqnu5rjwwQ0haIzitM=
X-Google-Smtp-Source: AGRyM1tmEqvblkLPuM3cKpX2kKeFRSezIsUBldJxUuJeEfON3wJh7LyGr0QnX2GZ5affre2rf11Zdg==
X-Received: by 2002:a05:6402:42d3:b0:435:2c49:313d with SMTP id i19-20020a05640242d300b004352c49313dmr30051549edc.86.1657620459423;
        Tue, 12 Jul 2022 03:07:39 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id bd27-20020a056402207b00b0043a21e3b4a5sm5799675edb.40.2022.07.12.03.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:07:39 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v8 4/4] arm64: dts: ipq8074: add APCS support
Date:   Tue, 12 Jul 2022 12:07:33 +0200
Message-Id: <20220712100733.34261-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712100733.34261-1-robimarko@gmail.com>
References: <20220712100733.34261-1-robimarko@gmail.com>
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

APCS now has support for providing the APSS clocks as the child device
for IPQ8074.

So, add the required DT node for APCS and A53PLL which feeds it the PLL
clock for APSS, since APSS will be used for CPU frequency scaling.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v7:
* Drop review tag due to significant changes
* Add A53PLL node
* Add clocks to APCS node

Changes in v3:
* Node does not currently exist in the upstream kernel, so add it instead
of modifying.
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 080796555809..6a13bd3ead55 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -879,6 +879,23 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 				      "axi_m_sticky";
 			status = "disabled";
 		};
+
+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq8074-apcs-apps-global";
+			reg = <0x0b111000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&a53pll>, <&xo>;
+			clock-names = "pll", "xo";
+			#mbox-cells = <1>;
+		};
+
+		a53pll: clock@b116000 {
+			compatible = "qcom,ipq8074-a53pll";
+			reg = <0x0b116000 0x40>;
+			#clock-cells = <0>;
+			clocks = <&xo>;
+			clock-names = "xo";
+		};
 	};
 
 	timer {
-- 
2.36.1

