Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9228E46859A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385384AbhLDOmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbhLDOlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:15 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4090DC0613F8;
        Sat,  4 Dec 2021 06:37:49 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id j18so11865313ljc.12;
        Sat, 04 Dec 2021 06:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hHEu7xIUmbPKbJQuG/1auedODddNVJ0Qz8PQOApRayA=;
        b=leSChBds958mAfUMY9jeuuqD5Qn6lvxbEB6QV5qCZ0n0CsKze78eor5z0bN9rj/7Vw
         h7/tlsyatSb4Rnn4aadHj9eKx3Hufmh5E1AfSh5sxzyV+r76EZLz4xGtHt/Upcn83GRk
         VlmvlBxwI9IrqnFSd36xJr7Sj1OUvD1LYMjcmuDTUgiYSK1yb5hTeoP7IWcrLVmEe8Vq
         ABkcKxWz8+fCJmaobjrWsaQaOyL68eh9YEuSyfNpUr0lL4ZpAvMCkfWw+ME8czOM9IQG
         5rwGwfIae8P3ENqoKLVdn2qIscFlew1Y0QtLEW09HYlSN5ZtDmEBLi/dLcE2RWXmINFP
         Ns6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHEu7xIUmbPKbJQuG/1auedODddNVJ0Qz8PQOApRayA=;
        b=tFZlbskz4WeA2+Vc/GZIltWETzEiqFsp+5UuMk7tjnJOnGrz1VORMAi62+GWFhr17f
         yc3D9heHQZvewI1jElULEyWI/NRCuRUa2aESAv+y5gPQ282x2LsP9K6H816UWcousdH5
         17lKfzEh+yjaikoAI9mlxb7p3X7sjqS0IqQC7QA/PrMVlvT1qqTwGN8zPfBj98PToN2V
         KcugPKhpO6ViIBO0Stq2vCgtdugzFCq0qF3SAMJA2/jJFiVYMbYxuyTt+eYlwPEB2dCD
         nwo+SNfAfLohTz3gYS5RbsDHBLPE/UuxihInfTUgy1DkC9/y9jJTtusisyZ86rlhuOMv
         aqaw==
X-Gm-Message-State: AOAM530KLbYViOU7ttFuvyrGu5FDmD0u2pY9Tg9Q6lX6qUDbtyL56RkD
        sDeKzHGJUtQx6TUC67tV/0g=
X-Google-Smtp-Source: ABdhPJyDeO75xIBk/QZj5qYQSqZV15+DMrRsbXBSrSANn3YT8kCBPAn11GIEkBQ9rFB2qoWlosH3Fw==
X-Received: by 2002:a2e:b8cf:: with SMTP id s15mr24932955ljp.297.1638628667574;
        Sat, 04 Dec 2021 06:37:47 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:47 -0800 (PST)
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
Subject: [PATCH v4 20/22] ARM: tegra: Add HDMI audio graph to Tegra20 device-tree
Date:   Sat,  4 Dec 2021 17:37:23 +0300
Message-Id: <20211204143725.31646-21-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HDMI audio graph to Tegra20 device-tree to enable HDMI audio on
Tegra20 devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 72cbe32d0c1d..dde228bcbbff 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -186,7 +186,7 @@ rgb {
 			};
 		};
 
-		hdmi@54280000 {
+		tegra_hdmi: hdmi@54280000 {
 			compatible = "nvidia,tegra20-hdmi";
 			reg = <0x54280000 0x00040000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
@@ -1063,4 +1063,24 @@ pmu {
 		interrupt-affinity = <&{/cpus/cpu@0}>,
 				     <&{/cpus/cpu@1}>;
 	};
+
+	sound-hdmi {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "NVIDIA Tegra20 HDMI";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+
+			cpu {
+				sound-dai = <&tegra_spdif>;
+			};
+
+			codec {
+				sound-dai = <&tegra_hdmi>;
+			};
+		};
+	};
 };
-- 
2.33.1

