Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A9468F95
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhLFDOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:14:25 -0500
Received: from mail-psaapc01on2133.outbound.protection.outlook.com ([40.107.255.133]:17125
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235402AbhLFDOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:14:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDvktr5wFdKkxcbBbGEpm6xzvOqIQegh70b0DwFeb2rMSEYdyO98gdm97jeDR1OgsHOqRWbsl+bVbV4hu1rkjmdhFtynGwd7Y0LiOrPYnwEsUuZPC82d2aRk69/jRqbGgJHAV/RkKVyReG6Lut7EyiOuy5lmJ5WsI5ecbuPtAp6nuq0edVguaxWa2dCyoTGNa0AXMdIlx9UvqDIg/SzdzZTeHi1mHK9y6FT7Ka4Nk6NQSG2H1kY0FFfVy0dspRHPQsS0hSgXaRuu+TgG/YafgPTATqCBrRhxgCcEuOZNKDhMhPmGbg2xUGNC+tDwc3EEnp4NVBJiCZTkw3krvF+ioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxDcfaVJPY6KbUzO45TmO/eXwy68S034dbby13ILf6w=;
 b=O+AI/IDwZaMvRTHfvvuoCm3/evndqLG1IeYmtzfr1XfGXTwSmymAJl989uCg3qDOJQLbux1Z1wkiEVqpSnkKRqtrS2hUny+yxTZMgaS+WqZHsvqVGpQujxMbM3L7Y8wjlPzQ5kjrQG/5NqgfsWToJKe3rugvd+4PYPn0ApSybuh9RAA20N4wlElXHOIR4IJO/Pck2oXpMvGFr/6EldTENi5L8lCTyAmVc6PYHlh4ODHM6KCMTBuWp1cgfmbmBJQ89670hE991fPTB/JIzf92slS+KFxjx9Rxl+CUM/2IQ2eldalNn8l7IFNYz7Bby037jzub/5HHLAHf/x8RM1GfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxDcfaVJPY6KbUzO45TmO/eXwy68S034dbby13ILf6w=;
 b=baD5W5wxPg8Hrz/PhOqAdbIPs5UO5E4C/SBB5c+bNwD4cS3KkLuVhAetpj4BptiSAERw8j2IcAARysQbAZWDOGV90i21XRmIJ0boZFRENEIXEHqO3nfVgo9WyvBC6QmHc6xLW96CPMGimNcRAgl/EbM4GuessJxqkk8IvLei694=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY2PR06MB3360.apcprd06.prod.outlook.com (2603:1096:404:ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 03:10:53 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092%8]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 03:10:53 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] scsi: pm8001: Replace snprintf in show functions with sysfs_emit
Date:   Sun,  5 Dec 2021 19:10:37 -0800
Message-Id: <20211206031038.27755-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.vivo.xyz (103.220.76.181) by HK2PR04CA0085.apcprd04.prod.outlook.com (2603:1096:202:15::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Mon, 6 Dec 2021 03:10:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02827714-cccb-434c-0bef-08d9b8660363
X-MS-TrafficTypeDiagnostic: TY2PR06MB3360:
X-Microsoft-Antispam-PRVS: <TY2PR06MB3360265BFE2C582D390E8C88A26D9@TY2PR06MB3360.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Md1F0FvnUpDx+fe6gFf01hDO/8L7Res1h+exHjJMviRcbFtwquV7V8ueQWpoiHj+fYVawe/gd0lyXv08lphuu9oI9tQu/OKpx4iq1m6I34KLERJ4UNtHNaYsuLGtOEjyu6DW2xd9MZor7pCa81xZ8Y6wwuZcAAXkhXZt0uyXPLr9EBose1Pp+KB/0bGLd2OyCHKUVXdj1BZBrVnS0qqsX3G56qFoLCoE4nACHOsNGh7IwmWS8fkPfhJOiP6188RHHT4oyuC0PyNdByeSVuBNUz52OaFhN1RUXe0EvF0eacU2Z49UV4taDKu3Zywq0v91/VjJrrQctcTtkHX4FZRr/kz6klzkFistHvm6pQK1/EFhFqw1yy+BJ7DFwX3hXYyfIMCVEHM7Uu3bGM4zHuCiwBImIFzjlLFPLwtR0l6AdIBfwj1S5WRZPg6UlUedsVeOPMJSQX0egx8TafX51YIuyrThuY6aVA8vlcPygdEkGAuAsyC5kXbVLE2t4jaLG6ilwRmAToX/2x6/VcgUKVT+WiAqWrP4xo/24hSEa30/1ZX+q0YeGVCTta1PPpoCxDyUMnPOPTaeVAWsHAlnZq41AtaNnoahB6KsQ81TAPukClHoeKLOKVQYkkAAnfnFq+WHHc5Bgc9YEJB9o1gekt7Z+5lIwneB4+vfQUFuTb6prI2xn3U2KmB5eyUvX/QSrcyDWOU9LEDcQFJctnTs3/j9BEWkPTAS/FlrA9HmeCxbHc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(26005)(8676002)(83380400001)(508600001)(2616005)(66476007)(107886003)(66946007)(110136005)(66556008)(6512007)(6486002)(2906002)(6666004)(6506007)(316002)(186003)(36756003)(5660300002)(956004)(4326008)(38350700002)(8936002)(38100700002)(52116002)(86362001)(182500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x7EFJHmG/WYTA78erwYEV8qjuUl1oNjh3JocrdpfyD00T6ucjOY21tzlVJ+h?=
 =?us-ascii?Q?3bGVRpvwTbQNeqh98KxyUBkShpLKJwHTUipuagqK1ZAEYOkaV0ibAZFYxXOU?=
 =?us-ascii?Q?UWJ24VffeyhtF2VkKi3QXdWCGVXeu4C9Wy97yRPQUqotY8Vv5KX3pWhxSEW2?=
 =?us-ascii?Q?K4zEiOeDstZaBvGLrt4+5MU2PtoEeSJarXgq28U9BVLbV91h/aNQw8VqptCc?=
 =?us-ascii?Q?a2qZSvoTIHsy8mZGd734TENS57kqNbjoONjOy3I1KzhUQ30lHIULPzE1xtIe?=
 =?us-ascii?Q?WXD7XXKN524kcZCACjDlZcBwQr/bEKZbilvXbJ/LG4sIutuVpBfn8Wr2rPux?=
 =?us-ascii?Q?vJUNkcd528uoYQ8l5fUCAhagJKH5hGKw78o3YNgq9zyoDPQs1o9ljqLDpO2Q?=
 =?us-ascii?Q?SvYRH2QmyfcEMU4Qyvh0SPTqTios3UP92s98z+6cJCZkp6QLbW3X4Mg128el?=
 =?us-ascii?Q?5blEJWb8tzwArXwua25N3UaA+2R1D9D02tR+6L7O2Jqn7bDgeeLj09sAqwC4?=
 =?us-ascii?Q?l/bPZGMJHKDeO0zDe2AfbJaS+4R3t4bGVQ87ZnHi0GT0AeyKErz1K+kYRN82?=
 =?us-ascii?Q?H6UlWRv2nZxi5ID1RBBc3Z3nbRC+pOhvswgyGCioTbi9mvuiDfgpmA0Y2yZp?=
 =?us-ascii?Q?Xmp3ZGO+1v5ltehHCMXqx48idwZ8UIzp83DH9QP0Q1BTuDjMdXiZsufMhZ46?=
 =?us-ascii?Q?vX9sSyeJW3MQFrxEw3zayrEnRw3pC0/KcB1ujZuDih02pflY0Vp2Iuh/MEWG?=
 =?us-ascii?Q?QMkjZGa+YTA/XvzjYOcYx9xJCnYcTtkvSKcLuA7hYKt7dR1AlJQ2yeCtybJm?=
 =?us-ascii?Q?Wo5z3Dx+U3jigtggrCrb3URGbDYph+junP83Eh/JYyhPvFOMJdq0pHUdC0db?=
 =?us-ascii?Q?92UYeXlXvST+vjkph19FocJMylkxbRgLej4jmkeGGpeuqGDT5JR+NKa/BSRP?=
 =?us-ascii?Q?lLp8NNHHI0g04/gRf5q8ddFRggzSZuA2U1n/26zXX0ER1oVrIStebQEFG+PS?=
 =?us-ascii?Q?4uDEMNYSL000pZCMo17QnDqxSX6lcoWaEvzaGd8Y3hKvJhWb17Qi5Z2/KmJJ?=
 =?us-ascii?Q?wKaq4UPudbuhKc4Y1aWVUPKF4HofNeQu6mLiF+fPduypG2Ushj0JBQzamJr3?=
 =?us-ascii?Q?Q9TooGkSoWwMpxmT+JDihO2W8pznNBMNRc2LgwLtSfVX4iyJaN/pxUwbMg1z?=
 =?us-ascii?Q?RJg2Mzx2HTf7je8TiVMjodmZZAkY1goXz7GdTMGV6wJ+Xrt+4b7rDoYB8nWc?=
 =?us-ascii?Q?M+kczwiIrfumgfer+ava6ToRY9JOdzQ63GajkyLIpkcMG4t1uH6yDuWfWlZg?=
 =?us-ascii?Q?TxlcttzSwPmLviy3NzFy4AxheeJOkL5EZdgb7dlW5IbhZzxM2Zuge6W6hd3Z?=
 =?us-ascii?Q?ilk06HXESPpKJtfGda39z/NsBE8QB3YYT+O+6EUs8oUOYa+5Ve8QDr8oDTny?=
 =?us-ascii?Q?xT1oMSLShUScFWUdwqEEFd4d6nBURJT/YLsUmFBEqzZIYfwKC7W6/Dsj1Wwp?=
 =?us-ascii?Q?51xB5GMfIbU/OkR3y/dmkEc7YRw50SsGqB/Y5mjhm/4xObNSEwuXvJ6/J3lp?=
 =?us-ascii?Q?eEoKb0PsNmApErs4rYxqim/MmxIFchkv6rQTqrndf5GeR26q3gNe/XTyyX3/?=
 =?us-ascii?Q?7oHV6tUkJLpuIR7lwtMfm2s=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02827714-cccb-434c-0bef-08d9b8660363
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 03:10:53.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 156+lKMkKr/M5RnYAbSMO2ifXPU4xDNG6LKzcZ7y1afK3b6eVxPKgkfjlbNQtIU75Pa7Wr1L2Nnzoi1YKrOZfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3360
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c | 36 ++++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 41a63c9b719b..8f90ea8d6ca0 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -61,10 +61,10 @@ static ssize_t pm8001_ctl_mpi_interface_rev_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%d\n",
+		return sysfs_emit(buf, "%d\n",
 			pm8001_ha->main_cfg_tbl.pm8001_tbl.interface_rev);
 	} else {
-		return snprintf(buf, PAGE_SIZE, "%d\n",
+		return sysfs_emit(buf, "%d\n",
 			pm8001_ha->main_cfg_tbl.pm80xx_tbl.interface_rev);
 	}
 }
@@ -86,7 +86,7 @@ static ssize_t controller_fatal_error_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			pm8001_ha->controller_fatal_error);
 }
 static DEVICE_ATTR_RO(controller_fatal_error);
@@ -107,13 +107,13 @@ static ssize_t pm8001_ctl_fw_version_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
 		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 24),
 		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 16),
 		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 8),
 		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev));
 	} else {
-		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 24),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 16),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev >> 8),
@@ -138,7 +138,7 @@ static ssize_t pm8001_ctl_ila_version_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id != chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 24),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 16),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 8),
@@ -164,7 +164,7 @@ static ssize_t pm8001_ctl_inactive_fw_version_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id != chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+		return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 24),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 16),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 8),
@@ -191,10 +191,10 @@ static ssize_t pm8001_ctl_max_out_io_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%d\n",
+		return sysfs_emit(buf, "%d\n",
 			pm8001_ha->main_cfg_tbl.pm8001_tbl.max_out_io);
 	} else {
-		return snprintf(buf, PAGE_SIZE, "%d\n",
+		return sysfs_emit(buf, "%d\n",
 			pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_out_io);
 	}
 }
@@ -215,11 +215,11 @@ static ssize_t pm8001_ctl_max_devices_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%04d\n",
+		return sysfs_emit(buf, "%04d\n",
 			(u16)(pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl >> 16)
 			);
 	} else {
-		return snprintf(buf, PAGE_SIZE, "%04d\n",
+		return sysfs_emit(buf, "%04d\n",
 			(u16)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl >> 16)
 			);
 	}
@@ -242,11 +242,11 @@ static ssize_t pm8001_ctl_max_sg_list_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%04d\n",
+		return sysfs_emit(buf, "%04d\n",
 			pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl & 0x0000FFFF
 			);
 	} else {
-		return snprintf(buf, PAGE_SIZE, "%04d\n",
+		return sysfs_emit(buf, "%04d\n",
 			pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_sgl & 0x0000FFFF
 			);
 	}
@@ -315,7 +315,7 @@ static ssize_t pm8001_ctl_host_sas_address_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
+	return sysfs_emit(buf, "0x%016llx\n",
 			be64_to_cpu(*(__be64 *)pm8001_ha->sas_addr));
 }
 static DEVICE_ATTR(host_sas_address, S_IRUGO,
@@ -336,7 +336,7 @@ static ssize_t pm8001_ctl_logging_level_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%08xh\n", pm8001_ha->logging_level);
+	return sysfs_emit(buf, "%08xh\n", pm8001_ha->logging_level);
 }
 
 static ssize_t pm8001_ctl_logging_level_store(struct device *cdev,
@@ -517,7 +517,7 @@ static ssize_t event_log_size_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.event_log_size);
 }
 static DEVICE_ATTR_RO(event_log_size);
@@ -604,7 +604,7 @@ static ssize_t non_fatal_count_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%08x",
+	return sysfs_emit(buf, "%08x",
 			pm8001_ha->non_fatal_count);
 }
 
@@ -882,7 +882,7 @@ static ssize_t pm8001_show_update_fw(struct device *cdev,
 	if (pm8001_ha->fw_status != FLASH_IN_PROGRESS)
 		pm8001_ha->fw_status = FLASH_OK;
 
-	return snprintf(buf, PAGE_SIZE, "status=%x %s\n",
+	return sysfs_emit(buf, "status=%x %s\n",
 			flash_error_table[i].err_code,
 			flash_error_table[i].reason);
 }
-- 
2.17.1

