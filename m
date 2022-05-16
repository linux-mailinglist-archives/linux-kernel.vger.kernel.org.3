Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1793528488
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbiEPMt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbiEPMsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:48:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120CC393EB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j6so28396338ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EM4jnNGDw7AMU0PeAM69NyPeBAC/GVPGYbDdF3ITGic=;
        b=UuCDifRXXwK1HzxNdsH/J1A6XFQx4+o2U78t9HC7AXVhV0L+fE5wQqQorYSL1+LgK3
         0RewaqFh0xxSjnX6qOWQH0zDmlSuxFmfJejL/D2RfxVO5Bs/yf0XKys7hZzz+pE3sM0b
         4QfNrCSxJF/uJ8Jn4EQ0oGg3c2wPfVHOsJc1r1pOH3AngJbjsSlGRbXEgijUBjUwOSHO
         sboyQpJvX9DVbqAfvcckC7mQ/7R4c36cpznFopScV8Q7Bgii4/EFdeRR+UVOxzW+35ws
         4gCxi2C7LylLfpbYLDiX7GtzeA+whzRGnsWg1Oebb7/FysyV6kcMzNpEtDq1ga8CiQQ9
         ISfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EM4jnNGDw7AMU0PeAM69NyPeBAC/GVPGYbDdF3ITGic=;
        b=4oOfFtT2F6/6B3l2L5xXBZ8bR5widoKYjnx7NdYl/w+aDK+suvkR4bayHMk1hhgaz8
         aC0WypMAhmLpwbCdA/GKGfoxD+jLG3PPsOf/+A1HNsB17BwbW6W+EE1LemCeru8Lw/RI
         2WMW4b21ItMnW03CRhY2UNQO1pKB/xpf52IgdTCYu+dpEM0LMunfmleEEHOMF++Pfn33
         PM9q/vCq6jo4el8fzb073RW2naCzuR29IFKwIYqFrHUzjrSyWVskiDFtimKcQe4G9jO+
         SjqzLtuickFYV9XM/JUNitLLv5h54dodFthnLA+B+bmRWXMGTFUZf0H/88/WtqsR3ac/
         hTkQ==
X-Gm-Message-State: AOAM530eRM6opxEdpmrLj+Nf090yI+PvRUz+cf2AJnSF5clkP1DafeW7
        gBvX8pDWTRUPsHKf/rrxOGU1LQ==
X-Google-Smtp-Source: ABdhPJxgHP/xJxIC0DfcLUofYXhPz/6yxm46vP1IE7I22RveeiTrEhXbkLaTZi3uflSML03Vho7zXA==
X-Received: by 2002:a17:906:c14b:b0:6f8:e6bb:f8d5 with SMTP id dp11-20020a170906c14b00b006f8e6bbf8d5mr15032709ejc.4.1652705332508;
        Mon, 16 May 2022 05:48:52 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id e10-20020a056402330a00b0042617ba6386sm5093331eda.16.2022.05.16.05.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:48:52 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 10/10] arm64: dts: marvell: add support for Methode eDPU
Date:   Mon, 16 May 2022 14:48:28 +0200
Message-Id: <20220516124828.45144-10-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516124828.45144-1-robert.marko@sartura.hr>
References: <20220516124828.45144-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.

They feature the same CPU, RAM, and storage as well as the form factor.

However, eDPU only has one SFP slot plus a copper G.hn port.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
* Make the DTS split a separate commit
---
 arch/arm64/boot/dts/marvell/Makefile             |  1 +
 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 1c794cdcb8e6..104d7d7e8215 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
new file mode 100644
index 000000000000..57fc698e55d0
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "armada-3720-uDPU.dtsi"
+
+/ {
+	model = "Methode eDPU Board";
+	compatible = "methode,edpu", "marvell,armada3720", "marvell,armada3710";
+};
+
+&eth0 {
+	phy-mode = "2500base-x";
+};
-- 
2.36.1

