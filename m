Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F5F497129
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiAWLRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:17:12 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56036
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236245AbiAWLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:16:57 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 67CCF3F1C9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642936616;
        bh=mZrAftbEtCYMgTENBFFGXCuFnaLbp5VnVYmLha/DMRk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=q7Wf+b82yeRbxpLxTEj7U9g6qKmjrY6Q/kSdOKdTtkmZtij4HztQ33mX+ltyPMCSV
         MCu9ce/9f1GvgzHaFeHvdWZbcYSY9W5zbIpoCe1UDMYgtBrr2dlLHPPteExpvPfRTD
         ugy/QFSTrth2lSDsjvI8N+ZlFd0mHOuxDkBNnnX6DSFjHlpf83JEpl6ZojkyIGZ3vx
         lBhvBzmMaUI5YA+M9QII6eLi3CuJ8E7TtGJ4Hx5elTUD+pe7Zn4VONCZ3vAEhu6Tfn
         o2QwAu1Wta1Vr9x92WC8d64nlLK7TMeLTDD8Ho4pBJRJgfv1T5hyYEg5jXhqTNnZt6
         f0hB9vuESDD2A==
Received: by mail-wm1-f71.google.com with SMTP id j18-20020a05600c1c1200b0034aeea95dacso12913778wms.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZrAftbEtCYMgTENBFFGXCuFnaLbp5VnVYmLha/DMRk=;
        b=3Sb3dpcHVEcPTFm3YMuyMVIrsdJeWCt8SsTLjERScsG7F9f6XWnZeoWgUpPQa+JuF/
         k53fHNG+rCaV8BS8bZXE1cnrIFAS14AJmgHhteKAZsmhMFdlSCqGL68H1TR0CSYDbFdB
         +3zlbYXgQ2P04iyYjCXvdxEpqPEcVGfS8mkuekLiNC3IaUqglyh7ji4uHrxBTOgcxfCy
         1vE02aJaotJxGIb8J7d8JWTxvXnY+nqZauTNiY463IUaNynL+7okZ0DhAi6teS4BeZUk
         QMWSHhD3w+ItmAiGXNdJ+MRlN24trPDeXv4vN6h1QlqrOjyH9bTF7Y/eZdAKB7MpJE61
         loBQ==
X-Gm-Message-State: AOAM530CfF38LSxPfHAct0S2kdqdf7UczYtKfotD7r3X4BxskJImeoto
        17UsLE91oXLqvgvl5/vTdHtXgoeVJCOIh7wXM3DgbrNgUECFrEqAcJYndgN23cTZ9WitsqYYaXJ
        02P8rpndaVC1BxKBGJwXZmc7DH/NwrlhwqWtmdH42AA==
X-Received: by 2002:a5d:64a5:: with SMTP id m5mr2349930wrp.596.1642936614116;
        Sun, 23 Jan 2022 03:16:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbgZpejnF9FsaGyv4Km9SlVIA0mLrJyWVOdw4PpZPzd2pNEg41zEEfiODSBE5ZfvFaMZwUFg==
X-Received: by 2002:a5d:64a5:: with SMTP id m5mr2349911wrp.596.1642936613937;
        Sun, 23 Jan 2022 03:16:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m5sm10143729wms.4.2022.01.23.03.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 03:16:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] ARM: dts: exynos: add USB DWC3 supplies to Chromebook Spring
Date:   Sun, 23 Jan 2022 12:16:37 +0100
Message-Id: <20220123111644.25540-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required voltage regulators for USB DWC3 block on Exynos5250
Chromebook Spring board.  Due to lack of board schematics, use same
regulators as on Arndale board.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5250-spring.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index e0feedcf54bb..138f51f974c7 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -553,4 +553,9 @@ &spi_1 {
 	num-cs = <1>;
 };
 
+&usbdrd {
+	vdd10-supply = <&ldo15_reg>;
+	vdd33-supply = <&ldo12_reg>;
+};
+
 #include "cros-ec-keyboard.dtsi"
-- 
2.32.0

