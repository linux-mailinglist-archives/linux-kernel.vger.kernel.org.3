Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A802F4D20B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349842AbiCHSw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349746AbiCHSwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:52:14 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2098.outbound.protection.outlook.com [40.107.236.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9B354688;
        Tue,  8 Mar 2022 10:51:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URW2ga7Xdb5171K9VOmSMKN1uVvvaM2aD+AXA4MRV+kzh81A/SG28EkR2LSQ4NC5k+5Xv4lezyJ5/YA4a8zu/56kdAv//Wz5yybS6ZHLRG7ClcuL/aBR7goWKDZ6+3dmiEgfAxir4HKa+ehPMOsJhTCJ7SxIZlhCMJ9TlVfwxMaw7D0pPvZ038t7GEFRF9Gcq1D9Qa/KW55Tw4IFN72uqfk6xG0xz67kZ/XtEXBa0xjM4tFgrT6sLROSAtsd6QlYkTCvJuiv+CxTooZQd2DLcmtT9bD5nYJNwmdugWCYhgN/hTvjFATJF24GyoI1ApYaNeYXW6ES27hLqifRMiSYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pbLwf6K7k7do+1nEtbQP06WUEmgqqGkPBz26VNN+yY=;
 b=Pc9a6Jo7VPdYTsJQai6awH1gFp40BuiDkmnYSKy3UNzZo5oB6fnTNLLqcdHau9vPqhj0tRxbSejmBjJZ2ccJF/g4N5CapuLPXT/pHr31wI0ao03MTB4mgCHv64vkgly9Nub5mvrOL8AylfpH2xPm9WPkdOD6INBKRQLSxX3/XilxESlo+XLwS8hE1JdCch3MLNqq7LT6RdTagMKjIovkJip/W6FX2wBofiDYtz/MQzE7sjLkulGEr1p4KU8vTr6r0l+hChLAVWRBAVhKdBG35VUbzZUpnJW5JC/r7c0ivRrT1ICr85SZdx2DT3Y4jOEyqcCxWjUzS9SESKaZGSsL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pbLwf6K7k7do+1nEtbQP06WUEmgqqGkPBz26VNN+yY=;
 b=aSAraNfA1HeMocjUAkXXrV15gl3krZFGYD3ppIEXOFXjO/cncXJ0Xb5SFX+FcoGVk0v4R5CKvdwCMaIne2aF+D6tuQrNiPD6Fw8v8WFdEhRdOE2VKq+9DWa8PLwVJHh/bGD74pb/5RVy5jcRtIcrJyIQrKy6jhDCItpAQnSi6Gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6329.prod.exchangelabs.com (2603:10b6:806:ee::12) by
 DM8PR01MB6854.prod.exchangelabs.com (2603:10b6:8:31::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Tue, 8 Mar 2022 18:51:10 +0000
Received: from SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::f56a:e18f:b6c4:ddb5]) by SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::f56a:e18f:b6c4:ddb5%7]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 18:51:10 +0000
From:   Darren Hart <darren@os.amperecomputing.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Doug Rady <dcrady@os.amperecomputing.com>
Subject: [PATCH] ACPI/APEI: Limit printable size of BERT table data
Date:   Tue,  8 Mar 2022 10:50:48 -0800
Message-Id: <43dfaba0646d498fe94c1a8479b812346133f438.1646765290.git.darren@os.amperecomputing.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:610:60::28) To SA0PR01MB6329.prod.exchangelabs.com
 (2603:10b6:806:ee::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea944381-f9e7-4891-2d3c-08da01349cc5
X-MS-TrafficTypeDiagnostic: DM8PR01MB6854:EE_
X-Microsoft-Antispam-PRVS: <DM8PR01MB68544CA692971FD09019853FF7099@DM8PR01MB6854.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqavSVaIaS595uuZ1Qfu3gkIEG2TmvDuo2fmpRjmUS1UKdh4oW50Rm5LXepGYuxB0tNttjgyXyyrOMZY4zwHE9GDPkoZgpriangzCFkb0v5AWRzyiicpaqljYbuzbMR/cnwHc4nm0zj8WM/RNMp6EuO6pSbWvB0AYU+rCVprz1fLNg7OPzRNAw0XUtjprWINz5MeF8LpIgAfSFCtwy54xwUzGvydcElJhywKyTLcvDwAh3SmTYuypJNNtlM6lw6D1ZUWLJSEDqb4YIAV7+BmxTSqsCYI0YP1rK46tOVr9NkQl7cokYJH/aOMxAjf5xQS+/OvcflvizoLpKlClDEq5mjt08alJpcUwIOUFqHUE7navAHZAk++RdfsfPrzweGBuOvD0FVy02puWExcM+dZPEppocmGbQAnhaEFMO8rrOpYMrOoO8eUEaY3yoI3fW4TLAZ/csz3Z8kcGc5ZJ511lsdD309j+foYoofinwdGqRUBt685plM3dw6l8tsvSoqJ+w+L7wffjwvKB7MSZ1X5PiNh/Ak1ZCulPqpvLaY9yPNZJ/3GLQ7CxaKNpXyaZBGz+PaegrNSNXy9Dn5QC3HfHGmP+5cy/1T3ILAxPJLVpPMeSrwXRsVBv6sbklVADNCgzzqS3oawwTT8s3WbuqaPHFIRO4IzRmIuvj+k5h9JPD/tOOix3P21WFaU/S/FVCJ8oI/8zAZjrLnFB1G8p929cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6329.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(110136005)(8936002)(6486002)(54906003)(5660300002)(38350700002)(38100700002)(66476007)(8676002)(66946007)(66556008)(4326008)(2906002)(83380400001)(107886003)(6512007)(508600001)(6666004)(6506007)(2616005)(186003)(26005)(52116002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XcFRXf45ct6m+hx8X8b2f14ZEHxGOetFZXTxXGPJ7lYQMDCft4zLy7jVCAbL?=
 =?us-ascii?Q?07wu3D8U7ejUGZnLwba0CRqrP3uwDs8UPhfVPvF60uUMJPDFfa+XC7B5pmNl?=
 =?us-ascii?Q?lfQMgTTTvqOpvK3SQk4eM1L0J2YRa9da//a1SKD/6pYEHcLvXXi0297cTY7P?=
 =?us-ascii?Q?Om+8TYH7qYCqIwSCsHaWJCAbRQmmjdiC9oh8lrk+Feyypg5UB6So5NmD7mRn?=
 =?us-ascii?Q?B3jIzRFEcJQjb0dE/6rfH1l3kJGLS+t7nncEFVW4sc9mu2aZSbGuOOMGQZCy?=
 =?us-ascii?Q?LubBghKUAEj39VneV+2yviKyzxjrZo5aapgE3LfEbxfDSGaZaBjCeG7hhTwQ?=
 =?us-ascii?Q?FdD4CoIatdC098Xl1iSy3pinZ+hkjX5sGxVETAqneQ2uEuCAdWF2NClMUkUB?=
 =?us-ascii?Q?zdQmeKqw4u9fQ9hT8/TzMWzfzvZUMyYJLTBmvp2UuwZEyfrJhlAwR6KDo+d/?=
 =?us-ascii?Q?+v3nMr75bqImqO2PRabX1vo8Uz60k5Xkvc8r38LbWfonl2pesGx0CQ3jOgCP?=
 =?us-ascii?Q?U1RyjIackR3Uw/7TlGpCDEjjd8OCU5Wwith9UVxD/C666HXtw4jJdiBZAJsc?=
 =?us-ascii?Q?zsHi6qV0M2PyyFQcMZmySUVP2wVYWbz/opEjZISPmBrS3iK8n7qD+g8ubcov?=
 =?us-ascii?Q?4l+XL6GqA4yAiQgx+7GxubmvP6aU/yPdhwzt3Iv0lN+MH+bp1AiAJM+2OfYY?=
 =?us-ascii?Q?FR+t7S/DZuWOgfUNnnFhErTZ+a2WUkn2j0krBo3F/eAuTKUqbmpaBSb2+psf?=
 =?us-ascii?Q?mXGCaYMmqpXuzqLLGAZ9RN9VBhlTcpj7MWtWOGui7zIjfk9t7fmJ3SJq7AKQ?=
 =?us-ascii?Q?8vMWwx30ez2QnJoC441SpHN5M+iwZ7ZR2fVclmJ4OUlR+fZpQkOTw5DZEnON?=
 =?us-ascii?Q?dqhLDiEkDdXwdUhtepdwuNh5OwU2uaj1edM+Op3HAX6CMBRPLbkcAoqeHKPE?=
 =?us-ascii?Q?bojLUqonOPhfTtzWOthuy+3q/0X6Kg60ZB4DxONrPX8bIJBHgZXXqps8Mn1y?=
 =?us-ascii?Q?1FT+r741T3OZgqeuhhXtY96ssB0ZUeIxb+mBOp5Ob/QeRhvVwM9APzKEWTkj?=
 =?us-ascii?Q?Mwr6lvBx4e6Bg6MHuJM52p7RZ/ZsfkZyLir+0UTpZNxomUxjhwvxiogDUS/w?=
 =?us-ascii?Q?0lfHygIHDbJVPfHlmPzoc0UUSMUV0E4ZsToNqdRgY4KtCXaCaQ4pz9m2xT6q?=
 =?us-ascii?Q?8Ueui/C7k7fcjjx+vlDpcAbi0LAZ/+hpsdxd5CgyfSDjpwqni3tuooJCJ1kW?=
 =?us-ascii?Q?x9/4CT6Z5nw9edB+opN99FfF5ynTFkgKeEDzDhjaHf9jJLIe0b0DkqR/tV0D?=
 =?us-ascii?Q?znNeG2dID4NwuRpGRwauVtI/8cgUMl45RvnubC/tpb4J2IW6Kw6/0zClagh9?=
 =?us-ascii?Q?YMZDZ4O+u7FWzuHQgU5fFI0V2SByT1OxN0GPIpbLCRZTHeR+4OSwGzXP41kR?=
 =?us-ascii?Q?ySKPKOCuqCP0ktOPDnJoV6iHJB9BqJ6bV/y/yVPGnZnRyCVL7fXKtTYMsCkK?=
 =?us-ascii?Q?+k65WTvTrg/yANm8vdcg3Y56BgUZN+Br0lOJSTGm0Kv3P0Td0YAS79wR71/o?=
 =?us-ascii?Q?Y1T0XSRMMk8Eh/1ft2/UbVjLZDPPvNU8DAMU7M1Q4KGFBzj8TNPHPZZy22s8?=
 =?us-ascii?Q?4aE+zLB+rf3R4iYzjufnzhk3/czOwZb339lRVWG5pMbtXGMe0RYRp++yaMEy?=
 =?us-ascii?Q?5nNwbua80qgZQU2XqvVlzVTmY/4SIxQw943DRO/yXomDQo5R4bCx+S7+NIFv?=
 =?us-ascii?Q?PgcppgXauA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea944381-f9e7-4891-2d3c-08da01349cc5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6329.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 18:51:10.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syM71At/aqhjjeXb+xW2YG+ka6/M4VwwG74GDQroj9KAIgz22CSBCMBiTza26q1ridmDGvmPLSbkn8aLfw8WUkYc6q9jFOuFjf0wC4lFQ+oR7lDctho7sQg9EzhxQ+2w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6854
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms with large BERT table data can trigger soft lockup errors
while attempting to print the entire BERT table data to the console at
boot:

  watchdog: BUG: soft lockup - CPU#160 stuck for 23s! [swapper/0:1]

Observed on Ampere Altra systems with a single BERT record of ~250KB.

The original bert driver appears to have assumed relatively small table
data. Since it is impractical to reassemble large table data from
interwoven console messages, and the table data is available in

  /sys/firmware/acpi/tables/data/BERT

limit the size for tables printed to the console to 1024 (for no reason
other than it seemed like a good place to kick off the discussion, would
appreciate feedback from existing users in terms of what size would
maintain their current usage model).

Alternatively, we could make printing a CONFIG option, use the
bert_disable boot arg (or something similar), or use a debug log level.
However, all those solutions require extra steps or change the existing
behavior for small table data. Limiting the size preserves existing
behavior on existing platforms with small table data, and eliminates the
soft lockups for platforms with large table data, while still making it
available.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Doug Rady <dcrady@os.amperecomputing.com>
Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
---
 drivers/acpi/apei/bert.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index 19e50fcbf4d6..ad8ab3f12cf3 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -29,6 +29,7 @@
 
 #undef pr_fmt
 #define pr_fmt(fmt) "BERT: " fmt
+#define ACPI_BERT_PRINT_MAX_LEN 1024
 
 static int bert_disable;
 
@@ -58,8 +59,11 @@ static void __init bert_print_all(struct acpi_bert_region *region,
 		}
 
 		pr_info_once("Error records from previous boot:\n");
-
-		cper_estatus_print(KERN_INFO HW_ERR, estatus);
+		if (region_len < ACPI_BERT_PRINT_MAX_LEN)
+			cper_estatus_print(KERN_INFO HW_ERR, estatus);
+		else
+			pr_info_once("Max print length exceeded, table data is available at:\n"
+				     "/sys/firmware/acpi/tables/data/BERT");
 
 		/*
 		 * Because the boot error source is "one-time polled" type,
-- 
2.31.1

