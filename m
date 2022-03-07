Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254DC4CF14F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiCGFph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiCGFpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:45:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327484B1E8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:44:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q11so12797996pln.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 21:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3fmm4nvalmQleWa1byPzKYwRMYCW7Pxtk8Gk5epwAE=;
        b=fl6tc4VC43ATK5SOcF9SU87whyYsM0/UNtzRWx1LVbVHj6trycs4EzVouaEEZrcpKE
         YC3iW3uXyA9P+iYT3vY/qMfHCuVwCd8S1tqyHxVxtac71XDsOIu+nMvTTY7QMQ/RNvWB
         KeuqZjyWE+hUEVXjKZhptxrbfUOlV7XU4tRNHayODoaEB7NjoS+o2a0Mnp7UWJLF2bIj
         jTC291bbLpDvmrw5q6vX//tuLYirSx6QQATmcn5dOYn1ETGZiqQ25erIbgBbeog9VnzY
         VuA8xqF0bs5B/8CdvaQLH3WrRzU7N/+YFucgiQo1AJA4I+6uqV7BbPIsg10CFjo09Fv0
         NrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3fmm4nvalmQleWa1byPzKYwRMYCW7Pxtk8Gk5epwAE=;
        b=H1WCghYdTusjMQaYRfilXf6f7G3VzhFUtZE88VNQSle7dhm4M0RMfpoosH7Zd9BgP0
         y1xkO3vWij6yb3iZHzHrhJuG01yXCuWUOJruNUQQAFguXd4uVYc0d8Iy+DCnwQmu/xLw
         vBZETCK2KIfFKzLvpx3L2Ctk0HvOvjUsne0sE8kbq/fGCwGhPVBwbyJbgbyUhpElcYLs
         yymJqMd/ghE49CfKSq5bU1j5O+JjTRo+hOUWFLemhQjWTM3+Pyjg2mOQwH0shCLvswZo
         1xw1Z753oor5Ut0ky+m9rdDdQENlGZFUrAe2P3tdyltewl4hGgwzgN/qHHFBVFoElU9e
         lrrg==
X-Gm-Message-State: AOAM5331Z3oysc4PPal1p/D13kuba25KcJZ4Kh3vx2PjW0v6VhfaWKNj
        isFuPP5vi317ENjuuQ8PvsPlwQ==
X-Google-Smtp-Source: ABdhPJxmHZJzk1QvRtzUfWeyEP/BccLNeBIBfFdyOzW6/M5gESO4UArQMmmb+9KSWVVM69HaTw8K5Q==
X-Received: by 2002:a17:90b:314b:b0:1bf:7c7:d304 with SMTP id ip11-20020a17090b314b00b001bf07c7d304mr23359289pjb.224.1646631878754;
        Sun, 06 Mar 2022 21:44:38 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id k1-20020a056a00168100b004e0e45a39c6sm14447385pfc.181.2022.03.06.21.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 21:44:38 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v7 2/3] riscv: dts: Add dma-channels property and modify compatible
Date:   Mon,  7 Mar 2022 13:44:25 +0800
Message-Id: <b9ff5d8bef78d87d630d9defa5b39262f5abdcf5.1646631717.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646631717.git.zong.li@sifive.com>
References: <cover.1646631717.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma-channels property, then we can determine how many channels there
by device tree, in addition, we add the pdma versioning scheme for
compatible.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 3 ++-
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 869aaf0d5c06..d8869ec99945 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -187,11 +187,12 @@ plic: interrupt-controller@c000000 {
 		};
 
 		dma@3000000 {
-			compatible = "sifive,fu540-c000-pdma";
+			compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic>;
 			interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>,
 				     <30>;
+			dma-channels = <4>;
 			#dma-cells = <1>;
 		};
 
diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 3eef52b1a59b..6a3011180846 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -168,11 +168,12 @@ uart0: serial@10010000 {
 			status = "disabled";
 		};
 		dma: dma@3000000 {
-			compatible = "sifive,fu540-c000-pdma";
+			compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>,
 				     <30>;
+			dma-channels = <4>;
 			#dma-cells = <1>;
 		};
 		uart1: serial@10011000 {
-- 
2.31.1

