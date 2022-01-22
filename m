Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB35496AA8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 08:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiAVHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 02:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiAVHcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:32:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16867C06173B;
        Fri, 21 Jan 2022 23:32:32 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h29so1134574wrb.5;
        Fri, 21 Jan 2022 23:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qkDZRQEWdk0lu7bNuQSV4AkBZ5HIfgnjrIjv3tIsJzY=;
        b=AzVZwg0k2W6CP3Fh8Xm/bAgl911hncaM1uIGZIDornrKOcgHJsotYAIwvmmZ68Tj1m
         uocBG2841Mm541VA8qWEOfyWexZg/MpLw2+DBYtxMUIb69sNn+DdpTKGPNfL9w8PyqSx
         W5tBDu8hgFN2/ySIFn5ncsh19EpWlow6J2xjjYv16qMq6dj9OpIxsBsaEMkGV++9at5U
         MfkunTXl1DZa8TIEQJVsKuJCqMyI3jf9gnpqu8ZHhUR9X+7OnBj+V07BA8btKQNpum9H
         Zv8mKZhv76sq8hw2BqzK2MPcSJAROENmXlNVn7whiOBYhx7J0BGTBZH5Bw6pEldZDxYi
         RGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qkDZRQEWdk0lu7bNuQSV4AkBZ5HIfgnjrIjv3tIsJzY=;
        b=LNIPoNDPaRhA/p82ZFXMXW3l4tCRdIbhw9A4/cbOCRguiN0eQIY7utcGc7B+pyj/A3
         QP6E1CvQ0qeLAqU65IIPJwelO7g3Zb56MqW5bFqZtjp50M3YUGHXGhB++4NiJXo8SUL4
         9sKmy400TO5N74WOHMZgQIz1VO/H0yjWFoa3ez2vOzGOujdAw1LFsPKmbPwEvAOT2hKU
         rw5w8TcURcbJGcKEDPaSmB7jntIZpiDppY4E4SuciOUqzWeY/l5apjJ0dq8xk9sTdpOr
         uf6fdDvET9fsfdxLjjjfxTKKk0rRUAevxZAed03pra5xJVO/2vbsMx3h3sunNwt5q7BT
         im+g==
X-Gm-Message-State: AOAM5310g7m2S6dAiQTxANTrWy28geJzuWfW92D3XrqsyW5DpKXlUlVL
        mgbTYu8My86TqNgUS+axLPnaoyBnWeyefVw9
X-Google-Smtp-Source: ABdhPJzE6hu9cKNLdsUd3UjqpvEmHhwfp8Pn9fuydve0X9sJ/0BrRmpM9JHCzgaX2iCUlWGFFlf97g==
X-Received: by 2002:a5d:624f:: with SMTP id m15mr6336244wrv.13.1642836750180;
        Fri, 21 Jan 2022 23:32:30 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i8sm8970485wmq.23.2022.01.21.23.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 23:32:29 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Furkan Kardame <furkan@fkardame.com>
Subject: [PATCH 2/3] arm64: dts: meson: add BL32 reserved-memory region to GT-King Pro
Date:   Sat, 22 Jan 2022 07:32:20 +0000
Message-Id: <20220122073221.2398-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220122073221.2398-1-christianshewitt@gmail.com>
References: <20220122073221.2398-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an additional reserved memory region for the BL32 trusted firmware
shipping in Beelink g12b devices. This fixes a long running issue with
boxes booting from Vendor u-boot where the board wedges during boot or
soon after due to the (un)reserved region being overwritten.

Fixes commit 0b928e4e412b ("arm64: dts: meson-g12b-gtking-pro: add initial device-tree")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
index 707daf92787b..7782fc9fc12b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
@@ -19,6 +19,14 @@
 		rtc1 = &vrtc;
 	};
 
+	reserved-memory {
+		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
+		secmon_reserved_bl32: secmon@5300000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+	};
+
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		#address-cells = <1>;
-- 
2.17.1

