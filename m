Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9A9487FBC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiAGXxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiAGXxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:53:49 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7D4C061401
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:53:49 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t187so6486347pfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bLiXD9EPxhuhl4swC8hQ6wdNP1ClmDuHZfS+mTSLPMY=;
        b=BYk2607hHPmSvHDebgSv5EvoUO2Eu+i/iAiOXw2Ta1ucl/Xw1m3CkSEWSoxLGk+krW
         8TtKDL2dq86sfn3/TjOaQjddauSgNqwTr6imn4sJv7/DFenryx+A4mrAadJMQkIItgqo
         NeS17kOoVGXrYbz/o9aQI9i05ftBJHeTTORPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bLiXD9EPxhuhl4swC8hQ6wdNP1ClmDuHZfS+mTSLPMY=;
        b=dpUjTgmN2N6pbvFWunLMsflxb385eoCij0Fz1bJQ6twKwFoH5Ix9Fq+lh28KWNf5rG
         WZ2it+oiSkfbYGSWmBOXzZI8BTkeYK7qeNXK2kS6W6si3/TARImSK+j/NtUpQDuHFJLL
         Ke/yEVf7mJYAYC3wJwXenydFwC2K4XWYmmwTOQ9Q3AtmAYfyLqV46uUJSrUshR3MzC8H
         26csC33bW4eUC2EjPn4u5k5Qh+V/Jb3bEL5231+L2IehOmBplqxr13lgwg7ymEK+ACKC
         N+fWMMiIDCIHchETOsOvBoAyqFC23QSDKbMezRg5cIpZCvViAzb0jQP2HeNRUkobQlMr
         LrtQ==
X-Gm-Message-State: AOAM530GviksdFi+kw90KCWcOt3M1TjnyereJL4U2nY3SkMms16M8Dfe
        EhXJHNMlhNoD3g1UkDBcr7ihnw==
X-Google-Smtp-Source: ABdhPJxec9Iz4K7SGQBxWwH4Aa43xT+erYjwZOOHGJsTnXVxoFwz2OkPS74l+sChFO3DcJQ2WklFNQ==
X-Received: by 2002:a05:6a00:26c5:b0:4bd:4ad6:9c71 with SMTP id p5-20020a056a0026c500b004bd4ad69c71mr482801pfw.45.1641599628943;
        Fri, 07 Jan 2022 15:53:48 -0800 (PST)
Received: from localhost ([2620:15c:202:201:db:1c60:693f:c24e])
        by smtp.gmail.com with UTF8SMTPSA id y29sm56068pfa.54.2022.01.07.15.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 15:53:48 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 09/10] arm64: dts: rk3399: Add dfi and dmc nodes
Date:   Fri,  7 Jan 2022 15:53:19 -0800
Message-Id: <20220107155215.9.Ie97993621975c5463d7928a8646f3737c9f2921d@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107235320.965497-1-briannorris@chromium.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
---
This is based on a v5 posting from various authors:
https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/
Much of that series was already merged, so I start over with the
numbering.

Change since Daniel's posting: reordered by unit address, per existing
style

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index d3cdf6f42a30..86e2d87e008a 100644
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
+	dmc: dmc {
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
2.34.1.575.g55b058a8bb-goog

