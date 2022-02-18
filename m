Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789574BAE69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiBRAa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiBRAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E7E5F4C6;
        Thu, 17 Feb 2022 16:30:09 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p9so11719022wra.12;
        Thu, 17 Feb 2022 16:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iywisHL0NP8LXATzfziseh3r820tbR1Zc28/vheIWzo=;
        b=PLMgnL2gW+htEv4k9h09XJY1zhsAjjNHb75EpPVJYJxfSSC5pryk2tME9Ih1ATEB5o
         lc5PccI25yhsjzUQvl4zdLOR5TTQQp8N1c3pN4xCWVlbZ+pw1Zs4RyLUyyDKZQps9+bo
         qGguYRpvzhBkmXs6sqxgYolxT96KWpBnqRZWnHJQf4qRI8IsH++KFX4LKAoaIzd4LX3l
         PmT+5W4d7E6x8Gzf3VuNGR6Exukzk7DDD/vticupAsjMidQPhw7w2mbH68fH79U5Wc7c
         VGlUWVhVcfHf02CFSKtvhr6clyqs7k3ADmllYh+TSi/hoh1lFYvZ0fhnTrMA9ZfyhVtT
         zBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iywisHL0NP8LXATzfziseh3r820tbR1Zc28/vheIWzo=;
        b=L8rljRkSQUyWJKK1VX2HucPRrrvBkak+f6F9QkJGtf/ksWnMPwJy9b0vLzgROWfrTj
         TBhEcGDfPH5PuGLG8CJqTF3tAcaEiQ/ixWPFd19DJyEAGkHi5U+Cxbx4/WxFTjHloYG0
         7zetEfMutOLNIx0sGAYE/rhPhxsl+vmRBsnLDcc2Lx3cdUk6LYXHykJ6uRFI4Os7Mqmu
         JK6Cyd/IYCHnO9nc+3NUXOET+01w3oOAb7I4s9XRk3j/vUWaZtxVLB5tAwRcSlVOT+V4
         s3lvBnbwdc96rAlqqERq4gUCwdGyuviY21oefjZN/Tyilb46GQeoZQzhFXssQqC0Jjbf
         Xh7A==
X-Gm-Message-State: AOAM53236+cMoET1kls9uNDl0s35UdnLhbL3UmQGcM5sJeY07IrXwClX
        KI82Tn52ckQx2FeT53bBuNU=
X-Google-Smtp-Source: ABdhPJyzT+lQdLfsd//FnLjpfNd/Fp51eC6ocEQIUFisYwVxy5bDBGCeyg2OkeRE24GSjsAwCmJ9mw==
X-Received: by 2002:a5d:458c:0:b0:1e7:4e96:2b90 with SMTP id p12-20020a5d458c000000b001e74e962b90mr4063717wrq.56.1645144203534;
        Thu, 17 Feb 2022 16:30:03 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:03 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 08/18] ARM: dts: qcom: fix dtc warning for missing #address-cells for ipq8064
Date:   Fri, 18 Feb 2022 01:29:46 +0100
Message-Id: <20220218002956.6590-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
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

Fix dtc warning for missing #address-cells for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 36bdfc8db3f0..6768f7ba0d04 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -352,6 +352,7 @@ qcom_pinmux: pinmux@800000 {
 			gpio-ranges = <&qcom_pinmux 0 0 69>;
 			#gpio-cells = <2>;
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -473,6 +474,7 @@ mux {
 		intc: interrupt-controller@2000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			reg = <0x02000000 0x1000>,
 			      <0x02002000 0x1000>;
-- 
2.34.1

