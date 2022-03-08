Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0464D16DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346696AbiCHMIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346678AbiCHMIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:08:11 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89C12FFCB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:07:13 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220308120711epoutp0483a038eadefa1889d6a95e6ad7586266~aZmzz0k7F3138531385epoutp04N
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:07:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220308120711epoutp0483a038eadefa1889d6a95e6ad7586266~aZmzz0k7F3138531385epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646741231;
        bh=lEcoaPQ0wXcqoYAXTOO0tu1gYfLWrks8XW836Y3b+ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsCS/+PfU4+VcpLMeqZyL4IRziA+ZrDtDLtLPjlnXqlW0cbMohZ5cbNHl24pydJ+c
         nM+i4Rnxp03VfdbEvjJ0iOO/Xr5dbXpLfzptY1A0+NsuK7Fo+M7KDxVoIHBwTTp76Q
         Bv5bQLVxBB/uAxcwXGsFyntEpTui/K2q66Tp/bAo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220308120711epcas5p1807eac5e4de9c0f10ef5668f7261fb93~aZmzXll0Q1111211112epcas5p14;
        Tue,  8 Mar 2022 12:07:11 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KCYwV3DmLz4x9Q1; Tue,  8 Mar
        2022 12:07:06 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.C6.05590.AE647226; Tue,  8 Mar 2022 21:07:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220308120705epcas5p21f5cf07d2ab98f89cf87fe3b9fd595b2~aZmuTgLS52571125711epcas5p2M;
        Tue,  8 Mar 2022 12:07:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220308120705epsmtrp27766982a47bfd56b961a818cc47fcde7~aZmuSlDcb3197431974epsmtrp23;
        Tue,  8 Mar 2022 12:07:05 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-42-622746eaae3f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.8B.29871.9E647226; Tue,  8 Mar 2022 21:07:05 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220308120703epsmtip14761939bdaf6e1f980febe8da9f3a2a2~aZmsQcw4Z0869908699epsmtip1d;
        Tue,  8 Mar 2022 12:07:03 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        lee.jones@linaro.org, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Aswani Reddy <aswani.reddy@samsung.com>
Subject: [RESEND PATCH v3 2/2] spi: s3c64xx: Add spi port configuration for
 Tesla FSD SoC
Date:   Tue,  8 Mar 2022 17:46:40 +0530
Message-Id: <20220308121640.27344-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220308121640.27344-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTQ/eVm3qSwa25ohYP5m1js1j84zmT
        xaHNW9ktpj58wmYx/8g5VouNb38wWdz/epTRYsqf5UwWmx5fY7V4+Crc4vKuOWwWM87vY7Jo
        /HiT3WLR1i/sFq17j7A78HvMauhl87i+5BOzx6ZVnWwed67tYfPYvKTeo2/LKkaPf01z2T0+
        b5IL4IjKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB
        ul1JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBk
        ClSYkJ3xsH8pY8E57oqjr06xNDA+4Oxi5OSQEDCR2PF6I3MXIxeHkMBuRokpu9qgnE+MEis7
        jjOBVAkJfGOUuHuOH6Zj8ps/TBBFexklJn1byQbhtDBJ3DzyjBWkik1AW+Lu9C1g3SICbhI3
        GjvAbGaBT0wSC5fmg9jCAtES7/ZeZQGxWQRUJZYdW8cMYvMK2Eh8nLiZFWKbvMTqDQeA4hwc
        nAK2Eu+nOYPskhCYyiFx8f5uFogaF4lzU+YzQtjCEq+Ob2GHsKUkPr/bywbSKyGQLdGzyxgi
        XCOxdN4xqFZ7iQNX5rCAlDALaEqs36UPcSWfRO/vJ0wQnbwSHW1CENWqEs3vrkJ1SktM7O6G
        OtJDYvGOadBwm8AosXvWVfYJjLKzEKYuYGRcxSiZWlCcm55abFpgnJdaDo+m5PzcTYzgBKnl
        vYPx0YMPeocYmTgYDzFKcDArifDeP6+SJMSbklhZlVqUH19UmpNafIjRFBhiE5mlRJPzgSk6
        ryTe0MTSwMTMzMzE0tjMUEmc91T6hkQhgfTEktTs1NSC1CKYPiYOTqkGplmOVWsWL36s9XzK
        Sw0OvdiglVzaDzb5cj9N92qY8VD/cJLU3JCWs48vNpxgS5Let+3izUmFt5hjcoPKn8qYspWy
        pYkfze29NmEe3/PKy67P13snRswIrb5q9WF+8qp/Zd3mG5LvlV7lLL579G66xNsFK8yCLp88
        waf0rDSU/UWC/oX9l/IVvBd+teA8ZuF36toL7biEjRerddImMz6SOR+znMXkpcx1m87v737M
        +nrOaWqggpmzW3HFwyWrvOKLLmzZ2Tg9i7n1UZRl9GpudoP1UepndH6XJHKV9ckrrVdtmqlf
        4NrilJq0OGPD1YAVXleNe1e2Xni8/Nfq/pXShTtK3u6SkmFuca8O5RfbqMRSnJFoqMVcVJwI
        AOG9wGkZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnO5LN/Ukg5ddZhYP5m1js1j84zmT
        xaHNW9ktpj58wmYx/8g5VouNb38wWdz/epTRYsqf5UwWmx5fY7V4+Crc4vKuOWwWM87vY7Jo
        /HiT3WLR1i/sFq17j7A78HvMauhl87i+5BOzx6ZVnWwed67tYfPYvKTeo2/LKkaPf01z2T0+
        b5IL4IjisklJzcksSy3St0vgynjYv5Sx4Bx3xdFXp1gaGB9wdjFyckgImEhMfvOHCcQWEtjN
        KNG1KgUiLi1xfeMEdghbWGLlv+dANhdQTROTxJ5nV1hBEmwC2hJ3p28BaxYR8JBo+3ePGaSI
        WaCBWWL9jn5mkISwQKTE9hV7GEFsFgFViWXH1oHFeQVsJD5O3MwKsUFeYvWGA0BxDg5OAVuJ
        99OcIQ6ykZhxpZ91AiPfAkaGVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYweGtpbmD
        cfuqD3qHGJk4GA8xSnAwK4nw3j+vkiTEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTE
        ktTs1NSC1CKYLBMHp1QDU6Xi0rBX81S3sxbnKTusN8pvuL2b27697JfuVEH/luPyDf3ycziY
        IuREWkwWnr34Rmjrd/UaNkPVazHH2hTn2sQfLIzYXHnw64aIhmczzhlfrcrd+J55U861NwLa
        MbntXw+rSz/b9WEnGxP7owfbt+15yZ53iqvs/RnFie6btwZU5brmiKw+eb13/40dDbPtpCzr
        T566p7Ynu/3uTXvVvdv71Mw+L1pvyLV76xPfnhfHxab0MHTmrTrZyPU2/KyMV9L0OQGuNcsr
        zLqSdZJnCwvbbb6y9qOfyN4fjYU6JrsneaTyvf3clWTWoeiv8k01pXhN5N9I5S7GuC9Cmmtq
        vW95TZkxS+LIE1sJ3tRwJZbijERDLeai4kQAwrXRxN4CAAA=
X-CMS-MailID: 20220308120705epcas5p21f5cf07d2ab98f89cf87fe3b9fd595b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308120705epcas5p21f5cf07d2ab98f89cf87fe3b9fd595b2
References: <20220308121640.27344-1-alim.akhtar@samsung.com>
        <CGME20220308120705epcas5p21f5cf07d2ab98f89cf87fe3b9fd595b2@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible and port configuration for spi controller
for Tesla Full Self-Driving SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
---
 drivers/spi/spi-s3c64xx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 386550fca81c..423518bf0270 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1440,6 +1440,16 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
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
@@ -1470,6 +1480,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
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
2.25.1

