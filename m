Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD47A4676CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380596AbhLCLzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:55:40 -0500
Received: from mail-sgaapc01on2091.outbound.protection.outlook.com ([40.107.215.91]:18273
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231944AbhLCLzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:55:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cU9RdnS2OJ5zQOMukaclIk7zfJBw5b//JqnTfE1VxXwvrfRig6N4UL4VbOwqD9c5FCnaLdnhHIpHatLxFKqQfrgadGMqCmxsX6cYAM0x1hXvV28R7cwm8iQNEls/OpDpTWJuPGkQC8896ogziihzBuWpzupbQ7JaZ3YJk70yDGKuOsoFg31ND8BjJdMipGDqJYBEHwaSAeRnMEqf7BriP3XfrGVImySuU9YnfsKQ4Bd788RRD3kAlBnJsks7jL+To71ft2ussN7N5Ol7wPTgHDsb2P5fxLukQX9EVEKCesWtBJphzsK2Zuk3Vs1amTT5MEEZjzn97y5DOBrp44T4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kIe+6COFQgX+amb2vkkwfLrTAVEzrOMhmj7JepZGiE=;
 b=IeDvjJVpeFbxgDQEHH1D/utPbxV5qiaZg7OJ7KfDwMVeTCwUQWGUvVPp+kjGjI+YP/H1d0VczKtSkxVOTZlFo9p+7KRk+U4RRl2Jyup6JVgu0jbM+F2CDqfUO28AEwr08MWdIy7+jnOtC3sRDhOa98Jjcl8y3sx2E0pIl439GTau2kWVlxaE/zgCbPsbMWrRRbbex56cwDq0UEVAecjNM6SqNr1Xvqkrh+KbjRQPXUy/i1perHjrmr7o/kEdhnkCUM2NKvWr3ebs8nfe45j78WMz1UDI82o0Du1wgDxcCCtAPCsOnhTvFkZHs79qcAebZK2+wnM9xsHndomVxv4HXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kIe+6COFQgX+amb2vkkwfLrTAVEzrOMhmj7JepZGiE=;
 b=fPq5G3bhDvjNOf4hdinfIH6PssvoNbKltxZYnVwBs4JCLzJE7B5rZyeqIP39XCew2yGfSj0YzqTrFmR5zeF2ihNiNDiynhT4pz64QAJySBKvlmYDXO9JLBqAqE26VHQ4DnVkXp0I5+uCBHnYuWaHJFtfey56lBC1f6cdtpBUolY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY2PR06MB2894.apcprd06.prod.outlook.com (2603:1096:404:37::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 3 Dec
 2021 11:52:11 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092%5]) with mapi id 15.20.4734.027; Fri, 3 Dec 2021
 11:52:10 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] scsi: pmcraid: Replace snprintf in show functions with sysfs_emit
Date:   Fri,  3 Dec 2021 03:51:58 -0800
Message-Id: <20211203115158.6022-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::20) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.vivo.xyz (218.213.202.189) by HK0PR01CA0056.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Fri, 3 Dec 2021 11:52:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 115e682f-2c15-4597-dbff-08d9b65356e9
X-MS-TrafficTypeDiagnostic: TY2PR06MB2894:
X-Microsoft-Antispam-PRVS: <TY2PR06MB2894AD8D7D6DD02FE7B71644A26A9@TY2PR06MB2894.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:85;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BczyF0WRrMXZdgLSAIvytiVOrN5MQ+GhcgPPMjU3nKC5IrKqKtAyvzAWDdy8OI+gEUUyuUS787ApAVBXZUs4FUplrVYPzt7ykJ4XLFuhe9Lm6KwrbSKWH3QH/DoFGs8Q+/Br3dA4N6vgOW20T+R7sCzfsbUhH8VKuHHKl5IDNuvYC0eY6P6W+2OqisZT0Q7Fw69S0HfreJrNL3UVRmndUzLy6QYVTYcceeO9WyFguvBZ+Aq1dhp9OirbEL7eTEKUiOyO5IzlhJx0hLwFlNmhrkj76SbEzfhUnJUwO7SXjZM8OnFvowBxIH6Iba07/+SUoRIlnNXvwZS/txcxTdGk0YsMjATsfhKHVuWKZYpf3q/1UnDfNVdU24zWlpuMPd4l8uBVP6T7d846u3s6p34CZcw6f1LK5ipIRvN31kTIaznALknaCc/EiR18nTADgA80SM4TyaZgUEW/yCNWE7oA8WJ7H8mEn3Wx0iBFgxvtKplI/J7y1CrAbtkITCxplepXOSzZK7qyUVfls+DBHfZbBR/xE4bx1CdIf4D/F8hC4sJgJCoSzDTOTirphP819cSuj64mP50KnfNd9PjmEr7y7E5c2z7I/LDP2XwkWdQxiO5B4M2Qfyy82D1NyjmSYpJUfooKBhP+VJ7/UiF2I0AzDaw/crAsJb105YLwZ7oh46HQHiAwSqb9sIRTCOfu565HhaO7VujefQHtUz+hAUySteZGP4U4q1MA4QGq7U7Oz6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(508600001)(5660300002)(6486002)(38350700002)(26005)(38100700002)(2906002)(36756003)(66476007)(83380400001)(66556008)(66946007)(86362001)(956004)(6666004)(110136005)(2616005)(107886003)(1076003)(8676002)(8936002)(52116002)(6512007)(316002)(6506007)(4326008)(182500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Et3QULSHEOlxKKDBTKll27e++/N0XvU5dpYUOzq/7Kn5hwDlYmVYhGEE8Oxk?=
 =?us-ascii?Q?POn3gn70ZVi9kd0RHey1sonjTh8BpkYll3vguYKRrSD45XrsVccILHzSdHhV?=
 =?us-ascii?Q?wmyqx2yZMZTp91jf9NkhTjgXYd0VoMou1EN0ARzOPU9K/2txrXIhuFHm9wNv?=
 =?us-ascii?Q?Zu3U2MSdMgQgn5NBZJvLFmvCOpaN3iiQYunIlaybiM1wM6ev+JvEXSOYiRY5?=
 =?us-ascii?Q?N9XDEbDRonf73b2Q3VzsZNgN3wfH7CuvsViYHPk11PFyqI41fse2OiE0a9SK?=
 =?us-ascii?Q?Z2SnIoU5T2i9QbY6MlKAkZ5wFExQwBx9L6+Jwk/NfnSed5QD2BdAVbnCxcty?=
 =?us-ascii?Q?MmKIe22gDN0L3YT+wV3MXzWKsWy/TlsS+B+o+vTTgGa0KcENf0UzBEukFHi1?=
 =?us-ascii?Q?0mPfO1NXILbCBCvHrQt/DPUnO58DuaxGoNzN4xoH0rw5SKCeEditn3EryLNa?=
 =?us-ascii?Q?4JoCMljLss8Ce4uMIkZ79jRZz35PQ2EgVAbvXNtXhXuICi9Xal+PdP3oB8Ng?=
 =?us-ascii?Q?xgttRTCbomIxhgv9rwQtXnuqa0+soovX7+Hb3aLqr7ROjOUzbl/gvaHgQQJA?=
 =?us-ascii?Q?8Ft2z4XGpqYcq5QATwoGzGZak4SG5UL2S5ATdpyIwbl5MbzOhVCNIzVK+1Mo?=
 =?us-ascii?Q?s3eu/mJoGZKA9TwA3Tkv+V2Rbb+WLRIWP+aZIZrdm1jmRVnhElv4wHxNCLoZ?=
 =?us-ascii?Q?w6Wdj1RlkIt3KC+UkQKkvFCPVTo9mTI/9l+DIwS7y+b+qtxzl7/+Q12N3rRB?=
 =?us-ascii?Q?GgZZQxsX04TS4q/l45xGPndMqTmIQUfGnLquRAW7sgEqeP8XRCkkTeg4yeub?=
 =?us-ascii?Q?D0IZ+fHAdl3mewJla6bLQbRA/iW27DaAl9zTenosi2ELmzV0xd5ExunN92wo?=
 =?us-ascii?Q?VOplJ/Ip+dShj+yESfT2c89IVEBp5+WDeBg8rIubPisodyBUnm9l8I0xwK62?=
 =?us-ascii?Q?8Ng5OF1I2potjpWh67oWeOPZ76icGcpvm44WCKwh8g5jlVuUztG6jcxjJury?=
 =?us-ascii?Q?8vupvKbjpEJWs4nw7VcAoSZSz9lypnqV9qRxRfY3aEeghNiwF+1WNdcNJ9Qi?=
 =?us-ascii?Q?naMIe6GsB/KxVOWRe1JTgl7atVKAwPWz4VIN8OBSqQhPwBFATvvAkSt3JW1l?=
 =?us-ascii?Q?dmSbBJIUZ877S2f2XyQ1SAGuRaYGJGVWoy2WuBARhPCm3n+xGTqBGc3NiVMn?=
 =?us-ascii?Q?bdJMH/maGGnucg79wX8t/A84pLsuvd3u4c9A/WEsVwdjTYZytM4GrBYpuN6s?=
 =?us-ascii?Q?CMjD87u1WtXZn/VIGgaAuCEMMgEbKllW0mGGBYnNYWYRugzIujYyPt3xmkuf?=
 =?us-ascii?Q?acYXhXpWg6GQRyX8TtTx8ydpgm+8cdas5UZZqGXWhjWxIzmQ8wcA6EmIriA2?=
 =?us-ascii?Q?24moMljYEfOog6P+kI1jdBIYk+L3u7vhiX9EqB/KamXFbE7Fco3FKGJb+PMN?=
 =?us-ascii?Q?/9L5qY+5nJkPsDcVwxgDJtI59+Sz7VqRckobM0VKq8l9mbc2M153nZzY+/Iu?=
 =?us-ascii?Q?MldOwg8v2/SiuK6dCf56q96EHQqD+9RPOgiQgX7CCOOkWCHT/tsw0wGfAk3t?=
 =?us-ascii?Q?WXyDM58sVMYlKs/9wcspnS11O0rCiy0je+8kFCzyOxupykI47MtEIbmh1pnM?=
 =?us-ascii?Q?tOuJm2WbAg6q9mgA6E0z8yM=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115e682f-2c15-4597-dbff-08d9b65356e9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 11:52:10.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbkOe7IecyIDUbz7iNle+VET0fxan6Txj9Nmr6XSFiByl8AJk+AtfXC/EOXzCgp7pKT4WqpGXuX2tJwaGXez7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2894
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/scsi/pmcraid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 2fe7a0019fff..551713d33838 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3984,7 +3984,7 @@ static ssize_t pmcraid_show_log_level(
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct pmcraid_instance *pinstance =
 		(struct pmcraid_instance *)shost->hostdata;
-	return snprintf(buf, PAGE_SIZE, "%d\n", pinstance->current_log_level);
+	return sysfs_emit(buf, "%d\n", pinstance->current_log_level);
 }
 
 /**
@@ -4045,7 +4045,7 @@ static ssize_t pmcraid_show_drv_version(
 	char *buf
 )
 {
-	return snprintf(buf, PAGE_SIZE, "version: %s\n",
+	return sysfs_emit(buf, "version: %s\n",
 			PMCRAID_DRIVER_VERSION);
 }
 
@@ -4079,7 +4079,7 @@ static ssize_t pmcraid_show_adapter_id(
 		pinstance->pdev->devfn;
 	u32 aen_group = pmcraid_event_family.id;
 
-	return snprintf(buf, PAGE_SIZE,
+	return sysfs_emit(buf,
 			"adapter id: %d\nminor: %d\naen group: %d\n",
 			adapter_id, MINOR(pinstance->cdev.dev), aen_group);
 }
-- 
2.17.1

