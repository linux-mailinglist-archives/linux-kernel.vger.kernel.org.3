Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA2598E37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbiHRUj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345633AbiHRUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:39:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39215CC31A;
        Thu, 18 Aug 2022 13:39:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u14so2992440wrq.9;
        Thu, 18 Aug 2022 13:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cz2xkGMsvByC41KkhoxRGFhYkqJUO48ZE7vPhgR2CEU=;
        b=RPzK3EqVWgkwzhrUoWt9Lcth8291nLaD3ap5UBCNJePslUbdZbSUUokVZAhDTIH5QU
         qyEsKGtI5d3wWdjrdU7uY8JeUnOdQereM3LyXEzUTYoX8eeYKp3RWDOozT8jgz8AkH6p
         /mgmfdjX6W9DlQBOX+kGbZMzIHrH9S2FdYAV1GOdxiADvap//ERYrMq+C5L+0AXbN14n
         EwUsmfqHnLotsYHEGX1OImAIWnQyifI5bv2miQXdeN4NMOeu+iAhT/QyPqRs4l4P+Upc
         tz1zP954RUSNCSDi4O6STqrBeBn8YrMLXHTxmZsVfXJJ+M4217EMjIBxitEqs3oxH6qn
         86Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cz2xkGMsvByC41KkhoxRGFhYkqJUO48ZE7vPhgR2CEU=;
        b=2VSfY32estmOY8YsbOFrI3OF1Yey7wC2pkqbv3UIE0a/ltkVHx3hNephPU4CHUv/mz
         +Y7STnLZuv3BZWJ/lDR5jchZGWeqF+RjG4QiamkRHC3UHTAin9uX/MWlpwYzzM8n+w//
         5d/Au8KEY89u/ZLvyN7sxuMF08ZvEYybJInlQME7SMeJ1t2dDSx2/oG8UB2COO9p1m09
         ZAMvKY2ZG9HQAfjTqhzdKjlQYaG4hawvvIGgOfRE4JRR0XzezOXpdyZ/PWMwmqT/R3ss
         KMTMgkmXp0IuTrBwlMaLeklJRjtT2mWGDtGI9HeaNam4tMHkjcwiTHzgkpca0juo0qDc
         ufkg==
X-Gm-Message-State: ACgBeo2FbpHp20nRCRUNY+YnZebuQevWUo70fkT5S0vlm/tdUkmwJr5z
        fSYFY6kBdsZawRsRAY7eT7M=
X-Google-Smtp-Source: AA6agR41I9bNS4f0/4x1g+p1U1HKuv/Abo8MyzgVn0XT48d4RsvzRO+AVYBgyJKukDc5r3B99a2LbA==
X-Received: by 2002:a05:6000:1d82:b0:220:5f9b:9a77 with SMTP id bk2-20020a0560001d8200b002205f9b9a77mr2440848wrb.622.1660855176518;
        Thu, 18 Aug 2022 13:39:36 -0700 (PDT)
Received: from localhost.localdomain (2a01cb000c0d3d00cc34c67bc193cac8.ipv6.abo.wanadoo.fr. [2a01:cb00:c0d:3d00:cc34:c67b:c193:cac8])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a54d610e5fsm1571648wmq.26.2022.08.18.13.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:39:35 -0700 (PDT)
From:   "=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=" <peron.clem@gmail.com>
X-Google-Original-From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <cpe@outsight.tech>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: allwinner: h6: Add cooling map for GPU
Date:   Thu, 18 Aug 2022 22:39:26 +0200
Message-Id: <20220818203928.131059-3-cpe@outsight.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220818203928.131059-1-cpe@outsight.tech>
References: <20220818203928.131059-1-cpe@outsight.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Clément Péron <peron.clem@gmail.com>

Add a simple cooling map for the GPU.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 5a28303d3d4c..943ae5374dd6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -186,6 +186,7 @@ gpu: gpu@1800000 {
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			#cooling-cells = <2>;
 			status = "disabled";
 		};
 
@@ -1075,6 +1076,27 @@ gpu-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				gpu_alert: gpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 };
-- 
2.34.1

