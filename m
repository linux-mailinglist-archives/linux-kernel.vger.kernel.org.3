Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7982497143
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbiAWLSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:18:44 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38482
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236263AbiAWLRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:17:00 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 38E5740053
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642936618;
        bh=y357G77gKMHlTfzCL6+HEz+/UzqdnZT/McDbXpsW3BM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=rSHD0VOlmhsaMq/K4AVovsqSK3tJW40BJ7e3em2MmMQfyCJy6tCSjxn+5Fh0P1765
         zjKNfG6RQiHmVgRaCuqj2eY3zslvRdkxTtZwh0t/+rmhFJwr9Idhd8Wnfyo0BKZSfc
         N7073LygIh5I3RWWBBWiGe7/U03WIxSpOgVN8Lbs9/AZoTFXPFg11x0T7+05/EOVlq
         nMQWGu3m0jveEb7tIL77uzN3KAyavMpQAaHuQsF8QhokW/pD/rcjMwNoI4VyXSZuwW
         MYNWrSH8rMxZAixhIGVp/+BRb+8UNcgfoOioM4hCJpV/kEyeoyqwLqdyppT61M7xRC
         qCexaxEbjWD2A==
Received: by mail-wm1-f72.google.com with SMTP id d140-20020a1c1d92000000b0034edefd55caso2639554wmd.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y357G77gKMHlTfzCL6+HEz+/UzqdnZT/McDbXpsW3BM=;
        b=NV5aIi1yzhrQdbmYqvTYvB02b3RAy5OhGv5RxK1a0hPCGJNJCuguhTFtIpUXR5nl+6
         m7mHFAzivMQEvtdP+AcUkVgqdx09B2ty2c9JzFXcTCIFQ7DPBe4KfkGruMJYcGtuJYt8
         SNuSTK1D3nNNud7qA/tj2aCA9fXZb0PgICbT7JE3kY5ID6WZr96ojrQJp7q/HEgMP8WG
         WhHFPiysn82PDbLr8dx6qmbyjGYhoSo10Uyl+d/QUKXiF16Znh4qxrMIQDjVTCTv8jed
         3Ncjumajoh6MIt15GSOqTdEt3C6yYrtx0+0sfG7sLurCt9Esce17hZhlbk6nCjdHlnUL
         MASA==
X-Gm-Message-State: AOAM533Mkr3z8DgvCKKiIhbvx1MTydWKwCzjsHuHDve19AzFQFlHjdVi
        O9xWwZc8BUCsvbchv1lx+Ac+mXNnXz+qrXzGw8BPTYeTfi2+KUQUj3mVvkh2Xa4o5n3a5YYaf5Z
        Fpc1QAcgKq1hRofz1DIXafKFDh5+GV1Oap2OMjAOp3w==
X-Received: by 2002:a5d:4906:: with SMTP id x6mr10245495wrq.552.1642936617998;
        Sun, 23 Jan 2022 03:16:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwb59CpOjfY8CfprDukjo6039z0OQ3gfs8X3bsvt8yvFXtOAvk66eFpeVM1qtu1DqKws8uQug==
X-Received: by 2002:a5d:4906:: with SMTP id x6mr10245485wrq.552.1642936617866;
        Sun, 23 Jan 2022 03:16:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m5sm10143729wms.4.2022.01.23.03.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 03:16:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] ARM: dts: exynos: add USB DWC3 supplies to Chromebook Peach Pi
Date:   Sun, 23 Jan 2022 12:16:40 +0100
Message-Id: <20220123111644.25540-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required voltage regulators for USB DWC3 block on Exynos5800
Chromebook Peach Pi board.  Due to lack of board schematics, use same
regulators as on Odroid XU board (using same MAX77802 PMIC).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5800-peach-pi.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 77013ee586f8..fd6f80a9c64e 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -1072,6 +1072,16 @@ &tmu_gpu {
 	vtmu-supply = <&ldo10_reg>;
 };
 
+&usbdrd3_0 {
+	vdd10-supply = <&ldo15_reg>;
+	vdd33-supply = <&ldo12_reg>;
+};
+
+&usbdrd3_1 {
+	vdd10-supply = <&ldo15_reg>;
+	vdd33-supply = <&ldo12_reg>;
+};
+
 &usbdrd_dwc3_0 {
 	dr_mode = "host";
 };
-- 
2.32.0

