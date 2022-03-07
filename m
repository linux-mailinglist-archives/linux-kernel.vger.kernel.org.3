Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7337F4D064F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244740AbiCGSWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiCGSWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:22:06 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6C78188F;
        Mon,  7 Mar 2022 10:21:11 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id s11so14773094pfu.13;
        Mon, 07 Mar 2022 10:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBiRd+ga9tcDeGEmH3o6MmE8o/gJeN3HNLPViDcjgfU=;
        b=fi8TJHQfLKdt0uij9sOenGzc+tXogDxjL134kPYUvhvj5m+WIETwjCALuQpWf6r1k0
         YihnkAz6JI1LDtOunISdjU4CLL2nrzUwKX9U9CmOcMONVI9Or6iDxPQ1GyZiXR62j5Mj
         wOcZF8AQz+uezW/pNAVhL9v+NK9n9OMKwqGvjvwJpd9/h+U5eILX00d1rAxVfseeiKgE
         QQC897aIExLzwjOmGV4UsV0w6oWvsQfykET3YcmMnEeXUKp5A8AvIjG20GI4Hqm2vPex
         MnETq70WrEXC6hZVQ1ZfzmwZyGOFSxZJiK4rchc+bXSFeaA1oLRaJrsb7LnkcYyxsLZE
         HN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBiRd+ga9tcDeGEmH3o6MmE8o/gJeN3HNLPViDcjgfU=;
        b=oSHWiullYQrEp7K5wQ9iZcgg1jt7E+D5VzgU88MqGytI/WYEkY5FDBaINP6MWryCXs
         VUD/U3X1TnEhky9RAe/Dpt1PO40M8OuImRD+JLHdjKeBJfFAG/uyAFXXC/SM3uJ0bWfE
         gWmCNYJh+mLFiuGnzfGYnA0QDtTCTPcViWo2gpLw30mqSN8zXzDZ1bVRI4ETHAYfvlkr
         LM6Bewga2MfBuCd/i6e3CWmtj3JjMheV5frRi5gLCpdaEHDofIaCPUE/SMOcKPMQ9Ai+
         Mo2sK5/qU6WKBGFyf8h3fmbMoc/+YSPrEuJKBBFfY4+SL5PSFTOGvmY9eTZl8IsytIkf
         yxnw==
X-Gm-Message-State: AOAM53284+4gwxyd3k7WAvEXjYBcKMLkEMKixTawjFWnW99IXy5TNsfe
        wH6qhPwVfS0IVf6mUNUCnhc=
X-Google-Smtp-Source: ABdhPJyKplUciEN0F5nUTMpL14fmI/J5n3s9O+zynyGBtmt+zWS5cirNNP3d/EPPgzQphCqoa1uWYQ==
X-Received: by 2002:a65:4845:0:b0:325:c147:146d with SMTP id i5-20020a654845000000b00325c147146dmr10993228pgs.140.1646677271115;
        Mon, 07 Mar 2022 10:21:11 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id t190-20020a632dc7000000b003759f87f38csm12245809pgt.17.2022.03.07.10.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:21:10 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH 2/3] arm64: dts: ns2: Fix spi clock name
Date:   Mon,  7 Mar 2022 23:51:00 +0530
Message-Id: <20220307182101.84730-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307182101.84730-1-singh.kuldeep87k@gmail.com>
References: <20220307182101.84730-1-singh.kuldeep87k@gmail.com>
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

SPI clock name for pl022 is "sspclk" and not "spiclk".
Also fix below dtc warning:
clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 6da38ac317f2..4ef1817a4f7a 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -644,7 +644,7 @@ ssp0: spi@66180000 {
 			reg = <0x66180000 0x1000>;
 			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&iprocslow>, <&iprocslow>;
-			clock-names = "spiclk", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -655,7 +655,7 @@ ssp1: spi@66190000 {
 			reg = <0x66190000 0x1000>;
 			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&iprocslow>, <&iprocslow>;
-			clock-names = "spiclk", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.25.1

