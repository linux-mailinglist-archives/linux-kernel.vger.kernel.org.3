Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A954C31FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiBXQuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiBXQtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:40 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB36B1D0D4D;
        Thu, 24 Feb 2022 08:49:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v21so592080wrv.5;
        Thu, 24 Feb 2022 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rHDI6vIvxpV4bdkJwlGAV/GDPYbRvT76xn7rUsLJKXk=;
        b=k50QBe2UI3AOxtAw6DgWDBQq0m+7hHE+gszMaAFwAQsIeaEznNqmrJx3OL34Ah4QAj
         fxJU/n59bNa3/S7l21F42hMME1sHYYGkx6L9H1uZF1xfGAy3f6BtKBPlxfuK2uhincKc
         jUEstdXmQVe5mgY53z8S/5ahhAnXoyu5ik+UQ/FIflNqEHZqK+BsBTg6ZbQKPtp5+uhy
         vPb1TjBUtb2qoUc8l7OCvEFnhA5InZO+1QfT8g8IraNH4QMrKE3t4ZUyJJOLgI7lwzeL
         HHXzZ8H6B3SU1V2M4wmiey1wgykkPLPGWNN+8xWsbd90Ygnc0MYAz7+Ma5B9X8xxJ2bm
         pT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHDI6vIvxpV4bdkJwlGAV/GDPYbRvT76xn7rUsLJKXk=;
        b=wsjWf9fp4yzyHMnYjVoguboQxJgIo/BFAHNm7DPU2cNw59L9T/L7g9u3GIMVlLXUsM
         BuBx2mQZpwNszeda3JSUDKriHDjtqai58icOjNBOUws297i7iS4e1LyiyIbyVf7BfPY2
         YIdn2cFtjgRFF/CwauvjfD+zdnPL7gII/I3zfQ6VSItMlZuMl+D0FZ5FxZuApEYPsjEO
         Qui+cEcIOowUBo407pV1bn3IwhNszomp8wv/CcMFOMQj15jYqdHBwFUgCwHqSUVxj+Vn
         wwAUMIvmcpu2n5Kp5n0Xman1yrJw70EBOt0/qQbuKGou5G0lD9rUxltP/gPUTDws8TE0
         yl8w==
X-Gm-Message-State: AOAM532q3b5bZsjKoiIC6uyFJBSKhSS4vpFj/mYm5its/DaOSAOHkvfo
        T5E0peOq86GVLlT7G6pgEPI=
X-Google-Smtp-Source: ABdhPJxnAdoT0st8iIzer8UHRrd/lT8h9MydcQmVGmn4/o5jubPVXm6TKGXXK7VwOec5nyOQPnr/2A==
X-Received: by 2002:adf:e84c:0:b0:1ee:4a2b:fed with SMTP id d12-20020adfe84c000000b001ee4a2b0fedmr1968947wrn.149.1645721343396;
        Thu, 24 Feb 2022 08:49:03 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:49:03 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 15/15] ARM: dts: qcom: add syscon and cxo/pxo clock to gcc node for ipq8064
Date:   Thu, 24 Feb 2022 17:48:31 +0100
Message-Id: <20220224164831.21475-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
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

Add syscon compatible required for tsens driver to correctly probe driver
and access the reg. Also add cxo and pxo tag and declare them as gcc clock
now requires them for the ipq8064 gcc driver that has now been modernized.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 11481313bdb6..5524a68cf3d1 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -298,13 +298,13 @@ smem: smem@41000000 {
 	};
 
 	clocks {
-		cxo_board {
+		cxo_board: cxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
 		};
 
-		pxo_board {
+		pxo_board: pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
@@ -736,7 +736,9 @@ tsens_calib_backup: calib_backup@410 {
 		};
 
 		gcc: clock-controller@900000 {
-			compatible = "qcom,gcc-ipq8064";
+			compatible = "qcom,gcc-ipq8064", "syscon";
+			clocks = <&pxo_board>, <&cxo_board>;
+			clock-names = "pxo", "cxo";
 			reg = <0x00900000 0x4000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.34.1

