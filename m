Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD4A497120
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiAWLRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:17:03 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38396
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236223AbiAWLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:16:53 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 48F3B3F1B7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642936612;
        bh=QYyBjWAtA9OxXQVLH0xTxaZYjqCQLqUUnu7YMm/h3UM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=q0ESiPfYBcTACElUi/5sTRv+/X29y1inVLbHRBFUoF98mmn5t698WSXNXop0uJyee
         CwUgiGfhbeMo6P4l+GiSfsF2PXrBq7iBu2hHCcMjq6oHikSAYFUSWLqksxgGxNiPNW
         hiEjqQQOexBOVTHd3Gdq9bhQjiJlwhyrRmFDqFDzs0fmi9GxB5ta7polPf4shYgThy
         j2JUq2PQzb8zwOldpNts0+nk0XIgGbXc177NIOjm2bDOp6OCZqa9oO/o9QQGlQeMm/
         1LP+QEEfX0aT+0qIqxbiju7pnLJ8Dzm9xs5x7esPq/e3wQkgDrsp/fFKCAYPa3ZwDl
         SX47qoWDiXf/A==
Received: by mail-wm1-f72.google.com with SMTP id n7-20020a1c7207000000b0034ec3d8ce0aso2319877wmc.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QYyBjWAtA9OxXQVLH0xTxaZYjqCQLqUUnu7YMm/h3UM=;
        b=m1adlESiL0ya/p80kJj9MZZSFGXPPLNuD21KZtlGAWefvInHzUKtMrMDMVyu7mt3gd
         6RwDULQDOen4dGG89KDdarx3bpU0AZlsTXMSqws2/Ey9XXI0cTyKPuX3h18UYyYfntyB
         DAMgK/xj0Og7ma5UfsHTDCLY/c6y/o1FJR6xqIRhtH/Bwbpk5lgaFJupQdlC5DN7+Vkn
         vvfKT/WEF1jUd//X4CphMliyQyk6LYmj6ZWATRak62l3reFLHtNrspPVn3MTejAdU+jM
         L7xORUIecVHXunhk/QQpnAkMqLyYm/7omJtGXvIsukdd3G4hxWUn36bZWpZmJZrD+IHr
         IS7g==
X-Gm-Message-State: AOAM532QR+Pd9mTAhuh13QXcUrNHB4aBJIYwztkCtyTB51IitPscQaqP
        CKDpS3ky/S55Mhpjm2XurlCsWmv36Bdl0MTgASNDx8W7tAIhRzg6aiYpn8mcDvdmbHxbAXJIlsC
        npQ1v6aQDcOeQuOQwPCCvZzYrHrqgWIeSHphGFGWgGg==
X-Received: by 2002:a7b:cd02:: with SMTP id f2mr7650488wmj.68.1642936611940;
        Sun, 23 Jan 2022 03:16:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBpH9pPJ+LM0El76Z0koYfHiM9syIgi7ocm+JAQM3ZbsaChUMb8L30RzWfa7hIIqOsAqEd9w==
X-Received: by 2002:a7b:cd02:: with SMTP id f2mr7650468wmj.68.1642936611756;
        Sun, 23 Jan 2022 03:16:51 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m5sm10143729wms.4.2022.01.23.03.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 03:16:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] ARM: dts: exynos: add USB DWC3 supplies to SMDK5250
Date:   Sun, 23 Jan 2022 12:16:35 +0100
Message-Id: <20220123111644.25540-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required voltage regulators for USB DWC3 block on Exynos5250
SMDK5250 board.  Due to lack of board schematics, use same regulators as
on Arndale board.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 39bbe18145cf..53670383d607 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -417,3 +417,8 @@ max77686_irq: max77686-irq {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
+
+&usbdrd {
+	vdd10-supply = <&ldo15_reg>;
+	vdd33-supply = <&ldo12_reg>;
+};
-- 
2.32.0

