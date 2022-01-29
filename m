Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691C24A312E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiA2Ryr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:54:47 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36244
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351193AbiA2Rye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:54:34 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AD6413F1C4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478873;
        bh=FfSK7PHOPnItg2UxrfQMXnmMovdesQ6QCsFxowTZ2mY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=unnrMevZztbPtESj/r5NpoxBdYPTBpVGCLxfClNhjdEFMHphBlBYQYT1K2lPwO0jn
         5kfKE2NvG9iO4HY1wiZyPeqEemStq2AqhLCm4AndEVPk2qO0F/s7P23cVXynAeWOHk
         j7abiYHrfroQNVbKcJPPj9C3w0+HvGC/Vu7WVSGi3kDjJg/7q5P6PRzw7CQM2arvEX
         Z/HYQtDs5B1wLg1u+43Yif7shFQ2ttmt+HM6usRswcww7xMQNGNDwDYKY7HuctQvH5
         xJbR5f4NAPCV5JqxINwg+tI1L0fbFFeXxqGuQqYD/vkalClnyMf6zxj39YHWhltoJy
         xUKXphdcUGQlg==
Received: by mail-ed1-f69.google.com with SMTP id n7-20020a05640205c700b0040b7be76147so179453edx.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 09:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FfSK7PHOPnItg2UxrfQMXnmMovdesQ6QCsFxowTZ2mY=;
        b=NUxoL6VUYS0jx6utLueBwSfrsIBH7Qht006N+Fu4uktgANc8SGRfdR3D9PO38zOOsB
         gxibCIDKbnlslNGgd5ir87qTkt6SQ/y5E35LV+wYGIFuX+VLxNXbToIHeA5UD3L5Wrt9
         g7MzGPgYjv6hN3cIeyG6H4mgdcV1EJsUpaypOCsSz07cDtGRBqa0CT76DzRS1F4wRqTe
         eqSn2KWetCMTrZC4RJFT5ye5vvEIWijMBsvjw4hNLLo/Xl2u1h99KP5CYrjixGjFQh5A
         pm8Z7xpGt4u5uXJhQyDtS9R1sa1R8dRdIKvV5U5ud4DdIMRtFmNAr3+p0hdzBvT9lELh
         1y5A==
X-Gm-Message-State: AOAM530ExsxOGgNoctL/gFTK2vNXEIGtyPGUTeR/oDl5TLtBRUaseEp/
        x4keAlGXhDG6RpsF4edtgE/5qoPMPA1oQhNTea5Ct4YwmScdvl71W8texAF1sslPrmFE4n0HHHY
        oAhJIj8ZwFTWgcR/gq/qEDhNppK0OvTRQlqsqXOKqcw==
X-Received: by 2002:aa7:cdc5:: with SMTP id h5mr13597833edw.293.1643478872892;
        Sat, 29 Jan 2022 09:54:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx58d91XDto/xMjxDExr9JEzl/j/uOxsqzxZgQC3OzHOq4RT+oNor18vlDFtJgtZhK5hCpM2Q==
X-Received: by 2002:aa7:cdc5:: with SMTP id h5mr13597817edw.293.1643478872702;
        Sat, 29 Jan 2022 09:54:32 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a25sm875655ejs.149.2022.01.29.09.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:54:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] arm64: dts: rockchip: align pl330 node name with dtschema
Date:   Sat, 29 Jan 2022 18:54:29 +0100
Message-Id: <20220129175429.298836-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes dtbs_check warnings like:

  dmac@ff240000: $nodename:0: 'dmac@ff240000' does not match '^dma-controller(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 2 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index f972704dfe7a..56dfbb2e2fa6 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -711,7 +711,7 @@ rktimer: timer@ff210000 {
 		clock-names = "pclk", "timer";
 	};
 
-	dmac: dmac@ff240000 {
+	dmac: dma-controller@ff240000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x0 0xff240000 0x0 0x4000>;
 		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 39db0b85b4da..b822533dc7f1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -489,7 +489,7 @@ pwm3: pwm@ff1b0030 {
 		status = "disabled";
 	};
 
-	dmac: dmac@ff1f0000 {
+	dmac: dma-controller@ff1f0000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x0 0xff1f0000 0x0 0x4000>;
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.32.0

