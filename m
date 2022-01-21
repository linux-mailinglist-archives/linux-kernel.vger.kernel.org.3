Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3749643D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381791AbiAURm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:42:57 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28314 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344333AbiAURlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:41:19 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220121174117epoutp01c26bbb1994395013854e502aa1ed7cec~MWfYAEQeA1368913689epoutp01X
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:41:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220121174117epoutp01c26bbb1994395013854e502aa1ed7cec~MWfYAEQeA1368913689epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786877;
        bh=5gMeDQe2rLVY0kR3LBShBgcPXUyVdhwFYDjqwHQd5k0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRwMvA12evEAMDXjqYVidsezHFLIYg3R3ydrZUS79575uwPq+ldtyewGQ7GzoPjhW
         75uLHg2lSh1/zRaIQxrWsYajnRhGCywVbHnGVpoUhpw3vsqqKasGYeXCvk6eg0XkPt
         rfo+m+eY9UydcF2sXO39FQ5O8oF2QwyXJaDy02N4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220121174116epcas5p4b28ff1763dec9f84dd0e64cc0861e8b2~MWfXh07Fh0759707597epcas5p4f;
        Fri, 21 Jan 2022 17:41:16 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JgRWB0rzSz4x9Pt; Fri, 21 Jan
        2022 17:41:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.B5.05590.530FAE16; Sat, 22 Jan 2022 02:41:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220121174109epcas5p374e8960a466f7de537277f4583305857~MWfQydnvj0790107901epcas5p3B;
        Fri, 21 Jan 2022 17:41:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220121174109epsmtrp20c7d65136515ec8ec9c99e46e3c22aae~MWfQwLkaH1730117301epsmtrp2e;
        Fri, 21 Jan 2022 17:41:09 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-2d-61eaf0358489
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.96.29871.530FAE16; Sat, 22 Jan 2022 02:41:09 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174106epsmtip2cea412c410d4bdf75ec7aedd93bfb514~MWfOKhDOn1230012300epsmtip2Y;
        Fri, 21 Jan 2022 17:41:06 +0000 (GMT)
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
Subject: [PATCH v3 12/16] pinctrl: samsung: add FSD SoC specific data
Date:   Fri, 21 Jan 2022 22:58:36 +0530
Message-Id: <20220121172840.12121-13-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmpq7Zh1eJBo+6GC0OvD/IYvFg3jY2
        i7+TjrFbvF/Ww2gx/8g5VouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVmc
        uv6ZzWLR1i/sFq17j7BbHH7Tzmrx79pGFovH1/+wOQh5rJm3htHj969JjB6zGnrZPDat6mTz
        uHNtD5vH5iX1HldONLF69G1Zxejxr2kuu8fnTXIBXFHZNhmpiSmpRQqpecn5KZl56bZK3sHx
        zvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlATykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otL
        bJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjOuzeUv+KpR8WnTdfYGxr3KXYwcHBIC
        JhKrmnO7GLk4hAR2M0r8//WAEcL5xChx+Nl8KOcbo8SmLQfYuxg5wTqWv+lhA7GFBPYySmyb
        ywpR1MIk8ef5CRaQBJuAtsTd6VuYQGwRATeJG40dTCBFzAIrmCV6Vn0DSwgLuErsX3OCFcRm
        EVCVWD7/Nlgzr4CtRMevp8wQ2+QlVm84AGZzAsVfn53HDDJIQmAHh0RX60eok1wkXt2/ywRh
        C0u8Or4FKi4l8fndXjaIR7MlenYZQ4RrJJbOO8YCYdtLHLgyhwWkhFlAU2L9Ln2QMLMAn0Tv
        7ydMEJ28Eh1tQhDVqhLN765CdUpLTOzuZoWwPST61x5jhoTDBEaJXb/OM01glJ2FMHUBI+Mq
        RsnUguLc9NRi0wLjvNRyeDQl5+duYgSnVC3vHYyPHnzQO8TIxMF4iFGCg1lJhLcg/1WiEG9K
        YmVValF+fFFpTmrxIUZTYJBNZJYSTc4HJvW8knhDE0sDEzMzMxNLYzNDJXHeU+kbEoUE0hNL
        UrNTUwtSi2D6mDg4pRqYFostPpvgzGzUPV35j7THhm5FedEKMcnmCb+u/nw7/9/1UxGSH6Lf
        PxJev5jxXGvIfYe0iAv39z8UL0r7HFn9bHGjm4TtsvmzpCfV77tfsl1xmjPP2iMWyxxnXGqc
        Gbl+kfbNItnX0u9yns1+3ffJ7MOe0Kps/nMxK4s2NX3fxXE4R2ttVsrljd/Fmi99eKIRnLWs
        ZpXlFO7pa1OMbvk+Llny7mFWlMuSw4uabvz+57Jw5acE1yA/mwyVb+/1Mq9M55XeOqP/dqPv
        q6NpzzzdclmTf5et33BmZQR7yfYZG5/38vvejVO4peN62lo28m+FM6N4wSKzyscqdYGzn/vf
        uPHeac38xyq2b6d9NH6rvlaJpTgj0VCLuag4EQDmFKuEMgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvK7ph1eJBp9e8FsceH+QxeLBvG1s
        Fn8nHWO3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndXi37WNLBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKK4bFJSczLLUov07RK4Mq7N5S/4qlHx
        adN19gbGvcpdjJwcEgImEsvf9LB1MXJxCAnsZpQ4tPwQI0RCWuL6xgnsELawxMp/z8FsIYEm
        JolLx0JBbDYBbYm707cwgdgiAh4Sbf/uMYMMYhbYxSzR3XkCLCEs4Cqxf80JVhCbRUBVYvn8
        2ywgNq+ArUTHr6fMEAvkJVZvOABmcwLFX5+dxwyxzEaiedZWpgmMfAsYGVYxSqYWFOem5xYb
        FhjmpZbrFSfmFpfmpesl5+duYgRHhJbmDsbtqz7oHWJk4mA8xCjBwawkwluQ/ypRiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqbJC9Y8iJa7PTms/ZxS
        2YT8V4+P5z6R4ZHxfLisaULV24NiN1jD9ks4lizP31KZ94K7N+1VtLBfb1l4tXuugNOssjNS
        aw7tylli71fdFVbrsWex+F+rD0f3Prq5fcPldXLXOVXsteddXTAlPMuSr3zCogVa3j94I2fq
        ZvHYKj37ZvpxddXz1sSLSWnTbZfN5NvQXf5xSzP/DhHmy/r3fE1CX3oHrd0d3FveeEgkyXTv
        z9jPV9RTD/oJ7fU4cfLz3eDXXZW++yvzb1ycVMU1xz2MMUZt1+lnTadnKZg2q8TN69PSKd9Z
        FLmJx/Jmpx5/8KUTzlZ3PxmIbJ8TGWnKlsnxfd/neO8QvgqLnwzGbUosxRmJhlrMRcWJAMJU
        ZVn3AgAA
X-CMS-MailID: 20220121174109epcas5p374e8960a466f7de537277f4583305857
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174109epcas5p374e8960a466f7de537277f4583305857
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174109epcas5p374e8960a466f7de537277f4583305857@epcas5p3.samsung.com>
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
index 2e490e7696f4..6fd06a6ee131 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -727,3 +727,74 @@ const struct samsung_pinctrl_of_match_data exynosautov9_of_data __initconst = {
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
index 0f6e9305fec5..c542c8ed8fe7 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1271,6 +1271,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
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

