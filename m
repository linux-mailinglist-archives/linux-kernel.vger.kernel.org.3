Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235E9466849
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348004AbhLBQcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359768AbhLBQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:30:09 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A01CC0617A1;
        Thu,  2 Dec 2021 08:25:34 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id d11so710595ljg.8;
        Thu, 02 Dec 2021 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hHEu7xIUmbPKbJQuG/1auedODddNVJ0Qz8PQOApRayA=;
        b=PJS5NAphD8TMG13iWbjMT5Rvd0gBYlUTq3SvIbF/78W43Bl3rA3Jzqx03+4R2FKkuW
         QX5+9/OHFFtwo47h0GMJWQ8u+MGzEs/x1gDGKRNEDMBnayGFJuHhHA4uJSaugJIgUxSx
         hf18OYwSYZY43aGoXqzYOplCl6uOUAOkoPKouEcTNwkhOFrQMo+6oyw0cCZSFEYz6x0f
         KS48Lyto0JhjGWClc6WCbPuAFCkfeUARvdE+O9v1/I9T40gmsT+9ufErgcHwL1jpdZ+g
         x0cSUMSamn2a0xVPPXbTtCtdmbc1jpO6BsDfcLsLCCeIilr4nw4p+Eazzo4VEDab2IZK
         IXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHEu7xIUmbPKbJQuG/1auedODddNVJ0Qz8PQOApRayA=;
        b=48WTt5K8rtI2BtdN0DEAiIgtXVIghZ7Vm0VuaobSTescb1BcJFPYbio5WYcXk4M8D3
         5Xq/EOUDB4KdXW/pljOUX/x4Mb1jnCrVTIZV2A4KK4khIgI38f86SmRQSFwlSDb3uiWk
         QRAqG0vkH7+eULoo5xNnruzmQ//wwyh6ocB17lBKzXT3Z96SQ9u3+RX1KPfpcrKUUJA8
         BXWDP+2ORxpbNysQVolFDeqFseKfaMIGJcJQyXVFO9g/p+PbvW9VF6fw3I1aVITwmCRt
         aghesnXUtqNRfh4ANKY2Z0wWpAGHRPZx/W3Ohk5ondkBghlytPhjWo53z51/ZQv79mGO
         saJw==
X-Gm-Message-State: AOAM533p51BQ0zrUFJBJnxaXAVdiwbeURkL1rSinNYHv4opnAb4dV76q
        ZZBrNEPNt0TiXDtOf8deXhU=
X-Google-Smtp-Source: ABdhPJx97fEFBmRZTMoe4ceEqyDWsJCVc6i11HIbIt8I0RAFW/psqD4Gy32WAxA2oWW7diz92ZbKUw==
X-Received: by 2002:a2e:8090:: with SMTP id i16mr12623406ljg.125.1638462332604;
        Thu, 02 Dec 2021 08:25:32 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 18/20] ARM: tegra: Add HDMI audio graph to Tegra20 device-tree
Date:   Thu,  2 Dec 2021 19:23:39 +0300
Message-Id: <20211202162341.1791-19-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
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

