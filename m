Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3CE4CBE2F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiCCMv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiCCMvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:51:54 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300132.outbound.protection.outlook.com [40.107.130.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC8B184B63;
        Thu,  3 Mar 2022 04:51:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp/gPaX9Q/si6YLIYTdhBlCRDvAS16wZ3Q8VQdJ0eYio07W3e4AfdYBF0VGRFQa1XefdX48gHKQDR6zxa2pWIXUFlnRNQUQs1EU/vx1bwTQuin/EAuudgwerjVWvOu7cMpce1AfHPIqbDXmhLU5yBnLk5NmmyFDsZzgDgbb3iOgo9HoKhDJPEK4PnNPo/GIhLjK/I+8ug8Ugo5qgE5ZmYNFTm5GetN/yLFljuT7mWWJ43ZiihNpaq2ulm4hdpZwJH0n71fdc++WUtCYnoO8LgTTTFceLkVtYH+QVLa98N8cuZzPuFiWiBqqUF3hTU1AkRJ4pp2i0TXq3W8n+I3t4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L32B4Jp0XrZ5WSuC0/s7srnTsgaWQmQWyHN0Ay0au4=;
 b=kyTIqxsuaE5wGvUjRgosfaAjykoV01XpBmuXcQsXK9ySFZr7eYr1q72ORTeHO8v05OVJOtdYBcJg9UJAUiuwvcuUjisQG7apT8w/q5HDCZj+Eh/uBm5ZquYaPdPNKIky2MZRLu+SjmFE7VMazKE0jzd9JaL8QM75y4PKjZpw4I1dwrgF/9IjNxVwwBwYRXJFFd9j6bGiVCNfMs9ZVBWzYkhbqPQ1fewpsaqpXjtnn+1Gari9hQoVPz7tYQctkt5AuWycvfV4qC9dtZnUqe4w6UoMGvxjuMAE9s+QnzE8j8sbG9JiDf8+aUp6a5aPuT4RXVikkfX2thR0vwmEclwbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L32B4Jp0XrZ5WSuC0/s7srnTsgaWQmQWyHN0Ay0au4=;
 b=ECKGD1s26BKuq0GWpMjgbuKtjrICJ+l0kNWHgZW7KRfXdkArVqqTUbO01qZH1vsPRNk1PEQ7sE8bJaxyROVRTGiFFlr+pwxttymNk0gH0zuvV4MF+kNyDGXhFQOle6kxlVBPUq1fNrTpVx1nYjMtfuf8QcDk8o0CMVi+XNtbRoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SG2PR06MB3869.apcprd06.prod.outlook.com (2603:1096:4:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 12:51:05 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 12:51:05 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] spi: cadence: fix platform_get_irq.cocci warning
Date:   Thu,  3 Mar 2022 04:50:54 -0800
Message-Id: <20220303125054.3574-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 601175c5-a52f-4069-fef2-08d9fd147b18
X-MS-TrafficTypeDiagnostic: SG2PR06MB3869:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB3869C1262E3878527CA996ECA2049@SG2PR06MB3869.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72U9XlF3Ctj7kJVG7T8KgkgSV634rnmxF7ttJndlRpRdVLM0C7SnVIpLDIlWsMgYi3krTL+garN5dFkUli9nMV2THIZB++NME5AVH8yYCwjCiiFjk5Cb7lV3L/dD54pmd1IG8MDgwdVydMTJDy+BkG6rWhZUbmUSPXlBS3gxu2wZXOtLsxYB6C7aaDhGlGlOiLW1mKZUGJwyN5CXQDNZ+ZnxnHOoSWiHuqRh0S6jymmRYl5YN+FFo08y3Z2FndxPL/88ce9EbQ+qLWN+FDDE8i2Vey4Ay+1p/ReStTYSwF1tJnbr6M9rSQtDJ7N5YbH87O1OPeDZdQGlUuK0wgTirY1/6BqELYsLf+7S8vTdcYUNgp1tZhbwJokKK3N1Xhq0NcYCuU0V/s/FRCXhGBJmA6iQyHefm8/aEH11tffmv2AqWndDd53tYqRp9nXgh5KPMSj+5BGh4+9Tx8//NIk6KQiPva2FYwpi6k6jKHq/1zZo4oERqFQfry9X4NTjXx06oNIItY6DcwRBSyWUQkA1aAUL5n8Sa6WqEZcJ1YUh/OSzeSQ+gZDB2D8B3Uu8IYHYrzblciBvHNRIYDUdQ9l963KWPnx3kcKp5Ja5fF7PMZcO14ZXxp6oKiUNituKW1JRr7DxEXWNMWJMGHTLg6cPEoigpg+sinuMvtuXIUPSBKT1X2y2gONsJtcVSNxBd+UQBNthWEs11dwF388yemVsyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(6512007)(5660300002)(316002)(38350700002)(1076003)(38100700002)(2616005)(83380400001)(36756003)(2906002)(6506007)(52116002)(86362001)(8936002)(6666004)(4744005)(66476007)(66556008)(8676002)(4326008)(508600001)(66946007)(26005)(186003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jev8V2FqS33jJVH6mpFChuEkQhUQSlMAInlP3kfHyS+FQbtS95op0jMB3RKj?=
 =?us-ascii?Q?NH9kDrugbHD4HsF/xFxn1Ale2S6FcbzlTh3Q/hJ701nQjHKFsAUXHtMDFGtv?=
 =?us-ascii?Q?H/jxnsq1vlvbiKXTfbv4guabK0iV6jEeAMKW1uexnr77JYNs5NHwcw/Vdjn4?=
 =?us-ascii?Q?9X1PRzEuzs7+a4dqNoPHxzrgGTSVU7FxxyZ5ANcmPZyUL6hzFF6/L0wov8SH?=
 =?us-ascii?Q?Klkx5S2GP0qyfFSRN/hm6aiTGs3YTJHcjj65a062K3bdJGI69rPsd0xXbe6z?=
 =?us-ascii?Q?b+18362fe9XWREJbLdi+GFGFoj2Y+QgF4fkz1mssdHUEuYA43XXMj6o/gwNF?=
 =?us-ascii?Q?XkU+CiP01n2R9BP5vDOhT+NcndG43cWC5wApfbJ8wE22qBBRxuyCdMaVr356?=
 =?us-ascii?Q?Z7haxs7ENFPTiiWE1/41fcpC243qR79G+SpRfaECc0OtSE8GNTjP6OQAM0R9?=
 =?us-ascii?Q?aEKup7GX13EiIvEEc9PX/Be/7ldG+UVCNHzZmsdDu+PINmtOYgtwU9Svilgp?=
 =?us-ascii?Q?F8Tup9arkfLMKyBfGhGplCVjmjnBZkoOvX9SBSjyUmUJHipvZyl/smvjTKVD?=
 =?us-ascii?Q?Zyos7ukXnYHnXFTNOKd6Lu0IdE72o4IgNndbLToI8PMCAnz+2g/m2JD8ndU1?=
 =?us-ascii?Q?Fl83HqsIj8N0uPL9IxuHBLKY8SwQR6UMc06ueevSidc3IQg+9lxN2RF19vTP?=
 =?us-ascii?Q?mqrUs4BWDKOXbEn7P/egyap5TQWGvjR1majkSs4KC1FmeLyFaewEylvjRHpi?=
 =?us-ascii?Q?v0oTW9l4H7m2LfzYFdvL07uT6NeQ8lEe6ktWkaqNN7mR6ANX+XThubJ8ZfDD?=
 =?us-ascii?Q?1Ao8N6kQgvWRxVfLfSui1Tk9v7mLUYdt/PpqWtl8hB25BoR10qP1dluz+50l?=
 =?us-ascii?Q?Wwyd7zPQ/kkha9gJqdSMpE9DNX9WXsnkcXB7O/gbPTSATskqbZLoHC13cM0j?=
 =?us-ascii?Q?65i8n502trhYm/rYKHkCg7O+if/ZaOtYF79DADHN9QZ7309gqLEmiwPulP6C?=
 =?us-ascii?Q?w+uS9rctFgpDFkN771kzzVfvk3TpEanEiaVpcmZV0EKwSoCPl+Huob3USwXH?=
 =?us-ascii?Q?l+/TZwqlg6O/t1w3yx+tosQuskHbDmHVats0PNAiZ8S+Q495mDYlxfE9ta+f?=
 =?us-ascii?Q?p+R30Up4XBXyKtAwwf72x4je4K2NTLvjzGGZ5PRpdtcqMjeV1Ab59XG19VH5?=
 =?us-ascii?Q?PNuaS/nPnkcqTdhYjggk9ykjqEV5yf8ss9I+el9FwqK3gQw4SxBeVOgcyrwJ?=
 =?us-ascii?Q?uU+XOzWm7YFj9jNBsEzCaBwcH2zq1KUcg9zLxr4HD+GwetmVPPyTv9Qa5hNa?=
 =?us-ascii?Q?/MNJX91VqkZyPvdebvQK4hli8E3jvpxsyGkJVWUUiboFJkotdTOc0YLUy3Zw?=
 =?us-ascii?Q?KDdaK1+V7E5KYRFdPd7cvcDSgvpJsIrlamJtXysS7+YTBFp/W/4d1HBaJlop?=
 =?us-ascii?Q?fUyZ3ZUTDmvbfDEX9+pgFUm7C1WaFwtu2TjsS8sjGcrrNs/PQRWrFKHL8Xyk?=
 =?us-ascii?Q?3pnU+C7R0TA1+1OKkTSUdTIJIkOVDpcynjxkvjZcY28qnQpCqqyIKov24e1V?=
 =?us-ascii?Q?M+G95RoCLFPWtfUkAYfqH3dNRk9FF+sqyK2Abtu/xSH+/rIqgphlFqCuwWP9?=
 =?us-ascii?Q?psWIbWJIoIBmG/bV64MT410=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601175c5-a52f-4069-fef2-08d9fd147b18
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 12:51:05.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsTDQ1zRaiuCL9WinVB/YLAtMISfpnCoT0MrEjIXTFxCRLaaPOvQ5XCI03hG4Le42QgWJpXWlDfB5Fbb7L2utw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3869
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
 drivers/spi/spi-cadence-xspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 4bc1b93fc276..3ab19be83095 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -578,10 +578,8 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	}
 
 	cdns_xspi->irq = platform_get_irq(pdev, 0);
-	if (cdns_xspi->irq < 0) {
-		dev_err(dev, "Failed to get IRQ\n");
+	if (cdns_xspi->irq < 0)
 		return -ENXIO;
-	}
 
 	ret = devm_request_irq(dev, cdns_xspi->irq, cdns_xspi_irq_handler,
 			       IRQF_SHARED, pdev->name, cdns_xspi);
-- 
2.17.1

