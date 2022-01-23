Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5886849752C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbiAWTU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:20:56 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52845 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbiAWTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:20:32 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220123192030epoutp013e08df88198a214172753adb587af7b4~M-IlKd_231800618006epoutp010
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:20:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220123192030epoutp013e08df88198a214172753adb587af7b4~M-IlKd_231800618006epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965630;
        bh=qPGhD84tRJvx/z9F3ETkqxZkn17JRczHeh0S7mwrbPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=owgT0sxKr0dIEsf2KFcWHzdrSMV1PV9+KEL8JadwKE+3QPtxPo+GXrtqWEyYCQte+
         kInMobzbmdC+gEgEk8uMXXsWUXUfywCXJmr/v8HfWXv5vgWYZMq4gn4oHf6qnvnwGv
         nE7V8xk3+ElFqeP6UE8TYElDhgRqZVTx9hv0EfFc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220123192029epcas5p1f110c8d7e324833733b930f93fb5e9d9~M-Ij-h7CJ0413404134epcas5p1B;
        Sun, 23 Jan 2022 19:20:29 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jhjcm5nJ1z4x9Pv; Sun, 23 Jan
        2022 19:20:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.FD.05590.87AADE16; Mon, 24 Jan 2022 04:20:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220123192023epcas5p2daf1cc38e042a6dce8b0271026065715~M-Ieod-6H2292122921epcas5p27;
        Sun, 23 Jan 2022 19:20:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220123192023epsmtrp214d282fa1af1e671acf90f115893a294~M-IenVp522018820188epsmtrp2l;
        Sun, 23 Jan 2022 19:20:23 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-f4-61edaa78a3e3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.C9.08738.77AADE16; Mon, 24 Jan 2022 04:20:23 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192021epsmtip169b5fd0ed4131d068fffdabbb8624cc9~M-IcSFqGX0799807998epsmtip1F;
        Sun, 23 Jan 2022 19:20:21 +0000 (GMT)
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
Subject: [PATCH v4 12/16] pinctrl: samsung: add FSD SoC specific data
Date:   Mon, 24 Jan 2022 00:37:25 +0530
Message-Id: <20220123190729.1852-13-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmpm7FqreJBme69SwOvD/IYvFg3jY2
        i7+TjrFbvF/Ww2gx/8g5VouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVmc
        uv6ZzWLR1i/sFq17j7BbHH7Tzmrx79pGFovH1/+wOQh5rJm3htHj969JjB6zGnrZPDat6mTz
        uHNtD5vH5iX1HldONLF69G1Zxejxr2kuu8fnTXIBXFHZNhmpiSmpRQqpecn5KZl56bZK3sHx
        zvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlATykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otL
        bJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjOu3e1hKfiqUfHoU1wD417lLkZODgkB
        E4mWl82sXYxcHEICuxkldp2ZyALhfGKU2HxrFZTzmVGi4+hNxi5GDrCW2Veg4rsYJVYvO8wM
        4bQwSXQe2M4EMpdNQFvi7vQtYLaIgJvEjcYOJpAiZoEVzBI9q76BJYQFXCVaz19kAbFZBFQl
        1v87zwyygVfARmL17EqI++QlVm84wAxicwKFe199ALtVQuAAh0TnrYMsEBe5SFzq04eoF5Z4
        dXwLO4QtJfH53V42iJJsiZ5dxhDhGoml846xQNj2EgeuzAGbwiygKbF+F9gUZgE+id7fT5gg
        OnklOtqEIKpVJZrfXYXqlJaY2N3NCmF7SOz4dYEJEgr9jBLb965gn8AoOwth6gJGxlWMkqkF
        xbnpqcWmBcZ5qeXwWErOz93ECE6oWt47GB89+KB3iJGJg/EQowQHs5IIb0H+q0Qh3pTEyqrU
        ovz4otKc1OJDjKbAAJvILCWanA9M6Xkl8YYmlgYmZmZmJpbGZoZK4ryn0jckCgmkJ5akZqem
        FqQWwfQxcXBKNTA9Xnn/QYkI78qAS6ZvrpyZyKjzusPu7WZZPp6vazcVSi5a3J0kYqC0YvHG
        v7nRy93vcfb1dx9OP9NiLn2zetpsW79YubmuXx7+fOVjMe/Th1M2z5+FfIxd0Hfgo56+0KYE
        Vabux5t/HlB9Ym2sbt/dsbJh0p+308pNAqOyLswIy/3fMc8p5/aqz9Wqh/eubfeMmyvPHzlh
        2uyAb1yiEUGdGyymM6n7P5Oqvn+7o+RIW5xi4c7Ddx9/E5O1lvsvqhaQ38D1uYnl96+5/ht0
        ed7+enzj2hz3L/ZPwypnHXjVOFX0ZgOfAd9Ow/Add7elrP1mrfOH47HItetsjJdK5BvUXhiE
        WbQu2j7TWlGvNHOlEktxRqKhFnNRcSIAybN5ozEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnG75qreJBqu3KFkceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi37WNLBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKK4bFJSczLLUov07RK4Mq7d7WEp+KpR
        8ehTXAPjXuUuRg4OCQETidlXWLoYuTiEBHYwSpyeuZGxi5ETKC4tcX3jBHYIW1hi5b/n7BBF
        TUwSV6+2s4Ek2AS0Je5O38IEYosIeEi0/bvHDFLELLCLWaK78wRYQljAVaL1/EUWEJtFQFVi
        /b/zzCCbeQVsJFbProRYIC+xesMBZhCbEyjc++oDK0iJkIC1xISjchMY+RYwMqxilEwtKM5N
        zy02LDDKSy3XK07MLS7NS9dLzs/dxAiOBi2tHYx7Vn3QO8TIxMF4iFGCg1lJhLcg/1WiEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUwLVQ97FW3/6jXZ
        p9v4rQnnQ/0VTesmvGN419P74GPvazlm3Rsd8b5/9kcV/qxdsDLizQTDdTq7y4o+b7y6QzC9
        5mfx3h03IgJN3/+3n6+07PThORYrTBU3NcffzQ9kz1s5JafP5pUhm2OmziqGVxM0eN4GCHZc
        9FLgFb24v11q16Tml09vexQeEVeW3Mn4cOvf48lz1vhISL5yN13y66XjfAu/2u0TD8ztmj9p
        J1u2xB3HKUJd66wOsLRrJRlcZM75rV/mtflzs0zhEZa4+ACNRL6/m6+/arh3ZYPIntomdhnj
        L8rxK4J9MtwfZzQdir92u+97RbfSj6e+mUYhKTPO7Muw28XA9OPVsdLcVbZKLMUZiYZazEXF
        iQCwnOnx9QIAAA==
X-CMS-MailID: 20220123192023epcas5p2daf1cc38e042a6dce8b0271026065715
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123192023epcas5p2daf1cc38e042a6dce8b0271026065715
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123192023epcas5p2daf1cc38e042a6dce8b0271026065715@epcas5p2.samsung.com>
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

