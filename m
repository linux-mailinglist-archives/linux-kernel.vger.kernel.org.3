Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D71497132
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiAWLRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:17:18 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56050
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236259AbiAWLQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:16:59 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7E0DB3F1E6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642936616;
        bh=7G+hY+R5nLZKUZJkJX/xGI67gHlSdcGiauOov4lnBec=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=s1U6Wx2afIY/Y9aT1wf3RwKGf/L70ZlnUamIGedY1YbnU/i8CD2OO2i5uvlLYsYuJ
         2Ro605UXkycHyLoypgPKzaupJEv5z6brz7TJfIy4NbJ41BLVZ/rCw+SsTPJS7bg6FG
         lEYmpk0h9KRZXhIOc8IT3i4rb7cP24gT9F+kz6vkMrTfC5qDjyQ0Cxgmiy8MtkoG5g
         LAVF1AqOZrb7qkYitkyghewJoWXlb3lcrulw3//plKXGVk7dTpaUqo9Mds5K4ugf20
         00km4ZEHKVFVRLoqci/SzuU366cgdr26MDOPA8RcgfG/z2vIcWHd+gfTVdOIcdXqen
         9WO25hzVLJYng==
Received: by mail-wm1-f70.google.com with SMTP id b4-20020a7bc244000000b0034f4c46217cso1510450wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7G+hY+R5nLZKUZJkJX/xGI67gHlSdcGiauOov4lnBec=;
        b=pLtmlFic3SGBt7O3+pHYlL6ffvzD4k/3S6UZbGCpVTk4DEBZtqmh/g2IQTppGiLQXX
         Y9uxqAil01IBfatQVAyiR70qrwfJtiTQyOMLTmW8/J9qou50fgwloX4fnOBDfYSKI/Eq
         rD8vnI/TCxhLvbPvU4w/9aesodA1a0WoEmm39YTZ3f+BESAArGHH7/4O4KBcWUrwBlp7
         7uGPyq2IeHX+4gbXiitFMCVbyrcgRqWWAIjq8BTe1BRRM/xUv9DPUkkscwQUaEjhafX/
         4sclLTM48b6VSxgFqXoiciuhfFBLDSezgLho407Re2lSXjg4wxSyKaHBq346oR23o/Yp
         R+FQ==
X-Gm-Message-State: AOAM5336+hsnX6e3BMiBs17fHSHYkm8sewI8iFaMkkltnoK+5/cFIzam
        QoUyW80bLjslslORWsZkk6aiuTaof0IM9IeER9RrUznlym+ArgfeXWC70i1TLYfDEKI3lIF4+t8
        DK3HYLW5VL/de8zVJGKVhQwt5GauAjxZiRzoZ0w0sLA==
X-Received: by 2002:a05:600c:3b8e:: with SMTP id n14mr7635819wms.136.1642936615423;
        Sun, 23 Jan 2022 03:16:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmZiv76Qfw8F68YMkxoE3Zz0Ow5IhFbzrvbpiFnZTw5RuvqW1IyxGcoXhMn0pmZj+he53E6g==
X-Received: by 2002:a05:600c:3b8e:: with SMTP id n14mr7635808wms.136.1642936615301;
        Sun, 23 Jan 2022 03:16:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m5sm10143729wms.4.2022.01.23.03.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 03:16:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] ARM: dts: exynos: add USB DWC3 supplies to ArndaleOcta
Date:   Sun, 23 Jan 2022 12:16:38 +0100
Message-Id: <20220123111644.25540-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required voltage regulators for USB DWC3 block on Exynos5420
ArndaleOcta board.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index dfc7f14f5772..ffdf0e247c15 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -825,3 +825,13 @@ &rtc {
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 };
+
+&usbdrd3_0 {
+	vdd10-supply = <&ldo11_reg>;
+	vdd33-supply = <&ldo9_reg>;
+};
+
+&usbdrd3_1 {
+	vdd10-supply = <&ldo11_reg>;
+	vdd33-supply = <&ldo9_reg>;
+};
-- 
2.32.0

