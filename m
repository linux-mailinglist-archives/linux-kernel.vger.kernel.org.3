Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D01649712C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbiAWLRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:17:14 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56050
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236239AbiAWLQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:16:58 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 699583F1D0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642936616;
        bh=grI5UfAEDAIP80sPof/wJdxtniWt65JOOqzZgKpwDAo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=W11O0O+GSFX5uUSgSYpwS4JGBwdPfO0XvGccRotuGS1uVcnnsNZE9ONIZ6DqT/+sy
         8lxHQQRKJDbIJDX5IjLmiOUnsTRFCaA7KV3XnvlptCz5eMwOidheKdDYV38AEkf8OK
         34S8cvEiz3kHob79zfvSoAlPciEAfTiHj3z4/taVPh/0cWdjbiAoaSFn9hrxsWI98a
         Kq6Jl4JOgZV1VDqWzVm4iyYRuiIcrINFpUF4V1NuUfbIZ+28CcaT+GTP6Wu0/Hhh0r
         QIMCd0IFJqtsIQmWvX3plrCcll7Y9WV235Yb9PtCW0AAFuc8lLJl4x3x7T+6Mgj+7v
         fl9+ERPErOVgA==
Received: by mail-wm1-f69.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso8984779wmb.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grI5UfAEDAIP80sPof/wJdxtniWt65JOOqzZgKpwDAo=;
        b=QwrQ0UmXwnsV0hiWsf6rP8gDSGnVDIbV83y6McRp8vp8Y4VaPwxRXzWMrE9Ev5M7+g
         Zk98GJTZagVa8aHrzBHT4OQAi+o+Z3l6T97A28Wl4REBkzHe03hGQTM7D0HXn3fY24FB
         HQ+o03ohXnWT2fKyMfmTKLAD2jvR9vzHiu0jxwcfJCYr7QQw7bMk/UEtCFdCbuV52eMU
         to9XfghF8j4r+ni4EHW6dokr2AdDIeB0KwyVBndm09W6piHlvsXNylf/b4d7yFHajwOe
         Q/y5OVkhxqKy6To5c8GeJVNvbA5+uQrcDd1GiIvfFGI7b0k3MyLut45b4uewNEO5Fjhm
         iWGw==
X-Gm-Message-State: AOAM531ZJLrcHXBVz4wHkWiuDSHj5NXdjsW5WViR3HRlN0/sC+7b+9tG
        K4S9wDbjXDHPgTDdhTBoqNAZkhowqBa5NWZAh0m/r+Q0UmJZMUyIpDVZsX2XoX/yGP0f7JFLOFu
        i2I9iBuLQZaCLcVqGVaRlIeIlAm/IdwfTfBfB/e7x3A==
X-Received: by 2002:a5d:5887:: with SMTP id n7mr3788130wrf.95.1642936613073;
        Sun, 23 Jan 2022 03:16:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxdELQf6sIqrI/0YVD1AI+KkjLutbJQyLtovsY93KZNKsW7PHRBKT0U90IZXspsKI6wQudDQ==
X-Received: by 2002:a5d:5887:: with SMTP id n7mr3788117wrf.95.1642936612924;
        Sun, 23 Jan 2022 03:16:52 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m5sm10143729wms.4.2022.01.23.03.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 03:16:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] ARM: dts: exynos: add USB DWC3 supplies to Chromebook Snow
Date:   Sun, 23 Jan 2022 12:16:36 +0100
Message-Id: <20220123111644.25540-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required voltage regulators for USB DWC3 block on Exynos5250
Chromebook Snow board.  Due to lack of board schematics, use same
regulators as on Arndale board.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 2335c4687349..ccb32d53d598 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -698,6 +698,11 @@ &spi_1 {
 	cs-gpios = <&gpa2 5 GPIO_ACTIVE_HIGH>;
 };
 
+&usbdrd {
+	vdd10-supply = <&ldo15_reg>;
+	vdd33-supply = <&ldo12_reg>;
+};
+
 &usbdrd_dwc3 {
 	dr_mode = "host";
 };
-- 
2.32.0

