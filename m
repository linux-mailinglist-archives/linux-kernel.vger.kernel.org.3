Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE04B35D0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiBLPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 10:09:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiBLPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 10:09:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4943F214;
        Sat, 12 Feb 2022 07:09:50 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso5006442wmj.2;
        Sat, 12 Feb 2022 07:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4oJBB1iQ3jXfwvtZfxmVO4BCVeU0b4Dxjp4jQuS4LA=;
        b=EN0CBr7TkAOT5wI9D+VTki2rVGNhSiFlnU8uZcFivC6dzqXYLwsozAtIn0XyB2fmOn
         HSoDZp7ouQHaT1QD5WzDQztebXyKfq90n3zzZlclFO4juArW1ILS6HqogYLugwvjr/tc
         O83E8utMm4nQo0wt9jENI1TFZetaRBBXZrIIjT54l+7ns7DXvF/cEay2mFSnSOC6Wzg+
         I4vX7Ym7LjsLFTX+b4/+ZniGFnItdlZ3aIRzEk/UHOuAmLIbgZNWPsgyFeXdXfOaIPlG
         9DEXNEAMsQsH1RMlM9kIKaVLtEuK9Wnynphl2MKk7xZ4FpY+8AbfR6bkxmLLe8A1VqIr
         QYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4oJBB1iQ3jXfwvtZfxmVO4BCVeU0b4Dxjp4jQuS4LA=;
        b=OSB+jKa/jCHeo4W9VKevtnUCgzV/8EJHbtzK7QOG8IgZdUMcpmnrHrxXIbA2XvQa9e
         jm46JQa+7s537TFHj0pRTzvOgfr0u+xB23tZj8kXrBYNV4vVyX9fiQhzRqXHS6SaM+YH
         YHEBTqhKZ2SrozdaRq+nkwc19/rUQvY8P5KSgiYw9H579gTnC4I0UcEsPDi2hdzKuFqM
         f9EHm5839NJG544rT7SiPoaclV28qSJbB9zSUj109tb4zoNNyFj2SBHXulBPQk9h9hMq
         uq7qH43IgOiAC9AXpXyzrov/WDNmnAuixx9FhC4ZfIqNInxxvMmqyOmfJfl5p+p8qB6K
         ZLtw==
X-Gm-Message-State: AOAM533/IaR3KDG4LonnmugKnT4Xjjygbyag0qtfteJg0EnOXyttKBO/
        a7wjX13bMCtAWZ0iJP4X86Q=
X-Google-Smtp-Source: ABdhPJxWPICHL46SoAErCtd1MENUNuoP9hQwMONMogsMSXSliP+22OKiWAobCME0X2uu3G2cUAKvHg==
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr4409429wmq.44.1644678588769;
        Sat, 12 Feb 2022 07:09:48 -0800 (PST)
Received: from localhost (92.40.203.136.threembb.co.uk. [92.40.203.136])
        by smtp.gmail.com with ESMTPSA id o4sm4582459wms.9.2022.02.12.07.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 07:09:48 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dts: x1000: Fix missing TCU clock in tcu device node
Date:   Sat, 12 Feb 2022 15:09:27 +0000
Message-Id: <20220212150927.39513-1-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should've been present all along, but was omitted due to
a mistake in the TCU driver.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
v1 -> v2: https://lore.kernel.org/linux-mips/20220209230145.18943-1-aidanmacdonald.0x0@gmail.com/

 * Split DTS changes to separate patch.

 arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 8bd27edef216..c69df8eb158e 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -111,8 +111,9 @@ tcu: timer@10002000 {
 
 		clocks = <&cgu X1000_CLK_RTCLK>,
 			 <&cgu X1000_CLK_EXCLK>,
-			 <&cgu X1000_CLK_PCLK>;
-		clock-names = "rtc", "ext", "pclk";
+			 <&cgu X1000_CLK_PCLK>,
+			 <&cgu X1000_CLK_TCU>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
 
 		interrupt-controller;
 		#interrupt-cells = <1>;
-- 
2.34.1

