Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0F94F776D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbiDGH1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241746AbiDGH1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:27:18 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A639213E05;
        Thu,  7 Apr 2022 00:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEoR+XfoI6VXW3JCEwMGfc0bGTNw9MTp9wAHAcguocdCurabZsxtgICQ9MQw2ywK3rtrzQmUewdyArMiD3AX5uSxAt9Pg472Sx4R+tr2rvccChi/jjJB1zKPxk7B+o6999MkoaoNuiAPXum8w/bPm8UVEXgUMK774U5ZlZuHTKCsum5B2OQLcgNUJjeX9tWoGpy4J0BdXMYubyS2oo7HjfwNfe+4YqiNQE2+htBSjQSL3nGV4EwuGr0NxQBIlwRTffecHayT0OVe2Z+Sr31ikgBiK+3FaUTDBaViSS+dFRHkutSL6J0yQdvra8wrWYHUOH7BxAtr2xvZlkEFI6Eo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm6d/bLdOCb2G02Y7OkiHxCnhz/8Cx/00OxVVCzddNE=;
 b=au5/AlIiBz/jfwu1OlPoahnT1yVpAcp6LDYyz2vLYLubMdcchV11ZoRbccVeRCDNJSS//atg93mtEcMyl9tIncpaBuxB71kUxq6W6hVIx3wonKeMOzVRatU1bC10WN1AP1H0ZBn9FeOBrgrrUchDk1aYy7b6CZKJ+geCCJhMr4fNih+XdUl/YsJfOwBCY/f+CvkJ5uIVJ5bbnZ/BvfYFuL92lwNcQYJQlskJyNVHrDZDGeaX01TkXjksz0YyDLWWAYYtOmdKVmoAhaWOSr6TGcxytJPiWwoBeOgv9Fgr7X8gazyOTfh0AilPNOiJF/vEU5yQnK0TzAyDb8+kl/4NGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm6d/bLdOCb2G02Y7OkiHxCnhz/8Cx/00OxVVCzddNE=;
 b=VU5ntJzIaSeEhRYFXqRKP/wxkHadlHGj7vzmtt04j8Qg28K1B5JeAzJDJFWL+F/hxDr4G2ikBdiWYWsRC+qBG9ChEMKNL2b24YfENavUf1kqMf31r7e9+SwY05hCQ97PsCKiIHQoR/pLahq4+AxxJ6GCAO4gVKDXMuqQfNs8sAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYZPR06MB5001.apcprd06.prod.outlook.com (2603:1096:400:1ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Thu, 7 Apr 2022 07:25:15 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::74ea:8357:f542:4881]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::74ea:8357:f542:4881%4]) with mapi id 15.20.5123.029; Thu, 7 Apr 2022
 07:25:14 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] scsi: megaraid_sas: remove unnecessary memset
Date:   Thu,  7 Apr 2022 15:24:42 +0800
Message-Id: <20220407072442.4137977-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac806c6-c578-4dc4-a44f-08da1867c1d7
X-MS-TrafficTypeDiagnostic: TYZPR06MB5001:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB5001A070287EAE8B16DBD32FABE69@TYZPR06MB5001.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTo9EoOJ6s5auskDQnxhfiCZ9wle2UxSlVcIADljEYXslTZhfpvetNTuxckgda2ZZw5ZVzQn+k3+8UYG+st5nD/CcW+lBRjt2PY568sEbTzn2vWnq/ck46Z/z+y5thr2YY9iIWDjIU0R3kmtmL8BCO/HCmObtJGqxQzX5tTxrVBGnTEPuoaiyOnNkzWM5uhQ9SBMSJ7OE9kBXnToQ7YGeXDilPIbnGcZ+i6J8wYlnSOJ4t/X25IbBvp0zRcWD9yBRYT/pHHuumPovQZt39nWldqsSeYsTnt+ntDHVSt4Mq/3wrTUdML7gPlyBT+r6E1gSH5SCo5VtkPKyTfWpJtgvmx+oF7WHul7lfb+nF9D0PPrHMaMVtOLm5qq4/tWyHEqIr9CAcocQahuXjPACuhpe5X7CenzPev26iyhiF6iGdKm1x8IlVTQ6YUNV+v0OrRbBAh68x+71dGNNgpXiJAm3YSvMkvNRX70gGU7LUo2CzrsmN1K4k0UVsDANQnLU9x55ufgmsr5Mhb3K0lTNs/6YKCK0ozrIwwCkbI5ooKw8slCxJjcn5Wt5d6hWL9d6tdKiGoQglJzPtGD2TxuBkHnQJYC8asur9t/OvqX6Q9Vb72yuGAas/PBESs+qbsTgi/hGcF3S5Odp3Ap22L0cp+EqW/4soHJ5qmndy4hs9yahwEIkWwT54WcTZsgWsIJOAc4UyIzGIiRllUmBO5nuWaZgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(110136005)(316002)(38100700002)(36756003)(66476007)(66946007)(66556008)(6506007)(6486002)(83380400001)(508600001)(2906002)(8936002)(6666004)(4744005)(26005)(186003)(52116002)(86362001)(1076003)(6512007)(8676002)(4326008)(2616005)(107886003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MwiFl4bNQ4DfTeXzkXJT5r89BsUB0sqX3MiBNt3IMe8tzjyEF5I5/N5F18m+?=
 =?us-ascii?Q?4+jZkLO3BAbjco4pXqyg9Jb2KktXIRtPUtUwoIfK6GtW9TMyKsTQ617skEpH?=
 =?us-ascii?Q?rYVcYGAGvtcwdT1T4vNIcl7TxIsEjiy9XQJOiazZWfNQrPsuudIqd3mp2AzH?=
 =?us-ascii?Q?UptXxasNr8mc/iVxbRBFaDj9tGLqsjpJMPKua/4qUCFXDcH4/XUdQA9LeB3N?=
 =?us-ascii?Q?vptbmd7ogyiFDZp11ZHRv2TQLWSV/GY9DwoaHN8mVgA1QHIoM9DFwfgmBroz?=
 =?us-ascii?Q?VOjrRgfFsg/r6K5PoND6yQlc86VABmzz+gyRkXaYAowval9e/igCPO55vlLf?=
 =?us-ascii?Q?DxDgIOptWxxmHp2A5AzAk6TRIkr6/jDo7JvrXZfavr1LmGZTPIUOvsSdu3wt?=
 =?us-ascii?Q?XVnqZfrrr4pTmZUP3c0wIVx5x0L7wTBRJfCBlve9RT3t1K61zOQxuD2/Tsap?=
 =?us-ascii?Q?elfLw7dhD9v1WxCYDEhozp5aDZXxqFCCZk9KrgYHYkrXa8eE77hAjEKFcNNO?=
 =?us-ascii?Q?w1v6obr1xw99uv75AvtSjMND/LFnhU/8E+yDi5sufiGJw9IjBNx9e6XR9EKK?=
 =?us-ascii?Q?StQLWQxLuJtSiJzO1iyG6MQRv2zK2fbGkesM9J4sJqiCQe3MGyc3S2OrzmpO?=
 =?us-ascii?Q?jyZnUhHp84Zck3xTETgNCPWd2OE0foSispWAvGsV0J+Osa9vpHZJM3FZA4ps?=
 =?us-ascii?Q?JNxhXBok6FfHDp0cgrKntO0CfHsWkyjRDN6fl2uOhBvXAR6DavTHPaVxCOK8?=
 =?us-ascii?Q?0nG0ctze/XI8H3NV2syq33kQMenUTq8tDbLFRv5/k0Xi6OpDitWNmI0n9icT?=
 =?us-ascii?Q?jP8MF8cab1ebxDiaV/NNPuGFFNuGGuyaNjNCgJsma7GpUwPm+bh4Y8mLkXTv?=
 =?us-ascii?Q?ty9T9MNlusKavEgV9nr5Y0lypcO2DOK7ks+sbpih8fb2/J/9+YOunsEMlK3p?=
 =?us-ascii?Q?tUGl/xDLy0mFJu5BuuolbgCcFL3qyQYm1FEUE3/fDfz/s+QLp5AZOPAgJDKB?=
 =?us-ascii?Q?hvWelvRnkPxHxoH5wjQvHIjv846AtanULLxtus7FsaDWR3dtLHbr4Q7I1CBT?=
 =?us-ascii?Q?TVc2mS9NrM2R5s3UPo2rKr4i/Tc0Obrv0Pi1TvlceBzgFdGAzEt26WIOKE+g?=
 =?us-ascii?Q?hPA5TvI4pib+AAaYr6B0QCiC7iDnbNJq842gfbMbo1fpSHhlxJT9H2KgTdb5?=
 =?us-ascii?Q?dVjrBzijdHtRdnda6w+ayuI+G5vK5NZtOZi1Jw8lWrLVzmmYE7aJRtEjnl8y?=
 =?us-ascii?Q?azCYHk36zRR6/eTOIP2x6G8sT4pVBJkLqiQ5j41Asifg++PnOtFkTLrupJMs?=
 =?us-ascii?Q?cSmKLDBRgbp8+haUVfFp4MtVEqqadvgdD0NEuZ7gv2OnXqP8yZcf8dEszgAM?=
 =?us-ascii?Q?/STQ9WMDfLurTPmkaMcw3uLc5XGkixQR94DHRRrcr0aWD8TpvxKUnv8V+Vfi?=
 =?us-ascii?Q?eDpjPEmegvKMQIHktDTEbPFi0eJ4iXujjGNjhDmptm1+tPBvcsnYm/XZIvtM?=
 =?us-ascii?Q?Eejb8EgdXoDg2petxTEe/hUT0NK1fafkgzx7ZP0MrNXU9ynC0uTWEx8HONZw?=
 =?us-ascii?Q?cet0hd0StGotNx38jIpScSNzlnIQomtln6+omdvTugvHZL/Gh6o9TI9ExO5M?=
 =?us-ascii?Q?SM87sRl8X+JmV0dpXPB8gvdfq+iPGM4M+GISq7V3xOJONtDO8+JxOPj5L1++?=
 =?us-ascii?Q?smpsAssvJzgZ8NXQu1allUub3uITNQGrbKzFM+pwtn7haII0CUU6WcOJAewi?=
 =?us-ascii?Q?AhIM8dtasA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac806c6-c578-4dc4-a44f-08da1867c1d7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 07:25:14.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DRFB3uZCQXsyAcZ1CyLKmkYQFGqpWHKn58jBZN+NBvjUP+oh+vzujkafYZwrCrHJe9Bj84sbn9xiHX3K39ZHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5001
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

instance->cmd_list is allocated by kcalloc(). The memory is set to zero.
It is unnecessary to call memset again.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 8bf72dbc33b7..33f3226023f3 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4466,8 +4466,6 @@ int megasas_alloc_cmds(struct megasas_instance *instance)
 		return -ENOMEM;
 	}
 
-	memset(instance->cmd_list, 0, sizeof(struct megasas_cmd *) *max_cmd);
-
 	for (i = 0; i < max_cmd; i++) {
 		instance->cmd_list[i] = kmalloc(sizeof(struct megasas_cmd),
 						GFP_KERNEL);
-- 
2.35.1

