Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377FA498259
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiAXOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:30:36 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:42148 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiAXO3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:52 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220124142951epoutp03f7c5eca3791bd485f88889aa703d8e8d~NO0FqAfEI1227112271epoutp03p
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220124142951epoutp03f7c5eca3791bd485f88889aa703d8e8d~NO0FqAfEI1227112271epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034591;
        bh=qPGhD84tRJvx/z9F3ETkqxZkn17JRczHeh0S7mwrbPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/frSR7FqSy8vgptxUHYB9sKD95mrX5Oz//+E9sDNkwRI8bxMprNKyePigUmz9tiT
         r7FcPqQTPEavZmrRTPWlr7QgkylDjNg7moSPEJCJSMXU+Y1kGMTJigfyFxpQ25C/9i
         8EKB/UJ9oPDNwGOIIeY78nOQLc3muYgti6NTDUlg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220124142950epcas5p24eec8376f2f6a46ef13d41da0f1b5c01~NO0E0eEbi0974809748epcas5p2N;
        Mon, 24 Jan 2022 14:29:50 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JjC6y74kQz4x9Pv; Mon, 24 Jan
        2022 14:29:46 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.34.05590.AD7BEE16; Mon, 24 Jan 2022 23:29:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142946epcas5p11997a3c37546d37cac91f690a2a602bf~NO0BII2A62099820998epcas5p1Y;
        Mon, 24 Jan 2022 14:29:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220124142946epsmtrp2c4b48d4e9fcca2edbb5eb6232335aef9~NO0BHPsMW1656816568epsmtrp2N;
        Mon, 24 Jan 2022 14:29:46 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-cd-61eeb7da7b72
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.BB.08738.AD7BEE16; Mon, 24 Jan 2022 23:29:46 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142942epsmtip1352d15b16d6f8a9fab3d2c5b67cb804f~NOz91qGhm1063810638epsmtip1j;
        Mon, 24 Jan 2022 14:29:42 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: [PATCH v5 12/16] pinctrl: samsung: add FSD SoC specific data
Date:   Mon, 24 Jan 2022 19:46:40 +0530
Message-Id: <20220124141644.71052-13-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUwTZxjPe71eC67mrMresWywY2RDA7SjrVe1k2yI5zSOzW1uLrG7lUtL
        +pleO5QsGcomykf5qAQCWMG4jfARBJkjRRgCoiGiG9CCAgoCCyOOD5kogrqWw+2/X35fT97n
        fYQ88RksWJhksjFWE20gsED0YntEROTtX6dpSXqLgmyduYySI66LGPk0v1NAzvyUBcgzHTf4
        ZN3fjxHy1PLPCFk/5uWTc1l3+OTo1AGy112KkUU3WxCyq38eI8/+8o+A/KG5Q0C230/nk8+8
        dSg51r+MxYqpalc1oJae5AOqODUbo+orT2LUkPcSRl049x3Vd+0Yn3I0VALq2bHTAmq+/vWE
        wIP67TqGTmSsoYxJY05MMmlVxJ796vfVcoVEGilVkluIUBNtZFRE3N6EyPgkg+9RROg3tMHu
        oxJoliWi391uNdttTKjOzNpUBGNJNFhkliiWNrJ2kzbKxNi2SiWSd+Q+41d6nXc4C7U8fPvw
        vQeHUkFzWAYIEEJcBu/UXOFngEChGG8C8HbqEuoXxPgDAAvbjnDCPIBzFYPYi0RBbRefM7l9
        CeeXnOl7BA6PTgj8AoZvhsOFDYgfb8Dj4cDRE4jfxMMreDCrcmFFWI/vhEUZQyutKB4O3X3H
        V3gRroKFBbN8bloIrDrfyvPjAB/vKl9YKYL4JSEc6zgFOFMcrEl7uhpYD6euNgg4HAznp5t9
        A4Q+rIdZ7hiO/hb+6OpEObwDtvaVon4LD4+Ate5oP83D18LspXGES4rgieNizh0O06Y9q8lX
        YV5m5upQCv453yLg9pALYMXUJD8XvFb8f2sZAJXgFcbCGrUMK7fEmJjk/75JYzbWg5VL3bSn
        EdwbmY1qA4gQtAEo5BEbRCmJ07RYlEgfSWGsZrXVbmDYNiD3rSyPF7xRY/adusmmlsqUEplC
        oZApYxRS4mVRl/Y8Lca1tI3RM4yFsb7IIcKA4FQkziPwxDrqwkMGru/Qd4XZ+dWHLrR4duPO
        hJNp16SfX75yNf2TN4N+c5h/J52W977uVm5DPjZs3pr5VsUX++6Xy4w3A0RuV19OydEm3OF6
        Ej2+Uc1Ka2r/Ko165IyeitylVDmWR15aNKLCsoniYM8fa5Q5O2dpUR5jf6O7q0+3ODJ6bt+a
        T3nO3aOCxf42vTjecaO7p+fWXP0Bb0pT9LayRTR5MN/glfT0rps42JkxN1Aj7y1c/rBR1VA+
        eD13Btwdo3d9xI4GVcQudJdonm959EFrWPvkcx2xv9aYshB0uKRKXjD+sFTVercqDD4OmcxJ
        bsxeC4duFX1G2dwRe6UaAmV1tHQTz8rS/wJkxwdkMgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnO6t7e8SDXZe5bY48P4gi8WDedvY
        LP5OOsZu8X5ZD6PF/CPnWC02vv3BZDHlz3Imi02Pr7FafOy5x2rx8FW4xeVdc9gsZpzfx2Rx
        6vpnNotFW7+wW7TuPcJucfhNO6vFv2sbWSweX//D5iDksWbeGkaP378mMXrMauhl89i0qpPN
        4861PWwem5fUe1w50cTq0bdlFaPHv6a57B6fN8kFcEVx2aSk5mSWpRbp2yVwZVy728NS8FWj
        4tGnuAbGvcpdjJwcEgImElPXn2IFsYUEdjBKzPhiDhGXlri+cQI7hC0ssfLfcyCbC6imiUli
        xa4NjCAJNgFtibvTtzCB2CICHhJt/+4xgxQxC+xilujuPAGWEBZwlZjRdYcNxGYRUJXYdaUN
        LM4rYCsxfeoHVogN8hKrNxxgBrE5geLzFn4DquEA2mYjce63ygRGvgWMDKsYJVMLinPTc4sN
        C4zyUsv1ihNzi0vz0vWS83M3MYLjQUtrB+OeVR/0DjEycTAeYpTgYFYS4a1KeZcoxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA1P+ygv8mgofnxrsXxY3
        523W1a9vas//L78Xpc6qoJZyJ1XT49/aYJ7HwvyHT7/b/LCOY9+u3VlKvWqCdrGXf2YleqRf
        LwxQSBAKf1fCUJV4O+Auw8yX54pmHH7xruXklj0nJZrOmf0VDVVK7N0swJsRJmUictKp+Hhw
        YmTZ0gwvlr8Sk27nMcoaevtaNOxMKjrvp1gxQeXyeaGgLIvjcdKtUcr7WM/1Lzn9cK9Pwoef
        Ihs+6mV7hO66cFqmaZmzQZ+04a8fXiVTcq7sVt+hIntB7MFNHTaXtFjui48ruo6IRMyZuHlf
        bd1S44NuFv8mJSp+VF0+6w3HuzX9kYcaVr9+8I2DaZ9ErP/LQ+wbZiixFGckGmoxFxUnAgCf
        rTzJ9gIAAA==
X-CMS-MailID: 20220124142946epcas5p11997a3c37546d37cac91f690a2a602bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142946epcas5p11997a3c37546d37cac91f690a2a602bf
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142946epcas5p11997a3c37546d37cac91f690a2a602bf@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Tesla FSD SoC specific data to enable pinctrl.
FSD SoC has similar pinctrl controller as found in the most
Samsung/Exynos SoCs.

Cc: linux-fsd@tesla.com
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 71 +++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c     |  2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |  1 +
 3 files changed, 74 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index 4102ce955bd7..d291819c2f77 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -725,3 +725,74 @@ const struct samsung_pinctrl_of_match_data exynosautov9_of_data __initconst = {
 	.ctrl		= exynosautov9_pin_ctrl,
 	.num_ctrl	= ARRAY_SIZE(exynosautov9_pin_ctrl),
 };
+
+/*
+ * Pinctrl driver data for Tesla FSD SoC. FSD SoC includes three
+ * gpio/pin-mux/pinconfig controllers.
+ */
+
+/* pin banks of FSD pin-controller 0 (FSYS) */
+static const struct samsung_pin_bank_data fsd_pin_banks0[] __initconst = {
+	EXYNOS850_PIN_BANK_EINTG(7, 0x00, "gpf0", 0x00),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x20, "gpf1", 0x04),
+	EXYNOS850_PIN_BANK_EINTG(3, 0x40, "gpf6", 0x08),
+	EXYNOS850_PIN_BANK_EINTG(2, 0x60, "gpf4", 0x0c),
+	EXYNOS850_PIN_BANK_EINTG(6, 0x80, "gpf5", 0x10),
+};
+
+/* pin banks of FSD pin-controller 1 (PERIC) */
+static const struct samsung_pin_bank_data fsd_pin_banks1[] __initconst = {
+	EXYNOS850_PIN_BANK_EINTG(4, 0x000, "gpc8", 0x00),
+	EXYNOS850_PIN_BANK_EINTG(7, 0x020, "gpf2", 0x04),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x040, "gpf3", 0x08),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x060, "gpd0", 0x0c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x080, "gpb0", 0x10),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x0a0, "gpb1", 0x14),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x0c0, "gpb4", 0x18),
+	EXYNOS850_PIN_BANK_EINTG(4, 0x0e0, "gpb5", 0x1c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x100, "gpb6", 0x20),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x120, "gpb7", 0x24),
+	EXYNOS850_PIN_BANK_EINTG(5, 0x140, "gpd1", 0x28),
+	EXYNOS850_PIN_BANK_EINTG(5, 0x160, "gpd2", 0x2c),
+	EXYNOS850_PIN_BANK_EINTG(7, 0x180, "gpd3", 0x30),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x1a0, "gpg0", 0x34),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x1c0, "gpg1", 0x38),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x1e0, "gpg2", 0x3c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x220, "gpg4", 0x44),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x240, "gpg5", 0x48),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x260, "gpg6", 0x4c),
+	EXYNOS850_PIN_BANK_EINTG(8, 0x280, "gpg7", 0x50),
+};
+
+/* pin banks of FSD pin-controller 2 (PMU) */
+static const struct samsung_pin_bank_data fsd_pin_banks2[] __initconst = {
+	EXYNOS850_PIN_BANK_EINTN(3, 0x00, "gpq0"),
+};
+
+const struct samsung_pin_ctrl fsd_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 FSYS0 data */
+		.pin_banks	= fsd_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(fsd_pin_banks0),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 1 PERIC data */
+		.pin_banks	= fsd_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(fsd_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 2 PMU data */
+		.pin_banks	= fsd_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(fsd_pin_banks2),
+	},
+};
+
+const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
+	.ctrl		= fsd_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(fsd_pin_ctrl),
+};
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 568b6e65dfed..f610beab23a0 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1320,6 +1320,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = &exynos850_of_data },
 	{ .compatible = "samsung,exynosautov9-pinctrl",
 		.data = &exynosautov9_of_data },
+	{ .compatible = "tesla,fsd-pinctrl",
+		.data = &fsd_of_data },
 #endif
 #ifdef CONFIG_PINCTRL_S3C64XX
 	{ .compatible = "samsung,s3c64xx-pinctrl",
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 1f8d30ba05af..5b32d3f30fcd 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -342,6 +342,7 @@ extern const struct samsung_pinctrl_of_match_data exynos7_of_data;
 extern const struct samsung_pinctrl_of_match_data exynos7885_of_data;
 extern const struct samsung_pinctrl_of_match_data exynos850_of_data;
 extern const struct samsung_pinctrl_of_match_data exynosautov9_of_data;
+extern const struct samsung_pinctrl_of_match_data fsd_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c64xx_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c2412_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c2416_of_data;
-- 
2.25.1

