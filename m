Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F57C48A9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349031AbiAKIvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349019AbiAKIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:51:42 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C261C061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:51:42 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ie23-20020a17090b401700b001b38a5318easo4622702pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K49u+vw8xuJoyxVWZcA3NU+d4XvPmTqJkyhbFma1tEc=;
        b=dhVYdWw7PREA2x6EIZ4xujgcUvHYDPBvCt58d97/WsIX21uIzkZiCc2rXn6tw/8ef+
         N59TsHOZYauZ8NIBcMJjjYvDiYsFlqTLhkJtJaxu8O4qr38BnNaXg9WbqDAR6OEQ3MWX
         thmy55rc30zJKjDoRD0OdJKhs1Or9+tNIVskVu+8IDN0hFpKlzwprBCUI789q1AmzO6H
         SXEj/uSp87gr+stzL4xBYBR7Iqolh7Gt8E6pK1vnVj8htrZ9pgAmCRnu5fJpXGRyerNt
         K2S4VjfTTzAOuEkbIz0uCUPEKWg/iHzHXdvOqZVaMz/ysUKrbS2rDn/K7qfFN1DXQ5oR
         3wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K49u+vw8xuJoyxVWZcA3NU+d4XvPmTqJkyhbFma1tEc=;
        b=xh9qQxbeLF7dBWHUdKW3pbZLmhARg4Sc8K0L8P6kOYD+OWWv493pFEAMASIUZvrA7P
         n3W4QJXZ7XyFhgioqKy/FyLd+M5wgOq7CT2tsrzDUm+wSXObHEdtlAyBl46JvNyrb848
         s1/h8QOBC9N39+x5ETY4YWOm2sJWo/AAct6hyZsPyXNRh70g+mrHgdcVGHGy3eoc8JiP
         iaG+bJt8mmhWTIlhuSxp7DQEehNyndKH2pLzhL30btw1hJUB4TWdG04IMuq/EfyLfmCj
         hUyXCb6XDcNRYZSAEXKHL/ZJ7L8tsZUJjRyxOjcEhFCvgtN9TNkRxLvKf7qP3vQ8yex5
         d0cQ==
X-Gm-Message-State: AOAM532JC/tXvzAfsLwoM+ydylStnScYBBlKqYxG2jJOk4HClDM38Iyx
        UyUkx0BIL+Lust4BARRSbei42A==
X-Google-Smtp-Source: ABdhPJyyRNf9d57sKUsXdmiRpvG67UAK/JRDnkTqjiyNt2dbhjIL4gIaHj1J+p3aF75oTpbWw45k8g==
X-Received: by 2002:a17:902:7c84:b0:149:9481:bbb9 with SMTP id y4-20020a1709027c8400b001499481bbb9mr3638418pll.148.1641891101607;
        Tue, 11 Jan 2022 00:51:41 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j4sm9447598pfa.149.2022.01.11.00.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 00:51:41 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 1/3] riscv: dts: Add dma-channels property in dma node
Date:   Tue, 11 Jan 2022 16:51:25 +0800
Message-Id: <163a2cf11b2aceee2a1b8dc83251576d2371d4a6.1641890718.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641890718.git.zong.li@sifive.com>
References: <cover.1641890718.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma-channels property, then we can determine how many channels there
by device tree.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 1 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index c9f6d205d2ba..3c48f2d7a4a4 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -188,6 +188,7 @@ dma@3000000 {
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic>;
 			interrupts = <23 24 25 26 27 28 29 30>;
+			dma-channels = <4>;
 			#dma-cells = <1>;
 		};
 
diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 0655b5c4201d..2bdfe7f06e4b 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -171,6 +171,7 @@ dma: dma@3000000 {
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <23 24 25 26 27 28 29 30>;
+			dma-channels = <4>;
 			#dma-cells = <1>;
 		};
 		uart1: serial@10011000 {
-- 
2.31.1

