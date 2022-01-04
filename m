Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A9F4843F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiADO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiADO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:56:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F773C061785
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:56:55 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso1583337wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjC9RoatGf4NuVo6mZRinaRaNOZbl6EwcNrtjHiT4O4=;
        b=pVKyM/tpT8WV2u9dQSjWb2R2+yIp2RFRzYSVHtO1Z9f1E6ly/Q+A1sfyVjPJHK8nda
         1CJXRxRLD/OQW9iXB6ddlL2BwpjbSXUNER2HA30aAcMNpF2hWRWBjQ1MfdRgBaSszfaT
         7gC90tLlau/wWwAL8N8gqPmmRrrwOGD9o4epZ1DKNRWUDzPi0AEY0Z1hFazx9ec6m/eg
         0MjTRqsZiLYS/tQqN6amr22bO4z8G4xpIz9HXtXucEYIkivGLk84vl2f2pAZdOJ0EqfT
         44zO+/qQYMZQBqdw8zLkXXo/17FcLasTNYxAPFykx6ZMU5vw3N1D12Or/eZzMTe4QhEw
         AAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjC9RoatGf4NuVo6mZRinaRaNOZbl6EwcNrtjHiT4O4=;
        b=kqBnwsNThJetA43i6Gy7LJoqF5wkQ6VRlB+NvwOhDPA3REzWtBagl9Zi/qDY6OyOTJ
         zBc42HITBxBFyDlcbRbqaIAW+4/cUs7ahV94d8gNr/QLbloSXOSXIiPGTuHtpPS5LjMr
         O8LV9IlZh9ltLNCwP1lnr3FxgkV9w+5ivI0SzZO76Sa0DT9G/dk1JEInqSBWKfx8QWAO
         XFHcNQKCB8abjwXWd6esWUFzEnp6cwMUMi0wDR5AvaWj6H3dtYcnVkF1u/qykQ2pthi+
         Gb5flaBqmWsNlD9QywgTH8g+67iedQxiq+7Ab16zAoRy49qndFgmCI4fC3UuY7K1/Elf
         OoRg==
X-Gm-Message-State: AOAM530YF6+EuOFpfeE0GV9AZslG0beBnz5G3hzxQ9uCYGDtFJFmLze0
        B4RohD7NXrW3mT61jr3VVOvyefeD7ZdB2A==
X-Google-Smtp-Source: ABdhPJxFptGtlJldG0ByIqvEYEbbrflwjVjobp1qK+74UeP6+B5JY8OVsdELT/IyNlyDInC3z44YDQ==
X-Received: by 2002:a1c:4c08:: with SMTP id z8mr41067300wmf.48.1641308214010;
        Tue, 04 Jan 2022 06:56:54 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f6da:6ac:481:1df0])
        by smtp.gmail.com with ESMTPSA id k10sm19309859wrz.113.2022.01.04.06.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:56:53 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-oxnas@groups.io,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH arm-soc-next v2 3/3] ARM: dts: ox810se: Add Ethernet support
Date:   Tue,  4 Jan 2022 15:56:46 +0100
Message-Id: <20220104145646.135877-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104145646.135877-1-narmstrong@baylibre.com>
References: <20220104145646.135877-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the embedded Synopsys DWMAC Ethernet controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/ox810se-wd-mbwe.dts |  4 ++++
 arch/arm/boot/dts/ox810se.dtsi        | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/ox810se-wd-mbwe.dts b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
index 7e2fcb220aea..c59e06ff2423 100644
--- a/arch/arm/boot/dts/ox810se-wd-mbwe.dts
+++ b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
@@ -103,6 +103,10 @@ rtc0: rtc@48 {
 	};
 };
 
+&etha {
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/ox810se.dtsi b/arch/arm/boot/dts/ox810se.dtsi
index 0755e5864c4a..96c0745f7b70 100644
--- a/arch/arm/boot/dts/ox810se.dtsi
+++ b/arch/arm/boot/dts/ox810se.dtsi
@@ -81,6 +81,24 @@ soc {
 		ranges;
 		interrupt-parent = <&intc>;
 
+		etha: ethernet@40400000 {
+			compatible = "oxsemi,ox810se-dwmac", "snps,dwmac";
+			reg = <0x40400000 0x2000>;
+			interrupts = <8>;
+			interrupt-names = "macirq";
+			mac-address = [000000000000]; /* Filled in by U-Boot */
+			phy-mode = "rgmii";
+
+			clocks = <&stdclk 6>, <&gmacclk>;
+			clock-names = "gmac", "stmmaceth";
+			resets = <&reset 6>;
+
+			/* Regmap for sys registers */
+			oxsemi,sys-ctrl = <&sys>;
+
+			status = "disabled";
+		};
+
 		apb-bridge@44000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.25.1

