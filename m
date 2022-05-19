Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7E752D413
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbiESNbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiESNa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:30:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B6C6E5F;
        Thu, 19 May 2022 06:30:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id wh22so9830200ejb.7;
        Thu, 19 May 2022 06:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FxJnKg+A99wVrQlkanyVEuJTvEg3la3FckWvtOvAtg8=;
        b=eGV9t4Pe+aYujMGFP8V0IDDWdxCejL3cCO8g5G473ddA0oijPcfBAQ1rMwL5+k1vE0
         l7Q8CVUjXYzvQluSlvMZRZPVK/m7TWbafsDriPYjPfg+thoOtRD7P6m07umtB/D6PtQx
         SpNjlHonsvm9P6cbHKBJo3T93swFgBKlzAIc2giQ2wHjuy0qgJb4icVppOTN2YVFgM8z
         tbjShMY9PU/Xg6Ry7Qdf9i4GcKcJ+E6qj6fPHl1NjUBiLg+On2KS3EWS04jgDp5tvf06
         Z9aBx18PZMUO1xwDKabPYtrVc/ReCESlrCMwWAF7kM+pwkjPhnloYJR3Tcg4IhZDDOaC
         SqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FxJnKg+A99wVrQlkanyVEuJTvEg3la3FckWvtOvAtg8=;
        b=N5JQ7Y5GVeO02reGjHmejwM0EyGgaTeCwOI0Ewk6OEc5YD9dBDBmNSxhnH3zl3ErVT
         plqhWSXrdEJkHy7R6SEq/VG0WgFXDXH7b0duxIOhbc59zohR2Ho8KJW4uZm3f7uRxHKw
         Blo0vpijjfm1pfdv1z4nPVnqDlVGqPNk2SMLR4Uh23C26DicXXmHjEr0XR/l2KUWZElh
         LfV/cMLFW43H2EUcl+rQhskQCpNhXB0+6hp4LQzdrqnA9p5TD9xco+lYcdYISY07Txgd
         9HhENvDmio4GU9EnfcNmfFtNeRO+4xf5Ak6CJqQGB+mFpxc8zwOuAnLsTzv2yGZMSDtz
         nrSw==
X-Gm-Message-State: AOAM532mvlUJ44WqAykFPiyzP/EbSscCOjRF8hFuHvCxr+dNFv3hvJ0t
        RP9RZQYZ39GsmQueOXRZBg4=
X-Google-Smtp-Source: ABdhPJzWqxZpySS2+4NGbY2xj3uJDooRqXB7VLD/8lVf/avrXrbROe4czKYqU614TfSlbKTOVl2rQA==
X-Received: by 2002:a17:907:9602:b0:6df:e82c:f84 with SMTP id gb2-20020a170907960200b006dfe82c0f84mr4334422ejc.590.1652967026068;
        Thu, 19 May 2022 06:30:26 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-71.zg.cable.xnet.hr. [94.253.165.71])
        by smtp.googlemail.com with ESMTPSA id y17-20020a17090614d100b006f3ef214dd4sm2120383ejc.58.2022.05.19.06.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:30:25 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 7/7] arm64: dts: qcom: ipq8074-hk01: add VQMMC supply
Date:   Thu, 19 May 2022 15:30:15 +0200
Message-Id: <20220519133015.484639-7-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519133015.484639-1-robimarko@gmail.com>
References: <20220519133015.484639-1-robimarko@gmail.com>
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

Since now we have control over the PMP8074 PMIC providing various system
voltages including L11 which provides the SDIO/eMMC I/O voltage set it as
the SDHCI VQMMC supply.

This allows SDHCI controller to switch to 1.8V I/O mode and support high
speed modes like HS200 and HS400.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index b5e1eaa367bf..457cf83a1ed5 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -3,6 +3,7 @@
 /* Copyright (c) 2017, The Linux Foundation. All rights reserved.
  */
 #include "ipq8074.dtsi"
+#include "pmp8074.dtsi"
 
 / {
 	#address-cells = <0x2>;
@@ -87,6 +88,7 @@ nand@0 {
 
 &sdhc_1 {
 	status = "okay";
+	vqmmc-supply = <&l11>;
 };
 
 &qusb_phy_0 {
-- 
2.36.1

