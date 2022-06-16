Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6246454D68A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354709AbiFPA4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351063AbiFPAzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:55:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC37F58393
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 187so97988pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=itsEy92F8LgvkoK7MoKZ9B/GZxw2SAC9YAvwl0r5wg8=;
        b=z5mXx8sye4HKPIB7GYHCqOmGAGj5X42fg9fh791Lw1DXhV5zcZncP75cSXTXhLmtq4
         g7lrX/EsU75RaPEGf5B5G1LkIlaX4z9WqBVCWdYV3NN27afzgqvw16AH9OKxJNmBTI2m
         XTDqrwImsp+HwpXvH5JaGdLGEAu+TZO0/v34UfNt4ZZA45u4YGMymWhC/aBPrG0ASGVG
         hsX/qyXqmismIyIMdc0A5XjYmziMgoCcf19URCMHJwhvGapnII2ctHcbpH3j7geIyCiQ
         xS+DWBIbMyt2NXaLdJSFA9QX4Sp/Wr1fLXKOQnkCYfh0v1mwUsly2UpmfRNpv8frmavd
         UHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=itsEy92F8LgvkoK7MoKZ9B/GZxw2SAC9YAvwl0r5wg8=;
        b=XTet57WC31wgNq1Qo0+PO6rGOv7bP0U7n+3D4PUZgExep3aKM6NfdMn3UvGGqsanN9
         pu6SbI2L1YNQ4X9PVRo22eQMfGzYJWgt9tmlMgCCsty7RGlTfEA96Zzswcviz30GOLkQ
         sNl3x2SiIGD83t78/0Wczw6wx3Pc+kM9rTfIZrmFW4KwQ30NlgiGLu4LQ9cKIriceDIJ
         qd661Yds0ycUs5X5pc9BLi1SlIguMamRvjeyHKaL0dXu/qoREYWMQnVip8TkAUjUW3T6
         PAF6u0nznMYg5mTMMvRUk5ln6EUel2PtC/O4g/tuP4K8kJ0J6cOQPNP6xVIt56MBJC43
         NRkg==
X-Gm-Message-State: AJIora95P05kuo35c7/HHTieSiO/4PWN8rS4gKwOlogcVkkKGz2juuii
        RQXUUaN/MRu67Dl0TeDkmNdSZw==
X-Google-Smtp-Source: AGRyM1szTLtkES0t0cjWcjNlUNx3yfAdHRv1dieHB+qKOWjH/ekzn2LDX9kEaCAIRz7t5icSAt9ApA==
X-Received: by 2002:a63:f415:0:b0:408:808b:238f with SMTP id g21-20020a63f415000000b00408808b238fmr2093682pgi.469.1655340880158;
        Wed, 15 Jun 2022 17:54:40 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 31/40] ARM: dts: xilinx: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:24 -0700
Message-Id: <20220616005333.18491-31-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/zynq-zc702.dts         | 4 ++--
 arch/arm/boot/dts/zynq-zturn-common.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index cf70aff26c66..d23201ba8cd7 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -30,14 +30,14 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		sw14 {
+		switch-14 {
 			label = "sw14";
 			gpios = <&gpio0 12 0>;
 			linux,code = <108>; /* down */
 			wakeup-source;
 			autorepeat;
 		};
-		sw13 {
+		switch-13 {
 			label = "sw13";
 			gpios = <&gpio0 14 0>;
 			linux,code = <103>; /* up */
diff --git a/arch/arm/boot/dts/zynq-zturn-common.dtsi b/arch/arm/boot/dts/zynq-zturn-common.dtsi
index bf5d1c4568b0..dfb1fbafe3aa 100644
--- a/arch/arm/boot/dts/zynq-zturn-common.dtsi
+++ b/arch/arm/boot/dts/zynq-zturn-common.dtsi
@@ -49,7 +49,7 @@ usr-led2 {
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-		K1 {
+		key {
 			label = "K1";
 			gpios = <&gpio0 0x32 0x1>;
 			linux,code = <0x66>;
-- 
2.34.1

