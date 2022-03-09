Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02394D39BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiCITQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbiCITQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8805D10F228;
        Wed,  9 Mar 2022 11:15:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r67-20020a1c4446000000b00389d73ceb43so562058wma.4;
        Wed, 09 Mar 2022 11:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9jI9Vh83J5K1vC3Y5dVrpyhcV7T430K9gWFFt5O3sQ=;
        b=muKBwRDB8bg+6t5/La7r836zUI6IF7n1EWST3ks3Pk1RumB30Bn//UnBmOeb1P2LnM
         6LZHKtgvnvTaqCe045y5kgQtnXGUOe4hu1dHQTpAUsskxDlFlaQar9Kqq0vsFs1bLxAX
         yf/V1tUmNGDNHfRiOxWeT5d5Odj3jlFvxfO7S95xxx5yzFpVhplDMuchO42elqRaV2l6
         31u5MKcoACanb2znnjy9vLd6794OonjFQbNnc0OxWdKjFQTcj8YtLUjdfVrDiMkEKenK
         vJj8x8I+5Qptv0IRfUKQW0L9PvhnDgE4TxmRGEZye7XY/ulvBx+7k4ZGQSReMxD8jhwn
         eb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9jI9Vh83J5K1vC3Y5dVrpyhcV7T430K9gWFFt5O3sQ=;
        b=JAtXO7/qAzKs4XY/cP0nMbaJzJSd+j+e9N5rg0dG/Ftj6LvMOYFLhaMj9NRYhppLqM
         j0dgz2mVO373HbAWan1hLZdx9/3YmAt8tqEb01ret8sRRaHYFfunW+gdRhh2s0/EuLPB
         jPpejmdIj8NFHQMtQtw4ULqN7pvMCg6hFHO20BrNh9ER5XyMpUC7R5bPezhSfWymCLev
         Tts04v2PD0E6zYYqYdR2pqjeoQyoc0Oy2KZp8ZlnDNL4H0NlNl9+40vHjysbPZAqPk9T
         OtIMDgKHTVlJr9D/tm1QCrK0SDdZHSd3PXOuoAOrNt5BjiV/JKJVkRIRlbATyPkgHjPi
         2+Kw==
X-Gm-Message-State: AOAM531vzOuStsRahXUXY5+DOtaeQ7JmhX1KRNhuALDUpH2qMSbFJxP8
        Ix+ZLs5SntCO45UrqBHnd68=
X-Google-Smtp-Source: ABdhPJzkKvzSm6FCnpDzSXSBGeSLXU+V2bh+fLp+K+gEhtvUvS1sPT5Z7dDuk1xXgep9grkANR5jGg==
X-Received: by 2002:a7b:cd94:0:b0:380:b241:8c52 with SMTP id y20-20020a7bcd94000000b00380b2418c52mr8933762wmj.2.1646853324890;
        Wed, 09 Mar 2022 11:15:24 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:24 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 07/18] ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
Date:   Wed,  9 Mar 2022 20:01:41 +0100
Message-Id: <20220309190152.7998-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
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

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index e247bf51df01..36bdfc8db3f0 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -918,7 +918,7 @@ pcie0: pci@1b500000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
@@ -969,7 +969,7 @@ pcie1: pci@1b700000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
@@ -1020,7 +1020,7 @@ pcie2: pci@1b900000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

