Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE614821DE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 04:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242630AbhLaDhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 22:37:52 -0500
Received: from mail-bn8nam11on2131.outbound.protection.outlook.com ([40.107.236.131]:9953
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242613AbhLaDht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 22:37:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfHwwd8fqfKf+dcqg2RxcrmTErYQb0WdnROegcTezyPWTZVhlhB1snij02wBwWrmeTtikwA7+1wUxzfE0Y3bJGP94PKNO3yQzrwnlX/CzrQeUSeNgjJ853dy2Bt7W9ZH0hLiKEfladKNa15uo9aTCbeIlYx15140VVtoiNJxxP80X8qlFiD/MHje8cFeE5udcNwBXaQTgplk/n3mm0fPrBozcuFxR4Axk82nKlHHvit7Bt09IEoBtnRbkTPTG2mC1G1mcbZPwtmPnpshiCGaxI3jPvE1U/Sp2lXCRJCNWmZNJH5OLtiQQqc7YcxaDZt5hp+Cr7fQzsk+sbv6MqC7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCOt+ZUxK+M0w3KjsmLTFXDwwPeU+L/7sLzbC5sGcJY=;
 b=EakVr/umzS3eViXEh6c4PC6HkChwhM6NEiXTghn3YcJHxl4OS67RlYa/tTam6LZbRwyS6eHobKvZ8RhDddngEPpdm1J6l1BkSNRf00muo21jkOSrxYL5PxdW/Sy59wxRykWt2EuKz/TuwO+CuT/qZdguLAzSjRWHTcqOJU6n6fGEhfjFyd6J6YKX/2pfjzQNHzpnLT61Zbu8b4oSo4Vhu75+dM5ANBVhLA3PwC+nhR03Z1KX/0tHHYm5HbRF4CngslSltBmz5S86fAIsq6GtX6KE1rKI1ea8MjCgYhdlI3iqlIusGTnRTTqI4TyRAKVfje3nRBUlLGp9HYPLbb9oQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCOt+ZUxK+M0w3KjsmLTFXDwwPeU+L/7sLzbC5sGcJY=;
 b=tMeFBxOjtfl4A4/AX4FDJBLbtmVxTHclgGwnYWil5V0MmMW4tvpkUBFqYdLj6oPR97ul8j9oCkP/JmqGlwFv+P+AenXU5kW0bQzJCht7cwI4An2lqJIIOvKEJZKM/dKqbe8N1y1c1sBa7YozV1Pi6L2Qe4toXOVsYRqPvCbDTA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB4172.prod.exchangelabs.com (2603:10b6:5:2a::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.23; Fri, 31 Dec 2021 03:37:47 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38b6:2855:7c14:274b%3]) with mapi id 15.20.4823.023; Fri, 31 Dec 2021
 03:37:47 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: [PATCH v3 1/2] ACPI: tables: Add AGDI to the list of known table signatures
Date:   Thu, 30 Dec 2021 19:37:24 -0800
Message-Id: <20211231033725.21109-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211231033725.21109-1-ilkka@os.amperecomputing.com>
References: <20211231033725.21109-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:610:55::29) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2013b92a-56d7-4c89-dd08-08d9cc0ee99e
X-MS-TrafficTypeDiagnostic: DM6PR01MB4172:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB41725782D8BF6BFEAE1501DE9D469@DM6PR01MB4172.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BNGFHbFji7sSi/8G+ZYvT5sjKG98yJxpWljkh4sql8hYclIp6L3UN9XVQch0+Qw+2nV40khJpw/TA9/TrVUaidHn7Wae9dU8h7gl5nqVQpatAEfsKjFAgo/M+Ajj5N9RtLlXKpPbe34Pwdlr2E7edhxkw/68YuEkeAlwhpHNdMFO+f6z//M7y1Hc0qseBf12FsXTFBfPJ0Qq8rrTa4lydpO+Buz9ejg97laoPSdRhA8v2hx7HyVdPpPsFzfo16FcpyhvGmiM0SFrSB5QsQBYB+SpzzdQxO9YusqHRRQiJ0OGvjgTlq2QTXebaDaVdjoPUH/5/nxxncjg8tpCZX/kcPKAAGM9iRGp1wfBQPHbDk4fu9mQFJ0KRYgHRjvkZat9eko9tJe5K+el+IhKynBPHeieqlUdnNYVMxgfiWBa5OpxB4u3Jz1cgdvs/sobUFARAcp5xyrT9YU7gc6zCYpQ6LmHYX18EM61Zo2yx14KLOCHEPhFJUH3fm+iIpZxDFEm8WgZ3BEJ6AWOLb73stvNRjUSKwtG0ZARBfnuvnb1qXPW302RVKNCg1bi0rOX0IvUKMV3vyZdvaj2bNDrYvaNOH6l+Bhz0m0Xo5JB7kACQVKGannjL3t9Q+OQG0uHRoGJazVQ8HtK9g7823LBQwbV2vbE6yMnzTMpkM9VisSd0/qqrutnBc9Nz2VJabQ7p6Y+vk+HL2e53rD7mUISdl6TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(316002)(52116002)(6512007)(66556008)(2906002)(508600001)(4744005)(26005)(66476007)(38350700002)(8936002)(2616005)(4326008)(107886003)(1076003)(66946007)(38100700002)(186003)(6486002)(6506007)(6666004)(5660300002)(83380400001)(86362001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p1glAAiGE5hGFJzbqsnXELazF17R0kwuXo4wV95HBYecDf7NeQVsusEGssmY?=
 =?us-ascii?Q?xpFd6GtNqjZgA1DYF0Gv8yfEEihRxh8/KLWaHRT4BNUzaTyBHNyZqK26Nlxw?=
 =?us-ascii?Q?iywOLJmBa5GHaT0BA55toAnH2+e+in2TafNSA6xw4P32ktzSfPfRTukMvhyQ?=
 =?us-ascii?Q?6mjOOrPiXqZQesiiKuUcqOx9Cj8QAurZa4Btp6PnsmXHSO20639Q5wn4RAex?=
 =?us-ascii?Q?WWjcGahCRbIrp9vzfzeY2e05HZgQGo0ie7OomPUZkjw9b/HQRlsTpZ6QSdCZ?=
 =?us-ascii?Q?WnNRfPiX1gL6mLqqmAUoTO1+ZRQSrDT004adjTMRP6l1i01KQmzdHayTKwW1?=
 =?us-ascii?Q?nloyDnl8rdclz63W49jN6F1OE1zago3W0Wa1PM1UIrXHWV6Sap1yy7f4YsUN?=
 =?us-ascii?Q?R0Z5SbJutEtQmlumTzP1B8he3q93oRX8gRWsa8hKy26ky1AQNErU7FJg4yVG?=
 =?us-ascii?Q?Yhle/7L/RsnY2zwNUEHRSooIHAhz790yoqkMaA1XQr+GBsGM5VBEIfjkJPKi?=
 =?us-ascii?Q?gATwVXBye8O6zuuSMMIcjB8fi/CjMu2kCwTDMGPnlDHBCwTGoqIcdi1GKEBK?=
 =?us-ascii?Q?IfzNJMCYhfRaaLYBBPCN/Iuk24918hAfZlYWVYTzNHRoisZAnXFOJ57YWmZK?=
 =?us-ascii?Q?ZP/MJNpHKq9e8L4Qe7u1+5yMmC7AXVuGRWNlheaWMmqyJ2KrGRDynOWiaatH?=
 =?us-ascii?Q?3JPSa5K1qFUOTUNNHABUyQIPG44ViZcSqMs/+dT3KLQBEz3BFus42YTb2l2z?=
 =?us-ascii?Q?mk1isONbnh2xd8fzSruc2TpDwaF9ujOXZsq+fYU9JjuhPRjf5AVHHOExsrJl?=
 =?us-ascii?Q?JpdwTrPWjt2DyJxbxMjQZk3xLyQhFln7piA6QnCycx6ImZnUikDKKvE+0lT6?=
 =?us-ascii?Q?rYeriQLAb50dJZ1DFiRyw+E7fEiu+XF5/Lex2KkP12y1+d8obbEGcUBiCDfH?=
 =?us-ascii?Q?PjcOuiSiUmbOcH4e++ymrzLe6Ls3m5FWUolgceL2D9JIZnTJKMYxEPZMuKPa?=
 =?us-ascii?Q?RS5Zjz15L98FMY5yvuZXOV0IZa9XIJyr4HLmGW0EYp+7speUMMYUR/DHOq+x?=
 =?us-ascii?Q?TQK3BISVHo0l6ytCXmY09VdgDG1dyjn4yYcEqn13eX2LD7h65nBmW9GuFI8c?=
 =?us-ascii?Q?+64Q1BdmLAOxLTmgaZFn5QMJ9Yk6u99OYI+Usr9IDmOOvUb2ekmU8u0UAoqn?=
 =?us-ascii?Q?MgggIczmKvG9ozoiv/4j0uxmGopnpVMkhKhPwqkdqlFaGGdCpYcnnDgJRRln?=
 =?us-ascii?Q?HpS+eZlZgWa3sth5iQz8V9BsGIOAA/KDr2wKqLbewTm2meK9b3qRMtZyqNaw?=
 =?us-ascii?Q?fM8xjiTYNCIcWNSJ8xWsemjZm7FOFOvZkoVosm1On4V0aspJR9JY8LpUwWqn?=
 =?us-ascii?Q?ZiT3WbyrGSKO5C49Iime9RZiF1j7FTyYLG4eTNNaHZoIo0wVZX2B2Up6jfoW?=
 =?us-ascii?Q?Y1cJninpyjtBlmMyga6dFA2coV4CSv8tNDNRqMHldI6e0h5W+dcShwElSBoV?=
 =?us-ascii?Q?bgNmj35HptdSX9tis7uLrEH+8jOr/Kkg+M2ykH+nlS+8g/Y2J4DzVIdGGUjo?=
 =?us-ascii?Q?FN9WuWURIGjlf0Uv2KhGxch3rKHAbV+8PkdS9j9axDD9lJx/UShVg4fBkHI9?=
 =?us-ascii?Q?jih1ViPqXCrH0JbgEgOJpjotlNoGQ9arri+xZxM5gJtIDta7nZfiZ8g9ErI1?=
 =?us-ascii?Q?aedf9L9/vXOg5f6uh3LKbXU986yrpLnwzuOjQ5Oemib/elT2CQRLsWTT1DDd?=
 =?us-ascii?Q?tQ/5b+TexQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2013b92a-56d7-4c89-dd08-08d9cc0ee99e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2021 03:37:47.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GALFe8FiCF7eV2YZGhBfj4vzn3CxSHhcJKV4HQY3hPhBDfznuWUQ+ZGfqm6trjZ43YmvHuIiA5dISzD21ZASUGEMYjrLL8lH2kb8rr+LXal7YlBAbVxfhcjBjv3BUIDt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4172
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AGDI to the list of known ACPI table signatures to allow the
kernel to recognize it when upgrading tables via initrd.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
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

