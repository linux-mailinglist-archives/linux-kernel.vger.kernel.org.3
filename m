Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1E4C9B43
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbiCBCgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiCBCgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:36:02 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2112.outbound.protection.outlook.com [40.107.215.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FABA9A69;
        Tue,  1 Mar 2022 18:35:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhWk/ppKTKHOoTv7542UOhkw1cGJi4q4+Kv75owPBwcVtOkuH1XsgMcN0rDmkC2pOIz1iUG+MA1OBTTndGmpfxw0gsSfDLuITfSIzdwZfzyKhtG6zNZF3LilIdwRaFaxpckO92xJYcubadwI6DhlLNySW+wUJd0VYlZi6fclsWPqsnGHgQCqH5Eeh455Tp2f1/7LdNOKswV/wjuCByAqC+Vky7fEYJJa4mL/UqSiWyxCpfzfawHzEsJCv2cEwDeOo+3m8MJpGXXsJGV8aPpET2j3roAfdLw+ZKHrHOwdZiwTLQHYAvEx8s3m3TIeyuyo0suUTs2nyDC/eg4DTrGLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+DxXzz4ec4+07R3rtU7CChf0eFTD9u+qPrFqSgFUmg=;
 b=GKdXd7sxqZs2cVyD8MkKp5tQdPUBq21RLcqfpKJlVDZdJ1xBKBPJL0xYIqq1FYrKE03m0Ki1D9zXNnn5Qd9RWa68u62EO2TFFREPaZF6KRrj41M7SdublCtSoHC12fuUkVxl6lklnZVnL/JHiDVfzuzh4cfEJzicnQsTv2FwcrKKGlDirHefd2x/7WESlO3ddTb927TUj/Lhjq2t4GZv6MjJleDElPeu9Lq0IhKmKBVbg/K3CpNPT5J65sGHCweORGX6AskFq75FfvnqGMizfJnFKtXBDli2B9QjGJGeFUxtCI017Woa+oe1qyexhURRSaLeV69mVlVzHyQIiOMEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+DxXzz4ec4+07R3rtU7CChf0eFTD9u+qPrFqSgFUmg=;
 b=ECZ1f5u4j1b/fOPosbbURgitlEHUfkjj6CKlTsGWXuDKoWFKzIgIu1N9fCS+oWQg+KtbFMCOiqicYvxlQd0uoQlRbrXSVFaD3FYW89x9HpmjgJeys3wWF3BdGVwp1yjl4NXQvjU3dvfmGZXufMU0fdHx43Dvnse3shcIIOv6yww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TYAPR06MB2382.apcprd06.prod.outlook.com (2603:1096:404:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 02:35:15 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 02:35:15 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] power: supply: axp20x_usb_power: fix platform_get_irq.cocci warnings
Date:   Tue,  1 Mar 2022 18:34:51 -0800
Message-Id: <20220302023451.5040-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45689991-c78a-4602-fa33-08d9fbf548a5
X-MS-TrafficTypeDiagnostic: TYAPR06MB2382:EE_
X-Microsoft-Antispam-PRVS: <TYAPR06MB2382E81539333C4527FC659AA2039@TYAPR06MB2382.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBX+5ukf23o6JCn7u/vHVv862SACPovU5TzHLOmS03wBDNjYNq44GPo8/qpByNmE//IhJ7ycRE/IEvMdTTQ6MhFdAn9bz6zYGDHADIR7ci0GP7oQ5wxs2sm68koZTuHMWJ7YvHt7/agxjPmpREDU6tB04Fxqw7dNNZKUacOpz3JHQBdNFfx7JX64yDK1qwVsSqJueR6aVcAlUyXxyIPsuZqJ/EqoAjR/xFGoWCPQRFWXPXUbhtqmsI3n7D73GbSYkNBhpgWj/uTRN/7dusz667kFeNPbnFnCggZ2VhWFskZ60sICVjsBX6QM2SehkusAjRmWPcajTGXO2lBauA6jGBwRfvEEyQP4VqT+zj8KeQh/A9wUUnlMGawppmW7+PXAIBL4PGil0I5La/UM3lDSQhIAhIGGDeOar7n3oLPCGIuyTRPr30EXJTwDpOKFdvwNoiJqvyXJLv+zDkmXqB9pYWpBIaBVoie6lbOkyIJ2TBO3TzFhqa8uYAYSdb6VFb2LiMX++dBdJ77Mc+ZBKAAd7l7g27aBTjrtcI8BBcysU1r+sAKBR1bZdSG8yha2aqM9p4IKhxBpOWPAwaPCPKFG/5bIS2fDXygCiqABt4Yso6DebFkqdbUPPtmFLJXHp1h1ngevR1+BsDCFLjqNRfDbuhbywQd1rgVcmvX37PIMmR2lYenTQokDFH/Ma3oBpGcfucotVBzjRHUC3CBn8gLUqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(86362001)(8936002)(8676002)(4326008)(66476007)(66556008)(66946007)(4744005)(2906002)(6486002)(508600001)(5660300002)(110136005)(38350700002)(38100700002)(316002)(6666004)(6506007)(52116002)(83380400001)(6512007)(2616005)(26005)(186003)(1076003)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KrpMa9HPCAIQhDKuMVBV6hnMuncm5tHMY9Yj/yaWm3Tlq4D4ascA4KC8wP0i?=
 =?us-ascii?Q?uE7EKaXTud9njoQYVbtLuZ6HD/YsXeAJcqIYjngYGEizhGgWOEKwzW6ZsfpP?=
 =?us-ascii?Q?i3MFhq6Bmu4RZ+w2ZJO5vRkJB8JmOMQ3VScGOlrOzVwKbNjg+z4saD8vRAv2?=
 =?us-ascii?Q?Sm1SY1Kg5t28bnPcLoyJzKs6o74/s7MuMOyL+E+tHKpLLDEYeDUvBakSfS4Y?=
 =?us-ascii?Q?Q1MnerpMDadukqmtMszNRxppjOc2VYa0DLNveNRkXI2Y7jKCq7LPTBjFEGFf?=
 =?us-ascii?Q?5wAgm06N4m9vnMiJDjcVURTaLcwVGWofxs+oCMZicA8tWl7r+2CNvOpqVVrF?=
 =?us-ascii?Q?NKHnvzTgRbKQRsAp3rzvcwupf9huLUdiI1+WMgDGNNFzXe5VTWlyafN2/Y/t?=
 =?us-ascii?Q?zOLDoD0U5uhceT4a5obwmn74L9EdFfJVfL+p6V2WWILGlJtADicvkpfLDe1J?=
 =?us-ascii?Q?6LVV3cwLr+ih+ef9aCKJ7Z3HNvwLkZCs6jgcJ3J2RVQ2EreAJgTYpeMgDOry?=
 =?us-ascii?Q?7KY2hEj7f7+Cos3N6zpMVD8ZeBkLW3RYaVi1RhPtOPOoPya5IRRBLID3OTIr?=
 =?us-ascii?Q?br+G8jkOYfeR6nkd3cpFouSNpd8jIrDnfUrpyGRfpwNU5qKlXV97fTknmD0r?=
 =?us-ascii?Q?Jx6PI1Czp9GuyDZDZe1fzAinKM5zrLtmNJc8p26QpnIquGTUpCgEuhjRbm/9?=
 =?us-ascii?Q?9GwRqo1i6vUtStC9JjtI99odDfAfP+w5Cpd2qYe6H3ob6Xg9kwRYSJdk0NeM?=
 =?us-ascii?Q?jVa5voXtDRcaW/yv0UxoTgGHEK//S5dgnwX+HtFtbDULQbwC91EHT+97jJpc?=
 =?us-ascii?Q?1pl5CZy7tHDKc5HPaMLwTuLf0L09zfrq9yOCx2SSnIHrMxTNsxp7p1PnR57M?=
 =?us-ascii?Q?PgYfh3DRXmwEMD89yr88N8JMrhJivVmiydpBHsK4az8A3QiLoDu9O8b7Yqip?=
 =?us-ascii?Q?FGUiYoY+2Uzq9t64iB+UeYlqKBBRmI5aRZvIJxd3CsUxG+c3h+dSI7oCvqAp?=
 =?us-ascii?Q?OJiohAK09+yY1tduFW/1ymXaaO+ebJE5hDeNQYnz3nKrarXdIMGieXmhxB19?=
 =?us-ascii?Q?hoZjgFw5shckbW7jEe3L34kbGnVvWTWP6o+MUHP58rHYubMQoC3oH2p3a+zz?=
 =?us-ascii?Q?6tE8JAi/PcRil8EtRiHV7YbLE3CkWKWB68YANN70ds+JLg2lj/1ziVym8Fm2?=
 =?us-ascii?Q?aCORMdUyQMHibp+SLZg4nUTQaRHsuyvnJ2Jx1JIq6OZK1DUbTnRWUicdDEs1?=
 =?us-ascii?Q?yGN5IzH8DIv+yh182D8UsHkT301ErD/z0aeyT2fZ91mivgijPScQH0DQXwpA?=
 =?us-ascii?Q?KHgm8A0rTcKjOssMfedmNzyaRBCKuRa0ReLBeHeAb6fIC/6kPdigx+9WOzha?=
 =?us-ascii?Q?orVMA+WS0KyhGFckyUvDqqtI2z7101ZW7eE69WkMIDjpnxOxpReTiQhZWTaO?=
 =?us-ascii?Q?UQqanqFiK3/j5dE1yKz9qrjnmpLEQd7lmAEsnmgpR9X/XKVNTFYv0FDr/jff?=
 =?us-ascii?Q?n9uZENMWBg9Mnu6jXB022ow4jpBGonPFBjN3BL06Y55zLw3PyJ9OmM5Qafev?=
 =?us-ascii?Q?DRoUHDHOeZosFYq+hGyZArKm9YlgIsCt//x89JZVs8SOSpZmBEjtDGJwlPN5?=
 =?us-ascii?Q?syJRs6/ew3CZiKGH92UgH5A=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45689991-c78a-4602-fa33-08d9fbf548a5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 02:35:15.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bs+NBF/bNLbOXCjy4YT8wIna6pvrMC//R0MXlOCeiMI0qGL7YHcmYtFJMPAxLw1g4u2bx1g0GMT+rUluazdzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2382
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
 drivers/power/supply/axp20x_usb_power.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index a1d110f7ddce..75170fe79cbf 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -638,8 +638,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	for (i = 0; i < axp_data->num_irq_names; i++) {
 		irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
 		if (irq < 0) {
-			dev_err(&pdev->dev, "No IRQ for %s: %d\n",
-				axp_data->irq_names[i], irq);
 			return irq;
 		}
 		power->irqs[i] = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
-- 
2.17.1

