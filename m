Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3D84945EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 03:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358244AbiATC6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 21:58:44 -0500
Received: from mail-bn8nam11on2113.outbound.protection.outlook.com ([40.107.236.113]:14561
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231514AbiATC6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 21:58:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhL+VOp3dAqLbiCMnH5ov/qHe/DkEgkTcHzIVwPivsW1zY+SJBfNTZ0lSD+nVcyFv0EZIgC4qDOFIRhi1CeS7sbrN8YTtGqWQuqwr/NGFUcevmW0/pp73QUrwDeBLXuXTP0HIvwAzcSc37Rc0biKe3wxPftHMVVEOzq8HPdx4K6jeNyFDIjLpT4zwUyNUU6+YWts+MHu+dute0ARGHnUi8lp+YAmCzBWZjREL9RhhrOdpFftLfaz1U8ECXhDDf6IhwWZZjk0o4NnevpNItIwRSGupC2XnP64H1aRWEIvOLm3g86zBz1DTb4aAAK6ACU6O1qyuitMFctzfWAojz+zBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W82Z+6fOE2zsSPz3xZ+gwtAymeOC8tLFDVqSsHNd184=;
 b=WlHq42WY0K/AbaqK4VL3dQ/xtbQ68esMiOuyr0OQDtesNwf1I+cSXyca5y9Y66/GWyoNJ1LYtkg02URAcGMASjy81+PtgdHXEyPVun0Ee+g5UssIqC1HrSfCtMI8MqYMrq/kBMoSP0Hg6s1jBE8+n2ouVGDDHG2l7x2KU2D3gM2bb4PkTdAcDZwBuFQZhL7UGuAJ4TYlOPV+hE+5GCrpNy30kBCAQNmP+mjnfESPj4LOrxXIFftZgAh3l0XI4eTbJ0R4pZnCgZ/iGSxdg2HU3LilQyNPN+nR5coSoKXNfkCRY0D0ZnSeYtblLk3RKXFPDHgXnGnVAUWQFCR5hXVaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W82Z+6fOE2zsSPz3xZ+gwtAymeOC8tLFDVqSsHNd184=;
 b=GByjbuFsqXLtPeJnyC74BHx0v2xJxZQIyL4sKwEtzvVFSwt9/36melIbUhjljnfd6CujvJ4kAb1I0+nQrE8kCnROScUDghRQIqmOL6UKTRGSzZrjXb1LLTGv5xGW+I6WE7RUCsCYnSvJmLnPVvNjKMxkK6tykdpujgcYxsFM5lU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BY5PR01MB5827.prod.exchangelabs.com (2603:10b6:a03:1c9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Thu, 20 Jan 2022 02:58:37 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::c4f4:4df1:380a:2ad8]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::c4f4:4df1:380a:2ad8%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 02:58:36 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com,
        james.morse@arm.com
Subject: [PATCH v4 1/2] ACPI: tables: Add AGDI to the list of known table signatures
Date:   Wed, 19 Jan 2022 18:57:58 -0800
Message-Id: <20220120025759.8630-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120025759.8630-1-ilkka@os.amperecomputing.com>
References: <20220120025759.8630-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:610:11a::27) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b696de0-36c3-4b41-4cf9-08d9dbc0c0cb
X-MS-TrafficTypeDiagnostic: BY5PR01MB5827:EE_
X-Microsoft-Antispam-PRVS: <BY5PR01MB582747255C62AD9C6347F6F99D5A9@BY5PR01MB5827.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zdq9UUn6bjdObd8py9xh35b8C6/t+QJk7aSUVC8RDaVye6b+yxIDraKx19y7/ZuIDQNueQ4zVUn//HJgSK5r2y37hITBvpeykCMoxcIbQ+Eyr2NkQbt90LxqcQBDpW/po0l6yNFPj7LfhB48dRD+rx5/g6G9TNC9Yakq8cJeh1pLmcS0KYWdhWLrCGEu6Fp4CbflKNCSJDcKx8zY8Bvueour8P5cEyx+Fr9eIjPMS1kwG0o6DbK9xT2GhnICtW6lua6RwLeBVojwByz14SyGQeHyBEznvVW2mGbJdUMuvetn4iC0XkPsCRJW4VyslOY7VxtviBEDrPLPYtdjA+P/86IBK0VuJDoh4GZ2Eg+VvoQeihF5JkFBuZmaOLKqr6VBnNqvEIMcIxRLjnjBeD3MWlfOLCHjuAXDbrXtPQoxFCI3zNQaGfqDm86l3nJJ1ihdZgZrQmgXe9GWWnkFPhMJSqaEAbYc0HP8KmAWztuUDNXxFJ2uf0MaOjlHvidkcZHHSnO3aYEysoVGb5SyS37bD7izy46JQSZhq2hr6b4YkGK54bKrePClAtkTFjqyWMmbRtxeTmrnfwzT8V+6FrUinZBSs2aKkjVke1s0vivlsb7WWwWkblbq1XfIOq+AA/pvZNaDs/hK7E8kygB/ajY0iPcJ7s6V6r2rE2Cgx9gossBLN3A0g6oMUansgVROV7WkDa77Q83cwc+06C/cqPR/5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(66946007)(66556008)(66476007)(6512007)(4744005)(38350700002)(86362001)(38100700002)(316002)(6506007)(5660300002)(2906002)(508600001)(2616005)(52116002)(4326008)(7416002)(186003)(83380400001)(6666004)(8936002)(8676002)(6486002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n+/MINeBKM5QCCx/1BG6SKJrMPIhwW70uXOteK8m+g57wNwmNda5Q80y2Pys?=
 =?us-ascii?Q?OaQCNgMIXlPV4NmgKhZ8Gh3htikn0BBCRCCHlf1cwCQZGcM1XPMQkluhhMi+?=
 =?us-ascii?Q?SyZ/wdNceJGHfNDwIIhzQ8qLuRHSMQsRQWglFmHA1P3vAlSrkHrjnTuFYbhe?=
 =?us-ascii?Q?qLHQSa1ro7Aq4jiTcB4YBvmDXhKqftG1rcB6VsNpPcib9JYkyuW1CxyOVzfC?=
 =?us-ascii?Q?L6w8TVgrfSLWchquEwioENtlPyokhGalFh2qlzoDZYg170qExcUUub7cIGJb?=
 =?us-ascii?Q?I++NfhLqnKo1kj51qJFiEi2SAcA/sIGvTJU9zE3RLa+0vsal82Y4w7Dysram?=
 =?us-ascii?Q?rR1mb5rELRFgDmWqP5NcfXFIDGja3sEHwAH/v3t73w/nVgOF+Bo9QXOGZyae?=
 =?us-ascii?Q?WE03zDFxNU6oujT4aZYBRA7VoITYY+jRY/r4bVlNtFPYSTRfonGodtMEpRaK?=
 =?us-ascii?Q?7TWY5iq+jeydleosI6EQwYlcx1qVpYK4siezJ/IHflY469FkBBpV/PY+6sLn?=
 =?us-ascii?Q?R+whKqcZB1e82GwvoEP9+/L8ZwJ9nDRNmUmfzNKd5jixmjKEWwm07YbsFK/4?=
 =?us-ascii?Q?ii08ZFRbhxwlnFVnJF/xteI11fBB7+ZwlWh+kBA6ky1rfp8S4bQbDf1EhUu9?=
 =?us-ascii?Q?wn1p5F3WDMfX0FD2MQ6hNX5bVGZh7Vqzq0hLbYUdAeCSsxVRMTR49+Ele2Qu?=
 =?us-ascii?Q?bUp1sxCNMkT/Ykr+iap9EV2SfhGdlnyzK50TadzVWTFyCKd/CXrSpaiQdpNe?=
 =?us-ascii?Q?cI/qQPAzd4NXfsP7wi3YKDz3TAG5GtHazQG4fFSeKYU0Qn/JvJtbcimh0jac?=
 =?us-ascii?Q?2yMmHN9TRpGtvNtIueZSdpmpWWFJubCNpRMSIjRNqajOsZ4l51bEM5MmIGI+?=
 =?us-ascii?Q?oSvciDKUi0TpY7LUXLITRB/wD2gl5gYkB9eWiDg+hNWPRvRczH379KcK4bsU?=
 =?us-ascii?Q?xbFJltZhmogkA2P/5BvRGpc1p/qSkKbjPslj//1P6Bs9TtnEkMJDFEfDJTZb?=
 =?us-ascii?Q?EWMIbBGTN4I6Q3FLbXVWpT/N7yQxhZWWOZnrcwmOAShnHiA3EbCYzYroZ2rD?=
 =?us-ascii?Q?V5Jr5Ur2CJDJDuf7QnUkWUnGaZDLKquWopdlqZqcXrzWNQkzxKozK6GbyYHC?=
 =?us-ascii?Q?og7kQIFiLBU0XV08So5gM3a+4aP2PSX2Cdhwwxr1quZk3BWUoQYuALs5L2FD?=
 =?us-ascii?Q?pSG3vuO9AjCDHJyF7SBrFLqliuqt+vbxrtZZX6sXDIDisgghjZIIgJwDKgKI?=
 =?us-ascii?Q?0A+0wrzx/1E2M9jW/qpYvoenY7I3pAYsDbp0+SkYatkMtjXL+eaBFZFEVtNl?=
 =?us-ascii?Q?L37qEz0lUrWu7m+rIkeVQ9mUf90HVJ30aa7BHkAEKboB+kyISQHCWgj80+DA?=
 =?us-ascii?Q?8lzPISGk366K2Wi7vN6+4crMUUJ7pWXtjhVbWRsxfttQ/ATA0S5cYEsEeapt?=
 =?us-ascii?Q?+kXbkAAFqdgMe8y43cpQw6z+SCdUcvS+N/+9bwOSycIjqyCDsYzpVhCBwca/?=
 =?us-ascii?Q?oFqu05jZj2dI/ILqTwg2wv1RzFI1QbgC2R9g88xKbtUlbEbPvJ1JYRHJCFgS?=
 =?us-ascii?Q?3yx5ugimI8+HuhwID9TwDE2UfSk/BR3BumMUP/ME3v3bENRoloLCrJKtgbhv?=
 =?us-ascii?Q?HXyPR7R5dM86H0eniRWJ3OtxgxShAS2MUGzrY1IfqyxXOQxh95QZ247MHSJm?=
 =?us-ascii?Q?zbvNcmRuL0BpvwWdHEYoYgbVVceFq+bw6m0GmFaVDGhrw828Y3Ru5s5nSy94?=
 =?us-ascii?Q?CE70VfLUTA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b696de0-36c3-4b41-4cf9-08d9dbc0c0cb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 02:58:36.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRscig7VcN1OeO/TzSzp0mUkHKDlbaNJcSz80zJFHnQLbZArOWCETZdmVs6zu9/aGhykyRY6ZgTrHN7eKxZkM2lYazSPG+L5GIEO61tzna+x3EufFeMr6v+Le7spLYW5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5827
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AGDI to the list of known ACPI table signatures to allow the
kernel to recognize it when upgrading tables via initrd.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 682a3ea9cb40..973b466fa652 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -500,7 +500,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	ACPI_SIG_NHLT, ACPI_SIG_AEST };
+	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_AGDI };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
2.17.1

