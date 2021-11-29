Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91204622E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhK2VHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhK2VFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:05:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1C3C0048EA;
        Mon, 29 Nov 2021 10:26:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o13so38711886wrs.12;
        Mon, 29 Nov 2021 10:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2CK7ksNUp8Pg2echFt8tqjUwXozzVDtckwrvamj3fR4=;
        b=pEsFxY9XJrFlt6w2FqEL8BefM39rmQUeYseKPXfyn+veqbL/hRrUetlSFEWrt4TdLj
         DX4ExO5P48trqilumGsGHydlasQa/b7e5WG/go7ES5HhH5tCptdJV33z4hjXq1I1jOK3
         iHaLRuU9pMnJkf6EcuXNyVnwfkLZ0D/+GL7mpAazNG+hGkzB75arjFF1VvAcSRKoTk/+
         Kn89bNMTOoi/rjcGdr8KTPpfK9Qco6+bskGhIzw1gcGe/m3sg2JBEcLfsb3WmXDFawNW
         7XGJcr/4MuYPFN3uFCZK5lGieiQpH7Rf04o+dmd9RqixpCbvpKzd22Cex7zlMaBqgcEy
         mJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2CK7ksNUp8Pg2echFt8tqjUwXozzVDtckwrvamj3fR4=;
        b=b+t95I7EJceBECVQkuDtJ9DuMtbZcdQ+dS2c9Cu/nmxm2F9iFXzIShONH8OKzA28HO
         0apSThKkWMxmOmYPWEPPU/3cdBIcAd9k0HfTyHLKEHp+2rRv/Wt4w1b0tP/EScYq/Pd0
         hcoE+sCKT2Ftn7m6bvZkT/hWLvkeED8tEjbKvmvGjPA+XF7rSf7F5Lcetm8uuXAq9FN0
         GnCn64DMU1h0Nn0u5AUwwukPgWwn3YX9YPRM75fFitJ7lCJqyKTyrOdeIa8pKJOVAeNP
         dkfoVFE6Osr2HKYqlGWWmvkgC4iPE20CrBB5lzrh/tkP6jWGbbq0KIswoV28OYKOx4+3
         O0/g==
X-Gm-Message-State: AOAM532lohIR0bhvENXoMlqmSblZrOhqq2f4b9nCKxeHWHIRSadApJgK
        Xkc6byDk6FaJfDEBUT24r+xR8Ua4z+AL1w==
X-Google-Smtp-Source: ABdhPJzN44NyUbZ6t3f0zWKxJtGZkXmmaeAOLVx4Xb2YyJrvOhxilgJVC5Um8UxWuCf4ryumst6epw==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr35204542wrw.151.1638210410731;
        Mon, 29 Nov 2021 10:26:50 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o12sm85907wmq.12.2021.11.29.10.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:26:50 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 9/9] arm64: dts: allwinner: h6: Add Hantro G2 node
Date:   Mon, 29 Nov 2021 19:26:33 +0100
Message-Id: <20211129182633.480021-10-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129182633.480021-1-jernej.skrabec@gmail.com>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 SoC has a second VPU, dedicated to VP9 decoding. It's a slightly
older design, though.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 4c4547f7d0c7..878061e75098 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -153,6 +153,15 @@ mixer0_out_tcon_top_mixer0: endpoint {
 			};
 		};
 
+		video-codec-g2@1c00000 {
+			compatible = "allwinner,sun50i-h6-vpu-g2";
+			reg = <0x01c00000 0x1000>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_VP9>, <&ccu CLK_VP9>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_VP9>;
+		};
+
 		video-codec@1c0e000 {
 			compatible = "allwinner,sun50i-h6-video-engine";
 			reg = <0x01c0e000 0x2000>;
-- 
2.34.1

