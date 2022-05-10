Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325585225B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiEJUoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiEJUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:43:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B312A18BC;
        Tue, 10 May 2022 13:43:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j4so105643lfh.8;
        Tue, 10 May 2022 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNyzKurbPrxNPFTdAAgyBjoxC65yJEaBohozFWfbO8U=;
        b=MkivjYRzDuzS2/9WoTfim0TKZksKggjcT/NnEsxlY0gcvVmkScTZ9D00cHiAZtwY9L
         C4MEimAE5OFAMg2xtboztW08BPfZYX7Yh3pu0gswb/Gh5EwKvZ4PN+JsvsE4ddhmwUmC
         vVcHYqcMMT0u0C3N6tIUAOZfYxCBcDviSqXktA8e0jZ6l47ua77GWLQrW90bPeG5zPDY
         +Zzge3QipIDNhgzCIILJtZNYbp/VK2giQ6cl6txIge9Z0qUqFUKs5v0+2w/KW9XC5Xd6
         2MGmJJ7LUGno3dMt1jqnHHFGRG8mDzW0AI7vKD3LQz8461gZfJDjGaMB99tS4AgMaqyu
         BGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNyzKurbPrxNPFTdAAgyBjoxC65yJEaBohozFWfbO8U=;
        b=bfEELkBAHHashUH/joWgYZ4vGBj6ZtnF4dzyUJZdf6UwGJzQPtYzR9Al7ZH0fzw+xt
         4JsaMUNu4qY22qKPGLovrAnoNDqhaMPEgawNLWN/4i7sA5ffxBM2qPQO1F/eFG82V5ie
         r3muZQxrLSIXxljTVva3fz1tUvlGjL1DqA9oYwYhkD+p8RWPVrONue0ZbS1npzZiTPDb
         3d8RaYJ81JE77CtbH0aDUq4Sv5tqSdjrQ0RJ6AoXeqaUKtYxehHOSKMQwef9HzkU/ndV
         e5R5etu7ZpTLDsDOkE7XGikCzXJ5wUFGHR/pM6fokX5491Y8G9OMG7hcY+zwB1hHL+e/
         PrmA==
X-Gm-Message-State: AOAM532eSVqCzJXXIR1M+x82A+prU8z+wSRQ91XV4LrLwvqDN1RSSOL2
        gGW8ioRUZM4Q0q/iqtgMhab6MvUMB2E=
X-Google-Smtp-Source: ABdhPJzo8xn+gwcZMe/h9a6hbjpdTPWX9/w09OOLktAb5Wge6VMamsyXgosvvAti605Jo2aTxpP3nA==
X-Received: by 2002:ac2:48a4:0:b0:471:fc7f:b54d with SMTP id u4-20020ac248a4000000b00471fc7fb54dmr17933084lfg.538.1652215418812;
        Tue, 10 May 2022 13:43:38 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 10-20020ac25f4a000000b0047255d210f0sm12318lfz.31.2022.05.10.13.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:43:38 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: qcom: msm8998-xperia: Introduce ToF sensor support
Date:   Tue, 10 May 2022 23:42:56 +0300
Message-Id: <20220510204256.8874-6-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510204256.8874-1-markuss.broks@gmail.com>
References: <20220510204256.8874-1-markuss.broks@gmail.com>
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

This patch adds device tree support for the VL53L0X ToF sensor
found on all Yoshino devices.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 47488a1aecae..ba85177bdb1c 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -245,6 +245,23 @@ &blsp2_uart1 {
 	status = "okay";
 };
 
+&blsp2_i2c2 {
+	status = "okay";
+
+	proximity@29 {
+		compatible = "st,vl53l0x";
+		reg = <0x29>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&tlmm 27 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&cam_vio_vreg>;
+
+		pinctrl-0 = <&tof_default>;
+	};
+};
+
 &ibb {
 	regulator-min-microamp = <800000>;
 	regulator-max-microamp = <800000>;
@@ -621,6 +638,22 @@ hall_sensor0_default: acc-cover-open {
 		input-enable;
 	};
 
+	tof_default: tof-default {
+		tof-int {
+			pins = "gpio22";
+			function = "gpio";
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+		};
+		tof-reset {
+			pins = "gpio27";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <2>;
+		};
+	};
+
 	ts_int_n: ts-int-n {
 		pins = "gpio125";
 		function = "gpio";
-- 
2.35.1

