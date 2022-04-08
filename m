Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E054F909E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiDHIVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiDHIUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:20:50 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C847716E3;
        Fri,  8 Apr 2022 01:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6VxNlGT9Usmyp6017tSnvfF7RSHczKCWamZ0mk8q8f6YYQkmSjOCtICdE2Q2jiKCTDfCfurVBqG/agSYD9WYw0vjbUFFW5AE09IjjPzG82QqusCOQeUZ8NVDXvpTGAdHcHXNu8a5T7JxrQhuN/LpnX9VhuXn8fjrXikrS2KysndhvaXoEvUwy+P1ixB0hACtH6OCjEpeETKURHmWnVSFY05s1E2AZgu9lsn6Vd0RkhO2cwvH4j7zTQuLtU7HsZcqq2yFWaMc1Jwgn5B90GRwvjWQH+8yPzu8N3b1MnclGKg9+Ibblyp0Xq2hqZTm4gTrxcofCHZOBpEg0b0QG7pUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYD3s6Q7mX9W7qFsDHMv/eywa9RGFZbtte2pDQaAm6s=;
 b=mhYujJAyJSDLWiu+xXJY4nyhT+4dkhv0HgihG2xgF01g3PhjlnikqPJQL1JE7nuEH/pqQFkPpYpEl2uYewUscV5/wLhS59Fnf/BtUJBAWaMPmd8shFnsSIKF9TRGDNOHWcruiE4eMw/NFkGBZb4+MA0jGdneWwdo9Iq9+GhAPf54WH1CKIFeZAcasfyGiVDtUKrRecJs9CIUOpzWyxNd8gpUxkbrvbRAIkTloiN2jr0YQ4U2TogzNTYi+jJohPcV9oFvAc314B/6WLqDaJnxWnCU7Y85cD3346f0GoC/aFBI7r+oxXhCxl9ytoblH2gQtOH4RStx2csBHI58fewPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYD3s6Q7mX9W7qFsDHMv/eywa9RGFZbtte2pDQaAm6s=;
 b=Jfb8IzYYNDdvQElFzX3/XZZmT3HKHZhCdqGfzFJa2eoMOPNt6tQEDpnHJBYosQonk5j7PsOTKq8xM1S6cySm3AEgzEmV6rO7ilyReiBdduAQCheTdkL9kjQt8Lg5mN9axCsipF3otmdtX5syaIQAnGdeI7Xep2AQYl2dtl9KdPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by KL1PR0601MB4499.apcprd06.prod.outlook.com (2603:1096:820:72::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25; Fri, 8 Apr
 2022 08:18:38 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be%9]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 08:18:37 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] scsi: fcoe: simplify if-if to if-else
Date:   Fri,  8 Apr 2022 01:12:37 -0700
Message-Id: <20220408081237.14037-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::19) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46edba7e-ea77-411a-8e73-08da193861a1
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4499:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4499F5658D8137E944003E2EA2E99@KL1PR0601MB4499.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7GpC+zkOFt2MAXSBCDbWKMkZIblVzlEDnabZ2r7E9uzm4IVvQ5F3w3igtuW5dClQMrA/oqDidKEXBQUcjUBPA7emJN6ebAL+JDN0TyU8kljtd3BjFM5moj5TbCA9Vtma8CsmWlahLdr8DO7a7fc5o+gcrsaH17L8w2JX5O0qWXTTA43245YtGJ3qtKxOBS4gpl8BDrUuF84jmz0Ll3Up0yHj1tEVKtf1rdgWI0e3PeWWweQV6AdvSH63c1oHQECAbQ+apkxkPNDYrMXLrpAsYN0Tuqu8YAag7XbfV7N5HSHJjKUt5F0OjTujQQ533ZUk8yc9cV5NV3D6H4l+gVwf4sU+awhFgCnmQK0jgeIIM14Ypj1C1wCLdJuORYCrKkcZIiXwUaVb3ETWKX7RDC7GDAm7fxDnHlYHO2Lvg6yP41i8txPmAmZR6+DEJnHrB9BDZ8tKtgtdEcR+NFPLdHdXs6LN6aCNhsgJXfvFFoTVFnfEwQcSKLOesoBjB2Y540HUb1asFc/SrWXFpHVxlto10fniYL1GB8DyNz/nXotYeLLqXGJZfHI6l3NLOJdUGbl6jXjeutJA9hraAbm6tZtn5fVuPMizTrqgR6KjteU18ELz6SkUPI6uNltRaTX+Hl69ZWiAiBAXJoSArmLDTbp4Krtqu2qad9Di09Mg5axsBEkY/2bpLA0P7eUrygK0iYS+M94/wE5HfF7n3RsIrsGZUblk8eiGlDM2vzdn5BPjoT1haUKdLsjK0LY55QDdYEjbTkkZP690UR4Fn1RTnDXMuclxjYQuqItbCEBvYE9wik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(66476007)(66556008)(66946007)(8676002)(4326008)(6512007)(86362001)(52116002)(2616005)(316002)(1076003)(8936002)(107886003)(508600001)(5660300002)(110136005)(38100700002)(38350700002)(186003)(26005)(2906002)(83380400001)(36756003)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9hIIbnRUWIvANOMbSA9VaubEEor8aCffYNdfJEhvPh1LBLlYmIYwftwuLvRG?=
 =?us-ascii?Q?7ylkPXPw4p69pwi0ymVnLpG2SF+mcN2q/A3GpdjzxBaRCbv6OXKBYSSKaPrm?=
 =?us-ascii?Q?T1FzbsXiTakR8Pt2FLzY/obUtqOD3V2SC46jUSzbh+YLoCByn1PCnEjMwI3p?=
 =?us-ascii?Q?KDu12N0PxFtODGZ7y4iw4d2tPdx13Car6JXI8Hi3BM+mnG4fg8MBYo4yWmKC?=
 =?us-ascii?Q?mTQS5kjoulNoFshgDyJWme0pNORdQ703yZn8w0l3WBe1wpFp0uKHHitr0rK8?=
 =?us-ascii?Q?lAZQ81VY4DZjuun4xO7aywdZ4QzaMN2SWv4fwQdWMVx8ldPlz8c2bDFRDWk8?=
 =?us-ascii?Q?xEOLPvzYw3I2EBeVP3q5f58xgcDnblPsksuCpOhVM7NjFizzIVQs9dWHV9w2?=
 =?us-ascii?Q?Nsz1S3DPaD4ULqPuSJHJMMI9FyH0WbV6SE7OKW9BabSFDTvC0rtzm3zS0gdt?=
 =?us-ascii?Q?4tLXi+PmR6956+s4LiBd169lQR0btT6kSE2ytAAwcuq2Qafkt7KJKN1PWUia?=
 =?us-ascii?Q?QCyw5ts69jne2LLI4KKGvuseaU6c8TL8OvMFhmRSqrRhvlkKWbmaJuhKdE8A?=
 =?us-ascii?Q?rBLBCGNFA0CwTe/4Ljo9bizrXaZoPuB5M+HWGtlAzSAwgNl9okhOwO5Xjgyi?=
 =?us-ascii?Q?ZECnGq7ngqETR5sZdLNbC4u5SfkonhxpvzjnyXhvVY3tJjGGeAAMomiIOxaW?=
 =?us-ascii?Q?sRgclkBfpTOsCSVXcKn7U3wA3fdunZ6z+L8jH844acSuYR9C83z8KwRN2k+x?=
 =?us-ascii?Q?sMxX6tF7wJuG9rNCa46RN2HfOVmfMmUXzmPCq+OO/8qBPPHYmVGHgQ44o8pu?=
 =?us-ascii?Q?iJhu/TIyFcvXCjLb+VIHpovwVc6TaWxKts7CbEVWkPRAWenQ/gT2ql5Jz9nc?=
 =?us-ascii?Q?eai8oFEWtDYL05Or2D8fvwOiMH7Ia0nAys6WRX5zp17oBJoGdB9ji5L2JVxI?=
 =?us-ascii?Q?98btrV20LlUVF1Aj97bOjT3cTgk5AxM9AGqQLU1oEZSu0wwWAmBakIlF+o2i?=
 =?us-ascii?Q?SWhWycP7AJ5j79KMOvz1cy6xozjdB4P6PncwxCcIxeYdugWnwan8uKOeRTBs?=
 =?us-ascii?Q?1liG1UsPY4BTVjmh5GainXk/0R3+omYsmV9GIydAqYoz2iLTy2lek5/13F89?=
 =?us-ascii?Q?oNHT8BLdPWMYchml1RcDqfAQg1c+Wwde37qzYhvwijrKNfwPRsq94XCCpM8D?=
 =?us-ascii?Q?ZYb420UC2vO3d0ML1F4RmmQwwWfL7cBZyI06JLgjI/AYqAmazz0iNzrUY2xO?=
 =?us-ascii?Q?KH+g99ZSmJ1vRlhKpwaBT/vJ9wFbqS2jfDaS3qNg3stsZY7NWVqAU9kQnvvL?=
 =?us-ascii?Q?8RKXtkwgy8J9v2OWO1igbqHm5IDvFkGfLZdIWsbw5j9PHjd+toTxJHvlPqLv?=
 =?us-ascii?Q?kqBJSk9SYofco8Nw5uuZlGT0CztSOVmzXbjOlq76eEU6zX9nBulhy1wU2S9K?=
 =?us-ascii?Q?UY6DlG1s2J4xcxVpg1yX0opNQkQF6EDzjTpvu53JFBf4YyuyGZ052Q0a3xq2?=
 =?us-ascii?Q?8cGC2N56cCigJliEOaUO9TudmkEx+9PpG5STVyuJAmr46cHg2a5n8Ee4UQ9H?=
 =?us-ascii?Q?LYZher5R+CGjybkZaEwMfiHKokv2o6T0d+dm1xDoO/3AMPeZ7nruazSUz6oS?=
 =?us-ascii?Q?xNp9zqYnRD7lcS/JFcZDFn2lfFhuXkdjq1mO6qPUyhwgRf/7WLESojFA4Bok?=
 =?us-ascii?Q?YCPJmEhxonFFjdo+0q49Tp+XLsNOtdTFA1cirQq/h4kDgIGJCtTk2rVA1KpD?=
 =?us-ascii?Q?jKp1N1gsOw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46edba7e-ea77-411a-8e73-08da193861a1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 08:18:37.4748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfcgoIf2zGtfMDlKnKoqiZV82m/oBZghSDnQufcaQ5FKgFktq0K1pQbdwu3UpRdOwLIg4HcQIHq99s+WoYIQEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4499
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace `if (!is_zero_ether_addr(mac))` with `else` for simplification
and add curly brackets according to the kernel coding style:

"Do not unnecessarily use braces where a single statement will do."

...

"This does not apply if only one branch of a conditional statement is
a single statement; in the latter case use braces in both branches"

Please refer to:
https://www.kernel.org/doc/html/v5.17-rc8/process/coding-style.html

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/scsi/fcoe/fcoe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 44ca6110213c..983e00135fea 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -2580,7 +2580,7 @@ static void fcoe_flogi_resp(struct fc_seq *seq, struct fc_frame *fp, void *arg)
 	/* pre-FIP */
 	if (is_zero_ether_addr(mac))
 		fcoe_ctlr_recv_flogi(fip, lport, fp);
-	if (!is_zero_ether_addr(mac))
+	else
 		fcoe_update_src_mac(lport, mac);
 done:
 	fc_lport_flogi_resp(seq, fp, lport);
-- 
2.17.1

