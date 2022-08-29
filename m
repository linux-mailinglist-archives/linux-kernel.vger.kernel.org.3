Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873EC5A5358
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiH2Riw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiH2Ris (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:38:48 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4424E9C21A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:38:43 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id j1so6838975qvv.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=I/SAEi6d7MQzK2zmN3C2Xz2o5qThFKoSXxNju+OsJpA=;
        b=ExueIjbnC8ELzM7W1vKR2FOynY1q8Fh3VZ5Wj1BktKSDzf7cIL8U2DbErh6JjFm6MI
         +O+XGdOHlHUUoIQt8Ed8ALIq247yV826r/JIw6oQejjlRixuULEUd7wNvH/Ij6L62JDF
         aOxGjuIyzSmlBO++pezTZa8cD0dvXrEZidJmxLXYXjvWRcdHdwSswjCBBi2nRcyGyLmf
         VUUwbqgShkABLrpa8GQGbu6scME+aVXr2pBRp/NNYMPsxOaIwJwg/1QWOUXPtRjCXnCH
         7kng41a0spVw6XAnlk7u1C39rsOZgQjbR6QflkHnAS7uxpPA5ePu606KFmGo1/89+u2r
         uHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=I/SAEi6d7MQzK2zmN3C2Xz2o5qThFKoSXxNju+OsJpA=;
        b=UR7h3IV6YNksf9dI1OhjYJtc1Ot05tk+/KKYxT0A6OCtNLklX/ZBHEAVtD54PbiNGM
         pD+l61eeHGzJA8FppX0X1KiUA5Y8DBradrdmjXCWMGzLr+Lt6uaSxNcLD1hJsHfwgx3V
         dq1Y8rDGEzLpmCQQNwwDYad8aRA3Ns5bZP+ToaG73pkaOBjloOAbTT+toIQg58+YgdV/
         r7hSKY+UnnU+/73/O0pKL1pgMIWHGnPIpi8R1dVs6c8ipLtWrKrSEt0L/lOdP2UnSKQa
         sSoYGeQHehpHw6XybFJOQgGrP19pSwQolqpX/bOKU/WLy0obYAVeW9L98qi98DB6JnRA
         M4MQ==
X-Gm-Message-State: ACgBeo11p25skmHLwmD8RL0w6E3m0T3gDhQBkbSCAFdiNeGcqD1LBQow
        R8LOyDdX0dYsNAM3yGJe2Uc=
X-Google-Smtp-Source: AA6agR7prCnqNNbI5hjcg/QnEFm4SxS15Vz1qgfQQyokaHeubUPKXPU9sds/jGpWQGwpQoMilmTTvQ==
X-Received: by 2002:a0c:8e8d:0:b0:496:b53d:c775 with SMTP id x13-20020a0c8e8d000000b00496b53dc775mr11474870qvb.36.1661794721961;
        Mon, 29 Aug 2022 10:38:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j8-20020a05620a288800b006bb7ccf6855sm6543583qkp.76.2022.08.29.10.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:38:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     soc@kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        krzysztof.kozlowski@linaro.org, arnd@arndb.de,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        william.zhang@broadcom.com, anand.gore@broadcom.com
Subject: [PATCH v2 2/2] arm64: Kconfig.platforms: Group NXP platforms together
Date:   Mon, 29 Aug 2022 10:38:29 -0700
Message-Id: <20220829173830.3567047-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829173830.3567047-1-f.fainelli@gmail.com>
References: <20220829173830.3567047-1-f.fainelli@gmail.com>
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

Group the three NXP platforms under an ARCH_NXP menuconfig symbol to
make make selection of similar vendor SoCs visually nicer.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/Kconfig.platforms | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 748f9ac4d775..61d946e092d3 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -143,12 +143,6 @@ config ARCH_K3
 	  This enables support for Texas Instruments' K3 multicore SoC
 	  architecture.
 
-config ARCH_LAYERSCAPE
-	bool "ARMv8 based Freescale Layerscape SoC family"
-	select EDAC_SUPPORT
-	help
-	  This enables support for the Freescale Layerscape SoC family.
-
 config ARCH_LG1K
 	bool "LG Electronics LG1K SoC Family"
 	help
@@ -207,6 +201,17 @@ config ARCH_MVEBU
 	   - Armada 8K SoC Family
 	   - 98DX2530 SoC Family
 
+menuconfig ARCH_NXP
+	bool "NXP SoC support"
+
+if ARCH_NXP
+
+config ARCH_LAYERSCAPE
+	bool "ARMv8 based Freescale Layerscape SoC family"
+	select EDAC_SUPPORT
+	help
+	  This enables support for the Freescale Layerscape SoC family.
+
 config ARCH_MXC
 	bool "ARMv8 based NXP i.MX SoC family"
 	select ARM64_ERRATUM_843419
@@ -221,6 +226,13 @@ config ARCH_MXC
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
 
+config ARCH_S32
+	bool "NXP S32 SoC Family"
+	help
+	  This enables support for the NXP S32 family of processors.
+
+endif
+
 config ARCH_NPCM
 	bool "Nuvoton NPCM Architecture"
 	select PINCTRL
@@ -264,11 +276,6 @@ config ARCH_ROCKCHIP
 	  This enables support for the ARMv8 based Rockchip chipsets,
 	  like the RK3368.
 
-config ARCH_S32
-	bool "NXP S32 SoC Family"
-	help
-	  This enables support for the NXP S32 family of processors.
-
 config ARCH_SEATTLE
 	bool "AMD Seattle SoC Family"
 	help
-- 
2.25.1

