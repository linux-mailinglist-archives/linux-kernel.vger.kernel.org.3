Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3325308C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355592AbiEWF0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355563AbiEWF0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:26:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F252C25EB;
        Sun, 22 May 2022 22:26:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so12656463pju.1;
        Sun, 22 May 2022 22:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PLLLntBRKNP/TR5HdmPuN09W5k0TVn71VC7Vx2rA/LU=;
        b=qoDnotxySoygzG7LDqmRxBz+yEnAjAoyUwB5EeLCCUnfIBo0oIK+1PXtE16UYnFlvE
         GVfqsI0HyM8P2rZxmc4svDZrb+l99fOuzadugqWvOmStscFC+Ax2CvHgtc+kqUQjOTVb
         ed42OFT7pW5FNi/yRvcyqhtbLntR1DQsgCLI03nEPnYTLPUULCFeBlVgGcMfYpC+hAMb
         ZOAVnoclGBt0dw1zcXyIJTuPVcVbU6vhhZy2yfEAgwEOiB36qtPzjLThpYQaGZutCgl9
         8kvLNcdf+uiWlG2F7V+Jp4HGD5jUYtNm8szMOCRkiXestQHeohSKZ6XVYEN1PVCpfUAZ
         wxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PLLLntBRKNP/TR5HdmPuN09W5k0TVn71VC7Vx2rA/LU=;
        b=c3lxIGg92mwjWnqQy9yTFWmY0ZZLYvUCaSC3cxikWLamAkWF9cPVso4bQvbcq5gcAw
         B/zVUJGZiqIhqCqTXehc8TqkwTcUXhjDF933wxqE/BmaSYooOitgKM/utv2vGM+xNBlN
         FGS7TRCCsdtF8B1u60umSCKZ3gK28PWbqMh7x6bFIMjabQJskBgmPuv/FBIdHzdDEeJa
         ZE2TDnNPqHiuYladiGVNhbLKD0YG6lnroMxPxHtvMjg2+LPUTlKU0EMydG3Rw15G0PRV
         0kuDWEnxsgW8h4z3aokfvSp7AfTmsqP84HOlZHu4KIu9awu01OfWsm4NQvEu+Nb4x2sm
         4KWg==
X-Gm-Message-State: AOAM533hq5lpaYegEctWrZPtabunRF8xx6UFiJA9CW+ghmi400XWG2Zf
        EeA4Z6vya7FF4hrX7WReYwQ=
X-Google-Smtp-Source: ABdhPJyMHWgHcFMRk4ZK1dOj5OyOTswPsOPx+ERGze4TRYKvLU4M3Jj8l4qGkzJgLvBMtpDwuCKhsw==
X-Received: by 2002:a17:903:25cd:b0:162:2250:b04d with SMTP id jc13-20020a17090325cd00b001622250b04dmr4147933plb.12.1653283567458;
        Sun, 22 May 2022 22:26:07 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y5-20020a655285000000b003c14af50603sm3871523pgp.27.2022.05.22.22.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 22:26:06 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v4 1/5] arm: dts: Add node for NPCM Video Capture/Encode Engine
Date:   Mon, 23 May 2022 13:25:44 +0800
Message-Id: <20220523052548.28109-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220523052548.28109-1-milkfafa@gmail.com>
References: <20220523052548.28109-1-milkfafa@gmail.com>
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

