Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7108F584E78
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiG2KDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiG2KDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:03:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1335D0F5;
        Fri, 29 Jul 2022 03:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeYsx/we7ZxNIvI6fmvuSJJCxB5kRfbiq9g6HgZGuy3fG6Llk/kthR64rTy1dQWVnGbmW6ofh/A2DWyMPFN+Ynn6uoNks1bWtlCay126C3GERzyFOQ+pBZrGnfiy+D1EBgSHcXYnCnA5B4eiP7jcm+6RFnhJbvnr4ksZquWJ+4jtytArMPQ+qsmqO+60C3e9xQFs2xDHSG+TX3CgXC0wmASJblnIyU1FWE4lvMguxccI6Mb3NJhy/N++RdkKgYk92DSUmrN+UjpJJNP89KMuWmxll7yMpLQ1IH5Gsfzdtf/dTbWRfNBgyFpkFjyHeczYzAqCEQnwXfykKPrhh7A+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oL5YMZ5sAy6UJ25gzWLFxRKs6jW+FyIEkHJNrphFQE=;
 b=Vm9NSfkGCJzIYALsspfuS5O5dBejaiL4BKz6T4SRwzSPgCmYkkPnWwO2i/U4klwyN3eoftCkl4kuhq7Jrfo/8LSxKKC09K2r1vPu5y8JPKGEquhSKGeh+SGGesQM72eQzP5bW/U1kP+CkClUsLy53PczYpnWeDyxGgk/LfLuqvdPuRrL0XXhflHB6ePnt6Pm9mkRP4n2J23ICuX2ZymAqOcD/o/EMxCAcjWdVBPV6DGCVnpinUxdc8BhMk5bu6nWr1g7Px9hbjseVTqpTLZGVAxa9aYrnW1WJHOyMzv723jJPqCrNwbmZH8DgoE8UCLNciGvs0FpIiSiSQvOeKfW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oL5YMZ5sAy6UJ25gzWLFxRKs6jW+FyIEkHJNrphFQE=;
 b=b6Lq7Xlggyi3tU7vn6rHXyRpoDRf/tWZwoB/IzAw3xxtp29SXQcGalzYQG3HODSLr8mame+eqg8byczZhKgF7FY/I4+vgSorUIWUJqA8XQldMlzsxj89D8Je8UbAKOpjvr1bURarVAD5AEWYus+zrzhpnglT+tvD/gbg/R56Vak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8296.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::23)
 by DB6PR0402MB2775.eurprd04.prod.outlook.com (2603:10a6:4:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Fri, 29 Jul
 2022 10:02:57 +0000
Received: from AS8PR04MB8296.eurprd04.prod.outlook.com
 ([fe80::b810:ea9c:9783:b2b8]) by AS8PR04MB8296.eurprd04.prod.outlook.com
 ([fe80::b810:ea9c:9783:b2b8%4]) with mapi id 15.20.5482.006; Fri, 29 Jul 2022
 10:02:57 +0000
From:   Kshitiz Varshney <kshitiz.varshney@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Rahul Kumar Yadav <rahulkumar.yadav@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Matt Mackall <mpm@selenic.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>
Subject: [PATCH v1] Moving init_completion before request_irq
Date:   Fri, 29 Jul 2022 12:02:11 +0200
Message-Id: <20220729100211.2204126-1-kshitiz.varshney@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20)
 To AS8PR04MB8296.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a02942b-5318-4893-7d7a-08da714982e5
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2775:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7U9VNElAQ/cxrRNJnLgrb/bhDKufrI1SuXpK77fqtLUJn0hUmDG4nOojMV1i3DklPACf1KMwPelYeQ4oJ8aaAFeu5JZF4JuNzF9U428nU9wNteMgJI9n2QTTtWWT4HCNknUO/mcIKVXa6btHTSfk4WelPM6APg/0r5TuVqAikUxkn/OgzqW+MpsTQMxhNl9HbEjJpC5Ue7jA6O4IQOQFZGlJI5T/KoA82FzvtJcAg86tl7wFQd5dgFQeiJ91XKiRqooFq8ZjIr1q9YpzWSZt4mm6CRHdExvsh26t7+UGKmZOfd9ZiBIOxg9RKhZjvRIdkCB7WpIC17JVtOhiK4VXoIsKTaQJo9GTl2Ya80HWciJOMIAZaYc6x4teV27mzTyYJB6xJMe8Fh5yKKdgCTdM2XGDHmgz2x7BcArXuJcPoTsUMwb4q4uA/9u1gKvwxHFZFFgeSqcD4jyTMM164O9+KYDJ/WKYLQJpquuN3qD4XxqckkCqese1UdjPGZqUSOvkE+tuM+pEoulvwmgXYmoEtNeYOjM3At3Bmafc9iuTM7QWIR6692jfWiV+CP4x7Ncj+PhAtoTMranluaCeh9vKCFo3xQEjeff0km5Hyc4aYQotf7MLKFge4Nk3+YLi1ncVFDi7Hyh4j06oBWX+7BqVVPqWjqoNPjkIntDU1ozdlUrr1MSikKX5FnT2VkLZZYSClQKa4LoKPd16zOIFP+M5hwpZNdIzUR0DPG5Db9bRFh+xWtI/YdIVwJym2mS3GlSHV3PdJHsn9F5+oiV7RkfniZrNNht03jlMm6+PL2iUWSEli9K6iOsqRmflhDCgWwORsBHlp9RUUuaYjA05hn9JYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8296.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(1076003)(66476007)(186003)(4326008)(2616005)(8676002)(66946007)(36756003)(6666004)(26005)(110136005)(41300700001)(2906002)(66556008)(52116002)(83380400001)(921005)(86362001)(478600001)(316002)(44832011)(7416002)(6506007)(38100700002)(5660300002)(38350700002)(6486002)(8936002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LaXVTetzyKHBazCwIO+fmOYtQVjE3xIwZHe3nCPLKliscJey/2myTjDFmjL8?=
 =?us-ascii?Q?Z73nfvAy0h72aEAPU8NAzM1BlsMvZV0z+eYX5Oln4NQHzeAREH0ba28WvyHX?=
 =?us-ascii?Q?zzYW/hzzpGZJwKzqL28iJxtqS1BwvsTvZ9t0LU6lv3/u6DtQOZ4mUmaL8OY1?=
 =?us-ascii?Q?NJSQ1QwrHZWz+7DBo7qLTGba6/CQLpjD4rM3dsBoeATHjjsOn/oSugAycH5+?=
 =?us-ascii?Q?3zsltLPY+J5pihRYH83CcaRpZeo+fc1aysLJBj0RsFf73QpwMblDb+e2LAFh?=
 =?us-ascii?Q?62ZT5AprAK+WGUaWzYaFp+Kxpyr/nC9r7xfIV0+Ya2rz6iqTfbekb0SNHHDM?=
 =?us-ascii?Q?NZ8fm782MQPR/vymmYsAmj3kZR9db9Cf8cpE14urmtSMeXkrSpWABsj8y/yt?=
 =?us-ascii?Q?ODIa0A2bS5hnKKX2flcWk1A5vJmV7SUYTv6T//g27q4W5wV4QxpmnJUD7DvE?=
 =?us-ascii?Q?oNYPwvYpY4zY2d4pBfdo2BEDX+ot7l7vzR+nhhrLhQvm71g8ydnKDr+N4BDI?=
 =?us-ascii?Q?6wAnYDu30MeDN3za249KTU4TV/4exVzkz/SsSri5UkcWBmfia8TbsdtKb+Ny?=
 =?us-ascii?Q?admjv8CTcZMXIWPvj4ACiH/y5/NTC0EymlCKkHu6L/0TB6F4Gq80Gl1wGolr?=
 =?us-ascii?Q?S+CAOCcMO6UkKY8WabB7pjnsdGBcCLEGVt1OGCQBXyAt2PO7Un2ikY8YLJwf?=
 =?us-ascii?Q?4ZRS0tvUlh3W7aN5m9T8LLEikljzXKe9EwQSztr9wQ8eea22jle1ma0Xwx5d?=
 =?us-ascii?Q?HfAXW7YfilGqR7bK96cualIg+cqyRgm+37y0t9ur4qz2SRsgUbjNlqQKF8Ow?=
 =?us-ascii?Q?5fqX2H+eYKVapCWs1M+CYiE3BTXX404V0vCWO/7NEVN3rFQRntmo2TNJYtD7?=
 =?us-ascii?Q?scJzsSnepPDntsyQnjWDIYAEyuQ/1Wf3OZofe8vEdUH7e59aBfNG0IJtUOk/?=
 =?us-ascii?Q?8PBLKTWU6SrxSLK6W1K4OLdBaNtxXPcwXmR2/hPVbm0i4QhdLhUhI+iZj4CZ?=
 =?us-ascii?Q?wnGyqlQhVkNUSuI1tWSgY4+AGlnqTdfwSD0BufLA5PWW85LYvK4ZuZrqUlrw?=
 =?us-ascii?Q?37h2ukZ27ju5SM6Smj4oNj58vkZtdQ6FYABobA3Krk5zs26q8N+3zu9nfrYz?=
 =?us-ascii?Q?/VKwbbwWp3/lxal4fQ9ab/vvuQkhtsMAw5pDdUbCKhloBn7o2YhiWo3w+Nol?=
 =?us-ascii?Q?wM+XAaU/i9BMhScR6ppJeStQsl4HP/8daOwxIWXsJgw03NeiPTYtsXcGtn7M?=
 =?us-ascii?Q?+gsu8dky01T5QFTucT2xSGJCsd+P/PtNUWrUj2hmmbA/AX2My9H7QxXPRmuv?=
 =?us-ascii?Q?Qan7F2Pyr4x/FeEhhiTY3gELv4BteAI0PocQ8Gtc51tz7p2Vz/Hh4f67m6KY?=
 =?us-ascii?Q?aJ//wZKPjYKNG9No9W3Q17KpEAZJfI3e/bLe9JAsaCO+oRYDSl8anJtu9ler?=
 =?us-ascii?Q?7LKUNfnvKk4kFkf0UUFNdpKL5wBc8g+wKcpdOMrfCIW1UeqHy8ofCKToq7mi?=
 =?us-ascii?Q?VCDFnH5yvThF1PRDUfNwTchy0VZUfCAfDaoqbRNzo/3xA+bJddh8gEost0ds?=
 =?us-ascii?Q?U71t85YcpUHf6Wu7hsUxFevzwsyZad5gN2NXOYniV6bDFVxRUdwxkISR7tA7?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a02942b-5318-4893-7d7a-08da714982e5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8296.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 10:02:57.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXriYw1P5qSGg4poKGUkLVjvTw93daCUTB3PX65uHnSIXd3/cs4StsRz0iNKivrTwnudFHkS9T9L/bls9CnDhq01hazY9zJ8pgdXQ2/vh18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue:
While servicing interrupt, trying to access variable rng_op_done,
which is not yet initalized hence causing kernel to crash
while booting.

Fix:
Moving initialization of rng_op_done before request_irq.

Fixes: 1d5449445bd0 (hwrng: mx-rngc - add a driver for Freescale RNGC)
Signed-off-by: Kshitiz Varshney <kshitiz.varshney@nxp.com>
---
 drivers/char/hw_random/imx-rngc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index b05d676ca814..53e571c4f283 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -270,6 +270,8 @@ static int imx_rngc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	init_completion(&rngc->rng_op_done);
+
 	ret = devm_request_irq(&pdev->dev,
 			irq, imx_rngc_irq, 0, pdev->name, (void *)rngc);
 	if (ret) {
@@ -277,7 +279,6 @@ static int imx_rngc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	init_completion(&rngc->rng_op_done);
 
 	rngc->rng.name = pdev->name;
 	rngc->rng.init = imx_rngc_init;
-- 
2.25.1

