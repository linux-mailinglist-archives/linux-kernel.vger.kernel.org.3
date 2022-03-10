Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07694D3F46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 03:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiCJCiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 21:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiCJCiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 21:38:07 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACCA11B5D3;
        Wed,  9 Mar 2022 18:37:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAW5cPo9m9HwzzeWy++vYMtrtYoYtV8/R8bun3ay+ttmjKUq5ubOCyNp1afs7lvmRo9sSIvhdMqoYKukI1XuZMMmDMq+8bx2dUJmCOCFJhFHLj3KDquYKsALKIngpCaS+iLpmJuTQ7MTCXKUzsfeqIj+kiHupMw/6nAtXzXNMmHKLS9nJHNFA+sGLW5hPxhNGUN4jbBt8vBimabI9rIGz6W8H6F/NaTeR3RGOdQriKQpeltXmmxw1eBsw/q36UCu3UlhBlwE6uq0oifFHJ4fsnQSvBkOLXCgfBuKMLlnSaX9zCb2K4wwtApoDOeqLVVxGRASJWrzp11yJAx7mZkxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xX2UvrUHXsghGFGUN8G7XEEuaNPiMx2PY5AkqKFSe0=;
 b=l67ngrsaxZuCL5KMNohdWuWeEfRIu3UEla42C/akYn5mirdmty1WjA4Ilz2+Gf8qaMFrprbafcVfujntGEI6lFCTY+RdpZJNPAFLP0ud6K2drNj/g3EfVqFh5OkAvAfKFCLBApuYxig2UJrPeF8OUPm+8t2WTzwd2B3425eso9BDQ42mREuWuA7GrFUhJVm5cuk8sLKs1a1/tiBsUyX4qnlIwooHVsc07qEz/N3nKDIvVm/YvmFXz5WB+ykkq3iWQIwFAhN0IdMl2jO2NY11ecL0EAC3K6hZ9kUDUmJI2ZkpZPmjuWcpI5aXcmlUhWIe5gzS6/aa6/Mn+VHtKlcvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xX2UvrUHXsghGFGUN8G7XEEuaNPiMx2PY5AkqKFSe0=;
 b=Mv8pK1pOdlaMfLQ0s/llyPHYS9Jy3Fn+jTkgxOyirRXIpYKpjKnhXgMHmxx2y9ZyfVx/9IF+b6UmHjqvILPU4Em2KsgkMeaUh/VRQBDcv/N+0eVWk1zPZyf8YXgXWn7lPXKhMioIBwUoJWsvyJhIo13iTBSD6Ky3EgyUh4Ib0f0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY0PR06MB5355.apcprd06.prod.outlook.com (2603:1096:400:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 02:37:02 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 02:37:02 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] media: platform: mtk-vcodec: fix platform_get_irq.cocci warning
Date:   Wed,  9 Mar 2022 18:36:45 -0800
Message-Id: <20220310023645.10082-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:3:2::14) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a7ba819-377e-47f4-9b23-08da023edbb2
X-MS-TrafficTypeDiagnostic: TY0PR06MB5355:EE_
X-Microsoft-Antispam-PRVS: <TY0PR06MB53559687438278D4054C050DA20B9@TY0PR06MB5355.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2Gzh3ssmc1x1Sk+QpsOkEdY/BY3oK8OYjnBM2G9P/soreijYLOhQuyPcL0rkQvunEeUQvXDF993ZX2IGZ8ze1rVqW4g+jnWKF218lgXJhxjVa8rre9X2NNGgxSGVZF3MXPbCD4b5H/sjXrQECjhgKP8OxlmLRgwL8ahypMtV5Q42XGMrp2aDh63S8kRTueerk3XvR4MaBlb+rscDxuetrEFgITGZW+L1CiMqx1dxX+LhFlPzBXlRVeXfJG6+JuBFlmS2oOootkOjz6KLFyf2MzlTT6XnHkGwz0XYald65YUlXyUR/8vlYMc1pmDRov48bnpE066lVYxARAOAbreNQ62gRC5pLowToZtlqCGX02G0PWPEVBysrZXmxXDfGfSo8lk0I1pzm2HRoYMqVf1kSR7Vqp5EPe2cig/WqQsFcS/unE9SzLnvniv2WNOqyaXiINZZYbgLsUi0vgveNDFXC9y/Ps9AqOvWlQ5TYIG9XNEm/JdieEJxLCCstOLHuttk6aen7OiEUZqwGIhw9Jyax24+v8jaE5hYmq2pmQhKvf8JXAEr2F9P1q7TrlxwFZMtlQ5BWgsmwnWETXUU6X2EM5gjkn5Q8jdAer3GUcKATjtd+PaFkiuvtIkS50WxOwmY7bYkDlIS1FabAa5CnGAn95+stYu+MhwFxuIpGFdnyksYJZmY8TmKlnvb7oaIbdSu7hJxs74UgZw5cDTS6PDXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(110136005)(66946007)(6506007)(52116002)(83380400001)(316002)(38100700002)(66476007)(38350700002)(66556008)(4326008)(8676002)(6512007)(6666004)(2906002)(1076003)(36756003)(2616005)(4744005)(26005)(5660300002)(6486002)(508600001)(186003)(8936002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9PRJ0ybPaQO4WDF9eFulaQrOBjhmjbJ5CcmGo5KUHIf9lVmKGjsAwkjIdP2i?=
 =?us-ascii?Q?44ixx5d2k79wOzgw/w8fVKdLaFwhormAvytTXnShWLKn/MtOyhKxB0SdklY5?=
 =?us-ascii?Q?eg6Jd/ogoYaUi8H8AYFmy5ayz2clzo/xLhyy42Eu4xbcCwxBkVK5BONOuB3a?=
 =?us-ascii?Q?9s8GYbCOVBPwdYgMul6n6lsjeidStqQ1Y4rGf//BXQ6oCOBMsVCl47f+MoVS?=
 =?us-ascii?Q?EvtXWDyH42uLZgR/9S8l8bYVHIKgpjeJh63lvSYBrnmp+XCLjx2KmgZbH+9w?=
 =?us-ascii?Q?UVly5vzkCVSDpPdroVpXRTTtOK8nlU6xx1sdtq81kqWGsE5aGxvoRhbhFi/+?=
 =?us-ascii?Q?9sQljXl/2E5dBV45KNmcccDKuQey4CR+MmfAmQrDdgBNeeuvfwBoHRyK4Sqd?=
 =?us-ascii?Q?yCe0Hv9jv+1TITSxw8XQkMBSO8stp7llvsrRineu3dXLX9ji4iVis6L2IpCE?=
 =?us-ascii?Q?6n1QglxGBYJsW/KVhy5EJvAhZvL64QOBZteQlYFrRIDqlzPhO5amj+QLsLsP?=
 =?us-ascii?Q?1mkw4BoRdsO12HLh/IDIsXad4OlSOs5ITxtk0FPqaAlTfXpx1JhMYnzbFtho?=
 =?us-ascii?Q?XBHrUAZtoD5OPfuQpjwKPSnPqSBqVxxULVZ7/cHE6Y58PsptBC26sAbJs28z?=
 =?us-ascii?Q?B+2XFwqbMgCQpPJ5qSC//4MUR82EFi85zS/TjWfi9lGyiMCmRaBFq/ID+tjh?=
 =?us-ascii?Q?ihfg37lKQxTwOSC29H0C0qmzuW4lTyov5J+5UQCTCWbaExEJcvHPVEa7Wnms?=
 =?us-ascii?Q?kDVAPrZUUWxrceI/ScUf6eNzNUBvwAoSBcwyFZj1oOwRwuE6rSw9onYA/UsW?=
 =?us-ascii?Q?7VJ/mh41KkZkLKmXO87L8ckjRNGTYnvYFJEIzoBwg9XPgW2cqpdSFzUIPMON?=
 =?us-ascii?Q?MzvXPnyJHT4lMvkmCs4QFGVYzPcd3RcJHzRM7pFOAxD7NlAtZO3oT65BcR0x?=
 =?us-ascii?Q?UY2A5TWyDBd00+7J4+GxzR+oiZDcjjOltJ8TbkyYGjvD9prc03gy/JOAPqG0?=
 =?us-ascii?Q?9V7OFAm5HXkQAH0qSuyjcyA0R7AB9XGTVSWOjrT7TBn80E672bS8UGKJyVie?=
 =?us-ascii?Q?YsKdu1fCkRDWJgOUR/VPd1zka9MgXNHE2ougxVASGFICQq5tvQvwumtVV1UX?=
 =?us-ascii?Q?6qe1O/5LL+blGDH2xxzy7YkLuv0J2ks0odc2ZzJAnsg2B9UFw8cED0UNOpSR?=
 =?us-ascii?Q?5LdyEUHKwsRaq7vp/kpGc6f9lCa450vYAUzGVR4Wfi+PfF/o6EMO0nqGEYuj?=
 =?us-ascii?Q?MkylBFfpwL1wuwplUnyXUif7lwsA6saBadDNaG7OYFK3k3/Re1uKgBF879pu?=
 =?us-ascii?Q?Y76nC2OKAlcXPisi1MaTcRQuft2HtF41jpp67fT0IlvHuocsq0S6xxDKag/m?=
 =?us-ascii?Q?qlWHCErxMsaZlAAY6YW2ikqyN3sc70VnSgTzElPLC6puV2kyYOse6DPEvg3T?=
 =?us-ascii?Q?mjGSSG7afxQ/Glb/nmrYhlzSS2+/riIJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7ba819-377e-47f4-9b23-08da023edbb2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 02:37:02.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lk9Xr8ud0sld5f9dhZF9b/fce1tyN6ttSKygdR64wqXOn+/5bjvnY5u2o7MZQF5G629Dec/GGPb01/pNRQMgKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5355
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dev_err() messages after platform_get_irq*() failures.
platform_get_irq() already prints an error.

Generated by: scripts/coccinelle/api/platform_get_irq.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index 48dad9bb13d2..df7b25e9cbc8 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -115,10 +115,8 @@ static int mtk_vcodec_init_dec_resources(struct mtk_vcodec_dev *dev)
 		return 0;
 
 	dev->dec_irq = platform_get_irq(pdev, 0);
-	if (dev->dec_irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq number");
+	if (dev->dec_irq < 0)
 		return dev->dec_irq;
-	}
 
 	irq_set_status_flags(dev->dec_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->dec_irq,
-- 
2.17.1

