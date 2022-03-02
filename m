Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0354C9E12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 07:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbiCBG5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 01:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiCBG53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 01:57:29 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41ADB16D5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 22:56:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+UfqNshhrvWYElJzpZptLfqwuSHR04m37Re3aD4jSmahFOqrRrgphcWdPaZuxzzY2gtFRuwjhF5fUoWDes7HFhESeYBGoII8HM4inmwj7fyaq7BtCfPmCpyeT/v0BqeZLaBYWa0soK3Le8u5QxyuABlno2N6T4Nt9aIDZdE0mJopUzggTomspVw3hyVysb/N+SmZ1CAEX/aCeXheHvCaN4psCNNiXO/yvz+oDhwnKeFtr6U0/chtVKWbR/kL0rQzvzV4L3ofvJqJuD6a5wvRqv4nPzvC/0GXPtQp7etp15TnwGHT6SXmXkAhc8zT9kPaPNzAdGhKNmSwmrKw5/jgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iTORNleBZAKsU+Gf2U9xbWgNiNybeer8DJnX+1a7e8=;
 b=IjTvbz+Bc6hBOB4R7knaPgK531bXxs0JLwCQfhOgJEnIU/OeMPJMEwPMB1SLhrifASwsZF4nSnpTrSfT8C4u8qdWz4MDwIuBgHGpsqi94gkRFN1HKw2qmxLZeag5j7nw6OT75PGQPKnsRdIeONQGcHXHXia6VrIK9VWfwOP/eAE8Toas113MYobnOfRKMQqOWgIEX3W50F0/NL163MXz8+eCnT0mZGNitlyrBOZxHG1cIIatuDL3whGnoU8STt7Q9fPIK5LwE1+aDTKMKwL28fRxb07yDPycZaWnUBv2yGl5fQ0Mx5T0eFZcurc5arfxLRvj3tVQU3toh9kjQFGiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iTORNleBZAKsU+Gf2U9xbWgNiNybeer8DJnX+1a7e8=;
 b=CaqZ9aLGtprXWocY13Ab4RTuebqeDZ3n0gZCcLduLrMCGMl63+YnOuq27Wc8ayDzGiscoiy1sVDEZR1aRryxtA1RCbY5RnWNnPTiCnNcalLtEkjqNbouGkSaslnHUeraJhcwidJIZ8fSRPvFaNO9eMZkHYmw/nK0F5Nzzbv1xQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TYAPR06MB2365.apcprd06.prod.outlook.com (2603:1096:404:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 06:56:42 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 06:56:42 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] mfd: hi6421-spmi-pmic: fix platform_get_irq.cocci warning
Date:   Tue,  1 Mar 2022 22:56:29 -0800
Message-Id: <20220302065629.6855-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05ee9e56-8522-40e6-4634-08d9fc19ced3
X-MS-TrafficTypeDiagnostic: TYAPR06MB2365:EE_
X-Microsoft-Antispam-PRVS: <TYAPR06MB2365D85E005BC9DCCCBB8086A2039@TYAPR06MB2365.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJyhYXk1Pib1ZAHAFPGL10DIquasIYlNiA+JmaNA1fEq7ZnLNlC7cNoMdsoMcroknbnRTXf1MEAtts/T7VkGIosdVmLqx5Q2z/YvfnHvbTEShDVjf93C6V2JZMdWd6ZB/fW8FzXwE4BMpUmvfuiM5ldtBfc0hA3wM3xdSFrje0NJT50CxAkzq0GwysFSDt/sgc7pGbAIKZ3MaEKXYvjII7h4PNkFtpnGOMucXr7pwzzpfIhyohsCTvJCXx0GW0yTGAMxoX+p/7TaIseQ6UKFEusNmSHDYSl3op7hyn/qA666RLeAqLPWz97/iS7JvcxKvHSsnlDsYBYxpCuBEZUnCO3Cd8HfxI7lrwUMgunVYMC8VKtKMVbjwE1t4Uaq/3mQ+SjgP9IjRua1OICSCkOEb/5A99MVnG6s+47NcaHsjvWj6HmmN+O/k1tXHnrluu8UJ935OMzbaB4AzhAfv7+2FouwyFNPTLY2YpskazRyAuquOwTYTmVx7cbTRdQA5TsNTVn52pHvaBcH5nlruA05zbvozrgXqO9h5CuzCoBDd7VGE7miC52DV8JrRm3NXWy9o7NgHY6fnZjvkH+D8nJq4bSFQ56GWuhsTKXEWFEE9WmBt3A92/ixwl2+vY9e3iMZDOuHYr/NFdm8fN9ct6HYVTIiFYxyz8saS5w7LswggJaDdtZTvyocgB9iSH0qxY8hpqatKm4XqsjRoAzEXwg8/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(5660300002)(2906002)(38100700002)(38350700002)(4744005)(26005)(186003)(2616005)(1076003)(107886003)(110136005)(508600001)(6666004)(6512007)(6506007)(6486002)(52116002)(36756003)(66476007)(66556008)(66946007)(4326008)(8676002)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UlV/A3nkXt7Jmue3ZpdOWjlNezxs4s9q4GOHMPLEI8t5VbolU39n7rsEzU7f?=
 =?us-ascii?Q?Qu6ao9/t/ufWoz0qE1686nAYlOjDS1Qlal4H/gkMsJU8SE+9DW5PKdhd+/Gs?=
 =?us-ascii?Q?aYIlbA5TCH8FRx5B1Svr05XKys/HouV0AAPy23H5tlih+vyulKFdn8cvr1fh?=
 =?us-ascii?Q?PY5dkcwf/HCYgCNf+kQ64t96Qt5uqQhq0BggnSt1rWfcrXCNE2bZXbX/YQGf?=
 =?us-ascii?Q?T3vwqnJmFzJhWPthT9U+d4IzD0MPVnCGQ+REt5QVorAaxusfSIYqtEVpjC66?=
 =?us-ascii?Q?uGm2gH5FoNHEc6hqVtMNiWPox+hLdqaCcu8F8gIlevBSJKtO3gmvZxvPvtEY?=
 =?us-ascii?Q?EGvvl6rlz2cbVJum3xJJ1RRxxgWaSd8p+MA/AcQ5WoxhLiknjYdtt8FbVF/x?=
 =?us-ascii?Q?3Cr0zpB3OBDROB87/ZC/y2no49fG5Nsd/KSld6WKoOJ91Wbnfl4yH0/oJq+s?=
 =?us-ascii?Q?FsZ25ASSRrBBgUNgj/6Gmq9Wry2HG6MzFGoncT9mNte3yupOaOvCwrUUixt8?=
 =?us-ascii?Q?mdioYvqeFT2Q0gR7ukntS42ZOj0sH1+ZJOh+XozPUfrsQ6FhaNNl3AiBdbvi?=
 =?us-ascii?Q?pXE5K5SpjsvuAq2617URt07Za/vDCT0MfX/M47hV2Eo0PDzTRyIwyzwcaeOy?=
 =?us-ascii?Q?jxr0lIgv/6sfX3yUJmkhXujL9LNA0YNdFzPGzK7xtmPZBm9n27culmWeHAc+?=
 =?us-ascii?Q?SKcE2dSHUTQ+SCLEPFkeSK7MyIOEEgPKozO122OcBUL/x6b46lkgQ1YGgOWV?=
 =?us-ascii?Q?CmIgZIOCefwhOqcFkb+vEVHdD9yiJTDb4hUwAgydiRz8+4GRD9WWoi1xBllu?=
 =?us-ascii?Q?7eNh4Yxu+rJv5MKVWQR/qWbOKGoepPi92YxdSzgF74wwXI01vNjEKTbEtBh5?=
 =?us-ascii?Q?MBpM1z5CzokVmnjO1C3bkgTsDTzZK2vWk+xT/2AsmYUqeGsK/PbBuGIfGL5T?=
 =?us-ascii?Q?4bFmmC+UR2helLJ5OYBniRUnar+waA8PFM2jCBCgjOygCtxGnInGIysGDkHr?=
 =?us-ascii?Q?pMNM7cPXWz8ErP9CmhvkFPZuC1jz0tjNVn6UEjS6EEMJRNdo2APMtxodBQ3o?=
 =?us-ascii?Q?NGTmcSfP5enOd2l3LD/kVTrjt3qrNf6ejJpgIgU8uxo8bMFw0TV3KyKZ0SD7?=
 =?us-ascii?Q?JCiHUlj03At02JpC4JWNE8Kc8xYe9cijEIzxfTPwoRsamSdNkr8exAwwlwKm?=
 =?us-ascii?Q?n5QzFO0EgDrto8qNXGol3q7hOlMjXo5/FZnhgQpbO16c46AgDRMgGKVsrF3M?=
 =?us-ascii?Q?h9PREUP3kUYC6qIAh+xEw5eoAq5XmeRh9T0Rpc38koRnfYq3k0PA7HKq1xS9?=
 =?us-ascii?Q?m0Y/hqkv/DTZ79235UK5C1yAvqMWYM1xG7eyR+DtW4MeskMeHNBlIqtjHxN9?=
 =?us-ascii?Q?ej7N+cCoQZJZosntsJDB2kNJNFnWlKdW/AIfB8QMpiTujURbEwM5MwraCEOq?=
 =?us-ascii?Q?dA6ckpj8SsBlHO6Tg17+ed5CQjVCHM9MhJkhGB4baaU48c6mdDK1p7bsqgdO?=
 =?us-ascii?Q?zPaua+UVX/497xSWBYGpW0DDUSjXxYShnzRNwJe9xavN/AMMaVPBrEwVS1gk?=
 =?us-ascii?Q?CyYXZnojRmnixnx/oHnkpuaTtySP/6OoIY306wvjdWjLPLbwCIIOnBTidCNp?=
 =?us-ascii?Q?obBKz64Fxxyp+tHMVI7SsDo=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ee9e56-8522-40e6-4634-08d9fc19ced3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 06:56:42.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdEEhkn7eZJAliIqV1JLPMgXn8zzIruRxISPZz6SreaqF/qkCdudLho154ubdH+47r1VXDsXFSJIZWl8qI2xOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2365
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/misc/hi6421v600-irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
index 1c763796cf1f..babb85364aa9 100644
--- a/drivers/misc/hi6421v600-irq.c
+++ b/drivers/misc/hi6421v600-irq.c
@@ -244,10 +244,8 @@ static int hi6421v600_irq_probe(struct platform_device *pdev)
 	pmic_pdev = container_of(pmic_dev, struct platform_device, dev);
 
 	priv->irq = platform_get_irq(pmic_pdev, 0);
-	if (priv->irq < 0) {
-		dev_err(dev, "Error %d when getting IRQs\n", priv->irq);
+	if (priv->irq < 0)
 		return priv->irq;
-	}
 
 	platform_set_drvdata(pdev, priv);
 
-- 
2.17.1

