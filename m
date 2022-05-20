Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F6652E2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344855AbiETCsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344831AbiETCsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:48:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813A114675B;
        Thu, 19 May 2022 19:47:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j6so6610145pfe.13;
        Thu, 19 May 2022 19:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PLLLntBRKNP/TR5HdmPuN09W5k0TVn71VC7Vx2rA/LU=;
        b=HbGYfpAIScYy7rUPgRC2VngAHXrnAlthass+NUjn0m0ZxLDHydn3dGeqpTvh/cNgjc
         g8vtAZXI/SRU4tlbyfGc+Hx8vV1nLhfRAvK6qJgB/2leG3XkyvuQeXbWXQ4Wa4GDQvTK
         YIYWipvkjh48QVgz/5HiMGeCMymQOf+eaRqTZTI9P08q1s76dyFrsZnqyGpxg+ZoXEbk
         Ypfk0lic3xKsZC36dq1IrwaX8/35B9QQuMubluoyINN6iL8UNn6JF8ZrMiK5/HZf6ULV
         GzCl27WbdRi5NrPBba1x/pSIgvBDVt+N+nFD39KnHa9nLHtkYrhCfq14Dk3c85H9wqRx
         x8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PLLLntBRKNP/TR5HdmPuN09W5k0TVn71VC7Vx2rA/LU=;
        b=LtJ+LHcqA4Kbyhd/MQCcAuRStCsdb1jPa1iEQj/+YMJ1XpUc4XZWYp2kbokNShIzDZ
         trAyF3nn6EWZ7oP/fB1e+cssplds3RseyTGTzhLRlx3NxwZjjNFwlyjr4bIZ/MxPGnLp
         7sydwY/ZnRsEMEZehq8LWsGl9OMcVucQoA14p9w+4+MnuhenDf0C3wNZoQg7NZHLks4l
         8lmK1xW9iIw/2rsJUdgl/nebjK9XPNWuR755Ssp62g7mlpl09PlnwBdtUZV7N5TZKNxo
         Vdx7yHV5K47JsBPNJns65K5Vifl7yvEyBrxKqXuEZ4pZAfoh02PZ8V27/3q0V5Vc8GuY
         yOnQ==
X-Gm-Message-State: AOAM530vVGKWIifgCWfx+fHlPgBe4PAFez2RxaHdatz/e6KfZds2tPsY
        mvCO1CSKu8zpB5RUDw/0QGc=
X-Google-Smtp-Source: ABdhPJxg2CUR6hFUHRTDEKGa2nHovb0+dGvuSLQdEKWoHzz5PoCdPR9PqK1r8IKVD6B0YSHQzpPD4Q==
X-Received: by 2002:a63:2ad0:0:b0:3c1:5f7e:fd78 with SMTP id q199-20020a632ad0000000b003c15f7efd78mr6620687pgq.56.1653014878947;
        Thu, 19 May 2022 19:47:58 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n9-20020a629709000000b0050df474e4d2sm379406pfe.218.2022.05.19.19.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 19:47:58 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v3 1/5] arm: dts: Add node for NPCM Video Capture/Encode Engine
Date:   Fri, 20 May 2022 10:47:40 +0800
Message-Id: <20220520024744.25655-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220520024744.25655-1-milkfafa@gmail.com>
References: <20220520024744.25655-1-milkfafa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for Video Capture/Differentiation Engine (VCD) and Encoding
Compression Engine (ECE) present on Nuvoton NPCM SoCs. Tested with Nuvoton
NPCM750 evaluation board.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index 3696980a3da1..0d2df74974bf 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -178,6 +178,19 @@
 			status = "disabled";
 		};
 
+		video: video@f0810000 {
+			compatible = "nuvoton,npcm750-video";
+			reg = <0xf0810000 0x10000>, <0xf0820000 0x2000>;
+			reg-names = "vcd", "ece";
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>,
+				 <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+			reset-names = "vcd", "ece";
+			nuvoton,syscon-gcr = <&gcr>;
+			nuvoton,syscon-gfxi = <&gfxi>;
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -553,6 +566,12 @@
 				pinctrl-0 = <&smb15_pins>;
 				status = "disabled";
 			};
+
+			gfxi: gfxi@e000 {
+				compatible = "nuvoton,npcm750-gfxi", "syscon",
+					     "simple-mfd";
+				reg = <0xe000 0x100>;
+			};
 		};
 	};
 
-- 
2.17.1

