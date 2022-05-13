Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC652628D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380555AbiEMNEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380545AbiEMNEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:04:07 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F078A45AF6;
        Fri, 13 May 2022 06:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gb5uyKZCnZjoD/Ymd50jRBjReqnUGVUxzwvriwHNPUCkzUbYz7wS7AUApwkBxa43OhZ9sra8vo+liRkglswqfO0PmfW2DgQ6UYEYKfYhvqFo6L3n0U4gSb0Ug6P38GP/YU9kzt4fT0Ufo+brI5+1/bEqRsmzaKonyFAzuJUvlA/UD8/nI7t/0iE7PJ1QxlpH68IYHDCYtcvuhVOq9XhHBk9aleDRWo8UdFhIUY3tns4lb91ryUDGlaSoEsKx3Cv1zGJ6FJYRdql9Blfg9MSideGJZrChUvKhPfd98z7iIvHorugo0o/TahQ1m32CkJP8CuYxop+ro8SSTg7njXcSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ik11G2VyJUqugugwqF9W5siLNxGa1QGTuJ6/3rdCcM=;
 b=QngXyeu7ywIriKneUc1WShEwZvSBxQeIyFx2UDzKgIo+RXelnAD4fAWuxSqj3+Zy8eGN7oNyLl/ywJyHStaJdGxHd+GXEfZp1CAiyYMiIKKhlx0FTqwS3Ulh7mQ8bxn1sXrqv+gvroW7r8UQO6Lsd7G9G9H1BNJBmEpeJcalN+H1Mfd9VmoVhZ7umQRzJbJxdqBDSAi7N1skAVMbWPhj+E872X0Gu35qjbpa7jMxodgcVey3hawRiH90spNJA+C7Ylf+/taYR5MRqmocUHym3mJtLz+0H/gopbZGriH54PvlpudkDSOvkcZblL4ZpAG2w0+EPrHsXrUqPmuAN+aAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ik11G2VyJUqugugwqF9W5siLNxGa1QGTuJ6/3rdCcM=;
 b=OumOx9vgNsKDQQ07L4s3L/hkl0n9pXFzqKRjx3/dK3ekb+xEGGfuVpi4agdtGHP8UBJx/XCPD9nzwoaGUrugFgXADaqw7d8cxmFzhRiM6YYJBHiD1Eudk5CfX+5cD70D/9MOIN+ZXdGvpDOUZ1B0zeG+waz7Ds43MAtdZvT3QeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by KL1PR0601MB3733.apcprd06.prod.outlook.com (2603:1096:820:16::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 13:04:00 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5227.027; Fri, 13 May 2022
 13:03:59 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] drivers: spi: spi-au1550: replace ternary operator with min()
Date:   Fri, 13 May 2022 21:03:33 +0800
Message-Id: <20220513130333.58379-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::36) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbf83d4e-8479-4b19-63f8-08da34e10ba3
X-MS-TrafficTypeDiagnostic: KL1PR0601MB3733:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB3733E758CEB0903FA38FA75DC7CA9@KL1PR0601MB3733.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBeD7XhSaZZk0ei39cKytrcQZzbycNfoDRickZ5n5dL6Z+I+ZtSANqYeJ4PRor39kQ7j4crxkNEIHHkAXEVDHiMXTvqVRpBrgJA3iCmFUpyHaInMrAsvbV/CSP7Y5k8li5EVo9HVMYD/53giZ30LeG8tqGh1tJrFPUtGhpyzQJjgDTQxOFvPprHbNlk1EZ4Kc/VOgbKwnXvF0rH3hgVhNHRLK/M+z2Q4tqZICRUYWgwnI1k7wGN5yVDXlxht79qm1rEQfrzJ1yKeUUOaGStwRGuuegr45Dzx3TDxqtv1gGLeLTRwVtNp2WO2hJw1bzG6D0iE7MeNNRsz66o6SFaWRa5+PbRayEQssBuvq4EqPRsmVsjbUvwUOc9wPvMbgJC+4f/fr1lhz3q6/iBjoBrG0Z5lhrIETmslY284q3iCTpcNyq1Owh3GZ+Z1C8jCJZfHP626Z5PaRgeqHQaW+8YIrTulbMY402BDs7icnD2tK3fROEHo0PfI75cyAWDBSq7ZM4JgvJHNSdd6jl0+GrBnqEPOSqhHvb8PTnyockw3IRQ6VWouFIt2Ca3PUPtePSxe0+J49xfofEybgwCWYu0FE2+KOp3GG24gpQW16GVkKbwJZWUuqwhBfivgrCl3E56ks9xfxtJl5bDDOkK8y23vhSycGA1m2Z1qx5HsLxGIzm1kfFI1DPU1CPhUaFQ8hVVt1dZqrt7vENhEk2R3B3GTHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(26005)(6512007)(5660300002)(186003)(83380400001)(6666004)(2906002)(52116002)(8936002)(316002)(38100700002)(38350700002)(66946007)(6486002)(66476007)(66556008)(8676002)(36756003)(86362001)(4326008)(508600001)(2616005)(1076003)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1jh/lPyUlWUboA7H9R6AjdmZ/Jjkvz1ub2b69Oo6rQ8nGMNvhLuu0NMRGijd?=
 =?us-ascii?Q?QUvXGZ5QqKWwti2Pr6+3pTjEEaWat7etsuCNz56tduflMbcFD9SqZr9++eh1?=
 =?us-ascii?Q?YHuL4YDf9mPJX8G/DbjuhKqO6AF/jX5i/Fo/n9zD5OaBN+EcYB3NDKBBMT5S?=
 =?us-ascii?Q?o/5RARJffnlo5BBeZMzE1m3AMAmx1uuibgV401gE2tFDkJ7gmQsRFyVl/csH?=
 =?us-ascii?Q?Yp9MkXn7/gy2h1cVonc2QbDj1MeXhcWhJdVCkhxQiE4dyVWjQuwMK4YfoJXP?=
 =?us-ascii?Q?hzEttb+uavJO6eS1YWDlng9tISz+MU6gaSpSFUV9q1lpmNRtccjcGS/3gbLo?=
 =?us-ascii?Q?lHm04sXntgEZ6jHWLBWkIcy1uZfxSUInlg4cMrK23IFIompORQTJdJJt6Ipp?=
 =?us-ascii?Q?XUnSe5r+mRCyLgxXcqkwzGbZaqiVh0lx7tGbHHh3wBxX7uiJSy+2PKia3ydb?=
 =?us-ascii?Q?jixlu/tZ/1yU6EcVnPd58+F9xmXrLgt3Z8ysH7hnvQhAAsbTBc49lmzjOR1y?=
 =?us-ascii?Q?jJx77T1VwfUdNlDWKsorI8mzBXI7470ZfhM4v7OnEhpGhd7cKcIM6+0niupe?=
 =?us-ascii?Q?xBgCf9mTk78lvyV0bkojLnIILTaF/orAGA4aUjm9h2nSfjVENmxqtyltnXIR?=
 =?us-ascii?Q?YJTkdy8OBqD3u3oIDk814lgo9dpF5m8l+l+KJYD+pqw8fsERt2NDELCvjMVJ?=
 =?us-ascii?Q?t+4GX/Rt+XiYtlVA8fAWL/LyxW2OpGuO0XneiodreLABgYhotYYs4xR2m7/L?=
 =?us-ascii?Q?IXJ0UUpHJdQe3Bkb7JqNRfjUMDMKkGF+OVFoYfuvtsZurMJDgPbBQUdYdYtv?=
 =?us-ascii?Q?4ZmW/iubN5RrP/Ph4xft8YuzW9O+MgO0z91O+BNHFjcmZpNvGyvOQG5apaZh?=
 =?us-ascii?Q?9aXsdJ8+bgy9o8862Fxu+oIKwcHRLvQw9u5gyUkth4fXlKHhvNPfvZTzInGm?=
 =?us-ascii?Q?x76jjDCxqFL/k2rnUzxVdsdanHH+P5KuY8gUqx8CxNIw+Z8UhAJQuBSyPwOa?=
 =?us-ascii?Q?vYtGMS2Jzhk3zWoOwmDWjQ1uKT5Y0mAD1/QZviRdhe3eaWWmnDj8BG9bkwal?=
 =?us-ascii?Q?7qQ9InUYyUSeML+fPNj87CBsVBUz94Y3SvntRE63HS3bz8hb679C7utVxhGw?=
 =?us-ascii?Q?TcGLAxWBMQp4OTpPQA8zwKaO+lOLOTQhHML/4tjZukfxHkBv9bpiJ8jSdaVn?=
 =?us-ascii?Q?ortFjxLax86Vk2zze+98NNFcsV71iu8ANmBINM84lOq7K3VfjpBhtkBtbUmR?=
 =?us-ascii?Q?U0SsDxBvwVcdmMWH4SrD/yII12wcAQ9IyyjksvLia4YFMQHEhxQBBz4ztuYu?=
 =?us-ascii?Q?sAhOB14aRV5CBlP7dTu1fLICUqTClZ4lA+yKT3q2oUrhu2ZQKjyp6PK+0CRe?=
 =?us-ascii?Q?fMQPjqErPB521eEtJmZuKL4IqVoq+AwvWYZfBvRAoERWoccPvzmujTsnqGxu?=
 =?us-ascii?Q?a0RnxzQCvanvGV1wwD0//fjunzPB9c9VLb2e704n4s5bcsq4N6arzH+MGwNh?=
 =?us-ascii?Q?dLhxVT2Y7c7XzXjJ/Y+DXZZlwrTnsR/94MXLiV3A/cPZaHMuMbypWvunnYUO?=
 =?us-ascii?Q?+eI+S4vKoa2Qz9+CQM2gZ9fkLTrLOau6i+mZOuShR5dvqvGy/tw8STowZl55?=
 =?us-ascii?Q?fmzL+AN1RFCmF79vQp/mXOOgBPzR2SgAPCV88N+mmhpqiqgj5zpfAn7p7svo?=
 =?us-ascii?Q?DnPM418ZV5q4xaUnK8IuVXpCn50BaUYA3Ps/p4PQHQs16VyyLUT1lwEl+lm6?=
 =?us-ascii?Q?H5VwhP/Z9Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf83d4e-8479-4b19-63f8-08da34e10ba3
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 13:03:59.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFgK5SMjJ6O9YDtXymZUXJhr/wN8KzVAdCGt1zb6Oc0cl8ahde8HfXvj0SJ93qG16uREV2BQOpTTWfFtioZpaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3733
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

drivers/spi/spi-au1550.c:408:21-22: WARNING opportunity for min()
drivers/spi/spi-au1550.c:542:21-22: WARNING opportunity for min()

min() macro is defined in include/linux/minmax.h. It avoids multiple
evaluations of the arguments when non-constant and performs strict
type-checking.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/spi/spi-au1550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index 4b59a1b1bf7e..e008761298da 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -405,7 +405,7 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 		dma_unmap_single(hw->dev, dma_tx_addr, t->len,
 			DMA_TO_DEVICE);
 
-	return hw->rx_count < hw->tx_count ? hw->rx_count : hw->tx_count;
+	return min(hw->rx_count, hw->tx_count);
 }
 
 static irqreturn_t au1550_spi_dma_irq_callback(struct au1550_spi *hw)
@@ -539,7 +539,7 @@ static int au1550_spi_pio_txrxb(struct spi_device *spi, struct spi_transfer *t)
 
 	wait_for_completion(&hw->master_done);
 
-	return hw->rx_count < hw->tx_count ? hw->rx_count : hw->tx_count;
+	return min(hw->rx_count, hw->tx_count);
 }
 
 static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
-- 
2.20.1

