Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF97A551686
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiFTLEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiFTLEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:04:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B2712AB3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:04:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so5514962wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E9aKX9oDaX2lfkTZYFCt5GDgDZqAXKuhAdFiZdMrPqY=;
        b=NW4jz6dwfA5JksloJV3dLWU46ohpfweUdbOBappE3Yd/0pA5MPuyI3XIzT+XCXHDCQ
         TphPyrKVss82RWnsp0C8VYArXNsJ2bmQp1zRnanFbsP7DD/MEjN4QgqA35e3QAgvR1sE
         L9m+M39BkIG/Ca0ZiQzPPZvhJapsLKiKwLKK+CG0gPQwegoueqSu3OiWv+7B0arCnjy5
         FLXflRBf8ed6wQYy32keNxyX/F5P3ceOSK91YBleAhg2K8W91mGgd0L8+2amsRt7xIDb
         D7EQaa/KBTgXsjezdglGahdHsoODcXjwOoA6TH/l/1awBTjmam7Ej6ue4shDzsSJnJef
         79/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E9aKX9oDaX2lfkTZYFCt5GDgDZqAXKuhAdFiZdMrPqY=;
        b=nPjBENIxAW61QE/OqLAIJOD0d3vu1uVutS8RqtCYcgzKdo0HvPQpsEZQICBKIevrug
         j6wvV8WoZhJPIYqnM99I5C/c7rAJkCWQsqe9peeUUbYIaRFZPNRW1cFp/L2EFr8bbCfs
         aMUVH/O98IWtDyYkCo6cR4xlm5DFDTgMex9LyMiZj/ZhaQBOpMhOfh3GKIpehjyI3GsN
         d6Z3W/ZP6mkWW+/tQmg1eEUOPotMYW0PEUBM23lZsZRAqIp6iH3XMkq1b8Ykgc3f8Hbh
         Q0IQJE03wF4desRPoilh/xe5uipgo43TBpEPnu5RlWp6fUwJh+i+YdDzP1CxfIWFVaIz
         0Ozw==
X-Gm-Message-State: AJIora+nZfOcpZBD1rgP7v7TIcGCsVl/eLjOHNt5CogWczi/WkRgqS8t
        Bx3g5aGHKEqGjfDYUkrm7IeE1A==
X-Google-Smtp-Source: AGRyM1sWoia6ofcqh57mNpVUqj2dfOlA//Qf4Y6NoEk7FLRl0BExflOY7RUSmN/hMk9v88Y+2OxcKw==
X-Received: by 2002:a7b:cbda:0:b0:397:48d6:6c9f with SMTP id n26-20020a7bcbda000000b0039748d66c9fmr24035982wmi.10.1655723072824;
        Mon, 20 Jun 2022 04:04:32 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x12-20020adfffcc000000b00218453adaefsm12838167wrs.101.2022.06.20.04.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:04:31 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, m.reichl@fivetechno.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>, stable@kernel.org
Subject: [PATCH] arm64: rockchip: rk3399-roc-pc: prevent fusb302 powering off the board during boot
Date:   Mon, 20 Jun 2022 11:04:07 +0000
Message-Id: <20220620110407.2393644-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
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

The rk3399-roc-pc never finish booting because it is powered off when probing
fusb302.

The type c port is disabled because not present in DT as can seen in dmesg:
OF: graph: no port node found in /i2c@ff3d0000/usb-typec@22

So adding the port in DT (as needed by the device tree schema of
fusb302), permits the board to survive and finish booting.

CC: stable@kernel.org # 5.10+
Fixes: 8bb878cf20ae ("arm64: dts: rockchip: add support for ROC-RK3399-PC board")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
This patch is tested on 5.10.123, 5.15.48 and next-20220614

 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 0e45cc2d195b..60c400ca4034 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -552,6 +552,22 @@ fusb0: usb-typec@22 {
 		pinctrl-0 = <&fusb0_int>;
 		vbus-supply = <&vcc_vbus_typec0>;
 		status = "okay";
+
+		connector {
+			compatible = "usb-c-connector";
+			data-role = "host";
+			label = "USB-C";
+			power-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+			};
+		};
 	};
 
 	mp8859: regulator@66 {
-- 
2.35.1

