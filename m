Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52DF48D7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiAMMZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:25:57 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59734 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiAMMZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:25:07 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220113122506epoutp048983460b078217b193f96a3729e52bad~J1BB2XMVu2753527535epoutp04B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:25:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220113122506epoutp048983460b078217b193f96a3729e52bad~J1BB2XMVu2753527535epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076706;
        bh=K8vTbIvFIBqHtyyqH6gBJua5O8SlNOOefAJIAr14Cl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHNBy2aKz0QjFpiYdBn3z76ataNtd5dBWQbkKH8wnTW5I74A5vNhfqsOALjjb0LDC
         btar4iYmPSrOtzQtuHNdQI16jE8CTk3Jftm41Qvso9hQMy4s9O4TXcR/r/e15WMrQR
         r808U/IIrf1Xz9PpW/BDgDaz1VJFdwirL5yqwbQ8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220113122505epcas5p1c815dc2d2ae118cae897ce96e82e58b7~J1BBNhJCe2652426524epcas5p1g;
        Thu, 13 Jan 2022 12:25:05 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JZNt65JQYz4x9Pp; Thu, 13 Jan
        2022 12:25:02 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.D6.06423.E1A10E16; Thu, 13 Jan 2022 21:25:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220113122502epcas5p37747b0c5c242c0571d294b9245963a1c~J1A94d_951006210062epcas5p3p;
        Thu, 13 Jan 2022 12:25:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220113122502epsmtrp28d725e966cfd99cee4a4c476022a6bf5~J1A95ADUY3235332353epsmtrp2d;
        Thu, 13 Jan 2022 12:25:02 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-3d-61e01a1ee6cf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.B8.29871.D1A10E16; Thu, 13 Jan 2022 21:25:01 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122459epsmtip2e5b4002f52af13c0bc060d4cb53c7683~J1A7RzPuN1246812468epsmtip2J;
        Thu, 13 Jan 2022 12:24:59 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Aswani Reddy <aswani.reddy@samsung.com>,
        linux-fsd@tesla.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 23/23] clocksource: exynos_mct: Add support for handling
 three clusters
Date:   Thu, 13 Jan 2022 17:41:43 +0530
Message-Id: <20220113121143.22280-24-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmlq6c1INEg/VfRCwezNvGZnFo81Z2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lktHl//w+Yg4LFm3hpGj1kNvWwem1Z1snncubaHzWPzknqPKyeaWD36
        tqxi9PjXNJfd4/MmuQDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
        VFslF58AXbfMHKAvlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
        6Xp5qSVWhgYGRqZAhQnZGTeXv2cqeMJeseXdDtYGxn1sXYycHBICJhK7p/eygthCArsZJT7N
        re5i5AKyPzFKtK34ygzhfGOU+DF9GSNMx7PDG9khEnsZJe6+7IFyWpgkVrW3soBUsQloS9yd
        voUJxBYRcJO40djBBFLELNDOLHFnwl4gh4NDWCBS4tgqc5AaFgFViUu7v4HdwStgK/Fx2SGo
        bfISqzccYAYp5wSK312VBzJGQmAph8Sir5dZIWpcJM5s3swCYQtLvDq+hR3ClpL4/G4vG0iv
        hEC2RM8uY4hwjcTSecegyu0lDlyZwwJSwiygKbF+lz5ImFmAT6L39xMmiE5eiY42IYhqVYnm
        d1ehOqUlJnZ3Qx3gITGpYys0FCYwShw+e419AqPsLISpCxgZVzFKphYU56anFpsWGOallsOj
        KTk/dxMjOGlqee5gvPvgg94hRiYOxkOMEhzMSiK8/UX3E4V4UxIrq1KL8uOLSnNSiw8xmgJD
        bCKzlGhyPjBt55XEG5pYGpiYmZmZWBqbGSqJ855O35AoJJCeWJKanZpakFoE08fEwSnVwNSv
        NeNB7xGtNb7FB1o3Tvt7YPPEVVFNN6b3HGBTWc6437VJTGWmMjPvC8aNSuFLyh7siAyxzpNI
        6MwX/3S+w3+zv8GKxPlxNb/38Mr9Y+Xx2SfI8OxH3NrMvhmdrw9X5hycHPlXnuEOR4tfZaT5
        x45VJrnZ55/ZPLOZwhInxmTEIece9Mpb4FbcFm+dOeuYeHZqGSZqhdotrGMKyZzje9hn6cGL
        eY/0WPa/3ZLyJVRq62GTLIZzj/5zznp5vo3zuRbrnAdtfiVv1x5iyUv6osnRFtaq7SQZ7bm5
        6r/omtWzzBLS7LJeZ8qaBu2/tKBMdEdRX9VDWbfX226fk33m9yElUWrada438+sKFzRzKbEU
        ZyQaajEXFScCAPi3N+0jBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvK6s1INEg32zVC0ezNvGZnFo81Z2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lktHl//w+Yg4LFm3hpGj1kNvWwem1Z1snncubaHzWPzknqPKyeaWD36
        tqxi9PjXNJfd4/MmuQDOKC6blNSczLLUIn27BK6Mm8vfMxU8Ya/Y8m4HawPjPrYuRk4OCQET
        iWeHN7J3MXJxCAnsZpR4cfAfVEJa4vrGCewQtrDEyn/PwWwhgSYmia+7TEBsNgFtibvTtzCB
        2CICHhJt/+4xgwxiFpjOLHFg2zeWLkYODmGBcIn9fZ4gNSwCqhKXdn9jBbF5BWwlPi47xAgx
        X15i9YYDzCDlnEDxu6vyIFbZSJx7tZ5tAiPfAkaGVYySqQXFuem5xYYFhnmp5XrFibnFpXnp
        esn5uZsYwQGvpbmDcfuqD3qHGJk4GA8xSnAwK4nw9hfdTxTiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBKVtCMUj4/q1jm4O6V9st4F3CH1lg3CARo/FO
        Jy013OjaW8fFFftlHos+u5bFsHSDFFdfnG3U3s7FvK3T0n+7nzSMuBWspW77sXu+/7LLU36L
        Hk566KD5beua4FVfBJJ/CkvFS3IY3WEIanbeJ/Poh9PZvO//2q8v2cFpsqE/yv5U7I2mvnmW
        Z0Kskq5Es6eFm8yblnWa50Lb96abbE/abh1JfX/5lZF77ZXeQxskgpMlg91P/apP6hafL/++
        8/n0J1krjz/ZqGi8SLZUXH/67Ls2zyz37b+yzGAOv9viWX71nOdXRz4ra/KSramsnXFiy1TG
        WVb68yNLuW559Xoz+t7/HDNxO9OUlcopfUttlFiKMxINtZiLihMBC8F3kOcCAAA=
X-CMS-MailID: 20220113122502epcas5p37747b0c5c242c0571d294b9245963a1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122502epcas5p37747b0c5c242c0571d294b9245963a1c
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122502epcas5p37747b0c5c242c0571d294b9245963a1c@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswani Reddy <aswani.reddy@samsung.com>

This patch adds support for handling thress clusters
(upto 12 CPUs)

Cc: linux-fsd@tesla.com
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 5e3e96d3d1b9..ba3af940a687 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -78,6 +78,10 @@ enum {
 	MCT_L5_IRQ,
 	MCT_L6_IRQ,
 	MCT_L7_IRQ,
+	MCT_L8_IRQ,
+	MCT_L9_IRQ,
+	MCT_L10_IRQ,
+	MCT_L11_IRQ,
 	MCT_NR_IRQS,
 };
 
@@ -89,7 +93,7 @@ static int mct_irqs[MCT_NR_IRQS];
 struct mct_clock_event_device {
 	struct clock_event_device evt;
 	unsigned long base;
-	char name[10];
+	char name[11];
 };
 
 static void exynos4_mct_write(unsigned int value, unsigned long offset)
-- 
2.17.1

