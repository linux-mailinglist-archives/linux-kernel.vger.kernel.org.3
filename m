Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EBC4C2EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiBXPED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbiBXPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:03:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5678B141E24;
        Thu, 24 Feb 2022 07:03:26 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d3so108678wrf.1;
        Thu, 24 Feb 2022 07:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07w1eqbJ15tC5JNVyR7gPyWNsdMe4ksKSNb7RJ89FRc=;
        b=Kr/SpNEEK10kPz2CyojbzFHbGPxq0EX6NdwDNWASMKt2PU6AnpTD4G1XPni+fCxeiI
         qibZ21FBLSzAJ7yC/uBZb2LDSgFPDKb206q5vFxFFNeg10zYXzLp5UWurTeXquCTvFAC
         jZ4llp7fd64thdCXYnVRQaYnbfmqglDTdE0OoUCH8v59qkDy+AXkNFkieNYPW+vL6lxu
         K9vhzSUyHtN18Xg5UuD4F9+YkyWv3cnRAhj7gFkCgnW/NkwROdCDvNKQ6O01SsFVqEQ2
         wKU18h1zPMLPLlA8Xf1kim5yR084gAKEj9kHrzPLCC6Lu+hQSalUpwraBCoxA3OYRY6B
         EucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07w1eqbJ15tC5JNVyR7gPyWNsdMe4ksKSNb7RJ89FRc=;
        b=IEwh7dPK3nOmkhEdRlv1pTJHjbwwnvdhRJjQ+4vZMusNKA56hzge0Qi/zN048Z8wYN
         c8OdY8Nzx8Gzrp+WvSrGuS1UyobGnoH6+a2KQp/jlmJWc1VqrQ3cQ1y2q+tmkxOvlCfP
         qIZOd7Eo16G+tBJIxpgzLv5tck6p6tcZoUo0+5yrRKP6JpiLUjG8K9O2tOcvi+eI+rev
         5An3lfPcRps5X/6kkQaTmqiU7+TYgEQGY/EahS/UOcXHsn9SCfB61smxEv3IJzvq/kgS
         EtIftdsBWJDipjLnQCCGrAWri3T6YBcMGkqkwrXhQIOUUxD4DPjiRqF7ZKj+QixPn85K
         8TGw==
X-Gm-Message-State: AOAM531bib91LSvJmlwvRMhpwG1lmr5fcQAfc3nZXuQkjd4xXrPcXHR8
        ybsvEYKzhcYfbryYUsDD9JV11V+1lJTw2A==
X-Google-Smtp-Source: ABdhPJx6KbtOCExwexuwkiyhLyven+vSwBXYqmckAU+Jlq72l1EYhf+xNeAbVtVrN6thv/ozgo/qCQ==
X-Received: by 2002:a05:6000:18c8:b0:1e4:b8f4:da8f with SMTP id w8-20020a05600018c800b001e4b8f4da8fmr2694759wrq.199.1645715004964;
        Thu, 24 Feb 2022 07:03:24 -0800 (PST)
Received: from localhost (92.40.203.111.threembb.co.uk. [92.40.203.111])
        by smtp.gmail.com with ESMTPSA id w13sm3088645wrv.21.2022.02.24.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:03:24 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] mips: dts: ingenic: x1830: Add TCU clock to tcu device node
Date:   Thu, 24 Feb 2022 15:03:26 +0000
Message-Id: <20220224150326.525707-2-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224150326.525707-1-aidanmacdonald.0x0@gmail.com>
References: <20220224150326.525707-1-aidanmacdonald.0x0@gmail.com>
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

Like the X1000, the X1830 was missing a TCU clock that belongs here.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 arch/mips/boot/dts/ingenic/x1830.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi b/arch/mips/boot/dts/ingenic/x1830.dtsi
index 2595df8671c7..4408df24ca98 100644
--- a/arch/mips/boot/dts/ingenic/x1830.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
@@ -104,8 +104,9 @@ tcu: timer@10002000 {
 
 		clocks = <&cgu X1830_CLK_RTCLK>,
 			 <&cgu X1830_CLK_EXCLK>,
-			 <&cgu X1830_CLK_PCLK>;
-		clock-names = "rtc", "ext", "pclk";
+			 <&cgu X1830_CLK_PCLK>,
+			 <&cgu X1830_CLK_TCU>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
 
 		interrupt-controller;
 		#interrupt-cells = <1>;
-- 
2.34.1

