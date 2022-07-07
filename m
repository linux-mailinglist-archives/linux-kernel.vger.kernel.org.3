Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D82569748
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiGGBKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiGGBKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:10:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22212D1DC;
        Wed,  6 Jul 2022 18:10:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n4so10570387ejz.10;
        Wed, 06 Jul 2022 18:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I0G/BiU72KwKM2woTAXR6MpcLtEh9AufGx8sGvA9/7c=;
        b=LXDMyrsSAceV6GhJDjUvPGxBEudlH5lWRzEkoroV3EXxno84TmiHLsMDLoC5QY8rKl
         s9rVDtaTQwfhtHvE6Q/LwAFIxm2CZOJzLbVRdO7y20jasTqz095TQMoZGT0vRbiCaade
         tpxnk47uwPEMnSwTotIGeZ2vfINwu3J/PNy9gomTFbMeirQXR/+Q93D19A4dIb78FyFg
         CfXqky8Jom9DkiRJmAtL6WjSkNWnVw8rIojl7I5ZbRTFq6nRtMJ1UkQeWteAUQD3lkk6
         0/4D1w4j99EVigz5RXAS+CjKe6nfQe7qnR1fr4ihcGV+cETkinT5FHIi90zT5eisnBLE
         AaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I0G/BiU72KwKM2woTAXR6MpcLtEh9AufGx8sGvA9/7c=;
        b=Tjd7vU+T9+eXdfdzdPZT3UKHRHmcSNCrDzLNfyloSZhFs+263jQNEYG7GeT5XLIj6W
         gpDBoRiIZ+zR1ckPHd7LS7uPe/abTCkZregWY1RQBzhFM2nU0DgVAMIxfzc4nAwlIGog
         FMj5x55/W/Cro7Krx5w3DOWfIY0XX/RMnwzpwvAO4tX0o30J56Jw6OzSkSaHfuOA4WwN
         86nMoLWW8sb6qXn3VCA32yDYOhcNfnbpWlD48mB28LwAUmZ4QjZPT+dMs9MA5gf9jP52
         Jb+3BCJfNkHrhpbzpHUvz2z8gprkq2oTLsxiWXpf+DXHkQRNxmrmjKVAnR3XEzJeiIua
         pxpg==
X-Gm-Message-State: AJIora9ysNfLP8NHh/70V/gCCbAad5BjKtgLSkURHPyJzKubbHqbxqjw
        j6IygzaWwFY9l6ei4qk1x5o=
X-Google-Smtp-Source: AGRyM1tGnt8SFYij3k+Jnu5pkWJaF/nmkrZIP6b6IHnj3/ruCBe5CfFBvZ4zF3iZlT1EWPXE/l61SQ==
X-Received: by 2002:a17:907:2814:b0:72a:3758:e948 with SMTP id eb20-20020a170907281400b0072a3758e948mr475058ejc.8.1657156210445;
        Wed, 06 Jul 2022 18:10:10 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm6915464edv.46.2022.07.06.18.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:10:09 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v2 6/8] ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
Date:   Thu,  7 Jul 2022 03:09:40 +0200
Message-Id: <20220707010943.20857-7-ansuelsmth@gmail.com>
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

The current value for pci IO is problematic for ath10k wifi card
commonly connected to ipq8064 SoC.
The current value is probably a typo and is actually uncommon to find
1MB IO space even on a x86 arch. Also with recent changes to the pci
driver, pci1 and pci2 now fails to function as any connected device
fails any reg read/write. Reduce this to 64K as it should be more than
enough and 3 * 64K of total IO space doesn't exceed the IO_SPACE_LIMIT
hardcoded for the ARM arch.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index e70167870476..8d2f7c8bf6ac 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -885,7 +885,7 @@ pcie0: pci@1b500000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
@@ -936,7 +936,7 @@ pcie1: pci@1b700000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
@@ -987,7 +987,7 @@ pcie2: pci@1b900000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.36.1

