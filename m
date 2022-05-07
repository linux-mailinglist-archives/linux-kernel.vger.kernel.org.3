Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB3A51EA0E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447060AbiEGUes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447045AbiEGUd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:33:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6EDE029;
        Sat,  7 May 2022 13:30:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y3so20073641ejo.12;
        Sat, 07 May 2022 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YevJxKBdfoigsdif5cCA3smLmibiaBo4qQ4+jmjct3s=;
        b=YXdDPcLYZVdWb32UKU3srakoWr7WA9ntHQQvzmWKdrBe3iMhs9bERQHRgsbS14o26U
         WtEkB1OITwofjg1mIcI+Xpg1kSJEws+cgSQEiwPgnZv3QtmyWI99VV59VMEeWixnu6OL
         v7Q5EJwXkgwCG8asb2M6pSKMzlP43RLZdyMXU9l9dBbZm1MQH65ZZNSbPlzhvakPg3Qe
         AhB7rTPgHqDy851rEcit2iTvSyuGA1VZseZEKDdSNP3cZbEqXF9MPZrT2viLnkcCdNIh
         ToDghiYzKPE7EsqU7ZHYgleuCPpQfJb/w9dVe/8yp+5c6tR2B3k2w6KOXkvnbXFVGdfc
         9J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YevJxKBdfoigsdif5cCA3smLmibiaBo4qQ4+jmjct3s=;
        b=j0c3nYiUpPfGvZCDYCXuvR+RKMoir1Jr8maCsw3oe4K4vBy47zSJy9BFl8uBlEqjnl
         i55QuRk9uLT/jS7fSq3eYi+1U1SvoWfB+TbmoCjUtwvh6DY59COL/9djVSkQEn1AyySC
         BA18yYW+SzHsTImKhKJw4+b4ulrbrmieEHy7AtdrxFLjwHsA5qiD4tdr7pmYYswh8X9r
         ekt5GA+NmuKsCLPixwsEewQD0K2hnTgAd8vGc3ggdTh6o48lL9701/kkcw4vsuJp7PoM
         MLEaIX4LMCvTNPIMQZmSqz/te8c1hvSQ9AqtFKEfPw/4SwrL6s0DX/IZpu6pmDah9rtP
         /2dg==
X-Gm-Message-State: AOAM532/uNcD8rlmjNi2fxWoWWfWeRdTgq/pcYc8Zuw2J39UlcQBCvN1
        tJ7nKX3x99EKqdvhmYjeUgI=
X-Google-Smtp-Source: ABdhPJwWEwvo7gjqTDNM3W9LQKAqdTg7wgHpFKC42vZNvYsaCpycjwzNmMQlKYZeThABz5GruG01lg==
X-Received: by 2002:a17:906:6a1c:b0:6f4:b0e0:2827 with SMTP id qw28-20020a1709066a1c00b006f4b0e02827mr8011138ejc.249.1651955408140;
        Sat, 07 May 2022 13:30:08 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm3900777edv.13.2022.05.07.13.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:30:07 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 11/11] arm64: dts: ipq8074: add USB power domains
Date:   Sat,  7 May 2022 22:29:48 +0200
Message-Id: <20220507202948.397271-11-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507202948.397271-1-robimarko@gmail.com>
References: <20220507202948.397271-1-robimarko@gmail.com>
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

Add USB power domains provided by GCC GDSCs.
Add the required #power-domain-cells to the GCC as well.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index ba81c510dd39..0bc21b0c177f 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -383,6 +383,7 @@ gcc: gcc@1800000 {
 			reg = <0x01800000 0x80000>;
 			#clock-cells = <0x1>;
 			#reset-cells = <0x1>;
+			#power-domain-cells = <1>;
 		};
 
 		tcsr_mutex: hwlock@1905000 {
@@ -610,6 +611,8 @@ usb_0: usb@8af8800 {
 						<133330000>,
 						<19200000>;
 
+			power-domains = <&gcc USB0_GDSC>;
+
 			resets = <&gcc GCC_USB0_BCR>;
 			status = "disabled";
 
@@ -650,6 +653,8 @@ usb_1: usb@8cf8800 {
 						<133330000>,
 						<19200000>;
 
+			power-domains = <&gcc USB1_GDSC>;
+
 			resets = <&gcc GCC_USB1_BCR>;
 			status = "disabled";
 
-- 
2.35.1

