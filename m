Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC12529E12
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbiEQJaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243360AbiEQJaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:30:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130742E0A0;
        Tue, 17 May 2022 02:30:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h24so11133599pgh.12;
        Tue, 17 May 2022 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jvAEBjwUOb6zwBl6DiP+4dhdWO5kB2YZRGfj+rIA7BU=;
        b=i3/TEtwKdC1L8jE2kpraxfjfQMZdWlaYJ82HkAzVjRv1/y1XlOVgD1ZbQU7onzcfg4
         giVARRWtF7FK4zX+k1ALoozacX8jutwm3/ULK8aEXr4g2MGhBGqEkfF7h6KKVsaKUcnL
         azIFQtKcacL4leEBRCIlgqOPMb1y59+AEWnx8Hu3EDGY7Tr8hppkIPlpNEcfoZFmM51S
         VKqpotpc+dWRtQGiIWKDaUyEoM0SXgqNGP9X9I5/gp2PbgPW7Do52MFhLn3m415PhKcB
         6bD1x+JCldY9h1YFecy4cWIBPebN73w68lokoa7zrjkAoRpXPiqcoaZ2Yk7k2Q8l8Mxk
         9Vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jvAEBjwUOb6zwBl6DiP+4dhdWO5kB2YZRGfj+rIA7BU=;
        b=k9YUWPXA/2xIuQD1u1cM7W7ueeOTRSpUt45AnKaLhZxEcf44Nao2NjPs5NqVnBlNtv
         DmPaFhBtyuExT75wh5e1/9CltD3GqqxVRUa8w+0FvTpj0QlCi2A3h3GBVHT8vvaWr6VX
         vpEjL9MtxHuBikuvRVoLP/ao+6547lxc24oB8iSfff33zASZH/wzmHEuz9SADQ8gq9T+
         rrljcC6+e+x9YGKNFMKPoennsCXnGmr8VwKCTBRRBLdSf0jlfDrC2e/HlurJ64gD/5nT
         H3AF8vW8HnML5i+sJgJ2eWTGxmu1xf2VpJBodeDApbB86OCtKG4AfX1m/qwiyydixM8E
         4ZwQ==
X-Gm-Message-State: AOAM531C67+zAJJjqUYGFDDIAsD4hEmW2t/hn70PbVL+m/Z4MZHpV/EN
        EKjA2p2qZPE2WEZuX1bEwqQ=
X-Google-Smtp-Source: ABdhPJzwh48w1dJnWm+zZPcO4dArsIyEoEUhwOO2vSh7KhfR5xavNbJ0X9lVMD7tpl/w+Avzv0B6TQ==
X-Received: by 2002:a63:dd09:0:b0:3f2:804a:cf11 with SMTP id t9-20020a63dd09000000b003f2804acf11mr5338934pgg.621.1652779799416;
        Tue, 17 May 2022 02:29:59 -0700 (PDT)
Received: from localhost.localdomain ([116.89.131.16])
        by smtp.gmail.com with ESMTPSA id h17-20020a62b411000000b0050df474e4d2sm8399720pfn.218.2022.05.17.02.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 02:29:58 -0700 (PDT)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     benjaminfair@google.com, yuenn@google.com, venture@google.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, avifishman70@gmail.com,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        JJLIU0@nuvoton.com, KFTING@nuvoton.com, ctcchien@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 1/3] ARM: dts: nuvoton: Add nuvoton RTC3018Y node
Date:   Tue, 17 May 2022 17:29:24 +0800
Message-Id: <20220517092927.19537-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517092927.19537-1-ctcchien@nuvoton.com>
References: <20220517092927.19537-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nuvoton real time clock RTC3018Y in I2C node

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
index 0334641f8829..c1248211b1b4 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -202,6 +202,12 @@
 		reg = <0x48>;
 		status = "okay";
 	};
+	rtc0: rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+		#clock-cells = <0>;
+		host-wakeup-gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
+	};
 };
 
 /* lm75 on EB */
-- 
2.17.1

