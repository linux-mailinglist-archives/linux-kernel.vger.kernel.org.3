Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875374B61E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiBOD4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:56:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiBOD4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:56:41 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2126.outbound.protection.outlook.com [40.107.93.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E946D4C8;
        Mon, 14 Feb 2022 19:56:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmEPe4e/AqQV3apwhziL37eZ0Ume0P4as3F1leem/T7gBbIiFLVn2fn3Qavrlga/90y854r9b47hOxVJ1+HyxbsxXctaggXVVd6rYow9A0gK36I23dy2aBLwAkrF9NBHCVp3ykHvZCejG/zGyvp3dbTWgYt+9/edR5udMLLHXSjdv0SF3lOn8PiYp7UEX+M3m+hlPS24DK1OkQknHlv2Vod16j/AIaewzAKSQIoMHR4R5x7wjtIckNfyCPNLVWShejvI1pIpNB7XgY2oZLjZkfvkErktmule2cynft6a+FkBHcC8pAXlhsBqkkm8qaKUCRBNTZbhFYCT2VWFAg99JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNohOuriLTgmuKLvWTouis7EUyrZTYwXlXn9IP6Zjww=;
 b=WPz98GbbryPeuhmHtSi8N9FihFulOj9Ed4Rav0a69EqXNGAJ9ubn/ewfgokPsKSzTjB7ObTeG/ZIRuSddGnDnc/VQFawuVoHdSoVzvXjg4CtX6SZdG0zXUm8kAktBnHK7uxqNqOQz0iLozjF21uCRYxPAkKG69HiPOUwo92F2DrGPWBBbmROzjCvxlxfy1ySukA8aRcf9Cu9wvXM1TPoXDP/mcSm/ieLk+dIRIVDPIlNKafBkFISlzb6HNb+i/FPmT19icCwSfw1Py3H9rQmTF85bgIBkkXAsTQuAnXo2JVheZ5oN0KR1Si+/xlFiDtv6u+JKY/fgVNwHpFZ3OD4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNohOuriLTgmuKLvWTouis7EUyrZTYwXlXn9IP6Zjww=;
 b=dgZiWTCubHrwyfxnev9rlLdiJAxr3ZQ77NeLmW46r4eMkAmzW2dUnt/yHJORmBo4Icm6dmNndiw4cs1QoeOr2pfbysRVLReezbf6lbtZ+UyPAVgwxRAf0c5S8VZ6gw1GbWb6Xw/1UDrqxnKCG6M3wroytfRZqdBcFrMf7R/lVEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO6PR01MB7500.prod.exchangelabs.com (2603:10b6:303:147::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Tue, 15 Feb 2022 03:56:27 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::e085:6acb:773c:c3e7]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::e085:6acb:773c:c3e7%3]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 03:56:27 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com,
        james.morse@arm.com
Subject: [PATCH v5 1/2] ACPI: tables: Add AGDI to the list of known table signatures
Date:   Mon, 14 Feb 2022 19:55:52 -0800
Message-Id: <20220215035553.102315-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215035553.102315-1-ilkka@os.amperecomputing.com>
References: <20220215035553.102315-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:610:38::38) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b6560c8-99c0-47e5-5719-08d9f0372435
X-MS-TrafficTypeDiagnostic: CO6PR01MB7500:EE_
X-Microsoft-Antispam-PRVS: <CO6PR01MB7500A276F7DF9C47967DBC7B9D349@CO6PR01MB7500.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tJ1dxICH7tNE38ZbxLhAVbD8HorYqyaybpl/E3hyisAz8m8DcywlhQev22PBfbuvv/0XjiBPwP74cpSrVeTruKDsco3D1mVgId6XCxqFp6PwI33FvnXxBQOROwQROxUGpsA4ieBrR+sJ5ACA3iXc59b10gKlAeRJC+0zUUQrQyFfRhD9wUdUxnri1e3Ub0WZ6pStHqtB4tRTjFfF96K0uyHkUbnw5w7tRjL0BztiDqKIIM/AO9064pwL2RkAKQzq6wGjF3yXWzFFI5LEfnvVTxiFeBj/WypXTeodK2TEndN5IbfaC1k/+HjLxJ2APwYTtWyHpPLZlXWBUITgQ/eExfJ991F7WKKgrvyOWP3jrWYlixOWnfhLJxSKzyBYCeEw66VGGpreRRWuuMbh0DnZ1nMen+39qiWQo6BeViVDnZgeAVjp43H7kJNqntt+0Q3R/uo8gNnBocPGJfG64ekYpyKmagjYmY+e6q+wX67xCTo9ilVJ7TeAbrBkwamwBcAXFfBETc/y0Ami9JWH850tC033ZIgoTGVT5OvcxvXHzUHKa8FBYTFQPBzP1y2ZUP6k4a7VLadBXe5FPgIJ6gSFRKOM0KlL1UWKhEe3KuQ5W+3QBI0mG6jpY2Jcg6yjKbAyycPpyIRJvRXJ6vCN2hKg8DklJcealXe30r+NkOTyDCV7xhM381c9Q9QbF3rsFv1NmN9fgPc2Tfb4e41m1U5+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(8676002)(66946007)(4326008)(66556008)(66476007)(2616005)(316002)(1076003)(2906002)(38350700002)(38100700002)(86362001)(6512007)(5660300002)(7416002)(83380400001)(4744005)(8936002)(6666004)(6486002)(508600001)(6506007)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KEIsJDyWQ5A6CUaMW/ZeKrcsOB9obF1mrHej8MYsA3O6gaA3wdaWzanynKVz?=
 =?us-ascii?Q?7lbB9pN1eNzG+8GI8Behym4N8HmXI07ndGLCfHinGtEQTGkLdo/tZ55fz3lC?=
 =?us-ascii?Q?XMP6AggFVZsvGTQv51ra2UihnajVqTGbYa9TdaktmB1d8+idZMeNREW4HcxI?=
 =?us-ascii?Q?vKPlTbIAqWkGpCsXFaWoQFjyDTP46qE+Vpg6mAEumHAMvRlb8NstLXjr32Kg?=
 =?us-ascii?Q?JQF8X4Z/lq9yrblZGlksAyLJQW2pEEmnT/esRy2n13fMOwi3qCrr+J6kFzl0?=
 =?us-ascii?Q?TW9xeglMGHq2nF5xdXy4TaPY/6dflLAKseYFrz16LLbB6VlTZjKkp3MTXobW?=
 =?us-ascii?Q?1JA2wxFaVaF7j7oMzChunJiP2f7S9f5aB1keMjCLQx2MIKJMFI43soTceLOE?=
 =?us-ascii?Q?RO/KkZz5F0rqwfChYy2R1zGcASTcEMVY1DnpNF534VfE3POHURg/soJaFP/7?=
 =?us-ascii?Q?z8k2Lx93CI+nrKI+MDUV9Ofv38GTQD3lhh2iDC0B3EW4Vog6Opk4AxHv+rnd?=
 =?us-ascii?Q?D8fT7HU+0LLzlBWGcfeM+TvBEH8KwlvB8Gc1trAKwgbud0ulKfbRTKG0XyrY?=
 =?us-ascii?Q?+xucUg7aquXFeUn37ZFBfV/YqJVVP8BMVASDNmREhLYrRFjYq1A2lfV02kji?=
 =?us-ascii?Q?Fh3EY1a11DggaAQgz74dtqdVGi+P97JiFcEHLc0CROYxq2MJKNtJbs6UZOJu?=
 =?us-ascii?Q?G9d8ghdFCnUaiFtj/p53+J6538jeT8YHC/h92TR+cZw5QdHJ61Ykq0a1/m1a?=
 =?us-ascii?Q?jbHTMpaw/D7tU+fTyzibqNSi5ohoH/IdWUwvhBsF9u4kZnxLj1ZyOLTQTXQ1?=
 =?us-ascii?Q?0pg/J7Ys63igg39EHq9bjahlb+TjgATDpwghowloUmqb254kQhf5qrVRcv4b?=
 =?us-ascii?Q?aY4GEACVqXWdm549AwxGXHIabO5FJQ6o+yR9AjTHJV+7DJ/ejw/XrzS/KmCH?=
 =?us-ascii?Q?3w8dRH5vJdPgLb62XpGPnoz79BZXwZt+j/rPP/lf8kKKErWk476u1UtfzIB7?=
 =?us-ascii?Q?rkRFZ7xPTsnPyOsG7nqXLL1kJ4xztSGyz7iGY8ngAMd3WXghbqmXST3yT3Ro?=
 =?us-ascii?Q?D8tegXLAiR6+tT7/GQNxcYZuqIqe1LvWk/Qfq1awmSklPos1i1Y5iRqPEg1o?=
 =?us-ascii?Q?XxHnTbVV2BhFueYgMiIqh3QtgZ2bGh3Gz4lgKMDLICfLTtcArGJPu1ZG13VU?=
 =?us-ascii?Q?hiiZhBrL2kSwxj7FoA+COdt1cl5hoUB5YYNudMPJibHDPO6rShyn/FrgIwX9?=
 =?us-ascii?Q?6dyEWPyJwn+50HzB+xPpzeXG/uYfrze2u4JaRhe6U1djkofnXfiKS+8JWrkI?=
 =?us-ascii?Q?GDINUCm8bpDBGzaLu8Ahjv/oc6GpP1KrktFKnBtPPiu5VdHw9JcwGYCI8/Wp?=
 =?us-ascii?Q?ZIMdtSnGbiePG7lO+Q63KOhaMDV+WiUCHGNWL36r+Nej0ceKYiwi2rz5hmBJ?=
 =?us-ascii?Q?mvIDpLzC9zYwWp9AEfCvgi4Htwsp5TkVneSD3aEbQSBMfAR7ejPeZr/qm6P/?=
 =?us-ascii?Q?p5+WRVsCoxbJfgc1XgJ8ILarIeRsLX7UXZLY861Hc0RUtc2MaH6U6pOR6kV1?=
 =?us-ascii?Q?xyjJD9yS6YqeoTsPm/9kJSo6gRoC5GReixUqqsCeOuewp04Lel/zQRlNbKek?=
 =?us-ascii?Q?Sy2mFSzguvCfkymTxTv9p4HMtlZww64Wmdqv28vK9KBx10hk76rir6K6kesN?=
 =?us-ascii?Q?5A2Zco4xLQR7ydZttVKukSI+av/nIzA3Sg9/g27volZEHOXLrFRpGbT8BmU/?=
 =?us-ascii?Q?RqfMLvEdzQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6560c8-99c0-47e5-5719-08d9f0372435
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 03:56:27.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fnh6yFNrdlSXvydd/dCxmqdrccN6ltfFN2g9DKZULSsT2oRnLiFLmNZ2c+5Srqjd4Hrd61Ff9Nz9iXRnM80aBq8zZhpGyDa/WBxKrcQPKyWD4UImFZClWJueXCDHQTJo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7500
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 2d7ed7126faa..ae29b13b8774 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -545,7 +545,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT };
+	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
2.17.1

