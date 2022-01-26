Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF349D144
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbiAZR40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244004AbiAZR4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:56:20 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7436C06173B;
        Wed, 26 Jan 2022 09:56:19 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v13so369018wrv.10;
        Wed, 26 Jan 2022 09:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I0fcplD3VFrkCpKgQiNkIlnOuTzfq8ZQ6areILp5ZR4=;
        b=U9Z/ql/ZK5IhK6P6O4TP//zSS7SALYSv28NVpH43H2c8VeWbavUv6Yczw/oDx7jch8
         m+jzH6RY74MMRnWB39XeOeKKP//Ta7fXipFxNH3dToe5KpJCsb21jTrhJINlgdTVV3Yo
         NXVcNR4GjqEGNoj5p5SlHth02vxqMYXVAwYDevkNIvKQWg9sXt+LsmTimoJhGuKicBcU
         7kVJz8+8Te1RWjqJw6mURwfIWOFNTCCj0xR6uakv8JvW/7LH6f1IEKprfI92TlkBB0mE
         uMhItvJJ6vrTIOkDSJwgqzjf4i6AgbjcIyKNRgdqRFo46N/M8qb0CDS+KI75xB4KmriQ
         YMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I0fcplD3VFrkCpKgQiNkIlnOuTzfq8ZQ6areILp5ZR4=;
        b=y39Rt98bbPFdxeVgRs3BOJio+K2wKsQRpBrrdK6K6OX16CQpLyQlmRMfh6EY5XKP0k
         3vJ5doJJSv5JXYmcusxNjLNiZVKEfrmhCFAsSicRx35DcJYN/kTCAvxFXGcd4Pn/WupL
         vrwjjEqshk+z87dQJ1qFkNyvFTrmX9gS1qQs54t6s0Sd4vn+97auxrn3l7jkpFO7eLwn
         VIl7Bg3pg7GyUUiMhmnjzwpmedZQWE3J6+/lJ+dQEVDBQBBeGU+LSV68VLuv50mSkv5M
         pnq0MdRX98g0q4UBy+YJS3SKtJ8O5vwR0fP8neWpzQfqiujHRYa3V7fJ/+MXgFmLqjvz
         JJoA==
X-Gm-Message-State: AOAM533F6pG5ZF38LUPg6cNRb27iOwRayRGlS/QOiG1QoLFXFtugcQxV
        6X/Yw3VfDQ4x0SunwTg7bTpb9aJ+vRUyjg==
X-Google-Smtp-Source: ABdhPJzllu4IdjHXcUMczo++gtjf4jceZyVT6HHXrsq0SLK7NBDrKCoKTv4YEOEn8X7kGWdEbXOzyA==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr23407788wrv.215.1643219777966;
        Wed, 26 Jan 2022 09:56:17 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id o12sm4632848wmq.41.2022.01.26.09.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:56:17 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] ARM: mstar: Link cpupll to second core
Date:   Wed, 26 Jan 2022 18:56:01 +0100
Message-Id: <20220126175604.17919-6-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126175604.17919-1-romain.perier@gmail.com>
References: <20220126175604.17919-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

The second core also sources it's clock from the CPU PLL.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-infinity2m.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/mstar-infinity2m.dtsi
index 6d4d1d224e96..dc339cd29778 100644
--- a/arch/arm/boot/dts/mstar-infinity2m.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m.dtsi
@@ -11,6 +11,8 @@ cpu1: cpu@1 {
 		device_type = "cpu";
 		compatible = "arm,cortex-a7";
 		reg = <0x1>;
+		clocks = <&cpupll>;
+		clock-names = "cpuclk";
 	};
 };
 
-- 
2.34.1

