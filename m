Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E904479608
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhLQVL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:11:57 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:44780 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbhLQVLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:11:50 -0500
Received: by mail-ot1-f42.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso4383560otj.11;
        Fri, 17 Dec 2021 13:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I+t20QleD2PGL+WYrCPECqqzvnxEHkAMmI4IR3Gys78=;
        b=n4F0q/fN/BnxE76FXz1u+83VzkWhaHhqqidqYQ8qfgTx3DOAPaXIKm3ugBx+ibJ07R
         idZfLlwqC+f/kNLvfJapoNl4mjOS6TeSoBdfVOrTran7QiRkmBr8QTICRFR7pF/PxGcL
         c94/kYdmigbSYk7kaZynD49NpxH+bTofrZ+rMNo0GKrNIUnv1apim3mtlNT+/2ngTgiQ
         uzRWu6iO7CT2rLBZaJQfYm78WHuQ4ENMJ85plnNhi8YKbsTZMYkrOQWOWSqq8pvbCBF8
         3b5IGGvqDD5QdXJzFsN6Km23DbYYkKuYRcSfG1AKBLatn3V5wopVeMpqOXWEtFmAinzZ
         t2TA==
X-Gm-Message-State: AOAM533GXxAYh3CveIu4JZP/ux8HchHwGTMle4SUCHAJLuUujbcVF2XQ
        mt0S8bk+3Dqusj1NwKs6NQ==
X-Google-Smtp-Source: ABdhPJy6x8vqiMtHo7/RF6BWxEthz80anojjDi5ZQsstpRC2m737c9/XC6s/Aovl9GVB8RW/FY5V8w==
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr3482087otf.198.1639775510015;
        Fri, 17 Dec 2021 13:11:50 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id c3sm2004022oiw.8.2021.12.17.13.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 13:11:49 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Fix msm8998 cache nodes
Date:   Fri, 17 Dec 2021 15:11:36 -0600
Message-Id: <20211217211136.3536443-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msm8998 cache nodes have some issues. First, L1 caches are described
within cpu nodes, not as separate nodes. The 'next-level-cache' property
is of course in the correct location, otherwise the cache hierarchy
walking would not work. Remove all the L1 cache nodes.

Second, 'arm,arch-cache' is not a documented compatible string. "cache"
is a sufficient compatible string for the Arm architected caches.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 52 ++-------------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 408f265e277b..00adee461b52 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -138,15 +138,9 @@ CPU0: cpu@0 {
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
-				compatible = "arm,arch-cache";
+				compatible = "cache";
 				cache-level = <2>;
 			};
-			L1_I_0: l1-icache {
-				compatible = "arm,arch-cache";
-			};
-			L1_D_0: l1-dcache {
-				compatible = "arm,arch-cache";
-			};
 		};
 
 		CPU1: cpu@1 {
@@ -157,12 +151,6 @@ CPU1: cpu@1 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
-			L1_I_1: l1-icache {
-				compatible = "arm,arch-cache";
-			};
-			L1_D_1: l1-dcache {
-				compatible = "arm,arch-cache";
-			};
 		};
 
 		CPU2: cpu@2 {
@@ -173,12 +161,6 @@ CPU2: cpu@2 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
-			L1_I_2: l1-icache {
-				compatible = "arm,arch-cache";
-			};
-			L1_D_2: l1-dcache {
-				compatible = "arm,arch-cache";
-			};
 		};
 
 		CPU3: cpu@3 {
@@ -189,12 +171,6 @@ CPU3: cpu@3 {
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 			next-level-cache = <&L2_0>;
-			L1_I_3: l1-icache {
-				compatible = "arm,arch-cache";
-			};
-			L1_D_3: l1-dcache {
-				compatible = "arm,arch-cache";
-			};
 		};
 
 		CPU4: cpu@100 {
@@ -206,15 +182,9 @@ CPU4: cpu@100 {
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
-				compatible = "arm,arch-cache";
+				compatible = "cache";
 				cache-level = <2>;
 			};
-			L1_I_100: l1-icache {
-				compatible = "arm,arch-cache";
-			};
-			L1_D_100: l1-dcache {
-				compatible = "arm,arch-cache";
-			};
 		};
 
 		CPU5: cpu@101 {
@@ -225,12 +195,6 @@ CPU5: cpu@101 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
-			L1_I_101: l1-icache {
-				compatible = "arm,arch-cache";
-			};
-			L1_D_101: l1-dcache {
-				compatible = "arm,arch-cache";
-			};
 		};
 
 		CPU6: cpu@102 {
@@ -241,12 +205,6 @@ CPU6: cpu@102 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
-			L1_I_102: l1-icache {
-				compatible = "arm,arch-cache";
-			};
-			L1_D_102: l1-dcache {
-				compatible = "arm,arch-cache";
-			};
 		};
 
 		CPU7: cpu@103 {
@@ -257,12 +215,6 @@ CPU7: cpu@103 {
 			capacity-dmips-mhz = <1536>;
 			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 			next-level-cache = <&L2_1>;
-			L1_I_103: l1-icache {
-				compatible = "arm,arch-cache";
-			};
-			L1_D_103: l1-dcache {
-				compatible = "arm,arch-cache";
-			};
 		};
 
 		cpu-map {
-- 
2.32.0

