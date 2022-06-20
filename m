Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D934D551927
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242792AbiFTMl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiFTMlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:41:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC197666;
        Mon, 20 Jun 2022 05:41:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i15so9636185plr.1;
        Mon, 20 Jun 2022 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plDsixdHGkwReRRapB3IYjwpAfTPKVvhPbyz+pv/gYI=;
        b=ICmMV2oszgwzC2Pyc/0I+mdIeWs7c01X5l7teViNCY78TE2k/DLbunTbXZ+3RJuUQR
         NhrQlIwfHtvIVZGwBJ+b1z3G3aevXXts+j3THIeTaA2Ei/yzWDDGXgyXE5HOaLfVvdiB
         HKy50DI8VMCQeYwgeVB6/OMhABD/0iWfj6iyE8mf3CVp4OPkF1jhDQLgIzqXvmy4GFtv
         7gZFVGnYRTl6BiSIS4mDQY1shJKGi8O7DQ02MdqxSDckOaoU2e1yTHNfFji9/LQeNDxl
         E2WgQ6MoHvlvVSIW4fPN+Br8xvPlLzzU35BTLKnoZ5ySBHqHhsz8DAT8fXxpPJgejYym
         Nqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plDsixdHGkwReRRapB3IYjwpAfTPKVvhPbyz+pv/gYI=;
        b=gk6xrJPKlpoIk3pEcriDQYTTaFecOTvQM3h5waSyzzXVqf1A6Ok3WjrCKZoE/gQcJ+
         ksKVJUTKZwfunQcldCBcSV1NS1P9qSFJK0oMZg8/+OnnoZxMwOnMmQcVgYppmpjOsMva
         lfUOBtMdW2rpCHpCmmsOw+hFMZ9fRuBLERqK2WFS5HNS1gp+e/BiwBmAN6YtqVCTc1N5
         PZxM76dB4ksB1FCTYLGsO/nuAhiysAwb33sG7b8cS6xSxmUCe0TU7A542LNqZ1/JeiLJ
         iqKV/heozZN+ZvrrFCCq/IoqlMRHZ2U2pH9AcoWw+7PyN9arVj7R/gBFlTBCxWkFz4oi
         LN1g==
X-Gm-Message-State: AJIora8m60EGAJYGUj14GcmwmnPk30lrLdJhMwU19+YTrgiXdhojxJdO
        BLQAsPgjzFxP/HwbyqMRNVw=
X-Google-Smtp-Source: AGRyM1tTb8x3Fl2gd43ULKfcA4VCOkb9FbTFSBiJ27F3JiSYUSQJeaMB7ccLk4xGEBoTeh5sraQVPQ==
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id s7-20020a170902988700b001516e1c7082mr22606756plp.162.1655728910034;
        Mon, 20 Jun 2022 05:41:50 -0700 (PDT)
Received: from linux-server-us.. ([172.247.46.202])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b0016a1c216b73sm2938777plx.9.2022.06.20.05.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:41:49 -0700 (PDT)
From:   YuTong Chang <mtwget@gmail.com>
To:     bcousson@baylibre.com
Cc:     tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        YuTong Chang <mtwget@gmail.com>
Subject: [PATCH v2] ARM: dts: am33xx: Fix MMCHS0 dma properties
Date:   Mon, 20 Jun 2022 05:41:46 -0700
Message-Id: <20220620124146.5330-1-mtwget@gmail.com>
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
v1 -> v2: Cleaned up coding style and addressed review comments

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

