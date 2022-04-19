Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB9506661
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349657AbiDSH5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243296AbiDSH5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:57:20 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10041.outbound.protection.outlook.com [40.107.1.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03EB32EDC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7WaPL5X8rlAlNvBCLsniYBIz7Dia9osNOnHB9lz+JRfJEI2FjQiXPVFFx55DsyDnmfRiSXXpEOczf68n8pxbg7WlH4PWOy9qkIwQs4Tub4OrgAIAzVS1QJAxFIwOCl2SU+rPH1dFlUk6S2INSlLqO40LsSfcNZDO11O5q5EwDBay0n7jGLWFzbT2rnj+f49jGNRX0aeBtFFjmb/GEawgP4zfBwj/KIWO3LIWBQnsPx0EQKOKkfi2YPZXNTd0tK2b1FhQi3zXFUhtuhc6tFptpMOON+GMhuOS9q0KeSCGjP6aC33oXCWcY2SeKgFQi0MEv569BzTNBLHRlqTGpA6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNfBS7B/j7spnd2j+Nn1cf5px4gOD/KRxNIc9Rqu54k=;
 b=lSyyTHYbFjZsn1ZhtjDmV3N2D1/Dz3TjXAAsDg+pkfMUQ3eRzlkXH0veUmlTiNTEqWArcx7aEd52+3muDlN4BAmNXMVHoNkCuXf3EkuRZunoaEkWaq5VsSyqnivkO5gd7L6ciLtXHar23gWjzehjTbeNKVdcxebV+kWyUgLS6Rgt90TB/l/gBMiSMlMQiwnFCJ6zXpZQyJVINjVBCF/d2/RG+kLGzjzmpl09FNN7hK3XtXxkq7z4BbRxyXVHfzLxxSqdZdoqx64xPED89ewBJ3epw6pbTHSjadOcrktmq32ti5+8KFwehbbg9ZSMD34RNuOdh9bURgz2xcEd8hM8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNfBS7B/j7spnd2j+Nn1cf5px4gOD/KRxNIc9Rqu54k=;
 b=OSh+iiCrnrKQ4l7U9Sk5Dy7oSXXE2kP41bt+jmJsGpd+RqFsnigHS4joto8MNnrLsdCRrSMzUIR7Cc1FxZvIzaVAgfG6dAFNGDUmYED93avfslssfS2O4RrkNgT2uxly06iJYfb6IFp9bntxDTTnD3wecnt80MyLJfS8rSN38j8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
 by VI1PR04MB5952.eurprd04.prod.outlook.com (2603:10a6:803:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 07:54:35 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 07:54:35 +0000
From:   Li Jun <jun.li@nxp.com>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com, krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, frank.li@nxp.com, xu.yang_2@nxp.com
Subject: [PATCH v2 1/2] extcon: ptn5150: add queue work sync before driver release
Date:   Tue, 19 Apr 2022 15:43:21 +0800
Message-Id: <1650354202-10445-1-git-send-email-jun.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To VI1PR04MB4333.eurprd04.prod.outlook.com
 (2603:10a6:803:49::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 189eaa62-c40b-478d-3fa6-08da21d9d878
X-MS-TrafficTypeDiagnostic: VI1PR04MB5952:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB59520F960DE337DE7DE32B5189F29@VI1PR04MB5952.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnCfPzz6NDkV8CPtznKBSJeRseIYUWym6ARVDO3opN6SsFW1C1Ybc7nYNbsJ6DBbiOAyIM2LawMitk9o2nQ0bMJy0LCapi/FSv+rbw9uwJvQhyAY4PuV9+vB1L1RTomUpyUyNMjr/sQpJmtfsLQ6WueccJealS/3n6eJyD94mqltyV/RbNy5ABYNfkounMemITccW4hAz5k2FW3sEggaNcYgW3VABjT1vn6HTa1XbuvzRRW+WUW99Qslw2kpVRJdc1eJKyKmzWX4yQhB2/qiHHaqcN61RcoFgCducukA/s1B3+MOTWsE/JjgBRhLLNnkr0r4strATy8xbWm1pAu3NDsFRc/bhaKsGXC93TrXJbSmv6xdfmayVUCM/fyTZw0ReBtSjXsRfm3/ow3nwPznalvfy4giVSzWZ1q3mgRW11+z7aGvCQDc5z1u3bcJVw5SI854RLfEiLfrF2sHRNlV/nIuF9CEC/4KsvA7fY0tdWyCiYsSOR4teT2H5pycwv3gtiC3H7CvMgLf0XiZDI0RK9Elv8lm/4ndg017iTO9VgG4x89QNi4Cbwau1Nf+WtCD8LoUG8blKQgyybIh2vcYOGWIlsm+jN6QxSgld/s5mCSHrXvblul0S+B8Dmdy7LIjoA5gilKmBgxMSYF/eiRflgZUSd0oKSZRdQYVTqluqoUdLDr+7mjy5JQE27Mf+W28
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(38350700002)(5660300002)(4326008)(83380400001)(2906002)(6512007)(6486002)(6666004)(52116002)(36756003)(508600001)(26005)(8676002)(186003)(38100700002)(66556008)(316002)(66476007)(86362001)(66946007)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tj5lZhUqit+880vWsL7sMGMQLNmShHdwib6BU0z8UeZ414EhjBfsTj0oLt9v?=
 =?us-ascii?Q?4bddH1h7p8Gvqh2fBjprP3qyxV0vxRaiTfMqqL649FjwjEXBArByEdmwuEZ/?=
 =?us-ascii?Q?76pCx/dKxiZjyEy7p/73GzFiA1nKNMRUUW3nOEJeffgwz0p5v3GwzXjBbPJh?=
 =?us-ascii?Q?AMlVvn8bNVzLJ/JPEWgt1ZZM49tGf7fzEpNk+WznvEgJ0Cc1Kejm9WgXgG6Z?=
 =?us-ascii?Q?4PxSdG9OED+jabfPuHDvpSWmArDyjsRK5enh4zLaQeK6Gq5BmCmgz/zNN4fJ?=
 =?us-ascii?Q?BmQYiiUGHBgPTnG6rbPvwJqv0TlNAQZatH9VfI4gyO4QD2dDBybioCD2Uj66?=
 =?us-ascii?Q?LaIDMGgahH+Lz9YZWm5Qc7+lOcBV4g7bGYWJpjEpOlY3PFdqSkbz7K1rNu0h?=
 =?us-ascii?Q?88lo41D6J+OmlN3GBkJpxSKLEllHgnY60XQkYVRkGYGZoPhSSbDuYlvoAiyt?=
 =?us-ascii?Q?Igd1vRa3BTVz/KsToshlRG9Z3YRGm5Zz4OaV/pIgn72s5dALL8Q3UBbDpVIC?=
 =?us-ascii?Q?Tm3xfz2j6T+UjgpRjm6z/ITxcxaL/eHuZros3VtomAonpqHAqwI9GMhQ42gB?=
 =?us-ascii?Q?ERQz9F/Jsx3Y8osdrg6HnHTtDkua1sw9nzCUYEj83Z9aQPuDpgeIfuU6PaqU?=
 =?us-ascii?Q?FBzSs7YYEGkPMYsFUkKDtK6z5YeZuYs5Rp2bfcKH3trd6gYqOcg+tuaOqVNl?=
 =?us-ascii?Q?nbtj4GiwfezfTXSAxDyZ+Y/G+nrsIFz8vPWpjwnHO3nQAGFwHdcYAzNt/bP7?=
 =?us-ascii?Q?RffXKDLIly7FS0TJH1sNDroMRxOCHAa3PzH3O4GAmjF9J2QUcDFXz+QfxmP7?=
 =?us-ascii?Q?FZTdeu/iXxTxweGQ0EgstjJeMNCg5nyxgqSzJDf8e49MBWHps5rcu4rAlAAZ?=
 =?us-ascii?Q?pPgN59AvIHymjDNiVJ2Ib+6iVEq5goWi4R2knTKkspnz5sUq5T5k9Favixfw?=
 =?us-ascii?Q?ZZ6MbaxeOW8OAPgocF54BOCO9pYg7pky5szLYUPbdRnUalHS+m3RYvaoutrh?=
 =?us-ascii?Q?2WYQCfqyDSoX5czzBN+8uGiukIH0lUduiy531L33OZ+cf1xZsy77PxOGaZPi?=
 =?us-ascii?Q?MbL7e7GipTFdIOrETyKn8idVy9jwQ47U6RaO4i9OY+baCZ8suYlQL1p0voPg?=
 =?us-ascii?Q?tbdVhauaFUqAxQy1Kwr2EFVALa6d/IliLHyijAxS8l+lo4FjOGUFC0HTlt0A?=
 =?us-ascii?Q?R6QyObWrwBhtdK3JEpLvKGKXjnVwe2C1uHmM9yBG+SZGm9UxPB4xVVQN/XCP?=
 =?us-ascii?Q?W/NZvzw9rcBc0nsVAaXI4OPcR7+OiI/RNkCOeKMlvQiSVPigWQ5h52XEBxou?=
 =?us-ascii?Q?qFJOmV/pjTwrh/+8GEs6zD3m8567oXQq7IEgr0QgIF2Ion6JvGdGHnUTcL84?=
 =?us-ascii?Q?VlqAp0LkhZ79d+EKvYxMuipE5GZlvUgCpKyVy82/Yz3etixd3JigARJyZe64?=
 =?us-ascii?Q?nPmqfEx/GNKa50YSWJBcNvYWtNiuw2Cu+1YHioSRIL6eBXx7bJTM8VwF9CyU?=
 =?us-ascii?Q?4b1Zms1sHNeOxLdOdEKo0bRqdF1yODLVq6qICJKuyLAy07uwMo9rmaPJ06Wp?=
 =?us-ascii?Q?Sf656RLEEPRpKK1fq7KLrad/hh91XnOpNSU/BJK6WpOqukGHjy1ncc5s+QCd?=
 =?us-ascii?Q?QH4MhayQrwWYFBJltiyCt4nTqxYtKjmjgfA6/TcVXU9hT6PE5mla4zxir7P0?=
 =?us-ascii?Q?u5453Wb1WyB47PuSstsqg6YfvgcdMhySkm4KWTREzD8BiQo9tKUppdfMbIDG?=
 =?us-ascii?Q?a1H1HoDtsA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189eaa62-c40b-478d-3fa6-08da21d9d878
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 07:54:35.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVocgmDA3SEF3JohsHvK/URVhPT518CsHL1Bki+wSaJER7KTILA/gRr5voJ5B1Mo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device managed action to sync pending queue work, otherwise
the queued work may run after the work is destroyed.

Signed-off-by: Li Jun <jun.li@nxp.com>
---
- new patch

 drivers/extcon/extcon-ptn5150.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 5b9a3cf8df26..2a7874108df8 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -194,6 +194,13 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
 	return 0;
 }
 
+static void ptn5150_work_sync_and_put(void *data)
+{
+	struct ptn5150_info *info = data;
+
+	cancel_work_sync(&info->irq_work);
+}
+
 static int ptn5150_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
@@ -284,6 +291,10 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return -EINVAL;
 
+	ret = devm_add_action_or_reset(dev, ptn5150_work_sync_and_put, info);
+	if (ret)
+		return ret;
+
 	/*
 	 * Update current extcon state if for example OTG connection was there
 	 * before the probe
-- 
2.25.1

