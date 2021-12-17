Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B52479534
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbhLQT5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbhLQT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:57:46 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB80C061401;
        Fri, 17 Dec 2021 11:57:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so4783784wmj.5;
        Fri, 17 Dec 2021 11:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eU0XGPi4uBhPUtyGCEgXF/C3mA2MpO37zRIQErCawvo=;
        b=f9VKS4gPYA3Bst20TJUlMjQI5/yet1jmgxsDXqhLiDT1wAXa5vbUy+yT9pHpv+D9T7
         RSbOMRYPqqV0KXJOstjbEa8DSH1ZHijqX+EUve2ebiEtiAUMtlr/kVvqVl/IyaUBDA4J
         JrTi715WFR7b5VHZTIexXlBh9aus6csf4oSHs9GV76cWI41D9wjIV3pIhsp1a+fAHFHb
         VFdj4Yjmf3JL+aT85WzUrqfA6wObE4SUBTJlibrbUo/mNn9qIAecOiuI+SVXnb2QK3sq
         iSHrjqSJ9jr6yOxrzJ3NfkW8QUJMqm57W9Wu34GO1hbTbAfTR0DIbEifUhR5i/Vp4yQB
         l2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eU0XGPi4uBhPUtyGCEgXF/C3mA2MpO37zRIQErCawvo=;
        b=sLT94xt99HRUAVcldmQmyknVWGZEOM6kTEqHO2KuXnyv3at3Dx0mEK1xtIGDKzIB0F
         JSb7kQaIbqXnDLSojvRFZpMN1P0bxqiMFBV7WCJpn6t2TIurh7FkToNACpiguw4XFq/j
         aaRW8sav98ztshChV7pLFicm0FGtCjwxNtoeSVsrxdC1qfvCEKW2iFM2Ns8NkEpbXGZb
         SfXNn7lAqE37pb4+X8MEqRCwKwdKUzR6fCI88lEEEdF7OOMjO5bc4Q+2JTsU60C06YF8
         xhZWHR8yRiORWtphCJGtaNSfQxuk2FS40uzVyp2+m3hJKVPkfjPnNE0Zfsur9I9z5QJR
         3/zg==
X-Gm-Message-State: AOAM531Kwdg5u1h7GwgkcLUgXXVPCH6BEZCBX7la0xcrCbYyRcolJEkl
        qoTLnxUU0DL9xCB+YaLRvApSpYJxn7ioZg==
X-Google-Smtp-Source: ABdhPJxzAMjIxX2CXI+2wbGHfE/1VAILVFrQsoQogotGZM/HaypI7k2Q17zUtBJT70jYx40zjbJY/A==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr10925271wma.95.1639771064308;
        Fri, 17 Dec 2021 11:57:44 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id i17sm9340951wmq.48.2021.12.17.11.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 11:57:43 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] ARM: dts: mstar: Add timers device nodes
Date:   Fri, 17 Dec 2021 20:57:26 +0100
Message-Id: <20211217195727.8955-6-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217195727.8955-1-romain.perier@gmail.com>
References: <20211217195727.8955-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the definition of the timers device node.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 89ebfe4f29da..7ede4cec0af9 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -123,6 +123,26 @@ watchdog@6000 {
 				clocks = <&xtal_div2>;
 			};
 
+			timer@6040 {
+				compatible = "mstar,msc313e-timer";
+				reg = <0x6040 0x40>;
+				clocks = <&xtal_div2>;
+				interrupts-extended = <&intc_fiq GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			timer1: timer@6080 {
+				compatible = "mstar,msc313e-timer";
+				reg = <0x6080 0x40>;
+				clocks = <&xtal_div2>;
+				interrupts-extended = <&intc_fiq GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			timer2: timer@60c0 {
+				compatible = "mstar,msc313e-timer";
+				reg = <0x60c0 0x40>;
+				clocks = <&xtal_div2>;
+				interrupts-extended = <&intc_fiq GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			};
 
 			intc_fiq: interrupt-controller@201310 {
 				compatible = "mstar,mst-intc";
-- 
2.34.1

