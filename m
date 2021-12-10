Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80064470639
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbhLJQvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbhLJQvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:51:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752B1C061B38;
        Fri, 10 Dec 2021 08:48:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso7074489wmr.5;
        Fri, 10 Dec 2021 08:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRq0hfApreiHtzHlp8RLgD5AXAfijxXr2DgGdf8mphw=;
        b=A7YASKCtSZmjH5AHUo9Lguft22JcHtL05v4NWtrGm1sEX4ENI3TZNVhNtleiEOgLv7
         OcsiWZLrj4OjjHL9x3vlcE9XfB+Dk9sIei3lC8LcgiI/bpYbY64UBM0PtnKWDUz3NCh6
         0sEcywbHnDARQT+OXSwZPoW79g/m6/30FzaveZbgierDJWHVYdpkWSpAFOQzKfJvjKqY
         khjptbK4qOHhLQ8ihQfGGegKDxwHWMb4xbWtzLbjWm1OoNCEbfrYQdbpRXpw3+nZix0F
         ghoBlsatowWFoJfN4bMTRfJhgsjn/u11299dgxSGRzdYMvSf1Wua2s7LCLEYBOO22REo
         1rWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRq0hfApreiHtzHlp8RLgD5AXAfijxXr2DgGdf8mphw=;
        b=53d8u2lsHvGg8CV0UytdAWFoeXXgPIYBjZCVVDyjv7vJ60F5VPwTpEEC+n35eE/BBQ
         vQfE3Cq93U8yyrvYHc/k+UK8sFn6L0wpMBRXZsGTVChHxy/MRWnUiWKpmblGbjVzZrRm
         Cm/zTMRABjWfMqKNSDwICW0AXIOJ9GedE1fBty7F55VNTmv7Q8StqdqyeFfREYjOZwq5
         A+88lwnAFqV92xjsw3jwi8w3uA1R4BE32WQv6u1agFNQKrFg2IKMTect9WOlSY+TWcYi
         4tvc6zpyw2hQMtnE2orUapf6eJzK8+i1MquJh74OVjRrqrcXwpGonK4K6sGBrtsxGo+N
         bQ5g==
X-Gm-Message-State: AOAM531Gdc74B/UNU3jw8HFQBt1z5PIF+O1Lh/Edi/F/cf6D8IgIZcZO
        rKYkdTGr939gAihMF+UzBlc=
X-Google-Smtp-Source: ABdhPJySgQ8B+evQLwgajoXSdSDmIbVYgiz32CGDuiiffF8C/H8TuQ4BuH59Vat1aCW7PaZFdPGKkA==
X-Received: by 2002:a7b:c310:: with SMTP id k16mr17906114wmj.169.1639154880025;
        Fri, 10 Dec 2021 08:48:00 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id f3sm2984522wrm.96.2021.12.10.08.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:47:59 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: tegra: Hook up MMC and BPMP to memory controller
Date:   Fri, 10 Dec 2021 17:47:41 +0100
Message-Id: <20211210164741.881161-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210164741.881161-1-thierry.reding@gmail.com>
References: <20211210164741.881161-1-thierry.reding@gmail.com>
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

