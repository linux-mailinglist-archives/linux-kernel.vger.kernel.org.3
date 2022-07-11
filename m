Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891C456D830
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiGKIf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiGKIeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:34:44 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7C11A3D;
        Mon, 11 Jul 2022 01:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAChumpId1QdHL1Va6skyeNrUuXzMqGXNyEMS4t5utt1UJG4h/vyLLN/Ujcy4Ck/2/pdzwhBTuSDfw+DBIp2XHkgqZYLgPR9DP1KwcHjwsaXYA4iPSKZuFZSykodH2nS7ntZE9wuwhHG490Nys56Esvq20rGfwVmEkZUaDEworuBZitBBQZJrnkflZLsvYbWV6F9D/+sggdWgjzBYFgPh6ESKlSwLS6UOmDycXArgzOs4J/MMu9+9+VCO0fdr042w4gEV0vdSRaa6VkIGH8ed5VxdNQY0EFlnHXuhod0aFmh7sc3P1hHJOkPlHfRughHZLQ6lRVDjGwKvxlNNAQ1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6Ksshg9ZDzKe3YWaG6ZWXEFCt0CAZ+e23FYgsbS97Y=;
 b=S+PwMTT4J5MpFGIJLXdZogpt+rtZnhSR/i3ouHCo1WMBxsoH+Wmrk3qWyIfUxv34TIg1BZzwHEWzDzIwBmxCdUx+5zH9A4Fyo78MXyWquVOHM9dyh1yibMsfAO3NxcTI25nJm+1m2fNEIGonb2bPLwsPOP1azV9apW0BBp+MahNDoUboWG9PEK2XDfFq5PSAYh9+VXIGg5fECUVvZy8cKeOPX28Q/MZMUdCQcwDBCom5zUtCEneaSJDCT68B/xngt3cNegypc0wpfe/oHWP1AMD7Up3H6UfYbD4bPXH8/m8pJ3LuIV+2Kv8OS2BeAq1znDkeHrN9IAowwPeI6nHXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6Ksshg9ZDzKe3YWaG6ZWXEFCt0CAZ+e23FYgsbS97Y=;
 b=HDURP4sI0Qr/KcBr7sjKh4qaBdCIN8kDFDlAziyEYn9WoSshTz9MTs7ynfVpV3XR6usMqQC82n5uCW2K5c2VALglcrbYhMSGVQ/2kP3U2ViGG0xy5LMc7RgQZ0walITcuz0aqGcK6ITHhdAT+kWFniN8AiyYxgZTMRCpn0oUbU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9)
 by AM6PR0402MB3640.eurprd04.prod.outlook.com (2603:10a6:209:1f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 08:33:54 +0000
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::1c1b:6695:20d7:fd10]) by DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::1c1b:6695:20d7:fd10%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 08:33:54 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     linus.walleij@linaro.org, aisheng.dong@nxp.com, festevam@gmail.com,
        shawnguo@kernel.org, stefan@agner.ch
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v2] MAINTAINERS: Update freescale pin controllers maintainer
Date:   Mon, 11 Jul 2022 16:35:28 +0800
Message-Id: <20220711083528.27710-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PU1PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::18) To DB9PR04MB8412.eurprd04.prod.outlook.com
 (2603:10a6:10:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f55122d-81d6-4829-0d37-08da631816b2
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3640:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Q2xU2OimmAm4YrlMqmo7cxLpcB/96TAXwe9sugxhLS9CFU93KNof2oxU5dxQK/Uf+sC6AOsf5udHR8FJxNedmdGj0b8wDdwe/si933GdvGkLjhURFMwhFzZsjtja5ZXBmJIvjtlhvV9sWiImLMEynpdTCEF2xrkVz9VMMuGzlkKkL3XfkxgoCNfuGDcEBATcn/QfZha9mPruKyuOCEO8AVEw5GYn7/UnUR/Sv2JiXQDxgMZYY9cgDmJJierCguPq2VLfIABy/UPNJVsu6bT3yB88aE24WnPmfpgCF6bCwBQL+KKYsJu1GwvwDJ2oszPHnQ6/+CsEzxz25eB6oVcn8HXtSNPPJZ3QvA60DCqWXmQO8kRYxiLr4wyyE+h0n1ueb9Ie0EGEXwFKf3uUHkuxNFZybq8/ASIEVdcZd5SudUTgAZs+6NWRygOJWDiNuDNG3oT8bBkhd+wau7R9d8Q8JG1UKaMRWPrGrobdR+Jmu02ZFy8n4QRHTltNV2skQxePCTNCFI2aR7Kv8moSWgFYL3axlf4JOla68TBSVKe3TyPj/Kpgk3vMMntJI3P1ZCg+lXmEZJ3uee9V54uuhxQeG8yto1dkTnnA0FbWYmnSU6lBuQxRHuuPWHybdoLzezI1r2c6GloWmmgUMMJRZ4H3pGzAv+91E9EFDW4Gt9iD9aGsDMlxrwpJyRooOMSbxPcmCC4nhaZgIhw7qKN5gHrVD++DlYjNToSDSxGNksvU5BHkPCu73n9m2Kd+/ovZhshbjiI6dvU6CvRJQufqqLpnBoS9NeCBzNHEbPV7xyLhsIujOLHEpgnR/C3hKgK3KVb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8412.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(66476007)(8676002)(66946007)(4326008)(66556008)(6666004)(36756003)(83380400001)(316002)(478600001)(4744005)(41300700001)(6486002)(5660300002)(6512007)(52116002)(6506007)(2616005)(2906002)(8936002)(186003)(1076003)(26005)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OzS31b7V1O/wGhrMVuqaZmGe+0yZOpoimZ5EGCVTERyP1c9e7Ck6drnTIQYF?=
 =?us-ascii?Q?5D/Us8Jlp0xSx/sPrIF+1rosdW1xWHbqapvSH0wL/XnfnRjafRoM5Xjg4oaP?=
 =?us-ascii?Q?EnCaK8THp8iQDCPB48uZWhOpwuN6GucOgoaqOv/nZTKZEot5OgpTN3VxQwfb?=
 =?us-ascii?Q?/G8p60eujYIU6QrYZxlSFyGXfthbJNksT7Rx6yKJ4jWVs+cdsh/ePTUxPY6L?=
 =?us-ascii?Q?MBMxoPVLzRQvOdfTaVouqLLURFnqNAD1IjfZ2d0ci1HpYQ4s/7DQayflYOr5?=
 =?us-ascii?Q?9w21zzuWPhxeHhbfU9jYhpZ/cPtTog0qa4wt3boZND0K792uRDViyIzILYXo?=
 =?us-ascii?Q?VCiesiRFKo1Z+ey9BSuYSGgsQlRpwcRzigrNIqn1xX9AS1q8LIrFRwb32SId?=
 =?us-ascii?Q?DseVyWz+vtwzLHHACN/hJ0/7Hd0oexwDAaMnTft7R4R1HNvI74MIpJrc8AvL?=
 =?us-ascii?Q?mDwKn29pKpDyO4Fy4yI0NiyxMvWPrvmY/X953X2WCf8ByP+DGrOgeXHUVqt1?=
 =?us-ascii?Q?QOjOckWLVwzbGkPP5p98AMCyVqsrn54mL+0RUSfp3gFHq/6Vo+0Ws1cSXikt?=
 =?us-ascii?Q?PXBQblzjfsmfoiODaxwBLPkIOTtvF2SxT5fao2Z5i2/vnRSSj6GNMejbh+U6?=
 =?us-ascii?Q?iLju53AB/MLEtT4AHYBadtAJC8laL5DpSyklYNn0SCY9tvvcCEwDzueNAkKy?=
 =?us-ascii?Q?Lfu8E8bntWvXfwLaocJ9piepu5FKi+F5C7JI8xHVvA+J081Z/7e9RtOQ0V/K?=
 =?us-ascii?Q?r8ExwOI2zdhQR1yI/hKRfT8J+nFS73QsMF+R8SR0wEMhoeWwpeVIvmqTYQwz?=
 =?us-ascii?Q?r8r2tOjuS05x8rS0RQU7kObUhDMEGteLl6xtIjT8m9/PgMIRMz36GzQ7AtCW?=
 =?us-ascii?Q?ED6+YdAK2GUwdt32GXEZ2rnOb6F5+yDsD1Mowr/eQtTDyMZWnwB8HpEgejR8?=
 =?us-ascii?Q?IpYbrWgSfwm2RynnD+2v363x+fPfoZp0PGKRx5jCSszDWJCwinllQ3PPDvCs?=
 =?us-ascii?Q?9AjQNZUj/kkoZc6IIH1//OuxV07799LOSIiyB1dEk8XL94EsxxxlmBx9pC+t?=
 =?us-ascii?Q?Lc+lFDa5Bn2zRNZG8kEqPwdwjFgyXem3kf+8A0pp/bYBQ5XfbcMKNrRMqYUZ?=
 =?us-ascii?Q?FUz3hUywFvpkJNwcxjf5AkKYyrbnAl5gRvbNY80dBLTLPUJblYCwUwoTYxAl?=
 =?us-ascii?Q?hWuB4oP5EV0pYss09kdhsn10cKbcF8XEPsxlDhlMVtSLyRJhfP3xwvdlzpAX?=
 =?us-ascii?Q?zNs91xBkTtmF83rMCO6mSa5jL6oXaws4a9l4rAdoERwdo1Yx7rXSLpzJuhGR?=
 =?us-ascii?Q?O3O/qGFtonGFe4ziKERM7K0r0jBV6hmF6oub09hKouWnSquM6UEiAbvKZ7aX?=
 =?us-ascii?Q?8mkFEDYBitbUXCArVt/DUKjEtCcdTOxHKnefvTQjznOqnJ3HQbozcTeSlMO5?=
 =?us-ascii?Q?vh+yb8aj1vE4ELbORcYdxEtCQ1vq5BPDDalcqE71JOnCxN7d3em9kOXhGmXv?=
 =?us-ascii?Q?cUGmDIwAQ4Y+JW+Hk3ndp0VnK7W9qAMNn66Ltz4Iw8k9snuqEZW7+JMAMiJY?=
 =?us-ascii?Q?DLafbWsP7yslA6CkdGlw6MDvmpxrF4fW1FgiBHkd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f55122d-81d6-4829-0d37-08da631816b2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8412.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 08:33:54.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBvsnExOsFDoExL/ZjmGBfLSiLcNCh5JFcUH8xX/n4Nncf7SaxNi5TsGfbVSH7ne2UOVX4aBs+bOY4ORkv1EYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3640
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as co-maintainer of freescale pin controllers driver.
As Stefan is no longer working on NXP pin controller, so remove
Stefan from the list as suggested by him.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Stefan Agner <stefan@agner.ch>
---
 - v2 changes:
   remove Stefan from the list as suggested by him
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6d879cb0afd..f4c964d36daf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15556,7 +15556,7 @@ PIN CONTROLLER - FREESCALE
 M:	Dong Aisheng <aisheng.dong@nxp.com>
 M:	Fabio Estevam <festevam@gmail.com>
 M:	Shawn Guo <shawnguo@kernel.org>
-M:	Stefan Agner <stefan@agner.ch>
+M:	Jacky Bai <ping.bai@nxp.com>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
-- 
2.25.1

