Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A836570A18
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiGKSoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiGKSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:44:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CCC23177
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:44:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v16so8133100wrd.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1IQZ5rMVEddPML6F8h702sg3EwlT7K9zE2hYh3JCeM=;
        b=Jj+OLkUk2I13jTPtOe9Kyi7VcOuVAPM5BzlQNEypZZQp+NbKf9nMZCCFQ6hHqiqW86
         tHABUXE/YfQlNFzH02VLigSQnRyMO6RX68IAt7jTy7bg8wqYs6Pi/wZmk6vanMypaWqE
         yq3BDMUQEyhYOOs9qMBeoSGec3rKC/acJ0OJlRmVS0NOQz+eWaPudEhyXwtFRoV5VCrU
         BR6v+4fB9VcyCy5FcimyhsXOn93hng3OBJ82uoQAUeaGQreemb48CXtrir8Vr/lMXfE6
         SXvSBmpV63c4EogvWZImFBN6z5sb82Lk06Ak6eG+PCnnbtwgHAdd/ggGETj36Qx8m49v
         y+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1IQZ5rMVEddPML6F8h702sg3EwlT7K9zE2hYh3JCeM=;
        b=WOYGsYbwpdiHTQyvExpk08rmiKSyeynY+njQtdL4VhLexc+qGC499oXVyVPzIK+yn4
         0aYutXTfh2l9/SwtHsBTBCEe0v5LAfA45pMZQtifaztUecibiAMvpfudSkOuZwqkwZ73
         DPmEjy2Ldfp8NBbkLf0Ke0ILRhFmpYeP0JyuQGpmHH+FABsEGJK0dSBg1G4v9/NjVlf2
         JZyiLd2b2ai5izt3RU6JbB/aRLTjiGwBMCdlBhNE0mHvW68I5wqJNfkpuXAcCpbqfGqo
         oqrge8JG2ywHlKBfVVzSskh1Q8mGzsg2lrQF3kUytZwoFteg8l0g9x9ypBFHj1O3NAEo
         XX8A==
X-Gm-Message-State: AJIora9DyW//oor+uf8+Vi5yCpLO8gKfcMvrJJi88tGrVzj2ZAjiQR+m
        jJ9rah0FlKlEWuee+22OxO4KDA==
X-Google-Smtp-Source: AGRyM1uVjauKfuKiTPMOqOvAQPCUUKMYYNjIBIvYdkM4RZWSrJUmn+aRiqrXVxOF1fvtcHpC/7FBxA==
X-Received: by 2002:a5d:4f90:0:b0:21d:a6da:eb6f with SMTP id d16-20020a5d4f90000000b0021da6daeb6fmr5729408wru.283.1657565050659;
        Mon, 11 Jul 2022 11:44:10 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c410900b003a02cbf862esm7330892wmi.13.2022.07.11.11.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 11:44:10 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor core
Date:   Mon, 11 Jul 2022 19:43:26 +0100
Message-Id: <20220711184325.1367393-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711184325.1367393-1-mail@conchuod.ie>
References: <20220711184325.1367393-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The JH7100 has a 32 bit monitor core that is missing from the device
tree. Add it (and its cpu-map entry) to more accurately reflect the
actual topology of the SoC.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index c617a61e26e2..92fce5b66d3d 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -67,6 +67,23 @@ cpu1_intc: interrupt-controller {
 			};
 		};
 
+		E24: cpu@2 {
+			compatible = "sifive,e24", "riscv";
+			reg = <2>;
+			device_type = "cpu";
+			i-cache-block-size = <32>;
+			i-cache-sets = <256>;
+			i-cache-size = <16384>;
+			riscv,isa = "rv32imafc";
+			status = "disabled";
+
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
 		cpu-map {
 			cluster0 {
 				core0 {
@@ -76,6 +93,10 @@ core0 {
 				core1 {
 					cpu = <&U74_1>;
 				};
+
+				core2 {
+					cpu = <&E24>;
+				};
 			};
 		};
 	};
-- 
2.37.0

