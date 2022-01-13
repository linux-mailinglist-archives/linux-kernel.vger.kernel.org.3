Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0348D1BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 05:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiAMEpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 23:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiAMEpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 23:45:52 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7700BC06173F;
        Wed, 12 Jan 2022 20:45:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c71so18462984edf.6;
        Wed, 12 Jan 2022 20:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZBLBMo0FMbEtIJpoOidyGwsdZCYDTmf8Kl5LcIDvQzg=;
        b=RduABD0/Iy2DuiYfR/f2rVzAtFGwY2XDX1UtIZZtkk1JVeYMdN2Ah0IGWPGGZNKoyy
         C8GaXxboP0MiQh/9HO6f+oZKxczLfOPKhKPK1wzLqCZKDn0Cpro6KskIGHn3zb3IR+PS
         kFnEEtUEAqYfULdUcLXRXV1Q0Ra5UyFpH3LASCntUep/sA+2/P+H9rQ8wyV/VI3DAqpc
         StuKKfY9pmYuIV0jOZPKdw6qg8J3F/xYIbVZROj7HSO9VbSomz3G9+E9yDj8aDvJLlmq
         iqXsK9U+xMdhRy6KjO95gZn9Pf/vOK2pkTUQNjzz52Z7+AWIjX6lo+f1ajtCqZUmDwsg
         uKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZBLBMo0FMbEtIJpoOidyGwsdZCYDTmf8Kl5LcIDvQzg=;
        b=KfnyCSJCb9sYkqCDCqnxY351dqBlxwk/5Kj8lELyFA7fLNS//YAPGacqpYw7UtI7lO
         CdZ0r41CQGlIa4DVy6EtrTUqHBl2bC0rN7M0x8zqoeO6BJGeW7VtXknBxUJWLqF6d0fW
         mQlPeEkMzkFxPtp7AJapfjYVyhW3P5RqWkQE04BgknUFNC91VdrGRvYDetJueA/GqvVd
         nn7GhdQjU6uUGb/5IswSwY32WoVMWypfMeiH/375nbyRVs/ABjwi0fd25KSvKoATyv+D
         srb2pzYjTwzjGC2zLV6nWm8fUG3J7fv/H5pHHsWZ+6Ky2YXFZ7ho33JV4u0AZ8edhnKU
         PSaw==
X-Gm-Message-State: AOAM531qV2lV0XaXJkGneAtlEPaMOWiT54WKGI+xBBI/Z6LykgZUXT9s
        qnS4o9XzsOLxNd27/NTKlKn5jj3FORNPFGJs
X-Google-Smtp-Source: ABdhPJyOzQGKHC2fdVcOPLUDg94J6QU/Pp0BHs60Q5SYgrungCHape3obDdCrxo88bKM2W5MCfkzQA==
X-Received: by 2002:a17:906:2f97:: with SMTP id w23mr2132611eji.739.1642049150538;
        Wed, 12 Jan 2022 20:45:50 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e16sm667983edu.15.2022.01.12.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 20:45:50 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add audio playback to P212
Date:   Thu, 13 Jan 2022 04:45:46 +0000
Message-Id: <20220113044546.16856-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial audio support limited to HDMI i2s.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
The P212 dts is widely used with Android box devices that follow the
reference design. The real P212 development board probably has many
more audio capabilities, but as a minimum we can enable HDMI output
and help box users too.

 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
index 2602940c2077..a39830379c74 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "meson-gxl-s905x-p212.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "amlogic,p212", "amlogic,s905x", "amlogic,meson-gxl";
@@ -32,6 +33,45 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "S905X-P212";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&aiu {
+	status = "okay";
 };
 
 &cec_AO {
-- 
2.17.1

