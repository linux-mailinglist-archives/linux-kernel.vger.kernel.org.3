Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C894CCD61
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiCDFl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiCDFlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:41:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2091.outbound.protection.outlook.com [40.107.237.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58399151D32;
        Thu,  3 Mar 2022 21:40:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQv+wBRIC4tjcZABNUmDa9/Iz2LS/eEh0qnxGi+jSba1tSBJvcN6bS3tbChiVGSUDKspIV+rnoZHnVG+icYD/bCFv2SjdamfMzN0+R0722LQTakMz7V2pcwaftNYmianwgtdjqeq1/KsS5zFDe3zGYZrM2Y0zlCZhPaYHDw7SXIRcdN0en/9E0SB9R/1LdHwmR/Srkwi/3/uegN2XMp+Qqbg9MlPqzM/i9foJNCwGigm4192zwFftGl1BAXDvCnLYDsEYMjHVLK2MELGWb262dYiBR48hAbMfVM977i/oaNXTs1x2jULAfWdpV5YlI+tA2WmXxRwd2B5WOthQr9Zfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/pNR25m76J3ou5e/I866l8x3mpHuJyr6k15clz2jZE=;
 b=TRcG1a8LNkbBVzx5ghVExIk84D2nzWyVkxDYCiCEHdiSKFjPHMP54le9FbCJEAii5ONhwjGhUCkHCnj25RuOT2qqLwTTpPkTZrSMo1hZHUTpo6mdisTJwsXEv9Tw/vV155e1BesQ5VId1VHAHsM485/eD6sx4asoZTj3zSi3vA0QE1hBouHwmUiNNI48iaz8IrdU5+2K6aJ+tQi+5Uyy/Tyy5KIVyEBMxu6GvU5LhfoVTyxLJJ1Ts2MWeTVA9MwcdsAYBBhGted1AbFxEucRiOEG+EIMQUUrWzSxL6dTAfHiiUSaOe8amVhojkp7MAX2kowagRlMxk06NCrXbM+XTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/pNR25m76J3ou5e/I866l8x3mpHuJyr6k15clz2jZE=;
 b=p7noXgrfUN+/VsSbbsaaN4BGUrEey5Ut0v0LvAruMcDOCEfl87TwR7c+zLpJpjSXCQBO3tbutQhbFz2jHhmpdjfn87FQ4ClqNUZHxF3/8Zey1GHrA8r+EEDA6SQViArLUd5+EfN8ZPsfbnoVP5aqsLpx5F3sqkNSkbpE0LapubU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CY4PR0101MB3174.prod.exchangelabs.com (2603:10b6:910:41::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.13; Fri, 4 Mar 2022 05:40:33 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 05:40:32 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: [PATCH v5 RESEND 1/2] ACPI: tables: Add AGDI to the list of known table signatures
Date:   Thu,  3 Mar 2022 21:40:02 -0800
Message-Id: <20220304054003.152319-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220304054003.152319-1-ilkka@os.amperecomputing.com>
References: <20220304054003.152319-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95bd5b8f-ca42-458c-dac5-08d9fda17fc7
X-MS-TrafficTypeDiagnostic: CY4PR0101MB3174:EE_
X-Microsoft-Antispam-PRVS: <CY4PR0101MB3174D1297E52E0A8BD05E0889D059@CY4PR0101MB3174.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDvbFN07hq6+uR97XvuNpvJk4NPP4ZsBuqnEk+aI430MVNuXfl/fVAHOmg9QkDF6621TgV+IbSV7GtOLLcW5QsOJpXplOmniJljXhcrYGq+tiV/sxKA1uwyvMlx7nFMejNMKJ5nNXH6VG8Yf2RHxlU9VKZW2qalJkpasIOZYI5Iu2IAIht8lNLtp2nqi0AzD+4VIsoVOsgE9IIWj+RpWM9rgP/ILQsGnhKzzCgsRMHBd+ZQhbJRR44f1gXJG9nAN60WloBvyHAZyTxj3vcPNIds85vZ0rWNUNmRTwvOuEzzLYq30oBjm4Gj7SnEdjDLE2ZdoYTyXv/dPx+ekt7MbcfimA7hr3zlXP34Pj2cvc0eV3EO5rWPfla5R6jvkktZ6odObktxmmBk4/7foFndeTjxTQ0dKyfVutw6S3zuOkQrM7cknWS7HqNIHn1kGDZLN8K9Y3k4nkGMcTIWlHFx1K2fboiGK71nqU092w1hSLsQJ602MHoPCCQlkip0OrcXMTKtiS4kq60uixMnsOj6e1yhOMkxZp8d20PoosgQ0GMF9O6WvQV33Lh7wGZ73L2/sSa2q7c7TJ+8sxIwfTm2oF2MwlYpuWvMZeaOxsEoQTCn3ycbHA3yTbDa8GcmdW265Ne/gHDcV3F4xBV+f8Cblc3ag9E4UO32TgyZu7d0HCphG1tyKBzGSatxNP3OjquyEJyDhFgTIDqHlYccgY0zB3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(186003)(6512007)(508600001)(1076003)(83380400001)(6666004)(4744005)(4326008)(2906002)(8676002)(38350700002)(38100700002)(5660300002)(7416002)(6486002)(316002)(8936002)(52116002)(66946007)(66556008)(66476007)(2616005)(6506007)(86362001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6b58olf0/uFPfz4MdBrJiseU8fC9z4pcprDTmSZbzB/ECtcwtNNCT9j0Oo+6?=
 =?us-ascii?Q?b5uVWFTbBJPgFhDItNvPlAXqTmsutGSYpFbNRG1B7ijClcJVKEU0bFPXCLR6?=
 =?us-ascii?Q?Ir7yxldyhjCVC+8JERov4GjjpMj4o1iRAPuNSStkcd94CRNqCup2a1m6rGdA?=
 =?us-ascii?Q?jlG4eHEHcp0k6AjUV7SCBmURhfHul49kKuotayfRq03w8RbFJ1VGq3X6fTMb?=
 =?us-ascii?Q?qAx4vGHSxFh6ZgBJ8f0jzcFZ9t36tjvxBHiZsXszRtd6hNkFvHNupMgnw7HD?=
 =?us-ascii?Q?9dwmfCU11b8hF4uhBmIp2J/6sAuhdQcLhJz3WqNI0cnl9GzZ3LeFCHXmkZVl?=
 =?us-ascii?Q?rHFeq3+Wj8linJcVLuxlDX1dGaXGQQvPLTNve/u1NZ2iD2udpxUwTktdCnz8?=
 =?us-ascii?Q?1LdToQ0prS2u7k9jzF3LSzOPPqpkMWAafJZ7yaLYlAWxTA6qk0jTjWqkSLYd?=
 =?us-ascii?Q?YjULxR3EPwzpFXT2c2gp43DkijCOuUL7AO5MIOzHxgn6GEBCYhL0JrQEmh4k?=
 =?us-ascii?Q?WeLsWPRSnqmyJwDPliFFcFrEFvplNywy35SrHoEA3WIS8ODQLVG7/Ql8keZB?=
 =?us-ascii?Q?rtV0JDfoeI8LPuezc4WImnth1Py1a2UowS3nLdEQjzsWTMycovajaj+Xpauu?=
 =?us-ascii?Q?yAfw42uQ+TPs3DoZ4savakdIb6UFR8AtfOBki5GC+ANqSfIRuUpe5Be9qJe9?=
 =?us-ascii?Q?bm3GZt5LiP0XeNGD6ABZ20zBC1kmwV77/Mu7PJymCn7WCu1uirKCbFjIfDlM?=
 =?us-ascii?Q?1AHfHvSsndWmqGzrUdwwUPhsEpe4dQQruDBTjXPJ7jkPtNy/1Yz/dsg/hvLC?=
 =?us-ascii?Q?VSEzgh0KvoPC1U+OKElQnmBePMBhDZve0mNYINuvHtx2BLiMqA0NQzd+qIxH?=
 =?us-ascii?Q?YZk+2TMfTvGpoZTow/qZL60EEU18fQcdD0hV3DGpBI91xr7YtbXLCQgQN6ly?=
 =?us-ascii?Q?8BSJrjUCXMQG+z8eF5Fm1u7SoxdyiOsqPN8BM5VHPdBVejg9mkv9RmKhc+qg?=
 =?us-ascii?Q?rrzi6Y9uPIl2jU+JXjncyuKvNEuCrOVB97rEsnkNds5KnO4/tMjd8oHth6oj?=
 =?us-ascii?Q?vk2SmjzcBY3xx6ct7zlTaDngtQWyiBQQK0FHtRXwK2dOL664X8yuiACSiuke?=
 =?us-ascii?Q?xfav6MZN6/MRl8Sk0utB5LXwHpx1GstOWsmLt/bA+t6lF+ZMuTWcHo5rklsZ?=
 =?us-ascii?Q?wgXV6KH90fuBmkllEB6i/iuAYDJHfYzcl3UvM85zA2WHD7GifV1HS0r89Mg0?=
 =?us-ascii?Q?QK3LDdBCs/P0vajrjw50Fibn+hVQ3rYES4OPG84DkJz8nsqO4aK8HQur2ni3?=
 =?us-ascii?Q?rprAE2mXRs0icqAgZxeWb78o/H+1Su6OkpjxGd/ABhaENwzcbu30MRqJeZEY?=
 =?us-ascii?Q?+Xy6nyGS/exXxYa4kml9VHe/7j0Iy5RMjuSVt7oh85vqwhgGhPe0moTCTfrK?=
 =?us-ascii?Q?woB4w0lXa3UYRZX030hoxUuVI/Z3aFTBu2LwiW4gzrqrXJBCC68vTp+3tPDw?=
 =?us-ascii?Q?DP1cGjjZ3xj3ZCc2ILB99F/1IeDVSaOaPSB5TTxOAKNbshuJQTiDU58OFdHt?=
 =?us-ascii?Q?1TYE/Piv7CSZ6dIK8ms3txdfl5bgyr99d5qFqouJUSuka+KFtwatya4MolTI?=
 =?us-ascii?Q?SmacrnScx/3Rp+qg0zswn6f/V2ckePXYyLXJblxTbYDXlEcIQb3ZJWfmwRJw?=
 =?us-ascii?Q?wUBq/+sYW/pJK/DlChl0YMx8E0VB7Cf8OYxCbCM3MFiZcCxi+WnyiE4cFeAn?=
 =?us-ascii?Q?7lOupMfQSQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bd5b8f-ca42-458c-dac5-08d9fda17fc7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 05:40:32.7814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejBtP4Aagul5LvZBXFFDEE3lddvEHX5XN2RxXBlGSB475TrhKq8uZKdjphKvS0dhfId8bycN0QGClfETqfMBCZLwjUHYQAl0PB6mdp/NYcdx7y4ndKMd1Yqr31goRJP5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0101MB3174
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
index 369eb998c3d1..ceee808f7f2a 100644
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

