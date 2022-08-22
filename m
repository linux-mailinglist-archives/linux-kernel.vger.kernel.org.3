Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6DB59BE56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiHVLTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiHVLTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:19:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C41C137;
        Mon, 22 Aug 2022 04:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy/HZc+yVkITV+rsLxlq6MXIp4u5XouW/r/tCZPsub6Boo9aNMhVZ36Ehdd/VtfD9Q4z/RTVO5LAqKP5wY8lK2gLB3nXFdf9azbzxWoe8qc6pAg73dCof7U+JDqPIjhxkoCyE9JkRoEu8y3NqMIhDYgYE/76EJFxVCQ9LhYB3HYHoNvp7p48JYRu+cMcGvcoJB6ej5fehbEQ62Q0kNLT3KOM5ygOhsg/bWvp92a7Z3/P2g+T/+L98lHcNngFxwisPzNrPzYr9l6fTYHuMpMVZKy2H2NWL8PZpIVuyTz2pftRwwQjsAFeKflzRLKAvupo4dUhOMVbIrpH1ONO+5Ihcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pveVqQ7BvBUU44WXR7ODpfYYi68OPbgajJDxo+psdfw=;
 b=VoiclUJwj7ZvyvYVfVcnQwAMrP9unD8mrDsOG21qM7AAATtluA29ruHHs7dReawWqCm1Qxj5iMo8RCZJWQzZVZ3QivbB0UvWxZ0JhePMhcQ1KTpa8NbB21TmepXVYLGtk9AeCAvZYPJsvVSNFfYL3zitouDjKj1gsq6xAJ8UASBxY+MoUBGSSD7rBvMm726k/8ayLtto2UHsWaI9+aBJh8rluMS8GWeRq8BOq+RLX6jJWci3nLP7xnUpPzh4CW30C8NJ94GSwdqpXOyzI9slf4CLYNj8tq+Vxa0FlLCmHPIaIvK7nzrtkZ+Aj62kc+VQib4rBbb7EKP0iRoeT5OBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pveVqQ7BvBUU44WXR7ODpfYYi68OPbgajJDxo+psdfw=;
 b=E9Qg1kq4ec5IW09iaxBn4EV4prhWtBxEQlJ0S5YedCQMIaew3MMFrEBAFhhQD5sXgm+DAmA5cX9iQYERMwaStoW5YbZKQ/FL29aU2h6sQkVQe85zfVlrlaZ9dBJ4o9goxUxm2v3tkzm2DIXap6B101QPtmdlomFiCjWTxeuN6m0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8296.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::23)
 by PAXPR04MB9594.eurprd04.prod.outlook.com (2603:10a6:102:23c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 11:19:34 +0000
Received: from AS8PR04MB8296.eurprd04.prod.outlook.com
 ([fe80::8116:46e8:c388:c92d]) by AS8PR04MB8296.eurprd04.prod.outlook.com
 ([fe80::8116:46e8:c388:c92d%7]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 11:19:34 +0000
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
Subject: [PATCH v1] Moving IRQ handler registering after imx_rngc_irq_mask_clear()
Date:   Mon, 22 Aug 2022 13:19:03 +0200
Message-Id: <20220822111903.328957-1-kshitiz.varshney@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0078.eurprd03.prod.outlook.com
 (2603:10a6:208:69::19) To AS8PR04MB8296.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29edbe54-5513-4b1d-205f-08da8430314f
X-MS-TrafficTypeDiagnostic: PAXPR04MB9594:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3lWKJWCeAtSx1UskszWnnVs2Wfs6HIW2mCGcwV3nhOT/qSEhYRX0X3zhOMfbI/N07p0c2OBb39M8eTZDY323m9KcKC97qQtPMdTXpwIphXjclkaYQiq/u6gYyPY916Ai2lwhHYH2OTeP2tt0kmfHuxAQydXEbxVnIVx2fWEAbhF5nyajVR2c8hL6MaEDXZj7toVwi8RXN/mNknmT226mbDUWVJXi08XewiZgeRpVlUgSBg6AUdaaPh30OEonykFJIWBySkJmneywi45nuP4BiULR4xiOeWm/rPNwVO2MHsl+pQNwwo6rQgdcJW4gVH/dAZP1iuKQC4xPC8JLy3ptZr6QJ5e8IcS2tw2aPrcZr3Q21TQ86E2U3dWS8oBBMzdYLablx20OCJgdvqqbYvCbVH59Po9uWCYBw6EbU8XjHLWOo3zYvNUIoAoQ2XKRo9GrvCZ92ePrGPPxVXSHhu1J4f/MbBlmovlfLaBbDMPWXcSNPPx2H6ztPXOr17soHwrKcCe2C+CH1LyYdncG2HWH54zPsKWw9LGqWPSIO3L/Gm/ePneJ4+E5glb4bs1dssLjEJWiKLpQlIy4Dk+4SykBrha+5U02xZmMmRr9iS4tq5mgOjlvTIf1lmmIdms2zDhqfETcHlErqQHsvL7b+42BE/ZCZ2z8BN0qTX3//W1Xaf4CId34y+TLtQ4r1KiElaWMS8RIdPzKEJ3wa6AigAX6b/ZbkOZ/jsBDo1rIYDjux7ZrETIbnITxmI8wyapX3hR/BOAoK/ykAr3WXEaMSFJCmTO1oVUfXPucqUZcAFiowA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8296.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(41300700001)(44832011)(7416002)(5660300002)(8936002)(316002)(66556008)(66946007)(6486002)(478600001)(4326008)(8676002)(66476007)(186003)(6512007)(26005)(2616005)(86362001)(1076003)(83380400001)(921005)(6666004)(6506007)(52116002)(2906002)(38350700002)(38100700002)(36756003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+wHp3n3MnLpZtSR6jF7YwzDL7HuijguWK1xdpAIICbegBLRcRAQpLNHr2+Ek?=
 =?us-ascii?Q?CKfGllgbLaRklu61bjbrnedxDOBy1iqhOtmKc+58c80B13F2jCCXpPtBLudZ?=
 =?us-ascii?Q?dBWvyiicxC/i4CaMZmtsfvPN4nxPHM8YUGUVeTe0xwR7FbnFcibJQnjPi3W6?=
 =?us-ascii?Q?rXw/7KMm33Jc6pzIBs9fatp9egPe/mnLT5hagrmekXLTLhaaU4aXEpcbtkfR?=
 =?us-ascii?Q?peZrEKK1QYsnNRyGG2T6sDTINrA9k9bSh8hJvRaRdglkQMy3d9DGHu/Kn/CJ?=
 =?us-ascii?Q?s2QOCrAy09BU8T4zvxbRjapfqeBskA3USNab7MH+EerWlBTtW6VV4IC4GyFf?=
 =?us-ascii?Q?dOYLSvMXbrdq8JA3VgU5ok4z/tD4w1hVaj7Hbh14BCOftcGH669K0wpHyLNx?=
 =?us-ascii?Q?ew39ogeH0RBH3LlCUBo2I83ocSC9txAIDSSyvigPDnujNuoxiEPbMRuoTvHy?=
 =?us-ascii?Q?DCCwqGJuEqBoQvd9/bmuHa6na9w78B6xTWZT3JmQ+Cj7crEuLSd3csYTAZDo?=
 =?us-ascii?Q?ioMcCx+S7huz27dLHIIcKDPw8RQhxOWEKV835X5AsJHb7mTtXQeWUht3Wmiu?=
 =?us-ascii?Q?R/pAFvYeOFDNGlLX96NXPqIArXF/zrKvbiUe82rsYe8HjM7wcM3tfm5ecHv2?=
 =?us-ascii?Q?gu54+5zEpCLjtyD+JvgEYGXqIyz9DxuWy/8032s0aKccca5i/V+rtvptbit9?=
 =?us-ascii?Q?mRB8IgPCeY6eAochyWkTZzoPFN2OYcHBWcDgyUqcY6RTJFn9l4RyIsQVU0FC?=
 =?us-ascii?Q?f2ZVPahse0K+Udd0exnsH0QmB38kjk1XBkzrQp+XuwIWszKGxPbxudg9FqX7?=
 =?us-ascii?Q?1iseM4iDvUc4S9dYhd4rK/loXGdglsnk0q9EIN4Jr3dCsJskgoGDcuHHHAfR?=
 =?us-ascii?Q?Q+uNpFC59nPhvs7cdpvF0WDAyh/vAF8VsFdC9pwWU/X7pp8Hr6euWJXx0nAp?=
 =?us-ascii?Q?XUZBNgJrtnVkMaG6zMwgM7h8tfd0XyiUS+uexWJObBTDfF5vHWK3jBSWO1Iv?=
 =?us-ascii?Q?Kcq/FOgjgditrt36xNKCHFfGOVqhzsJNhvBqDLRAz3wC4+mGdZvNgrINDyXa?=
 =?us-ascii?Q?Bp8ZQBmw8zoDoRF/uGwolc3i2NMO+7f62TSnhxvd31T/N+t+MGvu50DAbYdx?=
 =?us-ascii?Q?b3LKkLv97BvT9OxauZaJZFw4ZvE6jwhYCvyC/xtgOow4Hx24YrHrMYeVbR+C?=
 =?us-ascii?Q?xAdnPuWNSzuBovhE9WtuzOmZUf3Rq0mS4IZdapUMQ1GAsuwSP3p+vtEaU24A?=
 =?us-ascii?Q?7NVMdMiJqwS0+6mGSfHRIzUwq2vNcVEd1DwLA/NFsGP3AkIHJYWEgN+tIzU/?=
 =?us-ascii?Q?76K1M6A73Nh9vQJLSePHdnaQETc+i4swBebRKNQgq4Q51eIjf4FdxJvue0Cm?=
 =?us-ascii?Q?pUzoj4MjY60qksral9CNCxiRHl1D8mh97BhVkcd7yy2Sck+UM5n688PlZbLh?=
 =?us-ascii?Q?VugpaShFHOjAv1gQo3or5vu5TsMAevihnbwobfg1Ikf2TS6ZKHbFwGjwj0au?=
 =?us-ascii?Q?8GGBGisY34k2vESd/7buWr5llKDsUZe9AwQg89nkLZGmEsHLDpPwU/uGZzya?=
 =?us-ascii?Q?cjWL+5ajL3xQAdJ6UxoXQFAYFQ1DIpkNXhfOaP1EjqRkSj7TMtIhn0zfH3Ol?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29edbe54-5513-4b1d-205f-08da8430314f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8296.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 11:19:34.8318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKaBwvMUsiDHkKe2TERVKG2I3TfKfAlFLMdzlALVKlVDM4nv77mLX7Jucq119MQO123K3cGAvV9fxI6Ec17lZVKS8NARxPAgjhhyZ8pNed0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9594
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue:
While servicing interrupt, if the IRQ happens to be because of a SEED_DONE
due to a previous boot stage, you end up completing the completion
prematurely, hence causing kernel to crash while booting.

Fix:
Moving IRQ handler registering after imx_rngc_irq_mask_clear()

Fixes: 1d5449445bd0 (hwrng: mx-rngc - add a driver for Freescale RNGC)
Signed-off-by: Kshitiz Varshney <kshitiz.varshney@nxp.com>
---
 drivers/char/hw_random/imx-rngc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 53e571c4f283..0b71ed850809 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -272,14 +272,6 @@ static int imx_rngc_probe(struct platform_device *pdev)
 
 	init_completion(&rngc->rng_op_done);
 
-	ret = devm_request_irq(&pdev->dev,
-			irq, imx_rngc_irq, 0, pdev->name, (void *)rngc);
-	if (ret) {
-		dev_err(rngc->dev, "Can't get interrupt working.\n");
-		goto err;
-	}
-
-
 	rngc->rng.name = pdev->name;
 	rngc->rng.init = imx_rngc_init;
 	rngc->rng.read = imx_rngc_read;
@@ -291,6 +283,14 @@ static int imx_rngc_probe(struct platform_device *pdev)
 
 	imx_rngc_irq_mask_clear(rngc);
 
+
+	ret = devm_request_irq(&pdev->dev,
+			irq, imx_rngc_irq, 0, pdev->name, (void *)rngc);
+
+	if (ret) {
+		dev_err(rngc->dev, "Can't get interrupt working.\n");
+		goto err;
+	}
 	if (self_test) {
 		ret = imx_rngc_self_test(rngc);
 		if (ret) {
-- 
2.25.1

