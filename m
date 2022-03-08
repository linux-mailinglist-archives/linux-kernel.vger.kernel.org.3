Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F334B4D2110
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350038AbiCHTLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349940AbiCHTKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:10:52 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B922C4EA30
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:09:36 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s18so4708285plp.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=geOsN3B5D2pajGUjtYVHTo7ODDoeZA/dXvJuvUQtYe4=;
        b=bA+VT4I9ZxfwZ8yFKGSlTUtH+qIbs57S7WdlvHPPy9xMoPV+tbezSe48mUgDGXO0JP
         Hp/Cm5ngjF3p2FemiNiZ6A8b8CMOH1tPZ8pHWrIbUOyVU8zR9eJFxO8vTsMz38V1S9pg
         6BensZKMWCk8fclI4SFiey5MXSZMXswKXead8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=geOsN3B5D2pajGUjtYVHTo7ODDoeZA/dXvJuvUQtYe4=;
        b=TsGJbalb8opaMNQnQSbRwP+G3DSOJ8UlvwHYT858pSACowM0dIlCPQHilGBvBJ2IhI
         MN/8MfG4hW1uDxoNnDKBUSI0r4leuz4eA+WR7ofiyqhyzChrNyqhdaIfs/CN5eRsdmbp
         QTxlFWBMKRUEe+BnEmL17l65pefBUfH/aUQgRaeMnM+b7y6PQMGP23oV9U/zexi8oDTQ
         oGMxZYuAb4kQ43Yk9GA7HDSf8nuZcAKkPPyv3MzlxUWaFPu/Aj7uRsUaAnJwlyMsP31g
         EuHt8kKRhoJ/mAEkO3pa3VrDN3YEJV3hxF4K0JiOZ5cfzijp67TQTs6vn+djc8W66sGH
         znOg==
X-Gm-Message-State: AOAM533Wp6s8rrevDiTKxC43+vZf2bBYzmCjhmF+A47gxwjF0eFCFswi
        PJ1cOpINhTHMzV0N0hRnZ+4jqg==
X-Google-Smtp-Source: ABdhPJz8sipP4o8OnOtzeYNcbMuAl0E8BVURef/sTsMInT3tF3+6fRadwtzliY/mkiCrGLMnIopp0A==
X-Received: by 2002:a17:90a:db96:b0:1bf:a7c9:9571 with SMTP id h22-20020a17090adb9600b001bfa7c99571mr326788pjv.173.1646766576051;
        Tue, 08 Mar 2022 11:09:36 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id j11-20020a056a00234b00b004f7463022absm215258pfj.208.2022.03.08.11.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:35 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 11/15] arm64: dts: rk3399: Add dfi and dmc nodes
Date:   Tue,  8 Mar 2022 11:08:57 -0800
Message-Id: <20220308110825.v4.11.Ie97993621975c5463d7928a8646f3737c9f2921d@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308190901.3144566-1-briannorris@chromium.org>
References: <20220308190901.3144566-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

These are required to support DDR DVFS on RK3399 platforms.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Change since Daniel's posting: reordered by unit address, per existing
style

---

(no changes since v2)

Changes in v2:
 - rename dmc to memory-controller

Changes in v1:
This is based on a v5 posting from various authors:
https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/
Much of that series was already merged, so I start over with the
numbering.

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 080457a68e3c..9065bb55ee7d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1295,6 +1295,25 @@ pwm3: pwm@ff420030 {
 		status = "disabled";
 	};
 
+	dfi: dfi@ff630000 {
+		reg = <0x00 0xff630000 0x00 0x4000>;
+		compatible = "rockchip,rk3399-dfi";
+		rockchip,pmu = <&pmugrf>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DDR_MON>;
+		clock-names = "pclk_ddr_mon";
+		status = "disabled";
+	};
+
+	dmc: memory-controller {
+		compatible = "rockchip,rk3399-dmc";
+		rockchip,pmu = <&pmugrf>;
+		devfreq-events = <&dfi>;
+		clocks = <&cru SCLK_DDRC>;
+		clock-names = "dmc_clk";
+		status = "disabled";
+	};
+
 	vpu: video-codec@ff650000 {
 		compatible = "rockchip,rk3399-vpu";
 		reg = <0x0 0xff650000 0x0 0x800>;
-- 
2.35.1.616.g0bdcbb4464-goog

