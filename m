Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E575468596
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385338AbhLDOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243484AbhLDOlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:14 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708F2C061751;
        Sat,  4 Dec 2021 06:37:48 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c32so13807075lfv.4;
        Sat, 04 Dec 2021 06:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkcS7+n1gGRETsbxAVke0DfOgp5thJ9O9vqlNwbymZo=;
        b=kv2emZJWkJTujeoo/B8BstrOBYDbdGuc57GGc8hkUquVLVp7bDCUL0DA66kijcAH4d
         449pqpwpZ7zRfpKur2KGwMDOT83ItGf7l4k8LZqZ4+gDcYkwgJEYGmynkTnBe87KvUxb
         AH2KPgQUXa+hgf7DM4Gaz2mzuoRnSH5ncsgC/IEKy5ajMCFv/bWRMCsRshodRtdQkVJ/
         4v3Hc87NywbXLwSnsaPCBWits7Pn0gRwoi3FnE5VxRxLwqh9KXcGHwz0OzreXND/ffS9
         lGPytKHmoxALxblmGh6K0pZneN6lIvsGcYjrUHVyHyLo/kZKu+/r7aPdwnfNPl48nAGA
         iaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkcS7+n1gGRETsbxAVke0DfOgp5thJ9O9vqlNwbymZo=;
        b=AFOLYDWPSTuR3DoospF2VQJzi+IgN29Zpv3vcVF+WpDxnIACVYBS1uBsf0k0djsJ5w
         O8k9KAbnbVOu0MevXVkamjRpp41kJ9AV8rvZfy5s8390Ou0SBI5QaOpYgBHrnVfgdn4E
         idWTzqggMKIEP43c14Jq9zNLevt+n0v3JIEENpjMQfXrkMNLTriwuXcR9yFamA8mLbO/
         x4PmcQQv1+zeG1AJ14nu7lQqPoaX8yqr5Z84hT/F7cJdlr5kWryeloZUNfX92NiX3gUG
         gR5Xjwif+D9h9oAs0XZMo5mRrwL10BG3bxhohr/Vb/+NvcAWwIJBwnog88Co7434NeyK
         yJ1g==
X-Gm-Message-State: AOAM533ojeaQop3H293Pbc15zXFVuFmvwT4oWj2nA7aSZK95L73bC08x
        Mz+JBAxqyT9WVRtHbrXlM2g=
X-Google-Smtp-Source: ABdhPJxVyr80sNTp3Ra50xhUsVA8jhye5Uem6qk6wXJWErKHgo6ZLg3UwuWsCshEDUsQpvKkvk7WgQ==
X-Received: by 2002:a19:791e:: with SMTP id u30mr24186475lfc.539.1638628666780;
        Sat, 04 Dec 2021 06:37:46 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:46 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 19/22] ARM: tegra: Add S/PDIF node to Tegra20 device-tree
Date:   Sat,  4 Dec 2021 17:37:22 +0300
Message-Id: <20211204143725.31646-20-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add S/PDIF node to Tegra20 device-tree. It's needed for enabling HDMI
audio support.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 63c2c2f8c0ce..72cbe32d0c1d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -197,6 +197,7 @@ hdmi@54280000 {
 			reset-names = "hdmi";
 			power-domains = <&pd_core>;
 			operating-points-v2 = <&hdmi_dvfs_opp_table>;
+			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
 
@@ -396,6 +397,23 @@ tegra_ac97: ac97@70002000 {
 		status = "disabled";
 	};
 
+	tegra_spdif: spdif@70002400 {
+		compatible = "nvidia,tegra20-spdif";
+		reg = <0x70002400 0x200>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA20_CLK_SPDIF_OUT>,
+			 <&tegra_car TEGRA20_CLK_SPDIF_IN>;
+		clock-names = "out", "in";
+		resets = <&tegra_car 10>;
+		dmas = <&apbdma 3>, <&apbdma 3>;
+		dma-names = "rx", "tx";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+
+		assigned-clocks = <&tegra_car TEGRA20_CLK_SPDIF_OUT>;
+		assigned-clock-parents = <&tegra_car TEGRA20_CLK_PLL_A_OUT0>;
+	};
+
 	tegra_i2s1: i2s@70002800 {
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002800 0x200>;
-- 
2.33.1

