Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C9D57EEC0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiGWK1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiGWK1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:27:18 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2115.outbound.protection.outlook.com [40.107.22.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4987C18A;
        Sat, 23 Jul 2022 03:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7DxPNoCgpsHLd+42l6AA2Q04fyqN99Cmvl0YM5BkmzmXou18R0hkWI4wNHt+dkUPDipjZN8lGolH9/EXmGTsKMPje30Ms8m+xQYedXYof+ID2l5CX0n9KjJsUEomwjXynwLozncYQ1xHsuLjKwVIWOZdeCxUStmfuKh7HBlQqbyFH50LgmOFw1HQQAYMAidAPH3DjPSziGNzSrbi32TtnfIlOLBcPTFTmqfyUH4h2a2BpFY4r0yTSvy3KklxDAxdxFy/H5Ukhe+vBpCi2oRzBZnu7dheTq2mZPEmllyQLgAxIhMGkKftpdgL1RLZsjv2/OE6Pjyg9c3h+SBtU1vzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cryoGtIWz9oRFD9UI/nfm+Bb73nkLb7jr06eTR9PFHk=;
 b=LSEqhzScU6U6/QPgqwSQgJiFQ5soYMUBHZ3NHCpb1X5oTm5713CsQg1gQ59ZKsD0Px5ThCTtpps88Z8lK3PqlEutBa15vppu5NY/0ObEP3O8VUtPiMwGVhWNUBNCgsXX33lx2Sn/HxF58bTzy07VM1bySZO4a6F8u+zyP4sZMA5k58/DHXsnCl++lMDmw+JjsxoAU5/HE4LgeC8FP45AtRCmmSKbK3pjxbWzKHIngdqapmNVicSFjt1nzVTDYMptEgZRbipXfds+a1X62786GRUgWnU+Xy4QQMtWvkcWsTOpfD/ncVdPMb5ZBPAzUpgAlCOgZrvoknNskk3ytBRPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cryoGtIWz9oRFD9UI/nfm+Bb73nkLb7jr06eTR9PFHk=;
 b=yL/omAUrIZAt45RdhMf2LDRVZXzXIcgyHw6T+RgbaDuTApOfBMx5/Hqa188TFSDqXy+yFHNb0ZXSFU1KYuu9NVjZCEZJ6gU7GatXNQa7hQnb9dJTJafZwO1SiqkumZDf/I8O156ck62ZvtfE0iTxaoH0ByR6AxOjJA2+/I0vMpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PA4P190MB1327.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Sat, 23 Jul
 2022 10:23:30 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76%6]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 10:23:29 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Noam <lnoam@marvell.com>
Subject: [PATCH 4/7] spi: a3700: support BE for AC5 SPI driver
Date:   Sat, 23 Jul 2022 13:22:37 +0300
Message-Id: <20220723102237.10281-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30fb80fb-9cd4-46df-51e8-08da6c95633a
X-MS-TrafficTypeDiagnostic: PA4P190MB1327:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sr0ojDsGsW9EGKyZfZs96LpZzwDjubAyZBoykYS6uyNEjCiLyDKMQc6EFV0LtsZAwRDs7fW5fxK/m8qjsATJLPj4ZcUuy8EFAKTIWkigNtgI/se7WumduWm8H/n16f/HWqHZrhj5HQ7i1mqiUv/075P/Fb/IF9A+HZvOP0MhPYU0L8+SqXIbp4bVscMBQdeJYqw/0xVS9GWGYPTF3RZmht//ztvaB4eo2RW/wGPb82l3Vf3GES/Bbertr2Z7IcPLfSdTASPbFtaIr4w6BPGpioQP1JDoU4XsRRsWGpyKF3qaofRVW2aqsxnuBTXytAnz9BXV9+JZB34t6cVxvQGkzlmjTf+sHd5sNY7AYLe/QJxHW26XORLP72o8ZIy6u3hNlar3NNdgEggd/I6ntDTd+11HHTJD2hVcxGzT0kb2sA5wc56IVGkiLCiwIICCU2djkyELhKvrgNB6YhGrrVjYFzgBmU3nWmHKNnWTbtixETRjZZ6AQ4RbUPgQwPLsMDA3eQgG+9HvyB3fmzUbxlkt11BvRUUx6j6P3drR9116+TnyCzHkeCgDIquycO1eKq9RzuuZBsBXJerQLyxerWTD1+zMqCifwpfL6aj6EqHGiO2x0LImX70ZVPWA5gEBtVOEiqljyPEb7emBJDPQuvTgB2+gYdk0oG9naOFzb9rDzUlgiXBUz7SL59pMV+AN+u9Y1XA6PAIPi0X6AdNQdDaXv+uPI/d22otxyqtxlqHZEg9yIzNjIeH+m+an8XoB2kSb1KpD8FhnKfN9dxl87yQZKvDN4mY2wJP5MYtA3Q+QHTrcsnJD+OfC5SgKw4qIiIXi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39830400003)(396003)(136003)(366004)(26005)(6486002)(6512007)(52116002)(6506007)(86362001)(478600001)(6666004)(41300700001)(38100700002)(186003)(1076003)(316002)(8936002)(38350700002)(83380400001)(66556008)(36756003)(44832011)(2616005)(8676002)(4326008)(66946007)(5660300002)(66476007)(2906002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mNcpkCZJgkxDKdyLCTEHqLjdli9l9OM+hUXViAmJ3RDFsZqKnl4A99TWwcFY?=
 =?us-ascii?Q?93cCgHq9Pw3oIH+2FdSiQx8Jea2IVvgQLeIem+xHE9bor8EIKzK682V0wS7N?=
 =?us-ascii?Q?3CgLeh8VrcbUOzaO7eH4QywCwdQl4VbdfTab8Pdx++STYaOYJ2vICvg+xMCy?=
 =?us-ascii?Q?bciGXBADxRk8jjbzSkm52xOMret2udB/P00sH8xlgbrvSkb4JWnI+OluIe3e?=
 =?us-ascii?Q?q89pOqzirWoZN7bbdZ7nL6UPiLakWdcDhWtWiamSJ1p33VdcA5NTMyDennkm?=
 =?us-ascii?Q?61bhy405kAVALbB7evkON0MwreFqs8nm2ydXWfThrlcRVAWT3GY2/ywivZEb?=
 =?us-ascii?Q?9YKDRXDhtXZPybMk8Y5zkXOu3kyX3Ii0oL5Fz0DgkqDcrvrB/WD7mH/fevu2?=
 =?us-ascii?Q?DnXiAvAE+uRbWJSH2qCoQ+e0VzBx1HTFbpdThFHxiWs1yIITgfrugKvYZ5Pc?=
 =?us-ascii?Q?/rTVh2TeZTFnrTCFBjVCjrSKl2s9EHNJ+bSS2luHN2Mnh8FLwxfupZSjG/TN?=
 =?us-ascii?Q?3BlHV24+fCb89nclRP7UW2FjyuA7VQ0Ee2ML7CHIsV74wunRWEl+GslicvRO?=
 =?us-ascii?Q?PcECn9oDq6EoAtrTbBFoXutqanMCxTS7dc/peHTWk0GN7R4LmWTU8DtYaRra?=
 =?us-ascii?Q?o60TWa12NIUyylrXa/iIaWv+Br8o7+W3HbqBeDh8IPTePF8bt3S+r+XDDAF9?=
 =?us-ascii?Q?eUti8ZF7p1BHaeAu6UFYajLyJ6n1GPr+YD/xCCalsWYg8euNbHWcW9lq/mVf?=
 =?us-ascii?Q?960nLaK4h/HwAQoJYs7jHaM7kI0i8whfQiih4EiH6ldtppRkBj/0SRC1B2Pg?=
 =?us-ascii?Q?3p9ccjwa0m9SbZ7FJDnhvK2TIFz6NV38Vhfjla7l0N8CNuGOW4P/gXEkjZFB?=
 =?us-ascii?Q?eyRdvVQLL7EAoLuh89Ae9T7+GFlAR0eJYbg2N2Z6KaNKWmLfbAgmoJtxHtBF?=
 =?us-ascii?Q?jbFl+c8LN5fbcRUrAixVtsyT9UgMjGFBXn1JcYQU4nCPAM+nft6K3rMjVJTg?=
 =?us-ascii?Q?UAtwDHJv8M+EqQCyMr39F2v6DtVZ+A1EFvlM5LrchKISg6T9DzTOH9VdE3o0?=
 =?us-ascii?Q?XkznrU4DSXVEKUuuRS+DXaW4ZlWycLgsURPigLRwJtNYdiLiCCdaybjbfdnk?=
 =?us-ascii?Q?zql6aWEn8U82pioLTr/NJJVElGITH8QENvLMci0loUnhyT5idkMxXu+18i3l?=
 =?us-ascii?Q?P2loScNgsIaACCs4aa/2BleALQ2BFNQ6cuXJXrjD+crDA5vsLxFNh/UYvIHy?=
 =?us-ascii?Q?BsGVh4jYa2uxjW2yek26pOkMUX0UcuzvSyhTRuTZgUGLNvLTGnK6xE9Pa2Lc?=
 =?us-ascii?Q?k0W9OkK6/EuWDFLDTBaIudRsVALjY9M8s9xMPpEw7+g+3+5JJu+fYZ8YIs/I?=
 =?us-ascii?Q?W2gH1SoXVfiZQLOjVCYFOEZxtNNSmU+Apw0OshRh9q6TQbWDe7jonvbcmktD?=
 =?us-ascii?Q?4KXmYNqvANN5v6Bmi6qzUhQwSQvq4DZK5wK+i1AktRep2KSZjZvicniKi5B6?=
 =?us-ascii?Q?EY1bism1vWyORtLv2FYlJTZj4i/YDJLMijO/lQar/p14wJKr4xqe4DcX3FVL?=
 =?us-ascii?Q?Adu1PHlqutdoJfHXe5gb2uoud+Yth295r9d8CU7bbKXge3Bfc3xIgrptM4qV?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fb80fb-9cd4-46df-51e8-08da6c95633a
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 10:23:29.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waUok7K4OEC+va61CNTdLkLILXGjCjgoQyxBf2yKY59+cRGO/wF5p/1RUgdHjTEIatQbn3qGAdFoTkbrpiYRnwxyp9iT4H26oVNgNQtJ1XY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1327
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noam <lnoam@marvell.com>

Tested-by: Raz Adashi <raza@marvell.com>
Reviewed-by: Raz Adashi <raza@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/spi/spi-armada-3700.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index d8cc4b270644..386c7959ea93 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -497,7 +497,7 @@ static int a3700_spi_fifo_write(struct a3700_spi *a3700_spi)
 
 	while (!a3700_is_wfifo_full(a3700_spi) && a3700_spi->buf_len) {
 		val = *(u32 *)a3700_spi->tx_buf;
-		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val);
+		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, cpu_to_le32(val));
 		a3700_spi->buf_len -= 4;
 		a3700_spi->tx_buf += 4;
 	}
@@ -519,7 +519,7 @@ static int a3700_spi_fifo_read(struct a3700_spi *a3700_spi)
 	while (!a3700_is_rfifo_empty(a3700_spi) && a3700_spi->buf_len) {
 		val = spireg_read(a3700_spi, A3700_SPI_DATA_IN_REG);
 		if (a3700_spi->buf_len >= 4) {
-
+			val = cpu_to_le32(val);
 			memcpy(a3700_spi->rx_buf, &val, 4);
 
 			a3700_spi->buf_len -= 4;
-- 
2.17.1

