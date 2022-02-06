Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7663D4AB00C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbiBFOob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 09:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243094AbiBFOoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 09:44:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA64C06173B;
        Sun,  6 Feb 2022 06:44:21 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u15so20546383wrt.3;
        Sun, 06 Feb 2022 06:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ER5tL9joKsP7B1sna5VGna8el05JPGgUeONDDnd65Ng=;
        b=Fg0yongwHkZ2lTRaO5rc6YlMEYfx40PVo032/ibh9mVuAYXys8uRb7ZmwqMjEGZnPD
         rCmwg9ejd3Oiwjzh7EYJ2tZpBViVTgVEbKg32Bbj5U0qAvXIYRqhp1Y9iLAegMMEVyKv
         +ortYmh8HPqjj9kXWYqEO1QDqoGxIzNfDoTe4oJy8H4uN0GWOMiTPP8H5Nk3heUBA+Sr
         /hm0SxDL8QA3fLWPIYrLMdRUGPrLBb/r20i+EUGlhWnCxqbfCTpRPiHsdZ9ncF0/1ULG
         egs1Y54tO9Wv08OOdt/Gic9EwGSnX7clVMSNpFLAyxJtnYUecJiJmghsTWxwZwv5s1uR
         qobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ER5tL9joKsP7B1sna5VGna8el05JPGgUeONDDnd65Ng=;
        b=UNThgrvq8aQlRyNtQSaGRVnkg40QGvqO/9HHHHuEyF3T6UMkG7bRtw9csj1jh7wvGq
         dKjSknr/ieaXTucRCxAI/yYerwn4/qePijhDxqlSRN2tMHvPwhlvl0hjlQOWtF+lcBOL
         dF5R0ebn9cwIb5ugdXlxRKZjgFX1oJ7vMqc+AIASH6IW7aTKS8dIoPZH7ccw1Im0nJQf
         9nEimy6doY9Y2qpE8310FV11L9kydo+25xtV7kg7etPfi2c/iWaPfrvh0bR3N8jDQMYS
         9JXKTDy1GwHYpiVIjv/1z+QgdhFpmCb+FnB4dQOz/1aVsGiLiBmME1WLqZKqeVpYosBz
         M67w==
X-Gm-Message-State: AOAM531kQNu58sV8Ch1iowGMxsreGgkjCpvRPS7ZZWPl3THhj5dB8JrF
        3YcpOtPu7pOHOtxTVxAz8l0NNDaaEctqag==
X-Google-Smtp-Source: ABdhPJyuqIsJhNOGpgrbrRrFg3RW0vhg0iwASL1X8Z5ta+K627QiZHRLs03dlq3CsFLY3JUy6lbNkA==
X-Received: by 2002:adf:e350:: with SMTP id n16mr6270014wrj.180.1644158659608;
        Sun, 06 Feb 2022 06:44:19 -0800 (PST)
Received: from localhost.localdomain (cpc92882-cmbg20-2-0-cust452.5-4.cable.virginm.net. [86.31.103.197])
        by smtp.gmail.com with ESMTPSA id j2sm6888517wms.2.2022.02.06.06.44.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Feb 2022 06:44:19 -0800 (PST)
From:   Benjamin Mordaunt <crawford.benjamin15@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Benjamin Mordaunt <crawford.benjamin15@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] add pmu to amlogic meson sm1
Date:   Sun,  6 Feb 2022 14:43:43 +0000
Message-Id: <20220206144343.2194-1-crawford.benjamin15@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205234554.4403-1-crawford.benjamin15@gmail.com>
References: <20220205234554.4403-1-crawford.benjamin15@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
The dts for meson sm1 appears to omit the SoC's PMU,
which is essential for accessing perf events regarding
e.g. cache on e.g. the Odroid C4 platform. Add it.

 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 3d8b1f4f2..4147eecd2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -6,6 +6,8 @@
 
 #include "meson-g12-common.dtsi"
 #include <dt-bindings/clock/axg-audio-clkc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/meson-sm1-power.h>
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
@@ -90,7 +92,16 @@ l2: l2-cache0 {
 			compatible = "cache";
 		};
 	};
-
+	
+	arm-pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+	
 	cpu_opp_table: opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
-- 
2.34.1

