Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54806550C33
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiFSQul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbiFSQuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:50:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EEBAE6B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a10so4639260wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNXopq52OdPOW8hnENMbdffTvgekfwjZqRQxiWITItA=;
        b=UXseDhSOx0rUAEvMqPdKjoNX6iw9kl3ksS1KhacDVTvFn9tN8JSbBObzwz8gdyDzQg
         uQJkGfWZksWFLd0JITNB4k8Lp+jk+Tb4Jco9WbPkapDV40a/UXo94H0yAwxGoAu8j4Vg
         KwVUHLnxGxGypw8UpX7J2FHUCRkPpv7drdKjkZfhGI/gTAirqZbp2sUhgpyPIL9pmLIj
         qlkBRg4NNpCccrXRS+RduITB9GoWEe29/VUCSe5YbbNnsbABBPX8VNSs+PUJET+TxzYp
         HnkLC3Qc4N0cRB7whR+tm0GM/2NItv0jxMP8CQW86kPt2rl2M6rnavs5s0wUyftzUI9k
         +Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNXopq52OdPOW8hnENMbdffTvgekfwjZqRQxiWITItA=;
        b=b42c55FihQRrJUVeqzzJ44fE4pdp1Bl4Fun1ubNl7QuauK8x2X3gdHiE8TaP9WfIQ5
         xepRJx6ZQ0hIygyLdUklgZnWLRjQdAjlEzZzIaG3vnKe7NJxhh3wj6nKjz3GO87mQzt7
         4byYAx35IftdGmJOwvw40gCiogi1W5vd9mLUwYY4ZHW/SPOANbQxwHaLXQGboKWzjDq6
         gkvj5csCFG+TA5t7dPs8it/qbp4E7u39yschsXf1KRDuWtZNdBVKSxCVqodPDNVzENEc
         x/P+lFFQhINiDs2K6uhtZKFrrUdQq8fXtJF+7uk0SXXzuLsqU3+HYeUU3CWJ0evpJ1cL
         pH4w==
X-Gm-Message-State: AOAM531X95AnakAb6+OdfEZv1wbIdntU86IhgSrlI6s3si6SPtXeapAw
        zssSFMDA4bDaCk6bKn8n383zzEUaF0mRbVxuVjU=
X-Google-Smtp-Source: ABdhPJxL+7m5XLx2s4xgfyyeKIsKdf3d5gNOY2UtvWLXs/QJRThfo178XdMRDOR1NdK/T7YB6xi5OQ==
X-Received: by 2002:a1c:4682:0:b0:39c:4459:6a84 with SMTP id t124-20020a1c4682000000b0039c44596a84mr30464743wma.167.1655657424029;
        Sun, 19 Jun 2022 09:50:24 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id m14-20020adfdc4e000000b0021a3c960214sm9189510wrj.6.2022.06.19.09.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 09:50:23 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC 6/6] riscv: dts: microchip: add mpfs specific macb reset support
Date:   Sun, 19 Jun 2022 17:49:36 +0100
Message-Id: <20220619164935.1492823-7-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619164935.1492823-1-mail@conchuod.ie>
References: <20220619164935.1492823-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The macb on PolarFire SoC has reset support which the generic compatible
does not use. Add the newly introduced MPFS specific compatible as the
primary compatible to avail of this support & wire up the reset to the
clock controllers devicetree entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 8c3259134194..5a33cbf9467a 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -197,6 +197,7 @@ clkcfg: clkcfg@20002000 {
 			reg = <0x0 0x20002000 0x0 0x1000>, <0x0 0x3E001000 0x0 0x1000>;
 			clocks = <&refclk>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		mmuart0: serial@20000000 {
@@ -331,7 +332,7 @@ i2c1: i2c@2010b000 {
 		};
 
 		mac0: ethernet@20110000 {
-			compatible = "cdns,macb";
+			compatible = "microchip,mpfs-macb", "cdns,macb";
 			reg = <0x0 0x20110000 0x0 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -340,11 +341,12 @@ mac0: ethernet@20110000 {
 			local-mac-address = [00 00 00 00 00 00];
 			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>;
 			clock-names = "pclk", "hclk";
+			resets = <&clkcfg CLK_MAC0>;
 			status = "disabled";
 		};
 
 		mac1: ethernet@20112000 {
-			compatible = "cdns,macb";
+			compatible = "microchip,mpfs-macb", "cdns,macb";
 			reg = <0x0 0x20112000 0x0 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -353,6 +355,7 @@ mac1: ethernet@20112000 {
 			local-mac-address = [00 00 00 00 00 00];
 			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>;
 			clock-names = "pclk", "hclk";
+			resets = <&clkcfg CLK_MAC1>;
 			status = "disabled";
 		};
 
-- 
2.36.1

