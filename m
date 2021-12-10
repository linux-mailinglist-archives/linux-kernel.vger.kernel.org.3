Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46266470636
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbhLJQvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244048AbhLJQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:51:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB16C0617A2;
        Fri, 10 Dec 2021 08:47:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i5so15945048wrb.2;
        Fri, 10 Dec 2021 08:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Q/4DEmKM3Cq2HhP5WpDWHKu/Cc6C+vR4Ni+Fz1R7UU=;
        b=npa1AKPiSHJukax+fAqKhEL68vJlP4dvtWNXKbJbyhBAB3bFoPKQj+gtBj2BQbB27A
         WWvYhuzhOgqmpKxw4W09yu9rCEo+bwJHUigMNWyVJU/C8L4FZLJtfbEVev1qjvk/OuO8
         3CpkBINicUNX0wYpVxNIqjmbqR93D+vyFZ2O8twSQv4sBLMdDl8HX+tHseEL9mv3RhPM
         a9Jvv3JWy6esF84EyoQzPQYB3KH6FOrxPiqb+3mgASPTxO2jUTdzsUq4DWoDtTTd5/no
         +CgOVHqBgLJPj7qbqdRI4J01FJn61RWWGMwzcPpSmbq3/FLxbU4dGTjzw/iLQKa44sGV
         pRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Q/4DEmKM3Cq2HhP5WpDWHKu/Cc6C+vR4Ni+Fz1R7UU=;
        b=QQzpWfo50W5J44i51bY4PTASmF0O/5frAnh6ZVyPSMsIVP7cu43PdRO3VFp86xdPIO
         EMUIX047zfjbkZ/ksnvc2ee4USRKIDBBNdJqNIltyv0earEnSugMwhX2hYR0Saa1PHxM
         mkqEkGEf8v6ejy+g2HeoxUemcQJ3DnwTw3CFnhlFhYDVy4RP1Twg/fgqkb6v950KC0J4
         JKhfg3oY9SHQpliFxCelzCizkb7elwl9szCOkXdGpNHNEYgPsiIqZykKFLJO8rsUBnE6
         UG1c7J/sgZIDmA2XMRpBUd7rqhVMaWHp8I528dLCTk4UrB2vqvzvWTRQHEPjr0JvsJgx
         L/yw==
X-Gm-Message-State: AOAM532VEzmStaBvw2iJlpIKMeOgbb+kVacWkJXPRfUQWQrxIKj20eNi
        aocJo2j+/+EjecSMol5u4X0=
X-Google-Smtp-Source: ABdhPJyyZccznAQ0oK5NREEh9zB+zLk0rJiSmA+Nd5N+NyZqzAUta4l1yeW4MKStmJaCEUNZ4WQ+NA==
X-Received: by 2002:adf:f001:: with SMTP id j1mr15118538wro.351.1639154874252;
        Fri, 10 Dec 2021 08:47:54 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id y15sm4309083wry.72.2021.12.10.08.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:47:53 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] arm64: tegra: Add EMC general interrupt on Tegra194
Date:   Fri, 10 Dec 2021 17:47:39 +0100
Message-Id: <20211210164741.881161-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210164741.881161-1-thierry.reding@gmail.com>
References: <20211210164741.881161-1-thierry.reding@gmail.com>
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
Changes in v2:
- new patch to add the missing EMC general interrupt on Tegra194

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

