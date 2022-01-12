Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929E148CD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiALVRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiALVRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:17:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8452EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 13:17:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id i8-20020a17090a138800b001b3936fb375so14885337pja.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 13:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boundarydevices.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P0OpirpLo3lFPzhXuxtbh2WjLoHGGYMgIKLuMYWDySQ=;
        b=Nex77jCtujyu/JYrJVhh4VSI3QRugHS/8QUW03cirP3xG0d+h0WH5uL/kfJz8OD25w
         X9vKtrk0BED2tqKug1kk50kdAJBQroPulaajtEo6EBVDocXTMnaO1gpsgGo4BP1HaLza
         OPbQfVL+WH8aIdzOa//C5wHZHjs4CSjMHwNP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P0OpirpLo3lFPzhXuxtbh2WjLoHGGYMgIKLuMYWDySQ=;
        b=nzg0P1p0/m95IPvVOINzo860EMKqBB6op9GvmO3tMXCdfpmX9vjwpMxHXf8UKYb80t
         DsWTsjpZbkS81mPswp2pO1Ny3cFeoA1BnmIxD5G/7FtoJ24gEz7g9uYebg64rWhao1+r
         CvPA8mKaizR0Jbo8n1GdpcKEBOTNT+COQSh85CT1kcr4FJpqdfTYz/LV2NwRPfS1bwq6
         ni3XePL/NAc1MfaukTLVMSCP428GFhbKmEe4X30W9xkbYSJifoOK6zQ53n/F85E5dLVC
         OWEROIzFwNMlr7FGuoLiFTuQrB5IhCDLzC2RQ7jQ5v/uEJTgKC1/YcDJcGfxm0boPzDr
         fbTw==
X-Gm-Message-State: AOAM530P8hC7/Of8lFYjjQErmHSGh0nL0d8Nm4RK71yi8CdkefNYPVBv
        ezKVCpvNlRxtDJRy1McHMLcZhw==
X-Google-Smtp-Source: ABdhPJwbJwaH/Q4KmjeX+oL9vPN/RCYvtu1ji5uNMCH/GhuM3e2/kYW/rA9QUcuITjN8PNtNNsSrUw==
X-Received: by 2002:a63:a745:: with SMTP id w5mr1310352pgo.374.1642022221052;
        Wed, 12 Jan 2022 13:17:01 -0800 (PST)
Received: from localhost.localdomain (2a01cb000f5a8200e371e4a5048c8b22.ipv6.abo.wanadoo.fr. [2a01:cb00:f5a:8200:e371:e4a5:48c:8b22])
        by smtp.gmail.com with ESMTPSA id h15sm507192pfc.89.2022.01.12.13.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 13:17:00 -0800 (PST)
From:   Gary Bisson <gary.bisson@boundarydevices.com>
To:     linux-amlogic@lists.infradead.org
Cc:     Gary Bisson <gary.bisson@boundarydevices.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: meson-g12-common: add uart_ao_b pins muxing
Date:   Wed, 12 Jan 2022 22:16:42 +0100
Message-Id: <20220112211642.2248901-4-gary.bisson@boundarydevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112211642.2248901-1-gary.bisson@boundarydevices.com>
References: <20220103154616.308376-1-gary.bisson@boundarydevices.com>
 <20220112211642.2248901-1-gary.bisson@boundarydevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- RX/TX signals can be mapped on 2 different pairs of pins so supporting
  both options
- RTS/CTS signals however only have 1 option available

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
Changes v1->v2:
- renamed nodes as suggested by Neil

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index af1357c48bee..62350c408e16 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1952,6 +1952,33 @@ mux {
 						};
 					};
 
+					uart_ao_b_2_3_pins: uart-ao-b-2-3 {
+						mux {
+							groups = "uart_ao_b_tx_2",
+								 "uart_ao_b_rx_3";
+							function = "uart_ao_b";
+							bias-disable;
+						};
+					};
+
+					uart_ao_b_8_9_pins: uart-ao-b-8-9 {
+						mux {
+							groups = "uart_ao_b_tx_8",
+								 "uart_ao_b_rx_9";
+							function = "uart_ao_b";
+							bias-disable;
+						};
+					};
+
+					uart_ao_b_cts_rts_pins: uart-ao-b-cts-rts {
+						mux {
+							groups = "uart_ao_b_cts",
+								 "uart_ao_b_rts";
+							function = "uart_ao_b";
+							bias-disable;
+						};
+					};
+
 					pwm_a_e_pins: pwm-a-e {
 						mux {
 							groups = "pwm_a_e";
-- 
2.34.1

