Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948CF58E5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiHJDyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiHJDya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:54:30 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F5E65825
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:54:29 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 53-20020a9d0838000000b006371d896343so41651oty.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7rU8bDr39Wos4pPlp5rDHY4O2R+eG5nyVtErR7bxkgQ=;
        b=jN9MOdWDI/Rb19CdE9nA8Rw19kEKGJXLGI6QMin1iEM03ACk31Sm0RnYqYHsxuX3ku
         gw8l6PZzL81YmIPr1G+rDByM1EVybyUvVwH/BBBDzIWSiDujXTMHdOYe4Omf+p9i3cxo
         P+7i6zA3CUWW+Mojj0JiOqDwbVSg3zs3DlYRP/Bf0HL634Lp6tmOnzL9qL3IExYA0y8o
         7ygRdYxo0/GnWcQNrOzoYhEOV8v57eo5Wn38uwfCEFKySVHjLQ6kIq6Zsv0rTR45TQgB
         dNGEEYgSt//Dd/IOCenNlKpAruUyg9KxV5NP+BBDlAMEEXSJr2W6EWiMY/x1KDAnCyV3
         9qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7rU8bDr39Wos4pPlp5rDHY4O2R+eG5nyVtErR7bxkgQ=;
        b=ArgT92cWtaog/RQ1hlfD61X6g4xPQvd7PaX38AMpp1dfymGWbuBO57RIOa4w3soBFu
         wzgyqGyF0FHtsDYiNvMXib4vlhQ8gyvwVszAr0fNIsB1Sed+ZzKatu8LO+UayKivtJZM
         qpIL5BUjxgg48PNiJdxfe4dqiPmNI8AUbg+OTz6LXdokbec3ahg0DNIuPl9z4Id9nnzi
         2RI1g7odKXxoyyk+wk9fTnOMu/L2oa0beT0sWHo5UBABGnB2gADZgM/eI1W20t62Lzws
         qp+k9AZuMG6yeFfPx1ztAcZ1auc8ZwyfeQcoqFylalCcg0sCOx2VouMg3/kKnCIU7VyL
         IJmA==
X-Gm-Message-State: ACgBeo3xoSbLj9lAJI2ugiCwmx6KQecQonmqG/c69e9palA2guTr5zh3
        GNb1yQ0kv6PkThOMNmaQWbaFHA==
X-Google-Smtp-Source: AA6agR52u71mq4gR0xhKvUZjvRBcpyjsvD4wjJZOe6Ml/U3mAwQDbMyFlLSB8zRTOV2mQfHtFzyX/g==
X-Received: by 2002:a9d:1b21:0:b0:61d:2e19:4566 with SMTP id l30-20020a9d1b21000000b0061d2e194566mr9818467otl.11.1660103668834;
        Tue, 09 Aug 2022 20:54:28 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r13-20020a056871088d00b000f5f4ad194bsm3569732oaq.25.2022.08.09.20.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:54:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: qcom: c630: Add Embedded Controller node
Date:   Tue,  9 Aug 2022 22:54:23 -0500
Message-Id: <20220810035424.2796777-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810035424.2796777-1-bjorn.andersson@linaro.org>
References: <20220810035424.2796777-1-bjorn.andersson@linaro.org>
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

The Embedded Controller in the Lenovo Yoga C630 is accessible on &i2c1
and provides battery and adapter status, as well as altmode
notifications for the second USB Type-C port.

Add a definition for the EC.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index a7af1bed4312..1b9b36faea27 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -352,6 +352,33 @@ zap-shader {
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
+
+	embedded-controller@70 {
+		compatible = "lenovo,yoga-c630-ec";
+		reg = <0x70>;
+
+		interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ec_int_state>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "source";
+			data-role = "host";
+		};
+
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "source";
+			data-role = "host";
+		};
+	};
 };
 
 &i2c3 {
@@ -676,6 +703,14 @@ mode_pin_active: mode-pin {
 		input-enable;
 		bias-disable;
 	};
+
+	ec_int_state: ec-int-state {
+		pins = "gpio20";
+		function = "gpio";
+
+		input-enable;
+		bias-disable;
+	};
 };
 
 &uart6 {
-- 
2.37.1

