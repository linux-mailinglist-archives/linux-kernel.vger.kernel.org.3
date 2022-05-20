Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CE253023A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 11:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbiEVJyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 05:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243385AbiEVJye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 05:54:34 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D413B3D4
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 02:54:33 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220522095429epoutp03630676fa057a273aebc664256de3c33e~xZLW0ku4C1803418034epoutp03D
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 09:54:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220522095429epoutp03630676fa057a273aebc664256de3c33e~xZLW0ku4C1803418034epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653213269;
        bh=LbKA1zuCHHgjytaxf7pbRgp1K7uW9nFynZPObMbAQFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2HIjTqKYPdEYypg4W3+P06CQLl9N9ISG9iCZs0prU2IBCh7cs7C/+S1LQ+7R4W3w
         YIz2hvrNTHrugQ0rzoIaEJoB/g9PQ4wvAXzddFuT/AizyZ7jWa22vrXsPN8ew1nExc
         kw+ZaNdD64y7oDWAPJNr4DkLSmSeJYbBxKsThq1k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220522095428epcas5p2ab41fb5e759c3067c9897dc9bd2fb5ec~xZLVvYIL33217932179epcas5p2J;
        Sun, 22 May 2022 09:54:28 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L5bQm43jHz4x9Pp; Sun, 22 May
        2022 09:54:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.01.09827.0580A826; Sun, 22 May 2022 18:54:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220520145802epcas5p2153cb572493e3bccd702e0ecce1171fb~w2Bz5l2F30456204562epcas5p28;
        Fri, 20 May 2022 14:58:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220520145802epsmtrp2baba019b24fd22c46067f5de9a8549f1~w2Bz4pZNy0678606786epsmtrp2K;
        Fri, 20 May 2022 14:58:02 +0000 (GMT)
X-AuditID: b6c32a4a-b51ff70000002663-f2-628a08504f10
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.E2.11276.97CA7826; Fri, 20 May 2022 23:58:02 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220520145800epsmtip1336ebd9f9cb40b177ac85b01ce6e1a7c~w2Bx2w8wv1422614226epsmtip1_;
        Fri, 20 May 2022 14:57:59 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     geert@linux-m68k.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, alim.akhtar@samsung.com,
        paul@crapouillou.net, linux-fsd@tesla.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v2 2/3] iio: adc: exynos-adc: Add support for ADC FSD-HW
 controller
Date:   Fri, 20 May 2022 20:28:19 +0530
Message-Id: <20220520145820.67667-3-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220520145820.67667-1-m.shams@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTUzeAoyvJ4F+DnMWDedvYLOYfOcdq
        8ezWXiaLB02rmCxezrrHZrFk8nxWi02Pr7FaPHwVbjHvyDsWi8u75rBZzDi/j8nibutidov+
        xZdYLFr3HmF34PNYfamdzWPTqk42j0OHOxg9Ni+p91jy5hCrR9+WVYwe/5rmsnt83iQXwBGV
        bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdLaSQlli
        TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj
        4NUzLAXv5CouXdRqYHwi2cXIwSEhYCIxbbZAFyMXh5DAbkaJ1fsmMEE4nxglZv3cwQzhfGOU
        WHH6BVsXIydYx5kLt1khEnsZJVq3rIZqaWGS2HvkMDvIXDYBTYnj57lBTBEBf4nOvy4gJcwC
        y5kkTq+bBjZIWCBUov/VfTCbRUBV4vrtXcwgNq+AhcTas1+hlslLrN5wACzOKWAp8fVnEyPI
        IAmBXg6JmZPmsUIUuUjc//aKEcIWlnh1fAs7hC0l8fndXqhB6RJzH/YyQdgFEst2fYeqsZc4
        cGUOC8ihzEA3r9+lDxGWlZh6ah1YObMAn0Tv7ydQrbwSO+bB2IoS/3f3Q40Rl3i3YgrUOR4S
        bRsPMkLCpIdRYs7rX6wTGOVmIaxYwMi4ilEytaA4Nz212LTAKC+1HB5nyfm5mxjBCVPLawfj
        wwcf9A4xMnEwHmKU4GBWEuHdntiRJMSbklhZlVqUH19UmpNafIjRFBiAE5mlRJPzgSk7ryTe
        0MTSwMTMzMzE0tjMUEmcV+B/Y5KQQHpiSWp2ampBahFMHxMHp1QD0+YLi6byBC8XznuRZXNr
        QbdkcneGcl/bpHL1Ll7/Tw3TzWf4sDK9Ovr9hLHRm4yChNMSC4TZTwqbJs68yTL1ZHrkgXRn
        s4x7179w1/x54Mz78YaHAZt24s9zxr9mypmF2D+8fDg+fBdb0DpzyX0nb7yNO/NzSYxjuacy
        7xano2sFZdM2msgWhM7eYrlLf02iBQf3JpEwQQ5WHuFtT67r71on/Xa67+9vlvnJOVzbez7o
        X5n0y757f+L3dexev5jslz/yXWLjV3AweuMxESPVWX8bPn4t0t177JHde3n+0D+dnJ6ur7zL
        ZgcHHOyquHhj9YvSqvD5L9j9VETPqFi8cGteslv5x+yPOtbWeeUqSizFGYmGWsxFxYkANLiA
        TyEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSnG7VmvYkg5l/GS0ezNvGZjH/yDlW
        i2e39jJZPGhaxWTxctY9Noslk+ezWmx6fI3V4uGrcIt5R96xWFzeNYfNYsb5fUwWd1sXs1v0
        L77EYtG69wi7A5/H6kvtbB6bVnWyeRw63MHosXlJvceSN4dYPfq2rGL0+Nc0l93j8ya5AI4o
        LpuU1JzMstQifbsEroyDV8+wFLyTq7h0UauB8YlkFyMnh4SAicSZC7dZuxi5OIQEdjNKzOia
        wwKREJeY9ms/I4QtLLHy33N2iKImJol1f9+xdTFycLAJaEocP88NUiMiECyx+NBhZpAaZoGN
        TBL/d3exgiSEgRKzbk9iBrFZBFQlrt/eBWbzClhIrD37lQ1igbzE6g0HwOKcApYSX382gS0W
        AqpZ0fiNeQIj3wJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFBraW5g3H7qg96
        hxiZOBgPMUpwMCuJ8DLmtiQJ8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1
        ILUIJsvEwSnVwLRf88WKyQflwtctPni9+KT2+1+cGdELIpiaZ2W1MXosOfP0/6PYy1xTTFwi
        LUR3HK404Hq5yU+qO7AmsbFow4kQiVLF0k3fL3X9jeGeUMGauu2+uIh8cGnoz4XeOb4z+Mpv
        xCSu33W5pDpLRX5Zo09csMOmD3ozXS+KpTb8PKN07O3Mtwk2RdfucW5olLUxaHuX7FF8wl11
        +684Y7P3fx5MK/DPinMP4Nsb9jCUaXuGj/Lf5Ys7Kpwu6Gj6p/mlZDmsaVq+an93ojU//8uV
        oo1Hct9J1ockLWtcqcYVqcaVHvi52sPg3OnNH6ZwJd1y2R3e1Xivvn7fnSUHpWxD52szG+7s
        9Pv55pR49ZNuJZbijERDLeai4kQAHlqIidkCAAA=
X-CMS-MailID: 20220520145802epcas5p2153cb572493e3bccd702e0ecce1171fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520145802epcas5p2153cb572493e3bccd702e0ecce1171fb
References: <20220520145820.67667-1-m.shams@samsung.com>
        <CGME20220520145802epcas5p2153cb572493e3bccd702e0ecce1171fb@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alim Akhtar <alim.akhtar@samsung.com>

Exynos's ADC-FSD-HW has some difference in registers set, number of
programmable channels (16 channel) etc. This patch adds support for
ADC-FSD-HW controller version.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
- Changes since v1
* Addressed Jonathan's comment by using already provided isr handle

 drivers/iio/adc/exynos_adc.c | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index cff1ba57fb16..183ae591327a 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -55,6 +55,11 @@
 #define ADC_V2_INT_ST(x)	((x) + 0x14)
 #define ADC_V2_VER(x)		((x) + 0x20)
 
+/* ADC_FSD_HW register definitions */
+#define ADC_FSD_DAT(x)			((x) + 0x08)
+#define ADC_FSD_DAT_SUM(x)		((x) + 0x0C)
+#define ADC_FSD_DBG_DATA(x)		((x) + 0x1C)
+
 /* Bit definitions for ADC_V1 */
 #define ADC_V1_CON_RES		(1u << 16)
 #define ADC_V1_CON_PRSCEN	(1u << 14)
@@ -92,6 +97,7 @@
 
 /* Bit definitions for ADC_V2 */
 #define ADC_V2_CON1_SOFT_RESET	(1u << 2)
+#define ADC_V2_CON1_SOFT_NON_RESET	(1u << 1)
 
 #define ADC_V2_CON2_OSEL	(1u << 10)
 #define ADC_V2_CON2_ESEL	(1u << 9)
@@ -100,6 +106,7 @@
 #define ADC_V2_CON2_ACH_SEL(x)	(((x) & 0xF) << 0)
 #define ADC_V2_CON2_ACH_MASK	0xF
 
+#define MAX_ADC_FSD_CHANNELS		16
 #define MAX_ADC_V2_CHANNELS		10
 #define MAX_ADC_V1_CHANNELS		8
 #define MAX_EXYNOS3250_ADC_CHANNELS	2
@@ -484,6 +491,43 @@ static const struct exynos_adc_data exynos7_adc_data = {
 	.start_conv	= exynos_adc_v2_start_conv,
 };
 
+static void exynos_adc_fsd_init_hw(struct exynos_adc *info)
+{
+	u32 con2;
+
+	writel(ADC_V2_CON1_SOFT_RESET, ADC_V2_CON1(info->regs));
+
+	writel(ADC_V2_CON1_SOFT_NON_RESET, ADC_V2_CON1(info->regs));
+
+	con2 = ADC_V2_CON2_C_TIME(6);
+	writel(con2, ADC_V2_CON2(info->regs));
+
+	/* Enable interrupts */
+	writel(1, ADC_V2_INT_EN(info->regs));
+}
+
+static void exynos_adc_fsd_exit_hw(struct exynos_adc *info)
+{
+	u32 con2;
+
+	con2 = readl(ADC_V2_CON2(info->regs));
+	con2 &= ~ADC_V2_CON2_C_TIME(7);
+	writel(con2, ADC_V2_CON2(info->regs));
+
+	/* Disable interrupts */
+	writel(0, ADC_V2_INT_EN(info->regs));
+}
+
+static const struct exynos_adc_data fsd_hw_adc_data = {
+	.num_channels	= MAX_ADC_FSD_CHANNELS,
+	.mask		= ADC_DATX_MASK, /* 12 bit ADC resolution */
+
+	.init_hw	= exynos_adc_fsd_init_hw,
+	.exit_hw	= exynos_adc_fsd_exit_hw,
+	.clear_irq	= exynos_adc_v2_clear_irq,
+	.start_conv	= exynos_adc_v2_start_conv,
+};
+
 static const struct of_device_id exynos_adc_match[] = {
 	{
 		.compatible = "samsung,s3c2410-adc",
@@ -518,6 +562,9 @@ static const struct of_device_id exynos_adc_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-adc",
 		.data = &exynos7_adc_data,
+	}, {
+		.compatible = "samsung,exynos-adc-fsd-hw",
+		.data = &fsd_hw_adc_data,
 	},
 	{},
 };
@@ -626,6 +673,8 @@ static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
 		info->ts_x = readl(ADC_V1_DATX(info->regs));
 		info->ts_y = readl(ADC_V1_DATY(info->regs));
 		writel(ADC_TSC_WAIT4INT | ADC_S3C2443_TSC_UD_SEN, ADC_V1_TSC(info->regs));
+	} else if (of_device_is_compatible(info->dev->of_node, "samsung,exynos-adc-fsd-hw")) {
+		info->value = readl(ADC_FSD_DAT(info->regs)) & mask;
 	} else {
 		info->value = readl(ADC_V1_DATX(info->regs)) & mask;
 	}
@@ -719,6 +768,12 @@ static const struct iio_chan_spec exynos_adc_iio_channels[] = {
 	ADC_CHANNEL(7, "adc7"),
 	ADC_CHANNEL(8, "adc8"),
 	ADC_CHANNEL(9, "adc9"),
+	ADC_CHANNEL(10, "adc10"),
+	ADC_CHANNEL(11, "adc11"),
+	ADC_CHANNEL(12, "adc12"),
+	ADC_CHANNEL(13, "adc13"),
+	ADC_CHANNEL(14, "adc14"),
+	ADC_CHANNEL(15, "adc15"),
 };
 
 static int exynos_adc_remove_devices(struct device *dev, void *c)
-- 
2.17.1

