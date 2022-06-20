Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED46255146A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbiFTJeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiFTJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:34:18 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AA41274C;
        Mon, 20 Jun 2022 02:34:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f65so9811719pgc.7;
        Mon, 20 Jun 2022 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBq3Z7oEu9gFIA7jCFZpeq+S3fU28ZeUrdw/hJHHGkg=;
        b=dWaNUQiBx1z6mDhfWG2BGKV681ibxqG2PSBUFwROknXuWxP1DCiK4ikZdsiO8mZAm/
         0cCFhFnwAmz/7AFFMSSqWJW/bMYtuGchqrTPmPRuVm6J/dIVYEjVnnE2LzDdBX1rcAH2
         bpqJWI/S0dYpoz2wp/y3YbpxzmS0h4IbFFk0+Tp8HM8w7e2za3i7yiL1bOb8wyWa6sFN
         Iy4yEryvI+vKRrM0KNaJOGLkuWQeDPsGtPsotEsI4TEHVQlwYRkOknRKMOE0gWI7y6Sv
         6BAdPbTt0CjcN1f+jaYzBBu6xsBlOxb+c0FLelG73tV01XbMxwwafTrMgw4S/TFdwvuW
         +5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBq3Z7oEu9gFIA7jCFZpeq+S3fU28ZeUrdw/hJHHGkg=;
        b=oV8InNO/fSfuqFy/b5HO1Xpghw1/GNv0bm+ElbBvoSpS4b/TAgCPdyMRU/Ldbv58fd
         BT5CaejMb3yD5mNY8ClrnRf8yihqEHR6ldtNvYsl/2yfr5ZOgIhhEdKj4zd7QnIdFYyU
         Imz848vjVBNdK4Jhi0yf5H94nyzKDYzU59RUN/2QyjgGb6STjETqvRhJaq4VrEfU2TpS
         1eT/F8O7Lt6A5aCt2gj4nESFapycLgxa+//UjQxWlWZQ3NMPJ3DM/MSLPSuduAAuayrI
         5Tul+a83F6qyFWbtWEHO1VTKXc5yc4nzCvHCREIolaQtiKc6iSt8gt4M/Uc/V29zurEn
         Mq8w==
X-Gm-Message-State: AJIora/3saoMAdNeghTT7DfQXWPHNzibkwPRQG5r6lwrcER2nlM3C5FN
        xuH+2OJrmbusrq+HAaUQAVA=
X-Google-Smtp-Source: AGRyM1tBauLNcRR7D2sWkvnvtc1HidI5RlyIcwafqqTpriwR07db5llpY299JzgZ8s69dWDyl3jJJA==
X-Received: by 2002:a05:6a00:1941:b0:50d:807d:530b with SMTP id s1-20020a056a00194100b0050d807d530bmr23516600pfk.17.1655717657206;
        Mon, 20 Jun 2022 02:34:17 -0700 (PDT)
Received: from linux-server-us.. ([172.247.46.202])
        by smtp.gmail.com with ESMTPSA id i4-20020aa78b44000000b0051c66160a3asm8574380pfd.181.2022.06.20.02.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:34:16 -0700 (PDT)
From:   YuTong Chang <mtwget@gmail.com>
To:     bcousson@baylibre.com
Cc:     tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        YuTong Chang <mtwget@gmail.com>
Subject: [PATCH] ARM: dts: am33xx: Fix MMCHS0 dma properties
Date:   Mon, 20 Jun 2022 02:34:13 -0700
Message-Id: <20220620093413.4041-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.36.1
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

According to technical manual(table 11-24),
the DMA of MMCHS0 should be direct mapped.

Signed-off-by: YuTong Chang <mtwget@gmail.com>
---
 arch/arm/boot/dts/am33xx-l4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 7da42a5b959c..0446e2622d5f 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1502,8 +1502,8 @@ SYSC_OMAP2_SOFTRESET |
 			mmc1: mmc@0 {
 				compatible = "ti,am335-sdhci";
 				ti,needs-special-reset;
-				dmas = <&edma_xbar 24 0 0
-					&edma_xbar 25 0 0>;
+				dmas = <&edma 24 0
+					&edma 25 0>;
 				dma-names = "tx", "rx";
 				interrupts = <64>;
 				reg = <0x0 0x1000>;
-- 
2.36.1

