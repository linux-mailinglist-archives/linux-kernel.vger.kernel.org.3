Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4214D00FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiCGOVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiCGOVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:21:12 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0F53A184;
        Mon,  7 Mar 2022 06:20:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIJWtXpG3NHXJboVY14//RNpCJCrRWC0oLQEMp+U6VNdSys4OJMvykqmMiSof1FhYyPa3Qga8MxsmhjRcKWHbWTPv58NsSq4o0Km8Jz7GnhQRAZeBqgAEC7z9iX0skFm6NhEPgoSTBDTNUh2IKn/BzZ5I3bcWiEDEktxeYSkr7WvCqjF6q7VyIiMjj4mLYmQEbWCzz0bZltv/Seujohv/Jk44GpxUpONo9hNZ116LsHmBOL637/J5m6DLG197Pyxf/xlzpmrxyIEAHZHuG5bCytWnf0ZOwYOXnYvgNLMrF35ieepk6PD8nv62yRByJT2zwAvk3M7ivhfviNYMDSrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkuy22tgMAr0M9AonqdKYrPPIdxxlme6C/YVpMAV2JU=;
 b=GnfQ15WQhNkLRIHVjIiVrpOn4mQx8Y6P3UAEtH35o9i4H95k1/3sxwjPUR/V4Vc5NKL2166YpsXFFncd8GKJ4MvPdFXb6lUgcYfTLzFjIzhDAmjpWDTN6wzOQIQCUsMXe7qOptOUOOq92ycYEPUR9npXt+JF2oSv3tphlpWfYrhsea1YdcKLyubGIKhBe7gvLWWDCKsxW8bGofWCx1fSlKHdnwAteOXohyW/ZZuO06elEtzHZhvBCPKNuAEGqpAUyOhnkE8XlXWThnbQ0oI5cpTSS3xA5HNJU6LE6YyOcoP1CprBPAao0JLoJBDYTog1NX2IKOFfndyIG2SaXm7d6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vkuy22tgMAr0M9AonqdKYrPPIdxxlme6C/YVpMAV2JU=;
 b=OnGjLz3vc8tApFfQnMKOc7HRcqoqdQGMELamy7Ojkym1KobnJvFj5fRfMlE+bLREMStxkfTFStZHD/XELYXzEWzLya7OsEvUjv7OR5Rb71F6rEex2iDk0cvzuxJrSsFaSvnFHUuCh22nI9wtV4PffJtejg0vM6VBnsFCmo84KJ8Xe2FJdk34IVhrSStYbHUErOcFteukSUm7Izv+HsrLpWwGZoEJsDOK4Gq7UvKfMjDy/KmXLOj4bQzWslyLmLj7DPBasuRnN3RYgNgmVoQDpI6Cs5jPiyla0S5nr8OWBGTeHE9eXTjOolmLDUW9TVS/1EXto7evlmGWXo7sI7jycg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com (2603:10a6:20b:41a::7)
 by VI1PR08MB2638.eurprd08.prod.outlook.com (2603:10a6:802:1f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Mon, 7 Mar
 2022 14:20:14 +0000
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63]) by AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63%6]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 14:20:14 +0000
From:   Alifer Moraes <alifer.m@variscite.com>
To:     linux-kernel@vger.kernel.org
Cc:     brgl@bgdev.pl, eran.m@variscite.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, pierluigi.p@variscite.com,
        FrancescoFerraro <francesco.f@variscite.com>,
        Alifer Moraes <alifer.m@variscite.com>
Subject: [PATCH] driver: pca953x: avoid error message when resuming
Date:   Mon,  7 Mar 2022 11:19:55 -0300
Message-Id: <20220307141955.28040-1-alifer.m@variscite.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP2P215CA0012.LAMP215.PROD.OUTLOOK.COM
 (2603:10d6:102:1::22) To AM9PR08MB6999.eurprd08.prod.outlook.com
 (2603:10a6:20b:41a::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 268d47db-3ba7-44a3-a526-08da00459898
X-MS-TrafficTypeDiagnostic: VI1PR08MB2638:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB263826D1D6BB27419E543E5C87089@VI1PR08MB2638.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9/FFtf6ovsN0NSaKrO9FsGowL6MFFEUsI5/1irgOrcnIE0tiXWMHqKiwso2/hYqiSafZPPoiqz4L09ilZTO3Vq14r/YKay6GPJWywvUiZIGD22Jn8qWhb8DYUryNV/iU6utMzkC2gzYP/lenhUuD5Pc8A+4zNw9tZ0II36i1TNgdknQxt6NoCqDoaLAXdsJB+8gz0GEJhaeYTptqVVDwsezye4JREY6XzUf0Co/uR0UeVh2R6vkaDKDfb7Cwv8ZlfPRwKjqIflJ6KCDjte/a+fEQ8+isIIl0HbiIqpF1/x7uX5RJRH/GusqhL2BNuuy+HkcM0kgc/80i8psk15/9Pdmerqg57P+AlARPNvpbLIMe/QZbej8mRBeXavo74x9ZNNpoht7i0GRayoDFYY5bFww8xLJK4bV4EwHmHFJ17bPd/oCxXePsdW0KkZA274potgV+c+j5iIObVVIYT02dHEcTERUzogqyfIXFXdleQNgNfu3qHv1DuTpARVG840XzEYvMBS2mRT1hP+tcYHsfWPgRIG6+mvSAHCfcdsI4D0hEpmAYnbnHVBjS2KLDiApUBEjoSUDcevc9QmUmpfaipy3szV15Aw2FeodHGvBYCvv1IaCOFTAJTEF/54iipf25DwrCjTiycYYNfZrhaeh9MaG1VjHE5cZMxeiIxk4U33JtPJOIz+50YMt05qtgaJr7Pynr7Mms7DFNZhZ8/4uWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6999.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(346002)(4326008)(36756003)(5660300002)(2906002)(15650500001)(52116002)(2616005)(6506007)(6512007)(38100700002)(38350700002)(6916009)(83380400001)(8936002)(66476007)(66556008)(54906003)(107886003)(186003)(6666004)(86362001)(6486002)(508600001)(1076003)(8676002)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7pO0uLBSmA2D+fYeBV4xtZgBnc+MqD2rz0CQz3/C/Pz2G+CSJzt61mJ08Zo/?=
 =?us-ascii?Q?RXpvxE0E4qu53cQwI+mJmjdnjVH/rpMDuscoNdJgwlku5HJcAYZTmjAcFh44?=
 =?us-ascii?Q?JL7VYgWeDKO5sD5Y0cDq1MMGnsyulJTh86eftD9ftLmK4slACcQ8KZ/18MpG?=
 =?us-ascii?Q?YDfB1efI6uBNF9cOIzVBiqxZGJLm9s2215NZTGnCkDvOsv07ciHRarZrfGMZ?=
 =?us-ascii?Q?d5tmcIGl/l3QiYqF78ndbCDDjeJlMSFRzs0ZQV/qsqiRzGJWSJCxpyeS6sxw?=
 =?us-ascii?Q?9IfPJlgzYIxvvBZKM0TNHx6dWqjc3XWCjDPPTQ25S8v2ocyrFyTO3sA3wHS4?=
 =?us-ascii?Q?MVWFPbKUcswNq1OcV7g2CJtfWNgvLga7Myd8C//DuEGU3SW/R6guuJivG2Kb?=
 =?us-ascii?Q?4PUvcsmFq2GTshBuRAKwhE+9YTF3f7HQmTOIKPfmFR2f+N0uAr7y4k1sD8Ng?=
 =?us-ascii?Q?inri3Yh4ZeZ2LCsi4f2JMCwKpanOgbpqCTd/50KgMpN6/UglylW+ketWoiy+?=
 =?us-ascii?Q?ftw5dxZwuX0PjJlI0ZyMmQk3m4AB4C87BSt2N8H2VMxSengOVFf/rXdHB0uV?=
 =?us-ascii?Q?T8qQuBLt94qUPACIRBRZ6bXHMGLg9L537ifLQa51CUNWIbv5TuInQDxYaiIF?=
 =?us-ascii?Q?XU2Hu3p50QHSMBB057Dr8//4C3+YlVtkCbUwkEmxhDbUE6Cq1/EEqOjT1Whc?=
 =?us-ascii?Q?h4+pHkzyVTi4WfQ8CzKhk3poCAI76UnOxvk88d1t0HPT3rRKqQoklS2WJWfL?=
 =?us-ascii?Q?vI/CwRc6ao/U//3JWRRQ5A6y434+ynMM+Ma9ywC8JT/46FsIyjmBxJBiHThM?=
 =?us-ascii?Q?6pjIWfbAzPQfXtyDlVT0Mm7EMJknSYjff4sUWEcL01SPPN+EPtu6CRufSB2M?=
 =?us-ascii?Q?cH01eqdD76NhxBpm6W8RK6DNWJZ7fUQOpoFkZ3mAHvRtMPj2zB9Xkn6GFckH?=
 =?us-ascii?Q?OxchYux/CLrhLyIj32YqdaVGXiTrNyLZQddvcZYSvefQOZf1ukrE6Id3UPf/?=
 =?us-ascii?Q?uojhjjZ9y0WHVi/tTg9q3kDf/FgNCZNu+/HI/oXAJnWP9lByLUMCWoN4lTGU?=
 =?us-ascii?Q?VlPtkmBDQsBGIjAR8mO79s8zn31tcTlAmiXO+rb3AAPHpt4gghU05yvU7klb?=
 =?us-ascii?Q?osksNJZOyIknFz/84TgyRdrlZDN3AcFXVu6+cwwseZHfZICVX641Vto8JYrA?=
 =?us-ascii?Q?gNoz8c6fH1FiFU5g7Kj3bpebiviEB67IzjeN0WHfGaH8B3XrDOj1D0LJ7Fe4?=
 =?us-ascii?Q?rgnNPGbHakSeW//kyw43kOOI+sNcjhVmOffZ6uhX8JaU6U9oZlPOoo2ybA3T?=
 =?us-ascii?Q?yaivC+1osoKntFSm0IQUcgSCXnr6sxRH7QnrZp/LsPjlBuMlyPc7zV3ozBl2?=
 =?us-ascii?Q?R7KJK16jrAJANRHLzTYhTIaKsFdFyVQ2976vnmbDHQBcNymaervvI3vKtHLN?=
 =?us-ascii?Q?bXQcvLQqaKu/QHNflO24a1kwGryE2lbp2Z5K3RTxEoE6+zv8mzPnZwbKlZHh?=
 =?us-ascii?Q?cqdxhO7fDTQjhDJNuuQblVCZjDtSKqHwzF+o4X3dFKlAHertGLjEZCcgmPU2?=
 =?us-ascii?Q?Ydnmdy+qg/QH9TomCw+skx0N5tZIrzMNFSQlJeHrCOc/qGcCe3wIhIrv5lUV?=
 =?us-ascii?Q?+BDJyeNs4e/iKanvNW/i4pM=3D?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268d47db-3ba7-44a3-a526-08da00459898
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6999.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:20:14.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w34X+bV9dDlY9EP1zM76esqvWSygmgTc5tHww9YF3pe9mLjBclVJsbchbO4Q1aGFCZ+5K+OwwGM9QZEYZYcpsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: FrancescoFerraro <francesco.f@variscite.com>

Avoids the error messages "pca953x 1-0020: failed reading register"
when resuming from suspend using gpio-key attached to pca9534.

Signed-off-by: Francesco Ferraro <francesco.f@variscite.com>
Signed-off-by: Alifer Moraes <alifer.m@variscite.com>
---
 drivers/gpio/gpio-pca953x.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index d2fe76f3f34f..4f35b75dcbb1 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -211,6 +211,7 @@ struct pca953x_chip {
 	struct regulator *regulator;
 
 	const struct pca953x_reg_config *regs;
+	int is_in_suspend;
 };
 
 static int pca953x_bank_shift(struct pca953x_chip *chip)
@@ -412,7 +413,8 @@ static int pca953x_read_regs(struct pca953x_chip *chip, int reg, unsigned long *
 
 	ret = regmap_bulk_read(chip->regmap, regaddr, value, NBANK(chip));
 	if (ret < 0) {
-		dev_err(&chip->client->dev, "failed reading register\n");
+		if (!chip->is_in_suspend)
+			dev_err(&chip->client->dev, "failed reading register\n");
 		return ret;
 	}
 
@@ -954,6 +956,7 @@ static int pca953x_probe(struct i2c_client *client,
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
+	chip->is_in_suspend = 0;
 
 	pdata = dev_get_platdata(&client->dev);
 	if (pdata) {
@@ -1161,6 +1164,8 @@ static int pca953x_suspend(struct device *dev)
 	else
 		regulator_disable(chip->regulator);
 
+	chip->is_in_suspend = 1;
+
 	return 0;
 }
 
@@ -1189,6 +1194,8 @@ static int pca953x_resume(struct device *dev)
 		return ret;
 	}
 
+	chip->is_in_suspend = 0;
+
 	return 0;
 }
 #endif
-- 
2.25.1

