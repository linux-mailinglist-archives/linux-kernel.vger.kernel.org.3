Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9F47319B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbhLMQW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbhLMQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:22:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF77FC061574;
        Mon, 13 Dec 2021 08:22:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j3so28034755wrp.1;
        Mon, 13 Dec 2021 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRq0hfApreiHtzHlp8RLgD5AXAfijxXr2DgGdf8mphw=;
        b=IEfWkEcFL9qcF4Rd4Jg8VqGGs7KeT3aExkB2XIBY6iH86zkh4aehf7kHF3j0kSOknd
         SCb9OtWCFNOAX/SkU5LAGqLUkCgQQJw88RBh/mi8XNQw8h46k0/8xWlrpErxp5Uxztf6
         Q4f1vNuE/glbniOo+ifZlK9yoQA3UkGSTWbRtjqDcxuTI0OLNPSnxPxh612BC0F4MOrE
         J84DCJsyuoC9bM03ps8kJDXQIXyiCNbrPZf0IH6w5fyN5SlgZPSeb9SRgAHx8PcYg53M
         yPzsDDx/pjOx3eqolQHpC4vkP5VVDizGAMVvni3I2YHlqdei36RL+QXg0TR8HpYh068c
         Nvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRq0hfApreiHtzHlp8RLgD5AXAfijxXr2DgGdf8mphw=;
        b=BwM6p94goYMk3plRzp1MGm66eo7BtXN/yggQCkqqbCSt/XA1ZCqlAS8tY1r5og/j9n
         ZCFrsfhg7j//DNidC9m94tEfc2gHrZz1wVj2F4nXgghGVgv0Dh5UM2dAXHwQ+4Jb94Lu
         XNjCPf95Nl9NWdCZcQVreV2FopKA5pLpSdQgPtP9XL/O5BuHEMujilWH+F39SGbtNbWH
         Vi19x+0gf6MfaHCZOJXGXy+eNyf2LFKra1GM/J6uDUb5m3xmlsBNZXkICSA1T2Q/mBj5
         lSLAzok1Fm5M6rXR+r9ssW4HXMmWLhKO89OCCd1aqDBfCZ9QuxzZIIJTNb+W6F9LTQ3G
         oLwA==
X-Gm-Message-State: AOAM5306N26gjd6tr2EbYgMDwK2Siy856nLofKC7PBp/R0pWEe0hQ4TC
        3NkOQXyJuKG/icf2/lnaAGs=
X-Google-Smtp-Source: ABdhPJyBirPkd9VXmykw0aeNavHUSlGLV968uo3FYyG2hvffx6lNnWCpwLKNQGsZebSTT0kTqgxA4A==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr32496379wrs.222.1639412529265;
        Mon, 13 Dec 2021 08:22:09 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id r83sm7736842wma.22.2021.12.13.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:22:08 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] arm64: tegra: Hook up MMC and BPMP to memory controller
Date:   Mon, 13 Dec 2021 17:21:51 +0100
Message-Id: <20211213162151.916523-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213162151.916523-1-thierry.reding@gmail.com>
References: <20211213162151.916523-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use the interconnects property to hook up the MMC and BPMP to the memory
controller. This is needed to set the correct bus-level DMA mask, which
is a prerequisite for adding IOMMU support.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index a75b21c6a521..fafbd9a819a4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -157,6 +157,9 @@ mmc@3460000 {
 			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC4>;
 			resets = <&bpmp TEGRA234_RESET_SDMMC4>;
 			reset-names = "sdhci";
+			interconnects = <&mc TEGRA234_MEMORY_CLIENT_SDMMCRAB &emc>,
+					<&mc TEGRA234_MEMORY_CLIENT_SDMMCWAB &emc>;
+			interconnect-names = "dma-mem", "write";
 			nvidia,pad-autocal-pull-up-offset-hs400 = <0x00>;
 			nvidia,pad-autocal-pull-down-offset-hs400 = <0x00>;
 			nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
@@ -289,6 +292,11 @@ bpmp: bpmp {
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 		#power-domain-cells = <1>;
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_BPMPR &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_BPMPW &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_BPMPDMAR &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_BPMPDMAW &emc>;
+		interconnect-names = "read", "write", "dma-mem", "dma-write";
 
 		bpmp_i2c: i2c {
 			compatible = "nvidia,tegra186-bpmp-i2c";
-- 
2.34.1

