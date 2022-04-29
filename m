Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC351489C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358794AbiD2L4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358733AbiD2L4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:56:31 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C7CC6ECD;
        Fri, 29 Apr 2022 04:53:12 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id q13so5154424qvk.3;
        Fri, 29 Apr 2022 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdBkDQmKoIggvVv+9nKr+EG7gevAiBpcUOqfYxzGhEU=;
        b=btsBbf150KlxvPgk29yG535UtWnJICkliDohSbgYOm9Uxqzs45Q0cuw8eRkzeIo5m6
         UfaWty44QpA9Jq89tmgWpEOdOse/nkT7r7cU140rXyr5Phfrbkhhm9qemHu6GA7Qrpl2
         SmHZ4gQ+HFsujQfELi7YlgJ8R6JqnRgk/3kFkvGT2PtRBKJqSrQXEH4glvObWFiKy7A1
         n9x5lmUZJJktqSy+q6lGotSKf+WQdV56AOB2vixJn0q9i9UFFMjPi1k+C1/shz4NVMMc
         RXfFg6Xb1R28QVl2uLN8h0+1ItWu52ebkixk2rqspzuVqyKKCknQDYaugrQOr7UvnCdA
         lPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdBkDQmKoIggvVv+9nKr+EG7gevAiBpcUOqfYxzGhEU=;
        b=HI6vnSA8dEj3ETI1AVWIe27xtJoZtTuW9h0oCTWsaWxpGIyWJdIk+GxEm/MZzulLQ6
         Ld4fkceLD35jdTey5unNunUH0xxIDy1PmSLdj9hgiyNDbpV5wN86nla+iKmoZpYusNVc
         h0137ofz6/N/IF3o+HKPgdtXSCyxvishrkTi+HmyjVFPr2yMTJKKibIReXejNNn5Vd9o
         2D0BAXdVqGFITeRVPJkWm/G8h/5nqHP5/yx2Z4+0Kbew5goR6GQWEuqptjC9fu2DYLky
         OLk+u50FWBebyREcCuqfp18zvvXs+fUl5HI8hk6jWU8RhMoooO5xnnv3p/R3wYRmFul7
         RwcQ==
X-Gm-Message-State: AOAM532+NPKxfAkTJL4i6B5z6Cu68GBnT+ilR6rhubDLo/FAUhEM/gex
        AEEm7cF4gWRLPlEFZhKopFThgE9FFUpJlw==
X-Google-Smtp-Source: ABdhPJxHLLSlDuQSF8q/L28tDhOJvVMBBSaB10SlvL2+Jt+VX752p8Q+6XTmT2eS4vLZrXwe6fmZMA==
X-Received: by 2002:a05:6214:202b:b0:458:10af:3f59 with SMTP id 11-20020a056214202b00b0045810af3f59mr2314048qvf.57.1651233191745;
        Fri, 29 Apr 2022 04:53:11 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 123-20020a370c81000000b0069fa408fdb7sm1382505qkm.24.2022.04.29.04.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:53:11 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] arm64: dts: rockchip: add rk356x sfc support
Date:   Fri, 29 Apr 2022 07:52:49 -0400
Message-Id: <20220429115252.2360496-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429115252.2360496-1-pgwipeout@gmail.com>
References: <20220429115252.2360496-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the sfc node to the rk356x device tree. This enables spi flash
support for this soc.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index ca20d7b91fe5..61a6d9d4c8a0 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -750,6 +750,17 @@ sdmmc1: mmc@fe2c0000 {
 		status = "disabled";
 	};
 
+	sfc: spi@fe300000 {
+		compatible = "rockchip,sfc";
+		reg = <0x0 0xfe300000 0x0 0x4000>;
+		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "clk_sfc", "hclk_sfc";
+		pinctrl-0 = <&fspi_pins>;
+		pinctrl-names = "default";
+		status = "disabled";
+	};
+
 	sdhci: mmc@fe310000 {
 		compatible = "rockchip,rk3568-dwcmshc";
 		reg = <0x0 0xfe310000 0x0 0x10000>;
-- 
2.25.1

