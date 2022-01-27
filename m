Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B005F49EE9A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344031AbiA0XJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344504AbiA0XIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:08:47 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE5C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:46 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q75so3658268pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXezxkg2kGuWbB36YJn2JEHiHCC80Um0xlTyospu4bE=;
        b=W52+ysBtqCsUepS7IJiVv6MqZt+QdNIY980EbuHquIW6109/e0+n0y9mwaOPmdVytS
         uRAk7qC1DiU/CwNi49mc4RvLPdUna1Oqj5Qgt0jPuWkra+DTqe1xx5fnNx2rjw/SO5hh
         qVqkuZdKSeug7aH608jY9tfD7Q/F1d9LkblPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXezxkg2kGuWbB36YJn2JEHiHCC80Um0xlTyospu4bE=;
        b=b9eIoOdGPN6yQMhGwKWWqgc2H/SPq1D0IQvIsppQHlOX8ASsOGv8az58a5M46q9Jrp
         C3FtfIOhkfLrucb6AIQWXHMznfQNQVTYR8HTuriO6Cxqi6PFsyPXis791XXnFMFjmbO/
         QHeXBiPScGqE/wkrHK1HFMu/jNqpb+bL4U5tQ4yD1cJZ/gmVb03/q/NKpD39Bgsw9GWK
         xmyFSeuFXWHr0Z06m1WElHmouZxitzZHvq++/YOTe2unNr3uhxFR7gC1Dh/JGg0GDyHG
         o8gkAxkucSS4k5RqJnlr8iqgBpAOY8m99yJfw5BckH8hoYH8qNFD9VQVEu6jKfDXfJW/
         Ljgg==
X-Gm-Message-State: AOAM5325066xGQCfvvCvdMPY4cWr3Hrw8sxStxGBGkCdLrsdVrU8BaP1
        mnuT55oFq1JGn5ZDIGombQHYyA==
X-Google-Smtp-Source: ABdhPJzIjPFzmvY95upLY8umBbY8uqvVIvgVAGp2b3szXo3MoWikHuPQAGZ4kG2PB8Y9F89T9NfEvQ==
X-Received: by 2002:a62:1cc9:: with SMTP id c192mr4895534pfc.70.1643324925797;
        Thu, 27 Jan 2022 15:08:45 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id n22sm6497884pfu.77.2022.01.27.15.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:45 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 11/15] arm64: dts: rk3399: Add dfi and dmc nodes
Date:   Thu, 27 Jan 2022 15:07:22 -0800
Message-Id: <20220127150615.v2.11.Ie97993621975c5463d7928a8646f3737c9f2921d@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127230727.3369358-1-briannorris@chromium.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
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
Change since Daniel's posting: reordered by unit address, per existing
style

---

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
index d3cdf6f42a30..4096ef6f7b72 100644
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
2.35.0.rc0.227.g00780c9af4-goog

