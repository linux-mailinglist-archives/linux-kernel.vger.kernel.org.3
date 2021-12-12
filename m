Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1073471C28
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhLLSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhLLSTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:19:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACE0C061714;
        Sun, 12 Dec 2021 10:19:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c4so23516873wrd.9;
        Sun, 12 Dec 2021 10:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a03oi73IUIbALiHeFayx9Bqv0K+rE4kVayfrAJF+ar0=;
        b=bJ7HV0II5L/l/UY9f/1rz7n0LlKqyMUJ5wBNEO6siMqV7t5IaFC9HBm/W+L3StgXsr
         HhvJzDDANYd81kVuDm7CCE+MBms93xOadoeh4IAw37lUCLxSPSRmV+jABMTwbY5sHmvM
         edthUPi9OIbmgMeVxwxA5OTIwMFsXGKcsKLWw5eJeTraJZ8qCj333QlAFVy5uF5H2dx3
         22tOxGjVeKj18VQLfL8XmOTexrasCJlAZECAVXI5QPvMorOX8dOl/qOxzaMsRbnVVNFV
         r7zY1oZNomUql6Mmw6oiuYEDxntLEW5xMf79ilhLyzoxLNng7qYd/8N4WN6w+B8oLCzs
         rB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a03oi73IUIbALiHeFayx9Bqv0K+rE4kVayfrAJF+ar0=;
        b=czlIdHirx7yp/A+5xeufXBexjUHc+TJPzMemwtOc6FbR6OaJKluJ2RhdF8jTa0ZAz5
         kXtQHdUXxMnp0N80CouWYgnfNLALDmG0R6Ck5RbCin8Ba49bPESnFvRUiJhnbwsHuLUQ
         NZfdjRkElreBwYq3moM9deu4zJyTKkK0KGCQZug8aVwB8HztD0ayRHXQCmbez0FMd6Fy
         v05zqDEUBShocxyMrMOiw1Qgc/f49Hqo1phM+/bZytTIFMvFosrH9NpHiEmBurdNiwSv
         nzptwXN6W0+r4qmiEYCxXuZjDYCsUPfiHLon5VwknYZoBxmCdzk5iEnSCkCUnGaK5Vzz
         kk0Q==
X-Gm-Message-State: AOAM533G6AcX/qrR77cL32ho0J2xJCVPyiRjCAgrJEXF9lm82WFc7Hzx
        qmIRbXXBGWqY7LgE6N75wa4FTLceSoA=
X-Google-Smtp-Source: ABdhPJz2Lwt7Ww4KVXg7hy2a1buXV+yt4ukcRYrX8HH4Yyxc8ODF/E1VVMntO9HVqZV9yT6uswNFoQ==
X-Received: by 2002:adf:f990:: with SMTP id f16mr26550621wrr.128.1639333153865;
        Sun, 12 Dec 2021 10:19:13 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id l22sm4482861wmp.34.2021.12.12.10.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:19:13 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ARM: dts: mstar: Add timers device nodes
Date:   Sun, 12 Dec 2021 19:19:05 +0100
Message-Id: <20211212181906.94062-6-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211212181906.94062-1-romain.perier@gmail.com>
References: <20211212181906.94062-1-romain.perier@gmail.com>
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
2.33.0

