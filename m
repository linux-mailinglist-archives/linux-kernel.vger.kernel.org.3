Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C7347266C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhLMJvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:51:51 -0500
Received: from mail-eopbgr1300138.outbound.protection.outlook.com ([40.107.130.138]:17849
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236535AbhLMJrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:47:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg84YNPVsz0sYmXdfiaoldejL66OnG9+M/ejk5OqAS9B4/qyEpDWnKJpzkVabq76QPIh/Oz528TnN9tpgkiCj+drTOPzzX60mp9YPB5ATQjYaVjB7WXdbrJHSipo5JhhpN4A4KFkD56UQW7D2V9CwYdGcW2l8H3SLxL8mmrWYYVyp33F8bAgVUAjzG5Tv3qEcLlNKw2+7f9aWVmAauI+13+iNJ5LxAxAK6uEkHZODR7qbHK+/qsayq8PUzT3rjgGNXr7sZYGNpZFZAEN6V3aZoILapvFG5AOjIBLeIi5k3u6nhPeiN6kAKGn9afi14JXxycDviYm4Sw+rRl9v4vqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opzZfs7Z25iKbYC/gd4oTCNvS4UMfvK+rf/YZ+85rbM=;
 b=POzMhg1xdPkg7VclMIU4khBndOrsyE89xUU/A0qbkKOsMy+80hiCIKs1dh+J3QgBxUrZ9MybeFlxA65z2LSPht7Fv6bQKCpBebVJedDFyj2kpPn7eIk1l2rpxXb1CJegLyusGhQ/lUGabghEBJtqUzRvzaaRfD1EdyU+425ZL7huXQ4tp0WH0WlEtiIEJL3+/D26tdxIxfsJqg9PEPY3OgdtQsG6ZdyTB/VyOUxfgBU1iq4hCHLPzamsnsZrcpPML1BkWDuCr27rytD5z8pzajQujb6HSpBLnoBQIbI17NCt7tWrgPIFeUqtVMwUv7tvAax8qklMCQMfVUvy9BR4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opzZfs7Z25iKbYC/gd4oTCNvS4UMfvK+rf/YZ+85rbM=;
 b=qA/eaUBp4Nd79NDRV8tQTATd1Y8yxCK1/S6I5fD3DwVOkCabIy1TzVRfYALGi7kLa2+995y+fU3XX0lXD5C5yOYsBeW09t4qZvWrbGyQwOsjTsJfd08WWl9AIVZ73Zg52bm0ah4wC2BrhFyMfS9A7UnTJYOWRKsLnNRuHQYvWvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3050.apcprd06.prod.outlook.com (2603:1096:100:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 09:46:03 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:46:03 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] bcm: pm-mips: add missing of_node_put
Date:   Mon, 13 Dec 2021 01:45:51 -0800
Message-Id: <1639388752-64191-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::31) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50ede942-7089-4f88-22ad-08d9be1d604d
X-MS-TrafficTypeDiagnostic: SL2PR06MB3050:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3050A131CCB9D0B8BAA0F37CBD749@SL2PR06MB3050.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psxjtomRbxq4G4PpUH3dijSCdYVbBeYojIBcEHTDHV8ntNaNiufqfeetgUSKpDvVT3qkZjp0J3wAlPOglSVGdwUOohc9mr+MuKynJsOeRN0m+8yflgEMJyhjCiPrnOqIFQ8gg682zZJSX9TO/tO0RvbO4p7xhuEn57BQdcxYPztbDZ05bwFXb2F397l/E38vWVQ9K6SBFick4RIwyq0nto8SVvv3oYwvmtGTIg7bq4tUHrvaH1ifNwhkTX/HYrIooCMlO8z4W9/xuYfdYfgfZgA+A2jqXukHwFAamFqy58MNOui7L//ST4Ha4/CjMWf2dgVABnkrhXkM9icaFHpoJHZXnTHN3PxhszbIpLEs8T0kgyU3OwuHgouR0myhB/bvM6KE3S+WEIVGq9ToDLNh7XjGlG3jrlyOWMxbQMZvQ7pu4O/iHaSE1H4EHOa5FRngn1E18GRWDnB5++OPp5aw7XTQ4GSshpF42gaM5eegYXIZY+CMlxHYDuRT/aKLsfXbbkG/0euJt1KehRDN7jMHoOOLb5PnNueBzrNTU/uB4yTOFOiJx8E9qDmKGxKtm38QKkuehBpcAAll3QCvsOThkM0z+grqYw7EaLkrbLxV1W38s+jkAc7DLtlakXD6hpl7YWigTthHaMp3+sHIaQ2+pFKKIAVNrJH+RE5Kd7DjJF9gmpUb4Jr/aJcDfV920+x0g7X7ScPxW2yWBCd8r5LvAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(52116002)(6506007)(2906002)(316002)(508600001)(26005)(186003)(66946007)(36756003)(107886003)(66476007)(2616005)(66556008)(8936002)(6512007)(8676002)(4326008)(5660300002)(6486002)(38100700002)(4744005)(38350700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r1Eh7jxXqzT9sC4LkwJkKUncMbxnR3wSsUOuyn/L9m9OphtT8zRIZfzfY7PC?=
 =?us-ascii?Q?XUv2H5hwLknMZ/8D6n3b01pgIRUcZUbj/IJ5GnOyz5vPSbhHVmF7nTm8jJ0F?=
 =?us-ascii?Q?A1YvKS8ghzVzuVk+7+12wTgxDQZ+Qy3E9jcerhU5qZYUb2D17AX2IaZ9igKs?=
 =?us-ascii?Q?uH3zlVCmZkPtvY2nO+aFzBvwhfmZUpAOYsnjeJwuikUlkNbwKpAjxumJCj6s?=
 =?us-ascii?Q?s1eARrHgImT/Qi+Gg4+jLD+3HcAYOcqF6sOj7tvBI9D1XFL5326HKhEsT7Re?=
 =?us-ascii?Q?4XHlVw7IZZdQUoKyrO9zj9vJiRruTjgEGbWyHS8oeb1NU1oXp/LC/EOlQJd6?=
 =?us-ascii?Q?/+QWDpl9O8ORUZNz167vIBIQwyMjBj1h3f03ATfKKshrJF+bpRVAGtLncLFg?=
 =?us-ascii?Q?YK9xufbamxVAaX34BrFjvR5wErJL2H67NMiTNCQyP+TTnZrw8bG55GQYSLd8?=
 =?us-ascii?Q?oQFAJh0na9eyxvjSTjizQyJi3X7ArFV4hvDiWg5t+Fh1q69kiIn1ndbvtp1A?=
 =?us-ascii?Q?QXsd7i/5MfXUx8n4eUgsXbCJ/b7nNgmKMoPIyN1skDSPo/OZfX/UiWTJHVwM?=
 =?us-ascii?Q?wPjySrPbL3/2hCUAHdlcxUgvPbw9qIj35nmndBQ3Dnh3K3OXZFoqgoxvo8Mt?=
 =?us-ascii?Q?aY8GRv1FHZ4IneTBv9E8N+gqivX6SoxOiHwQTcdLiPjco36k5gJqkxvPFIb5?=
 =?us-ascii?Q?bugZu+ymN+WwoWSSTpFXyJzi+kXkWkH64FxNUa/g3FMxH4N2d4hDMs9lO+Tj?=
 =?us-ascii?Q?usJOOswCulsjraMQva80kDwa3CfXrtg03z+OvufaDKBYJMipTjiixsIBD8vh?=
 =?us-ascii?Q?3pP9vv7qLl2dyL0sNTvDezzF9WTcfZG6ypgNJMtmIuXSoBA29oNQjDHXVQzX?=
 =?us-ascii?Q?TvRDklYeU9vIOCalY0vVBeqUrjP6V6G5gnMIkc2VNbP/HWgMScVW1R1XPb/J?=
 =?us-ascii?Q?ZC/p4GjJA1e9g2yJOtz0emd6UKCEMINWMLWfF6pHrIjD7U1KRcG8KCIVlecQ?=
 =?us-ascii?Q?+OXXtFeBD2eWoA4bSuvho9vqoaHziMyjhPQgKKo5sNqwazEEJnKB6VUCawi1?=
 =?us-ascii?Q?qL8zZcOGhf0O7yO/McAySvULVGUzIMVL0FKfEV3+03XtWXHMTI4yTu+QGlWb?=
 =?us-ascii?Q?EgiS6VEqseRhxudhsDHrahEkckTotUNBx2dJ9jTy4Yr72fkjv3JaSID5lxWM?=
 =?us-ascii?Q?7PXySK8B+gjpVSCQbyyV+rZbnQxKfazZXCI2fZjcu/5f1I1LcEut8rRTkaja?=
 =?us-ascii?Q?sQj+rS0WLzLiB0EDx1C2+pzMTrgu7dE6Ht7DtVzWgcpyu0vFVnJmbmpRsSci?=
 =?us-ascii?Q?9v4GtU9mgZhu2HqlVSdU8ZqdE6ddYIP+w3S04I0RbGRSUspY4Uh+SULH55gi?=
 =?us-ascii?Q?wk1KRqh5medNHunofDyv9nHLhAWFO0PyNs7uOd4p1PbufA6RT9qeDxRcb/H7?=
 =?us-ascii?Q?LP+MNCPQTyxMCTO1nMGLweR7aAwMrpnzGZnR2Z0lKTFvlAc7i66xApZtKeG2?=
 =?us-ascii?Q?UpQPGduqHdLUzCOb1Y2tuInOO0Wwqlga/t4Mng8nMSaUAswMq+uZEaLMKWXJ?=
 =?us-ascii?Q?lWtjqS9ipS+rF18A4SAEJzIIcUgYVVrQ7q0T8a5Hjg8ZYP/qNHv/VYE+ric5?=
 =?us-ascii?Q?f7idn0R3I4k92EMudP8yjY8=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ede942-7089-4f88-22ad-08d9be1d604d
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 09:46:03.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvamNYFeFtdWXuofGgavEix/oXBP77D0Q+6v8sCR+JvWOqTWJkAXq4foT8k5+He97YnuFHCymPjkv+j580wTPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Fix following coccicheck warning:
WARNING: Function "for_each_matching_node" 
should have of_node_put() before return.

Early exits from for_each_matching_node should decrement the
node reference counter.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/soc/bcm/brcmstb/pm/pm-mips.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-mips.c b/drivers/soc/bcm/brcmstb/pm/pm-mips.c
index cdc3e38..2336e38
--- a/drivers/soc/bcm/brcmstb/pm/pm-mips.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-mips.c
@@ -404,12 +404,15 @@ static int brcmstb_pm_init(void)
 	for_each_matching_node(dn, ddr_phy_dt_ids) {
 		i = ctrl.num_memc;
 		if (i >= MAX_NUM_MEMC) {
+			of_node_put(dn);
 			pr_warn("Too many MEMCs (max %d)\n", MAX_NUM_MEMC);
 			break;
 		}
 		base = brcmstb_ioremap_node(dn, 0);
-		if (IS_ERR(base))
+		if (IS_ERR(base)) {
+			of_node_put(dn);
 			goto ddr_err;
+		}
 
 		ctrl.memcs[i].ddr_phy_base = base;
 		ctrl.num_memc++;
-- 
2.7.4

