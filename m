Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4E473194
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbhLMQWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbhLMQWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:22:05 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4ABC06173F;
        Mon, 13 Dec 2021 08:22:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso14428143wml.1;
        Mon, 13 Dec 2021 08:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XyyX10/IrEH9wmAZcxOQQHpERWoGafk1oTUP8IQlwu4=;
        b=OjMbXEi5p/+ANMeDDBZ7nIzPZW0EW6/zAx3Rgqc1mIixEz2KbHofTm1iXx6XTM9dV+
         mrF9PWdxLHwph609RtQ9lPhhT8nvnMZKhBnFPRb8yIOWRQHgsJRF3A1YHmgsbfUfkYBM
         RPgYRU8A45d63iVB/sGblkFpEbrBCU/hnDXAP+sJgF9kjUyfHfxve6KZ/8R1Jl3clTOY
         k26BPU/ANJHycMKQvZ4ElIDbxzFiKnH42N39s6ZA5enVgEd9J3nheA9tVdl1R8aJwycs
         ZVnBy5/Zt9de5saA45JNhR9CdsVDuHiy2IBqvp4dTcjRJTKqevDO2ztPea487GQ+UsAU
         BsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XyyX10/IrEH9wmAZcxOQQHpERWoGafk1oTUP8IQlwu4=;
        b=UP8C+2vThIC4u+MkOKJWfDmipzt+kQg9cILdwFBn4eE0yWd7Vw8rugtyvHgIALUpxh
         IU/Q0jsABMsUGCq62XoRhA9Wpbya42YxbZB5Ut5u2QDrEZ2ZP5aiAxQg0wjUXukxEFci
         +mMnj5wf2vabH1uyu7OrLbUQu3ESmLIFYytZFfknp7D962286rxkNxnSl4g3r2G46elg
         54QmkbdTOOPcr3GNQDYxF7Ptf+4r+IzqX12NZ50SPE3CctwbJKTA3xevWLyshBgw20o4
         pAQBuO/Ieljh0lqv+HGnSaIyfJo/gNo1NeLhC8MqJ54GkvBdRHbxUZLjFFYfaY8joM3k
         KSKw==
X-Gm-Message-State: AOAM532c0PO5TYsCyLccPfTSsTtqGnZrAHmHuyvrgLkaS9WVe7x/XXQ/
        cWfAzAmAPWHCJtJp2o5zWko=
X-Google-Smtp-Source: ABdhPJztFVmoWqvdF7P8kH78/nTh4akHNOhGjFdDZTGx658ZjSPCjD9j86mZgDP8aSFTi1fBYxJsbQ==
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr38871061wmi.178.1639412523939;
        Mon, 13 Dec 2021 08:22:03 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id o4sm13736828wry.80.2021.12.13.08.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:22:03 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] arm64: tegra: Add EMC general interrupt on Tegra194
Date:   Mon, 13 Dec 2021 17:21:49 +0100
Message-Id: <20211213162151.916523-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213162151.916523-1-thierry.reding@gmail.com>
References: <20211213162151.916523-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add the missing EMC general interrupt for the external memory controller
on Tegra194.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 8d29b7fdb044..ee668902dd6c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -593,6 +593,7 @@ emc: external-memory-controller@2c60000 {
 				compatible = "nvidia,tegra194-emc";
 				reg = <0x0 0x02c60000 0x0 0x90000>,
 				      <0x0 0x01780000 0x0 0x80000>;
+				interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&bpmp TEGRA194_CLK_EMC>;
 				clock-names = "emc";
 
-- 
2.34.1

