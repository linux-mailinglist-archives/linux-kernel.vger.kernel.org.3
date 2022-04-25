Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C583850E6B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243802AbiDYRRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243759AbiDYRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:16:56 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB5C13DD7;
        Mon, 25 Apr 2022 10:13:51 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e128so11259192qkd.7;
        Mon, 25 Apr 2022 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdBkDQmKoIggvVv+9nKr+EG7gevAiBpcUOqfYxzGhEU=;
        b=paxMNbaCwj5l3BgZd9lXV3mk+YDHGTTipw58Fdv/lu3cA8wVeGSVFUT4BcRfYY7TJ8
         KFmWRn8nG2Z29rqjm72k8XN1HnSVkIxfZprfp3gH84s9xECBZ+J26J2jiJxI8WzAeS/P
         9YGQ5pOgxCJC0sL7bhLQuIEN0f/bX+7KXfINO2VPnaVXTr3ByI2AIWkL846sovb6hhhn
         Uz9dP4c4CmE0FsHMmXXrVFIBKV+Wq7/BRbKRbnxie9kBXcoOdERewQkGzBLkUQs4G+E+
         KvdMqn+Gl7HWGDzlC3t2CsoRUyQRIsHlN5dlyJ2nIbI8ri+GwpIpPt8241yPRxtuxDCP
         JxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdBkDQmKoIggvVv+9nKr+EG7gevAiBpcUOqfYxzGhEU=;
        b=k1VeV790DM16bxO6xv4cug4U6GDQHLQV6W0boplYRyr1Q2JhiAXzwd6cOshqgQvg/U
         gqt5kQYFm8rzUoZyk4bDZvAmx9gTm8H7a3TevwV5vXK3O2yWNnt6558+6B6jJ1v7jNNM
         z2bStbfxZrlkgc4FO6ShbydynUOe+aQRvL9PGZK8wEdy+garIBH7boDVRIgWMNcTymvI
         70WzecwyxDBf5VrJpT5evICOrWHtgCDK8N6dn6KIXKoiyHWx/PaSwDFT6C507SYxkK6V
         uK85P96p+XDJn+qEpZqfumV1T1HOldhnrThPPaVe32Y/4EW3/ilstaEYmxfBDGGXqkZn
         GnEA==
X-Gm-Message-State: AOAM530CnCoa29T9UsT/v0mSrxpi1vaundM0Bbht2bSbpfalJ18NIRub
        QfXGCOuyaZFBPzlIMNcIILE=
X-Google-Smtp-Source: ABdhPJxb2SXF9ciMnaHs12z+YBgFKGrTWnGOCo6+3US1a6jJS7uDHVoqaFxdI5yGP+IDlmXKOilTYQ==
X-Received: by 2002:a37:b686:0:b0:69e:99ba:4ce2 with SMTP id g128-20020a37b686000000b0069e99ba4ce2mr10728313qkf.721.1650906830113;
        Mon, 25 Apr 2022 10:13:50 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm7154928qtw.64.2022.04.25.10.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:13:49 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/7] arm64: dts: rockchip: add rk356x sfc support
Date:   Mon, 25 Apr 2022 13:13:41 -0400
Message-Id: <20220425171344.1924057-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425171344.1924057-1-pgwipeout@gmail.com>
References: <20220425171344.1924057-1-pgwipeout@gmail.com>
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

