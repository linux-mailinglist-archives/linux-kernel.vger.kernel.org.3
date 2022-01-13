Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48A248D7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiAMMZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:25:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:25418 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiAMMYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:42 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220113122440epoutp033339aba6ee10bae6d117377c9db7a6b3~J1AqJu1si1645516455epoutp03t
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220113122440epoutp033339aba6ee10bae6d117377c9db7a6b3~J1AqJu1si1645516455epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076680;
        bh=VIaQqRCr+oTNVX62Of7/5Bg3BVzzJ2OXwvsaDwHJoBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7I1SZpy5GGBgA8DVEOoelQw7E6IMkB2DYTNAZn2hrFliMCyVJBuqjk6ypseOFC0r
         T3xkCtE7l04S9xaJd0fR40gx/eVHeXv6idN1Ei86rZjhdRbiYmHxNN4D8yI7tSSv79
         z1EcHxv3bBGUKxWhTIMhVEQyQlcze8SMbeXiZARM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220113122439epcas5p1af66aa08d133203743b8852200f06b73~J1ApUOroK1969919699epcas5p1Z;
        Thu, 13 Jan 2022 12:24:39 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZNsc1ydtz4x9Q2; Thu, 13 Jan
        2022 12:24:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.61.05590.30A10E16; Thu, 13 Jan 2022 21:24:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220113122435epcas5p18e6a2699f193b9e1287588278a570235~J1AlaPrsd2652426524epcas5p14;
        Thu, 13 Jan 2022 12:24:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122435epsmtrp1762b1afe80a59972bc8af2f64525ce2e~J1AlXQ4SV1991219912epsmtrp1q;
        Thu, 13 Jan 2022 12:24:35 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-2b-61e01a036b7b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.A8.29871.30A10E16; Thu, 13 Jan 2022 21:24:35 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122432epsmtip2b951016c0b47fc016c330f3f43374ced~J1AiHp_WF1131511315epsmtip2O;
        Thu, 13 Jan 2022 12:24:32 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, broonie@kernel.org, linux-spi@vger.kernel.org,
        Aswani Reddy <aswani.reddy@samsung.com>
Subject: [PATCH 18/23] spi: s3c64xx: Add spi port configuration for Tesla
 FSD SoC
Date:   Thu, 13 Jan 2022 17:41:38 +0530
Message-Id: <20220113121143.22280-19-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmli6z1INEg12fDSwezNvGZnFo81Z2
        i6kPn7BZvF/Ww2gx/8g5VouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVk0
        frzJbnHq+mc2i0Vbv7BbtO49wm5x+E07q8Xj63/YHIQ81sxbw+gxq6GXzWPTqk42jzvX9rB5
        bF5S73HlRBOrR9+WVYwe/5rmsnt83iQXwBmVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
        qGtoaWGupJCXmJtqq+TiE6DrlpkD9I+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAl
        p8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj1M9NLAXzuStOTzvL1sC4mbOLkZNDQsBE4lBb
        FwuILSSwm1Gi4U1EFyMXkP2JUWLLpz9MEM43RomPT24xwnTc//uSHSKxl1Fi4onTzBBOC5PE
        /z/3wKrYBLQl7k7fwgRiiwi4Sdxo7AAbxSywg1ni5PUlbCAJYYFgiUNbT4EVsQioSsz6uwPM
        5hWwlZhyt4UJYp28xOoNB4A2cHBwAsXvrsoDmSMhsIVD4tqtJ2wgcQkBF4l//50hyoUlXh3f
        wg5hS0m87G9jhyjJlujZZQwRrpFYOu8YC4RtL3HgyhwWkBJmAU2J9bv0QcLMAnwSvb+fMEF0
        8kp0tAlBVKtKNL+7CtUpLTGxu5sVwvaQmPDsMQskFCYwSmz/f5x1AqPsLISpCxgZVzFKphYU
        56anFpsWGOellsOjKTk/dxMjOJFqee9gfPTgg94hRiYOxkOMEhzMSiK8/UX3E4V4UxIrq1KL
        8uOLSnNSiw8xmgIDbCKzlGhyPjCV55XEG5pYGpiYmZmZWBqbGSqJ855K35AoJJCeWJKanZpa
        kFoE08fEwSnVwCT5rYTh2LeWQzFnlynOUXgtNSf1eBKffOrq+kc18jbz97+01X+jevrBqXVt
        NqK/luR/UzF4WKfJdTImdePEiMZJGuttGgtrdusFPNi54mtSvqhVQ/O/L8w5p5e8WxnW++Ng
        OsP+VTqpd2SnbbiyKZi92blq/f6gc1OuHmp+PG/r3gbLT7Wft/5s3evZadfTKhMx333nk+dx
        M7fonZeW0PnYdGfC4xeCj6MkY4y7FVosp16KNKxdyXamo1ZNutrP8LZKV+fdj3x1ksIOU7f6
        yrwMalLr++ji05X42Sr1yIeYqXwGn9s9zPrX13coy0StZ/T6mfko2NrUUdxUUnYui4ToZJYz
        nyuNFtc3NElvVmIpzkg01GIuKk4EAGhpTdAtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvC6z1INEg39/BCwezNvGZnFo81Z2
        i6kPn7BZvF/Ww2gx/8g5VouNb38wWUz5s5zJYtPja6wWH3vusVo8fBVucXnXHDaLGef3MVk0
        frzJbnHq+mc2i0Vbv7BbtO49wm5x+E07q8Xj63/YHIQ81sxbw+gxq6GXzWPTqk42jzvX9rB5
        bF5S73HlRBOrR9+WVYwe/5rmsnt83iQXwBnFZZOSmpNZllqkb5fAlXHq5yaWgvncFaennWVr
        YNzM2cXIySEhYCJx/+9L9i5GLg4hgd2MElfPb2SFSEhLXN84gR3CFpZY+e85VFETk8SLlS1g
        CTYBbYm707cwgdgiAh4Sbf/uMYMUMQucYpZ43dsAViQsECix49k9sKksAqoSs/7uAGvgFbCV
        mHK3hQlig7zE6g0HgJo5ODiB4ndX5YGEhQRsJM69Ws82gZFvASPDKkbJ1ILi3PTcYsMCw7zU
        cr3ixNzi0rx0veT83E2M4EjQ0tzBuH3VB71DjEwcjIcYJTiYlUR4+4vuJwrxpiRWVqUW5ccX
        leakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAtCixjOPV2+lOFV1NfzZN2rDW
        kpWPaeETiXa/LtePN1cYpyW/WyFwRs5DmDNGOaH5bcBFATmJcD/+jxK/MmQj782sWMHfkrb3
        kz+DdEi3YDMT7y3RYPk8tUU+H5UCNIz2882b+PvHC1leCa9vHmE3IpgbvnHcXybb0/DyJfNB
        8WZB1+Pf7jvaOgYUVVzN8ZxstX6ruERbk9fpD+pxFS+kp7/Qm/Qh4NYLEwO9o14CLSl5Lu2R
        ttdaOk/l3WpLXq+17rt78JQJ3S9CpHa4nnzzM/zNT2vPWo8DxVtXsq69zhv65xavgmhfuPTC
        z22Z341kldRP8DEEhPry3ssQkFo+J2KSc37qurzyT96L/yixFGckGmoxFxUnAgDiIswg8wIA
        AA==
X-CMS-MailID: 20220113122435epcas5p18e6a2699f193b9e1287588278a570235
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122435epcas5p18e6a2699f193b9e1287588278a570235
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122435epcas5p18e6a2699f193b9e1287588278a570235@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compatible and port configuration for
spi controller for Tesla Full Self-Driving SoC.

Cc: linux-fsd@tesla.com
Cc: broonie@kernel.org
Cc: linux-spi@vger.kernel.org
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8755cd85e83c..8d0c1f03ab7a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1442,6 +1442,16 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
+static struct s3c64xx_spi_port_config fsd_spi_port_config = {
+	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.high_speed	= true,
+	.clk_from_cmu	= true,
+	.clk_ioclk	= false,
+	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
+};
+
 static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	{
 		.name		= "s3c2443-spi",
@@ -1472,6 +1482,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,exynos5433-spi",
 			.data = (void *)&exynos5433_spi_port_config,
 	},
+	{ .compatible = "tesla,fsd-spi",
+			.data = (void *)&fsd_spi_port_config,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, s3c64xx_spi_dt_match);
-- 
2.17.1

