Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5348D7CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiAMMZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:25:35 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:34313 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiAMMY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:59 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220113122458epoutp019ca6fbd59c071d6e2a835e2794121c33~J1A6cQ2HS1825518255epoutp01X
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220113122458epoutp019ca6fbd59c071d6e2a835e2794121c33~J1A6cQ2HS1825518255epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076698;
        bh=WkVMaVSvbF1rUXL/Nei45+HdjDkhGZ/cFN1rSrgqnLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7DQRIZAhhld2X3dz5rL6c1niBzzLb6fn3HZKwdrMFN0/LiPGCooEQsR+DOVv3Ot/
         09I2sZ/YHR6M+jRvLMmqqwDP5R6m8qR+0mlsoFv8bCqd7O9nrMUP5TIlpEtElpIiS2
         3r+kUJMFApG4KMo6oazirw/WqBDXaujWA1f4dhSE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220113122457epcas5p104413405fafda3688352a3d7e65d7f62~J1A5qXTcX2652426524epcas5p1Q;
        Thu, 13 Jan 2022 12:24:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZNsw5QpPz4x9Q6; Thu, 13 Jan
        2022 12:24:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.D6.06423.41A10E16; Thu, 13 Jan 2022 21:24:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122452epcas5p201a3a87d0e9c0e9f449a90ed62de1f1c~J1A0jt9-S2959629596epcas5p2C;
        Thu, 13 Jan 2022 12:24:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122452epsmtrp14ba050598d95dfded2ba253dd5b92c3d~J1A0i4RdX2009320093epsmtrp1B;
        Thu, 13 Jan 2022 12:24:52 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-2a-61e01a14cb84
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.B8.29871.31A10E16; Thu, 13 Jan 2022 21:24:51 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122448epsmtip25b5a0b0f3b13357571a8679d99b5e964~J1AxdzOLs1247412474epsmtip21;
        Thu, 13 Jan 2022 12:24:48 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, jic23@kernel.org, linux-iio@vger.kernel.org,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH 21/23] iio: adc: exynos-adc: Add support for ADC V3
 controller
Date:   Thu, 13 Jan 2022 17:41:41 +0530
Message-Id: <20220113121143.22280-22-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmpq6I1INEg9+vRCwezNvGZvF+WQ+j
        xfwj51gtHjStYrLY+PYHk8WUP8uZLDY9vsZq8bHnHqvFw1fhFvOOvGOxuLxrDpvFjPP7mCzu
        ti5mtzh1/TObxaKtX9gtWvceYbc4/Kad1eLx9T9sDkIea+atYfSY1dDL5rFpVSebx51re9g8
        Ni+p97hyoonVo2/LKkaPf01z2T0+b5IL4IzKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
        1DW0tDBXUshLzE21VXLxCdB1y8wB+kdJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCS
        U2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ1xb+0D5oJzyhWzX/A3MF6U7WLk5JAQMJHYMucx
        O4gtJLCbUeL/H4MuRi4g+xOjxK2H19ggEt8YJdbt1oBrWLGXCaJoL6PE1+V9UE4Lk8T6M+8Y
        QarYBLQl7k7fwgRiiwi4Sdxo7AArYhbYxCwx7ewdsH3CAgESk1b8ZQWxWQRUJX6vbAdr4BWw
        lTg69xU7xDp5idUbDjB3MXJwcALF767KA5kjIbCFQ+L25LdMEDUuEhtbexghbGGJV8e3QPVK
        Sbzsb2MH6ZUQyJbo2WUMEa6RWDrvGAuEbS9x4MocFpASZgFNifW79EHCzAJ8Er2/nzBBdPJK
        dLQJQVSrSjS/uwrVKS0xsbubFaLEQ6Lvky8kFCYwSpw+eZJtAqPsLIShCxgZVzFKphYU56an
        FpsWGOallsMjKTk/dxMjOIlqee5gvPvgg94hRiYOxkOMEhzMSiK8/UX3E4V4UxIrq1KL8uOL
        SnNSiw8xmgIDbCKzlGhyPjCN55XEG5pYGpiYmZmZWBqbGSqJ855O35AoJJCeWJKanZpakFoE
        08fEwSnVwGS9QGTH1kULFgv2BR37LZ4j/+f7uT7R08+rjWzyZ1klb3u/7ajexS2Hiw0Xcjyz
        UDsUX6SY9TVIeSu/2gzFUmP3uj/HHf7suL+Jk13n/JtPBjGfz50JW8+3JiTcJnWj5fwFDimy
        ghfvsud6+kQcua1tsburKsNTc7X9vbfduhazmPfdPXDHdFWXW2pweK6G/7dvz7/N2/jexc3I
        tFcj+vXhS2tyn/qFasTWb21//X53VaDuqcO3zKIk6padum3k9ODhfUMeuafJHK2hb/ZekN7p
        oyTdpvUnxVLkedHPr/EPl373lZjjuPlkjfYl/aZnl7nXWidlv7Pa/1Ip4eNOy6RTv3Iqnfg/
        Hw/4u/vvDx4lluKMREMt5qLiRABlDZCuKwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvK6w1INEg98bVSwezNvGZvF+WQ+j
        xfwj51gtHjStYrLY+PYHk8WUP8uZLDY9vsZq8bHnHqvFw1fhFvOOvGOxuLxrDpvFjPP7mCzu
        ti5mtzh1/TObxaKtX9gtWvceYbc4/Kad1eLx9T9sDkIea+atYfSY1dDL5rFpVSebx51re9g8
        Ni+p97hyoonVo2/LKkaPf01z2T0+b5IL4IzisklJzcksSy3St0vgyri39gFzwTnlitkv+BsY
        L8p2MXJySAiYSGxZsZepi5GLQ0hgN6PEwjNvWSES0hLXN05gh7CFJVb+e84OUdTEJHHm+nkm
        kASbgLbE3elbwGwRAQ+Jtn/3mEGKmAWOMEtsP3mSBSQhLOAnMfHvNbAiFgFVid8r28FsXgFb
        iaNzX0FtkJdYveEAUDMHBydQ/O6qPJCwkICNxLlX69kmMPItYGRYxSiZWlCcm55bbFhgmJda
        rlecmFtcmpeul5yfu4kRHAdamjsYt6/6oHeIkYmD8RCjBAezkghvf9H9RCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYGgTburXyTgQy8/+YZPEkxsTl
        ULKDenRV0fyb07hT/XgmZ3tL/pozPeEJ38lMgcnv3K5eXub/Zu/269uSQ48ZKNW3SxiIefg6
        rljirDj5PN+/tjc26r+tPrJZLHvmtudCi3e3feFqI34bv8l2/VKcNzyKl4mmBkxb+L2K79z/
        yel7+lZr7zqQ88LaoPnG0uJ16tdeHP+X8XZu9QrRFddqFecU3vNyFyvvj/44ZXqNteKENad2
        T1cL+/D7vEUxZ4X7qs1aN+2r1nu3Rt3YN9X13C+n1GdtV5OMNz1s09wya/fEP19cVlm/nLet
        xtDD79FB58R9kbsjP5zvCqma3ZcXzl+p3+/T/DOEX1BsQn+eEktxRqKhFnNRcSIAEBg6fvIC
        AAA=
X-CMS-MailID: 20220113122452epcas5p201a3a87d0e9c0e9f449a90ed62de1f1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122452epcas5p201a3a87d0e9c0e9f449a90ed62de1f1c
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122452epcas5p201a3a87d0e9c0e9f449a90ed62de1f1c@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos's ADC-V3 has some difference in registers set, number of
programmable channels (16 channel) etc. This patch adds support for ADC-V3
controller version.

Cc: linux-fsd@tesla.com
Cc: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Signed-off-by: Tamseel Shams <m.shams@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/iio/adc/exynos_adc.c | 74 +++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 3b3868aa2533..61752e798fd6 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -55,6 +55,11 @@
 #define ADC_V2_INT_ST(x)	((x) + 0x14)
 #define ADC_V2_VER(x)		((x) + 0x20)
 
+/* ADC_V3 register definitions */
+#define ADC_V3_DAT(x)			((x) + 0x08)
+#define ADC_V3_DAT_SUM(x)		((x) + 0x0C)
+#define ADC_V3_DBG_DATA(x)		((x) + 0x1C)
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
 
+#define MAX_ADC_V3_CHANNELS		16
 #define MAX_ADC_V2_CHANNELS		10
 #define MAX_ADC_V1_CHANNELS		8
 #define MAX_EXYNOS3250_ADC_CHANNELS	2
@@ -164,6 +171,7 @@ struct exynos_adc_data {
 	void (*exit_hw)(struct exynos_adc *info);
 	void (*clear_irq)(struct exynos_adc *info);
 	void (*start_conv)(struct exynos_adc *info, unsigned long addr);
+	irqreturn_t (*adc_isr)(int irq, void *dev_id);
 };
 
 static void exynos_adc_unprepare_clk(struct exynos_adc *info)
@@ -484,6 +492,59 @@ static const struct exynos_adc_data exynos7_adc_data = {
 	.start_conv	= exynos_adc_v2_start_conv,
 };
 
+static void exynos_adc_v3_init_hw(struct exynos_adc *info)
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
+static void exynos_adc_v3_exit_hw(struct exynos_adc *info)
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
+static irqreturn_t exynos_adc_v3_isr(int irq, void *dev_id)
+{
+	struct exynos_adc *info = (struct exynos_adc *)dev_id;
+	u32 mask = info->data->mask;
+
+	info->value = readl(ADC_V3_DAT(info->regs)) & mask;
+
+	if (info->data->clear_irq)
+		info->data->clear_irq(info);
+
+	complete(&info->completion);
+
+	return IRQ_HANDLED;
+}
+
+static const struct exynos_adc_data exynos_adc_v3_adc_data = {
+	.num_channels	= MAX_ADC_V3_CHANNELS,
+	.mask		= ADC_DATX_MASK, /* 12 bit ADC resolution */
+
+	.init_hw	= exynos_adc_v3_init_hw,
+	.exit_hw	= exynos_adc_v3_exit_hw,
+	.clear_irq	= exynos_adc_v2_clear_irq,
+	.start_conv	= exynos_adc_v2_start_conv,
+	.adc_isr	= exynos_adc_v3_isr,
+};
+
 static const struct of_device_id exynos_adc_match[] = {
 	{
 		.compatible = "samsung,s3c2410-adc",
@@ -518,6 +579,9 @@ static const struct of_device_id exynos_adc_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-adc",
 		.data = &exynos7_adc_data,
+	}, {
+		.compatible = "samsung,exynos-adc-v3",
+		.data = &exynos_adc_v3_adc_data,
 	},
 	{},
 };
@@ -719,6 +783,12 @@ static const struct iio_chan_spec exynos_adc_iio_channels[] = {
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
@@ -885,8 +955,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	mutex_init(&info->lock);
 
-	ret = request_irq(info->irq, exynos_adc_isr,
-					0, dev_name(&pdev->dev), info);
+	ret = request_irq(info->irq, info->data->adc_isr ? info->data->adc_isr :
+				exynos_adc_isr, 0, dev_name(&pdev->dev), info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
 							info->irq);
-- 
2.17.1

