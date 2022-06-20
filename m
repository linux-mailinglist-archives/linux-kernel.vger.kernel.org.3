Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17115518A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbiFTMTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242272AbiFTMTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:19:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794595F6F;
        Mon, 20 Jun 2022 05:19:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d5so9563724plo.12;
        Mon, 20 Jun 2022 05:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G116oHrS6xPawz1p7YlGPW002yjrm+RWYps59Z2K3Js=;
        b=bQ3h43AIQpxpWNQaiBLocOnzDTZ7buSOL0mz19NlUnhzLU5ap878WMs1BFn61KUgj+
         NJM3YnYD8RdcyXovFq820Sr+ixX+2/d36WK0I82Kkhvg8CMQYkl88F95R0w9RP8Ef6jw
         1Bz9QbxEdsbALjrEATq3d8jBUVzUM0Ar6fUTTqTY+9FxcpgIpNHbC67pFpKDGTT4bkBk
         Lx7KPkIsOKiYHwhM9A0Dzo32AQpbgduoJ2/WKC4FeIizee5vi/DbRjJmPuJWXpyQOeHM
         z+ePZea2G9eTqgi1mFzENPhnkF9XM4HU3QhkjAkWjToSrt8HaswFOpprPCR6Ms0Fp7IQ
         /wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G116oHrS6xPawz1p7YlGPW002yjrm+RWYps59Z2K3Js=;
        b=VOn7Pb+cD/RS4Cq7Z7aoxcgwiFfIGTNgSeMA1k3dg4H2skG3UNQ+CSqkE+Fo/RSpRy
         YFreEjYER/4e2uueJv5mcoTFSGcIPv9wALAJxZyZ/miwB9ROul1vGMoTvgeHLv+cCji4
         OIzVyxixwPKegDmFrXaGBvJFowNbz+HiRyVuZN5W8TFz0fuAnb98VDwDa5Fjoy83pEiN
         Og2zQrJj6ra2X2KTA68+jfIyeraBOcJw+Xh76o13JjtnZeVET04rJZ4dwoLmfFf5rGq6
         n/UQb2LaUo5cp/mI1DjvFSCuLaxONhmQxNiV24K/U4wCvDCKqYwyl/OwLHVcNJm6pYLj
         PEqw==
X-Gm-Message-State: AJIora9f3H6EoL18POlUcjL5nxTwoaNBh5HnYBq/u7tHRS0JrUovbk+C
        Nb2+d35IPcA8mK0CJZvC90o=
X-Google-Smtp-Source: AGRyM1sUC8evC+f5PKK5DpcdqH/W0moQU/CHSv+aQrDCs/vVJib+j3xnh+/izPRDQMZhpVLBdI8p8g==
X-Received: by 2002:a17:903:41cd:b0:16a:f48:c357 with SMTP id u13-20020a17090341cd00b0016a0f48c357mr13447166ple.21.1655727543869;
        Mon, 20 Jun 2022 05:19:03 -0700 (PDT)
Received: from linux-server-us.. ([172.247.46.202])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902714f00b00168c1668a49sm8477165plm.85.2022.06.20.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:19:03 -0700 (PDT)
From:   YuTong Chang <mtwget@gmail.com>
To:     bcousson@baylibre.com
Cc:     tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        YuTong Chang <mtwget@gmail.com>
Subject: [PATCH v1] ARM: dts: am33xx: Fix MMCHS0 dma properties
Date:   Mon, 20 Jun 2022 05:19:00 -0700
Message-Id: <20220620121900.5196-1-mtwget@gmail.com>
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

According to technical manual(table 11-24), the DMA of MMCHS0 should be
direct mapped.

Signed-off-by: YuTong Chang <mtwget@gmail.com>
---
v1: Cleaned up coding style and addressed review comments

 arch/arm/boot/dts/am33xx-l4.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 7da42a5b959c..7e50fe633d8a 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1502,8 +1502,7 @@ SYSC_OMAP2_SOFTRESET |
 			mmc1: mmc@0 {
 				compatible = "ti,am335-sdhci";
 				ti,needs-special-reset;
-				dmas = <&edma_xbar 24 0 0
-					&edma_xbar 25 0 0>;
+				dmas = <&edma 24 0>, <&edma 25 0>;
 				dma-names = "tx", "rx";
 				interrupts = <64>;
 				reg = <0x0 0x1000>;
-- 
2.36.1

